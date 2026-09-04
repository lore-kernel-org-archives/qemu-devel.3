Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CFAC79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5c-0004VX-9r; Fri, 04 Sep 2026 16:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5Z-0004CH-Hw
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5X-0008JW-JU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYUW7mTarKGtGHB/ejRnCer72Bim5gXX0iKigt43Ozg=;
 b=Av65GRyiRoeP8bprMuet3BJxlXYndv+R+2ML4xGsLAI9K6LnFVS/6+gs5TGiiE/ZIp4rm0
 ow9EQ+7MpRWpNuGJOkPKBPHlILOL/Wlj4PhCZnJpVTxG8I+0h1BJsn2LGg7SHmM0tZAXnr
 oJaTLeiYTWY54OT/HK6ab3JjkXZ0ljg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-IE0eJQ6aP9i2C852AHkJ9Q-1; Fri,
 04 Sep 2026 16:00:35 -0400
X-MC-Unique: IE0eJQ6aP9i2C852AHkJ9Q-1
X-Mimecast-MFC-AGG-ID: IE0eJQ6aP9i2C852AHkJ9Q_1788552034
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E7918DA5CC; Fri,  4 Sep 2026 20:00:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EB421955F0D; Fri,  4 Sep 2026 20:00:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:23 +0400
Subject: [PATCH v4 40/75] ppc/pnv: fix phb-id and chip-id properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-40-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HSkTvfNSirJIc6SiW+8atmYUto98Bd95oCUMIIDC048=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKbG5aF8MftcPJE5LCqW1H0ulVHREG3uHG0
 78ZIvzz3oGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5epdD/9OUpWstLrqTe3EqqoY4Uq7B5kLIz5m40Pkyajq0hxGn9972Oyo2cMhQ3/d64IxMThNlLx
 WLIzjh43z3T2JBOAN78WMtlOebNLA83BAAdNfbAb9ACV2nCrCWL7kde3+rO2ttmWWbgFZcXYdI2
 bOmd9ioiUOdgKAOdJeSqpciaaDQeODHCUIqd2u23XVFUraxRpT/QM2fuc0d7ObRb2rTjOJpMGrj
 uoTpXZr+YZX2wD1+OiBWalwi9aEN0G9bTxFoCE+wtAs69JzpiMfihofQcJNkEFqpF3pNI9yohJ1
 BYiwBChM53UzDt2zJ1MJo8tkMVFptnDbXNZnsfnuoraJoGKw4Tra66x8B8Yb3yRIhkHTTQZI82F
 +jroYPwBV6JKdR7tro6SiSoV2m03HR+vgr3MWD3Cr22Uh8h7r+U703JLt/jQCD6AaB9LyhYIsuz
 zj6sOmGdn4IdskoF/bKxPIKHsWG4WWF+pBgMWhlrU6C28ZDPa5YmmuU8ZwVIaLpNi/MSHwUUpCR
 WJf/JIk/CocnC3c+4mW3iOICW/qlr8UqeQdlKmvOyVpepjd/g8eHfl2v+vMD2mQM8MBQQM+ic55
 JQE2p5A+7BTd95v817fGtQmsBaVhCeuNwI1NcrA8Ob2APadp/zAyw43q/MI+Rfo9HcQ2dAEPoei
 Tan43nzlSIdsJNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The getter and setter use visit_type_size, not visit_type_int.
Since the underlying type is uint32, switch to that.

Fixes: 8ec1e4f1ef97 ("ppc/pnv: add phb-id/chip-id PnvPHB3RootBus properties")
Fixes: b7c1750dc440 ("ppc/pnv: add phb-id/chip-id PnvPHB4RootBus properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/pnv_phb3.c | 12 ++++++------
 hw/pci-host/pnv_phb4.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 4ffdb4ce31ae..db061c134e95 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1130,7 +1130,7 @@ static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
                                        void *opaque, Error **errp)
 {
     PnvPHB3RootBus *bus = PNV_PHB3_ROOT_BUS(obj);
-    uint64_t value = 0;
+    uint32_t value = 0;
 
     if (strcmp(name, "phb-id") == 0) {
         value = bus->phb_id;
@@ -1138,7 +1138,7 @@ static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
         value = bus->chip_id;
     }
 
-    visit_type_size(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void pnv_phb3_root_bus_set_prop(Object *obj, Visitor *v,
@@ -1147,9 +1147,9 @@ static void pnv_phb3_root_bus_set_prop(Object *obj, Visitor *v,
 
 {
     PnvPHB3RootBus *bus = PNV_PHB3_ROOT_BUS(obj);
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_size(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
@@ -1164,12 +1164,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "uint32",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "uint32",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf074f..9acaf4c0c2f5 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1727,7 +1727,7 @@ static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
                                        void *opaque, Error **errp)
 {
     PnvPHB4RootBus *bus = PNV_PHB4_ROOT_BUS(obj);
-    uint64_t value = 0;
+    uint32_t value = 0;
 
     if (strcmp(name, "phb-id") == 0) {
         value = bus->phb_id;
@@ -1735,7 +1735,7 @@ static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
         value = bus->chip_id;
     }
 
-    visit_type_size(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void pnv_phb4_root_bus_set_prop(Object *obj, Visitor *v,
@@ -1744,9 +1744,9 @@ static void pnv_phb4_root_bus_set_prop(Object *obj, Visitor *v,
 
 {
     PnvPHB4RootBus *bus = PNV_PHB4_ROOT_BUS(obj);
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_size(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
@@ -1761,12 +1761,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "uint32",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "uint32",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


