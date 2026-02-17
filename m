Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAB8E68143
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGsI-0005GG-Lr; Tue, 17 Feb 2026 03:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGsG-0005Ft-GL
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsGsE-0001zP-TY
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771318562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfC56qoOuHwrNUtAn9JDpBkRQm6xRg1BxZ+CfDCToo4=;
 b=LFgnOqEhC0yQNqydMqIwp6PVQJLWenkfGwr96gpDtM/SLBGUXnaptSvxl3oCXTwgn3HOzk
 rcPL/QYdDEC+hpWR0/8NNxO1RJdn3Ksehvapk120pCb0TTSae2xrDr1AJQ0DImoU+Yp0IB
 Nt7Ez47t+S9Sf6ZZIH6bxgYoQU/QwPg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-vkhuUdd2PgK1z2LbO3WDbQ-1; Tue,
 17 Feb 2026 03:56:00 -0500
X-MC-Unique: vkhuUdd2PgK1z2LbO3WDbQ-1
X-Mimecast-MFC-AGG-ID: vkhuUdd2PgK1z2LbO3WDbQ_1771318559
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C7561955D42; Tue, 17 Feb 2026 08:55:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A59B1955F43; Tue, 17 Feb 2026 08:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A70421E692D; Tue, 17 Feb 2026 09:55:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: alex.bennee@linaro.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/1] Support per-head resolutions with virtio-gpu
In-Reply-To: <20260210123038.2332364-2-ankeesler@google.com> (Andrew Keesler's
 message of "Tue, 10 Feb 2026 12:30:38 +0000")
References: <20260210123038.2332364-1-ankeesler@google.com>
 <20260210123038.2332364-2-ankeesler@google.com>
Date: Tue, 17 Feb 2026 09:55:56 +0100
Message-ID: <874infoijn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Andrew Keesler <ankeesler@google.com> writes:

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
> Note - we use "xres" and "yres" (instead of, say, "width" and "height")
> to match analogous virtio_gpu_base_conf.xres/yres.
>
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
>
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
>
> Case: outputs[i].has_xres && outputs[i].has_yres
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Case: outputs[i].has_xres != outputs[i].has_yres
> Behavior: error
>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>

[...]

> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index cd67c4f52e..09dd0e6d05 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,15 +970,24 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output.  If both @xres and
> +# @yres are set, they take precedence over root virtio-gpu resolution
> +# configuration and enable the corresponding output.  If none of @xres
> +# and @yres are set, root virtio-gpu resolution configuration takes
> +# precedence and only the first output is enabled.  Only setting one
> +# of @xres or @yres is an error.
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 11.0)
> +#
> +# @yres: vertical resolution of the output in pixels (since 11.0)
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

Acked-by: Markus Armbruster <armbru@redhat.com>


