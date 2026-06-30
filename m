Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0969C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ81-0006dY-Ue; Tue, 30 Jun 2026 00:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ81-0006dP-0b
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ7z-0002yX-Iw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIfe4KaSAWiFYGxBo0mP8MsVGGEQeTnzwnevk33Axp8=;
 b=Tzz2pvR4dw1XuOAji51qrEpxu6AcXsCIusJ3J2d7asmgTLayJJZF6b668/TknRGg/L4aQA
 vmX8T5Ctu+nYIuXSz6ZuiJCe6nwVUWTgJz3m2zZZFetKRVkndMm1rcxTGr2jDZqA9sgqWC
 Y5HsuqSyJ+39ijYUOlFL7yzxPvWmtLk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-6gQRHWlqMuqojC0EhevY2Q-1; Tue,
 30 Jun 2026 00:31:17 -0400
X-MC-Unique: 6gQRHWlqMuqojC0EhevY2Q-1
X-Mimecast-MFC-AGG-ID: 6gQRHWlqMuqojC0EhevY2Q_1782793876
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7C5D18304BD; Tue, 30 Jun 2026 04:31:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05BC91956042; Tue, 30 Jun 2026 04:31:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 02/23] vfio/pci: Fix information leak in vfio_rom_read()
Date: Tue, 30 Jun 2026 06:30:46 +0200
Message-ID: <20260630043107.1511076-3-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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


