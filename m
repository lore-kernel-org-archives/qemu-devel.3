Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F77BC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEnoJ-00084M-0e; Wed, 05 Jun 2024 06:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEnoD-00082y-LG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEnoB-0001eH-2r
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717583033;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BKfA898JMMFsYzp/fngAksxsx5GUZp6ZyO/aC0pAqp8=;
 b=Fhoqzptl43xbD/Ig9OGzljqOzZEQOFVGiza63XCI+NE+PyorB1kETVv6p2akXwQNuWifdm
 dTqGBFoXM+iu+XpZxEPL0l7wENylSi+0gdAHPMmbkADWtQah09z00u6X9zIXNCfqv9/aR7
 mtJYqb5t4RIHUX0PYZeLvT9ZgBRq7aY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-tZQjdSBhMWm2JgGrVIabFQ-1; Wed,
 05 Jun 2024 06:23:50 -0400
X-MC-Unique: tZQjdSBhMWm2JgGrVIabFQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61D6D1944DC6; Wed,  5 Jun 2024 10:23:49 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.183])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D71C1956086; Wed,  5 Jun 2024 10:23:46 +0000 (UTC)
Date: Wed, 5 Jun 2024 11:23:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PULL 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
Message-ID: <ZmA8r20rrbCxKMEY@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-8-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604073755.1859-8-jasowang@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 04, 2024 at 03:37:42PM +0800, Jason Wang wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Propagating ebpf-rss-fds errors has several problems.
> 
> First, it makes device realization fail and disables the fallback to the
> conventional eBPF loading.

AFAICT, this is not a bug - this is desired behaviour.

If the user/mgmt app has told QEMU to use FDs it has passed
in, then any failure to do this *MUST* be treated as a fatal
error. Falling back to other codepaths is ignoring a direct
user request.

> Second, it leaks memory by making device realization fail without
> freeing memory already allocated.
> 
> Third, the convention is to set an error when a function returns false,
> but virtio_net_load_ebpf_fds() and virtio_net_load_ebpf() returns false
> without setting an error, which is confusing.
> 
> Remove the propagation to fix these problems.

It doesn't fix the problems. It ignores the 2nd and 3rd problems
by removing the error reporting and ignoring the users' requested
config.

> 
> Fixes: 0524ea0510a3 ("ebpf: Added eBPF initialization by fds.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ff600b3002..3cee2ef3ac 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1329,24 +1329,22 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
>      virtio_net_attach_ebpf_to_backend(n->nic, -1);
>  }
>  
> -static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
> +static bool virtio_net_load_ebpf_fds(VirtIONet *n)
>  {
>      int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
>      int ret = true;
>      int i = 0;
>  
> -    ERRP_GUARD();
> -
>      if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
> -        error_setg(errp,
> -                  "Expected %d file descriptors but got %d",
> -                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
> +        warn_report("Expected %d file descriptors but got %d",
> +                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
>         return false;
>     }
>  
>      for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
> -        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
> -        if (*errp) {
> +        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
> +                                  &error_warn);
> +        if (fds[i] < 0) {
>              ret = false;
>              goto exit;
>          }
> @@ -1355,7 +1353,7 @@ static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
>      ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
>  
>  exit:
> -    if (!ret || *errp) {
> +    if (!ret) {
>          for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
>              close(fds[i]);
>          }
> @@ -1364,13 +1362,12 @@ exit:
>      return ret;
>  }
>  
> -static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
> +static bool virtio_net_load_ebpf(VirtIONet *n)
>  {
>      bool ret = false;
>  
>      if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
> -        if (!(n->ebpf_rss_fds
> -                && virtio_net_load_ebpf_fds(n, errp))) {
> +        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
>              ret = ebpf_rss_load(&n->ebpf_rss);
>          }
>      }
> @@ -3809,7 +3806,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      net_rx_pkt_init(&n->rx_pkt);
>  
>      if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_load_ebpf(n, errp);
> +        virtio_net_load_ebpf(n);
>      }
>  }
>  
> -- 
> 2.42.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


