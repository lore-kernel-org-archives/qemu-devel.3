Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAAE63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpYE-00034K-VR; Sun, 15 Feb 2026 22:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXp-0002jp-Mh
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:12 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXn-0002dx-3E
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:08 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso1662240a12.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213505; x=1771818305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YspkmQ6qCsCzLdbemTI6YW69AEAqfF80AIDpAXjfP0A=;
 b=xq19cRc225oig2HaE+i2uwxVgwlz5IcWBHLrrTkpbWlUbCS7PSmJ9T4fhxM9gUCsm0
 Sn4lzkfpjI4UEgAA5T0H4bzaHsTzyyiQZGYwKr+6luiAqs2KTxmUR0yRoSExdj2UCrYD
 3RUva2h7DNnvfGoRROdHLZPdSF785oBq6jR8jPNFmWhs7PFV/IWnaV0qj0lTIzSQRGtJ
 H7LfNOpSmoE/LcCFyhull8J0X8sM19XhPBdWSCXwQ0pdKMrvSuvV/YBlOrtgwkQK8Y27
 CCDAZhDG6/RWL7s7lc3scmjQZLBdqretqU11kGuohy1qzQXYS/o8ti3+IiuCwr8o8a3v
 zeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213505; x=1771818305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YspkmQ6qCsCzLdbemTI6YW69AEAqfF80AIDpAXjfP0A=;
 b=E9sW8quuMIu90mv3ebSxu4X5Lm1tAZdm5QBtPR6gW42/c1zqGoH2XVn5aaHeBLyD+N
 20vkL+upI+UU2lr41BEGor7ugI7naLDuJfkLAS6nyQ5tfOPaqdNht0QbK1GGr4gGImqF
 LDT/VrwX3cThHTBW8S/xw4yXlVEYHGz2JRzpgITSNbx/l+8MCasqofSg/DrPxxlx5Frz
 bUVDWNx5moWYj1WaLFCFw3s9mLcROZyTmmYcYHJrM7d3cS3o/GSCPzp2I7lSUDO8/Ddg
 RA7NHSFaohxhprCYr5frLDNVfVNMNSOV08HSpjJYXkkbgefN1a0LHFfrRTADCRODZ0wC
 /AGQ==
X-Gm-Message-State: AOJu0Yyr6ehpXHgz8zsX0j3JbXdd2pr9TbrU94+y8fv8Cy+GCjcHObQK
 cD1Ojl8NYKNBpYO8pWTe/mAwHVBpoythCE6+KczgXMjNG+WPfuQNcJwd2bxy35crLkOFSjUU0jv
 TnpEA2KU=
X-Gm-Gg: AZuq6aK8BFgxXQy8x57sSTIepWnKPtdbgl8r/vA7FYzGldjt+poiBjGhA9l6fcQ3EdN
 oEAaCICOQC5lmWET8r+soL8i7T/ju8ENrMActnMbE60zTpP8nJbKHwjBfxRkmSATblvnpt0vXYF
 WkGUcqMERReKaWElH8geNdEGSoOcn8BsNKvPPcIVeczZcT8/6KAM0kWIVE+J1z43fyRLf7ie2CU
 rUsuGLwCFdscLDGEuL2cb1PzYw1BNm+noXJeoX/0fM8fhgDDJxsjgwIMDZEg/LPgXP9tB97rpLV
 AOEH9B0z+vwWmopUaQ7HpGLPKVHsPK8n3pQu//LYJuh/aHkzmus9zimf+ApyO5Lur/nPQQprpwg
 njl0Osx4Nj44+/SmHmpR7/4qW90ZcnMQYxhoZUvqgeW8AQs5IZCs1HZs2RB9b0KxBbDIyrZOvR5
 20075MHZWXsK+1zQl7fk3cPhML/sVfm22N
X-Received: by 2002:a05:6a21:398f:b0:35d:d477:a7d7 with SMTP id
 adf61e73a8af0-3946711458fmr10264998637.7.1771213504591; 
 Sun, 15 Feb 2026 19:45:04 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:45:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/13] target/arm: Add SME properties for KVM
Date: Mon, 16 Feb 2026 13:44:32 +1000
Message-ID: <20260216034432.23912-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the properties even if SME is not supported, akin to how
we unconditionally add the SVE properties.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 38d06af49f..4a7032ba72 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -496,9 +496,20 @@ void aarch64_add_sme_properties(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     uint32_t vq;
 
-    object_property_add_bool(obj, "sme", cpu_arm_get_sme, cpu_arm_set_sme);
-    object_property_add_bool(obj, "sme_fa64", cpu_arm_get_sme_fa64,
-                             cpu_arm_set_sme_fa64);
+    if (cpu->sme_vq.supported) {
+        object_property_add_bool(obj, "sme", cpu_arm_get_sme, cpu_arm_set_sme);
+    } else {
+        assert(!tcg_enabled());
+        prop_add_stub_bool(obj, "sme");
+    }
+    /*
+     * Only TCG allows FA64 to be configured; host virtualization
+     * enables it if and only if the host cpu supports it.
+     */
+    if (tcg_enabled()) {
+        object_property_add_bool(obj, "sme_fa64", cpu_arm_get_sme_fa64,
+                                 cpu_arm_set_sme_fa64);
+    }
 
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
@@ -784,6 +795,7 @@ static void aarch64_host_initfn(Object *obj)
 #if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
+    aarch64_add_sme_properties(obj);
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
 #elif defined(CONFIG_WHPX)
-- 
2.43.0


