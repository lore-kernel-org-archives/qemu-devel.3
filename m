Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37078C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE8I-0000qe-N4; Thu, 06 Jun 2024 10:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8F-0000kq-88
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8D-0000dY-0R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717684219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDfMUZhKmae+/Kl8rhTqSkxDB2J+XbFOFNJIOaJqc98=;
 b=dM41TOL/wTkswF7i18NUNtg5qHGbvWucNriI51BuaRvQ67gVNlgBnLLG8p/Wx4cN2NefLE
 gO8hkIWrc3mP0MJMWutTEvQ+HEfO/Dw62XgDZcaVqh2Hbw04++zAlutsZ6vj+rvZtOFyOm
 PY4E3Au5B1m9ZMtIl0cuOVA5GRK26mM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-ZoJZRBQqP520_fmRGwGH4g-1; Thu,
 06 Jun 2024 10:30:15 -0400
X-MC-Unique: ZoJZRBQqP520_fmRGwGH4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA6B3C025B2;
 Thu,  6 Jun 2024 14:30:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3DA5202279E;
 Thu,  6 Jun 2024 14:30:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0C40C1800D60; Thu,  6 Jun 2024 16:30:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 3/4] vga/cirrus: mark as not secure
Date: Thu,  6 Jun 2024 16:30:09 +0200
Message-ID: <20240606143010.1318226-4-kraxel@redhat.com>
In-Reply-To: <20240606143010.1318226-1-kraxel@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c     | 1 +
 hw/display/cirrus_vga_isa.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 150883a97166..1f4c55b21415 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_cirrus_vga;
     device_class_set_props(dc, pci_vga_cirrus_properties);
     dc->hotpluggable = false;
+    klass->not_secure = true;
 }
 
 static const TypeInfo cirrus_vga_info = {
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 84be51670ed8..535a631b4b09 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
     dc->realize = isa_cirrus_vga_realizefn;
     device_class_set_props(dc, isa_cirrus_vga_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    klass->not_secure = true;
 }
 
 static const TypeInfo isa_cirrus_vga_info = {
-- 
2.45.2


