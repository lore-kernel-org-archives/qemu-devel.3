Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFF7C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5sc-0001tz-58; Mon, 04 Mar 2024 05:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rh5sa-0001tR-M6
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rh5sV-00050E-Uf
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709549343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5r7OrzhRlKRkE5WLQ/StS72wkl+VKB3T4fPjQFBAPlo=;
 b=eZPHvM0Xv+gN6aOc4JkUn23q/t2oqwooSoXjO4JfF7oeV8FlAaS5eccKR7uNsPY5SivEdD
 DqZ953v3AMwWhTvymWksHDO8e7imm3/4G7URrAieuuWxpx/TLKiAVmEs0ebV8Xs+UdXzdG
 0rDjb+WyzTzxR5Mfulchgm0jtnxPLpE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-AsFrqwdRMnSMY8VHBQZQJQ-1; Mon,
 04 Mar 2024 05:48:58 -0500
X-MC-Unique: AsFrqwdRMnSMY8VHBQZQJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 589762806400;
 Mon,  4 Mar 2024 10:48:58 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ADD52026D06;
 Mon,  4 Mar 2024 10:48:55 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com, pkrempa@redhat.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZeWnFhLKCamlP97y@redhat.com>
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 03.11.23 18:56, Markus Armbruster wrote:
> > Kevin Wolf<kwolf@redhat.com>  writes:
> > 
> > > Am 03.11.2023 um 10:36 hat Markus Armbruster geschrieben:
> > > > Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>  writes:
> > > > 
> > > > > On 11.10.23 13:18, Fiona Ebner wrote:
> > > > > > Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
> > > > > > > On 09.10.23 12:46, Fiona Ebner wrote:
> > > > > > > > Initially, I tried to go for a more general 'job-change' command, but
> > > > > > > > I couldn't figure out a way to avoid mutual inclusion between
> > > > > > > > block-core.json and job.json.
> > > > > > > > 
> > > > > > > What is the problem with it? I still think that job-change would be better.
> > > > > > > 
> > > > > > If going for job-change in job.json, the dependencies would be
> > > > > > job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode
> > > > > > query-jobs -> JobInfo -> JobInfoMirror
> > > > > > and we can't include block-core.json in job.json, because an inclusion
> > > > > > loop gives a build error.
> > > > Let me try to understand this.
> > > > 
> > > > Command job-change needs its argument type JobChangeOptions.
> > > > 
> > > > JobChangeOptions is a union, and JobChangeOptionsMirror is one of its
> > > > branches.
> > > > 
> > > > JobChangeOptionsMirror needs MirrorCopyMode from block-core.json.
> > > > 
> > > > block-core.json needs job.json for JobType and JobStatus.
> > > > 
> > > > > > Could be made to work by moving MirrorCopyMode (and
> > > > > > JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
> > > > > > can be included by both job.json and block-core.json. Moving the
> > > > > > type-specific definitions to the general job.json didn't feel right to
> > > > > > me. Including another file with type-specific definitions in job.json
> > > > > > feels slightly less wrong, but still not quite right and I didn't want
> > > > > > to create a new file just for MirrorCopyMode (and
> > > > > > JobChangeOptionsMirror, JobInfoMirror).
> > > > > > And going further and moving all mirror-related things to a separate
> > > > > > file would require moving along things like NewImageMode with it or
> > > > > > create yet another file for such general things used by multiple block-jobs.
> > > > > > If preferred, I can try and go with some version of the above.
> > > > > > 
> > > > > OK, I see the problem. Seems, that all requires some good refactoring. But that's a preexisting big work, and should not hold up your series. I'm OK to proceed with block-job-change.
> > > > Saving ourselves some internal refactoring is a poor excuse for
> > > > undesirable external interfaces.
> > > I'm not sure how undesirable it is. We have block-job-* commands for
> > > pretty much every other operation, so it's only consistent to have
> > > block-job-change, too.
> > Is the job abstraction a failure?
> > 
> > We have
> > 
> >      block-job- command      since   job- command    since
> >      -----------------------------------------------------
> >      block-job-set-speed     1.1
> >      block-job-cancel        1.1     job-cancel      3.0
> >      block-job-pause         1.3     job-pause       3.0
> >      block-job-resume        1.3     job-resume      3.0
> >      block-job-complete      1.3     job-complete    3.0
> >      block-job-dismiss       2.12    job-dismiss     3.0
> >      block-job-finalize      2.12    job-finalize    3.0
> >      block-job-change        8.2
> >      query-block-jobs        1.1     query-jobs
> > 
> > I was under the impression that we added the (more general) job-
> > commands to replace the (less general) block-job commands, and we're
> > keeping the latter just for compatibility.  Am I mistaken?
> > 
> > Which one should be used?
> > 
> > Why not deprecate the one that shouldn't be used?
> > 
> > The addition of block-job-change without even trying to do job-change
> > makes me wonder: have we given up on the job- interface?
> > 
> > I'm okay with giving up on failures.  All I want is clarity.  Right now,
> > I feel thoroughly confused about the status block-jobs and jobs, and how
> > they're related.
> 
> Hi! I didn't notice, that the series was finally merged.
> 
> About the APIs, I think, of course we should deprecate block-job-* API, because we already have jobs which are not block-jobs, so we can't deprecate job-* API.
> 
> So I suggest a plan:
> 
> 1. Add job-change command simply in block-core.json, as a simple copy
>    of block-job-change, to not care with resolving inclusion loops.
>    (ha we could simply name our block-job-change to be job-change and
>    place it in block-core.json, but now is too late)
> 
> 2. Support changing speed in a new job-chage command. (or both in
>    block-job-change and job-change, keeping them equal)

It should be both block-job-change and job-change.

Having job-change in block-core.json rather than job.json is ugly, but
if Markus doesn't complain, why would I.

> 3. Deprecate block-job-* APIs
> 
> 4. Wait 3 releases
> 
> 5. Drop block-job-* APIs

I consider these strictly optional. We don't really have strong reasons
to deprecate these commands (they are just thin wrappers), and I think
libvirt still uses block-job-* in some places.

We also need to check if the interfaces are really the same. For
example, JobInfo is only a small subset of BlockJobInfo. Some things
could be added to JobInfo, other things like BlockDeviceIoStatus don't
really have a place there, so we would have to introduce job type
specific data in query-jobs first.

I'm sure it's all doable, but it might be more work than your list above
would make you think.

> 6. Move all job-related stuff to job.json, drop `{ 'include':
>    'job.json' }` from block-core.json, and instead include
>    block-core.json into job.json

Of course, this cleanup assumes that steps 3.-5. are really implemented.
If not, you would end up moving a lot more block related things to
job.json than after them.

Kevin


