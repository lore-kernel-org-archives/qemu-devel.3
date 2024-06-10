Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75DC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgTW-00089N-15; Mon, 10 Jun 2024 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTU-00088y-NJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:20 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTT-0004Ti-7b
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso2547850a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031497; x=1718636297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U3x05a4v+4MAIH1ElGBtlNNkjkLnxPJovuCbksbMLE=;
 b=pmQ5N30bpnjpHHqU7x20Ij8LsuPAjcZ+fyIu06yPUUUz8iBTCicnbwxXy7GjYZW1BV
 DimQcGsPJTAnHZ3rSvoBAe/mHmeogFFhzRyXBGXZPj9FJYS7UitA5bXRNpPK0KnJGc37
 HSjqlyVZ8WNB6C6j+jTG9x+4rJ8Z5NjEtsmuQ4hnluwvZEBbyn38ZxPFEZNbrWd/qiVQ
 RaYfwdP65WYfSibU+O4Ikp7Ep8nl88oA6PCl4KOD4XUS5tQ+WrrGQHNzH2Wumh8FYDmL
 h5718rPlnjUGfCQd4F1MsKkvSRIcUQvTsPcxiCZYqJBl6zae15tA6Qsu2PUenILa4IpT
 j6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031497; x=1718636297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U3x05a4v+4MAIH1ElGBtlNNkjkLnxPJovuCbksbMLE=;
 b=AfC0fqJ8kx1YW6Z9MmOy4cBmwk+oJW5c4N5pJ0FBi+lX2nh/Y4H6d5NpChT5Q+y5Jm
 Dcai7Ad0vDfvTcS6AEnQZt3SCnLOeTQ2y1PD5q2d0qbZUah4r4SuVvYorsQ/m0PhOKZm
 suSDRdmBJMfTT7wrshGx6gM64Skfpd/PRf0ESeKBRjlGinuLihGuMj4po9wNs5NU3sbs
 t+/4loW/ZKhOaY+rL+/2MFG/1vUizjv/HvYNzfi1lc7YG+LXEsCqKMK+eA8Rqr7xPJyp
 CL3CR2una5bXyRr03M1Uqw4oHx0/2rE/GuHRY0owMdrLbXwiZqSP4nyUHv62gjnWm3fV
 zflw==
X-Gm-Message-State: AOJu0YyZjCCd/bkfxH0i+Er5kTtHNLVictkOzelolMuNbUYiCv20o2jP
 Ly0aW9eIERj5vrydTu1FAF0n2Ku0xowDfNUJXZ9vuJUDgqqgAyWrWgeO6Oxrifsp+78rsCoWUf1
 m
X-Google-Smtp-Source: AGHT+IHJaqImCD2zJlaf4glJ9BeqBsEkP+IxZl/vyyB/stdPQO0Vp9ezkgkLP9aXA3Rj6SJ0wUjWaw==
X-Received: by 2002:a50:ccd1:0:b0:57c:6adf:1035 with SMTP id
 4fb4d7f45d1cf-57c6adf12b1mr3365343a12.27.1718031497049; 
 Mon, 10 Jun 2024 07:58:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13fff4sm7739080a12.53.2024.06.10.07.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 07:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] target/m68k: Restrict semihosting to TCG
Date: Mon, 10 Jun 2024 16:58:03 +0200
Message-ID: <20240610145808.2267-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610145808.2267-1-philmd@linaro.org>
References: <20240610145808.2267-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the m68k target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 9eae71486f..23aae24ebe 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,3 +1,3 @@
 config M68K
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.41.0


