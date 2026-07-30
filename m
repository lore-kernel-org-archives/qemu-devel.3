Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6AC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTP8-0006lv-V8; Thu, 30 Jul 2026 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTP5-0006gb-59
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTP3-0003k8-BF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785428076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsBn1r8k3tfnNoP7GImjCubK30i9RKQiJMFEf9Mw8Ms=;
 b=OyLylLpAuWBsK0suaRm6QWQaLZKVDkSjrtLEbePM3OmrfkOPTtEje0rS7gr4+BltTyFgcN
 wtqbnh3jCL5JhkTtm2rVWMJlyMvHiVJJqCjUlfk6hd/tR7Tt0HDuzKw4Ajs/ppuh1TNCTi
 obk2uH0fuKj9tLqAbOwhBcVI0w9543Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-_D9Gc9sUO3mKovURhRSgiQ-1; Thu, 30 Jul 2026 12:14:34 -0400
X-MC-Unique: _D9Gc9sUO3mKovURhRSgiQ-1
X-Mimecast-MFC-AGG-ID: _D9Gc9sUO3mKovURhRSgiQ_1785428073
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15ff68c858so241982466b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785428073; x=1786032873; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vsBn1r8k3tfnNoP7GImjCubK30i9RKQiJMFEf9Mw8Ms=;
 b=pugDgM8froZdiwUVVsVFfs/TLx5wINIUFHtYI/r+2xYf9+XVCHr0dP/d+n6D/TtHnV
 aHLsBFN2QsXXTSGYHp5+Pnb+dAVHTAFnIFwaAI9aXjjPBMCPY8HPoVO9AJHGMNOaWfcf
 1ukrtzOoravubq9m9x7zHdZ9gttPzkJPVigJe7I6DLVSPjXE4/yn2ePDW0BmhTVCSPaG
 BusTv1V2mNmGToYcum8Pjr+ClUe7zEYQ774JGq9dEeNBxI1kqdMBVxzqwTBdugK8mK54
 lzE1ulEI0TAWP9D4M3omBwkY1QiCwBK8on4Vvi/3zSTJKVrsNGRUtY4i5HjEeiAV6OpH
 PRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785428073; x=1786032873;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vsBn1r8k3tfnNoP7GImjCubK30i9RKQiJMFEf9Mw8Ms=;
 b=ZjjjvqWBx6/Wd5AIFIXW49I8b8WUwyfBepvwFy34zdFIaLP9FY0qR/rY60BTHimwb4
 9CAEb6Ziy6X3dnsGczW7UFQLiZbeIb0gsPVBv+cc5fkRmo0I+4c4RTg/2uHtEIWIV9Nr
 9y9dtiiqu0gvSelaQN1b6b+bmnR8eT1ieOv3KZzs6zMt3fEGKQFT6G9nJow/wO5OOUq8
 tCCT84ihPVmjlQwZ2WT7E/Wre0l06sNwmNLFHbto/3yd+arcWOpqcj33r4qG3kK9MW2y
 bk4VWfUXjw92weZ8EO73GSPMhnfb1iBrenHDMJrkRyeAX4h5BTW468OwUzzqKuNOlnVm
 zcnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9i7j8g32+wdAfvu26CWjtW8tHCB/wct5kJ95+f7qfssng3Bc4ymrM5Rehj0rvJ9E1fOabtMSE+ZWX@nongnu.org
X-Gm-Message-State: AOJu0YxUUTomdaHB0veG43OQBHD9hDRlT6wQQ6s2IyqH4oyTvdRSFuXV
 LnrUrFWyzS0QtvZz4HbItbSTeHlRomIIB1CVHjy88sA0FdkYnv00hXjAXZlDKOfULRlaemsW9e1
 vGNoPNhsqvQKLPtv0suagzJvdgc8QnzH756FOSF2Zjl4HA+ouWSFgp8L8
X-Gm-Gg: AR+sD104X+O45f4nr4ykO9Q9KSoBOgthkC4VTN3gQrFqUF5t6+R/geXce89E5WGAO3R
 0wniH71SSEh2Qo+32O0JGVgd4Yifc7nHWPp3OtPR+cL9BRnm6LKG7PKODMGcexN+xpjQDqrfj7B
 IdtxSF0BGX7W1CO0lZNVIph7niWEYwL9p7b97w+On9O36f5ej2n8vnwlyndWDhBDmJWoa/c31Ni
 WxM8XcSEKR++as28zOjgFq42e7eD3B8ajqR4ex2umAPFfE9vxJk8vGY0bq/3PjUPEsGDRhxWntY
 4x4UkUtLWk4e60eZYfynN35Ga/ivh449WVEthNq+17EkAUNU3VwUc3rAhfVg5A9sHkov
