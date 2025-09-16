Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D49CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcz-0000xu-2c; Tue, 16 Sep 2025 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWac-000618-W6
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008Kk-RA
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:26 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4d1e7d5036so3629302a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032573; x=1758637373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5WNm+peGJ2zUSPWUGzDEpnW/8pjrsxmYerIn3jmpQec=;
 b=ISDnKVuCGLEbKdUqbw2oeMnRl4ZZMf5+WNohibxD53yzGhkg8nI1r+ibQCOpX/k9xi
 2Niy9kl6hZawwxqNI8SSO8orn6KQq31jmuxnQl6GZXa04uqogcSpDQTuK/IN9812anEn
 TK2ZugVb0V88L+Fk6GSn0tjWii7uW7DkjxahYiOYJ7iRDd1Tw2207P4fza8rxlFrxke3
 zvktsElc12cYXS6G65plvlVbosD8qPiv3iR/jsmrqttifZ4UHEO9n2SL5oU8Eak5fDAx
 hDRZ9xlxu2NNKau3aPtZABfdcvThH0RqgAOKFVd1zLz0cLbxDpAZjk8TjtV/ARNSrBXO
 kKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032573; x=1758637373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WNm+peGJ2zUSPWUGzDEpnW/8pjrsxmYerIn3jmpQec=;
 b=fRQE0/LQpwJ3bijI1OBG/dG/KKk/gBh+cCPYDkGs6iiTKHGD29Kg2U8/PpkD3xRodO
 ERwzzMM2S1s901wFy5YI6BP3OLfA0nlTZPDA3Q4p89TZ72sgtpaTX6372pK1mwJXIEfk
 mxFT0mmQPogwhKqBXgaSG2209oWBUvEne4NQxuFa4OYLgs2lOb/of/MdjSPjsm2+IeR1
 cOaXFNI8AdOa0aNxqFQkk7OWmnL30BEiNnfow74zyQnNGrFRe9wNRuX0gkkaBZ9yeQLy
 XLc2Q0TMV26rYjKgIoH71aVIUXygi4AnMgoItRv8PfuRlTrmojb980NDJiHr1LPhuJA0
 hxXQ==
X-Gm-Message-State: AOJu0Ywg9OQtkjK70QiWNzN/i53ek/zZotZcB/OWhy1jpwVgTV+zF4oM
 ebVeQvp29wQZeZpoifP1KD6eoguKIFTRHX3SBGgDkkUPlif00WXkGLkG5gWOBdTySjy1fUOBjnk
 kzBe8
X-Gm-Gg: ASbGncvhAjIMIyHxaHH2l/Lqhs6M+ay9f/RzSm9ZcPfeGB0edoyTHiQRN2f06LsHYii
 QnfgF7UijwqD7mCfT5WukTmdeNB5+kITlbr1mzuO4DwAtV+o/26eQuUZP0kznE3GItm54URjSr7
 mIq0NSDJd0qkcW3LndlBBUb4krE0kEhGYOIDdKqroechnh8uXsaOgRuJB5tWfxg2GOU662rBmR9
 vTWqo7N+XUs69NmkzkRs2a07Elq2Mc9AvSS7TK18bmHXbij4EhlK1rS/Djx4kIGJGf+OWDmeAep
 q+OdfLVC2xlmLfNiNZu23oh6vvAVDvFSCGzX09jv4h9sQqTFip6KADQ2WDmH/8ZMwtZtci/eU/e
 S0TH1voYFao/debTzyGwMyNX06SH/
X-Google-Smtp-Source: AGHT+IF0PNhtt1zGo8dj/E1sITwfcw6yGZWUjoOyDjGhs5mlvkinOMwL0GlUVAwRFM5ap/0bXCdEjQ==
X-Received: by 2002:a17:902:ef47:b0:265:c476:9a53 with SMTP id
 d9443c01a7336-265c4769c71mr90990815ad.41.1758032573227; 
 Tue, 16 Sep 2025 07:22:53 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 17/36] target/arm: Convert init_cpreg_list to
 g_hash_table_foreach
Date: Tue, 16 Sep 2025 07:22:18 -0700
Message-ID: <20250916142238.664316-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Adjust count_cpreg and add_cpreg_to_list to be used with
g_hash_table_foreach instead of g_list_foreach.  In this way we have
the ARMCPRegInfo pointer directly rather than having to look it up
from the key.

Delay the sorting of the cpreg_indexes until after add_cpreg_to_list.
This allows us to sort the data that we actually care about,
the kvm id, as computed within add_cpreg_to_list, instead of
having to repeatedly compute the kvm id within cpreg_key_compare.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 54 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7c483b0d9..cc924adbc7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -229,11 +229,11 @@ bool write_list_to_cpustate(ARMCPU *cpu)
     return ok;
 }
 
-static void add_cpreg_to_list(gpointer key, gpointer opaque)
+static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
     uint32_t regidx = (uintptr_t)key;
-    const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+    const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
@@ -242,61 +242,49 @@ static void add_cpreg_to_list(gpointer key, gpointer opaque)
     }
 }
 
-static void count_cpreg(gpointer key, gpointer opaque)
+static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
-    const ARMCPRegInfo *ri;
-
-    ri = g_hash_table_lookup(cpu->cp_regs, key);
+    const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_array_len++;
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b, gpointer d)
-{
-    uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
-    uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
-
-    if (aidx > bidx) {
-        return 1;
-    }
-    if (aidx < bidx) {
-        return -1;
-    }
-    return 0;
-}
-
 void init_cpreg_list(ARMCPU *cpu)
 {
     /*
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
      * Note that we require cpreg_tuples[] to be sorted by key ID.
      */
-    GList *keys;
     int arraylen;
 
-    keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
-
     cpu->cpreg_array_len = 0;
-
-    g_list_foreach(keys, count_cpreg, cpu);
+    g_hash_table_foreach(cpu->cp_regs, count_cpreg, cpu);
 
     arraylen = cpu->cpreg_array_len;
-    cpu->cpreg_indexes = g_new(uint64_t, arraylen);
-    cpu->cpreg_values = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
+    if (arraylen) {
+        cpu->cpreg_indexes = g_new(uint64_t, arraylen);
+        cpu->cpreg_values = g_new(uint64_t, arraylen);
+        cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
+        cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
+    } else {
+        cpu->cpreg_indexes = NULL;
+        cpu->cpreg_values = NULL;
+        cpu->cpreg_vmstate_indexes = NULL;
+        cpu->cpreg_vmstate_values = NULL;
+    }
+    cpu->cpreg_vmstate_array_len = arraylen;
     cpu->cpreg_array_len = 0;
 
-    g_list_foreach(keys, add_cpreg_to_list, cpu);
+    g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
 
     assert(cpu->cpreg_array_len == arraylen);
 
-    g_list_free(keys);
+    if (arraylen) {
+        qsort(cpu->cpreg_indexes, arraylen, sizeof(uint64_t), compare_u64);
+    }
 }
 
 bool arm_pan_enabled(CPUARMState *env)
-- 
2.43.0


