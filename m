Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78525CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vs-0001Z8-R8; Mon, 18 Aug 2025 10:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vp-0001MY-7m
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vm-0002Ct-JN
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 32FB6807D1;
 Mon, 18 Aug 2025 17:06:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-Mp3KS07W; Mon, 18 Aug 2025 17:06:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526011;
 bh=CRFGK6nZULMxIVw/18pY4S5gebSM3w3PMN2fT81y9NE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=n3Bmz+R7rhNgPj10a7pJ61XrJusDJEAKwGVlOr7feaq+2yYvSrMBwdoDpKlwh0rsv
 +qbS5cJypXrF1FZXfJB00a++VXXIVLw3CGfP53epEkaru16QhgShGFeIYXbsabdMAD
 GXFYywEfQ2oKQpxwhs7NmAij+mXmP1ejpf7cD5Fk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 14/19] net/tap: refactor net_tap_init() into net_tap_open_one()
Date: Mon, 18 Aug 2025 17:06:40 +0300
Message-ID: <20250818140645.27904-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

net_tap_init() is used in one place. Let's move net_init_tap_one()
call to it and simplify outer loop code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 83a1c9250a..2cffa880a4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -674,31 +674,37 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     return 0;
 }
 
-static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
-                        const char *setup_script, char *ifname,
-                        size_t ifname_sz, int mq_required, Error **errp)
+static int net_tap_open_one(const Netdev *netdev,
+                            const char *name, NetClientState *peer,
+                            const char *script, const char *downscript,
+                            char *ifname, size_t ifname_sz,
+                            int mq_required, Error **errp)
 {
+    const NetdevTapOptions *tap = &netdev->u.tap;
     Error *err = NULL;
-    int fd, vnet_hdr_required;
+    int fd, vnet_hdr_required, vnet_hdr;
+    int ret;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
 
     if (tap->has_vnet_hdr) {
-        *vnet_hdr = tap->vnet_hdr;
-        vnet_hdr_required = *vnet_hdr;
+        vnet_hdr = tap->vnet_hdr;
+        vnet_hdr_required = vnet_hdr;
     } else {
-        *vnet_hdr = 1;
+        vnet_hdr = 1;
         vnet_hdr_required = 0;
     }
 
-    fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, vnet_hdr, vnet_hdr_required,
-                      mq_required, errp));
+    fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, &vnet_hdr,
+                                 vnet_hdr_required, mq_required, errp));
     if (fd < 0) {
         return -1;
     }
 
-    if (setup_script &&
-        setup_script[0] != '\0' &&
-        strcmp(setup_script, "no") != 0) {
-        launch_script(setup_script, ifname, fd, &err);
+    if (script &&
+        script[0] != '\0' &&
+        strcmp(script, "no") != 0) {
+        launch_script(script, ifname, fd, &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
@@ -706,6 +712,14 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
         }
     }
 
+    ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
+                           script, downscript,
+                           tap->vhostfd, vnet_hdr, fd, errp);
+    if (ret < 0) {
+        close(fd);
+        return -1;
+    }
+
     return fd;
 }
 
@@ -948,20 +962,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
-                              ifname, sizeof ifname, queues > 1, errp);
-            if (fd == -1) {
-                return -1;
-            }
-
-            ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
+            ret = net_tap_open_one(netdev, name, peer,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
-                                   tap->vhostfd, vnet_hdr, fd, errp);
+                                   ifname, sizeof ifname, queues > 1, errp);
             if (ret < 0) {
-                close(fd);
                 return -1;
             }
+
         }
     }
 
-- 
2.48.1


