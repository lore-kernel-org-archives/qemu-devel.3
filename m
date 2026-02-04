Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A8EE95399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncY9-00017C-BT; Wed, 04 Feb 2026 08:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncY7-00016v-Lb
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncY5-0005x6-DB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvFGF7uTamspqHZ8i+2W1kwQkISFavwKH902UPdMx5E=;
 b=H618xcJwTYowZTQ191OgcM+cHKYU6R3lOG933Mc2sW/GkDsYhWDGfEYD/BNvNQfK1cM26T
 bJrFxcaoC8Pi7PCiH8h4yOknLodtDq57cTR7x3owqzGFSXwRAJ5ybSAI9R0aFLcwAIr8k9
 G3TZzeVXQnskiy4GYFKvPdGC8zjlqXg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-2uZ8xmV-NLeEuxQ31Pd5Yw-1; Wed,
 04 Feb 2026 08:03:56 -0500
X-MC-Unique: 2uZ8xmV-NLeEuxQ31Pd5Yw-1
X-Mimecast-MFC-AGG-ID: 2uZ8xmV-NLeEuxQ31Pd5Yw_1770210235
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159DD1891469; Wed,  4 Feb 2026 13:03:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90FE518003F6; Wed,  4 Feb 2026 13:03:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A26521E692D; Wed, 04 Feb 2026 14:03:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] vfio/migration: Send migration event before device
 state transition
In-Reply-To: <20260128105159.10282-1-avihaih@nvidia.com> (Avihai Horon's
 message of "Wed, 28 Jan 2026 12:51:59 +0200")
References: <20260128105159.10282-1-avihaih@nvidia.com>
Date: Wed, 04 Feb 2026 14:03:19 +0100
Message-ID: <87343gy82w.fsf@pond.sub.org>
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

> Currently, VFIO device migration event is sent after the device state
> transition has been completed. However, it may be useful to additionally
> send a "prepare" event before the state transition, to notify users that
> it's about to happen.
>
> For example, in some cases with heavy resource utilization, stopping the
> VFIO device may take a long time. In time-sensitive scenarios, the
> management application that consumes the event may be notified about the
> state transition too late.
>
> To overcome this issue, send an additional "prepare" migration event
> before the device state transition.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
>  hw/vfio/migration.c | 18 +++++++++++++-----
>  2 files changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..de41211f1d 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -66,3 +66,36 @@
>        'qom-path': 'str',
>        'device-state': 'QapiVfioMigrationState'
>    } }
> +
> +##
> +# @VFIO_MIGRATION_PREPARE:
> +#
> +# This event is emitted when a VFIO device migration state is about to
> +# be changed.  Note that even if this event is received for state X,
> +# the VFIO device may transition to a different state if the original
> +# state transition to X failed.
> +#
> +# @device-id: The device's id, if it has one.
> +#
> +# @qom-path: The device's QOM path.
> +#
> +# @device-state: The new device migration state that is about to be
> +#     changed.
> +#
> +# Since: 11.0
> +#
> +# .. qmp-example::
> +#
> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
> +#          "event": "VFIO_MIGRATION_PREPARE",
> +#          "data": {
> +#              "device-id": "vfio_dev1",
> +#              "qom-path": "/machine/peripheral/vfio_dev1",
> +#              "device-state": "stop" } }
> +##
> +{ 'event': 'VFIO_MIGRATION_PREPARE',
> +  'data': {
> +      'device-id': 'str',
> +      'qom-path': 'str',
> +      'device-state': 'QapiVfioMigrationState'
> +  } }

The QAPI schema is fine, so

Acked-by: Markus Armbruster <armbru@redhat.com>

Whether the event makes sense I have no idea.  I'm leaving that
judgement to the migration and VFIO maintainers.


