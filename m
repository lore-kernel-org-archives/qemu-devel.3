Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D60BCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 22:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwpkS-00027i-7T; Thu, 11 Sep 2025 18:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwpkQ-00027X-Qx
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 18:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwpkN-0000nC-5B
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 18:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757629588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eoDrOUHGFo0Fi67Y+LW9HUxbnitFS/g2G9e9+K5xsOk=;
 b=cvqppif8VX27qF9oY59XeLEHRdjnMfDLJJgzV7euA6/SJpVW36R3PJqqGNHo8PxwlzQos0
 dZDAnAyPmsBH0o/l7vf1ZEtcgBKA5lqSyoJgCRkyml9xpXr/RRa1up/wnMfjhOaB/MUpV9
 5jDZZeVvnB1FTfQkAjk9IBRjVByWihY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-qgOYmKP8PlWQVG2UpOFMZg-1; Thu, 11 Sep 2025 18:26:27 -0400
X-MC-Unique: qgOYmKP8PlWQVG2UpOFMZg-1
X-Mimecast-MFC-AGG-ID: qgOYmKP8PlWQVG2UpOFMZg_1757629587
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-76487cdf979so21459306d6.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 15:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757629587; x=1758234387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoDrOUHGFo0Fi67Y+LW9HUxbnitFS/g2G9e9+K5xsOk=;
 b=UI8m6HqQ1Vbm1Jp2ASTt+ScqpDsFzBsV9EEogrqiVt7+7K6fKXwSaSdux9MFvFlUVX
 3vgnbXH30hyg8FW1GUjJ3beXwMb424Ds2HlggzbTm13BgscZBD2yFvhci4UJjQAM9K5R
 IiLELI+ADRmsuKcxsBOw7/vmt0RdCZaDlhElH5Ss4qIsUWs4GOjNxYj9+BmNaJ/inxuP
 /EjQjQGtk+Drv5ViSwIQY59511yXDAas0VUlFTzrTliI9sqB5qFaKcyCT3RNscqN1l2V
 E4sWGhkb4/kyh0mdU8OOnMgk4sCwMqHwfAPYO+o6lA44Ts2fyKYje80J4w66TxtjjeqN
 B5mA==
X-Gm-Message-State: AOJu0Yw6zweJxygKRcmo+hogxbNBNaLpmcsePhkDPAiZsnJdj+zL63uS
 zpqY1h9MsxlknwLEB29nJAJiMXdcOfMaZm1NfohR1lPQcZbFZFYE407zgXIRlrigHyGVbqDV/Et
 n9dzWOSJmtZ7awcW9SEZATetPPk6W3G7fSyBcH/VcGcPnh7WAJERoesOb
X-Gm-Gg: ASbGncuaDoBJZYOr/mA3LRwh7rJUwvb5wncNRjulW7TB/3+TS40UXPO4LuFnFpnkKFL
 VqrpeI0+iSSlLaXjSWAYCjzsofVM19iSX/Xl4qIXWm2OoeQobeTPHtSPEcLvR6hhwZ/zWAPuwbG
 YDPhBvgpZOfqgOnN41zhcyi8PXY1CMkGks7tsJZ32SChCQ2cDW0AqqxcxywNb1PKkRtEA3jyE6C
 nZ/c1NzEvHxX3mOj30VUKJzq8uJWPxu9MeApFUeuRe51NoQgXk017NnK1LxaDKoGxAfzM76RzZA
 f1M9/7nJzAlCqdn5F+Imx6ASNbGMDt2H6UjCLyoh5TOf4QH2whxu8IqSDuRmwncg2+VP8SKwHpo
 aDIb3VcAF6NiEbURyDlhGZA==
X-Received: by 2002:a05:6214:76c:b0:746:e5b3:e10e with SMTP id
 6a1803df08f44-767bcfa4eb9mr13365196d6.21.1757629586282; 
 Thu, 11 Sep 2025 15:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESl/fMpEdfyh2m76X0YlikSbwFl7E9l1S/Y/gx420UkfkhnoNrz9k+e4ttWkk+GD1fRavHBg==
