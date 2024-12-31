Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41826E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSinz-0002s2-VB; Tue, 31 Dec 2024 15:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinU-00022x-NA
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:25:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSinP-00013e-9d
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:25:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so5703483f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676693; x=1736281493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTSP6NjIVoPRvTo3NrDC/CEb4C93RSiNfhEoUzld/gc=;
 b=eatyQC9R9q8LniTPPfelaNasXQyUn9FvlX30TU0mVAlUGVUsMw8fBd7hXl79QEjSAN
 t12vg+TRSgrHRZ8PA/2wUsZCd93mjsb/NLNTfIlgf7OdZGwFQWIdcbxb+teFjyjSGL1a
 gGewi5UjUmP0v0SbxoAjdnw93lcTnYpd2xDwMOsFbvtAfPpgeCN0er3JAfsJtY66Tyav
 jEGTJsQp08aU039ba0B+ZV8Gv8o2wtDAuvb056pTGs+lqm6TDcGrId0X1NGwB+IhXwfE
 MH03LqZgYSxuNpkyeuoiw9pNLZW3nWALPeJM3ORom6wGBNXSMD+NGV7IWHX3BxOcc9rG
 3L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676693; x=1736281493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTSP6NjIVoPRvTo3NrDC/CEb4C93RSiNfhEoUzld/gc=;
 b=a1rOfcqBy+i0Ar+pyMYycrlOZ4q5lZ3NahW8ZWlUJFJZM9JMUmeFXZj7ExUs7144f1
 NS0cz/DqpQYRtoTaDdaAgdhpB9CE6nSQTKSJTpEA1zSd50KbdqpAgCBq5MyloGMtyWN8
 Db8TMUk1/TNTRoHxr6eQ2aiWEuNs9+9IJIPTro+Dn9om3eQm+uTLwDCuDeycuQJtS/e8
 sSX1p341XvaUxeydRfFIknajDt1YdKvHE6becAZaKRp25kXbrfqp17AwMBbyTz5AJN+O
 6LctKnTuCXcdtJZg9e6kyag+K/me9qi4syeUZHjG20AMqIG/fo2xk2+KUAL15JY+T1JT
 IsAA==
X-Gm-Message-State: AOJu0YzIG2fMqx3PWX8ylrZ2BHEMqUHQy4qCW4G/Rp768xXPJn6XE5FZ
 UFb5JDZ3nZP+/lCYPlaTm7UYnex8CY+XPPXcuFgCkW0tcDfeuTDQGa4zGIfSXvYj3qlhMMsjZAz
 36+o=
X-Gm-Gg: ASbGnct/PapmqFB5pv6k3u72epDSNeJFjHrR+3OWgMn7FT90AntaAMQZGIr8O047/Wm
 PtUKA6gW+vgyXAvcKr5GSWcOKmxeTvxFSZ0qVs1OV5M2W1zJRAlWmGOsKdPxvtY5T6JmWpBdSPT
 zlptdZwSd0Gat8/lxMqdBM8ksu5kp5E5Ioo4q9LSuSv5lw3bKbihdvlXhjFQykAHFW188My/eqN
 /i07opF1kS+bVEfsB0+wFziSltaDdLC95gUI4fYOW/gOZqa3AYfjRuOYlWyUNbMjKE+i4gNTsCE
 Zx49xqOj6tne5/+Shva8XRO1Z70RAxY=
X-Google-Smtp-Source: AGHT+IEBM6rAW+rV2DkTz/sjto3Px4jRPnsqm5xTMOA1YLzFA4S3hYngAqNmP4BhoyHmd64IOp6O9A==
X-Received: by 2002:adf:ab49:0:b0:38a:5ce8:df51 with SMTP id
 ffacd0b85a97d-38a5ce8dfb8mr2609028f8f.2.1735676693219; 
 Tue, 31 Dec 2024 12:24:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea42esm404643215e9.9.2024.12.31.12.24.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/29] hw/display/qxl: Do not use C99 // comments
Date: Tue, 31 Dec 2024 21:22:28 +0100
Message-ID: <20241231202228.28819-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Hyman Huang <yong.huang@smartx.com>

Do not use C99 // comments to fix the checkpatch.pl error

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <7d287eaf00e0b52b600431efd350b15a0b5b3544.1734633496.git.yong.huang@smartx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index f54a15e7404..2efdc77e613 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -50,7 +50,7 @@
 #undef ALIGN
 #define ALIGN(a, b) (((a) + ((b) - 1)) & ~((b) - 1))
 
-#define PIXEL_SIZE 0.2936875 //1280x1024 is 14.8" x 11.9" 
+#define PIXEL_SIZE 0.2936875 /* 1280x1024 is 14.8" x 11.9" */
 
 #define QXL_MODE(_x, _y, _b, _o)                  \
     {   .x_res = _x,                              \
-- 
2.47.1


