Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3CCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z2e-0007D4-Rc; Tue, 23 Sep 2025 05:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2a-0007BH-27
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2O-0000QP-7U
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mc/1fpfnycC7fgouplaTw4Xu2tEN0RZN3ojTYtsKpYo=;
 b=iEEV7xp9Pwl0P5M4NXRoX9eTWYpwuQoLE9Ii6hrdQSnTrk19tMIoOd3wyVIgCxdfUzaxlx
 Y9+6QyGhdBnKcrL2E5fT+2k+68jcMvr0nnx/foOT5Uz+d+dxZnrOV52np2FsToVIvJZk6Z
 hI44zGMcNdKrAGY2BlW00fWZvKxDMt0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-0zXdGnI8N32eHF3kf-TefA-1; Tue,
 23 Sep 2025 05:10:08 -0400
X-MC-Unique: 0zXdGnI8N32eHF3kf-TefA-1
X-Mimecast-MFC-AGG-ID: 0zXdGnI8N32eHF3kf-TefA_1758618606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39A01800284; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4126930002C5; Tue, 23 Sep 2025 09:10:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C10921E66E5; Tue, 23 Sep 2025 11:10:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v3 12/13] ivshmem-flat: Mark an instance of missing error
 handling FIXME
Date: Tue, 23 Sep 2025 11:09:59 +0200
Message-ID: <20250923091000.3180122-13-armbru@redhat.com>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ivshmem-flat's ivshmem_flat_add_vector() neglects to handle
qemu_set_blocking() failure.  It used to silently ignore errors there.
Recent commit 6f607941b1c (treewide: use qemu_set_blocking instead of
g_unix_set_fd_nonblocking) changed it to warn (without mentioning it
the commit message, tsk, tsk, tsk).

Note that ivshmem-pci's process_msg_connect() handles this error.

Add a FIXME comment to mark the missing error handling.

Cc: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/ivshmem-flat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index e83e6c6ee9..27ee8c9218 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -138,6 +138,8 @@ static void ivshmem_flat_remove_peer(IvshmemFTState *s, uint16_t peer_id)
 static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
                                     int vector_fd)
 {
+    Error *err = NULL;
+
     if (peer->vector_counter >= IVSHMEM_MAX_VECTOR_NUM) {
         trace_ivshmem_flat_add_vector_failure(peer->vector_counter,
                                               vector_fd, peer->id);
@@ -154,8 +156,10 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
      * peer.
      */
     peer->vector[peer->vector_counter].id = peer->vector_counter;
-    /* WARNING: qemu_socket_set_nonblock() return code ignored */
-    qemu_set_blocking(vector_fd, false, &error_warn);
+    if (!qemu_set_blocking(vector_fd, false, &err)) {
+        /* FIXME handle the error */
+        warn_report_err(err);
+    }
     event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
                            vector_fd);
 
-- 
2.49.0


