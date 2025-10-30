Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWJc-0001Ce-Oo; Thu, 30 Oct 2025 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJS-000180-UU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:51 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJ9-0008Mx-9N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2FEED8094A;
 Thu, 30 Oct 2025 20:19:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-fLAA5S6I; Thu, 30 Oct 2025 20:19:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844764;
 bh=4mc/qBRLhfYXRJW391uyW9nJdD23QGaduedXq3nj154=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gifW8X1uO3BMUUllENMu6cpL+PuoQ2iLARh5T0L6cild5mcv0BLxlFH5wg/YF6B+c
 8/r3HTM4EkWHsPn8I4qyTi6Y73JNTITLXlBI9sSrzTJtAZkQaIMEdfoEdjxvKOBZ4o
 Rar+rFBSHK938UtIBWCIQDbmlPIgeVdAuK+DYKxw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 9/9] net/tap: postpone tap setup to net_backend_connect()
 call
Date: Thu, 30 Oct 2025 20:19:14 +0300
Message-ID: <20251030171915.726441-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

As described in previous commit, to support backend-transfer migration
for virtio-net/tap, we need to postpone the decision to open the device
or to wait for incoming fds up to pre-incoming point (when we actually
can decide).

This commit only postpones TAP-open case of initialization.
We don't try to postpone the all cases of initialization, as it will
require a lot more work of refactoring the code.

So we postpone only the simple case, for which we are going to support
fd-incoming migration:

1. No fds / fd parameters: obviously, if user give fd/fds the should
be used, no incoming backend-transfer migration is possible.

2. No helper: just for simplicity. It probably possible to allow it (and
just ignore in case of backend-transfer migration), to allow user use
same cmdline on target QEMU.. But that questionable, and postponable.

3. No sciprt/downscript. It's not simple to support downscript:
we should pass the responsiblity to call it on target QEMU with
migration.. And back to source QEMU on migration failure. It
feasible, but may be implemented later on demand.

3. Concrete ifname: to not try to share it between queues, when we only
can setup queues as separate entities. Supporting undecided ifname will
require to create some extra netdev state, connecting all the taps, to
be able to iterate through them.

No part of backend-transfer migration is here, we only prepare the code
for future implementation of it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index c50430ba49..ad1d458521 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -90,6 +90,12 @@ typedef struct TAPState {
     int sndbuf;
     int vhostfd;
     uint32_t vhost_busyloop_timeout;
+
+    /* for postponed setup */
+    bool vnet_hdr_required;
+    int vnet_hdr;
+    bool mq_required;
+    char *ifname;
 } TAPState;
 
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp);
@@ -99,6 +105,7 @@ static void launch_script(const char *setup_script, const char *ifname,
 
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
+static bool tap_backend_connect(NetClientState *nc, Error **errp);
 
 static char *tap_parse_script(const char *script_arg, const char *default_path)
 {
@@ -368,6 +375,8 @@ static void tap_cleanup(NetClientState *nc)
         close(s->vhostfd);
         s->vhostfd = -1;
     }
+
+    g_free(s->ifname);
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -424,6 +433,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .backend_connect = tap_backend_connect,
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
@@ -847,6 +857,102 @@ static int get_fds(char *str, char *fds[], int max)
     return i;
 }
 
+static bool tap_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return s->fd == -1;
+}
+
+static bool tap_backend_connect(NetClientState *nc, Error **errp)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    char ifname[TAP_IFNAME_SZ];
+    int vnet_hdr = s->vnet_hdr;
+    int fd;
+
+    if (!tap_wait_incoming(nc)) {
+        /* Already connected */
+        return true;
+    }
+
+    pstrcpy(ifname, sizeof(ifname), s->ifname);
+    fd = net_tap_open(&vnet_hdr, s->vnet_hdr_required, NULL,
+                      ifname, sizeof(ifname),
+                      s->mq_required, errp);
+    if (fd < 0) {
+        goto fail;
+    }
+
+    if (!net_tap_setup(s, fd, vnet_hdr, errp)) {
+        goto fail;
+    }
+
+    return true;
+
+fail:
+    qemu_del_net_client(&s->nc);
+    return false;
+}
+
+static bool check_no_script(const char *script_arg)
+{
+    return script_arg &&
+        (script_arg[0] == '\0' || strcmp(script_arg, "no") == 0);
+}
+
+/*
+ * Returns:
+ * -1 - failed, errp set. The whole tap creation process is faild.
+ *  0 - success, tap initialized, connect is postponed
+ *  1 - no critical error, but postponed connect is not supported,
+ *      caller should continue usual initialization
+ */
+static int tap_postpone_init(const NetdevTapOptions *tap,
+                             const char *name, NetClientState *peer,
+                             Error **errp)
+{
+    int queues = tap->has_queues ? tap->queues : 1;
+
+    if (tap->fd || tap->fds || tap->helper || tap->vhostfds) {
+        return 1;
+    }
+
+    if (!tap->ifname || tap->ifname[0] == '\0' ||
+        strstr(tap->ifname, "%d") != NULL) {
+        /*
+         * It's hard to postpone logic of parsing template or
+         * absent ifname
+         */
+        return 1;
+    }
+
+    /*
+     * It's not simple to support downscript for backend transfer migration,
+     * so for simplicity, let's not support postponed connect in case of
+     * any scripts given.
+     */
+    if (!check_no_script(tap->script) || !check_no_script(tap->downscript)) {
+        return 1;
+    }
+
+    for (int i = 0; i < queues; i++) {
+        TAPState *s = net_tap_new(peer, "tap", name, tap, NULL, errp);
+        if (!s) {
+            return -1;
+        }
+
+        s->vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
+        s->vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+        s->mq_required = queues > 1;
+        s->ifname = g_strdup(tap->ifname);
+        qemu_set_info_str(&s->nc, "ifname=%s,script=no,downscript=no",
+                          tap->ifname);
+    }
+
+    return 0;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -875,6 +981,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    ret = tap_postpone_init(tap, name, peer, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
     if (tap->fd) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-- 
2.48.1


