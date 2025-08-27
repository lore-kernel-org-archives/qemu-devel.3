Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83865CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 13:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urGU1-0004MS-Ld; Wed, 27 Aug 2025 09:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urGTn-0004IM-Nj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 09:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urGTj-0000Uf-0C
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 09:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756302375;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H2TXyYaUWNdhTjyNwwfNOJcCpALidzPeYS8+Sz7i1ms=;
 b=B0diubtNrDK+GU8HDMcbT1jRB+vT0HoD2a2F7u78pMM0L0mH+i5//o89XcMbPAsO/UbrzP
 K4sRoMtKAH/qUAGIQXCZ7V1oXeUwoKLd3UAvr2MXk4+wzPp4BFb+4JnmoM543stxpvO7Q3
 q8iSW85JemhL3ZleQ6rRlPxGWjCMHPk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-3Hqa25lFNjm1mS9Zdzcygw-1; Wed,
 27 Aug 2025 09:46:10 -0400
X-MC-Unique: 3Hqa25lFNjm1mS9Zdzcygw-1
X-Mimecast-MFC-AGG-ID: 3Hqa25lFNjm1mS9Zdzcygw_1756302369
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 418681800285; Wed, 27 Aug 2025 13:46:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9458A30001A5; Wed, 27 Aug 2025 13:46:07 +0000 (UTC)
Date: Wed, 27 Aug 2025 14:46:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/display: Support per-head resolutions with
 virtio-gpu
Message-ID: <aK8MHGgp-Dm_Lkmb@redhat.com>
References: <20250722190824.3419413-1-ankeesler@google.com>
 <20250722190824.3419413-2-ankeesler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722190824.3419413-2-ankeesler@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Jul 22, 2025 at 07:08:24PM +0000, Andrew Keesler wrote:
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
> If no virtio_gpu_base_conf.outputs are provided, then
> virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
> respected, preserving backwards compatibility.

IIUC from the current code, xres/yres are only set against the
first head. The 2nd and later heads are left undefined by the
virtio-gpu-base code at least - I'm unclear if something else
in QEMU will fill in defaults later, or if they set to 0x0.

> Otherwise, if any virtio_gpu_base_conf.outputs are provided, then
> virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
> will take precedence. In this case,
> virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
> must be non-zero.

Makes sense.

> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> ---
>  hw/display/virtio-gpu-base.c | 12 ++++++++++++
>  qapi/virtio.json             |  6 +++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 7269477a1c..1fc879cc93 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -206,6 +206,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>                         node->value->name, EDID_NAME_MAX_LENGTH);
>              return false;
>          }
> +        if (node->value && !(node->value->xres && node->value->yres)) {
> +            error_setg(errp, "invalid resolution == 0");
> +            return false;
> +        }
>      }
>  
>      if (virtio_gpu_virgl_enabled(g->conf)) {
> @@ -233,6 +237,14 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
>  
> +    for (output_idx = 0, node = g->conf.outputs;
> +         node && output_idx < g->conf.max_outputs;
> +         output_idx++, node = node->next) {
> +        g->enabled_output_bitmask |= (1 << output_idx);

This change means that all heads are enabled by default if the 'outputs'
property array is set, which is a semantic difference from the previous
behaviour before xres/yres are added as properties.

Is it relevant to set xres/yres on outputs, even when they are
not (yet) enabled ?  Perhaps we should have an explicit 'enabled: bool'
property in the 'outputs' struct ?

> +        g->req_state[output_idx].width = node->value->xres;
> +        g->req_state[output_idx].height = node->value->yres;
> +    }

For head 0, this is overwriting the defaults set a few lines
earlier.

I think we should probably report an error if xres / yres
are set at the global level and also set against any individual
output, so the two approaches are mutually exclusive.

>      g->hw_ops = &virtio_gpu_ops;
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..36581690c7 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,11 +970,15 @@
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels
> +#
> +# @yres: vertical resolution of the output in pixels
> +#

Sorry, we missed the boat for 10.1, so these two new properties
will require an explicit "Since 10.2" tag against them, separate
from the overall struct versrion below.

>  # Since: 10.1
>  ##
>  
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', 'xres': 'uint16', 'yres': 'uint16' } }

This is a backcompat problem, because xres/yres are mandatory if
'outputs' is present.

$ ./qemu-system-x86_64 -device '{"driver":"virtio-vga","outputs":[{"name":"AAA"},{"name":"BBB"}],"max_outputs":2,"id":"v0"}'
qemu-system-x86_64: -device {"driver":"virtio-vga","outputs":[{"name":"AAA"},{"name":"BBB"}],"max_outputs":2,"id":"v0"}: Parameter 'outputs[0].xres' is missing

These need to be marked optional, to be compatible with existing use
of 'outputs' from the 10.1.0 release.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


