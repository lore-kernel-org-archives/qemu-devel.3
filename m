Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B4FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRqy-0000r2-2Q; Mon, 27 Apr 2026 15:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRql-0000pC-UF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRqk-0007ez-0u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNwbxYxWQ04sNy4bBLSed8SroTUWt0gC5fF5Xjj2gTA=;
 b=i+IZEjTPWOImh31CwMqoJOFdeBzksG2aEXXRxevtfFHHXuhq3eoEn6f+S1s1mFoFv7TcC+
 rMlb1J5vAnqjfYn2Lc76MUceFVPY4Dod1x2NBjJD1a9QxVgmYQY/RjJsrXzM1Sz13KtHac
 S25uFb0P9qjWa8OULYKkJMK2pvqniAI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-aXZnIwACP_CyMswST68e4g-1; Mon,
 27 Apr 2026 15:42:30 -0400
X-MC-Unique: aXZnIwACP_CyMswST68e4g-1
X-Mimecast-MFC-AGG-ID: aXZnIwACP_CyMswST68e4g_1777318950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00A461956089
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:42:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F3A11800664; Mon, 27 Apr 2026 19:42:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:00 +0400
Subject: [PATCH 01/41] hw/pci: handle missing bus in prop_pci_busnr_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-1-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=P8mQvnMK/kAJD5u8Y7BnOIAYXw5cBODLSGhSeHfU+Ug=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUCSpgafM7qyg1PvbrmiREBZP6oFhStmU2U
 tMJvXGTP9CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5XTqD/9CvkfW7mTllAvHZ2AT6f9GPWMs9EBtQEzZjBMTPmdJy2wbEVOOKeEwIWpSxGQPqt9ZqUV
 T0cTkQ3auWdpDBlycfhmpqugb6q+u1QZVlXA88J3nSGrXKRDXODy+t0L3j6mZchbhT2h9ZlN52D
 vgsi2Ch4ueqM8xrT39ec1PFzwRd4C9OPbWhwreS/PrX+SUirssX8MMEolodvH6yoX5Ytdh+gRtv
 aeYy7IKN8gIDRBAoPuIFd6MwwWk4KT0A76lDl0pd4dMCAYVoqgJKJ7zzxL92Ny3cMztFU1oQpLN
 +0aodTrLuSIcA53sWxsFEJb3bqAFoAEEeT31GbomLDDDa/p7mVsb3Se/LuV9mAD2omY3ZbzwUSl
 lHYCHdVySrqv3PUITuwyrpxmuion5UGJ/bouN+oxn0Tots8BgzcTdBaqObd57hTFTf+ljg4QLEI
 4OGGGFHjjpZ8LP5sYZA22vNLP94Cl+wXW7JA7ch/1iWCwZLJhMC6ftDLP1jhlAAbCDh2BEOwSJ1
 I9RFHew3jMWG7kYscKJH5LEy3gqKrcof70DH119fvOV26ik5cjvjILiakQWIUy1HZEj58MfX9cZ
 sXmqarT4Yn21o8bAgSFq/lx04J9Dq9Xi3+/MeVpHWCuisQONlnbN31J6u2A0HfE5cfjt1q9fC2a
 CNS+/Mbrn6PxdCQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index a0dbb81fd90..bf13cabd174 100644
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
2.53.0


