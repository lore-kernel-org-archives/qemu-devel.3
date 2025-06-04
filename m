Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C52C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmJK-0004Pc-An; Wed, 04 Jun 2025 07:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJI-0004PH-48
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:32 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJE-0005eQ-6G
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=UCynmRg/Gc/s2iIKVark8bFPSmHiNX1WPuu9/tJlxrI=; b=I3inDduD3GPSNEoK/5zESE74zA
 dhIwZUPn4KyPD7NjoiDjnk1PhENNyee8Q2PK/Y6rMmJGb0J5tgJJ3yHFY9SBXgUW3ZTRoIrohdm8K
 4aISz/oZzTIkgHvMM79H3OJkYGvZyPb+/n/K6EV13cWbaVLs+SJz2A1CQ9hqlxsfRA7hYtccTh3Qv
 X9samcdLvH3JJZ5XVD8Paf/2/JPs4zRbL4kBhf1viaNNGiIi2jThA7QtHaw/RJ6jrWFc3s2XkkhUO
 0EQWwdvVQrBADKdprq/VfBmZEBkowBhHouOFrjQ8u+um+4Du4BuHSU15JivtyEuHn+v2UyLEg73Xz
 XQ627zYg==;
Received: from localhost ([127.0.0.1])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uMmJ3-0001Fp-0H; Wed, 04 Jun 2025 13:29:17 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 2/2] net/af-xdp: Fix up cleanup path upon failure in queue
 creation
Date: Wed,  4 Jun 2025 13:29:16 +0200
Message-ID: <20250604112916.1195368-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604112916.1195368-1-daniel@iogearbox.net>
References: <20250604112916.1195368-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27658/Wed Jun  4 10:36:16 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While testing, it turned out that upon error in the queue creation loop,
we never trigger the af_xdp_cleanup() handler. This is because we pass
errp instead of a local err pointer into the various AF_XDP setup functions
instead of a scheme like:

    bool fn(..., Error **errp)
    {
        Error *err = NULL;

        foo(arg, &err);
        if (err) {
            handle the error...
            error_propagate(errp, err);
            return false;
        }
        ...
    }

With a conversion into the above format, the af_xdp_cleanup() handler is
called as expected. Also, making sure the XDP program will be removed does
require to set s->n_queues to i + 1 since the test is nc->queue_index ==
s->n_queues - 1, where nc->queue_index was set to i earlier. With both
fixed the cleanup triggers as expected. Note the error_propagate() handles
a NULL err internally.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
---
 net/af-xdp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index b83d9bc47f..5d9857fdd8 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -559,12 +559,11 @@ int net_init_af_xdp(const Netdev *netdev,
             s->map_start_index = opts->map_start_index;
         }
 
-        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp) ||
-            af_xdp_socket_create(s, opts, errp) ||
-            af_xdp_update_xsk_map(s, errp)) {
+        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
+            af_xdp_socket_create(s, opts, &err) ||
+            af_xdp_update_xsk_map(s, &err)) {
             /* Make sure the XDP program will be removed. */
-            s->n_queues = i;
-            error_propagate(errp, err);
+            s->n_queues = i + 1;
             goto err;
         }
     }
@@ -586,6 +585,7 @@ int net_init_af_xdp(const Netdev *netdev,
 err:
     if (nc0) {
         qemu_del_net_client(nc0);
+        error_propagate(errp, err);
     }
 
     return -1;
-- 
2.43.0


