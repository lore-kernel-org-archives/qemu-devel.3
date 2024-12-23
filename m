Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6A4E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 04:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPZlV-0000Ht-KY; Sun, 22 Dec 2024 23:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlT-0000H4-Hh; Sun, 22 Dec 2024 23:09:55 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlR-0001Pa-Vl; Sun, 22 Dec 2024 23:09:55 -0500
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-889e8847d56so483817a12.1; 
 Sun, 22 Dec 2024 20:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734926992; x=1735531792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQguSZN8sSKDeZZrzzB2zGOKmo+eCQfE3oCj7Gt4Jdw=;
 b=OmtY6pdTbN6nD35MH3rchyJFAOQS43k9alA4OHB2zmbG5mHxpt61W1Qw+xb9RON5JN
 Ak3kIYrLHdEaqksJMNLxYAE9vcSgeAW9xsA4+ooGUbok+MJtOxcTtS2zNg56vvjthkqY
 q9K/6PhXyute0eYGlzpVPd/lmDda+7zIVXlVYQVwMamMC8tsoH7+Ik1xVv/p285Z2LQg
 6MsBtTml9K/ixrClGvrZM2L3HB5Zuzmc5vlnHYNEYd/GxllXVG33U9EAIhEs1GvjNVv5
 Fs4C9tBZRSkRPrtVl0X/yIW3WTXGtcem9yADf3s8AoCHSj/74T1XLgySWrNHhATddfWe
 aw3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzZxeK42AsBmShLRwX2bxeWShhJzCURcloq9pZMuyQGWaQxzHMuXs5gB7Rzj4nxxsdsXTnfkHiaw==@nongnu.org
X-Gm-Message-State: AOJu0YzC8dusblwk539D2NWeQ1ZajLVHiBk1LfP0wB4RixfTdIGt1LDF
 iS3RhsNh1951yXQVtryb8KA+xJdP39CAo4jCCceWpGd+IQ0kySxXjsV++7Id
X-Gm-Gg: ASbGncv90Q5OfRs7JnnZ5XExIvU/HUtEbqLge7acJxQyi6vPPKjANDiKzRmgkbXnFPh
 fAUZLlHxyswD/tX6zNlM+uagpTvmFvyXQlKveth/TN2Sm+FwMsTB7H2sESkDJJfEl2rvm/s2GXO
 sCLm2HMkIl8lhgvWtg3E6rr6rGK0kRC5Ly/0ZlAX5sSTt1WWnRVhi1YxRJ6+ymACXMxqCWXwgOA
 7qmb+EmEaDwomv+jtwj0Ff4C9bXFW+YO9gRuy4+gPcmAb+VCc68yYb+Z1zgt9GetG25+oTye4VD
 VuiOLClQMQ==
X-Google-Smtp-Source: AGHT+IGy6yX0dhHHyfMu5kMCMm52RxBCpW696v37iD0285o4csaNlcVLQrxPmvRkQttgbd+b+qeLJw==
X-Received: by 2002:a17:90b:2b83:b0:2ef:9dbc:38d1 with SMTP id
 98e67ed59e1d1-2f4435ad5e6mr21538981a91.5.1734926991675; 
 Sun, 22 Dec 2024 20:09:51 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c02:c8b4:911f:687c:35b2:bc4e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f4429sm63921115ad.173.2024.12.22.20.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Dec 2024 20:09:51 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 2/2] hvf: arm: disable unavailable features on older macOS
Date: Sun, 22 Dec 2024 20:09:45 -0800
Message-ID: <20241223040945.82871-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241223040945.82871-1-j@getutm.app>
References: <20241223040945.82871-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.171; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f171.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.167, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

IPA size queries were introduced in macOS 13. When QEMU is built targeting
a lower version, the compile will fail. If targeting a higher version and
the binary is executed on an older version, QEMU will crash. This will
restore the behaviour before IPA max size querying was added which means
VMs with 64+ GB of RAM will not work if running on < macOS 13.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 target/arm/hvf/hvf.c | 55 ++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e..da60476dbc 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,7 +897,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
-    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
+    if (__builtin_available(macOS 13.0, *)) {
+        clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
+    }
 
     ahcf->isar = host_isar;
 
@@ -923,26 +925,34 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
 uint32_t hvf_arm_get_default_ipa_bit_size(void)
 {
-    uint32_t default_ipa_size;
-    hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
-    assert_hvf_ok(ret);
+    if (__builtin_available(macOS 13.0, *)) {
+        uint32_t default_ipa_size;
+        hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
+        assert_hvf_ok(ret);
 
-    return default_ipa_size;
+        return default_ipa_size;
+    } else {
+        return 0;
+    }
 }
 
 uint32_t hvf_arm_get_max_ipa_bit_size(void)
 {
-    uint32_t max_ipa_size;
-    hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
-    assert_hvf_ok(ret);
+    if (__builtin_available(macOS 13.0, *)) {
+        uint32_t max_ipa_size;
+        hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
+        assert_hvf_ok(ret);
 
-    /*
-     * We clamp any IPA size we want to back the VM with to a valid PARange
-     * value so the guest doesn't try and map memory outside of the valid range.
-     * This logic just clamps the passed in IPA bit size to the first valid
-     * PARange value <= to it.
-     */
-    return round_down_to_parange_bit_size(max_ipa_size);
+        /*
+         * We clamp any IPA size we want to back the VM with to a valid PARange
+         * value so the guest doesn't try and map memory outside of the valid
+         * range. This logic just clamps the passed in IPA bit size to the first
+         * valid PARange value <= to it.
+         */
+        return round_down_to_parange_bit_size(max_ipa_size);
+    } else {
+        return 0;
+    }
 }
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
@@ -973,13 +983,18 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
-    hv_vm_config_t config = hv_vm_config_create();
+    hv_vm_config_t config;
 
-    ret = hv_vm_config_set_ipa_size(config, pa_range);
-    if (ret != HV_SUCCESS) {
-        goto cleanup;
+    if (__builtin_available(macOS 13.0, *)) {
+        config = hv_vm_config_create();
+        ret = hv_vm_config_set_ipa_size(config, pa_range);
+        if (ret != HV_SUCCESS) {
+            goto cleanup;
+        }
+        chosen_ipa_bit_size = pa_range;
+    } else {
+        config = NULL;
     }
-    chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
 
-- 
2.41.0


