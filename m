Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D50CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6M-00084B-O8; Fri, 10 Oct 2025 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6H-0007zF-VA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:19 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6A-0007RY-OL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2E5F9806FA;
 Fri, 10 Oct 2025 20:40:05 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-DvJXLtwd; Fri, 10 Oct 2025 20:40:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118004;
 bh=sWnY8ZzMlkKOLKPtaKjH3fVS/aysz4QqO5yCpSiiFBE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BEcx68vKSJlYfP3Ryq1HWQbwx/58Mcu1O9ZC+bajTVDzGuy7ev3KTuV/hksftCqND
 lsWxz9brUwXnZCgSOKAUS9c1p8bxLYeb2vH6FQdkstuP55vKim9iz7b0MPBDG36h9Z
 lX5NexUIE7R0SygyFXDnFFla8APyM3YuJp3mXQYE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 03/19] net/tap: rework net_tap_init()
Date: Fri, 10 Oct 2025 20:39:41 +0300
Message-ID: <20251010173957.166759-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010173957.166759-1-vsementsov@yandex-team.ru>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f90050c3a0..b1b64c508d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -655,20 +655,12 @@ int net_init_bridge(const Netdev *netdev, const char *name,
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
@@ -977,6 +969,8 @@ free_fail:
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
+        bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
@@ -997,7 +991,9 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+            vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+            fd = net_tap_open(&vnet_hdr, vnet_hdr_required,
+                              i >= 1 ? "no" : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
-- 
2.48.1


