Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934EAC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2VC-0002E8-As; Wed, 29 Jul 2026 07:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp2VA-0002Dx-CN
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp2V7-0001IU-UJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785324663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MpkwfLSAhK+gyuTeXSWDbKE8h+1eJUPvUOBLN3Rwxyc=;
 b=OF2C6by1iXjtDkjXuVX3ZhE2K9hIrZ6xX6Fh2OJqx3KSb4jpWOTfMD+Ne/QY6ZuvbZNNJK
 r7I/BboCAyC48FF9hu8DV8nJjKFnerqGLVm9HrcOtmVReUHiwKELlTn2PPp7ldk5Pjf+MN
 gia+Rnrf3QhFejB1fsFeyMIZKpJjKOg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-BB52mUKzNkqXtLRIbvj1uA-1; Wed,
 29 Jul 2026 07:31:00 -0400
X-MC-Unique: BB52mUKzNkqXtLRIbvj1uA-1
X-Mimecast-MFC-AGG-ID: BB52mUKzNkqXtLRIbvj1uA_1785324658
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF2119560B5; Wed, 29 Jul 2026 11:30:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D25414; Wed, 29 Jul 2026 11:30:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F16121E6920; Wed, 29 Jul 2026 13:30:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  armbru@redhat.com,
 peterx@redhat.com,  farosas@suse.de,  raphael.s.norwitz@gmail.com,
 bchaney@akamai.com,  qemu-devel@nongnu.org,  berrange@redhat.com,
 pbonzini@redhat.com,  yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com,  Jason Wang <jasowangio@gmail.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v20 13/15] net/tap: support local migration with virtio-net
In-Reply-To: <20260729091334.1863155-14-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 29 Jul 2026 12:12:51 +0300")
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-14-vsementsov@yandex-team.ru>
Date: Wed, 29 Jul 2026 13:30:54 +0200
Message-ID: <87jyqeqbgx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Add new property "x-local-migration-supported", which defines
> whether local-migration is actually supported for this TAP device.
> Starting from 11.2 QEMU Machine Types it's enabled by default.
>
> Note that local-migration is enabled by global "local" migration
> parameter, but individual devices may have additional options to
> enable/disable it per device.
>
> The tricky thing is that we need to know whether to call open/connect in
> TAP initialization code, i.e. we need to know the value of migration
> parameter "local" when creating the TAP device.  For incoming migration,
> we can know only for TAP devices created with QMP after setting the
> migration parameter with QMP.
>
> So the full picture is:
>
> On source, to start outgoing "local" migration you need:
>
>  - migration parameter "local" set to true
>  - "x-local-migration-supported" TAP option set to true (the
>    default, starting from 11.2 QEMU Machine Types)

Is the machine type part still accurate?  The description in the QAPI
schema has (default: false, since 11.2).

>
> If at least one of these options is not set, TAP backend
> doesn't participate in migration.
>
> On target, things are more difficult:
>
> Same, you need both "local" and "x-local-migration-supported"
> be set. And same, if one of them is not set, TAP backend
> is initialized as usual, and doesn't accept any incoming
> state.
>
> Additionally, if you are going to set "local", it must be
> set before creating the TAP device. If TAP device created
> with "local" unset, it initializes as usual. If you enable
> "local" after it and start incoming migration, it will fail
> in .pre_load handler of TAP backend.
>
> Moreover, there are interface restrictions: if you create TAP
> device when QEMU is in INCOMING state, and both "local"
> and "x-local-migration-supported" set, most of TAP options are
> not allowed, and script/downscript are required to be explicitly
> unset (set to "" or "no").
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Ben Chaney <bchaney@akamai.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index acb8594c952..e6921912e12 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -437,6 +437,29 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @x-local-migration-supported: enable local migration for this TAP
> +#     backend.  When set, local migration is enabled/disabled by
> +#     migration parameter @local for this TAP backend.  When unset,
> +#     migration parameter @local is ignored for this TAP backend.
> +#     To be able to do incoming local migration of a TAP backend,
> +#     migration parameter @local must be set _before_ creating the
> +#     TAP backend.  Otherwise, TAP backend is initialized as usual,
> +#     opening/creating TAP devices in kernel.  In this case further
> +#     local incoming migration (with migration parameter @local set
> +#     after creating TAP backend with @x-local-migration-supporeted
> +#     parameter set) will simply fail.

Either have a a blank line here so you actually get two paragraphs, or
refill the entire description to avoid the illusion of two paragraphs.

> +#     Moreover, when QEMU is in incoming migration state, migration
> +#     parameter @local is set and @x-local-migration-supported is set,
> +#     the following options are not supported and must not be set:
> +#     @fd, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
> +#     Additionally in this case @script and @downscipt must be

@downscript

> +#     explicitly disabled (empty strings or "no").

"no" is deprecated [PATCH 3].  We'll have to remember deleting 'or "no"'
here when remove it.  Easy to forget.  Delete it now?

Maybe

   #     Additionally, @script and @downscript must be explicitly disabled
   #     then.

> +#     (default: false, since 11.2)
> +#
> +# Features:
> +#
> +# @unstable: Member @x-local-migration-supported is experimental.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -455,7 +478,9 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*x-local-migration-supported': {
> +      'type': 'bool', 'features' : [ 'unstable'] } } }
>  
>  ##
>  # @NetdevSocketOptions:

Naming is hard...

"Supported" sounds like a property of the QEMU process.  That's not what
this is.  It's an on/off switch that happens to be in series with
another on/off switch, namely migration parameter @local.

Maybe

    @permit-local-migration: permit local migration for this TAP
        backend.  When set, local migration is enabled/disabled by
        migration parameter @local for this TAP backend.  ...


