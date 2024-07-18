Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608BBC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUOrW-0004BX-LH; Thu, 18 Jul 2024 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOrU-00047c-SK
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUOrT-00048D-6E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721300386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtyBVnPcGZITyri8e7eWjfLZSfFXnHpy+jKDXi55qqk=;
 b=c3AfFPXUhmkGcpN/UCf0Z1lYfPkNrRY+d3PpyrUSmqIPzNoOUmK7DQ8aa2DsadfCAjN4G3
 NHn3GwA6nQLyMAhyY02gV9+SyR2s6J7pPfiwqg2EcBhbcRwLrFyVx81WG5im2Kqk2SFqIW
 Urhmc7C/05kKshW6bd+CcIiugSr2UcA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-5Hvfmo-HOTK-uR50Qen91A-1; Thu,
 18 Jul 2024 06:59:43 -0400
X-MC-Unique: 5Hvfmo-HOTK-uR50Qen91A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0D3A1955BF9; Thu, 18 Jul 2024 10:59:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D7E91955D47; Thu, 18 Jul 2024 10:59:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E963221E668F; Thu, 18 Jul 2024 12:59:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  armbru@redhat.com,
 eblake@redhat.com,  devel@lists.libvirt.org,  hreitz@redhat.com,
 kwolf@redhat.com,  jsnow@redhat.com,  pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: Re: [PATCH v2 5/7] qapi: add job-change
In-Reply-To: <20240626110124.374336-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 26 Jun 2024 14:01:22 +0300")
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
 <20240626110124.374336-6-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 12:59:38 +0200
Message-ID: <87le1zx8x1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Add a new-style command job-change, doing same thing as
> block-job-change. The aim is finally deprecate block-job-* APIs and
> move to job-* APIs.
>
> We add a new command to qapi/block-core.json, not to
> qapi/job.json to avoid resolving json file including loops for now.
> This all would be a lot simple to refactor when we finally drop
> deprecated block-job-* APIs.
>
> @type argument of the new command immediately becomes deprecated.

Where?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  job-qmp.c            | 14 ++++++++++++++
>  qapi/block-core.json | 10 ++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/job-qmp.c b/job-qmp.c
> index c764bd3801..248e68f554 100644
> --- a/job-qmp.c
> +++ b/job-qmp.c
> @@ -139,6 +139,20 @@ void qmp_job_dismiss(const char *id, Error **errp)
>      job_dismiss_locked(&job, errp);
>  }
>  
> +void qmp_job_change(JobChangeOptions *opts, Error **errp)
> +{
> +    Job *job;
> +
> +    JOB_LOCK_GUARD();
> +    job = find_job_locked(opts->id, errp);
> +
> +    if (!job) {
> +        return;
> +    }
> +
> +    job_change_locked(job, opts, errp);
> +}
> +
>  /* Called with job_mutex held. */
>  static JobInfo *job_query_single_locked(Job *job, Error **errp)
>  {
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 660c7f4a48..9087ce300c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3104,6 +3104,16 @@
>  { 'command': 'block-job-change',
>    'data': 'JobChangeOptions', 'boxed': true }
>  
> +##
> +# @job-change:
> +#
> +# Change the block job's options.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'job-change',
> +  'data': 'JobChangeOptions', 'boxed': true }
> +
>  ##
>  # @BlockdevDiscardOptions:
>  #


