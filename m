Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B24CCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlU-00085A-0Q; Tue, 30 Sep 2025 08:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlO-00082s-RX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlD-0002Pw-Cx
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iS9/jsID8lCuYILqlbkqvw0kLQZtR3FPcuJFepjPXg=;
 b=Fn8sLgFS1vFpPYT8ErKTcRTbi2F05whnYwqxwr29I2zluZeuq8Nhhy6PbLq8qt87PtEGoN
 09L/P3Er+SqN/r+JOhA0ddSJIDXfdJFHmy9IJ6xP19rws7AZeJXWA/CTGty2qRpyq5e3Nl
 TMslzslzVCI8RY/56EBwdSzkDU6efsU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-isD22pSwPtKN8hh2jCwcvA-1; Tue,
 30 Sep 2025 08:47:12 -0400
X-MC-Unique: isD22pSwPtKN8hh2jCwcvA-1
X-Mimecast-MFC-AGG-ID: isD22pSwPtKN8hh2jCwcvA_1759236431
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 589C318005AA; Tue, 30 Sep 2025 12:47:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB98E195608E; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F64621E66BB; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 12/13] ivshmem-flat: Mark an instance of missing error handling
 FIXME
Date: Tue, 30 Sep 2025 14:46:52 +0200
Message-ID: <20250930124653.321609-13-armbru@redhat.com>
In-Reply-To: <20250930124653.321609-1-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20250923091000.3180122-13-armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


