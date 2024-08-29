Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80886C87FD6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 19:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjl8k-0002Ra-El; Thu, 29 Aug 2024 15:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjl8i-0002PJ-Sd
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 15:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjl8g-0002n1-3W
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 15:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724960939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eD4HWle08dISZy1W0qDmAj9od3TJyWuTZzbAeIFW6WY=;
 b=ZyqFVa/dpJIfxsUhZ6uxTFT5t/oq9mjtNaLe5QjbnuyylpLFYUpsCeiIESO776txm1mFx7
 T10E11BffZqrO1xKdLFRS8IovMKyorKOI5XtCN6Yx5Oxbdy4jw/MtT87eIe3eNz7xCUGPn
 uIl3VO9e0KWbDRz0rfPDnn7lEda0e+M=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Vl8M1uryOrykXZdIf3cpGg-1; Thu, 29 Aug 2024 15:48:58 -0400
X-MC-Unique: Vl8M1uryOrykXZdIf3cpGg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2701a253946so1316106fac.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 12:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724960937; x=1725565737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eD4HWle08dISZy1W0qDmAj9od3TJyWuTZzbAeIFW6WY=;
 b=nNoe6EKQE/14VaWMoZc99SX2e+EDgM83gWpeRDRJshrpRt5ghBITJHxB3WAdmje6pz
 CPMzuVym/jSB+9lz/638oYtavaz3xUa+uSLEGRGxwVElfxAqt2ndY6ZRoHZcYzKCrjHi
 nbEMBM47y49oZKtQAy1kBcEsE7RM9K+PdXeokJqYBDILK6amxWB6H6aY91BfR5mD4LUf
 Fz6kg18yJ9mSAoLwEU301Drkd0VJSqkyJTbGcTOX7LpgbQ8UxbWKa/FMcC7Rm8hL+/2T
 zZc0l73QztIfFFt7Lkm0p4lNPpuEfcWFH8M/YdRJ67hNwwYf5f08FeOF758Wb0C6NMGq
 cyqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmBQoBBt8WeJalfIE6MVMPxWrSj8XUpsn0C4hSeDo6PKgJ1zdfccgqDZlcY2Ya0OEWWGM2CoqNGBCF@nongnu.org
X-Gm-Message-State: AOJu0Yx06dtC1PC75UOvMTVFE0YLLsNgKrDk6pRtMRbhz9fNYiYyv7wa
 rNMkVeqS3/IKjbtJVjY4y5hSkcoAwiyQx/ene2PJapBtEC0BbJZaJwXE+VrgLiRLEx4rT+afLsK
 5tQUrLHcbpTUvD6qx7AtB8Ya1HRudfg6ip4mkvI16sKrFCmInCsy1
X-Received: by 2002:a05:6871:ca1d:b0:270:735:96e with SMTP id
 586e51a60fabf-277900c612cmr3822912fac.12.1724960937419; 
 Thu, 29 Aug 2024 12:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyRR9dBs9dXN+JvUVEHmPOrUKrMZVdobN7TWpPt0xRDmgAsO1oZAtpU/4OjYS+sIUGyoYs6g==
X-Received: by 2002:a05:6871:ca1d:b0:270:735:96e with SMTP id
 586e51a60fabf-277900c612cmr3822870fac.12.1724960936886; 
 Thu, 29 Aug 2024 12:48:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-277abb3f16csm62510fac.13.2024.08.29.12.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 12:48:56 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:48:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
Message-ID: <ZtDQoqWNBoe9Zxt6@x1n>
References: <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n>
 <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
 <Zs36od036pyxvQlZ@x1n>
 <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
 <Zs8hcLPU62Hj8x-W@x1n>
 <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com>
 <Zs9IxoRdu6CcZRrx@x1n>
 <9bbdbee7-ef13-42b9-9594-fba1d0a634e4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bbdbee7-ef13-42b9-9594-fba1d0a634e4@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 29, 2024 at 01:39:36PM +0900, Akihiko Odaki wrote:
> > > I am calling the fact that embedded memory regions are accessible in
> > > instance_finalize() "live". A device can perform operations on its memory
> > > regions during instance_finalize() and we should be aware of that.
> > 
> > This part is true.  I suppose we should still suggest device finalize() to
> > properly detach MRs, and that should normally be done there.
> 
> It is better to avoid manual resource deallocation in general because it is
> too error-prone.

I had an impression that you mixed up "finalize()" and "free()" in the
context of our discussion.. let us clarify this first before everything
else below, just in case I overlook stuff..

