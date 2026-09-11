Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D80EC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56Rx-000097-EM; Fri, 11 Sep 2026 14:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x56Rv-00008y-UC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:58:11 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x56Rs-0006P8-KS
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:58:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 14A54C0B51;
 Fri, 11 Sep 2026 21:58:03 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 1wVPtaTWSiE0-vUkR6pCf; Fri, 11 Sep 2026 21:58:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789153082;
 bh=qhdigUM6yJeKxzGWYHMipS5joVCDQ44KzVFqhA7O5XU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=vgxVNQi+8nRa3do+L/nq48migRZ4JmcWNF+Rj9R+AYR6sv121XwwYj2vXdDWYhxlw
 AEtarWZNvczyEepibFGqSI+idjUySla1arGmKKudAmibapqv7wb5f+WN0a0ue8aZQm
 /nzSac5KLX9BvJZSt2luyI+jxdi3kwCwZOFqIVL8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2] util/event_notifier: more strict API
Date: Fri, 11 Sep 2026 21:58:00 +0300
Message-ID: <20260911185800.134135-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have .initialized in EventNotifier to track was it actually
initialized, and we have a comment that @fd passed to
event_notifier_init_fd() must be an eventfd object.

Still, there are two specific users, which ignore these things,
and use -1 as specific value storing in notifier, to mark it
"uninitialized".

Let's make strict API:

- store only valid FDs in initialized notifier
- _set() asserts that passed fd is valid
- _get() asserts that notifier is initialized (actually, except
  the two specific cases we rework, all other callers are not
  prepared to notifier being uninitialized when _get() is called.
  In this case _get() returns 0 (which is a valid fd), and caller
  will mistakenly use it, which is worse than abort())
- for two specific cases, implement additional getter for .initialized
  field itself
- zeroed notifier is uninitialized(.initialized is false)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v2: - rework to even stricter API
    - merge into one commit (seems simpler to see the whole picture,
      not too much changes here)

 hw/remote/iohub.c                  | 11 +++++-----
 hw/virtio/vhost-shadow-virtqueue.c | 32 +++++++++++++++++-------------
 include/qemu/event_notifier.h      |  1 +
 util/event_notifier-posix.c        | 10 ++++++++++
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
index 988d3285ccc..ab698d9f03d 100644
--- a/hw/remote/iohub.c
+++ b/hw/remote/iohub.c
@@ -28,8 +28,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
     for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
         qemu_mutex_init(&iohub->irq_level_lock[pirq]);
         iohub->irq_level[pirq] = 0;
-        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
-        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
     }
 }
 
@@ -85,9 +83,12 @@ void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
 
     pirq = remote_iohub_map_irq(pci_dev, intx);
 
-    if (event_notifier_get_fd(&iohub->irqfds[pirq]) != -1) {
-        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
-                            NULL, NULL, NULL);
+    if (event_notifier_initialized(&iohub->irqfds[pirq])) {
+        if (event_notifier_initialized(&iohub->resamplefds[pirq])) {
+            qemu_set_fd_handler(
+                event_notifier_get_fd(&iohub->resamplefds[pirq]),
+                NULL, NULL, NULL);
+        }
         event_notifier_cleanup(&iohub->irqfds[pirq]);
         event_notifier_cleanup(&iohub->resamplefds[pirq]);
         memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc79..53481109d40 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -745,6 +745,15 @@ static void vhost_svq_handle_call(EventNotifier *n)
     vhost_svq_flush(svq, true);
 }
 
+static void event_notifier_set_or_zero(EventNotifier *e, int fd)
+{
+    if (fd == VHOST_FILE_UNBIND) {
+        memset(e, 0, sizeof(*e));
+    } else {
+        event_notifier_init_fd(e, fd);
+    }
+}
+
 /**
  * Set the call notifier for the SVQ to call the guest
  *
@@ -755,17 +764,13 @@ static void vhost_svq_handle_call(EventNotifier *n)
  */
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)
 {
-    if (call_fd == VHOST_FILE_UNBIND) {
-        /*
-         * Fail event_notifier_set if called handling device call.
-         *
-         * SVQ still needs device notifications, since it needs to keep
-         * forwarding used buffers even with the unbind.
-         */
-        memset(&svq->svq_call, 0, sizeof(svq->svq_call));
-    } else {
-        event_notifier_init_fd(&svq->svq_call, call_fd);
-    }
+    /*
+     * Fail event_notifier_set if called handling device call.
+     *
+     * SVQ still needs device notifications, since it needs to keep
+     * forwarding used buffers even with the unbind.
+     */
+    event_notifier_set_or_zero(&svq->svq_call, call_fd);
 }
 
 /**
@@ -808,14 +813,14 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 {
     EventNotifier *svq_kick = &svq->svq_kick;
-    bool poll_stop = VHOST_FILE_UNBIND != event_notifier_get_fd(svq_kick);
+    bool poll_stop = event_notifier_initialized(svq_kick);
     bool poll_start = svq_kick_fd != VHOST_FILE_UNBIND;
 
     if (poll_stop) {
         event_notifier_set_handler(svq_kick, NULL);
     }
 
-    event_notifier_init_fd(svq_kick, svq_kick_fd);
+    event_notifier_set_or_zero(&svq->svq_kick, svq_kick_fd);
     /*
      * event_notifier_set_handler already checks for guest's notifications if
      * they arrive at the new file descriptor in the switch, so there is no
@@ -922,7 +927,6 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
 {
     VhostShadowVirtqueue *svq = g_new0(VhostShadowVirtqueue, 1);
 
-    event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
     return svq;
diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index 8a4ff308e19..820efe77229 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -39,6 +39,7 @@ int event_notifier_test_and_clear(EventNotifier *);
 void event_notifier_init_fd(EventNotifier *, int fd);
 int event_notifier_get_fd(const EventNotifier *);
 int event_notifier_get_wfd(const EventNotifier *);
+bool event_notifier_initialized(const EventNotifier *e);
 #else
 HANDLE event_notifier_get_handle(EventNotifier *);
 #endif
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 83fdbb96bbc..f595945af74 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -27,6 +27,7 @@
  */
 void event_notifier_init_fd(EventNotifier *e, int fd)
 {
+    assert(fd >= 0);
     e->rfd = fd;
     e->wfd = fd;
     e->initialized = true;
@@ -96,14 +97,23 @@ void event_notifier_cleanup(EventNotifier *e)
 
 int event_notifier_get_fd(const EventNotifier *e)
 {
+    assert(e->initialized);
+    assert(e->rfd >= 0);
     return e->rfd;
 }
 
 int event_notifier_get_wfd(const EventNotifier *e)
 {
+    assert(e->initialized);
+    assert(e->wfd >= 0);
     return e->wfd;
 }
 
+bool event_notifier_initialized(const EventNotifier *e)
+{
+    return e->initialized;
+}
+
 int event_notifier_set(EventNotifier *e)
 {
     static const uint64_t value = 1;
-- 
2.43.0


