Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2126DC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKHA-0005Lj-2o; Tue, 06 Aug 2024 09:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbKH1-0005AA-7o
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbKGz-0006AH-Ep
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722951044;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=v6EtI4825o7zfeXYMcpDE2BgJvWmzAELY6slBuOpxMk=;
 b=fNBKVhRLsIWZUFzm1L4r9MKqbkRdEj74mUDtG9oMi7Z2YsvAhr9Ig/805rB8aSpiRyDBnt
 FbUgWG1ktWZ/dNudnQYmEPeEJ2aX4Jxw1UMmaS28QugaNyz7Iv4yiB0UFrXlyySEx/Osef
 S9M7kMp62iy6HWqWwVW0XF3x6iF/oyQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-mNku20iKP1i9JaQ0meO0pA-1; Tue,
 06 Aug 2024 09:30:42 -0400
X-MC-Unique: mNku20iKP1i9JaQ0meO0pA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 568A9195422A; Tue,  6 Aug 2024 13:30:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0FBD19560AA; Tue,  6 Aug 2024 13:30:37 +0000 (UTC)
Date: Tue, 6 Aug 2024 14:30:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Zhibin Hu <huzhibin5@huawei.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 2/8] virtio-net: Ensure queue index fits with RSS
Message-ID: <ZrIlej6y0fTLZ_JZ@redhat.com>
References: <20240802031929.44060-1-jasowang@redhat.com>
 <20240802031929.44060-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802031929.44060-3-jasowang@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 02, 2024 at 11:19:23AM +0800, Jason Wang wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Ensure the queue index points to a valid queue when software RSS
> enabled. The new calculation matches with the behavior of Linux's TAP
> device with the RSS eBPF program.
> 
> Fixes: 4474e37a5b3a ("virtio-net: implement RX RSS processing")
> Reported-by: Zhibin Hu <huzhibin5@huawei.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

FYI, this patch is the fix for CVE-2024-6505.

Please make sure to mention CVE assignments in the commit message
when one is available.

> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 8f30972708..5635620a31 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1905,7 +1905,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
>          int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
>          if (index >= 0) {
> -            NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
> +            NetClientState *nc2 =
> +                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
>              return virtio_net_receive_rcu(nc2, buf, size, true);
>          }
>      }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


