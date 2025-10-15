Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7877CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SW-0005T7-FZ; Wed, 15 Oct 2025 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SB-0005JE-Hc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:08 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91Rv-0002zr-OB
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:05 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F11E88A3E;
 Wed, 15 Oct 2025 16:21:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-beisVgbX; Wed, 15 Oct 2025 16:21:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534502;
 bh=sWnY8ZzMlkKOLKPtaKjH3fVS/aysz4QqO5yCpSiiFBE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=m14ODcN+Bk8+KYTpnf4baGLNI7pd+mxsdu/TsnTUsIacllK2pqahsOeB1gXSJ0zEy
 4S7Mw2/NMbs8B3m11OUT+pPAMY9oqisIWOKfvLmv6KayxtyMER+8TDf8uGwK+ypSYF
 EENjnd683gZsHZalLmHyMW7aCJAnuNGBtA1342/k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
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
Subject: [PATCH v8 03/19] net/tap: rework net_tap_init()
Date: Wed, 15 Oct 2025 16:21:19 +0300
Message-ID: <20251015132136.1083972-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


