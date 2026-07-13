Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C9FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBYV-0003JQ-Jp; Mon, 13 Jul 2026 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBYL-0003J4-0a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjBYH-0004uQ-9B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783929487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36o89pPMzmn3LC/DdirOzCtsPQcYk0ihtG4SB4n+y34=;
 b=J+gdtaN6FeLHp1qkeNeVxQBg1NNpWXepMhxYHfpY0RQkyass4IqTA8yGXP2mbFC3fRiOe+
 wvZY+x5UmxHkwmVTv+7P5Pxu0vpWgMj1UQRG/d1sVf5D0bIlJj8/Q7a+xN3+xo7NBsFK4n
 KSHcBsTj7G/f9OiPOcyeQWhLuZVvCw4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-EGp6KOYkNuCpQ5lOyucB2w-1; Mon,
 13 Jul 2026 03:58:04 -0400
X-MC-Unique: EGp6KOYkNuCpQ5lOyucB2w-1
X-Mimecast-MFC-AGG-ID: EGp6KOYkNuCpQ5lOyucB2w_1783929482
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7958B19560A1; Mon, 13 Jul 2026 07:58:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0DAE36F33; Mon, 13 Jul 2026 07:57:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5494A21E6920; Mon, 13 Jul 2026 09:57:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jason
 Wang <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
In-Reply-To: <20260710191809.721154-13-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 10 Jul 2026 22:18:01 +0300")
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
Date: Mon, 13 Jul 2026 09:57:57 +0200
Message-ID: <875x2juxru.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Support transferring of TAP state (including open fd).
>
> Add new property "local-migration-supported", which defines
> whether local-migration is actually supported for this TAP device.
> Starting from 11.2 QEMU Machine Types it's enabled by default.
>
> Note, that local-migration (including migrating opened FDs

Scratch the comma after "Note", ...

> through migration channel, which must be UNIX socket), is

... and the one before "is".

> enabled by global "local" migration parameters. But individual
> devices may have additional options to enable/disable it
> per device.
>
> The tricky thing, is that we need to know, should we do

Do you mean "The tricky thing is that we ween to know whether to call"?

> call open/connect in TAP initialization code. That means,
> that on incoming migration we want to know status of
> "local" migration parameter at time of creating TAP device.
> So, currently, for incoming local migration only TAP device
> created through QMP is supported, as you need to set migration
> parameter first (through QMP as well).
>
> So the full picture is:
>
> On source, to start outgoing "local" migration you need:
>
>  - migration parameter "local" set to true
>  - "local-migration-supported" TAP option set to true (the
>    default, starting from 11.2 QEMU Machine Types)
>
> If at least one of these options is not set, TAP backend
> doesn't participate in migration.
>
> On target, things are more difficult:
>
> Same, you need both "local" and "local-migration-supported"
> be set. And same, if one of them is not set, TAP backend
> is initialized as usual, and doesn't accept any incoming
> state.
>
> Additionally, if you are going to set "local", it must be
> set before creating the TAP device. If TAP device created
> with "local" unset, it initializes as usual. If you enable
> "local" after it and start incoming migration, it will fail
> in .pre_load handler of TAP backend.

Out of curiosity, how would such a failure look like?

> Moreover, there are interface restrictions: if you create TAP
> device when QEMU is in INCOMING state, and both "local"
> and "local-migration-supported" set, most of TAP options are
> not allowed, and script/downscript are required to be explicitly
> unset (set to "" or "no").
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> In v17 thread we considered making new qapi parameters "unstable".
> Still, it was because of doubtful "incoming-fds" parameter. In this
> v18 it's completely removed, and we may live only with "local"
> migration parameter + "local-migration-supported" TAP option.
> This way the series doesn't conflict with suggested by Peter
>   [PATCH RFC 0/2] migration/vl: new -incoming config:* for early migration parameters
> So, I think, worth making one more iteration as "stable candidate".
> If still some doubts, not problem for me to resend with "unstable" features.

Up to the migration maintainers, I think.

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index ada0329ef9d..2070979f20e 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -435,6 +435,26 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @local-migration-supported: enable local migration for this TAP
> +#     backend.  When set, local migration is enabled/disabled by
> +#     migration parameter @local for this TAP backend.  When unset,
> +#     migration parameter @local is ignored for this TAP backend.
> +#     To be able to do incoming local migration of TAP backend,

Suggest "of a TAP backend", or maybe "of any TAP backend".

> +#     migration parameter @local must be set _before_ creating the
> +#     TAP backend.  Otherwise, TAP backend is initialized as usual,
> +#     opening/creating TAP devices in kernel.  In this case further
> +#     local incoming migration (with migration parameter @local set
> +#     after creating TAP backend with @local-migration-supporeted
> +#     parameter set) will simply fail.
> +#     Moreover, when QEMU is in incoming migration state, migration
> +#     parameter @local is set and @local-migration-supported is set,
> +#     following options are not supported and must not be set:

the following options

> +#     @ds, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.

@ds does not exist.  Do you mean @fd?

> +#     Additionally in this case @script and @downscipt must be
> +#     explicitly disabled (empty strings or "no").

"no" is deprecated.  Scratch the parenthesis?

> +#     (Since 11.2.  Defaults to true for QEMU Machine Types >= 11.2,
> +#     and to false for QEMU Machine Types < 11.2)

We commonly write this like

   #     Defaults to true for QEMU Machine Types >= 11.2, and to false
   #     for QEMU Machine Types < 11.2.  (Since 11.2)

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -453,7 +473,8 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*local-migration-supported': 'bool' } }
>  
>  ##
>  # @NetdevSocketOptions:


