Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36589CD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOH-0002AM-30; Sat, 06 Jun 2026 01:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjO5-00026E-Qe
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjO4-0008C2-Ff
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KSCoPhM3lk7JFhTxcjXT83QO7v9CIqkxILozb1DjS4=;
 b=JgkUVTHdnLTQayZUaI4+S528i4dFdiNJJ1FpJiDwp9K7aKXLWvCrMOQieOWLueSTMFK47D
 Zp4IoVzSEmDGQl5OgBaE0f2fhztbT0omCzwHNRpMDl7i4X/1IqA4B3k7P0etx9/syUp75N
 zAVo597/QFighG0C30uJ8b2m40dk1VU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-0iFngg0wMNKXKuZipOa0Mw-1; Sat,
 06 Jun 2026 01:15:57 -0400
X-MC-Unique: 0iFngg0wMNKXKuZipOa0Mw-1
X-Mimecast-MFC-AGG-ID: 0iFngg0wMNKXKuZipOa0Mw_1780722956
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90FE180044D
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:15:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D469B1800361; Sat,  6 Jun 2026 05:15:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:35 +0400
Subject: [GIT PULL v2 03/23] hw/pci-bridge: handle missing parent in
 prop_pxb_uid_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-3-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n1HD5N4FZEYQbnTz/49cmNT99YN0r5FAVFil0pDrL3g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0U79PgSmp2Nns1j+04YC4v4VqqR/qTKQGA
 Yh6bNS/tdyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5W3HD/9U6U5p5IipvEJ8ngxAS8yRWXgHwyFVluqRpjry5Oqh7yIrtbnC4wfuJgTW90X5on5p6RT
 6D5BMM/GYiN9/jyIS0jia9bnFZykd3wAjLO8G6NZQAUSiR5zVdw1eOfnOXPaRO21CEIoVYApbu0
 Xeiz3MiOqezadzg3B9LVimOXeIExiD2gFpFT8LYQ+bVkHPkJQN2LA95PKX5xxMVYGfPaOfN9TuS
 rUxL9fjluW4AB0TKdMADZ7+HmZq9Aoy4FyxQbYEH+RrLvcJvzOAJGYyLoFVXpR668Ky4GemrOar
 MsyoM2cciyvLOej3A5Fv9uQ5cGXjhtgHncjYvK9P8sc1DzHglHwDKnbk+hTQhPeVWpVEcrgoDJr
 Ax134v8XBzJFsceRaHtgk9a6s3gkoI9PhZI19UoyrB/GDDgr4gEG2RGq7CebjchcYKi9nYCL9MI
 r/iHnPZfKV8JKJyYpRQ7qz0LA6j/kHNnu7WwUipTrmBS+yU58q4NmWJXVUtJYkgKUce6nO0s4vI
 cH98UNokBYGBSlJlIR4D93x7h5i3wLZTySONxhoLDPAoD7m0hP/O/60bAVDS6jXwUYtRCg4LpId
 3xvxI4wYLnWcmsiUvd4PBtmZXPXm0IQnYLWZ7ydY79YChU6iBi+/YKUjrCpKeaWN3mIICzxYXx/
 lI6G/styWrW9aaQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

When called on an unrealized pxb bus (e.g. from
qmp_qom_list_properties), bus->parent_dev is NULL. The pxb_bus_num()
callback dereferences it unconditionally. Check for this to avoid a
NULL dereference.

Fixes: 97b9cb066e5f ("hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


