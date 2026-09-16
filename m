Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F42C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vS5-0007Vd-7W; Wed, 16 Sep 2026 15:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6vRx-0007VC-Va
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6vRv-0000bq-GO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789587461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ddPrb1AZS7SPKfLU0ywrPzOfc0TWDpxcte2DMhl3NY=;
 b=Wd04HoPSlmdvIvYZLJm+XW3CESBNmCQ6naq2rFpkjxbb3bX9kZ089qRN7fip19BelhGlQO
 fsTGqVpGJrWPge2BDDADyNpbh+kLcP0eS0tfOy13dk9fzhNKuXyJ1fNb0MI3BNeN8dMDn1
 m2pwDVJ63pupvaURwBF5FywqXStcyGo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-3DaPdFe3PbeFrhdR4UkTrw-1; Wed, 16 Sep 2026 15:37:40 -0400
X-MC-Unique: 3DaPdFe3PbeFrhdR4UkTrw-1
X-Mimecast-MFC-AGG-ID: 3DaPdFe3PbeFrhdR4UkTrw_1789587460
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ff59f2c47so297651cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789587460; x=1790192260; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ddPrb1AZS7SPKfLU0ywrPzOfc0TWDpxcte2DMhl3NY=;
 b=IjTxXoDCtn949iy8w7hseFjTnzMJnzjdKhN0Uy8tXlng+xaSczRY369UFLMgSWTQog
 T0L7PXKTNaUn0j43i1a8ILQcSZvyA/vRB+/y1Ejcn+GJm8tLDpCH/P4oVKLbujhSDcBv
 xGrRELIdmTwYIHcvCMwsZKazo/pP9nLLhFb/cZ4X+IKZM3rOZt1gx+Jx3Q5kw1o3MvPO
 pBO45TS/6Yr3GsqZCVMwoO3laWa6k7x19YXNBmstA2K9UlQcnV8W8ooK6zFi1OKUZ7aj
 9hmcN5YLV2ZHlpyujjMv8geEdVoNnwNEMCcesDbXVKb0eerno/4Bde/yACuC0SG0F59H
 AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789587460; x=1790192260;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ddPrb1AZS7SPKfLU0ywrPzOfc0TWDpxcte2DMhl3NY=;
 b=u9KIkkzheijHy9IQxC+U4uJlTsTXTCRw45AYG8t8pdYJjUcnGeoyfSsuvrQoKaEQKY
 M0NOTstBtLH74ycF7z1RLEEOxt01ZJgX7JgmbckKe7p8Jlxhi8xoa99AyA/Sy+rNBsLM
 rk4evjJrIi2VqFE8K6ujgtqqYaBLRw4Ma6bk80H/HJ5dYspv9FKTwRvy1ch/wFoaqMha
 97a6pshB047DTtH1dee2Nbi9BPO1Xl1TAPADMqmyxU6XBPz6cTqBfrJPBcsUPnSs79cz
 GMIGviYpSJ4zFONfucQSr25HPGdgtp06zVd0qmL9wv26z79rFldbN/Bo4vvWTGlvg4Gv
 m8Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0150yYmDqsCejaG1wJnW1x+aVjr9T7PezjJ0GVoFR3ZEgiZ97fXKPdoqMkYw/elocVCj5u8JrCuYR@nongnu.org
X-Gm-Message-State: AFuF++nNMskVnpbxFh70QMR0qdPVZBOFB21Iau4Hz5cof8qACrH2ekIQ
 1Z6oJBudj03akM/S6nZTnDJa0P1wPEJJBfNXjNMP8VHZmfpvLuazI/rMq2jdi7w8YON/Mfscy9Q
 OcHHo5Oi9C0gdaKvRYHsGgDEOOgFtYT1de4jEiEN8gHILazsLDOV334MV