X-Received: by 2002:a05:6214:76c:b0:746:e5b3:e10e with SMTP id
 6a1803df08f44-767bcfa4eb9mr13364476d6.21.1757629585352; 
 Thu, 11 Sep 2025 15:26:25 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bdd37c4fsm17414276d6.40.2025.09.11.15.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 15:26:24 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:26:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aMNMjetBDJfBiThl@x1.local>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 12:40:43PM +0900, Akihiko Odaki wrote:
> On 2025/09/11 6:45, Peter Xu wrote:
> > On Sat, Sep 06, 2025 at 04:39:06AM +0200, Akihiko Odaki wrote:
> > > MemoryRegions used to "piggyback" on their owners instead of using their
> > > own reference counters due to the circular dependencies between
> > > them, which caused new circular references. Stop piggybacking, showing
> > > that the circular dependencies are actually broken at the finalization
> > > time.
> > > 
> > > Circular references caused by piggybacking
> > > ==========================================
> > > 
> > > Piggybacking created another circular reference when an owner referred
> > > to its MemoryRegion via memory_region_ref(). This could happen in three
> > > scenarios:
> > > 
> > > - A subregion and its container had the same owner. In this case, the
> > >    container would use memory_region_ref() to take a reference to the
> > >    subregion.
> > > 
> > > - An AddressSpace and its root MemoryRegion had the same owner. The
> > >    situation is similar to the subregion/container scenario.
> > > 
> > > - An owner called address_space_map() with a guest-controlled address
> > >    that points back to its MemoryRegion. This scenario is similar to what
> > >    MemReentrancyGuard handles.
> > > 
> > > Avoiding such a circular reference required checking if the referrer is
> > > the owner at many places where memory_region_ref() is called,
> > > complicating the code further.
> > 
> > I understand (1).  Why (2)/(3) are causes of circular references?
> 
> I first explain why (1) results in a circular reference, and generalize the
> argument to (2) and (3).
> 
> Semantically, (1) has the following dependencies:
> 
> Owner <-> Subregion
> Owner <-> Container
> Container -> Subregion
> 
> However, the bidirectional dependencies prevents finalization, so
> piggybacking is done. It makes the following reference relationship:
> 
> Owner -> Subregion
> Owner -> Container
> Container -> Owner
> 
> In this case, we still have a circular reference:
> Owner -> Container -> Owner
> 
> This could be generalized: if you replace Subregion with (any kind of)
> MemoryRegion and Container with "X", it will look like follows:
> 
> Owner -> MemoryRegion
> Owner -> X
> X -> Owner
> 
> In case of (2), "X" is an AddressSpace.
> In case of (3), "X" is a mapped address.
> 
> > 
> > > 
> > > Insight
> > > =======
> > > 
> > > This change challenges the underlying assumption that circular
> > > dependencies exist and can be tolerated at the finalization time. The
> > > deletable MemoryRegions are of hotpluggable devices and
> > > virtio-gpu-virgl's hostmem. A device and its MemoryRegion have the
> > > following dependencies:
> > > 
> > > QOM tree -> Device
> > > Container -> MemoryRegion
> > > Device <-> MemoryRegion
> > 
> > Yes, they need to "reference" each other.  That's also why IMHO the current
> > qemu mr refcounting design is still practical, in that it keeps the
> > reference graph to be acyclic, which is much simpler to understand.
> 
> Piggybacking is indeed simpler but has the three possible circular reference
> scenarios I mentioned earlier.
> 
> > 
> > > 
> > > Techniques like piggybacking or a hypothetical garbage collector can
> > > finalize the device and the MemoryRegion once the QOM tree and container
> > > lose their dependencies. However, these methods are fundamentally
> > > insufficient because the MemoryRegion and the device have finalizers,
> > > and they do not respect the dependencies these objects may have during
> > > finalization.
> > > 
> > > As long as the object model based on the device and the MemoryRegion is
> > > correct, one of them should lose its dependency on the first,
> > > establishing a valid finalization order. Understanding this allows using
> > > standard reference counting, which is immune to the problems of
> > > piggybacking.
> > > 
> > > Analysis reveals that the device no longer depends on the MemoryRegion
> > > after being unparented. The device needs the MemoryRegion for the
> > > following two purposes:
> > > - To add the MemoryRegion to a container and expose it to an
> > >    AddressSpace.
> > > - To expose it via the QOM tree.
> > > 
> > > Once unparented, the device is hidden from the AddresSpaces and the
> > > QOM tree so it no longer needs the MemoryRegion and the circular
> > > dependencies are broken. We only need to ensure that the device is
> > > finalized after the MemoryRegion then.
> > > 
> > > It should also be noted that the reference from the MemoryRegion to the
> > > device needs to be tracked only after the device is unparented because
> > > the device will not be finalized as long as it is in the QOM tree.
> > > This fact can be exploited to avoid having a circular reference between
> > > the device and the MemoryRegion before the device gets unparented.
> > > 
> > > Solution
> > > ========
> > > 
> > > When devices get unparented, they also unparent their memory regions.
> > > The unparented memory regions will then retain their references to the
> > > devices. This ensures that:
> > > 
> > > 1. the references from the devices to their memory regions are counted
> > >     until the devices get unparented
> > > 2. the references from their memory regions to the devices afterwards,
> > >     which in turn ensures that devices are finalized after their
> > >     MemoryRegions.
> > > 
> > > When virtio-gpu's hostmems get unparented, they also unparent their
> > > memory regions in the same manner.
> > > 
> > > This enforces a valid finalization order, allows MemoryRegions to rely
> > > on standard reference counting, and eliminates the entire class of
> > > memory leaks caused by piggybacking.
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > >   docs/devel/memory.rst         | 41 +++++++++++++++++-----------------
> > >   include/system/memory.h       | 51 +++++++++++++++++++++----------------------
> > >   hw/core/qdev.c                | 16 ++++++++++++++
> > >   hw/display/virtio-gpu-virgl.c |  1 +
> > >   system/memory.c               | 33 ++++++++++++++++++++--------
> > >   5 files changed, 86 insertions(+), 56 deletions(-)
> > > 
> > > diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> > > index 749f11d8a4dd..9634d8805740 100644
> > > --- a/docs/devel/memory.rst
> > > +++ b/docs/devel/memory.rst
> > > @@ -143,11 +143,7 @@ Region lifecycle
> > >   ----------------
> > >   A region is created by one of the memory_region_init*() functions and
> > > -attached to an object, which acts as its owner or parent.  QEMU ensures
> > > -that the owner object remains alive as long as the region is visible to
> > > -the guest, or as long as the region is in use by a virtual CPU or another
> > > -device.  For example, the owner object will not die between an
> > > -address_space_map operation and the corresponding address_space_unmap.
> > > +attached to an object, which acts as its owner or parent.
> > >   After creation, a region can be added to an address space or a
> > >   container with memory_region_add_subregion(), and removed using
> > > @@ -158,30 +154,34 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
> > >   as soon as the region is made visible.  This can be immediately, later,
> > >   or never.
> > > -Destruction of a memory region happens automatically when the owner
> > > -object dies.
> > > +A region will retain references to its owner object when it is
> > > +unparented. This ensures that the owner object remains alive as long as
> > > +the region is in use by a virtual CPU or another device.  For example,
> > > +the owner object will not die between an address_space_map operation and
> > > +the corresponding address_space_unmap. Devices automatically unparent
> > > +their memory regions when they are unparented.
> > > -You must not destroy a memory region as long as it may be in use by a
> > > -device or CPU.  In order to do this, as a general rule do not create or
> > > -destroy memory regions dynamically during a device's lifetime.
> > > +You must not free a memory region as long as it may be in use by a
> > > +device or CPU.  In order to do this, as a general rule do not allocate
> > > +or free memory regions dynamically during a device's lifetime.
> > >   The dynamically allocated data structure that contains the
> > >   memory region should be freed in the instance_finalize callback.
> > >   If you break this rule, the following situation can happen:
> > > -- the memory region's owner had a reference taken via memory_region_ref
> > > +- the memory region had a reference taken via memory_region_ref
> > >     (for example by address_space_map)
> > > -- the region is unparented, and has no owner anymore
> > > +- the region is freed
> > > -- when address_space_unmap is called, the reference to the memory region's
> > > -  owner is leaked.
> > > +- when the mapped memory is used, the use of the memory region
> > > +  results in use-after-free.
> > > -There is an exception to the above rule: it is okay to call
> > > -object_unparent at any time for an alias or a container region.  It is
> > > -therefore also okay to create or destroy alias and container regions
> > > -dynamically during a device's lifetime.
> > > +There is an exception to the above rule: it is okay to free an alias or
> > > +a container region at any time.  It is therefore also okay to allocate
> > > +or free alias and container regions dynamically during a device's
> > > +lifetime.
> > >   This exceptional usage is valid because aliases and containers only help
> > >   QEMU building the guest's memory map; they are never accessed directly.
> > > @@ -191,9 +191,8 @@ this exception is rarely necessary, and therefore it is discouraged,
> > >   but nevertheless it is used in a few places.
> > >   For regions that "have no owner" (NULL is passed at creation time), the
> > > -machine object is actually used as the owner.  You must never call
> > > -object_unparent on regions that have no owner, unless they are aliases
> > > -or containers.
> > > +machine object is actually used as the owner.  You must never free
> > > +regions that have no owner, unless they are aliases or containers.
> > >   Overlapping regions and priority
> > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > index e2cd6ed12614..1fc773ca49e2 100644
> > > --- a/include/system/memory.h
> > > +++ b/include/system/memory.h
> > > @@ -1307,7 +1307,7 @@ static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
> > >    * memory_region_add_subregion() to add subregions.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: used for debugging; not visible to the user or ABI
> > >    * @size: size of the region; any subregions beyond this size will be clipped
> > >    */
> > > @@ -1320,14 +1320,14 @@ void memory_region_init(MemoryRegion *mr,
> > >    * memory_region_ref: Add 1 to a memory region's reference count
> > >    *
> > >    * Whenever memory regions are accessed outside the BQL, they need to be
> > > - * preserved against hot-unplug.  MemoryRegions actually do not have their
> > > - * own reference count; they piggyback on a QOM object, their "owner".
> > > - * This function adds a reference to the owner.
> > > + * preserved against hot-unplug. This function adds a reference to the
> > > + * memory region.
> > >    *
> > > - * All MemoryRegions must have an owner if they can disappear, even if the
> > > - * device they belong to operates exclusively under the BQL.  This is because
> > > - * the region could be returned at any time by memory_region_find, and this
> > > - * is usually under guest control.
> > > + * We do not ref/unref memory regions without an owner because it slows
> > > + * down DMA sensibly. All MemoryRegions must have an owner if they can
> > > + * disappear, even if the device they belong to operates exclusively
> > > + * under the BQL.  This is because the region could be returned at any
> > > + * time by memory_region_find, and this is usually under guest control.
> > >    *
> > >    * @mr: the #MemoryRegion
> > >    */
> > > @@ -1337,9 +1337,8 @@ void memory_region_ref(MemoryRegion *mr);
> > >    * memory_region_unref: Remove 1 to a memory region's reference count
> > >    *
> > >    * Whenever memory regions are accessed outside the BQL, they need to be
> > > - * preserved against hot-unplug.  MemoryRegions actually do not have their
> > > - * own reference count; they piggyback on a QOM object, their "owner".
> > > - * This function removes a reference to the owner and possibly destroys it.
> > > + * preserved against hot-unplug. This function removes a reference to
> > > + * the memory and possibly destroys it.
> > >    *
> > >    * @mr: the #MemoryRegion
> > >    */
> > > @@ -1352,7 +1351,7 @@ void memory_region_unref(MemoryRegion *mr);
> > >    * if @size is nonzero, subregions will be clipped to @size.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @ops: a structure containing read and write callbacks to be used when
> > >    *       I/O is performed on the region.
> > >    * @opaque: passed to the read and write callbacks of the @ops structure.
> > > @@ -1372,7 +1371,7 @@ void memory_region_init_io(MemoryRegion *mr,
> > >    *                                    directly.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1395,7 +1394,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> > >    *                                          modify memory directly.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1425,7 +1424,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> > >    *                                     canceled.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: used size of the region.
> > > @@ -1454,7 +1453,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
> > >    *                                    mmap-ed backend.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1487,7 +1486,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
> > >    *                                  mmap-ed backend.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: the name of the region.
> > >    * @size: size of the region.
> > >    * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
> > > @@ -1518,7 +1517,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
> > >    *                              region will modify memory directly.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1546,7 +1545,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
> > >    * skip_dump flag.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: the name of the region.
> > >    * @size: size of the region.
> > >    * @ptr: memory to be mapped; must contain at least @size bytes.
> > > @@ -1566,7 +1565,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > >    *                           part of another memory region.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: used for debugging; not visible to the user or ABI
> > >    * @orig: the region to be referenced; @mr will be equivalent to
> > >    *        @orig between @offset and @offset + @size - 1.
> > > @@ -1592,7 +1591,7 @@ void memory_region_init_alias(MemoryRegion *mr,
> > >    * of the caller.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1615,7 +1614,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
> > >    * of the caller.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @ops: callbacks for write access handling (must not be NULL).
> > >    * @opaque: passed to the read and write callbacks of the @ops structure.
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > > @@ -1651,7 +1650,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
> > >    * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
> > >    * @instance_size: the IOMMUMemoryRegion subclass instance size
> > >    * @mrtypename: the type name of the #IOMMUMemoryRegion
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: used for debugging; not visible to the user or ABI
> > >    * @size: size of the region.
> > >    */
> > > @@ -1667,7 +1666,7 @@ void memory_region_init_iommu(void *_iommu_mr,
> > >    *                          region will modify memory directly.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized
> > > - * @owner: the object that tracks the region's reference count (must be
> > > + * @owner: the object that provides the region's storage (must be
> > >    *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
> > >    * @name: name of the memory region
> > >    * @size: size of the region in bytes
> > > @@ -1713,7 +1712,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
> > >    * If you pass a non-NULL non-device @owner then we will assert.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > >    *        must be unique within any device
> > >    * @size: size of the region.
> > > @@ -1744,7 +1743,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
> > >    * If you pass a non-NULL non-device @owner then we will assert.
> > >    *
> > >    * @mr: the #MemoryRegion to be initialized.
> > > - * @owner: the object that tracks the region's reference count
> > > + * @owner: the object that provides the region's storage
> > >    * @ops: callbacks for write access handling (must not be NULL).
> > >    * @opaque: passed to the read and write callbacks of the @ops structure.
> > >    * @name: Region name, becomes part of RAMBlock name used in migration stream
> > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > index 8fdf6774f87e..b83c46615fba 100644
> > > --- a/hw/core/qdev.c
> > > +++ b/hw/core/qdev.c
> > > @@ -718,8 +718,18 @@ static void device_class_base_init(ObjectClass *class, const void *data)
> > >       klass->props_count_ = 0;
> > >   }
> > > +static int collect_memory_region(Object *child, void *opaque)
> > > +{
> > > +    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
> > > +        g_array_append_val(opaque, child);
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >   static void device_unparent(Object *obj)
> > >   {
> > > +    g_autoptr(GArray) array = g_array_new(FALSE, FALSE, sizeof(Object *));
> > >       DeviceState *dev = DEVICE(obj);
> > >       BusState *bus;
> > > @@ -735,6 +745,12 @@ static void device_unparent(Object *obj)
> > >           object_unref(OBJECT(dev->parent_bus));
> > >           dev->parent_bus = NULL;
> > >       }
> > > +
> > > +    object_child_foreach(OBJECT(dev), collect_memory_region, array);
> > > +
> > > +    for (gsize i = 0; i < array->len; i++) {
> > > +        object_unparent(g_array_index(array, Object *, i));
> > > +    }
> > 
> > What if the owner is not a device?
> > 
> > If we have a more self contained solution [1], which do not care about the
> > type of the owner object, why bother?
> > 
> > What is the benefit of your proposal here, comparing to [1]?
> 
> [1] only handles (1) but this covers the entire class of memory leaks,
> including (2) and (3).

Can you provide some example memory leaks that can reproduce on current
master branch with (2) and (3)?  How severe are they?

I plan to merge the one-patch fix first on circular ref.  This issue has
been dangling for too long, and I highly doubt anyone would even start to
like patch 1 of your this series on "finalizing" stage.

I don't see why we need to be blocked forever on this, keeping PeterM and
others poking the known issues.  It'll be great if you can work whatever on
top of that, and justifying whatever you propose is better is also easier.

Is that OK for you?

> 
> > 
> > >   }
> > >   static char *
> > > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> > > index f5cba8a7fa66..7afcaa4bfe2e 100644
> > > --- a/hw/display/virtio-gpu-virgl.c
> > > +++ b/hw/display/virtio-gpu-virgl.c
> > > @@ -203,6 +203,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> > >           /* memory region owns self res->mr object and frees it by itself */
> > >           memory_region_set_enabled(mr, false);
> > >           memory_region_del_subregion(&b->hostmem, mr);
> > > +        object_unparent(OBJECT(mr));
> > 
> > It's definitely not obvious why a memory core change will involve a GPU
> > change too.
> > 
> > >           object_unparent(OBJECT(vmr));
> > >       }
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 56465479406f..edaf039b0647 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1212,11 +1212,19 @@ static char *memory_region_escape_name(const char *name)
> > >       return escaped;
> > >   }
> > > +static void memory_region_free(void *obj)
> > > +{
> > > +    MemoryRegion *mr = obj;
> > > +
> > > +    object_unref(mr->owner);
> > > +}
> > > +
> > >   static void memory_region_do_init(MemoryRegion *mr,
> > >                                     Object *owner,
> > >                                     const char *name,
> > >                                     uint64_t size)
> > >   {
> > > +    OBJECT(mr)->free = memory_region_free;
> > 
> > I think this is wrong.  This should break object_new(TYPE_MEMORY_REGION)
> > users.
> 
> This function will never be called with an object created with
> object_new(TYPE_MEMORY_REGION). It is called by memory_region_init() and
> memory_region_init_iommu() and they call object_initialize(). If an object
> created with object_new(TYPE_MEMORY_REGION) is passed to them, it will
> result in double object initialization, which doesn't make sense.

I actually didn't notice we don't have much users.  I think it'll block new
users, then, by making free() not usable anymore.  Not to mention it's also
definitely an abuse to reuse a free() for other things.

It can be relevant to the other email discussion too:

https://lore.kernel.org/all/aMHidDl1tdx-2G4e@x1.local/

I feel like object_new(TYPE_MEMORY_REGION) can be a good thing to simplify
allocated MRs whose lifecycle still is the same as the device for the long
term.

Some memory APIs will need touch up, but it shouldn't be much, basically we
want to skip object_initialize() for all memory_region_init_*() APIs on top
of object_new(TYPE_MEMORY_REGION) MRs.

I'm also not eager to change anything yet, because these MRs are minority,
and I don't immediately have a problem to solve myself here.  So I would
like to know what exactly problem you're hitting with (2)/(3) above.

Thanks,

-- 
Peter Xu


