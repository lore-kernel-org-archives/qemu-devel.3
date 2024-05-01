Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5099EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2EhS-0006Of-FO; Wed, 01 May 2024 14:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2EhR-0006NJ-97
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2EhP-0003LA-9M
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714588138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbNgJd5vjOzyPPQegoUm7fdN8mfz+bUzsuHGR1E6bVA=;
 b=YutCq2N4Amg35ex6TbogmSJwr+3EKNhhEqV2BnRBhAvPQcIsS8KvmjkgIeyhekQTLBLrVa
 sGmERYFCxM96Y5pL58fN045DrG2kMGI5oU9s8uUNX3bs5kZZUoUZdsfxNm7SvdbBubQ13s
 Jcc5oVdSquzVQvpFDNncrf01lgD6yAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-C4dxp_u-MzOdADPZ-Vrgcg-1; Wed, 01 May 2024 14:28:54 -0400
X-MC-Unique: C4dxp_u-MzOdADPZ-Vrgcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 395AD10498B9;
 Wed,  1 May 2024 18:28:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36D56AC6B;
 Wed,  1 May 2024 18:28:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/14] hw/ppc: convert 'spapr' machine definitions to use new
 macros
Date: Wed,  1 May 2024 19:27:49 +0100
Message-ID: <20240501182759.2934195-5-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This changes the DEFINE_SPAPR_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number twice in two different formats in the calls
to DEFINE_SPAPR_MACHINE.

A DEFINE_SPAPR_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Due to the odd-ball '2.12-sxxm' machine type version, this
commit introduces a DEFINE_SPAPR_MACHINE_TAGGED helper to
allow defining of "tagged" machine types which have a string
suffix.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ppc/spapr.c | 93 +++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d2d1e310a3..4ab331da57 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4788,26 +4788,35 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     mc->is_default = true;
 }
 
-#define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
-    static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
-                                                    void *data)      \
+#define DEFINE_SPAPR_MACHINE_IMPL(latest, ...)                       \
+    static void MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__)(     \
+        ObjectClass *oc,                                             \
+        void *data)                                                  \
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
-        spapr_machine_##suffix##_class_options(mc);                  \
+        MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
         if (latest) {                                                \
             spapr_machine_latest_class_options(mc);                  \
         }                                                            \
     }                                                                \
-    static const TypeInfo spapr_machine_##suffix##_info = {          \
-        .name = MACHINE_TYPE_NAME("pseries-" verstr),                \
+    static const TypeInfo MACHINE_VER_SYM(info, spapr, __VA_ARGS__) = \
+    {                                                                \
+        .name = MACHINE_VER_TYPE_NAME("pseries", __VA_ARGS__),       \
         .parent = TYPE_SPAPR_MACHINE,                                \
-        .class_init = spapr_machine_##suffix##_class_init,           \
+        .class_init = MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__), \
     };                                                               \
