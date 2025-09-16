Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F8CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWdr-00036n-D5; Tue, 16 Sep 2025 10:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaq-0006Kd-FJ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaW-0008KN-Di
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-266a0e83662so16333505ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032572; x=1758637372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=977BcuDeql0kPwyP7xy6f+rDemPgbKM+wEyJIH6/QAM=;
 b=bjh2M2KbErnSmRH9mjG6+9cyI1XosvBCOoyNwVC82rtMukTyO1CSvTtvapPdIpy7lu
 ZJ1YXmwHwZUKfQdr86z3Q6QV59JJb7W6YoPNxoh0u9oN4I+iFRumEsxP4LLdRNwPXtTJ
 zDX5YejJHZbCRKxh+yc0GM2BKznG2xWDi8znoMNY/+Nxdzozcw8aNeF3lWK8YAwWSrgB
 vrByH+6pRUI26W0IMABi3NMvxZWavBU5rRt9QeiZiLw4oU4FAhbkUu3pQ1GtWpralKKP
 Zdp9XN5c9eDSZe/aAz4kEXLuXTiWRshQx1Px4BssjQOxg+249Mgtg/hQkhsASOZ/20oK
 Dp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032572; x=1758637372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=977BcuDeql0kPwyP7xy6f+rDemPgbKM+wEyJIH6/QAM=;
 b=n3W/GdrHrrt84rrYOrOfMBbO37of2oZUMx+5XNMGXFwKHST58TyxK1odPMJGEjpc0t
 8xQiO5nnJ3WPKio8koDmSKv4vC7HmJzNEhJTZGXAMGE5jSFWLTnEmo6ABXoyVyuI30Wj
 2GC7riqqhLkz6NdoMkpgJGAtrMjfu1vAlZpcO0qDh1r0GM39vXhO1VMytjXdD0P38BKl
 t2X7WhJGR7pZxIZ0iTvtU06X1tzVt2ZmLaaNPRv50pvKSwUz52RJ2bgx/hBwbKaBqH4d
 3gEVnXwp6uK4ii43kN3ZwBu7M91F3lNWjKxUM8/XRYBGWE1gxxdwp9A88XRior9iyP3b
 53Jw==
X-Gm-Message-State: AOJu0YwDRLWXb9Ed/Lm2otu3Z2ViXOfzH1g2OkBKcwWW4oVRbe4Uk8vi
 phy4HJqTm2hKK6sppZRSXEZiVkAyT7lnBm0FA8N+fXZpnunXgmpu+bAaeTGvHFlDEw59PN4sJvK
 I8ySB
X-Gm-Gg: ASbGncvjKyeY0ytumqRCUkRxT1u/Y1YsiL1Os3Ca1yyxcxnU7ZbgNIVr5GpumQ6Fu87
 5pCLyOGdHv6P38os5ula8hwy/cvweeeP+jM8uh7wISQJBjxARhKmB3XiDP5LmaEERt/YQS0LMc8
 IlJX+2Z6xydllSh9Uo/4CTtC5GwtAoJp2MIEYUcdvpaVx5o5ET1PcQ8nSxw6IdI0mez6sOmvv/B
 bQEPmEf5GSSrufZ5Gu8hcq9Jv4Qp9fBCB3yk/odYq+8cAQCX+RZM0Ki/6wAknddjZ+lPJbbqlVz
 DXPnN8XY5gNRfLM71TQ0xFdXiHdXzlZ8upMtin7YrfjV3sIRrXrOscwkSAHXGw7dep9kzb50yOY
 rw+XKgaOJzUVNzHWNsCM9/ai+cHer
X-Google-Smtp-Source: AGHT+IG2iXOitsj0rIiXECUvXk5tueRmn0QeAqPPunkUAzstgAMO/bL/1uU/1fB8l8EmmejQ3taH3Q==
X-Received: by 2002:a17:902:e849:b0:267:d4c8:c50 with SMTP id
 d9443c01a7336-267d4c81797mr30152665ad.27.1758032571765; 
 Tue, 16 Sep 2025 07:22:51 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 15/36] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
Date: Tue, 16 Sep 2025 07:22:16 -0700
Message-ID: <20250916142238.664316-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Give a name to the bit we're already using.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b6c8eff0dd..3dc4c9927b 100644
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


