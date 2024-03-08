Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5143C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVy5-0004uE-E1; Fri, 08 Mar 2024 03:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riVy3-0004te-B9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:52:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1riVy1-0007ZV-Ir
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709887957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YPuuaEHOImUsZFpgGVW/dkGRNrsrtVc4W2rUT5CpHNo=;
 b=esRMn9B0heRUaP4ETmFP0CAtMofMJbrJiR4x26fmn3uWgJPb4USzAEoH2UtybnEdpudS8E
 ZI7CNZ97QDmuruAKWUmu1xcKC2oRw6ga+WaU13y2gUbKgIcKPztRXx50fPXGXrQyp2aUmQ
 hrkfHmgJbtu54SegToesrrq+I5HBUvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-11Y0wQRGNbG7LuJzbarK3g-1; Fri, 08 Mar 2024 03:52:33 -0500
X-MC-Unique: 11Y0wQRGNbG7LuJzbarK3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B565A185A783;
 Fri,  8 Mar 2024 08:52:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0892022AB6;
 Fri,  8 Mar 2024 08:52:30 +0000 (UTC)
Date: Fri, 8 Mar 2024 09:52:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Message-ID: <ZerRzZj-NrDZUeAF@redhat.com>
References: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 07.03.2024 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 04.03.24 14:09, Peter Krempa wrote:
> > On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
> > > Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > > On 03.11.23 18:56, Markus Armbruster wrote:
> > > > > Kevin Wolf<kwolf@redhat.com>  writes:
> > 
> > [...]
> > 
> > > > > Is the job abstraction a failure?
> > > > > 
> > > > > We have
> > > > > 
> > > > >       block-job- command      since   job- command    since
> > > > >       -----------------------------------------------------
> > > > >       block-job-set-speed     1.1
> > > > >       block-job-cancel        1.1     job-cancel      3.0
> > > > >       block-job-pause         1.3     job-pause       3.0
> > > > >       block-job-resume        1.3     job-resume      3.0
> > > > >       block-job-complete      1.3     job-complete    3.0
> > > > >       block-job-dismiss       2.12    job-dismiss     3.0
> > > > >       block-job-finalize      2.12    job-finalize    3.0
> > > > >       block-job-change        8.2
> > > > >       query-block-jobs        1.1     query-jobs
> > 
> > [...]
> > 
> > > I consider these strictly optional. We don't really have strong reasons
> > > to deprecate these commands (they are just thin wrappers), and I think
> > > libvirt still uses block-job-* in some places.
> > 
> > Libvirt uses 'block-job-cancel' because it has different semantics from
> > 'job-cancel' which libvirt documented as the behaviour of the API that
> > uses it. (Semantics regarding the expectation of what is written to the
> > destination node at the point when the job is cancelled).
> > 
> 
> That's the following semantics:
> 
>   # Note that if you issue 'block-job-cancel' after 'drive-mirror' has
>   # indicated (via the event BLOCK_JOB_READY) that the source and
>   # destination are synchronized, then the event triggered by this
>   # command changes to BLOCK_JOB_COMPLETED, to indicate that the
>   # mirroring has ended and the destination now has a point-in-time copy
>   # tied to the time of the cancellation.
> 
> Hmm. Looking at this, it looks for me, that should probably a
> 'block-job-complete" command (as leading to BLOCK_JOB_COMPLETED).

Yes, it's just a different completion mode.

> Actually, what is the difference between block-job-complete and
> block-job-cancel(force=false) for mirror in ready state?
> 
> I only see the following differencies:
> 
> 1. block-job-complete documents that it completes the job
>    synchronously.. But looking at mirror code I see it just set
>    s->should_complete = true, which will be then handled
>    asynchronously..  So I doubt that documentation is correct.
> 
> 2. block-job-complete will trigger final graph changes.
>    block-job-cancel will not.
> 
> Is [2] really useful? Seems yes: in case of some failure before
> starting migration target, we'd like to continue executing source. So,
> no reason to break block-graph in source, better keep it unchanged.
> 
> But I think, such behavior better be setup by mirror-job start
> parameter, rather then by special option for cancel (or even
> compelete) command, useful only for mirror.

I'm not sure, having the option on the complete command makes more sense
to me than having it in blockdev-mirror.

I do see the challenge of representing this meaningfully in QAPI,
though. Semantically it should be a union with job-specific options and
only mirror adds the graph-changes option. But the union variant
can't be directly selected from another option - instead we have a job
ID, and the variant is the job type of the job with this ID.

Practically speaking, we would probably indeed end up with an optional
field in the existing completion command.

> So, what about the following substitution for block-job-cancel:
> 
> block-job-cancel(force=true)  -->  use job-cancel
> 
> block-job-cancel(force=false) for backup, stream, commit  -->  use job-cancel
> 
> block-job-cancel(force=false) for mirror in ready mode  -->
> 
>   instead, use block-job-complete. If you don't need final graph
>   modification which mirror job normally does, use graph-change=false
>   parameter for blockdev-mirror command.

Apart from the open question where to put the option, agreed.

> (I can hardly remember, that we've already discussed something like
> this long time ago, but I don't remember the results)

I think everyone agreed that this is how things should be, and nobody
did anything to achieve it.

> I also a bit unsure about active commit soft-cancelling semantics. Is
> it actually useful? If yes, block-commit command will need similar
> option.

Hm... That would commit everything down to the lower layer and then keep
the old overlays still around?

I could see a limited use case for committing into the immediate backing
file and then keep using the overlay to accumulate new changes (would be
more useful if we discarded the old content). Once you have intermediate
backing files, I don't think it makes any sense any more.

Kevin


