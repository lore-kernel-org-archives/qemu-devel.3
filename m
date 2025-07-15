Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F5AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPT-0001xd-4i; Tue, 15 Jul 2025 00:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOu-0001ZP-FG
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOs-00064U-He
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDqO+8Rqs4+HyIcE4v6ujqTUDnN0150WYetqM62Wi6Q=;
 b=WeBPWvWMV6qje/4Liu3o0g0D059OpmRv7eP3255DwzAFDY6iV6ZjhHr2k+CvwrYablNVFE
 P3NPmwmI07fkUaFZzARDVt8nQRs90Ih7e3lIaHGbrIl6UtmBxMDREeTvqzxrjpP8ceFUqQ
 x50bLS7nlbo06nYUnXvr8VUqrQC7ess=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-iAs9QhQ4Nz6u1hdTATNq7w-1; Tue,
 15 Jul 2025 00:36:13 -0400
X-MC-Unique: iAs9QhQ4Nz6u1hdTATNq7w-1
X-Mimecast-MFC-AGG-ID: iAs9QhQ4Nz6u1hdTATNq7w_1752554172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FDCE18089B5; Tue, 15 Jul 2025 04:36:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2486B1977000; Tue, 15 Jul 2025 04:36:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PULL V2 14/16] net/af-xdp: Remove XDP program cleanup logic
Date: Tue, 15 Jul 2025 12:35:22 +0800
Message-ID: <20250715043524.21719-15-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Borkmann <daniel@iogearbox.net>

There are two issues with the XDP program removal in af_xdp_cleanup():

1) Starting from libxdp 1.3.0 [0] the XDP program gets automatically
   detached when we call xsk_socket__delete() for the last successfully
   configured queue. libxdp internally keeps track of that. For QEMU
   we require libxdp >= 1.4.0. Given QEMU is not loading the program,
   lets also not attempt to remove it and delegate this instead.

2) The removal logic is incorrect anyway because we are setting n_queues
   into the last queue that never has xdp_flags on failure, so the logic
   is always skipped since the non-zero test for s->xdp_flags in
   af_xdp_cleanup() fails.

Fixes: cb039ef3d9e3 ("net: add initial support for AF_XDP network backend")
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Link: https://github.com/xdp-project/xdp-tools/commit/38c2914988fd5c1ef65f2381fc8af9f3e8404e2b [0]
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/af-xdp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index d022534d76..3d3268e18b 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -49,7 +49,6 @@ typedef struct AFXDPState {
     char                 *buffer;
     struct xsk_umem      *umem;
 
-    uint32_t             n_queues;
     uint32_t             xdp_flags;
     bool                 inhibit;
 } AFXDPState;
@@ -274,14 +273,6 @@ static void af_xdp_cleanup(NetClientState *nc)
     s->umem = NULL;
     qemu_vfree(s->buffer);
     s->buffer = NULL;
-
-    /* Remove the program if it's the last open queue. */
-    if (!s->inhibit && nc->queue_index == s->n_queues - 1 && s->xdp_flags
-        && bpf_xdp_detach(s->ifindex, s->xdp_flags, NULL) != 0) {
-        fprintf(stderr,
-                "af-xdp: unable to remove XDP program from '%s', ifindex: %d\n",
-                s->ifname, s->ifindex);
-    }
 }
 
 static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
@@ -490,12 +481,9 @@ int net_init_af_xdp(const Netdev *netdev,
 
         pstrcpy(s->ifname, sizeof(s->ifname), opts->ifname);
         s->ifindex = ifindex;
-        s->n_queues = queues;
 
         if (af_xdp_umem_create(s, sock_fds ? sock_fds[i] : -1, errp)
             || af_xdp_socket_create(s, opts, errp)) {
-            /* Make sure the XDP program will be removed. */
-            s->n_queues = i;
             error_propagate(errp, err);
             goto err;
         }
-- 
2.42.0


