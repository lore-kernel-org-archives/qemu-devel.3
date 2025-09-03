Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B392CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utng3-0005Ef-HD; Wed, 03 Sep 2025 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfu-00059L-Jl
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfp-0004tQ-Sc
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BDC2BC019B;
 Wed, 03 Sep 2025 16:37:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-AX9ikqZl; Wed, 03 Sep 2025 16:37:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906634;
 bh=3kTD8LHMLe7WQJ1Cy0sH9HJeNgscWdXUbDRna1jwCKA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mrCFFCjLEkTQno36xFOUtOIJD+TuS0ZvEe2IxMaW5Y7ByNbZwD0JZKWiC5Iu6mzFX
 GIixc1POq6nrpWqUNL4iSYB4pW0erE7YmB0NaCWinjS1960s92azqcWcA1eCFNjyYl
 6HP4MS9fgLKzznYI2YinOZ/jh4CcSPP+aF2mcFhk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 2/8] net/tap: keep exit notifier only when downscript set
Date: Wed,  3 Sep 2025 16:36:59 +0300
Message-ID: <20250903133706.1177633-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
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

The notifier is used only to call the downscript. Avoid extra
notifier for other cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 224fb37310..7dc8af1e57 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -384,8 +384,10 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_purge_queued_packets(nc);
 
-    tap_exit_notify(&s->exit, NULL);
-    qemu_remove_exit_notifier(&s->exit);
+    if (s->exit.notify) {
+        tap_exit_notify(&s->exit, NULL);
+        qemu_remove_exit_notifier(&s->exit);
+    }
 
     tap_read_poll(s, false);
     tap_write_poll(s, false);
@@ -775,9 +777,7 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
     }
     tap_read_poll(s, true);
     s->vhost_net = NULL;
-
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
+    s->exit.notify = NULL;
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         const NetdevBridgeOptions *bridge = &netdev->u.bridge;
@@ -805,6 +805,8 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
                      "%s", ifname);
+            s->exit.notify = tap_exit_notify;
+            qemu_add_exit_notifier(&s->exit);
         }
     }
 
-- 
2.48.1


