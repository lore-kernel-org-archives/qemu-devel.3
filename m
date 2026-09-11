Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58EBC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x90-00023F-Ca; Fri, 11 Sep 2026 05:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8y-0001yv-Ce
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8w-000867-6l
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=FqS4v9Xk8K8XZ8Qt4aLxjnWcCCNxAwi/ILQPju75FtIqSpvpWE+rkiMCo+qPjTHcNmGWM3
 kYYWxpYdhU10lrkCshbqQTqafDn5hwSXSRFqfXF7TFhXwbgAq8KrjTVZBPSHia2K1lHbR7
 SHZlqzgmrcvZ90zmwBtvdZ4Wg1e+u3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-qGiCWp0ZPZ--uwhDSCuVtQ-1; Fri, 11 Sep 2026 05:01:55 -0400
X-MC-Unique: qGiCWp0ZPZ--uwhDSCuVtQ-1
X-Mimecast-MFC-AGG-ID: qGiCWp0ZPZ--uwhDSCuVtQ_1789117315
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so14503795e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117315; x=1789722115; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=el4ECAi3wleNb15aogRfP4zNqCmT2ao/tSALd6zyhKaASOJJ7hzl6cVgPb4tfkgvH4
 9rzj9IzL8wa4Z5H6MzMS8L/5mawg8VBRAeciPXVXgSn5+SqcV569i+i5f5fxbLAC6vzB
 1lHWh0mjZ4dcHs+MZiQ10FH8L5cPaX3FyTZjCXFtP6/77ECYg5sQwZcuFEC/R+xqf2RN
 MZ9ShXqyGIazGpnZ8DNHq+8N+JszhPR6rky9iDo8HtWJyJSMr0pwm7201SIScz1SeKrB
 0PVQQ4o+lNuiTptg4YlLwonmEufl4XtJuEtEAEjnb82B3vAx18BfVE1Aey68BurpPsWP
 hO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117315; x=1789722115;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=n3hIlWQwbiwe0UPYbgjnJ44aQhMyz/GkIVY7oqcDHxDCOQcukLeiS6ZmW5TGS1sZ2l
 z6YPgYvd04JUBNnu/9c8AFfhhYumt7MCPZpIUYifl/kknQ56NTWvAmBUu/k2FswKJrMA
 uLdLXea9OBz6X+Vsxj76IVqadyaBmJtzudxbbRunwDw/9SbObyvVlcH+Ld4Od4bux9DJ
 syTRgrLhtd6HSIq3rKIr7OQXOdcKNs2uT9KzOqPxJRUc1CTtoKgGTY3ZZNMg2rbjHPXj
 LW4u+D/FotnCC5KE7/u7UDiZtKP+pKBC47KX6zNPdo0TTlErBIxXFgcko+JivdBLP8Pc
 Z1hg==
X-Gm-Message-State: AFuF++lmsYSJPAeMuhQYeygyz3d0cB+opETygOXs4jNEwxqtWRMuW16k
 nPP1VqBYnqUk1YAgn0DKZbcaiolOfHwoXktafB2vVLa2HIZjcDpHKoRUSMnR50Vtqom73SembcM
 KwXwLRXh3Ip4Jz4UmglkhGttgeMVPugK4o7w06gaGVmxPdas/gXjtEwr3GBmu5A3rT+8pH/+LMp
 fupUb4kvli+y6CgrToR9TnakUAK6cj/rrVAA==
X-Gm-Gg: AYBFou1VFZN7utWxC/eHTdQhjI1F/EomY6qSFpi5/7CHsJlX+3CQiEYbZC3FjPA49fA
 mD0cvWTl/YZ9+1bIM0xKhfgZZIDrtpAMEp03uQ5sTwM69y5Ot68xwwi3uBYK04eZXbwuEsFqwya
 K6k8BwkX5jwX2CYPLDv248sM40a7wXyvR1Toj7egTM6RhFimjbcv9aCvmBt+EJDiRVEk7ASDFrO
 sF9eTSgOcXH3QYLouMIpdhtz4B1J6rMNuZwQk7RfIi+1W+rLUsT00hUIRj1xwcuEWheiyL+bo51
 fVBHABdLxdH9h638bkZWA2Wpn05hRATqolJm67SN0LYmaT6ur3fStaPCPcT+zbTzYjtffUxin4C
 g+fEpeZBzIuQEUERR0EgID6M=
X-Received: by 2002:a05:600c:e547:20b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49e63cc640dmr14197015e9.6.1789117314527; 
 Fri, 11 Sep 2026 02:01:54 -0700 (PDT)
X-Received: by 2002:a05:600c:e547:20b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-49e63cc640dmr14196235e9.6.1789117313851; 
 Fri, 11 Sep 2026 02:01:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm128642625e9.13.2026.09.11.02.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:53 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 14/75] net/tap: use container_of instead of DO_UPCAST
Message-ID: <e0b1678562f300403ce1c2e667b3a0d94ac4a513.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We are going to QOMify tap backend, which includes deriving TAPState
from Object. So "NetClientState nc" will not be a first member.
Let's parepare for this change, and use container_of(), which will
work regardless position of "nc" field.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-7-vsementsov@yandex-team.ru>
---
 net/tap.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f2b571dd11..bfed74717e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -175,7 +175,7 @@ static ssize_t tap_write_packet(TAPState *s, const struct iovec *iov, int iovcnt
 static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
                                int iovcnt)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr hdr = { };
@@ -211,7 +211,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 
 static void tap_send_completed(NetClientState *nc, ssize_t len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, true);
 }
 
@@ -271,7 +271,7 @@ static void tap_send(void *opaque)
 
 static bool tap_has_ufo(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -280,7 +280,7 @@ static bool tap_has_ufo(NetClientState *nc)
 
 static bool tap_has_uso(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -289,7 +289,7 @@ static bool tap_has_uso(NetClientState *nc)
 
 static bool tap_has_tunnel(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->has_tunnel;
@@ -297,7 +297,7 @@ static bool tap_has_tunnel(NetClientState *nc)
 
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -311,7 +311,7 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -322,21 +322,21 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_le(s->fd, is_le);
 }
 
 static int tap_set_vnet_be(NetClientState *nc, bool is_be)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_be(s->fd, is_be);
 }
 
 static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     if (s->fd < 0) {
         return;
     }
@@ -357,7 +357,7 @@ static void tap_exit_notify(Notifier *notifier, void *data)
 
 static void tap_cleanup(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
@@ -381,14 +381,14 @@ static void tap_cleanup(NetClientState *nc)
 
 static void tap_poll(NetClientState *nc, bool enable)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, enable);
     tap_write_poll(s, enable);
 }
 
 static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
     return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
@@ -396,7 +396,7 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 
 int tap_get_fd(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->fd;
 }
@@ -408,7 +408,7 @@ int tap_get_fd(NetClientState *nc)
  */
 static VHostNetState *tap_get_vhost_net(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->vhost_net;
 }
@@ -447,7 +447,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_tap_info, peer, model, name);
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    s = container_of(nc, TAPState, nc);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -1016,7 +1016,7 @@ fail:
 
 int tap_enable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled) {
@@ -1033,7 +1033,7 @@ int tap_enable(NetClientState *nc)
 
 int tap_disable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled == 0) {
-- 
MST


