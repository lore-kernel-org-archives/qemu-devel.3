Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22565C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihF-0003lh-SZ; Wed, 22 May 2024 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih7-0003bP-OQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih5-0001kR-8u
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEsTrJqprE7ehqM1WFBRNx3rhC2HpuESGFKtGQaEOVk=;
 b=PyOXz4EFO8yxy0xOsuEActdjt5Ref/A2Ihj0/7GbLOmVfrwIxYdQEccR+xM8qI/bP8npBK
 +2z3kEqwL/x+9HShd18mXIef/ntzZzLywhbMVl29lu8q3ZdwyUspdc9GJ+zYb2n60gDjTc
 XAD/U4r4zE2PDALBg0xXfjbPCdqoiTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-CgJ1v5GxPBOniC7Zb7Z6Hw-1; Wed, 22 May 2024 05:55:31 -0400
X-MC-Unique: CgJ1v5GxPBOniC7Zb7Z6Hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C896D801190;
 Wed, 22 May 2024 09:55:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 630032818;
 Wed, 22 May 2024 09:55:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/47] vfio/migration: Don't emit STOP_COPY VFIO migration QAPI
 event twice
Date: Wed, 22 May 2024 11:54:12 +0200
Message-ID: <20240522095442.195243-18-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

When migrating a VFIO device that supports pre-copy, it is transitioned
to STOP_COPY twice: once in vfio_vmstate_change() and second time in
vfio_save_complete_precopy().

The second transition is harmless, as it's a STOP_COPY->STOP_COPY no-op
transition. However, with the newly added VFIO migration QAPI event, the
STOP_COPY event is undesirably emitted twice.

Prevent this by returning early in vfio_migration_set_state() if
new_state is the same as current device state.

Note that the STOP_COPY transition in vfio_save_complete_precopy() is
essential for VFIO devices that don't support pre-copy, for migrating an
already stopped guest and for snapshots.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index af579b868d7caa726fde1eeb73c832ebc3136a7a..56edffaf6251e28e39ef32991394697abb1b9e55 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -150,6 +150,10 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         g_strdup_printf("%s: Failed setting device state to %s.",
                         vbasedev->name, mig_state_to_str(new_state));
 
+    if (new_state == migration->device_state) {
+        return 0;
+    }
+
     feature->argsz = sizeof(buf);
     feature->flags =
         VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
-- 
2.45.1


