Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DBAE9539D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqZ-0003Sr-9A; Wed, 04 Feb 2026 08:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncqP-0003Lu-R1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncqN-000338-V4
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/g6KjAiQZk+xb8sc5e1aTQWLKu0s6V9lTsUfrosO08=;
 b=VC50RNZz0ltBZNc992c1jB9sY6mVLlnwfwJOGYHis4rI/N4KVYYPAoz+99daZqG8sNruJt
 cMg8bCXVPFX6/0cjg8ODsc/j+uJlDnG1ssjmIB63Edj2tPk0RAu14KA7oaVI2WrE/fW15q
 O99qVQyGSFP4qVys8qmzopnKWwlYyak=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-25zX8RY5NqSWyND7qZWcRg-1; Wed,
 04 Feb 2026 08:22:52 -0500
X-MC-Unique: 25zX8RY5NqSWyND7qZWcRg-1
X-Mimecast-MFC-AGG-ID: 25zX8RY5NqSWyND7qZWcRg_1770211371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCAF219560B2; Wed,  4 Feb 2026 13:22:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7849118003F6; Wed,  4 Feb 2026 13:22:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02C5321E692D; Wed, 04 Feb 2026 14:22:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
In-Reply-To: <20260202173406.13979-1-avihaih@nvidia.com> (Avihai Horon's
 message of "Mon, 2 Feb 2026 19:34:06 +0200")
References: <20260202173406.13979-1-avihaih@nvidia.com>
Date: Wed, 04 Feb 2026 14:22:48 +0100
Message-ID: <87jywswslz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Avihai Horon <avihaih@nvidia.com> writes:

> The VFIO_MIGRATION event notifies users when a VFIO device transitions
> to a new state.
>
> One use case for this event is to prevent timeouts for RDMA connections
> to the migrated device. In this case, an external management application
> (not libvirt) consumes the events and disables the RDMA timeout
> mechanism when receiving the event for PRE_COPY_P2P state, which
> indicates that the device is non-responsive.
>
> This is essential because RDMA connections typically have very low
> timeouts (tens of milliseconds), which can be far below migration
> downtime.
>
> However, under heavy resource utilization, the device transition to
> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
> VFIO_MIGRATION event is currently sent only after the transition
> completes, it arrives too late, after RDMA connections have already
> timed out.
>
> To address this, send an additional "prepare" event immediately before
> initiating the PRE_COPY_P2P transition. This guarantees timely event
> delivery regardless of how long the actual state transition takes.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

[...]

> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..17b6046871 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -11,7 +11,13 @@
>  ##
>  # @QapiVfioMigrationState:
>  #
> -# An enumeration of the VFIO device migration states.
> +# An enumeration of the VFIO device migration states.  In addition to
> +# the regular states, there are prepare states (with 'prepare' suffix)
> +# which indicate that the device is just about to transition to the
> +# corresponding state.  Note that seeing a prepare state for state X
> +# doesn't guarantee that the next state will be X, as the state
> +# transition can fail and the device may transition to a different
> +# state instead.
>  #
>  # @stop: The device is stopped.
>  #
> @@ -32,11 +38,14 @@
>  #     tracking its internal state and its internal state is available
>  #     for reading.
>  #
> +# @pre-copy-p2p-prepare: The device is just about to move to
> +#     pre-copy-p2p state.  (since 11.0)
> +#
>  # Since: 9.1
>  ##
>  { 'enum': 'QapiVfioMigrationState',
>    'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> -            'pre-copy', 'pre-copy-p2p' ] }
> +            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
>  
>  ##
>  # @VFIO_MIGRATION:

Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


