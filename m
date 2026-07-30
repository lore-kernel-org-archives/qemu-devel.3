Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF262C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpS1P-0001D0-TQ; Thu, 30 Jul 2026 10:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpS1K-0001C8-Cq
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpS1I-0000vB-C3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785422758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQbktjsH6wyMLJ057fR4DgwyaLjx0tKqUNxuq1tAbVA=;
 b=IWwu0WO17YWvM/wlN4Aq1AcQv2YwD+N4zp10FC8TUYZqSEBkNTQ/fHC1Tpv/vhQ1Em0oDI
 NM48VwvPb9PxVG9PwSN9hft5A1czzWTmQFa5g30JV0/q+qby8bRWslx6onUBQCzLSbUO2I
 zhcAeKVnRNZzl0kuzXwPuqO4adXG4ic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-fH82nHFHP_qadRDVfquOKw-1; Thu, 30 Jul 2026 10:45:57 -0400
X-MC-Unique: fH82nHFHP_qadRDVfquOKw-1
X-Mimecast-MFC-AGG-ID: fH82nHFHP_qadRDVfquOKw_1785422756
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b4cc049fso8294005e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785422756; x=1786027556; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QQbktjsH6wyMLJ057fR4DgwyaLjx0tKqUNxuq1tAbVA=;
 b=SStiItUOWSTW9WNX9tmqFQJa7M4TEF69hQiPg+DoHpDeuSpyiE7xEAPRhgSC/gd670
 8PIZJ09as6f3deLfOanDxui4MFQv8zT5NwLVIKdiZ2xwfzQW/rqVs5D9AeyD53Dw10gS
 uZAUrZvQ3wdQdPKZu1qjFP1SjGN+9jwPc1NtLfMrMNQwPAlObww/HNOdJWklw37vbIGd
 xY7ZjJi3hXOhg+WcNIVTKseXgfDo7F7Yr3YBTmmngZB+xximrEHM+PH6ypJkuJ4ZlDDK
 obMflZ2AmiDF1MgTySbzIWbQ+IkbItgYRf1I0IfIpWbwIlm5exc1H9PaNxHIcz1SCDJz
 3hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422756; x=1786027556;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QQbktjsH6wyMLJ057fR4DgwyaLjx0tKqUNxuq1tAbVA=;
 b=n+6Az7OCoxUM+lquJ7sdAtXbiqwrEtjb92scRCpiOBcjpIw9ARrUgQ0knwyrnTn6HB
 iVzcrkCIot10izDLEj/Ybjs7U5FPD0lUkh+rjbsOkI6dOyUD6ralEjMoVhI7seYCgqfn
 fhCG1hrPheWjUGJbZk83jv4p3zQTHaWJrP9nkLvjqe8ood/+xG7XXvF/jUpb0NgAG1pM
 cum2l/FyRFeeTjTHirtmr1WllSl9htyuB1dBZ+NaqFF9JQ8xKAA/Zi6rZbcl1IzLfxoX
 R8dWbW7XQfblnCgezl30b1K7XKvQCHO8KWwKgl/3iZEg7kPnCA7qL0hq0J+gdVTnH4XS
 vsQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpT/x9OMBhaGdXLA2H/JxDlicAWyNLifuJuK4ug9flfrGspDmEuLnd0UuSscgkhftMyjYbCmgMKs6fF@nongnu.org
X-Gm-Message-State: AOJu0Yxh7dFERHY8GClbM3OVe6grFzZojeu5AQa9SpshEMtbE26FWVBk
 dFMSG/bJfhORO3CZmNmNLBPDncoaa8sWep+IQTVhvli+CXLQhBYHkcKAaPOKYiJnMd0xLygmMtU
 Zfs/dBEXwFgjpt03gboIl8coXmp6U7mII8guQW9d/TNN5LZZqaNS0HXkm
X-Gm-Gg: AR+sD12GLq4lFHNW2acwaOaeCzn9xofUdDwAobZi3OBb5ZAR+Q18bgDxMBmEPpGYmCX
 RmhTgmq/1C7xgajPd+ZHk+qJOaiP4nE3NLb37gcX02S2lfSt2lf0srA2/VxiTQ/l/VBcVs44xZE
 WjWaC4yulv99EvRtmRJvfY+r/IoXztWKAxGvFYK3q1wYiXarq8JOeTub39xOO9cPU8N/pEUrEq0
 vZTrkgZW4Y7C4LKbIBmCanr/090lkbMru2CW+umpyZ16Pwgw+ih0Q/0tE5DBfiUFq8djk8mdgsP
 LXtcKjauYHcckTCR6ve4zA1RgCikaeRJxVhz37A4ZMjCpc2y8WzSZDbtN+aMuriTsmcfU4HnSDI
 igE4o2mLQtkJADuJURXOnEaE=
X-Received: by 2002:a05:600c:4708:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-49804ce5250mr8391985e9.1.1785422755678; 
 Thu, 30 Jul 2026 07:45:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-49804ce5250mr8391425e9.1.1785422755070; 
 Thu, 30 Jul 2026 07:45:55 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f24632sm59746315e9.7.2026.07.30.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:45:53 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:45:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
Message-ID: <20260730103634-mutt-send-email-mst@kernel.org>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local> <amteJEbrPguzFpH5@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amteJEbrPguzFpH5@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Thu, Jul 30, 2026 at 10:22:28AM -0400, Peter Xu wrote:
> On Thu, Jul 30, 2026 at 10:09:30AM -0400, Peter Xu wrote:
> > On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
> > > Hi, this is basically what I ranted about in:
> > > https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> > > 
> > > I'm replacing the per-integer-size type checks with a single "int that
> > > fits in 32bit" check. This allows several lines of duplicated code to
> > > be removed.
> > > 
> > > I haven't changed the macro names in the device code yet. If this
> > > series gets positive feedback then I'll send per-subsystem patches
> > > doing that.
> > > 
> > > CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> > > Also tested:
> > > - migration-test --full --thorough
> > > - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> > > - s390x compat run forwards and backwards for previous 2 QEMU releases
> > > - ppc64 compat run forwards and backwards for previous QEMU release
> > > - migration-test smoke ASAN/UBSAN run
> > > 
> > > Fabiano Rosas (4):
> > >   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
> > >   migration: Introduce VMStateOffset
> > >   migration: Remove redundant flags
> > >   migration: Remove duplicate vmstate macros
> > 
> > Nice work!
> > 
> > I think I was only looking at VBUFFER side and I thought it was fine
> > sticking with 32bit even signed or not, not a huge deal.  But cleaning up
> > VARRAY whole thing together looks definitely an improvement.  I definitely
> > like your version here.
> > 
> > I assume with your series I can drop both of my patches here, right?
> > 
> >   [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
> >   https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
> >   (I'll still respin with the rest)
> > 
> >   [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
> >   https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com
> > 
> > The only missing piece would be an multiply overflow check in
> > vmstate_handle_alloc(), if you could add that check too while rewritting
> > that in patch 1 then I think it'll cover all.
> > 
> > Vladimir's ask in the separate email makes sense: I wonder if we can also
> > do one step further and merge VBUFFER into VARRAY.
> > 
> > The other trivial thing is, while looking, I found one trivial macro
> > VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.
> 
> Now officially declare support for u64 on all these offsets, we also need
> to double check on our alignment with security issues.
> Similar reports will not be a bug anymore but results will be the same I
> assume: it's anything the attacker can feed a u64 directly (instead of an
> int32_t negative overflow), result is still failing a malloc() with
> enormously large numbers, legally this time.
> 
> Do you still plan to work on finding per-user upper limit or whatever of
> that kind?  I'd say time spent working on series like this worths more than
> that, but I still want to check with you while looking at this solution.
> 
> I suppose with this, one option is we can close all tickets reporting
> security issues while allocating with all u64 fields.

All issues where migration stream is malformed aren't security issues
according to the current policy.

Whether to close these or use them as a starting point in research,
is up to you guys.


> 
> Thanks,
> 
> -- 
> Peter Xu


