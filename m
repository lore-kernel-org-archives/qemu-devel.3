Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0467C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAJ0-0005Sn-LX; Fri, 11 Jul 2025 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIw-0005Lj-Qm
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:44:30 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIs-0001HT-VF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+bM6KO5lxBHz9WehrdiB7lnSkdK2h0w2rTSXUNi1Fd0=; b=M4B9ZgfAi4nIfGJOP+4NSq/zm6
 NcA9b8SpvsEEb7fn3kExpjPggt8JiYL7VawANowpFLRw364YEa4f+XHqV7DGSkUzt1TYymyN+0ILJ
 KiZGH10+LF8ISqcpWc3RoYjcg6OIfxEStyI4mz+r7SZyRKUfcxgmK897VPLXybHBc0rrp7gAc1hLx
 WAmSYUEQn8Z1/G9IfIDIyDH6NCJOuHPvCBZ4S5yDx/enQZ0RfQyFqGL7quSgD1VNyUstNQSt3bkJD
 hpgFONsqszglkGHdwCOIY+Z63320oBntkDR7P+qOBTdNWyUJULLndMqD7nhyeEH0PWH5QPaCcpUEE
 0xmibmkA==;
Received: from localhost ([127.0.0.1])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uaAIj-0002n5-2T; Fri, 11 Jul 2025 11:44:17 +0200
To: qemu-devel@nongnu.org
Cc: daniel@iogearbox.net, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 2/3] net/af-xdp: Fix up cleanup path upon failure in queue
 creation
Date: Fri, 11 Jul 2025 11:44:15 +0200
Message-ID: <20250711094416.247125-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711094416.247125-1-daniel@iogearbox.net>
References: <20250711094416.247125-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27695/Thu Jul 10 11:08:41 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The same is true for the attachment probing with bpf_xdp_query_id(). With a
conversion into the above format, the af_xdp_cleanup() handler is called as
expected. Note the error_propagate() handles a NULL err internally.

Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
---
 net/af-xdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index c5d3b6a953..1692efe9f2 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -482,9 +482,8 @@ int net_init_af_xdp(const Netdev *netdev,
         pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
         s->ifindex = ifindex;
 
-        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
-            || af_xdp_socket_create(s, opts, errp)) {
-            error_propagate(errp, err);
+        if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, &err) ||
+            af_xdp_socket_create(s, opts, &err)) {
             goto err;
         }
     }
@@ -492,7 +491,7 @@ int net_init_af_xdp(const Netdev *netdev,
     if (nc0) {
         s = DO_UPCAST(AFXDPState, nc, nc0);
         if (bpf_xdp_query_id(s->ifindex, s->xdp_flags, &prog_id) || !prog_id) {
-            error_setg_errno(errp, errno,
+            error_setg_errno(&err, errno,
                              "no XDP program loaded on '%s', ifindex: %d",
                              s->ifname, s->ifindex);
             goto err;
@@ -506,6 +505,7 @@ int net_init_af_xdp(const Netdev *netdev,
 err:
     if (nc0) {
         qemu_del_net_client(nc0);
+        error_propagate(errp, err);
     }
 
     return -1;
-- 
2.43.0