MR is very special as an object, in that it should have no free() hook,
hence by default nothing is going to be freed when mr->refcount==0.  It
means MRs need to be freed manually always.

For example:

(gdb) p system_memory->parent_obj->free
$2 = (ObjectFree *) 0x0

It plays perfect because the majority of QEMU device model is using MR as a
field (rather than a pointer) of another structure, so that's exactly what
we're looking for: we don't want to free() the MR as it's allocated
together with the owner device.  That'll be released when the owner free().

When dynamic allocation gets into the picture for MR, it's more complicated
for sure, because it means the user (like VFIOQuirk) will need to manually
allocate the MRs, then it requires explicit object_unparent() to detach
that from the device / owner when finalize().  NOTE!  object_unparent()
will NOT free the MR yet so far.  The MR still need to be manually freed
with an explicit g_free(), normally.  Again, I'd suggest you refer to the
VFIOQuirk code just as an example.  In that case this part is done with
e.g. vfio_bar_quirk_finalize().

        for (i = 0; i < quirk->nr_mem; i++) {
            object_unparent(OBJECT(&quirk->mem[i]));
        }
        g_free(quirk->mem);

Here quirk->mem is a pointer to an array of MR which can contain one or
more MRs, but the idea is the same.

> 
> I have an impression with QEMU code base that it is failing manual resource
> deallocation so frequently although such deallocation can be easily
> automated by binding resources to objects and free them when objects die by
> providing a function like Linux's devm_kmalloc(). Unfortunately I haven't
> found time to do that though.

AFAICT, the property list is exactly what you're saying.  IIUC normally an
object will be properly finalized()ed + free()ed when the parent object is
finalize()ed.  Here MR is just special as it bypasses all the free() part.

> 
> So my opinion here is 1) we should automate resource deallocation as much as
> possible but 2) we shouldn't disturb code that performs manual resource
> management.

Agree.  However note again that in whatever case cross-device MR links will
still require explicit detachment or it's prone to memory leak.

> 
> instance_finalize() is for manual resource management. It is better to have
> less code in instance_finalize() and fortunately MemoryRegion don't require
> any code in instance_finalize() in most cases. If instance_finalize() still
> insists to call object_unparent(), we shouldn't prevent that. (I changed my
> mind regarding this particular case of object_unparent() however as I
> describe below.)
> 
> > 
> > > 
> > > object_unparent() is such an example. instance_finalize() of a device can
> > > call object_unparent() for a subregion and for its container. If we
> > > automatically finalize the container when calling object_unparent() for the
> > > subregion, calling object_unparent() for its container will result in the
> > > second finalization, which is not good.
> > 
> > IMHO we don't finalize the container at all - what I suggested was we call
> > del_subregion() for the case where container != NULL.  Since in this case
> > both container & mr belong to the same owner, it shouldn't change any
> > refcount, but only remove the link.
> > 
> > However I think I see what you pointed out.  I wonder why we remove all
> > properties now before reaching instance_finalze(): shouldn't finalize() be
> > allowed to access some of the properties?
> > 
> > It goes back to this commit:
> > 
> > commit 76a6e1cc7cc3ad022e7159b37b291b75bc4615bf
> > Author: Paolo Bonzini <pbonzini@redhat.com>
> > Date:   Wed Jun 11 11:58:30 2014 +0200
> > 
> >      qom: object: delete properties before calling instance_finalize
> >      This ensures that the children's unparent callback will still
> >      have a usable parent.
> >      Reviewed-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> >      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> >  From this series (as the 1st patch there):
> > 
> > https://lore.kernel.org/qemu-devel/1406716032-21795-1-git-send-email-pbonzini@redhat.com/
> > 
> > I can't say I fully understand the commit yet so far.. because it seems
> > this patch was trying to pave way so that MR's unparent() can have a usable
> > parent.  However... I don't think mr implemented unparent() at all..
> > while it just sounds more reasonable that properties shouldn't be
> > auto-removed before calling instance_finalize() from my gut feeling.
> > 
> > I tried to revert 76a6e1cc7c ("qom: object: delete properties before
> > calling instance_finalize"), "make check" all passes here.  I am a bit
> > confused on where it applies, and whether we should revert it.
> > 
> > If with 76a6e1cc7cc reverted, I think your concern should go away because
> > then properties (including MRs) will only be detached after owner's
> > instance_finalize().  Again, I wished Paolo could chime in as he should
> > know the best.
> 
> I didn't know QOM deletes properties before instance_finalize().
> 
> I think it is a bad idea to delete properties before instance_finalize().
> The intention is that to keep a usable parent during unparenting, but it is
> inevitable that an object is in a semi-finalized state during finalization.
> If the order of finalization matters, it should be explicitly described in
> instance_finalize(). Deleting properties before instance_finalize() prevents
> that.
> 
> That said, I think it is too late to revert that change. "make check" works
> as a preliminary check, but ultimately we need manual tree-wide review,
> which is too costly.

I don't think it's too late. :)

