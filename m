Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CF6C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJN-00015d-3z; Tue, 07 Jul 2026 02:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJJ-00013P-Eb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJH-0006a7-Vf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIfe4KaSAWiFYGxBo0mP8MsVGGEQeTnzwnevk33Axp8=;
 b=F4HHs3Lh+zsdvmcllGvO6nRMnoO2nWv5n+BTpe2td/Reh6ZVnxQHtODULP1qNfi+/371hk
 Wj9KYfuc+Jg5pSexkpGpPz9Mt9i43ZGzaUuVL7ea5huU9dAwtQeZWN0uY5kLwJpnyMvPtm
 NUb5CJbzywsYO4b4SdDGKnxTpxtRFx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-D4jYvKRxMImkg0TukPvtmw-1; Tue,
 07 Jul 2026 02:29:31 -0400
X-MC-Unique: D4jYvKRxMImkg0TukPvtmw-1
X-Mimecast-MFC-AGG-ID: D4jYvKRxMImkg0TukPvtmw_1783405770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58F001801311; Tue,  7 Jul 2026 06:29:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0A57180065F; Tue,  7 Jul 2026 06:29:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 02/27] vfio/pci: Fix information leak in vfio_rom_read()
Date: Tue,  7 Jul 2026 08:28:55 +0200
Message-ID: <20260707062920.317302-3-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

vfio_rom_read() can leak uninitialized stack data to the guest when a
read occurs at the end boundary of the ROM BAR.

Fix this by initializing the val union to 0xff, matching the ROM
initialization pattern used in vfio_pci_load_rom().

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Mario Casquero <mcasquer@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260602074446.1206892-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 68ee3ce7dc254dd045ed2c1b21bebc53a4b4e3d6..6b04c6f94f9ade765e236d457e4828ac6199680a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1143,7 +1143,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
         uint16_t word;
         uint32_t dword;
         uint64_t qword;
-    } val;
+    } val = { .qword = ~0ULL };
     uint64_t data = 0;
 
     /* Load the ROM lazily when the guest tries to read it */
-- 
2.54.0


