Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D8EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPT-0001yL-Qn; Tue, 15 Jul 2025 00:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOv-0001ar-QE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOt-00064g-W6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGCsCUL5qF6MIXdaUO7UwSCz3GEaEBI9T7XGpaS+VSQ=;
 b=LpOSona/Y1xdisVNOIloKfUgtx7ki0yWADFpi8+8xrUGES1ScBe2ucVB/61RMFtPU3j0iG
 V0AEb0FXb5PhEkatQeCs0gTwvxDYOCtHreeVxrspHqHiyE1Y3Rz97UEDeKeu9h4vpch9d1
 SU2iJg5sLOTDQ8EuV7XvZLt+hZ3I0zk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-wf6_gl3XPZWtV_ArOR4Fhg-1; Tue,
 15 Jul 2025 00:36:17 -0400
X-MC-Unique: wf6_gl3XPZWtV_ArOR4Fhg-1
X-Mimecast-MFC-AGG-ID: wf6_gl3XPZWtV_ArOR4Fhg_1752554176
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BB0A195608F; Tue, 15 Jul 2025 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AE4C1977029; Tue, 15 Jul 2025 04:36:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
Subject: [PULL V2 15/16] net/af-xdp: Fix up cleanup path upon failure in queue
 creation
Date: Tue, 15 Jul 2025 12:35:23 +0800
Message-ID: <20250715043524.21719-16-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Anton Protopopov <aspsk@isovalent.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/af-xdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 3d3268e18b..cbe1cae700 100644
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
2.42.0


