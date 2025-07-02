Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42553C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsM7-0001vt-Va; Wed, 02 Jul 2025 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsM6-0001vK-BD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsM1-0005yM-S2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751443083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ps1NAYTgHNYew7Sy7+hlcEaU3fkBjhZZOoJZdaXTI40=;
 b=Fy/nSZ9np3LhYZ3AVb6hCWNFAENnMSGJjh2Z8+jZZd3N9wksTgnXEqUNjtLFOj8BQUHRNI
 sa4cuyH8Ov0Ix936GOQmOCs374xhZ7lnT/ZsCDM7YSq9uYq0RZd9LKWmnmF4VuXJlnJtP7
 KTQ/8gCpCSm4DoCV9cBz0iRdNBIDm6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-ZSW0ZojRPdWawkQ-9zt5fw-1; Wed,
 02 Jul 2025 03:58:00 -0400
X-MC-Unique: ZSW0ZojRPdWawkQ-9zt5fw-1
X-Mimecast-MFC-AGG-ID: ZSW0ZojRPdWawkQ-9zt5fw_1751443079
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0EA180047F; Wed,  2 Jul 2025 07:57:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28ED130001B1; Wed,  2 Jul 2025 07:57:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A407B21E6A27; Wed, 02 Jul 2025 09:57:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 06/18] qapi: add cross-references to job.json
In-Reply-To: <20250613203620.1283814-7-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:08 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-7-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 09:57:54 +0200
Message-ID: <87bjq3qb25.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/job.json | 73 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
>
> diff --git a/qapi/job.json b/qapi/job.json
> index c1ddae9c0fe..ffeac7989dd 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json

[...]

> @@ -59,13 +59,14 @@
>  # @standby: The job is ready, but paused.  This is nearly identical to
>  #     @paused.  The job may return to @ready or otherwise be canceled.
>  #
> -# @waiting: The job is waiting for other jobs in the transaction to
> -#     converge to the waiting state.  This status will likely not be
> -#     visible for the last job in a transaction.
> +# @waiting: The job is waiting for other jobs in the
> +#     :qapi:cmd:`transaction` to converge to the waiting state.  This
> +#     status will likely not be visible for the last job in a
> +#     transaction.

Let's punt on this one as per review of PATCH 03.

>  #
>  # @pending: The job has finished its work, but has finalization steps
>  #     that it needs to make prior to completing.  These changes will
> -#     require manual intervention via @job-finalize if auto-finalize
> +#     require manual intervention via `job-finalize` if auto-finalize
>  #     was set to false.  These pending changes may still fail.
>  #
>  # @aborting: The job is in the process of being aborted, and will

[...]

> @@ -236,10 +237,10 @@
>  ##
>  # @job-finalize:
>  #
> -# Instructs all jobs in a transaction (or a single job if it is not
> -# part of any transaction) to finalize any graph changes and do any
> -# necessary cleanup.  This command requires that all involved jobs are
> -# in the PENDING state.
> +# Instructs all jobs in a :qapi:cmd:`transaction` (or a single job if it
> +# is not part of any transaction) to finalize any graph changes and do
> +# any necessary cleanup.  This command requires that all involved jobs
> +# are in the PENDING state.
>  #
>  # For jobs in a transaction, instructing one job to finalize will
>  # force ALL jobs in the transaction to finalize, so it is only
> @@ -248,7 +249,7 @@
>  # The command is applicable only to jobs which have @auto-finalize option
>  # and only when this option is set to false.
>  #
> -# @id: The identifier of any job in the transaction, or of a job that
> +# @id: The identifier of any job in the :qapi:cmd:`transaction`, or of a job that
>  #     is not part of any transaction.
>  #
>  # Since: 3.0

Likewise.


