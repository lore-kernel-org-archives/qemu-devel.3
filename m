Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKya-0008EK-IM; Wed, 12 Feb 2025 17:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tiKyZ-0008E0-NX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tiKyW-0005zW-B8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739398375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5IUnO/hfkL0PWEq3ilPGk8DUYZUnJnQzDg/S4SsEKI=;
 b=BJx0YD/5Ubt6GoF9JPi2o6vXLXbRemDnIuPvqTs1gP8p5bLuY7JT5AJ336iePl2HfL3HqE
 ajrK4NKd6BknrQyypEt4YbrzzWA5eiXLba7dZsAZwg1fll3Pie3M6ce4r84rII20Ptd60q
 36RHhaTHwSRNocrl65wFCpRR6xmH0WM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-ZSz_H0JHNjCfwVZZ7uXHAQ-1; Wed,
 12 Feb 2025 17:12:53 -0500
X-MC-Unique: ZSz_H0JHNjCfwVZZ7uXHAQ-1
X-Mimecast-MFC-AGG-ID: ZSz_H0JHNjCfwVZZ7uXHAQ_1739398372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 923151800980; Wed, 12 Feb 2025 22:12:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10A8318004A7; Wed, 12 Feb 2025 22:12:48 +0000 (UTC)
Date: Wed, 12 Feb 2025 16:12:46 -0600
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH] qapi: merge common parts of NbdServerOptions and
 nbd-server-start data
Message-ID: <ky3eygomndpcfsxvcwt3aqdnyqmkerzx6zzmusj432gpof4gge@tsxlpcqazel4>
References: <20250212143351.274931-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212143351.274931-1-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 12, 2025 at 05:33:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Instead of comment
> "Keep this type consistent with the nbd-server-start arguments", we
> can simply merge these things.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> No problem for me to rebase on top of
> [PATCH 0/2] nbd: Allow debugging tuning of handshake limit
> if it goes earlier.

I just sent the pull request for that, so this will indeed need
rebasing.  But it's still worth reviewing as written.

> 
> Also, not that order of nbd-server-start is changed. I think the order
> could not be a contract of JSON interface.

Correct - QMP does not mandate wire ordering, so although the change
causes C paramter rearrangement, it is not a breaking change.

> 
> We could instead of making common base structure go another way
> and define two structures with same data=NbdServerOptionsCommon, and
> different bases (will have to define additional base strucutres with
> SocketAddress and SocketAddressLegacy fields). But it would look a bit
> unusual in QAPI.
> 
>  blockdev-nbd.c         |  4 +--
>  qapi/block-export.json | 57 ++++++++++++++++++++----------------------
>  2 files changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 9e61fbaf2b..b0b8993a1b 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -215,10 +215,10 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
>                       arg->max_connections, errp);
>  }
>  
> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
> -                          const char *tls_creds,
> +void qmp_nbd_server_start(const char *tls_creds,
>                            const char *tls_authz,
>                            bool has_max_connections, uint32_t max_connections,
> +                          SocketAddressLegacy *addr,
>                            Error **errp)
>  {
>      SocketAddress *addr_flat = socket_address_flatten(addr);
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 117b05d13c..5eb94213db 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -9,13 +9,7 @@
>  { 'include': 'block-core.json' }
>  
>  ##
> -# @NbdServerOptions:
> -#
> -# Keep this type consistent with the nbd-server-start arguments.  The
> -# only intended difference is using SocketAddress instead of
> -# SocketAddressLegacy.
> -#
> -# @addr: Address on which to listen.
> +# @NbdServerOptionsBase:
>  #
>  # @tls-creds: ID of the TLS credentials object (since 2.6).
>  #
> @@ -30,14 +24,35 @@
>  #     server from advertising multiple client support (since 5.2;
>  #     default: 100)
>  #
> -# Since: 4.2
> +# Since: 10.0

Markus, when refactoring types like this, should Since stay at the
point in time where the fields were first introduced (4.2) or at the
time where the refactoring introduced the new type (10.0)?  Or does
type inlining make it all moot if this tag never shows up in the docs?

>  ##
> -{ 'struct': 'NbdServerOptions',
> -  'data': { 'addr': 'SocketAddress',
> -            '*tls-creds': 'str',
> +{ 'struct': 'NbdServerOptionsBase',
> +  'data': { '*tls-creds': 'str',
>              '*tls-authz': 'str',
>              '*max-connections': 'uint32' } }
>  
> +##
> +# @NbdServerOptions:
> +#
> +# @addr: Address on which to listen.

This might be a good time to add a paragraph on how this is the struct
used for q-s-d command-line server setup...

> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'NbdServerOptions',
> +  'base': 'NbdServerOptionsBase',
> +  'data': { 'addr': 'SocketAddress' } }
> +
> +##
> +# @NbdServerOptionsLegacy:
> +#
> +# @addr: Address on which to listen.

...while this is the version for QMP runtime control.

> +#
> +# Since: 10.0
> +##
> +{ 'struct': 'NbdServerOptionsLegacy',
> +  'base': 'NbdServerOptionsBase',
> +  'data': { 'addr': 'SocketAddressLegacy' } }
> +
>  ##
>  # @nbd-server-start:
>  #
> @@ -50,31 +65,13 @@
>  # intended difference is using SocketAddressLegacy instead of
>  # SocketAddress.
>  #
> -# @addr: Address on which to listen.
> -#
> -# @tls-creds: ID of the TLS credentials object (since 2.6).
> -#
> -# @tls-authz: ID of the QAuthZ authorization object used to validate
> -#     the client's x509 distinguished name.  This object is is only
> -#     resolved at time of use, so can be deleted and recreated on the
> -#     fly while the NBD server is active.  If missing, it will default
> -#     to denying access (since 4.0).
> -#
> -# @max-connections: The maximum number of connections to allow at the
> -#     same time, 0 for unlimited.  Setting this to 1 also stops the
> -#     server from advertising multiple client support (since 5.2;
> -#     default: 100).
> -#
>  # Errors:
>  #     - if the server is already running
>  #
>  # Since: 1.3
>  ##
>  { 'command': 'nbd-server-start',
> -  'data': { 'addr': 'SocketAddressLegacy',
> -            '*tls-creds': 'str',
> -            '*tls-authz': 'str',
> -            '*max-connections': 'uint32' },
> +  'data': 'NbdServerOptionsLegacy',
>    'allow-preconfig': true }

At any rate, I like the consolidation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


