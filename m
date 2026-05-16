Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99D2CD4F47
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wU-0005Fx-9h; Sat, 16 May 2026 04:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wF-000526-19
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wB-00078r-8z
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRg2XEz7g/q9Y9vnBcCYZpcSu3GsBjF6YOxJNwlUUiA=;
 b=g5a/YeBKe6JMAegy7Ms6zSwT1pLPdVfCr80EDuzaFexvrIQ4IEQHbAN5AkzaEtGMz+1kDX
 Wo+urkXdoq0zEnpyIgs1qJN7Ro7scdQ2KcCrKXVWkjBvkS4KJB2E19nMJ/wA27bLN3NOFU
 0oK+6EL2ViNaaLzDlpaHB+pDamuV8ak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-0SVDDsLNPp2g1Ftsp5PR-A-1; Sat,
 16 May 2026 03:59:53 -0400
X-MC-Unique: 0SVDDsLNPp2g1Ftsp5PR-A-1
X-Mimecast-MFC-AGG-ID: 0SVDDsLNPp2g1Ftsp5PR-A_1778918392
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CB8518005B5
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F07C11800349; Sat, 16 May 2026 07:59:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:05 +0400
Subject: [PATCH v3 06/24] hw/pci-host/q35: handle NULL bus in pci-hole64
 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-6-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/fxZ1GAbhmt7eqzcBY0CxzgAhlT5phl8zL1KjrOh2so=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPIeH4X224yNHmEd8YJ/5v87ASv1zzIvt5o
 +OwWBJwr1SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5QevD/41lPbr6eeziJVuAmRcHk3C/Kv6WsudLJXvc+YR2ZOCFGsfN81ATiK4HaAfNVzLDTpSzre
 2TDQcnGBblaFFgJNsfIY9FaNRXij6RclKiBLhwp2lczvFnhfGmM1pCFi7Ol5VUXuExXdOBzKlqK
 omjOa0B8Y1BXkuUaH8SHzs17bNLibE7KOyIRy0FMhh83oIao6K4GRGju+T0pqKV9OcHTD8NFFCD
 jwS2uyr6NXMkSy88AtBxaEeagei+vJpzvMVxBBOVVWTgcK+Hh+ag1x7f2d3DSYk3jL1eruNQJck
 hxBl9gZM/g4b2qTM/Imbrcu7RexeWXzk47xy/nqBRq95cdHRu78ExNnZG/oLFRbmcKF7noyRzuk
 DrJ/om+4QBPxpxTOF5jSOgaJwAz31bO+Bfct8mI++S45bi3DDS2aj3Yavu73wZOeHOI5rooBrPB
 xeS0u9pyH3XJDoND/Ku2rCif8mUoQRRIl476htRlW3hJpR49QPqveTvdEpwfmud1bQgbCoAzkGv
 i1EW0kzTgG08RoznsbJ0Whjz6O1V49NPIVYI67aOfWxIJ0XOfmdJ+9SmMDUE41dkl2glgEJN1r9
 +WnrGpE17YxkREIQqU5goDMRcL6F0z1OVHVBc04prl2ZCAPY7F5V4BsBCB64+8/OYFR4eG7F0t/
 8U/9/HjQjxZK8gg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When called on an unrealized Q35 host bridge (e.g. from
qmp_qom_list_properties), h->bus is NULL since the root bus is only
created during realize. Guard against this in both the
pci_hole64_start and pci_hole64_end getters.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/q35.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b37..355e81bfa20 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -132,8 +132,14 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     visit_type_uint64(v, name, &hole64_start, errp);
 }
 
@@ -149,10 +155,15 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
-    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+    uint64_t hole64_start;
     Range w64;
     uint64_t value, hole64_end;
 
+    if (!h->bus) {
+        error_setg(errp, "PCI host bridge not realized");
+        return;
+    }
+    hole64_start = q35_host_get_pci_hole64_start_value(obj);
     pci_bus_get_w64_range(h->bus, &w64);
     value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
     hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);

-- 
2.54.0


