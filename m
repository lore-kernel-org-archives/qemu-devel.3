Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F1C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0MJ-0003jT-C8; Wed, 29 Jul 2026 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0MG-0003h8-5K
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:48 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0ME-0004vK-HL
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:13:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 3C784C0A4A;
 Wed, 29 Jul 2026 12:13:45 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bDa8GXKW9mI0-VDrL8TNB; Wed, 29 Jul 2026 12:13:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785316424;
 bh=gFmS/DTgG7tyPtgCYFw5DCDtqJUxh70iPyjnvtCIY7k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xQmWpEpbI5rQCjvwEdR54/vBqHeaFzjOM6B0UsyQf44mTN5i6eNMWQB2lkeFTOLer
 Y3iMjQTPDJS11UZ/IlX0vzayooevzVNp4bA/ywrqMCrWmhwgvkpc2OfIp5Y1XSSqd9
 tYO7phoIUPJDtB3+eHSfqGG+M1Bxqy/g98jPWpwc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v20 05/15] net/tap: move vhost initialization to
 tap_setup_vhost()
Date: Wed, 29 Jul 2026 12:12:43 +0300
Message-ID: <20260729091334.1863155-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Make a new helper function in a way it can be reused later for
TAP fd-migration feature: we'll need to initialize vhost in a later
point when we doesn't have access to QAPI parameters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 62 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index bec2cd48fd3..f2b571dd116 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -71,6 +71,8 @@ static const int kernel_feature_bits[] = {
 typedef struct TAPState {
     NetClientState nc;
     int fd;
+    int vhostfd;
+    uint32_t vhost_busyloop_timeout;
     char down_script[1024];
     char down_script_arg[128];
     uint8_t buf[NET_BUFSIZE];
@@ -722,6 +724,38 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     return fd;
 }
 
+static bool tap_setup_vhost(TAPState *s, Error **errp)
+{
+    VhostNetOptions options;
+
+    if (s->vhostfd == -1) {
+        return true;
+    }
+
+    options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
+    options.net_backend = &s->nc;
+    options.busyloop_timeout = s->vhost_busyloop_timeout;
+    options.opaque = (void *)(uintptr_t)s->vhostfd;
+    options.nvqs = 2;
+    options.feature_bits = kernel_feature_bits;
+    options.get_acked_features = NULL;
+    options.save_acked_features = NULL;
+    options.max_tx_queue_size = 0;
+    options.is_vhost_user = false;
+
+    s->vhost_net = vhost_net_init(&options);
+    if (!s->vhost_net) {
+        error_setg(errp,
+                   "vhost-net requested but could not be initialized");
+        return false;
+    }
+
+    /* vhostfd ownership is passed to s->vhost_net */
+    s->vhostfd = -1;
+
+    return true;
+}
+
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *name,
                              const char *ifname, const char *script,
@@ -756,30 +790,10 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (vhostfd != -1) {
-        VhostNetOptions options;
-
-        options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
-        options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
-        options.opaque = (void *)(uintptr_t)vhostfd;
-        options.nvqs = 2;
-        options.feature_bits = kernel_feature_bits;
-        options.get_acked_features = NULL;
-        options.save_acked_features = NULL;
-        options.max_tx_queue_size = 0;
-        options.is_vhost_user = false;
-
-        s->vhost_net = vhost_net_init(&options);
-        if (!s->vhost_net) {
-            error_setg(errp,
-                       "vhost-net requested but could not be initialized");
-            goto failed;
-        }
+    s->vhostfd = vhostfd;
+    s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
+    if (!tap_setup_vhost(s, errp)) {
+        return false;
     }
 
     return true;
-- 
2.43.0


