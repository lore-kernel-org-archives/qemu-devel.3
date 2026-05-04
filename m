Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55E2FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraM-0007W4-Qo; Mon, 04 May 2026 07:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraK-0007Vi-Uo
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraJ-0000n2-HW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bgLA9Zp+Jow51t/607ELa0KrzfqLyYWWcupN4GZiYQ=;
 b=MhUWjgQ67+duDdvxRfRjraAn4vm4wLtemQDf4uAzhNXgfrk7tuJdBfwLIeBgEBtlXUIIat
 c1SHQkeI9OH2V6BpPeOF8zHIB6A7be66INg1pz416G36G5HghKYQn6gZp23xW/VQtjdhZy
 5Hr1UxYtqoD971+h63Gxx/s/gAY/WNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-PbwEgQtUPgqRxd4yaUU3sg-1; Mon,
 04 May 2026 07:35:33 -0400
X-MC-Unique: PbwEgQtUPgqRxd4yaUU3sg-1
X-Mimecast-MFC-AGG-ID: PbwEgQtUPgqRxd4yaUU3sg_1777894533
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD3051956094
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CC191955D84; Mon,  4 May 2026 11:35:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:51 +0400
Subject: [PATCH v2 03/46] hw/pci-bridge: handle missing parent in
 prop_pxb_uid_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-3-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mzt68/PqLMn279UizfyFsnOjTDYKE+7gRPi+R9njaM4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsckuSlnRVxucpGu4M0o1VGTtJdQeSBN24i
 0JKwN1ohfOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5eaGEACcv47TTEn0QNkcSwsvf0I7AhjqGNBqwnrSqQpQa6H946t2+MD7BJ+v5vpxJYsS+f8l7JR
 Ip7W7cxPJQyqW4k3Xx26e2f6oeDeL5bbopzf7HJgfHQP1IitVsTOZFWimOvMTc5rKqSdd527X0n
 KGw9lBj+9ny2DNElw0Qaj8zAWeWUCSwvFuS/Imkivl3FpJPHrhyL8uNLDdbk2NPZeNmUu5HHq3l
 jpFRBSESPulgrKPhNeNuSN6+EI5VIWa7Ycp05tmCDjh1OO13Y4Q87pJH1bHteQbsp2pQ/O5F6iR
 /Jn+TeGIFSaK6ka8ZILlw0B4dVAMuENabn7vY2unPXMVPGm8mHR9M8cxHzwJG9/WBbwOUeKwTW5
 ejXD3hUh+MKbm8wMRIissX6LIJ8DAmVbYXjEpCPY2LBDRykFf9VO0gt4AGTZ+ft1ifCMEe/u4eV
 YGYF/ag+uUQlqqME6lGimHSN0NSXegxdyKybGtCkNX+EdNooPQE7LPacXIjAgPzUgewrMvIRdHj
 IrZauSvO99khd5vR+wgaxMUP3V0i3VXE1VvPzKDdmd5/JLU24SNSrdza6eNKEviAw0TSW1oCyrB
 As4yo5KckwFGH5/XEsUilQ3huA7t41W+3N7X1KuaS8pnybYyCj/Lw8mS+hUPvn1bjSIH4DGgBV9
 I/aUwA1g5O/HUKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When called on an unrealized pxb bus (e.g. from
qmp_qom_list_properties), bus->parent_dev is NULL. The pxb_bus_num()
callback dereferences it unconditionally. Check for this to avoid a
NULL dereference.

Fixes: 97b9cb066e5f ("hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 11623a5666f..40ffbc4e082 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -85,8 +85,14 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
 static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+    PCIBus *bus = PCI_BUS(obj);
+    uint32_t uid;
 
+    if (!bus->parent_dev) {
+        error_setg(errp, "bus not attached to a device");
+        return;
+    }
+    uid = pci_bus_num(bus);
     visit_type_uint32(v, name, &uid, errp);
 }
 

-- 
2.54.0


