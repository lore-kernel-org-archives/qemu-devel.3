Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944FFCD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOH-0002AN-3S; Sat, 06 Jun 2026 01:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOC-00029H-4B
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOA-0008D1-PM
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMU+/9kJPvBI6+rr+qjuUE2o/XCGiPk1vWq0Y33MHrs=;
 b=GT3fMUNjigFa9qVTFKjprTKlGiBk15Kq06OOk2OpAAhMOzIWCXHMM8XrG44rg92dbhyRJE
 iz47C1qCOm+KBVwLiJmPNLS0OiJQXQt/+xdoyNVYlDUarYVzlxhAgVIuR1UABoJgWvGnEK
 INUzvuWOMD698hzoKmjlnKmHNtzGfQU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-wFDvO_4uN8e8Cz_iQtfPaw-1; Sat,
 06 Jun 2026 01:16:02 -0400
X-MC-Unique: wFDvO_4uN8e8Cz_iQtfPaw-1
X-Mimecast-MFC-AGG-ID: wFDvO_4uN8e8Cz_iQtfPaw_1780722962
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D35C180044D
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB2251955BC0; Sat,  6 Jun 2026 05:16:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:36 +0400
Subject: [GIT PULL v2 04/23] hw/pci-host/i440fx: handle NULL bus in
 pci-hole64 getters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-4-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OVF9SYpNWrlV6USrd7t5agr6GhrxgYTzZ+VWk9J0k8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0r+HxpBIe+U43NaxusRL10a5nAxAty9WCY
 sZL8yNIiPaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5ZCTD/0U7ma8QVhoVM4EZ7ZTZ3bvto4ldeL/GI3Z7UA8OLDnLpB2zKKb23aE5lKNMWkn5ya78jJ
 2BwJ+jxaugaA8ny+PkcqFUpGf0SSwUTEYZOquJcngrH3XP60AIPxaFB0Z3XeGHQPlBgrBdNVYxH
 dTlc2xmoS0FqR5kI89j1yJtlTppg8otZreV6Dpyf6U91XYkGvgpI8V03873tB2CEjNA9nEf4ioL
 xqx9Fc3JQozAYYVxvUaTxlvYmlK9FPmADroCEA1wu4EwsxLioYHlxBqcCC5RhxdbZTqGd8j6yl8
 BLOQ3p4UQDtrCtwTHUjHe1O5QVLnuKYPpYFAAwYB4aiwe+6qdFY/vC/uN/4rtTkJHrvsrFnWPVW
 9ixelYAfIBjB3zKVD7Zyi+UMHCt+t8kmSr/mspVbgb7CHy8E/CD5yNqA9px16uGN0MLny6j5tHD
 hj3PCOHICk/OGcpE5CcTOinWAdyf1poitPEeoBVYhVXTwYt49O87zzlAS1sbOoF9XBPPA3tb2W/
 wCTm6ECgHhY6pME76xK+vhbI0P7rG4qQhVf1EWWpeVPDOhTkmAQ0QbuDLG28o+0Nr4pA5EnDTUK
 N4CsuGfF0r5yO6jrx373NR49xtjXbqpeGYdmrzAMgHC1Rk9FJf+gZsll7I3aXPi/ZtkFE/jGV2Y
 hp3n6rfSHeNQreg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


