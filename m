Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1AED3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgGM7-0006LU-Q6; Thu, 15 Jan 2026 00:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgGLu-0006Hq-CB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:57:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgGLr-0007pU-TH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768456618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AujIqaltR9/2qrP5D+eeiW4Zw7bpYrGVdmREnV6eSdk=;
 b=GEflrs/iSQ8XvlLZXsdQfPgSMez0OW7dWcKZb7tPyi6t+Tq6GU33s6bzgI3qDnQYEYvqJo
 yz95aDOTYrXvo+72SRLh5eWitnZESsmCwRlV6PiFcEEpFWc2WYPvI3DO1GDSbo5ZGwWFG/
 f9NAZWdHoLN0+7AJnpYWz0U6stbHzv8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-8Anty3mxOPGA6cZxKgHdOQ-1; Thu,
 15 Jan 2026 00:56:54 -0500
X-MC-Unique: 8Anty3mxOPGA6cZxKgHdOQ-1
X-Mimecast-MFC-AGG-ID: 8Anty3mxOPGA6cZxKgHdOQ_1768456613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEFC0180057E; Thu, 15 Jan 2026 05:56:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24E730002D8; Thu, 15 Jan 2026 05:56:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3063421E692D; Thu, 15 Jan 2026 06:56:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,  Juan Quintela
 <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  Zhang Chen
 <zhangckid@gmail.com>,  zhanghailiang@xfusion.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
In-Reply-To: <20260114195659.2543649-2-peterx@redhat.com> (Peter Xu's message
 of "Wed, 14 Jan 2026 14:56:57 -0500")
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
Date: Thu, 15 Jan 2026 06:56:49 +0100
Message-ID: <875x93zae6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Peter Xu <peterx@redhat.com> writes:

> COLO was broken for QEMU release 10.0/10.1 without anyone noticed.

We could arguably drop this right away.  I'm not demanding we do, just
pointing out.

First, COLO is marked 'unstable' in the QAPI schema:

* MigrationCapability member x-colo:

    # @unstable: Members @x-colo and @x-ignore-shared are experimental.

* MigrationParameter and MigrationParameters member x-checkpoint-delay:

    # @unstable: Members @x-checkpoint-delay and
    #     @x-vcpu-dirty-limit-period are experimental.

* Command x-colo-lost-heartbeat:

    # @unstable: This command is experimental.

There's more COLO stuff we neglected to mark, e.g. MigrationStatus
member @colo, event COLO_EXIT, commands xen-colo-do-checkpoint,
query-colo-status.  We should clean that up.  More on that below.

Second, it's been broken for two releases, our deprecation grace period.
In my opinion, "broken" is even stronger notice than "deprecated".

>                                                                     One
> reason might be that we don't have an unit test for COLO (which we
> explicitly require now for any new migration feature).  The other reason
> should be that there are just no more active COLO users, at least based on
> the latest development of QEMU.
>
> I don't remember seeing anything really active in the past few years in
> COLO development.
>
> Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> email to qemu-devel is in Dec 2021 where the patch proposed an email
> change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
>
> We've discussed this for a while, see latest discussions here (our though=
ts
> of deprecating COLO framework might be earlier than that, but still):
>
> https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c=
71@web.de
>
> Let's make it partly official and put COLO into deprecation list.  If
> anyone cares about COLO and is deploying it, please send an email to
> qemu-devel to discuss.
>
> Otherwise, let's try to save some energy for either maintainers or
> developers who is looking after QEMU. Let's save the work if we don't even
> know what the work is for.
>
> Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Juan Quintela <quintela@trasno.org>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: zhanghailiang@xfusion.com
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst | 6 ++++++
>  qapi/migration.json       | 5 ++---
>  migration/options.c       | 4 ++++
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7abb3dab59..b499b2acb0 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` us=
age.
>=20=20
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +COLO migration framework (since 11.0)
> +'''''''''''''''''''''''''''''''''''''
> +
> +To be removed with no replacement, as the COLO migration framework doesn=
't
> +seem to have any active user for a while.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 201dedd982..3c868efe38 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,8 +531,7 @@
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>  #
> -# @deprecated: Member @zero-blocks is deprecated as being part of
> -#     block migration which was already removed.
> +# @deprecated: Member @zero-blocks and @x-colo are deprecated.
>  #
>  # Since: 1.2
>  ##
> @@ -540,7 +539,7 @@
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>             { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
>             'events', 'postcopy-ram',
> -           { 'name': 'x-colo', 'features': [ 'unstable' ] },
> +           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] =
},
>             'release-ram',
>             'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',

Issues / doubts:

1. We delete the text why @zero-blocks is deprecated.  Harmless; the
next patch drops @zero-blocks entirely.  Better: swap the patches.

2. The text for @x-colo is lacking.  Suggest something like "Member
@x-colo" is deprecated without replacement."

3. Does it make sense to keep x-colo @unstable?

4. Shouldn't we mark *all* the COLO interfaces the same way?

> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..318850ba94 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_ca=
ps, Error **errp)
>          warn_report("zero-blocks capability is deprecated");
>      }
>=20=20
> +    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> +        warn_report("COLO migration framework is deprecated");
> +    }
> +
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"


