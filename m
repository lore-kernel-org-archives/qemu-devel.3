Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2992-0008BQ-PO; Fri, 26 Sep 2025 10:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298Z-0007Sl-9U
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298J-0005gX-F0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso8862235e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895744; x=1759500544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gECgbKEcYHTmXKtVZy6CzY300CnzlKZCzOl+7EfMFg8=;
 b=ICNxceDmPJyi8PfhLwMAWlFs2DsX+qr4ARt9xPCl7KtVeQlIYE+OKq9YBpKaHqljMf
 7MvynTKSegKqlLbsCOi3UP+/XYAvAy7wu1XDxAoJELi5MqjAbaOyM41EpR/SOfJuIGLO
 yWypiBcslFA8FGkEvWNSJEqwWspxUTUyvnhlv+cf1A1kl0czC0l8pG8v/UjgHq2jY2Sd
 36tSRNzHtZHSwgA52AUlxE5rryUB0H//V2sqPYM/RBe3iLCtFJaYhsa6ED3rr1NqhMer
 7FMW8OYssWBeF1c3xDL6xg97ofxJPhJ5HlJKRfVahzqPy3VSal6p3qKLg2v/TfKq/oGf
 p1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895744; x=1759500544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gECgbKEcYHTmXKtVZy6CzY300CnzlKZCzOl+7EfMFg8=;
 b=IQgVIpZiZxruGq9CP/V4htkpUJ6+9jDmVIQafkZfZoQsFUHyP3YhLE/POrBhaxCAz2
 RwDg8dAAJvyUNPXf7/X6hKA44e1JJ1YbZbO5ysVnEyrcfEV5J2aaPbKaOAFLEHRxezYI
 r4edUrNvoDJqWeA5elNUrIgOdXu5LB/R5gh/0mnhDofaJEKPCMBIAoz+2CURWOnKRgRu
 wHR0Oy2TFzCKGfuRrLIHK8XgsOBfZpyWrAkB1+8l1oFP6vxOR44Znn+xlSt92uTrMuXt
 pYPmt+nsCJFXnt1LjqbxIashdxxw7sCfwhxK43k979CdetQkV+wz5f2CqEsAGaqPPgX0
 68+A==
X-Gm-Message-State: AOJu0YyqNJ+U/82qh1l4wdUcnAtHY28iusPU26BkTZ4TDd2D09G6UZu4
 YcvUeuHe44xGNfU+SoMoLuZFxv/6IVrukQ329LeYV7yCITbKf+88nnCrgyokHVsi3GlmcEQWXpy
 uKCby
X-Gm-Gg: ASbGncs8a375wUc0HfTBrQvNUwl07xumJm4RCNfczII5uoRdPX8dN/t6Ep5GiFFCBhh
 ZOiEqaqc1UHAIGr9TAlc8cqFD60XuyaEb/A6dSWh5EmTonWMDPACEvJnUf5f8wOsyy2nSVsoa5N
 SA3qQpdprsQjIO/ONfQQkwQYBnjbtTphQlcuaCZx5Cg+jObgPs93XKx/HrZiyHtwVgxR+nNaC6e
 AHaHm1KevYVV48X/N8Fzxp9rArILGZjzwug01SSuywkSe5bh7Bffl3UDRlO4juvf2k6Ky5aM0t6
 WGZDHUMzTob5rLpybWSQ2500/Gruz1C80PGLAHTgDr+IEEeoBbnWctCE9WAFsQEO30vhLb3GHo+
 oG2ucKY6rW3pvK2IOlvS7UCxujhdFkKRr+oaj9Ag=
X-Google-Smtp-Source: AGHT+IERT4vZcoUUULqK50d1Rrr/NOqo9FJqCfgK+ElSWQwSJ3cvRv22J+VdRNtul6vJnYkvcoLmAA==
X-Received: by 2002:a05:600c:8b5b:b0:46e:3dcb:d9a3 with SMTP id
 5b1f17b1804b1-46e3dcbdc9bmr20959135e9.12.1758895744277; 
 Fri, 26 Sep 2025 07:09:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/44] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
Date: Fri, 26 Sep 2025 15:08:17 +0100
Message-ID: <20250926140844.1493020-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Give a name to the bit we're already using.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 74bae7309a3..f7dd6d2f758 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -178,9 +178,14 @@ enum {
 #define CP_REG_NS_SHIFT 29
 #define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
 
+/* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
+#define CP_REG_AA32_64BIT_SHIFT  15
+#define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
+
 #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
-    ((ns) << CP_REG_NS_SHIFT | ((cp) << 16) | ((is64) << 15) |   \
-     ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
+    (((ns) << CP_REG_NS_SHIFT) |                            \
+     ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
+     ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
 #define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
     (CP_REG_AA64_MASK |                                 \
@@ -202,7 +207,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
         cpregid |= CP_REG_AA64_MASK;
     } else {
         if ((kvmid & CP_REG_SIZE_MASK) == CP_REG_SIZE_U64) {
-            cpregid |= (1 << 15);
+            cpregid |= CP_REG_AA32_64BIT_MASK;
         }
 
         /*
@@ -226,8 +231,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
         kvmid = cpregid & ~CP_REG_AA64_MASK;
         kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM64;
     } else {
-        kvmid = cpregid & ~(1 << 15);
-        if (cpregid & (1 << 15)) {
+        kvmid = cpregid & ~CP_REG_AA32_64BIT_MASK;
+        if (cpregid & CP_REG_AA32_64BIT_MASK) {
             kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM;
         } else {
             kvmid |= CP_REG_SIZE_U32 | CP_REG_ARM;
-- 
2.43.0


