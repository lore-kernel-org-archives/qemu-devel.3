Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4224ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsql-0005uI-9W; Mon, 18 May 2026 03:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOsqj-0005uA-5z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOsqh-0001yD-59
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779091033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRD0saUvL1Dk1Sbq+Lljk3rudm7E0yzGiXm73rvKOY0=;
 b=QaF8WckmBtqkuOGAkSllXdUHgnDqm9d3HM/fhZTnxoYppg3RNSetVxyiRawoCecWoVH/1w
 f0m0GxA/8gcUByJ1mPj/D32GU3vq6g6a2shN+kHdwCPn5+vHSSNuRqfaPGIMV3uInYAWan
 R79DNJbbSKoqgSftr1VtHVFs1Xj1l0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-tMrBcx1VOauHyLINIgMC2Q-1; Mon,
 18 May 2026 03:57:11 -0400
X-MC-Unique: tMrBcx1VOauHyLINIgMC2Q-1
X-Mimecast-MFC-AGG-ID: tMrBcx1VOauHyLINIgMC2Q_1779091030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15F4D18002D0; Mon, 18 May 2026 07:57:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 312DB19560A2; Mon, 18 May 2026 07:57:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E185A21E6A01; Mon, 18 May 2026 09:57:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  dmitry.fomichev@wdc.com,  Kevin Wolf
 <kwolf@redhat.com>,  cassel@kernel.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  qemu-block@nongnu.org,  dlemoal@kernel.org,  Eric
 Blake <eblake@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 hare@suse.de,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
In-Reply-To: <20260510175059.311814-3-faithilikerun@gmail.com> (Sam Li's
 message of "Sun, 10 May 2026 19:50:57 +0200")
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
Date: Mon, 18 May 2026 09:57:06 +0200
Message-ID: <87mrxxw3ot.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sam Li <faithilikerun@gmail.com> writes:

> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
>
> To create a qcow2 image with zoned format feature, use command like
> this:
> qemu-img create -f qcow2 zbc.qcow2 -o size=768M \
> -o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0 \
> -o zone.max_append_bytes=4096 -o zone.max_open_zones=6 \
> -o zone.max_active_zones=8 -o zone.mode=host-managed
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com>

[...]

Just doc polish this time around.  Never been closer!

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 508b081ac1..d771dfb4a1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5268,6 +5268,70 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>  
> +##
> +# @Qcow2ZoneModel:
> +#
> +# Zoned device model used in qcow2 image file
> +#
> +# @host-managed: The host-managed model only allows sequential write
> +#     over the device zones.
> +#
> +# Since 11.0

It's 11.1 now.  More of the same below, not flagging it again.

> +##
> +{ 'enum': 'Qcow2ZoneModel',
> +  'data': [ 'host-managed'] }
> +
> +##
> +# @Qcow2ZoneHostManaged:
> +#
> +# The host-managed zone model.  It only allows sequential writes.
> +#
> +# @size: Total number of bytes within zones (default 256 MB).
> +#
> +# @capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size (default to zone size).

"Number blocks ... in bytes" is awkward.  Do you mean the usable space,
which is a multiple of the logical block size?

> +#
> +# @conventional-zones: The number of conventional zones of the
> +#     zoned device (default 0).
> +#
> +# @max-open-zones: The maximal number of open zones.  It is less than
> +#     or equal to the number of sequential write required zones of
> +#     the device (default 0).

Is the "number of sequential write required zones" visible via QMP?

> +#
> +# @max-active-zones: The maximal number of zones in the implicit
> +#     open, explicit open or closed state.  It is less than or equal
> +#     to the max open zones (default 0).

"to the maximal number of open zones" or "to @max-open-zones"

> +#
> +# @max-append-bytes: The maximal number of bytes of a zone
> +#     append request that can be issued to the device.  It must be
> +#     512-byte aligned and less than the zone capacity
> +#     (default 64 KB).

"Must be 512-byte aligned": do you mean it must be a multiple of 512?

> +#
> +# Since 11.0
> +##
> +{ 'struct': 'Qcow2ZoneHostManaged',
> +  'data': { '*size':          'size',
> +            '*capacity':      'size',
> +            '*conventional-zones': 'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-bytes':   'size' } }
> +
> +##
> +# @Qcow2ZoneCreateOptions:
> +#
> +# The zone device model for the qcow2 image.

"Device model" has a specific meaning in QEMU: it's a device frontend,
such as "ide-hd", "e1000", "usb-tablet", ...

Maybe something like "Creation options for zoned qcow2 images"?

> +#
> +# @mode: The zone device model modes.

Sure its plural modes, and not mode?

> +#
> +# Since 11.0
> +##
> +{ 'union': 'Qcow2ZoneCreateOptions',
> +  'base': { 'mode': 'Qcow2ZoneModel' },
> +  'discriminator': 'mode',
> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -5310,6 +5374,9 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone: The zone device model modes.  The default is that the
> +#     device is not zoned.  (since 11.0)

Maybe something like

   # @zone: Options for zoned images.  If absent, the device is not
   #     zoned.  (Since 11.0)

> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5326,7 +5393,8 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone':            'Qcow2ZoneCreateOptions' } }
>  
>  ##
>  # @BlockdevCreateOptionsQed:


