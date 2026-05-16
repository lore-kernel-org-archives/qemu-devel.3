Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E9FCD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9w9-0004zg-6T; Sat, 16 May 2026 03:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vr-0004yN-CN
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vp-00072L-Vz
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IYlECDaFjyC5jMVbOlYMcyFWCuAkt4a7pbuaTwHsVc=;
 b=iFqpgO6/atjdgUKp/0bee5twt2d0012t2FEAXHAT2Dze+f8EdIBU90v5ljG3YwYh5F/GKC
 rYCmv/upDT2VEac2iEPHLX5HjCTwSBBWFwbJ+Zkgo4ov5+hS7QJsXgUS4MWkJpjCu5IakS
 fxkU1nTpb7yMb6wYaq9cP6gQ933/Cws=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-BdSJBFriNyyIM04i0EcB0w-1; Sat,
 16 May 2026 03:59:30 -0400
X-MC-Unique: BdSJBFriNyyIM04i0EcB0w-1
X-Mimecast-MFC-AGG-ID: BdSJBFriNyyIM04i0EcB0w_1778918369
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90284195608B
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66C0830001A2; Sat, 16 May 2026 07:59:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:01 +0400
Subject: [PATCH v3 02/24] hw/pci: handle missing bus in prop_pci_busnr_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-2-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gv49yL0vZomasnhGHVDQr9t1aDIXOgAlYIxo7kT+4zQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPO75N7NTnEd+YD7W/C9SpWznUVWfkMZWUiW
 +DKusUdnyOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzgAKCRDa6OEJdZac
 5V/SD/9/QcpeTRMQY1+X4+ozKJovcz2mYY9XJNGXJ6NXvfzimJ/BDccxMTu6dpphZLHUBFgFvyL
 3g6HIlBYm3yMe+basiKE8xGLhmBWilvO1T90qpHLzJK16hYoI2pVuviljFrjJED1spbPUycXmYF
 Dv6g4kLlT9ahuDDYodpSUnQaAYsUoRuszJ7H/aimI1npIzldY7KbcplPH12dtWx0J8fAUQADBDx
 FpsUxtp/6HibXEjk18RIfO0em04xdxu1WXCP6gajZiQi9b3rB5BtLKm8a3O9wIXiXT0yuGoMJqd
 E0cNSzQFAYLgr2fLCr1Mh0jEc4IPBsKHJX6X2bejdewSsXN19+3c04ZMDkq2Fty2TH6feWeumz5
 ohbciol87hYZRjyQ6yzf1/A1ifH90egT2lt8+BpG9GV+p2lgtGjewEWCXAUQGSfTqbMd+RASZkh
 gdhkCeWw/BeNvFUT5HE0XIZoVyY2Xns0K19KR+wkQbzdAyV/MZzaoAZvMfnsk31VwBoyGU39ce6
 tIEgdU391rN29tyx1B2Juj6IB8ZMLpIgycSPeZJT8U1pEzkOdYr2dTzon2qKQJ8EI6TXHMKJFI6
 DQ624Bk9J0rwmVgOhtoe+pL3dES3dXh+5RQoYuPjXedGysf8ExeDF7KnLL9bGsuFhwOiJ9iSHmY
 M0/4MlCoz8ynh8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


