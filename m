Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884EAD1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbI-0004UZ-N2; Tue, 05 Nov 2024 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbE-0004TS-Qd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb9-00075j-7Y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:52 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so43593975e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805583; x=1731410383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4CpB0XbZQLncselzyyj8L+Ydlxu2Z7NIO+QmbjnCCQ4=;
 b=z7RuK1bVXxL3OF5gUx4lemw9FYwALvtg55ON7sr19qhjaYnOk6tnCU2qCSIhoyi7aP
 0c4A21Jg1jv78KPC205McRz1NlvBBhg0mPZDa4Y289dbmZp7J0+sCnD4QA5ObCrteMxA
 2q0hM4ZTXz/CSov1jQh2UhZVukOUHrvVENGAXmzEDOIl9e/T8kF3OlgiIrStCuBEVPHT
 AmoxtbEIQJ1K3rmEMDZTBUbB7tdKz5ROlWP3mHt9j6xOdWMBVs8bw3LjS455HAEmHFpC
 I4kvgZe09lhBla3C4AX1mLg3Kg4WG3o4Ag2Y6rF3mQshPnSusuhQmswNNBJ00p3xcer2
 pMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805583; x=1731410383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CpB0XbZQLncselzyyj8L+Ydlxu2Z7NIO+QmbjnCCQ4=;
 b=JBUrHt7p1WyQN28L6s8MXOrEcxTqCDlGBdxSPrRIYJ2CZFShiOYXGbejV/fbeWsktS
 O88qY6Ld/rAVi7yZjoUOiguC1llwH8zBDzEYft2nMbuSoJxOih38HMXvFIhSQXOOvQAw
 elJCxqRkWB8WUOraVlhecY9EPM/UpVmkb9CQYFZqSOgMDfXAKqKCa9EBirtOqRTPqhr3
 ExKyx+eooREZxMfji0/sIudTEbhJV723ki+YxA0i4YrK7KX1oytTAgaWvj3/7vZmojWF
 daZJ3FqNFrouoDjq7IoVIbxN7q5r2N9J602ZJyppS23RGLhzd/NEsxvmwUpp/vmDrfi5
 vROw==
X-Gm-Message-State: AOJu0YzhYE3649NELdsfGOlk80eA2uPfXsDYMiqGwxzbU+akZBj4q7Zz
 FDY0Qn5aJrefBD8//w8BmipxYos4ekAPaZkUizwEiFYRtoeTLbR4uBEIWSYe8fWvOZxvaKKsY8z
 D
X-Google-Smtp-Source: AGHT+IHY7vgE1TcQVbvrTrhQDKWJN95IHvwkWYOb739Ug1ocWVls3zM/AEh20TSkWY/xE/jboiEKJQ==
X-Received: by 2002:a05:600c:34cd:b0:431:157a:986e with SMTP id
 5b1f17b1804b1-4319acb8d3amr283664825e9.20.1730805583224; 
 Tue, 05 Nov 2024 03:19:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/31] target/m68k: Initialize float_status fields in gdb
 set/get functions
Date: Tue,  5 Nov 2024 11:19:14 +0000
Message-Id: <20241105111935.2747034-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we use a temporary
float_status variable to pass to floatx80_to_float64() and
float64_to_floatx80(), but we don't initialize it, meaning that those
functions could access uninitialized data.  Zero-init the structs.

(We don't need to set a NaN-propagation rule here because we
don't use these with a 2-argument fpu operation.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-11-peter.maydell@linaro.org
---
 target/m68k/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9d3db8419de..9bfc6ae97c0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -36,7 +36,7 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s;
+        float_status s = {};
         return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
@@ -56,7 +56,7 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s;
+        float_status s = {};
         env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
-- 
2.34.1


