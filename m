Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5EBC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BFV-00011P-T5; Thu, 17 Sep 2026 08:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BFQ-00010v-Bh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BFO-00086v-3C
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789648188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+laE03R+oB5XHI3Umg1Xx7VxnHqA/Y6t4kVSuzivhMA=;
 b=Y903J1+GmJ38PjaIHA2cOs8MXSqTcF8vayyAfFod1e8NNq3+bWptQFCkRcjAjMiVIIvQWg
 WNHygIwS0alerxxQZwJrZVEszF00M5/LU8I7XD+DnpFltuqh9mtrD6sIHN+b88gcQzd924
 AJuXnsXNSaBn50kU5xGtckouj9H4X9g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-yx7mVsLiNJmDxN5bkaJ_dQ-1; Thu, 17 Sep 2026 08:29:46 -0400
X-MC-Unique: yx7mVsLiNJmDxN5bkaJ_dQ-1
X-Mimecast-MFC-AGG-ID: yx7mVsLiNJmDxN5bkaJ_dQ_1789648185
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso20028916d6.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789648185; x=1790252985; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+laE03R+oB5XHI3Umg1Xx7VxnHqA/Y6t4kVSuzivhMA=;
 b=tuIZZBjOXEAmFdI4lgFhYmfmSjRZG0I2f0NPTo+4xWXt0TydNepokZ3v4h3NjU4Icx
 zEzZCWa3aQrQ+/SW3hkoB0Q7IjNhrGPEM74ntVrCtvX7oodu5hCZI5A/EyWYPI15A0wR
 IRJEvNvcn7Yo6A9NOf4XeA+1X3nuyg9OnE0hQzP0uadyuJnhHnUA4OoQdlO8XtVWcq8l
 u/cXyvfR3BrKZQq0KyNbUPzPDYp24cYd/5NSfWsofQw8+DUAbukyossYgcEDB2kUBoBo
 lIQBAX7FwaTolj6v8UFjUk94H8+56wwYAbGLuaY17+XzW6NATVUby9P5GjBm82TazWk2
 Y/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648185; x=1790252985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+laE03R+oB5XHI3Umg1Xx7VxnHqA/Y6t4kVSuzivhMA=;
 b=FUnFzU3y6AkUOasfgAg3Eqro3/4iTwrBFvTCoJ9snfYqbhHAGu7ac0hlJXAN7uefom
 RxHMSetEKOI3tKS/S5MTk29HmUgbG+uKtqBluyK86awpdXi5uRO0YjYn3plVx4Fjp6/9
 3p57V+AfgaCj41mL3kPd/Bp7knf1+s6gQZI8ziyyKE9E8OxpvC0QefLmaaZKB1NEi7WF
 W4JN3fEDmu2v9HJTKJvChqI4QaUT1ORWSZ7CRF1V46k8AMJxSx4SCzJ0f6Ia95o/eM2o
 u+DR1DcyXKaersab4i378z+glkEZs+5xla1A5ZuIXlqLcN78fmZUTClP74449BbYFmDT
 /tYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHo3PYJ+r1pzn/RX9MzoossUPgBZzrMmE0L6837z0PWKF7aXBFY0OBNGJUcbOqJ4gAbNvXeivXlKIW@nongnu.org
X-Gm-Message-State: AFuF++kqFGHgaD1/NmX12m5PW8LkbYGDnpWFXfNuHdORKnj2q1IJF7i6
 cIQEvmWW4I8/FQsQNNP5zxE2DA1vUvUsq1024FFsHSsi7yGLoU/GenI9H+FRTfXm88qpajwXX1C
 3nj9io/jElxfDqOYnCUHOi8XJ1fuKUwZbIZmPQKKQu9RtWS7HsxPw641f
X-Gm-Gg: AYBFou08j4UvOSVdA1zjiOdgoznTHq9aW0B4t9eI1qg9JMiInhuXxK5DTCF/UBQra7M
 APkz0Mh0s+d+Ct+1NWsa5d093789c0vCDbX8k0cOkPqXpQJEiKBo846FALalwhN+JXNfzVA9TKZ
 YZioe539LtexvFjVT+Qz6pj7+FSKHi+aY1S7MTsVlDpG+XCqhhqfG3OgzBHmJL0fCWjdPSZvXeF
 bHOXXLRqivWveBsV2JSezN19aJUY51VcPc4o+zJzk99AuZrxZHeGcXq7i0apLkU1dXaCWOvf0yG
 DM3wjsLrpP0/xql8DJfHktllfCNXeBOQqyLi1YkPL+6Zx44BwbWJK/t6nckF/co6zOmO
X-Received: by 2002:a05:6214:b6b:b0:8c9:c38a:20e1 with SMTP id
 6a1803df08f44-9123d74d285mr111373616d6.10.1789648185355; 
 Thu, 17 Sep 2026 05:29:45 -0700 (PDT)
X-Received: by 2002:a05:6214:b6b:b0:8c9:c38a:20e1 with SMTP id
 6a1803df08f44-9123d74d285mr111373126d6.10.1789648184706; 
 Thu, 17 Sep 2026 05:29:44 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bddcee0sm49050706d6.1.2026.09.17.05.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:29:44 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:29:33 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqvdLTnCbkHjJZO0@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
 <c7cef33d-5f23-493a-b437-e55a3b48736d@virtuozzo.com>
 <aqr_ZzShIhXG8oTk@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <2dc82f7a-9132-487c-92a6-000bfa32e085@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dc82f7a-9132-487c-92a6-000bfa32e085@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 17, 2026 at 11:48:52AM +0200, Denis V. Lunev wrote:
