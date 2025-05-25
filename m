Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4DFC5AD49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJADM-0004kb-Os; Sun, 25 May 2025 08:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJAC9-00017p-W1; Sun, 25 May 2025 08:11:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJAC7-0003ud-Vh; Sun, 25 May 2025 08:11:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADB6C124E69;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6AA5215FD0;
 Sun, 25 May 2025 15:08:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 55/59] migration/multifd: Don't send device state
 packets with zerocopy flag
Date: Sun, 25 May 2025 15:08:12 +0300
Message-Id: <20250525120818.273372-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/3bd5f48578e29f3a78f41b1e4fbea3d4b2d9b136.1747403393.git.maciej.szmigiero@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 6be7696129b302830a9cff7e30484e08c2d64b57)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd.c b/migration/multifd.c
index dfb5189f0e..198763bada 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -695,6 +695,7 @@ static void *multifd_send_thread(void *opaque)
         if (qatomic_load_acquire(&p->pending_job)) {
             bool is_device_state = multifd_payload_device_state(p->data);
             size_t total_size;
+            int write_flags_masked = 0;
 
             p->flags = 0;
             p->iovs_num = 0;
@@ -702,6 +703,9 @@ static void *multifd_send_thread(void *opaque)
 
             if (is_device_state) {
                 multifd_device_state_send_prepare(p);
+
+                /* Device state packets cannot be sent via zerocopy */
+                write_flags_masked |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
             } else {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
@@ -723,7 +727,8 @@ static void *multifd_send_thread(void *opaque)
                                               &p->data->u.ram, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
-                                                  NULL, 0, p->write_flags,
+                                                  NULL, 0,
+                                                  p->write_flags & ~write_flags_masked,
                                                   &local_err);
             }
 
-- 
2.39.5