IMHO if that statement is true, then QEMU will gradually become not
maintainable anymore with tons of such code nobody understands and nobody
can touch.  To me it can destine its death soon afterwards if so, sooner or
later.

OTOH, it'll be harder to justify or change indeed if some piece of code
stays longer in-tree.  So I agree with you even if we want to change
anything around this we should be with extreme cautions, and I don't think
we should merge anything like this too late of a release, just to give it
time to expose and break things.

> 
> Going back to the original topic, I had the (incorrect) assumption that QOM
> deletes properties *after* instance_finalize(). Under such an assumption, it

Let's stick with this model; so far I still think this is the right thing
to do, and I'm happy to know that you seem to at least agree (irrelevant of
whether we should move on with a change).

> would be unsafe to remove a subregion from its container when a subregion is
> gone. As you said, we don't have to object_unparent(mr->container) and

IMHO we need to do this. Please recheck this after reading above on
finalize() v.s. free().  Here object_unparent() is needed because the MR is
allocated by the owner, it means only the owner knows how to free() it
(again: MR's own free()==NULL).  Then if we want to free it properly, we
need to detach it from the owner object first, hence object_unparent().

> instead we can just call memory_region_del_subregion() instead to keep
> object_unparent() functional. However, strictly speaking,

I think we can do that, or we don't.  It's the same as whether we want to
explicitly detach links for an embeded MR: if it's not explicitly done, we
can rely on the finalize() of the MR to do so.

In all cases, object_unparent() will still be needed because it will do
more things than memory_region_del_subregion(): it removes the property
link itself.

This is also one reason why I keep thinking what I suggested might be good:
it covers not only mr->subregions and also mr->container, it means the
detachment has no ordering constraints on which mr is finalize()ed first
(in this case, either the container mr or the child mr).

> memory_region_del_subregion() is also a side effect and may affect
> operations with the container later. Such a side effect is better to be
> avoided whenever possible.
> 
> My point in this discussion is that the device has a control of its memory
> region even during finalization. We shouldn't call object_unparent(),
> memory_region_del_subregion(), or perform whatever operation on another
> memory region; otherwise the device may see an unexpected side effect.
> 
> Now, let's consider the correct assumption that QOM deletes properties
> *before* instance_finalize(). Under this assumption, the statement in
> docs/devel/memory.rst saying that calling object_unparent() in
> instance_finalize() is fine is wrong because the memory region is already
> finalized and we shouldn't call object_unparent() for a finalized object.
> 
> This also means a device does not have a control of its memory regions
> during finalization and the device will not see the side effect of calling
> memory_region_del_subregion(). However, if a device really needs to control
> the order of memory region finalization, it can still call object_ref() for
> memory regions to keep them alive until instance_finalize(). The effect of
> memory_region_del_subregion() will be  visible to the device if a device
> does such a trick. While it is very unlikely that any device does such a
> trick, it is still better to avoid having any assumption on devices.
> 
> With the proposed object_ref(mr->owner == subregion->owner ?
> OBJECT(subregion) : subregion->owner) call, we don't have to make any
> assumption on how finalization works, which is too complicated as this
> discussion shows. It certainly makes the use of two reference counters, but
> it does not deviate from the current policy on their usage and it is also
> trivial to adapt when the reference counter in memory region gets removed.
> Considering all above, I believe my patch is the most straightforward
> solution.

Let's see how you thinks after you read above first.  I hope we can get
more onto the same page at least on the context.

So far I still prefer using mr->refcount as less as possible.  Now it plays
the only role as "whether this MR is put onto an owner property list", and
for all the rest refcounts on MR it should always routes to the owner.  I
still think we need to be extremely cautious on further complicating this
refcount.  It's already complicated indeed, but hopefully this model is the
best we can trivially have right now, and so far it's clear to me, but it's
always possible I overlooked something.

Thanks,

-- 
Peter Xu


