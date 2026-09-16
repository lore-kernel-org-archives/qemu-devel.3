Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E6C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wTl-0003hD-4f; Wed, 16 Sep 2026 16:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6wTi-0003h3-PJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6wTf-0004ql-UV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789591414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZwR5Zd4YKvyPgDB4dWGjB35WVKU1zDzWyLTNeyuQWo=;
 b=U6C8SgKujseiwGJ4pkeU4yX0TVgAG6/DJjodl2D/FhZKzT7hbrpUAwwRxEP4om/6Bl8NWV
 GO/nBdHCIYVccw3kBtBF1A77kX13lTrhXENM0WKNUcjoDzpWlA4LynXPTawQBdyRDb/Cvn
 NUJMKN1zbPmX31l3d0TLoFZ8LiNeWbU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-WB76IkjKNom--5JoR5uqjQ-1; Wed, 16 Sep 2026 16:43:33 -0400
X-MC-Unique: WB76IkjKNom--5JoR5uqjQ-1
X-Mimecast-MFC-AGG-ID: WB76IkjKNom--5JoR5uqjQ_1789591412
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so18338885a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789591412; x=1790196212; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vZwR5Zd4YKvyPgDB4dWGjB35WVKU1zDzWyLTNeyuQWo=;
 b=sZmtlELOD3kx2d1wLzbV5BWUZ14w/0Qmv68C0UW02rJ/LplEXRCRAy8qM+F5E2BMb4
 GuG4oLlhYcXFLkOx6fT2vEAtXwWNrSPY22g+MX8UZPQ9kuuWw+4cDJdRo9u/uJQzzQVm
 dbfzgtOV6VuQUTur9+k2ldIvx3q6oQgt50EH4yOAgDnuM7ptpRxW3W3ZjaoWSId1MHmh
 Q1djTv1E6G4gFf8JPJPDkojK5LJdrFhcm4vIfRQz8zeCtNNcYddVYF/O+p9HxNQaKiqy
 JxVPVWihIDPR8wkPnir5lVFK5dfhGp73PR/2wu0nu4pmc9mZwTFZ/oqfTq9VKLlsO6J8
 9Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789591412; x=1790196212;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vZwR5Zd4YKvyPgDB4dWGjB35WVKU1zDzWyLTNeyuQWo=;
 b=usx18aOtgv7ycxkswwOwOPlMkUxq35mDYs5exh5GeI6+/+fsM0SE12xAPVrSqP4SxF
 F3CiMyZ+cJ00Xjw9y7LbobtMCZo4SgeRqrJSIbr2TW0ueL1D8zoz0Etg1rpKGRkWMZDj
 lHAm46oSQWC7dPxowDag6SnH8HYSAzAy70WvGuPp9DAdjLKEfMls09vpIAm4d3G4IN4C
 WIpPhvNOvM0Xl8bLkz5C2/LqSjBTaplXyszSzHDstMK15oM7CzH3HKPyHmOlEc1GZLXW
 mN6n7N7gdsQJ43lk7fG41e5c6gHyQRVRvqDijVWme70/UBQhLNFcvKO71oLi49mczU4j
 KG4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaGasarH/JhjDEpaqG3+H3c3go7Wxv6AY2clj31ICpoUhvDq1vANm6Jh6p3vAwrJWhrF5dVFWl61Xn@nongnu.org
X-Gm-Message-State: AFuF++lLjMV5Geq5XDtwV7XqypXVgI2uTL8JBjUr4EKU985s3IyCOCxT
 ECVjvEeHDRWDrGE8P2Lx1dSymoVCqop5wvIHr2HOgU2d8TBKwXui0VApNzCsSN4GU6dtrtcMSD7
 HDiHqS7uoYBCTIEjBGcfLabRFkwzTuYRqJYRRqrO10dE3MOIqF5e2k9W/
X-Gm-Gg: AYBFou2/PCidhPpVLsnlu5oMyyem1KXu18vbHZ5kt8eZXbAUjp8F5tIuSWbxJcD3Ml7
 5Mm67eXs3aznHIlR1Fb8MTvZMtiIcgouz/7kbelpzXh5SSFaiD/rSGuErwGokjf+gopWwrRJdyP
 FOrKwy4exwGL0NhdYAM72GI3hG60tzArocWFl6OusQUc6Xwy2Xd4xra4nAAYP9Zx3dcclOI/N7+
 HMAI60gPYNZXJkXEerguDXT47oISr84jUEUP4TS1M4Pj7irsfHLBGrVBzT4INlrKabrwZDGIkro
 3kRscPhav5ixLAGx6q9R4uLb4QBgQziyaXfkl7zOMMm80O8o6wZFAXDbN2oPGkJAzAvg
