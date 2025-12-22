Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DC6E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 05:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXYsx-0003sZ-TD; Mon, 22 Dec 2025 00:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vXYst-0003rA-Oj
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vXYsp-0004eB-RI
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 00:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766382901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ExaxCKD8rTO0elI1Sno4pWuINzRFrDH7sz7G3F5Jg90=;
 b=XrWqoKaxXWh5mdEEVadG0X3mLaHYu1G9IZS23TP/VBWRTZghU9jPWjCKglh1aNXjAuowMy
 bkSCtY/cJum4P837xrJGYUfBslbFJdgCetE273FPhhAwLG8Y7g++7M7DKGZqG6J9tU+QkL
 8qaRj+hhslHlhJuq4eVjdbQzmxCDmVY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-YNLLEGbaNRi7dYe34mRA1w-1; Mon, 22 Dec 2025 00:53:46 -0500
X-MC-Unique: YNLLEGbaNRi7dYe34mRA1w-1
X-Mimecast-MFC-AGG-ID: YNLLEGbaNRi7dYe34mRA1w_1766382826
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0f0c7a06eso71128655ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766382825; x=1766987625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExaxCKD8rTO0elI1Sno4pWuINzRFrDH7sz7G3F5Jg90=;
 b=Ew3H/vwU0iQWc9et6qGq2gRiIAb9dnGqCVlZ7lSNxTCW9pF6iDj0+XG7d+Cnx9SCYY
 RVYMpQCVMqPaVun8BavhNlgjyjLdOnQWaaw3WsapLXFkpZHAebNUYgZpA/qwnQSrVV3G
 S642Ppnj3IMMMniwkp9R/5khzzWfC75rluc4UlhtaU7Vnq3P0MwSddI25aR4hk02+i1W
 d1fHsuHhgoCn89p9Um0IqLjfTlvBdq601em0oQS5pJ47D92131UkHHMSjb5tEtFMDvjO
 /I9m/HHVfLLAsP4iAbvWK9vpoXwaueV7XgcncGtZD+IfPU7y7FoqrAdeyarBW32w5bpr
 vmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766382825; x=1766987625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExaxCKD8rTO0elI1Sno4pWuINzRFrDH7sz7G3F5Jg90=;
 b=i0es/SZg1kjyrFnjC+yt8Jxc+i7LhZ6Wlz5VcQJn58/vuPtS1859RBpDwej9euk8Rj
 P792NuiYIXmaEv7zoHM4plE/lCUWmqHEyWa6JizxEcX2fqop+nDcu2t1Ty9PCVMcn5K5
 0Z+VS7e9zPyJws3NYmSD3Fyok/I/UDfwDtnfDzanOL+6iIk0a8vvAQJ3+ihxXuhafVx0
 xLMrIcEOhlt0EqkRQLOoRSQnl7DbW1FqxqmUJqDCLehiEWx6mVn3LQscb1FW1pIr+GxN
 hh4SSTHBSuMH2Drc7WBsnjF9v8iw0qHRjZRQYCrsLbgicOBke4GNctT/iM5E9TkPimys
 L2sg==
X-Gm-Message-State: AOJu0Yy3MrLT0DxqnR8EWYMW4FFRq7FGqn3JZt8odNCMg27vncW2vEoO
 fhCKLSEG5eE14P7DWSkf4GumraOmLhLEsnZNmKfOD6VrEZVsZ36RiQA/fX8oc9ZLsxrODpx2c5A
 bqtoTHUIqDV9DVfHIWboHVU+g7/QrULMY8zaco3+qiFqHg7uYQGXhSHIbqWaWm3TWqmEVDxU+s7
 TCYd2wA8N68Al88htMOUi9zBPemAsmhzxgcqqDP3U=
X-Gm-Gg: AY/fxX5+l4FjDNqhm8GYVZJYR0eqSf44a5yL1BiFnd+QAfycD7YZK+Ok29gskd7Z57b
 SJZp2sAziV98wXqsbEVVr5rKjX3dNEtllU2ZnjGrzKuZ42ZL/WFrWyxMrwCLgrVT5BOkPXTpQzi
 ICkPAeXYtxa7Zjj1JAtMOmxKiAOrZG4U5jqhyJbslpRh/nJ5GAthxAZ6NFWBIE8H6qTi2DVhDEs
 B/qng/oRZM71yPmov6Ki+Kf2j2/qd6zkP+zg+pQ9isllsUD+T7wXHdC+4vEn0q89G+uT3e13TsS
 e0LFd1umwgJXWR3pbV4PPerpI9CICMczZjDV9Qe5EEIewpBmndqyw3ktxx/p3DZ36bLfJzf4iuQ
 QA/HcrnQXnKEXjQR3NonCwVZta9fGel5bqfv0cg8=
