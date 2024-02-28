Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJz-0002iW-B0; Wed, 28 Feb 2024 00:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJN-0001Os-2U
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJF-0007W5-Rh
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP3OexboYkgrsNQ0WmIkQllrjA/g1P+GKoEKbQpmMiw=;
 b=iBslPpQX+ZR2Oi2n0nt16ZgQ/mT+b0VpmXrLTd+8tjT+KK53ZAzvgQvlwC/Y/4ehicHCWj
 dv0YcSxZZ7kQ67o8Bd0PVqtVAy1zs9S95ZqajhhOk8mYx10MBCUulNbYpX0fET73mjDxMg
 QBHnt8gTqV8mciVwjPvTDZ7d5/k+2N8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-X9QrUcU-MAmsnq4tb49NFA-1; Wed, 28 Feb 2024 00:16:45 -0500
X-MC-Unique: X9QrUcU-MAmsnq4tb49NFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 393CB185A784;
 Wed, 28 Feb 2024 05:16:45 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1BD1C060AF;
 Wed, 28 Feb 2024 05:16:35 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 21/25] migration: update cpr-reboot description
Date: Wed, 28 Feb 2024 13:13:11 +0800
Message-ID: <20240228051315.400759-22-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Clarify qapi for cpr-reboot migration mode, and add vfio support.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-14-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7303e57e8e..bee5e71fe3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -636,19 +636,28 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command saves state to a file, allowing one to
-#              quit qemu, reboot to an updated kernel, and restart an updated
-#              version of qemu.  The caller must specify a migration URI
-#              that writes to and reads from a file.  Unlike normal mode,
-#              the use of certain local storage options does not block the
-#              migration, but the caller must not modify guest block devices
-#              between the quit and restart.  To avoid saving guest RAM to the
-#              file, the memory backend must be shared, and the @x-ignore-shared
-#              migration capability must be set.  Guest RAM must be non-volatile
-#              across reboot, such as by backing it with a dax device, but this
-#              is not enforced.  The restarted qemu arguments must match those
-#              used to initially start qemu, plus the -incoming option.
-#              (since 8.2)
+# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
+#     After quitting qemu, the user resumes by running qemu -incoming.
+#
+#     This mode allows the user to quit qemu, and restart an updated version
+#     of qemu.  The user may even update and reboot the OS before restarting,
+#     as long as the URI persists across a reboot.
+#
+#     Unlike normal mode, the use of certain local storage options does not
+#     block the migration, but the user must not modify guest block devices
+#     between the quit and restart.
+#
+#     This mode supports vfio devices provided the user first puts the guest
+#     in the suspended runstate, such as by issuing guest-suspend-ram to the
+#     qemu guest agent.
+#
+#     Best performance is achieved when the memory backend is shared and the
+#     @x-ignore-shared migration capability is set, but this is not required.
+#     Further, if the user reboots before restarting such a configuration, the
+#     shared backend must be be non-volatile across reboot, such as by backing
+#     it with a dax device.
+#
+#     (since 8.2)
 ##
 { 'enum': 'MigMode',
   'data': [ 'normal', 'cpr-reboot' ] }
-- 
2.43.0


