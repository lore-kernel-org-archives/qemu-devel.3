Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00093CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWiz-0004Rs-Si; Fri, 05 Jun 2026 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWit-0004Qy-9d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWir-0005qR-JP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHaYJTnNXtnP4r58RbVBZ5CHW50pjzFA4v+h6Y0CfyA=;
 b=i1wxzaYCzbCktlCzxO/o1fktJmE5/tbD8XdkJxcHH8l4/TpFbI7tMiMrs6EWuSs1vlpaLs
 dn8zx2xM6bHrGwwTNHElxmpzy24CaC+DF2C2xnDwSz38sH0sHcGUL6K3o4YjZnkT9DUZHh
 HDapu0NLBY0Yjgpx6OXB+1DRFRIPUcY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-_TAwq55lOpSTf6mi1j8PyA-1; Fri,
 05 Jun 2026 11:44:33 -0400
X-MC-Unique: _TAwq55lOpSTf6mi1j8PyA-1
X-Mimecast-MFC-AGG-ID: _TAwq55lOpSTf6mi1j8PyA_1780674272
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D65221800366
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C2FB180056E; Fri,  5 Jun 2026 15:44:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:21 +0400
Subject: [GIT PULL 01/23] hw/pci: handle missing bus in prop_pci_busnr_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-1-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6du0B3+bTyiu/gIbq11MHIRY6wGGJJ3yX28+ndrVGuE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7USACf/VSGqmQILNlbi8RPurSEMGSIuzAuB
 G4tcICumyuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5a/4EAC7LU8zvluP5UzzTOnWDY820reqEDPvnFvQHSqHMnfapnQ7b05aavf1tgGeDg81qYSZC7Z
 wiIZpgg9ubXjOrKXipc+bA02jSqW2ArXQWPK944zv1C/JrLIEq6k0iEtrQXRNf0ILAQld9hJ+mU
 WTsGzzVzCUuaMnTr42cl/osSZcyADROcE07oVq2bMWoT6nu3AUHj9lrdrayb/KeWKzLg9121k+Y
 gU7gfvWgNsAYQe66U7t6z363vErKU5DTZlVodVNcROifAYZjOBVJrGTGgbdCYqhjazhB0i1hLQf
 KRHPjYfWlayzQok3Z77Q7pzeO5BANQFlqNoEWDURkHiH4ME8dX+6FtIjissnW7bmU/07NddO5gY
 tHpBvjcqXRNje6nfjOzq3/5Q6FhMpjO3f9Z83vr84eMrmQ040DfVSoZf6r7zagBrk84pbt8PgHK
 cF/SAIalnYFVFVnhsOaCzJxlL56ejZVwYbiLanbctG5u1UWmHGnqF0vkHLZdquFHd/dOkAxFPnh
 mrq6z5nTG9hovK6XogbVqL9zHdbtFZJH3IpthKUAJew0OUrNZNAMk3SiYlrp0UYkJR/t2/kjtpJ
 7FdeMoJ+oeuxl1faMDhUgFmsplwPoVwYXFcxqKgqCB9EC4xr0pfWZj/AZudNSLHg2zJ7eP7Hy4s
 28lQz8euRas9UVA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When called on an unrealized device (e.g. from
qmp_qom_list_properties), pci_get_bus() returns NULL since the device
has no parent bus. Check for this to avoid a NULL dereference in
pci_bus_num().

Fixes: df9ac7254fd9 ("hw/pci: Add a busnr property to pci_props and use for acpi/gi")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4298adf5a0a..cec065d108f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,10 +64,17 @@ static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
+                               void *opaque, Error **errp)
 {
-    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PCIBus *bus = pci_get_bus(dev);
+    uint8_t busnr;
 
+    if (!bus) {
+        error_setg(errp, "device not attached to a PCI bus");
+        return;
+    }
+    busnr = pci_bus_num(bus);
     visit_type_uint8(v, name, &busnr, errp);
 }
 

-- 
2.54.0


