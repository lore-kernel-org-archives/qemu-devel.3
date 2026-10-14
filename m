Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A188FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGue1-0005Nh-Ur; Wed, 14 Oct 2026 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudp-0005FA-MS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudo-0004Xp-8B
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVTlceBdGKfLV6pzRmw8MfOPhrOsZ2iY1gRIqg26vGs=;
 b=QxHK9CS/VH2uVpE5d0bnTFvXlQ4enCWNNP2XQVtUcj5pR+YVfDlkVF63+aYPvSHY7XLvtV
 tYLChEsTH0xefIr9eX7oHFBXoUS1k4gHDPILr6AJuonol5GvO8eqrsdVHDlYO5lB4D3wgZ
 A3tyvHFP4Rv7WPW6kZP5jaMO0175wHE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-HeOsVXhxP6CLmd9rqzDrLA-1; Wed,
 14 Oct 2026 08:47:12 +0000
X-MC-Unique: HeOsVXhxP6CLmd9rqzDrLA-1
X-Mimecast-MFC-AGG-ID: HeOsVXhxP6CLmd9rqzDrLA_1791967631
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9C8318002C8; Wed, 14 Oct 2026 08:47:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BF8818001CA; Wed, 14 Oct 2026 08:47:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 02/17] igb: Add migration blocker when VF migration is
 enabled
Date: Wed, 14 Oct 2026 10:46:40 +0200
Message-ID: <20261014084655.127254-3-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

When x-vf-migration=on, the VF exposes a DVSEC-based migration
interface to the L1 guest. If the L0 hypervisor were to migrate the
QEMU instance itself, the in-flight VF migration state would be
silently lost or corrupted.

Register a migration blocker during realize so that any L0 migration
attempt is rejected with a clear error message.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_common.h | 1 +
 hw/net/igbvf.c      | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index f0e2529e757b..88e92e093680 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -163,6 +163,7 @@ struct IgbVfState {
 
     uint16_t vfn;
     bool migration_enabled;
+    Error *migration_blocker;
 
     MemoryRegion mmio;
     MemoryRegion msix;
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index bd6debc8310a..f2474da9ef2a 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -50,6 +50,7 @@
 #include "igb_common.h"
 #include "igb_core.h"
 #include "igb_migration.h"
+#include "migration/blocker.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -309,6 +310,13 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         if (!igbvf_add_migration_dvsec(s, errp)) {
             return;
         }
+
+        error_setg(&s->migration_blocker,
+                   "igbvf: VF migration via DVSEC is enabled (x-vf-migration);"
+                   " L0 migration is not supported");
+        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+            return;
+        }
     }
 }
 
@@ -323,6 +331,7 @@ static void igbvf_pci_uninit(PCIDevice *dev)
 {
     IgbVfState *s = IGBVF(dev);
 
+    migrate_del_blocker(&s->migration_blocker);
     pcie_aer_exit(dev);
     pcie_cap_exit(dev);
     msix_unuse_all_vectors(dev);
-- 
2.56.0