> On 9/16/26 22:43, Peter Xu wrote:
> > On Wed, Sep 16, 2026 at 09:45:56PM +0200, Denis V. Lunev wrote:
> >> On 9/16/26 20:57, Fabiano Rosas wrote:
> >>> Peter Xu <peterx@redhat.com> writes:
> >>>
> >>>> On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
> >>>>> From: Denis V. Lunev <den@openvz.org>
> >>>>>
> >>>>> The cpr state is a process wide registry of the resources that have to
> >>>>> survive an exec. Entries are added and dropped from realize and teardown
> >>>>> paths all over the tree, and a caller has no way to tell which thread the
> >>>>> next caller will run in.
> >>>>>
> >>>>> The state carries no serialization of its own. It is safe today only
> >>>>> because its callers happen to hold the BQL, and that is a property of
> >>>>> where those callers live rather than anything the interface promises or
> >>>>> checks. A caller that is correct within its own subsystem can therefore
> >>>>> break this one from a distance: two that overlap corrupt the registry,
> >>>>> and the next lookup walks an entry that has already been freed.
> >>>>>
> >>>>> Give the state a lock of its own instead of relying on that. Entries
> >>>>> move when a device is realized, when a resource is handed over, and when
> >>>>> a migration starts, so none of this is on a hot path and an uncontended
> >>>>> mutex costs nothing.
> >>>>>
> >>>>> Take the lock in every accessor and across the save and load walks.
> >>>>> Holding it over the walk callbacks is safe because none of them comes
> >>>>> back through this interface. State that is not reached through these
> >>>>> accessors, such as the VFIO device list that hw/vfio manipulates
> >>>>> directly, stays outside it.
> >>>>>
> >>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >>>>> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >>>>> Cc: Peter Xu <peterx@redhat.com>
> >>>>> Cc: Fabiano Rosas <farosas@suse.de>
> >>>>> Cc: Mark Kanda <mark.kanda@oracle.com>
> >>>>> Cc: Ben Chaney <bchaney@akamai.com>
> >>>>> Cc: Steve Sistare <steven.sistare@oracle.com>
> >>>> Is there a real problem anywhere?
> >>>>
> >>>> My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
> >>>> creating a new device or so, which should normally need bql already.
> >>>>
> >>>> To ask in another way, shall we simply assert bql_locked()?
> >>>>
> >>>> Thanks,
> >>> Fair questions, let's see what Denis says.
> >>>
> >>> From my point of view, if the work is already done to use a lock, I'd
> >>> take it; one less place for us to bother when dealing with BQL issues.
> >>>
> >>> (on the other hand, I'm not doing any active use or testing of cpr aside
> >>> from migration-test, so my opinion is the least important here)
> >> The fair answer if the following.
> >>
> >> 1. Right now FD database is already accessed from main thread and
> >>    from vCPU threads (MSIx handling). It is fortunately protected
> >>    with BQL.
> >>
> >> 2. There is no real today problem right now. You are right. The
> >>    problem is in downstream.
> >>
> >> But the problem is real. We either should fix either contract
> >> in written - just BQL or add the lock.
> >>
> >> I do think that CPR have value for the project - devices will
> >> come sooner or late and the database is to be protected.
> >>
> >> This is fair statement for today.
> > Thanks for the explanation.
> >
> > Logically we shouldn't merge anything that only works for downstream but
> > not upstream, but I agree this one is sensible on its own.
> >
> > Perhaps we can add some more info into the commig log?  The vCPU MSIx
> > handling, even if not applicable to a real issue, seems to be a good
> > example to illustrate the potential problem. In this case, personally I'd
> > even prefer stating the fact that "only our downstream is affected, but we
> > want to upstream this patch too because .."  these kind of things, rather
> > than being obscure on reasoning.
> >
> > Do you plan to upstream the affected component?  If so, I would still
> > suggest to have this patch be together with that series, because that's
> > where it really will make a difference (rather than purely wasting pCPU
> > cycles on some lock bit..).
> >
> > Otherwise I don't have a strong opinion, this one is a light change, maint
> > cost low (it'll be different if cpr_walk_fd() can take any cb().. but it's
> > not the case), we can have it.  I'll leave this to Fabiano to say. Sorry if
> > I'm too verbose here.
> >
> > Thanks,
> >
> The problems is caused by the external communication sockets
> which we are willing to keep, starting from monitor.
> Monitor in reality should be kept in the other case
> it would be very unclear at which moment libvirt should
> start reconnecting.
> 
> This adds hooks to socket backend and dances begin.
> 
> I will take a look whether this has been sent/discussed and
> come with this.

Ah I see, I recall Steve used to upstream something like that for chardev
backing monitors.  I thought it has landed.  I hope there're not two impl
of that problem, then it may imply we should upstream one of them.

> 
> For now we could add comment: we are protected with BQL.
> Will this work as a replacement? Both approaches are fine
> for me.

So now I'm trying to think from the problematic branch, not master.  In
that case it is libvirt connection kicking off the monitor iothread to
inject some client socket fd to CPR, right?  In that case, maybe BQL isn't
suitable anymore, because IIUC we don't want to take BQL in the monitor
iothread, at least for the same of Out-Of-Band messages to work.

Please help investigate the status quo for chardev cpr support and maybe
we'll know better, thanks.  If we want to merge this then it'll be great
the commit log contains all important bits (especially, if BQL is not the
right lock to use), because now I feel like taking BQL there is wrong then.

Thanks,

-- 
Peter Xu


