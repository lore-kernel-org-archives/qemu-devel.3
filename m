Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE028CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKzM-00005f-0S; Wed, 10 Jun 2026 11:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXKzK-00005R-MO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXKzI-0002eM-L5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781105823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEZDTqsn8krWhkTZt+TENJLHy87QaCq53mNIE3fmL98=;
 b=Op3N/QvAPuWLZesahVQze5jyLw4UdniSk6dq/aE3FFzcAK8DxWMDS5g9CuKV75DCXrWYAk
 KTYGtEOpGtemnW0axENEfNnXxo3tkiBYOHT0NtUKWfdN+JMU6aTIw6qLJ2ggAuqnK63EJF
 S3//U3EvlmDO6ucWUmZqQ5bEJGkh4tc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-pdC0Tc4mMvKrq0weWJk1mw-1; Wed, 10 Jun 2026 11:37:00 -0400
X-MC-Unique: pdC0Tc4mMvKrq0weWJk1mw-1
X-Mimecast-MFC-AGG-ID: pdC0Tc4mMvKrq0weWJk1mw_1781105820
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cce1cc8cb2so15621796d6.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781105820; x=1781710620; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uEZDTqsn8krWhkTZt+TENJLHy87QaCq53mNIE3fmL98=;
 b=PPlucNxtGo4S6KsZP5ZEd6KYlhRHN9E2wp6TrpriX/fczbdrqIdJEKL5jIM2QCabXp
 v1n9tJI+/nAyCd3bKwUjigRGiohiqJYyHrnLGh2MYnJKRo6UHYUradMM7dz5SABNmDlg
 Nvdxc166taZFQ+BLzShiqOPTXghoBFsEgBGYvTsjeC9xtXNF4tNZpx9Hj4vhf6HKL+v6
 rx3pXKrJn5RJTHlz3IHmBl42hz4E5HDKHR+0PfUxuAQzHSxO+tRTb8GGjTYQguvSxmjS
 XiZrCQbRaErlNCFEEpIWuOXt6ag/9xHqdCN1n2fPR7p2y77OaKMICERLFdXL3jtV6xeC
 mmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781105820; x=1781710620;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEZDTqsn8krWhkTZt+TENJLHy87QaCq53mNIE3fmL98=;
 b=d6B9V16IPH9E28uIZJpu1K4FZuP9NY1BU/YmTi3losBApPJO1pW2AoHL4goMARaLYw
 QEqAF4kLZ1Z7dGnDRxSZQSJciQ7tG98i+axic4ZzFcX9BmYuQxT08c4/6VRxMFAk3i/M
 xBkGDJxMUyGc4rN97XgjjbycfcmIgUx05vQkICK0DGKGUOMpngvbtcyeUAFOvXpIn/1/
 VZISP1yl1g3Yk5SMGS/bugXjcK13xGqaVf1xeZq8qVELTMwZ8jgcy91iEGDaKWbT5Gms
 tijMPJjQdlXeTUJ6zEq4KfN+Bu7T3aZTJAxRjcFMZlv+n2xg0AGLonAQ9kmzBRUgFUyz
 nzFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/r59T8MKkHyywEIqPEMoXBeiKtXzvfA2gybnfaO+PLMjdW3ifVX63nDV81s8gI4QtNlJqqsfE9apq0@nongnu.org
X-Gm-Message-State: AOJu0Yw5vJtC9RpFa/Y2Kk1UF7rG4bQzmBQQnFY6I+eBDCeCskeZkyEf
 9VfnWduRH6J4xkXINkkCYq3qxO9hhNtu/fNM+Ra6ZxJDA1Qu4CwhHMW0oRb+kkENa8QJ5GEHajS
 kjeiPNgkEdoHjs5k2aQRQQCgjzj0en+FIrTMc3MMQSbfoeqOHjFqUunCa
X-Gm-Gg: Acq92OGAJ60FLM02XEIyISJrrtEQ7ioYkWmxMKQRtZgZW08w8xFIUYrGbReyQOLveld
 wqS1949jMlTUkEDm92T03m+GsblpEFHzOa6g6Rfyi57aOr7VeOSLmOekWRvHB9vXhS4mFVoiVhx
 Yv3oiG0onjfuDOQL2gmHC6w51vTjnPH7xmFIEcspuxJ2KfN+fef6lMhb4m81VJx9/TEmmcpqAO3
 jB6QDAb6tP2+npib3dTeimuaTl3aftf5jZ/Nn+VM0a9mP1LJ1CsdjH6eo7MvnXxqUCKn4NwTEnw
 Or0ajtpabTU2KlU5qx5gSCt6wnIb8aycYXtjjrVJiqFeK2LDWfQ/1q1j4yMwVJK52yJfuKpiwxS
 u6ItsgeFf9hHV0tCj2mDlDx1S/w==
X-Received: by 2002:a05:622a:1e14:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-517ca609a24mr114591981cf.48.1781105819515; 
 Wed, 10 Jun 2026 08:36:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1e14:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-517ca609a24mr114591191cf.48.1781105818760; 
 Wed, 10 Jun 2026 08:36:58 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775d8161csm220992421cf.17.2026.06.10.08.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:36:57 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:36:55 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aimEl9QQ_LTRPLtd@x1.local>
