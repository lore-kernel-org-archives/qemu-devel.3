Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32B1C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5f-0004tG-TE; Fri, 04 Sep 2026 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5d-0004hZ-RC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5c-0008L7-5M
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0aO7FqfJSAdz1YQ8MVxqiTp3fdIPsWeQDE0DGs8ifM=;
 b=Ae5KQagWwRtdcU5HCA++DOLycnNGj8zfkymdwmmECx6R8BaKs6XveaSU2wUpHAJpzlLtQK
 Y9Info0vqWlZ6eU8ISqW8AKaQafQsbQAPMHh4Z8ynHy4UTnngrxk1cmi6YmJhGXvKiHJFs
 Q49SMshWk1z2J3/J88GpL9aYy/fOvCg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-4pok4fRVMGaX7eZlzhuGBA-1; Fri,
 04 Sep 2026 16:00:42 -0400
X-MC-Unique: 4pok4fRVMGaX7eZlzhuGBA-1
X-Mimecast-MFC-AGG-ID: 4pok4fRVMGaX7eZlzhuGBA_1788552040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF10E195396D; Fri,  4 Sep 2026 20:00:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C154618001CE; Fri,  4 Sep 2026 20:00:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:25 +0400
Subject: [PATCH v4 42/75] hw/acpi: fix "node" properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-42-a985f168e938@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rI6+Ht1+ovIHApi7V2V/PxX0Go4UHFVSP/2DooxLlRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKXm+3tmPfI/yolgBHhSSYsiLQ72WSt/MBr
 3ek3u+UFT6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5dXcD/4sNqQxkV6p1w07SrEYYUkTj6wp5Ma6kb1fylmbcKJ61HW0TGK7K9g1plyOxB54GW8/dmC
 qCt/LMJEDxn0C8aOhjAJAUlBz8Z2c20M1Kai45o94iFElSO8UR5FhWwq9bMOEPhCHGahPa2goRd
 UnbXAsGPwjWDqbf0rIBndxDvRWgPHGKO8fYXUACLm6RbhV6gC8x3XcEw66GAIu3f/hBZq8WXrHb
 +g79irPRvAuuqTl/8XFBCCFLYxU/ptHKKq7n0ct2zRcz5LAkE6wVL30/Y22yTwgTfSxR1VEt28U
 Mpm/Ixlb8vfOILLlQ6TaieFa0HD3rb3+vhU+OyT/LBwHRQfblyxXmeQ255Pe3rgixW6M60c7AcQ
 S91jjYuhbUtYZPCBmUpwqCQlqfOAd/6DTNvdhTygGHf1WLw4HI1HbKEJ4pFIY0T0111fy8J6c9R
 QIFovm7likYYX4rFNdaCSrJs2auETAsIPXTJcOlKMxw27gSDqOEfHCAby2IFq7P4FZHWDHzxLk4
 aKY7Ff8iYp6kieYyEdd6swz1hlJs6n2Q+aYxpReNH9JH9pwrWu896ZCwCDmnd482oD9986Suv5G
 u3a+shWf8xqxpKihOPiOKfJOLvt0wnMlxgNQUZwBcxofw+oSVZvSZtwoxPg30nwApoz13tni1nP
 qSHg762B1GU5OYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The setter uses visit_type_uint32, not visit_type_int.

Fixes: f74e78220dbf ("acpi/pci: Move Generic Initiator object handling into acpi/pci.*")
Fixes: a82fe8291643 ("hw/acpi: Generic Port Affinity Structure support")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 8c7ed104796d..c82924be8620 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -139,7 +139,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
         acpi_generic_initiator_set_pci_device);
     object_class_property_set_description(oc, "pci-dev",
         "PCI device to associate with the node");
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add(oc, "node", "uint32", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
         "NUMA node associated with the PCI device");
@@ -253,7 +253,7 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
         acpi_generic_port_set_pci_bus);
     object_class_property_set_description(oc, "pci-bus",
        "PCI Bus of the host bridge associated with this GP affinity structure");
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add(oc, "node", "uint32", NULL,
         acpi_generic_port_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
        "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");

-- 
2.55.0.543.g5ebe2ebe4ea8