X-Received: by 2002:a05:7022:6708:b0:119:e569:fbb4 with SMTP id
 a92af1059eb24-12172301f84mr10985931c88.35.1766382825111; 
 Sun, 21 Dec 2025 21:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnZxZYahjHNuLaVbtUUEqxVyizHm1l8MWTKrLP/N5DeCvRlj4CdYT7Yh5pLnkVqoFsGlnlVw==
X-Received: by 2002:a05:7022:6708:b0:119:e569:fbb4 with SMTP id
 a92af1059eb24-12172301f84mr10985904c88.35.1766382824527; 
 Sun, 21 Dec 2025 21:53:44 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217254d369sm42898817c88.16.2025.12.21.21.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 21:53:44 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Chandan Somani <csomani@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-arm@nongnu.org (open list:Stellaris)
Subject: [PATCH] qdev: Free property array on release
Date: Sun, 21 Dec 2025 21:50:05 -0800
Message-ID: <20251222055009.1050567-1-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Before this patch, users of the property array would free the
array themselves in their cleanup functions. This causes
inconsistencies where some users leak the array and some free them.

This patch makes it so that the property array's release function
frees the property array (instead of just its elements). It fixes any
leaks and requires less code.

Signed-off-by: Chandan Somani <csomani@redhat.com>
---
 block/accounting.c                |  1 -
 hw/core/qdev-properties.c         | 20 ++++++++++----------
 hw/input/stellaris_gamepad.c      |  8 --------
 hw/intc/arm_gicv3_common.c        |  8 --------
 hw/intc/rx_icu.c                  |  8 --------
 hw/misc/arm_sysctl.c              |  2 --
 hw/misc/mps2-scc.c                |  8 --------
 hw/net/rocker/rocker.c            |  1 -
 hw/nvram/xlnx-efuse.c             |  8 --------
 hw/nvram/xlnx-versal-efuse-ctrl.c |  8 --------
 10 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index 0933c61f3a..5cf51f029b 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -73,7 +73,6 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_invalid,
             }
             block_acct_add_interval(stats, stats_intervals[i]);
         }
-        g_free(stats_intervals);
     }
     return true;
 }
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0930d64252..455c28535a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -673,10 +673,8 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
 
 /*
  * Object property release callback for array properties: We call the
- * underlying element's property release hook for each element.
- *
- * Note that it is the responsibility of the individual device's deinit
- * to free the array proper.
+ * underlying element's property release hook for each element and free the
+ * property array.
  */
 static void release_prop_array(Object *obj, const char *name, void *opaque)
 {
@@ -686,14 +684,16 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
     char *elem = *arrayptr;
     int i;
 
-    if (!prop->arrayinfo->release) {
-        return;
+    if (prop->arrayinfo->release) {
+        for (i = 0; i < *alenptr; i++) {
+            Property elem_prop = array_elem_prop(obj, prop, name, elem);
+            prop->arrayinfo->release(obj, NULL, &elem_prop);
+            elem += prop->arrayfieldsize;
+        }
     }
 
-    for (i = 0; i < *alenptr; i++) {
-        Property elem_prop = array_elem_prop(obj, prop, name, elem);
-        prop->arrayinfo->release(obj, NULL, &elem_prop);
-        elem += prop->arrayfieldsize;
+    if (*arrayptr) {
+        g_free(*arrayptr);
     }
 }
 
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index fec1161c9c..207064dacb 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -63,13 +63,6 @@ static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
     qemu_input_handler_register(dev, &stellaris_gamepad_handler);
 }
 
-static void stellaris_gamepad_finalize(Object *obj)
-{
-    StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
-
-    g_free(s->keycodes);
-}
-
 static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
@@ -98,7 +91,6 @@ static const TypeInfo stellaris_gamepad_info[] = {
         .name = TYPE_STELLARIS_GAMEPAD,
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(StellarisGamepad),
-        .instance_finalize = stellaris_gamepad_finalize,
         .class_init = stellaris_gamepad_class_init,
     },
 };
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2d0df6da86..26d694d2ab 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -488,13 +488,6 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->itslist = g_ptr_array_new();
 }
 