References: <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610095712-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:
> > Hi Michael and Peter,
> > 
> > On 6/10/26 11:00 PM, Gavin Shan wrote:
> > > On 6/10/26 10:27 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
> > > > > On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> > > > > > > On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > > 
> > > > > > > > You did not answer the question that Daniel was asking, how will user
> > > > > > > > know that max-bounce-buffer-size should be used if it's necessary to fix
> > > > > > > > guest system hangs and how will user know what magic value should be set?
> > > > > > > > 
> > > > > > > 
> > > > > > > Sorry that I missed to answer Daniel's questions. For this specific case,
> > > > > > > user need to enlarge the bounce buffer size when seeing the following error
> > > > > > > message. We can add an explicit one in address_space_map() if the existing
> > > > > > > error message isn't obvious.
> > > > > > > 
> > > > > > >     qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > > > > > 
> > > > > > >     void *address_space_map(AddressSpace *as,
> > > > > > >                           hwaddr addr,
> > > > > > >                           hwaddr *plen,
> > > > > > >                           bool is_write,
> > > > > > >                           MemTxAttrs attrs)
> > > > > > >     {
> > > > > > >         if (!memory_access_is_direct(mr, is_write, attrs)) {
> > > > > > >             if (l == 0) {
> > > > > > >                 error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
> > > > > > >                 *plen = 0;
> > > > > > >                 return NULL;
> > > > > > >             }
> > > > > > >         }
> > > > > > > 
> > > > > > > As to the value user should take for max-bounce-buffer-size, it is really case by case
> > > > > > > and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> > > > > > > smallest value works for them. The worst case is to set 0xFFFFFFFF.
> > > > > > > 
> > > > > > 
> > > > > > 
> > > > > > This is not at all reasonable. All kind of fixes are possible but
> > > > > > fundamentally, bounce buffering data path is by itself already a
> > > > > > bad idea.
> > > > > > 
> > > > > > I have no idea what does bounce buffering device ram accomplish.
> > > > > > 
> > > > > > In the end, qemu still simply reads the memory from/to the buffer.
> > > > > > 
> > > > > > My suggestion is to first of all look for ways to mark the
> > > > > > memory as direct.
> > > > > > 
> > > > > 
> > > > > As I explained to Peter Xu in another reply, we can't simply mark the (RAM
> > > > > DEVICE) memory region is directly accessible. The memory region is initialized
> > > > > by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
> > > > > 
> > > > > The  accesses to the memory region is handled by 'ram_device_mem_ops' where
> > > > > {ldn, stn}_he_p() are used in its read/write handler. They're different
> > > > > from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
> > > > > 
> > > > > Thanks,
> > > > > Gavin
> > > > > 
> > > > 
> > > > What is endianness set to, for this region?
> > > > 
> > > 
> > > The endianness of the memory region is set to that for the host.
> > > 
> > > static const MemoryRegionOps ram_device_mem_ops = {
> > >      .read = memory_region_ram_device_read,
> > >      .write = memory_region_ram_device_write,
> > >      .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
> > > };
> > > 
> 
> So there is never any endianness translation.
> I think the reason qemu does the bounce buffer is more
> to prevent things like vector access from MMIO.
> 
> 
> > How about to treat the RAM DEVICE memory region directly accessible in
> > address_space_map() only when HOST_BIG_ENDIAN is false,
> > something like
> > below and I don't hit the guest hang issue with the changes.
> > 
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index 1417132f6d..9daca55251 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -2908,7 +2908,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
> >  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
> >  bool prepare_mmio_access(MemoryRegion *mr);
> > -static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
> > +static inline bool memory_region_supports_direct_access(const MemoryRegion *mr,
> > +                                                        bool check_ram_device)
> >  {
> >      /* ROM DEVICE regions only allow direct access if in ROMD mode. */
> >      if (memory_region_is_romd(mr)) {
> > @@ -2922,13 +2923,14 @@ static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
> >       * be MMIO and access using mempy can be wrong (e.g., using instructions not
> >       * intended for MMIO access). So we treat this as IO.
> >       */
> > -    return !memory_region_is_ram_device(mr);
> > +    return (!check_ram_device || !memory_region_is_ram_device(mr));
> >  }
> >  static inline bool memory_access_is_direct(const MemoryRegion *mr,
> > +                                           bool check_ram_device,
> >                                             bool is_write, MemTxAttrs attrs)
> >  {
> > -    if (!memory_region_supports_direct_access(mr)) {
> > +    if (!memory_region_supports_direct_access(mr, check_ram_device)) {
> >          return false;
> >      }
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 7bcbf87573..2e6b72b124 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3724,7 +3724,7 @@ void *address_space_map(AddressSpace *as,
> >      fv = address_space_to_flatview(as);
> >      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> > -    if (!memory_access_is_direct(mr, is_write, attrs)) {
> > +    if (!memory_access_is_direct(mr, HOST_BIG_ENDIAN, is_write, attrs)) {
> >          size_t used = qatomic_read(&as->bounce_buffer_size);
> >          for (;;) {
> >              hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
> > 
> > Thanks,
> > Gavin
> > 
> 
> I do not think it has anything to do with host endian-ness.
> 
> 
> This is the change that broke it I think?
> 
> 
> commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> Author: Alex Williamson <alex@shazbot.org>
> Date:   Mon Oct 31 09:53:03 2016 -0600
> 
>     memory: Don't use memcpy for ram_device regions
>     
> 
> Maybe Alex has an opinion on what to do.

I can offer one idea here..

IIUC the major issue was vector ops but the mr ops might be too heavy, then
another way to fix it is in memory API instead of using memcpy()/memmove(),
we always use a helper (say, memmove_no_vector()) to do the split and
properly aligned IOs as what ram_device_mem_ops does right now, this should
only applies to ram_device.

With that, IIUC we can remove the current ram_device_mem_ops, then in
Gavin's case mmap() will go through and guest will not need to vmexit at
all.  Best perf, issue solve.

We just need to be careful to trap all possible memcpy()/memmove() used in
memory core.. if I didn't miss any, IMO below four should needs to be
replaced by memmove_no_vector():

  flatview_write_continue_step()
  flatview_read_continue_step()
  address_space_read()
  address_space_write_rom()

Thanks,

-- 
Peter Xu


