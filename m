Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B511C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHtT-0001fr-PV; Tue, 18 Aug 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtN-0001b6-NE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHtL-0006xQ-TB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2y7ZoLqrQvj5JiO96UdrTHJb4VNDOERoPvd/37XGTss=;
 b=BVZXoYbnFbTypHVoQtQ91m78ejsI5sxmBI7nkgdAqNi5ITjddhknL4pP52H4kmqecUhQXT
 qXo5YMT34FSp2WaAS9ruDPTTR4XfeSELPR/KKB679XDMuANvEFmdPlmrzlfh0wai5bg+wm
 A3lrbvIiBnwXR8AeqOiqRPwvD4t21Nw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-zYNRnFPtPz6aRNxuyHaRig-1; Tue,
 18 Aug 2026 07:21:54 -0400
X-MC-Unique: zYNRnFPtPz6aRNxuyHaRig-1
X-Mimecast-MFC-AGG-ID: zYNRnFPtPz6aRNxuyHaRig_1787052113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAD4F18001CD; Tue, 18 Aug 2026 11:21:52 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 262A61956042; Tue, 18 Aug 2026 11:21:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:06 +0400
Subject: [PATCH v3 39/74] ppc/pnv: fix phb-id and chip-id properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-39-24b8bbbe3d86@redhat.com>
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
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KuOcq19I+P/sJeJ1xp8d6ZSTzh2ez12rQGMJ3NMg204=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26OP8NHlU//glh6Y/TiS6C4LWMdM1Mp1PE4
 N73VUTAjYCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5Z3zD/9gWU7pfMt92jOlAo2RZAEXkHDRGKqEx2ICdvTyWX8zleuysTpxTkfShdtSN6S9ztfTciS
 SYmWsYMEAjGrRG15PVWwYDuP2aZvFF+BEprhAXUxt7sw3/kvto08o1uF3PQsywv3rKxgYVwRVeG
 zVLCJ3YxelFRUJM3/4iOyKZz9cGcp2NHW5on7S930p64Eondnf2iDwKtGvcnqUkEw7PTFGTzJf7
 qhn2p97AOH4bbAnliiEuZXHZtcHDZYGErAq/s04Id3Hb6btno10wKyS4GskHdIrzmCoFPOoXO1f
 Af0dRZmrGsDNl/6TuAdl32BIGSmbWCbi0hbH5RHmMJz/1BkzzVbb6f2ZiRc4wnxJEJKwGq3btXE
 /jDGGwRF3eOmxGacI0rGn9CysH1ZHhE3liF5Z24uVSbgKNXXO1DUEp5Ea4Y5TvRcjLOgTDXAiIQ
 UULsnsFFqzvfvLkgg8sze0JCc0XKq3WLJgAM+MT8/Q9XFTIyj7VKJqi6zQvAR4QzMFLmEufd3cb
 q0Ga2ftJJBd6/NwkwPpk0I3O8FMQJrSMcttRLEMuJOZnJGTcWybz8f12RnWGL1K6udGtbo2wO8F
 +CbnHf4Vg4/klvHf0dzS9PZ51VjpnRKIb2wzMLAiqvNF3uft2oHkAA0FB7HDY+G+BnNE0LuiqHX
 ikrh1I8Md22i/Sw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_size, not visit_type_int.

Fixes: 8ec1e4f1ef97 ("ppc/pnv: add phb-id/chip-id PnvPHB3RootBus properties")
Fixes: b7c1750dc440 ("ppc/pnv: add phb-id/chip-id PnvPHB4RootBus properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/pnv_phb3.c | 4 ++--
 hw/pci-host/pnv_phb4.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 4ffdb4ce31ae..0471b009ec2f 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1164,12 +1164,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "size",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "size",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf074f..510edebc40de 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1761,12 +1761,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "size",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "size",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


