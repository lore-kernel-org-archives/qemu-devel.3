Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F97C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4OM-0004Mf-1x; Tue, 12 Mar 2024 11:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rk4OB-0004Jv-Fp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rk4O9-0003O6-K6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710258600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lY188FiJ2YuM7uSFDgQLN8tycDgILAK9Yyk3onuPocA=;
 b=Sk1gtF/bOazfHIixhUxoH1pxYwX+OLNTZiQKxwg7O2CK2Px21MXu25wwfRyabX42+thTT9
 NcuoAIang4ZZpL8Fsyoly4NuBX/WVP0WhHxATpH5LpmtdHBRTltMRbL1X31MnEP8U/vydj
 gD1tg9oLDEH/JIyKwWsirzre6LdKeM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-_Hjyh2LPOBuNEVBq8xCizQ-1; Tue, 12 Mar 2024 11:49:57 -0400
X-MC-Unique: _Hjyh2LPOBuNEVBq8xCizQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A99EB822486;
 Tue, 12 Mar 2024 15:49:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FA62166AE5;
 Tue, 12 Mar 2024 15:49:54 +0000 (UTC)
Date: Tue, 12 Mar 2024 16:49:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZfB5oaFgYJ8SuSm1@redhat.com>
References: <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
 <ZerRzZj-NrDZUeAF@redhat.com>
 <306d2ca4-de7d-4318-b461-a06354e3b975@yandex-team.ru>
 <1d6ba74e-b1d8-4292-9825-ea53d9bc77af@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d6ba74e-b1d8-4292-9825-ea53d9bc77af@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 12.03.2024 um 14:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 11.03.24 18:15, Vladimir Sementsov-Ogievskiy wrote:
> > On 08.03.24 11:52, Kevin Wolf wrote:
> > > Am 07.03.2024 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > > On 04.03.24 14:09, Peter Krempa wrote:
> > > > > On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
> > > > > > Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > > > > > On 03.11.23 18:56, Markus Armbruster wrote:
> > > > > > > > Kevin Wolf<kwolf@redhat.com>  writes:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > > Is the job abstraction a failure?
> > > > > > > > 
> > > > > > > > We have
> > > > > > > > 
> > > > > > > >        block-job- command      since   job- command    since
> > > > > > > >        -----------------------------------------------------
> > > > > > > >        block-job-set-speed     1.1
> > > > > > > >        block-job-cancel        1.1     job-cancel      3.0
> > > > > > > >        block-job-pause         1.3     job-pause       3.0
> > > > > > > >        block-job-resume        1.3     job-resume      3.0
> > > > > > > >        block-job-complete      1.3     job-complete    3.0
> > > > > > > >        block-job-dismiss       2.12    job-dismiss     3.0
> > > > > > > >        block-job-finalize      2.12    job-finalize    3.0
> > > > > > > >        block-job-change        8.2
> > > > > > > >        query-block-jobs        1.1     query-jobs
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > I consider these strictly optional. We don't really have strong reasons
> > > > > > to deprecate these commands (they are just thin wrappers), and I think
> > > > > > libvirt still uses block-job-* in some places.
> > > > > 
> > > > > Libvirt uses 'block-job-cancel' because it has different semantics from
> > > > > 'job-cancel' which libvirt documented as the behaviour of the API that
> > > > > uses it. (Semantics regarding the expectation of what is written to the
> > > > > destination node at the point when the job is cancelled).
> > > > > 
> > > > 
> > > > That's the following semantics:
> > > > 
> > > >    # Note that if you issue 'block-job-cancel' after 'drive-mirror' has
> > > >    # indicated (via the event BLOCK_JOB_READY) that the source and
> > > >    # destination are synchronized, then the event triggered by this
> > > >    # command changes to BLOCK_JOB_COMPLETED, to indicate that the
> > > >    # mirroring has ended and the destination now has a point-in-time copy
> > > >    # tied to the time of the cancellation.
> > > > 
> > > > Hmm. Looking at this, it looks for me, that should probably a
> > > > 'block-job-complete" command (as leading to BLOCK_JOB_COMPLETED).
> > > 
> > > Yes, it's just a different completion mode.
> > > 
> > > > Actually, what is the difference between block-job-complete and
> > > > block-job-cancel(force=false) for mirror in ready state?
> > > > 
> > > > I only see the following differencies:
> > > > 
> > > > 1. block-job-complete documents that it completes the job
> > > >     synchronously.. But looking at mirror code I see it just set
> > > >     s->should_complete = true, which will be then handled
> > > >     asynchronously..  So I doubt that documentation is correct.
> > > > 
> > > > 2. block-job-complete will trigger final graph changes.
> > > >     block-job-cancel will not.
> > > > 
> > > > Is [2] really useful? Seems yes: in case of some failure before
> > > > starting migration target, we'd like to continue executing source. So,
> > > > no reason to break block-graph in source, better keep it unchanged.
> > > > 
> > > > But I think, such behavior better be setup by mirror-job start
> > > > parameter, rather then by special option for cancel (or even
> > > > compelete) command, useful only for mirror.
> > > 
> > > I'm not sure, having the option on the complete command makes more sense
> > > to me than having it in blockdev-mirror.
> > > 
> > > I do see the challenge of representing this meaningfully in QAPI,
> > > though. Semantically it should be a union with job-specific options and
> > > only mirror adds the graph-changes option. But the union variant
> > > can't be directly selected from another option - instead we have a job
> > > ID, and the variant is the job type of the job with this ID.
> > 
> > We already have such command: block-job-change. Which has id and type parameters, so user have to pass both, to identify the job itself and pick corresponding variant of the union type.
> > 
> > That would be good to somehow teach QAPI to get the type automatically from the job itself...
> 
> 
> Seems, that's easy enough to implement such a possibility, I'll try. At least now I have a prototype, which compiles
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0ae8ae62dc..332de67e52 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3116,13 +3116,11 @@
>  #
>  # @id: The job identifier
>  #
> -# @type: The job type
> -#
>  # Since: 8.2
>  ##
>  { 'union': 'BlockJobChangeOptions',
> -  'base': { 'id': 'str', 'type': 'JobType' },
> -  'discriminator': 'type',
> +  'base': { 'id': 'str' },
> +  'discriminator': 'JobType',
>    'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }

We probably need some different syntax because I think in theory we
could get conflicts between option names and type names. But I'll leave
this discussion to Markus. I hope you can figure out something that he
is willing to accept, getting the variant from a callback looks like
useful functionality.

For output, your implementation is probably not optimal because you're
going to look up things the calling code already knows, but it's
probably not the end of the world.

Kevin