-static void arm_gicv3_finalize(Object *obj)
-{
-    GICv3State *s = ARM_GICV3_COMMON(obj);
-
-    g_free(s->redist_region_count);
-}
-
 static void arm_gicv3_common_reset_hold(Object *obj, ResetType type)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
@@ -644,7 +637,6 @@ static const TypeInfo arm_gicv3_common_type = {
     .instance_size = sizeof(GICv3State),
     .class_size = sizeof(ARMGICv3CommonClass),
     .class_init = arm_gicv3_common_class_init,
-    .instance_finalize = arm_gicv3_finalize,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index f8615527b7..85da0624f6 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -334,13 +334,6 @@ static void rxicu_init(Object *obj)
     sysbus_init_irq(d, &icu->_swi);
 }
 
-static void rxicu_fini(Object *obj)
-{
-    RXICUState *icu = RX_ICU(obj);
-    g_free(icu->map);
-    g_free(icu->init_sense);
-}
-
 static const VMStateDescription vmstate_rxicu = {
     .name = "rx-icu",
     .version_id = 1,
@@ -382,7 +375,6 @@ static const TypeInfo rxicu_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RXICUState),
     .instance_init = rxicu_init,
-    .instance_finalize = rxicu_fini,
     .class_init = rxicu_class_init,
 };
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 0f4e37cd47..e715ff9475 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -618,9 +618,7 @@ static void arm_sysctl_finalize(Object *obj)
 {
     arm_sysctl_state *s = ARM_SYSCTL(obj);
 
-    g_free(s->db_voltage);
     g_free(s->db_clock);
-    g_free(s->db_clock_reset);
 }
 
 static const Property arm_sysctl_properties[] = {
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index a9a5d4a535..acb0f5773b 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -405,13 +405,6 @@ static void mps2_scc_realize(DeviceState *dev, Error **errp)
     s->oscclk = g_new0(uint32_t, s->num_oscclk);
 }
 
-static void mps2_scc_finalize(Object *obj)
-{
-    MPS2SCC *s = MPS2_SCC(obj);
-
-    g_free(s->oscclk_reset);
-}
-
 static bool cfg7_needed(void *opaque)
 {
     MPS2SCC *s = opaque;
@@ -489,7 +482,6 @@ static const TypeInfo mps2_scc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MPS2SCC),
     .instance_init = mps2_scc_init,
-    .instance_finalize = mps2_scc_finalize,
     .class_init = mps2_scc_class_init,
 };
 
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index cc49701dd3..cbc7bd3ed9 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1429,7 +1429,6 @@ static void pci_rocker_uninit(PCIDevice *dev)
             world_free(r->worlds[i]);
         }
     }
-    g_free(r->fp_ports_peers);
 }
 
 static void rocker_reset(DeviceState *dev)
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 4c23f8b931..1875fdb953 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -224,13 +224,6 @@ static void efuse_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void efuse_finalize(Object *obj)
-{
-    XlnxEFuse *s = XLNX_EFUSE(obj);
-
-    g_free(s->ro_bits);
-}
-
 static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -288,7 +281,6 @@ static const TypeInfo efuse_info = {
     .name          = TYPE_XLNX_EFUSE,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XlnxEFuse),
-    .instance_finalize = efuse_finalize,
     .class_init    = efuse_class_init,
 };
 
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 6f17f32a0c..4d0c2c8404 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -724,13 +724,6 @@ static void efuse_ctrl_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
-static void efuse_ctrl_finalize(Object *obj)
-{
-    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
-
-    g_free(s->extra_pg0_lock_spec);
-}
-
 static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
     .version_id = 1,
@@ -767,7 +760,6 @@ static const TypeInfo efuse_ctrl_info = {
     .instance_size = sizeof(XlnxVersalEFuseCtrl),
     .class_init    = efuse_ctrl_class_init,
     .instance_init = efuse_ctrl_init,
-    .instance_finalize = efuse_ctrl_finalize,
 };
 
 static void efuse_ctrl_register_types(void)
-- 
2.51.1


