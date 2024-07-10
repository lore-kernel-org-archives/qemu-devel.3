Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2664DC3DA47
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY8D-0003ox-I0; Wed, 10 Jul 2024 10:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRY7z-0002rI-BE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRY7v-0004UG-IE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720621018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEwMH4aUe0S8Koyu1Ux31ZzcoB926u5SAT1zJIr7HA0=;
 b=gggRfFVAETdMf9rIn3ViGfCxcjFo4YlTDYkZTJ7d3vSuv3VH8RxLWsdjw1qRY28JvtASqr
 SxTG5ekaoVjY9GmW6vzMnFVGgGSFl+t7xMg4TVbfWUfuQgKMNOITdEKrn/Uk0e4sz7wX9r
 bTQgQcOT3+1Y0pr0rrVp0E/H3Vs+ut4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-tof68BT0PAikbi-RUeoATw-1; Wed,
 10 Jul 2024 10:16:55 -0400
X-MC-Unique: tof68BT0PAikbi-RUeoATw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E326E19560A3; Wed, 10 Jul 2024 14:16:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A69801955F40; Wed, 10 Jul 2024 14:16:48 +0000 (UTC)
Date: Wed, 10 Jul 2024 15:16:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] virtio-net: Remove fallback from ebpf-rss-fds
Message-ID: <Zo6XzRyoXsp6FUWu@redhat.com>
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
 <20240708-auto-v2-4-f4908b953f05@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-auto-v2-4-f4908b953f05@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 08, 2024 at 04:38:09PM +0900, Akihiko Odaki wrote:
> If ebpf-rss-fds is specified but we fail to use, we should not fall
> back to loading eBPF programs by ourselves as such makes the situation
> complicated.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e779ba2df428..075c91f037d1 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1396,15 +1396,9 @@ exit:
>  
>  static bool virtio_net_load_ebpf(VirtIONet *n)
>  {
> -    bool ret = false;
> -
> -    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
> -        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
> -            ret = ebpf_rss_load(&n->ebpf_rss);
> -        }
> -    }
> -
> -    return ret;
> +    return virtio_net_attach_ebpf_to_backend(n->nic, -1) &&
> +           (n->ebpf_rss_fds ? virtio_net_load_ebpf_fds(n) :
> +                              ebpf_rss_load(&n->ebpf_rss));
>  }
>  
>  static void virtio_net_unload_ebpf(VirtIONet *n)

The eventual caller has an Error object that needs to be filled with
error details, not warn_report().

IMHO this patch needs to look like this:


diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..c7fd52bbe9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1314,21 +1314,21 @@ static void virtio_net_disable_rss(VirtIONet *n)
     virtio_net_commit_rss_config(n);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        warn_report("Expected %d file descriptors but got %d",
-                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
-       return false;
-   }
+        error_setg(errp, "Expected %d file descriptors but got %d",
+                   EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        return false;
+    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
         fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
-                                  &error_warn);
+                                  errp);
         if (fds[i] < 0) {
             ret = false;
             goto exit;
@@ -1347,14 +1347,15 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
+        if (n->ebpf_rss_fds)
+            ret = virtio_net_load_ebpf_fds(n, errp);
+        else
             ret = ebpf_rss_load(&n->ebpf_rss);
-        }
     }
 
     return ret;
@@ -3750,7 +3751,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        virtio_net_load_ebpf(n, errp);
     }
 }
 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


