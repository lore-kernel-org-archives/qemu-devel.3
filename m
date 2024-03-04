Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255C7C54E55
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6T-0001B6-0I; Sun, 03 Mar 2024 20:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6R-0001Aq-Ff
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6P-0002Cq-V3
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1u9p98iL9dGUhqwCh1QSReBpXp024Fs7D/IbbmF5DU=;
 b=AlUeb2ScJpPNLu1b/rnHO3IdpYhu3M+FHCwLAwPPVk9Wm8/8cpYvFB1CCdCeoFsckYaaZ9
 octT6IXmLqRPGYucPLAWyFc3S8BjlgKkST7BW3pIJjsHY0gefIeBozs2H+AOrSqNHYRdMV
 pn1UEE6lm3IOqXU32hM6El8AZKAmtVs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-bCWqCaEZP9a6jawEZylEgA-1; Sun,
 03 Mar 2024 20:26:46 -0500
X-MC-Unique: bCWqCaEZP9a6jawEZylEgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7923C0BE4D;
 Mon,  4 Mar 2024 01:26:45 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 685A640C6EBA;
 Mon,  4 Mar 2024 01:26:41 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/27] migration: massage cpr-reboot documentation
Date: Mon,  4 Mar 2024 09:26:08 +0800
Message-ID: <20240304012634.95520-2-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Steve Sistare <steven.sistare@oracle.com>

Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
cpr-reboot references, capitalize COLO and VFIO, and tweak the
wording.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1709218462-3640-1-git-send-email-steven.sistare@oracle.com
[peterx: s/qemu/QEMU per Markus's suggestion]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 0b33a71ab4..b603aa6f25 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -636,28 +636,30 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
-#     After quitting qemu, the user resumes by running qemu -incoming.
-#
-#     This mode allows the user to quit qemu, and restart an updated version
-#     of qemu.  The user may even update and reboot the OS before restarting,
-#     as long as the URI persists across a reboot.
-#
-#     Unlike normal mode, the use of certain local storage options does not
-#     block the migration, but the user must not modify guest block devices
-#     between the quit and restart.
-#
-#     This mode supports vfio devices provided the user first puts the guest
-#     in the suspended runstate, such as by issuing guest-suspend-ram to the
-#     qemu guest agent.
-#
-#     Best performance is achieved when the memory backend is shared and the
-#     @x-ignore-shared migration capability is set, but this is not required.
-#     Further, if the user reboots before restarting such a configuration, the
-#     shared backend must be be non-volatile across reboot, such as by backing
-#     it with a dax device.
-#
-#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
+# @cpr-reboot: The migrate command stops the VM and saves state to
+#     the URI.  After quitting QEMU, the user resumes by running
+#     QEMU -incoming.
+#
+#     This mode allows the user to quit QEMU, optionally update and
+#     reboot the OS, and restart QEMU.  If the user reboots, the URI
+#     must persist across the reboot, such as by using a file.
+#
+#     Unlike normal mode, the use of certain local storage options
+#     does not block the migration, but the user must not modify the
+#     contents of guest block devices between the quit and restart.
+#
+#     This mode supports VFIO devices provided the user first puts
+#     the guest in the suspended runstate, such as by issuing
+#     guest-suspend-ram to the QEMU guest agent.
+#
+#     Best performance is achieved when the memory backend is shared
+#     and the @x-ignore-shared migration capability is set, but this
+#     is not required.  Further, if the user reboots before restarting
+#     such a configuration, the shared memory must persist across the
+#     reboot, such as by backing it with a dax device.
+#
+#     @cpr-reboot may not be used with postcopy, background-snapshot,
+#     or COLO.
 #
 #     (since 8.2)
 ##
-- 
2.44.0