X-Received: by 2002:a17:907:1c03:b0:c1c:4e36:eec6 with SMTP id
 a640c23a62f3a-c1fa5591f35mr167825066b.18.1785428073210; 
 Thu, 30 Jul 2026 09:14:33 -0700 (PDT)
X-Received: by 2002:a17:907:1c03:b0:c1c:4e36:eec6 with SMTP id
 a640c23a62f3a-c1fa5591f35mr167822866b.18.1785428072664; 
 Thu, 30 Jul 2026 09:14:32 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8576a3dsm91343066b.14.2026.07.30.09.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:14:31 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:14:26 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amt4Yv8miJ_rFYSS@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de> <amo86cXLNE2uV6Ge@x1.local>
 <20260729145247-mutt-send-email-mst@kernel.org>
 <ampUBV4wAluFGW93@x1.local>
 <20260729180727-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729180727-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Jul 29, 2026 at 06:08:27PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 29, 2026 at 03:27:01PM -0400, Peter Xu wrote:
> > On Wed, Jul 29, 2026 at 02:57:57PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 29, 2026 at 01:48:25PM -0400, Peter Xu wrote:
> > > > So to me, it's much simpler we say migration stream must be
> > > > trusted, and I expect dest QEMU can allocate any buffer it needs, until it
> > > > eats the whole system memory.  I really don't see much real risk..
> > > 
> > > It's not risk due to migration, specifically. But making qemu
> > > drink up terabytes from the guest would be problematic, right?
> > > 
> > > Putting qemu in a cgroup with restricted total memory
> > > would be one way to prevent this class of security issue,
> > > and a robust one.
> > > 
> > > But that, in turn, is impossible if qemu insists on allocating
> > > unlimited memory at the drop of a hat.
> > 
> > Just to clarify at least one thing.. we have two attack surfaces here and
> > they're very different IMHO:
> > 
> > (1) guest behavior caused memory allocation, or,
> > 
> > (2) migration stream caused memory allocation.
> > 
> > AFAIU, (1) is more severe. All my points only apply to (2).
> 
> 
> Absolutely. Yet without fixing 2 we can't mitigate 1 with OS level
> protections.

Nowadays most of issues around migration stream can cause allocations are
about what we have already persisted internally to QEMU to maintain guest
states.

Takeing a GTree as example.

In guest context, one concrete example is GTree can contain unlimited
number of elements for a vIOMMU device to keep the mappings, before
migration we should better make sure the mapping isn't too much to eat all
host memory and get QEMU OOM killed.

In case of migration, it's about when migrating a GTree we will migrate
exactly whatever it is there already on src to dest, then a malicious
stream may cause unlimited allocations.  That's one of the security
reports, we have similar ones for qlist, etc.

IOW, I think yes if we stick with "migration stream trusted" all issues
should be non-issue, and we should not worry about (2) too much, because we
really should majorly need to worry (1).. which is real, since guest is
never trusted..

Meanwhile, migration should still make sure it won't allocate anything else
than what has already been there for source QEMU.  If we need such temp
allocation for migration only, that's the real part where a migration
security issue may reside, but so far none of the reports is about
that... I also can't think of a lot that migration does allocation on its
own for things that can occupy a lot of memory, some might be relevant I
can still think of is bitmaps all over, that's unfortunate, we need them
for various reasons, either on src/dst.. say, kvm also has bitmaps of such,
only allocated during migrations, not easily avoidable.

Another example is QEMU_VM_VMDESCRIPTION that is definitely migration
specific (not part of src QEMU), but dest is already careful there, in
qemu_loadvm_state():

    if (ret == 0 && should_send_vmdesc()) {
        ...
        if (section_type != QEMU_VM_VMDESCRIPTION) {
        ...
        } else {
            buf = g_malloc(0x1000);
            size = qemu_get_be32(f);

            while (size > 0) {
                uint32_t read_chunk = MIN(size, 0x1000);
                qemu_get_buffer(f, buf, read_chunk);
                size -= read_chunk;
            }
            g_free(buf);
        }

I also remember VFIO has some internal buffering only used in migration, I
also remember when I reviewed it I tried to point out the buffer limitation
issue I hope it was properly settled..

I hope we're always careful on those otherwise, but these cases should be
rare.

Thanks,

-- 
Peter Xu


