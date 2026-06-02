Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUK5Q-0001pf-4i; Tue, 02 Jun 2026 04:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUK5O-0001p8-Fi
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUK5L-0000oI-7g
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780387369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QD+NM5lb2CiNRSvOqZts9mJazo8NVVEkg0xVdYDSZHo=;
 b=bPa9mA1HWdhAAl9pbZsoebOpRilWbC77uRoDl8L+DaE0EvqmGff9vHN1AILTATgdLRppFg
 Zlck5VuK8oNj3oSwQTFZ/45qv+RUjUIkznSCW1FgsPXggHOz80FrU1r1KvTe6P6ksw2Q/r
 8KcBoT5X2nuIeSG0Db25T0fpU+B5u8A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-CskEOdXLOp6j9MkgNwB2cQ-1; Tue,
 02 Jun 2026 04:02:46 -0400
X-MC-Unique: CskEOdXLOp6j9MkgNwB2cQ-1
X-Mimecast-MFC-AGG-ID: CskEOdXLOp6j9MkgNwB2cQ_1780387365
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C393B1800367; Tue,  2 Jun 2026 08:02:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C60C19560A3; Tue,  2 Jun 2026 08:02:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB29221E6A01; Tue, 02 Jun 2026 10:02:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v17 08/10] net/tap: support local migration with virtio-net
In-Reply-To: <20260527191150.250333-9-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 May 2026 22:11:47 +0300")
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
 <20260527191150.250333-9-vsementsov@yandex-team.ru>
Date: Tue, 02 Jun 2026 10:02:40 +0200
Message-ID: <877boh74kf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

[Cc: John Snow for advice on cross-references (search for "John?")]

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Support transferring of TAP state (including open fd).
>
> Add new property "local-migration-supported", which defines,
> is local-migration is actually supported for this TAP device.

which defines whether

> Starting from 11.1 MT it's enabled by default.

What does "MT" mean?

>
> Note, that local-migration (including migrating opened FDs
> through migration channel, which must be UNIX socket), is
> enabled by global "local" migration parameters. But individual
> devices may have additional options to enable/disable it
> personally.

per device

>
> Add new option "incoming-fds", which should be set to true on
> target for incoming migration work. It says "do not open any
> files, but instead wait for FDs coming from migration stream".
> "local-migration-supported" option is not enough, as it work in pair
> with migration parameter "local", and intialization process
> of TAP device should not depend on migration parameters.
>
> For new option require explicitly unset script and downscript,
> to keep possibility of implementing support for them in the
> future.

Why explicitly unset?  Do we have to override a default script?

> Note disabling read polling on source stop for TAP migration:

I don't understand this sentence.

> otherwise, source process may steal packages from TAP fd even
> after source vm STOP.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c5..c5d87ba308b 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -425,6 +425,22 @@
   ##
   # @NetdevTapOptions:
   #
   # Used to configure a host TAP network interface backend.
   #
   # @ifname: interface name
   #
   # @fd: file descriptor of an already opened tap
   #
   # @fds: multiple file descriptors of already opened multiqueue capable
   #     tap
   #
   # @script: script to initialize the interface
   #
   # @downscript: script to shut down the interface
   #
   # @br: bridge name (since 2.8)
   #
   # @helper: command to execute to configure bridge
   #
   # @sndbuf: send buffer limit.  Understands [TGMKkb] suffixes.
   #
   # @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
   #
   # @vhost: enable vhost-net network accelerator
   #
   # @vhostfd: file descriptor of an already opened vhost net device
   #
   # @vhostfds: file descriptors of multiple already opened vhost net
   #     devices
   #
   # @vhostforce: vhost on for non-MSIX virtio guests
   #
   # @queues: number of queues to be created for multiqueue capable tap
   #
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @incoming-fds: do not open or create any TAP devices.  Prepare for
> +#     getting TAP file descriptors from incoming migration stream.
> +#     The option is incompatible with any of @fd, @fds, @helper, @br,
> +#     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
> +#     @downscript be explicitly set to nothing (empty string or "no"),

WAT?!?

Special value "no" is not documented in the QAPI schema, see the
descriptions of @script and @downscript above.

It is documented for -netdev tap in qemu-options.hx:

    ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
        Configure a host TAP network backend with ID id.

        Use the network script file to configure it and the network script
        dfile to deconfigure it. If name is not provided, the OS
        automatically provides one. The default network configure script is
        ``/etc/qemu-ifup`` and the default network deconfigure script is
        ``/etc/qemu-ifdown``. Use ``script=no`` or ``downscript=no`` to
        disable script execution.

Special value "" is okay: you can't name have a script named "".

Special value "no" isn't: you can have a script named "no", but if you
try to use it, it's silently ignored.  Yes, it's a silly name, but it's
also a silly interface.

I think we should document "no" properly, and also deprecate it.

> +#     and requires also @local-migration-supported to be true, "local"
> +#     migration parameter be set as well, and QEMU being in incoming
> +#     migration state.  (Since 11.1)

This sentence is rather long and hard to parse.  Here's my attempt:

   #     The option is incompatible with any of @fd, @fds, @helper, @br,
   #     @ifname, @sndbuf and @vnet_hdr options.  @script and @downscript
   #     must be explicitly disabled (empty string or "no"), and
   #     @local-migration-supported must be true.  Additionally,
   #     migration parameter @local must be set, and QEMU mist be in
   #     incoming migration state.  (Since 11.1)

Ideally, "migration parameter @local" would link to its description, but
I can't tell you offhand whether we can do that and how.  John?

> +#
> +# @local-migration-supported: enable local migration for this TAP
> +#     backend.  When set, local migration is enabled/disabled by
> +#     "local" migration parameter for this TAP backend.  When unset,

migration parameter @local

> +#     "local" migration parameter is ignored for this TAP backend.
> +#     (Since 11.1.  Defaults to true for MT >= 11.1, and to false for
> +#     MT < 11.1)

What's "MT"?

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -443,7 +459,9 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*incoming-fds': 'bool',
> +    '*local-migration-supported': 'bool' } }
>  
>  ##
>  # @NetdevSocketOptions:

Two bools mean four cases.  @incoming-fd's description excludes the case
"incoming-fd": true, "local-migration-supported": false.  Awkward.  Does
case ""incoming-fd": false, "local-migration-supported": true make sense
and why?