X-Gm-Gg: AYBFou1vr1rTMrqBtcPgaCDALWXtb7aNdoSoKFDpQtaiQk5++lk93q23vHbS1MptDHP
 c/tlfnA23u3tYwg5OrEgP3yeCQAIY8s1UPzFPua2rdErpRi/EY68nU6d0xh+B1jP9sZQj5EvVna
 X3RuOppfFulpU3QAxV2r+mDFnJ/OhMb1MXE6kOmwJfxJ9I3FaATRaxCdCkFvrhmVumAUkUy2Xnm
 dZd/UPnHIlyBSuBhVdLtVxssP5LYsOEGaVRvzfoQTvJ+ep1KX96VKD7ExMYUIbnwJ6tm0VdSnE3
 dLovMplPCoS/r4hsLHv1x6korrq9PbHp2SlnFeCxmxOfKCPs4xMWt5O8fKw906mQoCZQ4O4WDR8
 HHEfpgVCgPCluK9t1a1VwdkRMMrvWp/Jd+Jci90O2OkysDCB7LgGfKZlg62Q=
X-Received: by 2002:a05:622a:1208:b0:530:e0ad:89c1 with SMTP id
 d75a77b69052e-5328cfc0895mr13949711cf.21.1789587459706; 
 Wed, 16 Sep 2026 12:37:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1208:b0:530:e0ad:89c1 with SMTP id
 d75a77b69052e-5328cfc0895mr13949211cf.21.1789587459183; 
 Wed, 16 Sep 2026 12:37:39 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532620843dfsm30432011cf.22.2026.09.16.12.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 12:37:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:37:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqrwAftZOnT4LsI6@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v785rpml.fsf@suse.de>
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

On Wed, Sep 16, 2026 at 03:57:06PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
> >> From: Denis V. Lunev <den@openvz.org>
> >> 
> >> The cpr state is a process wide registry of the resources that have to
> >> survive an exec. Entries are added and dropped from realize and teardown
> >> paths all over the tree, and a caller has no way to tell which thread the
> >> next caller will run in.
> >> 
> >> The state carries no serialization of its own. It is safe today only
> >> because its callers happen to hold the BQL, and that is a property of
> >> where those callers live rather than anything the interface promises or
> >> checks. A caller that is correct within its own subsystem can therefore
> >> break this one from a distance: two that overlap corrupt the registry,
> >> and the next lookup walks an entry that has already been freed.
> >> 
> >> Give the state a lock of its own instead of relying on that. Entries
> >> move when a device is realized, when a resource is handed over, and when
> >> a migration starts, so none of this is on a hot path and an uncontended
> >> mutex costs nothing.
> >> 
> >> Take the lock in every accessor and across the save and load walks.
> >> Holding it over the walk callbacks is safe because none of them comes
> >> back through this interface. State that is not reached through these
> >> accessors, such as the VFIO device list that hw/vfio manipulates
> >> directly, stays outside it.
> >> 
> >> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Fabiano Rosas <farosas@suse.de>
> >> Cc: Mark Kanda <mark.kanda@oracle.com>
> >> Cc: Ben Chaney <bchaney@akamai.com>
> >> Cc: Steve Sistare <steven.sistare@oracle.com>
> >
> > Is there a real problem anywhere?
> >
> > My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
> > creating a new device or so, which should normally need bql already.
> >
> > To ask in another way, shall we simply assert bql_locked()?
> >
> > Thanks,
> 
> Fair questions, let's see what Denis says.
> 
> From my point of view, if the work is already done to use a lock, I'd
> take it; one less place for us to bother when dealing with BQL issues.
> 
> (on the other hand, I'm not doing any active use or testing of cpr aside
> from migration-test, so my opinion is the least important here)

Yep, I get it.  It's actually sometimes easier to just merge it.

But one thing I want to try to avoid is we introduce a lock, but without
knowing if it's needed.  The problem is for the future: we can't get rid of
the lock easily, exactly because then we also don't know what will start to
break.. so it might be good to ask early than never.

-- 
Peter Xu


