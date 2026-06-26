Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A106DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd1Ob-000685-FE; Fri, 26 Jun 2026 03:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd1Oa-00067t-6l
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd1OY-0007QP-Go
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782460476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+HMkPBGXwDpMMp+z6wg6ROQQ22RXD2U7uLGqA44xYE=;
 b=fQpJaSoxNBbmnk3Slgt1d3MI5bWTsso7lTTMmVZIb1Ci7z4jpc0BYYqWho8pdIdXFzB9yM
 +LfI7cQ16MCV5Mxwe81Dylq/URJ0vAOqa9e52h+WiZz4ubUJzHyND5ktip/hoqF/BCkiZ8
 YVxLFJrdbAVCAOBMs7ie1bnV1xwo5Mo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-hy4CxaJzNguOnDwTjRaqaQ-1; Fri,
 26 Jun 2026 03:54:31 -0400
X-MC-Unique: hy4CxaJzNguOnDwTjRaqaQ-1
X-Mimecast-MFC-AGG-ID: hy4CxaJzNguOnDwTjRaqaQ_1782460469
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A8A1954AD2; Fri, 26 Jun 2026 07:54:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 474791956086; Fri, 26 Jun 2026 07:54:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD11B21E6920; Fri, 26 Jun 2026 09:54:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Halil Pasic <pasic@linux.ibm.com>,  "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,  Eric Farman
 <farman@linux.ibm.com>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 "Cornelia Huck" <cohuck@redhat.com>,  Eric Blake <eblake@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>,  John Snow
 <jsnow@redhat.com>,  Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
In-Reply-To: <20260622101214.25770-8-avihaih@nvidia.com> (Avihai Horon's
 message of "Mon, 22 Jun 2026 13:12:07 +0300")
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-8-avihaih@nvidia.com>
Date: Fri, 26 Jun 2026 09:54:23 +0200
Message-ID: <87v7b520uo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just spelling nitpickery this time.

Avihai Horon <avihaih@nvidia.com> writes:

> Switchover-ack is a mechanism to synchronize between source and
> destination QEMU during migration to prevent the source from switching
> over prematurely.
>
> VFIO uses switchover-ack to ensure switchover happens only after
> destination side has loaded the precopy initial bytes. This is important
> for VFIO, as otherwise downtime could be impacted and be higher.
>
> In its current state, switchover-ack is a one-time mechanism, meaning
> that switchover is acked only once and past that another ACK cannot be
> requested again. This was sufficient until now, as VFIO precopy initial
> bytes was defined to be monotonically decreasing. Thus, when precopy
> initial bytes reached zero for all VFIO devices, a single ACK would be
> sent and its validity would hold.
>
> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
> initial bytes to be re-initialized during precopy. Specifically, it
> means that initial bytes can grow after reaching zero, which would
> invalidate a previously sent switchover ACK.
>
> To solve this, make switchover-ack reusable and allow devices to request
> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>
> Since now switchover ACK can be requested for a specific device and in
> different times, make switchover ACK per-device (instead of a single ACK
> for all devices) and let source side do the pending ACKs accounting.
>
> Keep the legacy switchover-ack mechanism for backward compatibility and
> turn it on by a compatibility property for older machines. Enable the
> property until VFIO implements the new switchover-ack.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  qapi/migration.json                | 14 ++++----
>  include/migration/client-options.h |  1 +
>  include/migration/register.h       |  2 ++
>  migration/migration.h              | 32 ++++++++++++++++--
>  migration/savevm.h                 |  6 ++--
>  migration/migration.c              | 37 ++++++++++++++-------
>  migration/options.c                | 10 ++++++
>  migration/savevm.c                 | 53 +++++++++++++++++++++++-------
>  migration/trace-events             |  5 +--
>  9 files changed, 123 insertions(+), 37 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 27a7970556..9b3070e494 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -508,14 +508,12 @@
>  #     (since 7.1)
>  #
>  # @switchover-ack: If enabled, migration will not stop the source VM
> -#     and complete the migration until an ACK is received from the
> -#     destination that it's OK to do so.  Exactly when this ACK is
> -#     sent depends on the migrated devices that use this feature.  For
> -#     example, a device can use it to make sure some of its data is
> -#     sent and loaded in the destination before doing switchover.

Here, "switchover" is used as noun.  My dictionary is happy with that.

> -#     This can reduce downtime if devices that support this capability
> -#     are present.  'return-path' capability must be enabled to use
> -#     it.  (since 8.1)
> +#     and complete the migration until the destination has
> +#     acknowledged that it is OK to switchover.  The acknowledgement


Here, it's used as verb.  I think it needs to be spelled "to switch
over".

Same for code comments etc.

> +#     may depend, for example, on some device's data being loaded in
> +#     the destination before doing switchover.  This can reduce
> +#     downtime if devices that support this capability are present.
> +#     Capability @return-path must be enabled to use it.  (since 8.1)
>  #
>  # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>  #     keep their dirty page rate within @vcpu-dirty-limit.  This can

[...]


