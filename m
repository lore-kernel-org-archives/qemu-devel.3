Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CA1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut6Pr-0000ez-R5; Mon, 01 Sep 2025 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut6Pq-0000eg-RN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut6Pp-0006gH-2B
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756740351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EcFxNxL6ldZCTWEMqaPlPITZ2/wp7ouWa/qa3uoJrpw=;
 b=VbaV5qwZzHsv/lL0Ttd0muxvoiegi1KhYE1Nq8WtUTQdhUPFv2OFMz7H4gjw1UR70FfIZP
 0a/0sQCI+EP+wl1B4o1FEYN+mjJDfvGMq4enmyWO7KW1LgcfSJ0vcZFvtiZ7qdzsn67y57
 CIwdKNNy9RqrJD+pm/pzibbyacUfG58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-tjegWBPuMVOJTrBEIVF_hg-1; Mon,
 01 Sep 2025 11:25:49 -0400
X-MC-Unique: tjegWBPuMVOJTrBEIVF_hg-1
X-Mimecast-MFC-AGG-ID: tjegWBPuMVOJTrBEIVF_hg_1756740348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63B6D19560AA; Mon,  1 Sep 2025 15:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D0619560B4; Mon,  1 Sep 2025 15:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E35621E6A27; Mon, 01 Sep 2025 17:25:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2] qapi: net/tap: deprecate vhostforce option
In-Reply-To: <20250901141758.55605-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 1 Sep 2025 17:17:58 +0300")
References: <20250901141758.55605-1-vsementsov@yandex-team.ru>
Date: Mon, 01 Sep 2025 17:25:45 +0200
Message-ID: <87tt1mtcsm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This option doesn't make sense since long ago (10 years!)
> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
>
> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
> (that don't have MSI-X support), you should have set vhostforce=on
> (with vhost=on or unset).
>
> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
> for vhost-enabling options logic.
>
> The current logic is:
>   vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>   vhost unset : vhostforce counts, enabling vhost
>
> Currently you may enable vhost several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
>
> - they are all equal.
>
> Let's finally deprecate the extra option.
>
> Also, fix @vhostforce documentation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> v2:
> - improve wording
> - add documentation fix
>
>  docs/about/deprecated.rst |  7 +++++++
>  qapi/net.json             | 11 +++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d50645a071..b17a5a41aa 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>  The ``reconnect`` option only allows specifying second granularity timeouts,
>  which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>  
> +TAP ``vhostforce`` (since 10.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option is redundant with the ``vhost`` option.
> +If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> +
> +
>  VFIO device options
>  '''''''''''''''''''
>  
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..e89c7aff5f 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -346,13 +346,20 @@
>  # @vhostfds: file descriptors of multiple already opened vhost net
>  #     devices
>  #
> -# @vhostforce: vhost on for non-MSIX virtio guests
> +# @vhostforce: enable vhost-net network accelerator. Ignored when
> +#    @vhost is set.

Two spaces between sentences for consistency, please.

>  #
>  # @queues: number of queues to be created for multiqueue capable tap
>  #
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
> +#    option is redundant with the @vhost option. If they conflict,
> +#    @vhost takes precedence.  Just use @vhost.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -369,7 +376,7 @@
>      '*vhost':      'bool',
>      '*vhostfd':    'str',
>      '*vhostfds':   'str',
> -    '*vhostforce': 'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>      '*queues':     'uint32',
>      '*poll-us':    'uint32'} }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


