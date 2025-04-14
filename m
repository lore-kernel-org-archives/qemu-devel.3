Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB8C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Llv-0000hq-Gz; Mon, 14 Apr 2025 11:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llr-0000e5-K8
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lln-0005XV-E7
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:50 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2295d78b433so46677525ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644639; x=1745249439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqyBJJOm46Sb82n8FzKaMXcdhyeyuBYZxwBUrlvI8+o=;
 b=XAhCQWPtI5b9ASzbVx7HJhZ4N/BwCxKWyyyXrtwUxTrH3om+e9Aru5Krff/pGuprWp
 cWSOIhu5HkoRn/L89fkPPajOVqlPm1ROeoaMlgAeEB1zSgXFBwOsS5hlqFhOwlffLDA7
 FjBllEglTWhOdYEz1CKrqt0ay5oIIyfHU97yQhrBcOi27yIWaZWh1Ce508VuR/D6d5v6
 Imyf804pPbdGsP+Z7hywAZMVdzxlXc23kTbJ8zkevv3inUDOsZlm86ZNloi1NhYTob57
 dpRMw6ZfuOb4rKMicH75XtHaAo2H6ZthLMDBKvq9axV/ZmakPoMd9q4l6hp7Umz+IPQr
 Up2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644639; x=1745249439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqyBJJOm46Sb82n8FzKaMXcdhyeyuBYZxwBUrlvI8+o=;
 b=Ua7MOtQDA8ycLmLnMSs/er1PZkCnVZBwU7KdV5L4LffF6ZOMLVu6E+a/w8RwNS4q9K
 3vKVwY3jwGX817OVuHvTxesgkb6QF1LO8+i17w/ZuYRNL1gBO7ow9oOTeTcSwe4MnHcX
 FXenInq8MD1AATyvO7j4sBOIl2KOALSyCGr9IE08aObG4VTpPFSCKV+DLYquJDlQRMsh
 x/H/n/Bnn5/Sb5EYQpDqSW3jYhF1hoE4iKY3i4NC/4yBvJ4rv1V80iOxcLtlwZXg9BtR
 C/hgQCBhuKjXZ9euwhLeviNtVwCQMFSdEFlD1gzbBXNcmm6ya62FsTf8Gge2TN+sZLAP
 ScsQ==
X-Gm-Message-State: AOJu0YwwBN4fG3CF8+OWyYn57ZAQH4DZhl101ikY6LWVON4c7VCaCJyq
 ZjTWCDxqXF5C3zLMzeDyOiRSSAJwHJwXOPiiszeqE5w1LaCiiNgrSOi+r2bWytpiqM9OPQMSp8/
 J
X-Gm-Gg: ASbGncsbxMdrfj2klgdDw2cpGw4ABTj0iaNMJwAEuT0zShEfiOtwfkFy0g3rXjXADFq
 t2kXYLZ4AbnsaBSdQxOxD7vc9CER7NdLX/p4l6kT7fEeAB15kOUAMFq4pRdU0Sl7IMKuBrZaRTY
 Vg3nUqmeUdN7ZUQ3AEl8zOMsoAvWS27BifwxB7R5cDKVwiwLpO1/2Y/4rVbYTj0ths5aU/IB78B
 30QuQQXSNwADvGQtY9y0SKbNYJ3Q2EotKXKGrHmleD7EZ03aED/qJXJZsE1PJkqmE3rZ/luB/Ax
 EVs9/mNFZdUBCvxx2A/V76ky3AAWkU2bdScnYRzsdcM3GSoAWX4=
X-Google-Smtp-Source: AGHT+IGj2y01HOaY/U7OEdnQAN0S+23Ws0NfwzBdUjrskqCVThL7GgoEJaZ+7iPR0rmsB7OD6BUMkA==
X-Received: by 2002:a17:902:ef0a:b0:21f:2a2:3c8b with SMTP id
 d9443c01a7336-22bea49d314mr182921865ad.11.1744644638942; 
 Mon, 14 Apr 2025 08:30:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm100735235ad.248.2025.04.14.08.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:30:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/4] target/arm/ptw: extract arm_cpu_get_phys_page
Date: Mon, 14 Apr 2025 08:30:26 -0700
Message-Id: <20250414153027.1486719-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Allow to call that function easily several times in next commit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c3e4390175e..bf92c165175 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3629,23 +3629,17 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
+static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
+                                    MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_space = ss,
+        .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool ret;
-
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
@@ -3653,3 +3647,13 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     }
     return res.f.phys_addr;
 }
+
+hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+
+    return arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+}
-- 
2.39.5