X-Received: by 2002:a05:620a:40d5:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-93bb7947dcdmr704057085a.48.1789591412322; 
 Wed, 16 Sep 2026 13:43:32 -0700 (PDT)
X-Received: by 2002:a05:620a:40d5:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-93bb7947dcdmr704051485a.48.1789591411791; 
 Wed, 16 Sep 2026 13:43:31 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b780ca630sm294744685a.4.2026.09.16.13.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 13:43:30 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:43:19 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqr_ZzShIhXG8oTk@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
 <c7cef33d-5f23-493a-b437-e55a3b48736d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7cef33d-5f23-493a-b437-e55a3b48736d@virtuozzo.com>
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

On Wed, Sep 16, 2026 at 09:45:56PM +0200, Denis V. Lunev wrote:
> On 9/16/26 20:57, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
> >>> From: Denis V. Lunev <den@openvz.org>
> >>>
> >>> The cpr state is a process wide registry of the resources that have to
> >>> survive an exec. Entries are added and dropped from realize and teardown
> >>> paths all over the tree, and a caller has no way to tell which thread the
> >>> next caller will run in.
> >>>
> >>> The state carries no serialization of its own. It is safe today only
> >>> because its callers happen to hold the BQL, and that is a property of
> >>> where those callers live rather than anything the interface promises or
> >>> checks. A caller that is correct within its own subsystem can therefore
> >>> break this one from a distance: two that overlap corrupt the registry,
> >>> and the next lookup walks an entry that has already been freed.
> >>>
> >>> Give the state a lock of its own instead of relying on that. Entries
> >>> move when a device is realized, when a resource is handed over, and when
> >>> a migration starts, so none of this is on a hot path and an uncontended
> >>> mutex costs nothing.
> >>>
> >>> Take the lock in every accessor and across the save and load walks.
> >>> Holding it over the walk callbacks is safe because none of them comes
> >>> back through this interface. State that is not reached through these
> >>> accessors, such as the VFIO device list that hw/vfio manipulates
> >>> directly, stays outside it.
> >>>
> >>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >>> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Fabiano Rosas <farosas@suse.de>
> >>> Cc: Mark Kanda <mark.kanda@oracle.com>
> >>> Cc: Ben Chaney <bchaney@akamai.com>
> >>> Cc: Steve Sistare <steven.sistare@oracle.com>
> >> Is there a real problem anywhere?
> >>
> >> My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
> >> creating a new device or so, which should normally need bql already.
> >>
> >> To ask in another way, shall we simply assert bql_locked()?
> >>
> >> Thanks,
> > Fair questions, let's see what Denis says.
> >
> > From my point of view, if the work is already done to use a lock, I'd
> > take it; one less place for us to bother when dealing with BQL issues.
> >
> > (on the other hand, I'm not doing any active use or testing of cpr aside
> > from migration-test, so my opinion is the least important here)
> The fair answer if the following.
> 
> 1. Right now FD database is already accessed from main thread and
>    from vCPU threads (MSIx handling). It is fortunately protected
>    with BQL.
> 
> 2. There is no real today problem right now. You are right. The
>    problem is in downstream.
> 
> But the problem is real. We either should fix either contract
> in written - just BQL or add the lock.
> 
> I do think that CPR have value for the project - devices will
> come sooner or late and the database is to be protected.
> 
> This is fair statement for today.

Thanks for the explanation.

Logically we shouldn't merge anything that only works for downstream but
not upstream, but I agree this one is sensible on its own.

Perhaps we can add some more info into the commig log?  The vCPU MSIx
handling, even if not applicable to a real issue, seems to be a good
example to illustrate the potential problem. In this case, personally I'd
even prefer stating the fact that "only our downstream is affected, but we
want to upstream this patch too because .."  these kind of things, rather
than being obscure on reasoning.

Do you plan to upstream the affected component?  If so, I would still
suggest to have this patch be together with that series, because that's
where it really will make a difference (rather than purely wasting pCPU
cycles on some lock bit..).

Otherwise I don't have a strong opinion, this one is a light change, maint
cost low (it'll be different if cpr_walk_fd() can take any cb().. but it's
not the case), we can have it.  I'll leave this to Fabiano to say. Sorry if
I'm too verbose here.

Thanks,

-- 
Peter Xu


