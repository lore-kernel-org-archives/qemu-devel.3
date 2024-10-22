Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE288D2C54B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EV6-0005C3-WE; Tue, 22 Oct 2024 09:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3EV6-0005Ba-CJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3EV3-0004X5-SQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729602037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfLH6I5bM4Jy1R/F1FAjdzJtMu0505+ee6gJoJKJ564=;
 b=HJwZFfCHhGTowMTdF610RUyGj3R/u2D1+iaP73xi4jqt+KgLtMH7ocmp1j4koz893Zc2zd
 e9CrQXOsPJqIVpXWLhwG6C1BguYScxwCvUYkWLCyrIQsM+bRayssEsmgolj+L4FS038DCY
 RD+XUWgbitWveio73miolEfevy2Nxg8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-OYh_5LmGP6mlV2uSdo0egg-1; Tue,
 22 Oct 2024 09:00:33 -0400
X-MC-Unique: OYh_5LmGP6mlV2uSdo0egg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E14F01955EAC; Tue, 22 Oct 2024 13:00:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A393419560A2; Tue, 22 Oct 2024 13:00:26 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:00:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, devel@lists.libvirt.org, hreitz@redhat.com,
 jsnow@redhat.com, pkrempa@redhat.com
Subject: Re: [PATCH v3 4/7] blockjob: move change action implementation to
 job from block-job
Message-ID: <Zxeh4rNpVRTbciKi@redhat.com>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
 <20241002140616.561652-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002140616.561652-5-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 02.10.2024 um 16:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Like for other block-job-* APIs we want have the actual functionality
> in job layer and make block-job-change to be a deprecated duplication
> of job-change in the following commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 2b873f2576..6fa525dac3 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -27,6 +27,7 @@
>  #define JOB_H
>  
>  #include "qapi/qapi-types-job.h"
> +#include "qapi/qapi-types-block-core.h"
>  #include "qemu/queue.h"
>  #include "qemu/progress_meter.h"
>  #include "qemu/coroutine.h"
> @@ -307,6 +308,12 @@ struct JobDriver {
>       */
>      bool (*cancel)(Job *job, bool force);
>  
> +    /**
> +     * Change the @job's options according to @opts.
> +     *
> +     * Note that this can already be called before the job coroutine is running.
> +     */
> +    void (*change)(Job *job, JobChangeOptions *opts, Error **errp);
>  
>      /**
>       * Called when the job is freed.
> @@ -705,6 +712,11 @@ void job_finalize_locked(Job *job, Error **errp);
>   */
>  void job_dismiss_locked(Job **job, Error **errp);
>  
> +/**
> + * Change the job according to opts.
> + */
> +void job_change_locked(Job *job, JobChangeOptions *opts, Error **errp);

Other functions in this header document the locking behaviour. The right
one here seems to be: "Called with job_lock held, but might release it
temporarily."

Kevin


