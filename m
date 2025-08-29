Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC8CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9C-0002zG-C4; Sat, 30 Aug 2025 11:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruJw-00071x-OS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruJu-0004Hf-Hd
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756455529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3dKXbQsC7E0WoVlYtV0s9sQxLTGP2jFFvYRfZXCaGiY=;
 b=Kd85f0iWZRcGy2Fn7nvj4PjI/r+a83kbBooetNkEm7utUM6uwNc8RePnGTuaKG4uhqro5L
 AThvgB2GMXi7SbuyliaDGwqliCXBEVo6BVM/8ZH6AQ9jnAkemO6pbqmX9IukkBxNWeRbVd
 uFJfiNGX+aT0LZm/TBifIp6FZSSoirI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-dUNbu2VDNpGLHzjF9_iGlQ-1; Fri,
 29 Aug 2025 04:18:46 -0400
X-MC-Unique: dUNbu2VDNpGLHzjF9_iGlQ-1
X-Mimecast-MFC-AGG-ID: dUNbu2VDNpGLHzjF9_iGlQ_1756455526
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92DA195C279; Fri, 29 Aug 2025 08:18:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B9F1956095; Fri, 29 Aug 2025 08:18:43 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:18:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] Support per-head resolutions with virtio-gpu
Message-ID: <aLFiYBMSZ95b0VLo@redhat.com>
References: <20250828175259.3831672-1-ankeesler@google.com>
 <20250828175259.3831672-2-ankeesler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828175259.3831672-2-ankeesler@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 28, 2025 at 05:52:59PM +0000, Andrew Keesler wrote:
> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
> 
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
> 
>   -display vnc=localhost:0,id=aaa,display=vga,head=0 \
>   -display vnc=localhost:1,id=bbb,display=vga,head=1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>                  "xres":111,
>                  "yres":222
>               },
>               {
>                  "name":"BBB",
>                  "xres":333,
>                  "yres":444
>               }
>             ]}'
> 
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
> 
> Case: !(xres || yres) && !(outputs[i].xres || outputs[i].yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
> 
> Case: (xres || yres) && !(outputs[i].xres || outputs[i].yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
> 
> Case: !(xres || yres) && (outputs[i].xres || outputs[i].yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> 
> Case: (xres || yres) && (outputs[i].xres || outputs[i].yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
> ---
>  hw/display/virtio-gpu-base.c   | 10 ++++++++++
>  include/hw/virtio/virtio-gpu.h |  2 ++
>  qapi/virtio.json               |  6 +++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 7269477a1c..8bcbe5e837 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
>  
> +    for (output_idx = 0, node = g->conf.outputs;
> +         node && output_idx < g->conf.max_outputs;
> +         output_idx++, node = node->next) {
> +        if (node->value->xres || node->value->yres) {

This should be

         if (node->value->has_xres && node->value->has_yres) {

> +            g->enabled_output_bitmask |= (1 << output_idx);
> +            g->req_state[output_idx].width = node->value->xres;
> +            g->req_state[output_idx].height = node->value->yres;
> +        }
> +    }
> +
>      g->hw_ops = &virtio_gpu_ops;
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 9f16f89a36..7597e87971 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -129,6 +129,8 @@ struct virtio_gpu_base_conf {
>      uint32_t xres;
>      uint32_t yres;
>      uint64_t hostmem;
> +    // If set, outputs[i].xres/yres takes precedent over xres/yres and enables
> +    // the ith output.

I mean for that doc to be in the virtio.json file, so it gets into
the public QMP API documentation

>      VirtIOGPUOutputList *outputs;
>  };
>  
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..9f753543cb 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,11 +970,15 @@
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)
> +#
>  # Since: 10.1
>  ##
>  
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>  
>  ##
>  # @DummyVirtioForceArrays:
> -- 
> 2.51.0.338.gd7d06c2dae-goog
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


