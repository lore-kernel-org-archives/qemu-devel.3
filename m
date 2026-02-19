Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A33E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2dN-0004Pm-2C; Thu, 19 Feb 2026 06:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt2dB-0004NN-JQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:55:42 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt2d8-0006DE-8z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:55:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 92D5080878;
 Thu, 19 Feb 2026 14:55:36 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VtZwpM4A6uQ0-lpbtJ6aw; Thu, 19 Feb 2026 14:55:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771502136;
 bh=fF0WU7Y5ApYR2lkAVIV/MqBLwBoq0YXSQE5sJlwnsPM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uFY82wqLwx2GK6Ar9Pt93oNYlU/mqfxZPsCqOzQSkdtch//Fmxp8H0N61Vk4LIaKJ
 6i85djid4dg43ruC7QC2U3SZNAJ0ye4sjyObFRIUCJBtuhHN183Rgj4Ovw9EXumwgc
 lnyndiddghYqo6875DmxCBIweiUmNaenVAglhypg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: thuth@redhat.com, armbru@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v11 2/8] net/tap: move vhost initialization to
 tap_setup_vhost()
Date: Thu, 19 Feb 2026 14:55:23 +0300
Message-ID: <20260219115530.2019498-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
References: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 net/tap.c | 62 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 1245b98408..294ca61f8b 100644
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
@@ -702,6 +704,38 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
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
@@ -736,30 +770,10 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
2.52.0


