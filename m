Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53599CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWK8-0001TZ-FC; Thu, 30 Oct 2025 13:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJS-00017o-1r
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:51 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJ5-0008M6-Cc
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CE26480808;
 Thu, 30 Oct 2025 20:19:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-9JV8PcFe; Thu, 30 Oct 2025 20:19:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844759;
 bh=fUHKAefukzFPik1zAPDmFaZI1FqMXXq3sbBaJu+yMjM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vx2woOqnpPVlNQfz2eKWtc5MFvGfunPMULPVOoD6GW0/Xdv8AAv8SYsEnrRWtxqP2
 IVqNe331OYfb42fm4FUjF5Uy9X5v3i9X9fjZZeSdnvs6Tv7mfhJejfk2I4h/EmcWhh
 jv2vDYeH+si2XQELrSU4C0koHN5c2RIczI+8MPHE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 2/9] net/tap: rework net_tap_init()
Date: Thu, 30 Oct 2025 20:19:07 +0300
Message-ID: <20251030171915.726441-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

In future (to support backend-transfer migration for virtio-net/tap,
which includes fds passing through unix socket) we'll want to postpone
fd-initialization to the later point, when QAPI structured parameters
are not available. So, let's now rework the function to interface
without "tap" parameter.

Also, rename to net_tap_open(), as it's just a wrapper on tap_open(),
and having net_tap_init() and net_init_tap() functions in one file
is confusing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 3bd81883fd..05f7480334 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -668,20 +668,12 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     return 0;
 }
 
-static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
+static int net_tap_open(int *vnet_hdr, bool vnet_hdr_required,
                         const char *setup_script, char *ifname,
                         size_t ifname_sz, int mq_required, Error **errp)
 {
     Error *err = NULL;
-    int fd, vnet_hdr_required;
-
-    if (tap->has_vnet_hdr) {
-        *vnet_hdr = tap->vnet_hdr;
-        vnet_hdr_required = *vnet_hdr;
-    } else {
-        *vnet_hdr = 1;
-        vnet_hdr_required = 0;
-    }
+    int fd;
 
     fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, vnet_hdr, vnet_hdr_required,
                       mq_required, errp));
@@ -989,6 +981,7 @@ free_fail:
             tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
         g_autofree char *downscript =
             tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
+        bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
 
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
@@ -1002,7 +995,9 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
+            vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+            fd = net_tap_open(&vnet_hdr, vnet_hdr_required,
+                              i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
-- 
2.48.1


