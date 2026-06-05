Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B883CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWj9-0004Uk-4G; Fri, 05 Jun 2026 11:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWj8-0004UP-35
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWj5-0005u6-KC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMU+/9kJPvBI6+rr+qjuUE2o/XCGiPk1vWq0Y33MHrs=;
 b=dM+tuA+3CPPNUjLPCQLk7MzZOYhs58A0T/ji8TYjH0tkhgj11Wg6cvW1wQ2ssBiNF0kgRu
 d0AI+ay65Ny/B3AF+TRDlpoeewtkuTs1zMDI6qU6nj6c6DiesFTJFAQSvoUNux6GkWvRcg
 JsS3QFyYN1pz0cApUAKtHpYlhVC9pHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-MMBUFk_jPqOKe-5G9pOMLw-1; Fri,
 05 Jun 2026 11:44:49 -0400
X-MC-Unique: MMBUFk_jPqOKe-5G9pOMLw-1
X-Mimecast-MFC-AGG-ID: MMBUFk_jPqOKe-5G9pOMLw_1780674288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C2501956094
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:48 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 797DE18004D4; Fri,  5 Jun 2026 15:44:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:24 +0400
Subject: [GIT PULL 04/23] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-4-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OVF9SYpNWrlV6USrd7t5agr6GhrxgYTzZ+VWk9J0k8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7U8WhLRtfdVdEKgoWC+J+wXA98xptKvzxgX
 o3loMsIeR2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5ZsBD/48u9aSqkRqPL7mWf//NxeMl7nC9CGDc6wCp91NSBWfwCOVuGCL7CVasdhOEdfOCDO7dBs
 Au6tHY/Q2kKfblYK5gFXhYL0KNQFByeNKCLVojVo2XxO+hm2x917BzVPpyECd27sV/NHA9zGswv
 I+3qYcPhDAPyFhfxHzKeMRDRzGuGL4JmCJIw13kp7qeApEB67CsfqxkXphM+oC9f2A7kjuPj2l0
 ZNrCRqDU5UOfBGB+AD6KI4w7pfeL/rZdCfQ2HO55rWRNeRpFpxoZemQLMrqO3uz9KdFuGrIm3Wf
 k8x6p7zwA80epcDcTbsgbMqEvRctFM9QME2aa+Quk+BtoJLe8Z0fB0EEO7YMotwDye9AbpX4v7z
 2llV4yHoS/+W5fZl8pKYWg2QyfgyGfL7sXZIHWAqf54HuLJlDuEnlQp4mnsM4P2tEiAeEA4qb69
 cy/QW0PHRBwzYcadR60m3NOuhbVUGD67aaMPu9TODEaPwwC5ss29gdfowx0Wcj8C+iB11csv5ZR
 wCdF6WYEu0TW2Zp4ThdR0hnLdfK7BwE3IpVmQyjnGP8RGGdjvl5ZOFbxDVM5I2DNo2Sc2QDR20H
 ONozmS4koIrzgbCa6tLUD+adlu/4zKpkMr+FqjR32qSuciyT7e7suUwyq3ELzjuVVF9Oq/hGDYb
 XKsMzhoZ4IgwaMg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When called on an unrealized i440FX host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both
pci_hole64_start and pci_hole64_end getters, reporting an error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/pci-host/i440fx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index e7d638b296c..c1982f7962a 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -189,8 +189,14 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
                                                 const char *name,
                                                 void *opaque, Error **errp)
 {
-    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     visit_type_uint64(v, name, &hole64_start, errp);
 }
 
@@ -206,10 +212,15 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
+    uint64_t hole64_start;
     Range w64;
     uint64_t value, hole64_end;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);

-- 
2.54.0


