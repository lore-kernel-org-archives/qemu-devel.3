Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F747C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIa-00015P-Tt; Fri, 07 Mar 2025 10:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIX-00013d-IR
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:37 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIV-0008NW-Ts
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso1482412f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360054; x=1741964854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x+SEHRFMekz29GykQ7PlMCgQXWgPZliX2QLCYy6OiT4=;
 b=PqXxMGsyVqaq9wguEpH72uGBSZ5n9tp6V1OnOVx343/tx1XB9jVKnnwd4QSaLddZTS
 G9FW938t/cA/v00B/kQiYXsWoIOM6l+6zPi8Rcn6qSt4pF+MoMTl5s6+gWLykOhp6elT
 UhckSor2uzIdikD+A2Goj+GiG27D0JSf8OkJ0YQbTLjgQIZY7CSzWf9+TgjEif9CAjOV
 qGzgG/wv0gNnL0pJUOFz3lPKbp/hzPJBdtSDE+qpevdz4ZkKaPA3nzviB75e8o9laKZL
 P+CGaFRu7aYydDObAS0+ruiBGw6wzTnuCkAnBvTVf2gzuv2PEbYmw42Z1bUAxGchqCkV
 QM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360054; x=1741964854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+SEHRFMekz29GykQ7PlMCgQXWgPZliX2QLCYy6OiT4=;
 b=F7KW6HdlmysnO5rDwKq22ZBw6cdKrn8JiW6NwjdrDOgHIqt+SJYL+IwDKQROxnPnFx
 rpTg9l26yqIHymgfB4UrK5dTc4EofvxnSuE4tWDHVRKR2sptdradaqaPUtZ+2M1j0lnD
 rB+nBOtWlWaonWuul2o6fXKEZoRA6QbjtWyTiZrzbp7X28HH+twlHpxmUL8dnS3pwDSI
 Zpe5C9370XQIZXxUceP44/8NIHw+bqd6TGQ6Ulfyz3ST1rNU8SlILsYOP+t4l9s2GhmU
 LPOTp9J+XpFar9WPI+BijLgYxOfNRgKtIc2cpYP5ptJWdiPiC+dB/0lWi815gjtYwVnF
 8wLg==
X-Gm-Message-State: AOJu0Yy03LM+4/kme5q5V60QfuXYqBTaTr7czmRtMt1r4+NZpfUxmUfw
 /FbXlIh1OlbR4GQ/T/ksQ0CPAfbSzCLH+OsgGRuRL6AAb0zk6yYgYxVGLOstY4uPvny3dG179Xi
 g
X-Gm-Gg: ASbGnctBq7TQGv6TKvWakAlLtUjM8H1jQSUypmGbI8L9+hJH7Dp6MJ41Y8dcGtL0b3W
 cf2iyzFPLlV3r5xa0I6Lf2C0QVCpcjYx0gKhZZ8v4I/75AME+/09029u3eSjEAwyBH73KoKkjtp
 8Qg36Tjgu6NO4q5ZIy2KXSiwyTdhjI7Ljwr4HIOs8zf6Rq3iO47SnsK3azsz+I/x53w+YefmsoH
 OF4oePOOlBfPhd1rFl45PD/COsyBsnj0+MhFCpHYZ8xgl5bqfD9AFNePYttYMXYcju7jUFv4k1I
 uGna9pnlUNfx5lpd1OdH/g0kNVAMLjRcMlaUy8dw5XnDfPlhDI4=
X-Google-Smtp-Source: AGHT+IGjz4DzYmD/6MBmr6DyoJsQgHDp3SZr2dmIdz4DvTaEMkDT/qcKHj12jtIXfYpcN577sGBFJA==
X-Received: by 2002:a5d:47cc:0:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-39132db8b3cmr2976381f8f.43.1741360054294; 
 Fri, 07 Mar 2025 07:07:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] target/rx: Set exception vector base to 0xffffff80
Date: Fri,  7 Mar 2025 15:07:07 +0000
Message-ID: <20250307150708.3222813-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Keith Packard <keithp@keithp.com>

The documentation says the vector is at 0xffffff80, instead of the
previous value of 0xffffffc0. That value must have been a bug because
the standard vector values (20, 21, 23, 25, 30) were all
past the end of the array.

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index 7f28e729891..e8aabf40ffb 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -88,7 +88,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
         cpu_stl_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffffc0 + vec * 4);
+            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
         } else {
             env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
         }
-- 
2.43.0


