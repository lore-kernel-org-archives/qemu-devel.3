Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEF8C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHtY-0001tM-90; Tue, 18 Aug 2026 07:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtW-0001qT-Hb
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtV-0006yh-6a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JcxfkZ237zfdcOtdcEivBYWWxF/TrulB/dckEQCvYM=;
 b=IjvPRRJsmaHF+uHfbWuL/Cbdkjefi9mKHMyQEOu7699oozTdUWlQedV+o+crKq5NcOGduF
 CIoz12mHwNyDJfCU4enW9Kms3I0ziyfinEGhExP2vcELFd3CJ9bzx3k6+Qg2n4RsC/TQxY
 +kydjT8tsyCfSV8d42e57q3vkGs/VAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-u53nJ6pWPAe31a0xiXXF5Q-1; Tue,
 18 Aug 2026 07:22:09 -0400
X-MC-Unique: u53nJ6pWPAe31a0xiXXF5Q-1
X-Mimecast-MFC-AGG-ID: u53nJ6pWPAe31a0xiXXF5Q_1787052128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D5831800646; Tue, 18 Aug 2026 11:22:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72139180034F; Tue, 18 Aug 2026 11:22:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:08 +0400
Subject: [PATCH v3 41/74] hw/acpi: fix "node" properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-41-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pc3526WxzWWGflYPva+gEUQR9wKHaqhJ+UYHvMwFRZw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD262AvPSPp71kl+0gJ8I9EiKJvdFrT81WDkU
 rg4Nj275f2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5aRrD/kB4mciJbag+mCWEbGxgkQYtUbhjJsN17TAebszLgb1eNaBD+fkac4gEaBzXK01qSKsB0f
 J49hAH4esVdeA2Pd33t2mmw1t+fvjDt/GwrNgyeN/LjpgVGe1bqm5OIT2dMYkSYi/rSCRTCILY4
 984trFVK/Gay8Cw8fb2XOYmCRBWA+vYRWMsopLi9kIZA7kmG3O6jDfjTKmzcJJIs1Pt1xnxoz0s
 K5BSu3iF8xRx72saHOBuOvFEit8hu9jcSGbt1CPgB8gnuDRHGrSHtILGbFN/eqhoTFTkWf1OjzF
 /sXrBcgXCbUFPBCa3BSLaDxLkHBs3Bu/v243Yt2GZ4r1pqc+mLBV4z+FffdWywVb09mahu6rXjy
 Q9tUdTwSVgeEjl2meY2vSV9WS1xaSvUMB6C7QCbTrOgmr87jojvKvM3y4AuonaPhsnr0/f/Podu
 nVwPk3lUAIDjPpQmtsiqSlagnkxobpnvxlP3P8f/DHClO8XsycV75YFHPwz7kL9LCE+A/sci++y
 scTYh56VxeprBJJVY22Dm1J+VpoJoOywvGx67II2NXr0xsj9gs9f2YHCdk8qljWsEKcTjtLpKlS
 8XTqUi0DmQ4vmSuT2+bAT7Vs91BfaUUPAY8HaciP/EOshAwS9CYULV5zwcEPjHs53lLm5GWksXc
 i+aQW0pKNfPIwPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The setter uses visit_type_uint32, not visit_type_int.

Fixes: f74e78220dbf ("acpi/pci: Move Generic Initiator object handling into acpi/pci.*")
Fixes: a82fe8291643 ("hw/acpi: Generic Port Affinity Structure support")
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