-    static void spapr_machine_register_##suffix(void)                \
+    static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
-        type_register(&spapr_machine_##suffix##_info);               \
+        type_register(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
     }                                                                \
-    type_init(spapr_machine_register_##suffix)
+    type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
+
+#define DEFINE_SPAPR_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_SPAPR_MACHINE_IMPL(true, major, minor)
+#define DEFINE_SPAPR_MACHINE(major, minor) \
+    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
+#define DEFINE_SPAPR_MACHINE_TAGGED(major, minor, tag) \
+    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor, _, tag)
 
 /*
  * pseries-9.1
@@ -4817,7 +4826,7 @@ static void spapr_machine_9_1_class_options(MachineClass *mc)
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE(9_1, "9.1", true);
+DEFINE_SPAPR_MACHINE_AS_LATEST(9, 1);
 
 /*
  * pseries-9.0
@@ -4828,7 +4837,7 @@ static void spapr_machine_9_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(9_0, "9.0", false);
+DEFINE_SPAPR_MACHINE(9, 0);
 
 /*
  * pseries-8.2
@@ -4839,7 +4848,7 @@ static void spapr_machine_8_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_2, "8.2", false);
+DEFINE_SPAPR_MACHINE(8, 2);
 
 /*
  * pseries-8.1
@@ -4850,7 +4859,7 @@ static void spapr_machine_8_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_1, "8.1", false);
+DEFINE_SPAPR_MACHINE(8, 1);
 
 /*
  * pseries-8.0
@@ -4861,7 +4870,7 @@ static void spapr_machine_8_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_0, "8.0", false);
+DEFINE_SPAPR_MACHINE(8, 0);
 
 /*
  * pseries-7.2
@@ -4872,7 +4881,7 @@ static void spapr_machine_7_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_2, "7.2", false);
+DEFINE_SPAPR_MACHINE(7, 2);
 
 /*
  * pseries-7.1
@@ -4883,7 +4892,7 @@ static void spapr_machine_7_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_1, "7.1", false);
+DEFINE_SPAPR_MACHINE(7, 1);
 
 /*
  * pseries-7.0
@@ -4894,7 +4903,7 @@ static void spapr_machine_7_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(7_0, "7.0", false);
+DEFINE_SPAPR_MACHINE(7, 0);
 
 /*
  * pseries-6.2
@@ -4905,7 +4914,7 @@ static void spapr_machine_6_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(6_2, "6.2", false);
+DEFINE_SPAPR_MACHINE(6, 2);
 
 /*
  * pseries-6.1
@@ -4920,7 +4929,7 @@ static void spapr_machine_6_1_class_options(MachineClass *mc)
     mc->smp_props.prefer_sockets = true;
 }
 
-DEFINE_SPAPR_MACHINE(6_1, "6.1", false);
+DEFINE_SPAPR_MACHINE(6, 1);
 
 /*
  * pseries-6.0
@@ -4931,7 +4940,7 @@ static void spapr_machine_6_0_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(6_0, "6.0", false);
+DEFINE_SPAPR_MACHINE(6, 0);
 
 /*
  * pseries-5.2
@@ -4942,7 +4951,7 @@ static void spapr_machine_5_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(5_2, "5.2", false);
+DEFINE_SPAPR_MACHINE(5, 2);
 
 /*
  * pseries-5.1
@@ -4956,7 +4965,7 @@ static void spapr_machine_5_1_class_options(MachineClass *mc)
     smc->pre_5_2_numa_associativity = true;
 }
 
-DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
+DEFINE_SPAPR_MACHINE(5, 1);
 
 /*
  * pseries-5.0
@@ -4975,7 +4984,7 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
     smc->pre_5_1_assoc_refpoints = true;
 }
 
-DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
+DEFINE_SPAPR_MACHINE(5, 0);
 
 /*
  * pseries-4.2
@@ -4992,7 +5001,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
     mc->nvdimm_supported = false;
 }
 
-DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
+DEFINE_SPAPR_MACHINE(4, 2);
 
 /*
  * pseries-4.1
@@ -5012,7 +5021,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
+DEFINE_SPAPR_MACHINE(4, 1);
 
 /*
  * pseries-4.0
@@ -5039,7 +5048,7 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
     smc->pre_4_1_migration = true;
 }
 
-DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
+DEFINE_SPAPR_MACHINE(4, 0);
 
 /*
  * pseries-3.1
@@ -5061,7 +5070,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
 }
 
-DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
+DEFINE_SPAPR_MACHINE(3, 1);
 
 /*
  * pseries-3.0
@@ -5079,7 +5088,7 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
     smc->irq = &spapr_irq_xics_legacy;
 }
 
-DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
+DEFINE_SPAPR_MACHINE(3, 0);
 
 /*
  * pseries-2.12
@@ -5104,7 +5113,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
 }
 
-DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
+DEFINE_SPAPR_MACHINE(2, 12);
 
 static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 {
@@ -5116,7 +5125,7 @@ static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_FIXED_CCD;
 }
 
-DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false);
+DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
 
 /*
  * pseries-2.11
@@ -5132,7 +5141,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
-DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
+DEFINE_SPAPR_MACHINE(2, 11);
 
 /*
  * pseries-2.10
@@ -5144,7 +5153,7 @@ static void spapr_machine_2_10_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
 }
 
-DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
+DEFINE_SPAPR_MACHINE(2, 10);
 
 /*
  * pseries-2.9
@@ -5164,7 +5173,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
 
-DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
+DEFINE_SPAPR_MACHINE(2, 9);
 
 /*
  * pseries-2.8
@@ -5182,7 +5191,7 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
     mc->numa_mem_align_shift = 23;
 }
 
-DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
+DEFINE_SPAPR_MACHINE(2, 8);
 
 /*
  * pseries-2.7
@@ -5257,7 +5266,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
     smc->phb_placement = phb_placement_2_7;
 }
 
-DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
+DEFINE_SPAPR_MACHINE(2, 7);
 
 /*
  * pseries-2.6
@@ -5275,7 +5284,7 @@ static void spapr_machine_2_6_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
+DEFINE_SPAPR_MACHINE(2, 6);
 
 /*
  * pseries-2.5
@@ -5294,7 +5303,7 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
-DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
+DEFINE_SPAPR_MACHINE(2, 5);
 
 /*
  * pseries-2.4
@@ -5309,7 +5318,7 @@ static void spapr_machine_2_4_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
 }
 
-DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
+DEFINE_SPAPR_MACHINE(2, 4);
 
 /*
  * pseries-2.3
@@ -5324,7 +5333,7 @@ static void spapr_machine_2_3_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
+DEFINE_SPAPR_MACHINE(2, 3);
 
 /*
  * pseries-2.2
@@ -5341,7 +5350,7 @@ static void spapr_machine_2_2_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
 }
-DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
+DEFINE_SPAPR_MACHINE(2, 2);
 
 /*
  * pseries-2.1
@@ -5352,7 +5361,7 @@ static void spapr_machine_2_1_class_options(MachineClass *mc)
     spapr_machine_2_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);
 }
-DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
+DEFINE_SPAPR_MACHINE(2, 1);
 
 static void spapr_machine_register_types(void)
 {
-- 
2.43.0


