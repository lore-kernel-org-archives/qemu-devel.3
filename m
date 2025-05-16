Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C13C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 13:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFvV5-0005Vf-Ts; Fri, 16 May 2025 09:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uFvV3-0005TJ-Rx
 for qemu-devel@nongnu.org; Fri, 16 May 2025 09:53:21 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uFvV1-000182-Vy
 for qemu-devel@nongnu.org; Fri, 16 May 2025 09:53:21 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uFvUr-00000003pkd-0PbA; Fri, 16 May 2025 15:53:09 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH] migration/multifd: Don't send device state packets with
 zerocopy flag
Date: Fri, 16 May 2025 15:53:03 +0200
Message-ID: <3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

If zerocopy is enabled for multifd then QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
flag is forced into all multifd channel write calls via p->write_flags
that was setup in multifd_nocomp_send_setup().

However, device state packets aren't compatible with zerocopy - the data
buffer isn't getting kept pinned until multifd channel flush.

Make sure to mask that QIO_CHANNEL_WRITE_FLAG_ZERO_COPY flag in a multifd
send thread if the data being sent is device state.

Fixes: 0525b91a0b99 ("migration/multifd: Device state transfer support - send side")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ec108af6245a..843c7740a4ec 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -690,6 +690,7 @@ static void *multifd_send_thread(void *opaque)
         if (qatomic_load_acquire(&p->pending_job)) {
             bool is_device_state = multifd_payload_device_state(p->data);
             size_t total_size;
+            int write_flags_masked = 0;
 
             p->flags = 0;
             p->iovs_num = 0;
@@ -697,6 +698,9 @@ static void *multifd_send_thread(void *opaque)
 
             if (is_device_state) {
                 multifd_device_state_send_prepare(p);
+
+                /* Device state packets cannot be sent via zerocopy */
+                write_flags_masked |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
             } else {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
@@ -718,7 +722,8 @@ static void *multifd_send_thread(void *opaque)
                                               &p->data->u.ram, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
-                                                  NULL, 0, p->write_flags,
+                                                  NULL, 0,
+                                                  p->write_flags & ~write_flags_masked,
                                                   &local_err);
             }
 

