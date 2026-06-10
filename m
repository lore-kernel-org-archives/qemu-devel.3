Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A135CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLem-0007Ey-Ib; Wed, 10 Jun 2026 12:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXLek-00078M-3t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXLei-0002os-IA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781108391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaDeH4LIoTfLU2nOk6YmmIXEAiIzcNkTHiQsFpqDOG8=;
 b=M0u5VQbdF4FOy0S7LtirjIqNn4+7j0zqr+cCc+aQioGR/PPyFebO+fQ8O1bimpAebt5RKl
 /6aNMRsHg/P1CAXoWUgpMb0LZ3x2JzFy6yh+kQgnWRJ9NRbbYc3HwLv8stgfZ1BC+RSjMS
 +bUAnFZfMAg5g6yU7ByUs6YP3/oFFNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-KaHwyAwWNSKiy8E0fBo6rA-1; Wed, 10 Jun 2026 12:19:48 -0400
X-MC-Unique: KaHwyAwWNSKiy8E0fBo6rA-1
X-Mimecast-MFC-AGG-ID: KaHwyAwWNSKiy8E0fBo6rA_1781108386
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so52612865e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781108386; x=1781713186; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oaDeH4LIoTfLU2nOk6YmmIXEAiIzcNkTHiQsFpqDOG8=;
 b=nnlTUZ1bKFobW5O695rEmaoOdL8SCPiawfSTpxGN+ee0WZ1F6mWwgMFy2RvhwrnqdN
 bqqXpkXPbErSQVn+m6iEijKGBLQGukxbzrnp7psNEQFOuPiseet8769krjTqbORp3v0a
 raxR2n/M+i9YgWtMy9LK9xbIxs4OL23zcR7b4qwmjwUw1Cf2ptEYfLSgSrv04OqQMv3T
 JsQ5nZcgU8pW0yJjuwfszkx2+PwrJzhjSotSmM/kgATRK4gxRxuewTH27Aq5XkVYWzJ0
 5QG7XASmgMYo7G7MYmuMPSbcSgxW2baIrDilotBoVCD+CG0hFjzPxJy3QzZ2eYAIBB0t
 bJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108386; x=1781713186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaDeH4LIoTfLU2nOk6YmmIXEAiIzcNkTHiQsFpqDOG8=;
 b=TD5OA2MVvY3JI/1DaxB+hiC3tJoZD60J/EimqjL8GrxOEJt8mf2SgeYYRz70zOUFxF
 J1UBz8Ib7djR2U0PDm7FPZXpymLhKbSSnupT9H5RcGHUFzFDWwjDEdfQ059kJpgs7YGX
 t/zgIBiYfZB3PBhbyqsJ8LZG916NIZpbfHNa8cJ7r/gBQ9I5M/tGwzY2UIxQgx48041N
 cYeXHrj86C+yB8jrUGNl+2pt+2HmL2pDyAprmavzHZcueTImDNp01duX2G0pOGMPZ5ac
 Dd9daIeY2wIbiZ5CoA03fIkahqALO4i+5ttotMRsk7sS63F3gkiqp/ddxH+hWqlMJu6r
 lAOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QH3y4+PGmkAM00S1iA4gxgndNN4/UV6bpBpvMcR9if/koGC7Ol0YDqk8AiYfIKbxS1JvLelfxFY/j@nongnu.org
X-Gm-Message-State: AOJu0Yy6ioAibnWq3omLBG59kCYUeYBO3SOds4JOHxsibTXw672CQMWM
 j8siPnrs9fc1WEmm9KvIUFN4icTF9Wgr7OLSs9mxlMGjAaJNylu0NsUhE0z19g7lj5eXEpm6o3/
 /Rc/nWyf8dSt+cXX41NNZ0co2+4tZ58UAm0zszBDciYfMKs/hTTediLO3
X-Gm-Gg: Acq92OF1zlLDAU1tL0ZcQnk+6SwCwUYxLbuXNzcI3vCdkn6LX2hP6mCYgo7HWjGBuvY
 QCldQKADp2CpOowol4ZNG8vhHfAYndaffTolOtJ27YA5woi1trL4YE4jRgZ3eNOReiGV56UcY8W
 WwXUa+17qSFHqlN4hbBpE/cASr7K9v5GY1IJLzHFCd5R6SUSHyxbgegMqhtkv0Bi9/bZxbJsRm0
 IXWvxJEty6wmrkiq2AtK/2BLY9AMGkaIPO/Gp7UjxwqvTeVMnfwUlkamqawretpugap4ptY7YOM
 qXUpTt2iFeMoF8/JpoUenONT4rTYlBaFOtCr1+vDxgripXxtdG6xLG6iWHmQfSjec/SmDrACbv+
 K9typiCJz6zYYwBCF/vpogi+VcJjjcC453LVybiaS6cDSeLEqHbCy5g==
X-Received: by 2002:a05:600c:5292:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-490d722e5ffmr110073495e9.27.1781108385847; 
 Wed, 10 Jun 2026 09:19:45 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-490d722e5ffmr110073045e9.27.1781108385294; 
 Wed, 10 Jun 2026 09:19:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e284bb55sm140685e9.4.2026.06.10.09.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:19:44 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:19:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610121846-mutt-send-email-mst@kernel.org>
References: <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8HhC-=KwdbNE5jgqdP+H1VF1aJXdGaME8KsaDHhnBG9Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 10, 2026 at 05:11:40PM +0100, Peter Maydell wrote:
> On Wed, 10 Jun 2026 at 16:37, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > This is the change that broke it I think?
> > >
> > >
> > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > Author: Alex Williamson <alex@shazbot.org>
> > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > >
> > >     memory: Don't use memcpy for ram_device regions
> > >
> > >
> > > Maybe Alex has an opinion on what to do.
> >
> > I can offer one idea here..
> >
> > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > we always use a helper (say, memmove_no_vector()) to do the split and
> > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > only applies to ram_device.
> 
> If the underlying memory needs to be accessed only with specific
> alignment/size, as the 4a2e242bbb30 commit message suggests, then
> we cannot expose it via address_space_map(), so we must have
> a bounce-buffer.

Right. And virtio currently isn't friendly to the bounce buffer.
We can fix that but I worry about the perf impact.

> The address_space_map() function says
> "here's a host pointer to  memory, do what you like to it", and
> the caller is entitled to memcpy to/from it or otherwise
> access it with any C operations, which are not guaranteed to
> respect any kind of alignment or similar restrictions.
> 
> My guess from commit 4a2e242bbb30 is that that applied an
> overly broad "don't do direct access" hammer to all
> vfio assigned devices, and that there needs to be some
> concept of "this vfio assigned device's region is OK for
> direct access" vs "this other one is not", such that if
> this GH100 card's BAR guarantees it can be treated entirely
> as RAM then we can have memory_region_supports_direct_access()
> return true for it.
> 
> thanks
> -- PMM


