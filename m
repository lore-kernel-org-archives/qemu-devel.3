Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC601C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfaT2-00013k-Fn; Wed, 05 Feb 2025 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfaSt-000126-Rq; Wed, 05 Feb 2025 03:08:58 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfaSr-0001E9-I6; Wed, 05 Feb 2025 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738742934; x=1770278934;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Yb1GwAcOa0aO1yeLYu4Yq+LWNnT1bGHQr+oZVW53MYc=;
 b=LDwMwv033+RUAlTkQTHJF5ST2/mxJGegg5w/a4NH0pg+iE2YS88t+q+e
 K11z1D09byA/KV/tZig44Ipvwcqw0WBr5JjEYObi/amQAETr7kDF4refI
 3Pzvx8fKJu2XRwLwWPZdjNhJu/x5JsWPSOvekE4WlaT4QtyU93FKE0QBB
 ZeoMK2H0SfJWR9LCXpblR80iFMDAfmGZdtjMow8kRy8yKX2Gt6hYLB81m
 szu59IDqUP/Tnjky9dZeZ3g94TRJlUseZy1eokNVqP+Sq4G6L4f0lFdcB
 lMsiVXGSbLCk0V/FnE/NuRbiQlHOiyW8YMQMSIFCfVMF/tOQNQYDyKINW Q==;
X-CSE-ConnectionGUID: 1L7kc7atS7Wpa4NTULgV6g==
X-CSE-MsgGUID: e7zjKvnsTjOWy3CiMvAP1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39453697"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; d="scan'208";a="39453697"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 00:08:48 -0800
X-CSE-ConnectionGUID: rUnbGF3FQSKH6IK5Zl6p9w==
X-CSE-MsgGUID: HnYJ6bSwQKSiTIElndhnsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141720847"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 00:08:46 -0800
Date: Wed, 5 Feb 2025 16:28:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z6MhH0bLVRw8O/8c@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
 <Z5ZRnYDZdZcgyCsR@intel.com>
 <CABgObfZ1659K9TrAAa3HYfhr0vf31eveoN-=33rSmpJnLo1RKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZ1659K9TrAAa3HYfhr0vf31eveoN-=33rSmpJnLo1RKg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 29, 2025 at 11:03:31AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:03:31 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
> 
> On Sun, Jan 26, 2025 at 3:56 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Hi Paolo,
> >
> > On Fri, Jan 17, 2025 at 08:39:55PM +0100, Paolo Bonzini wrote:
> > > Date: Fri, 17 Jan 2025 20:39:55 +0100
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > Subject: [PATCH 02/10] rust: qom: add reference counting functionality
> > > X-Mailer: git-send-email 2.47.1
> > >
> > > Add a smart pointer that allows to add and remove references from
> > > QOM objects.  It's important to note that while all QOM objects have a
> > > reference count, in practice not all of them have their lifetime guarded
> > > by it.
> >
> > About the background, I have a maybe common question...why Rust needs
> > extra reference count guarding?
> 
> Children properties are removed, and thus their reference is dropped,
> before instance_finalize() is called (see object_finalize() in
> qom/object.c). This is not valid in Rust, you need to keep the object
> alive until the last line of Rust code has run - which is after
> Drop::drop() has run.

I see, this is also a typical effort to eliminate unsafe crossing of FFI
boundaries.

> > Additionally, I felt that the ref count may be a bit confusing. After
> > creating Child<> property, the child object's ref count is sometimes 1,
> > and other times it's 2:
> >
> >  * With object_initialize_child(), child's ref count is 1.
> >
> >  * With object_property_add_child() (usually after a object_new() to
> >    create child first):
> >
> >    - sometimes user will call object_unref(), and then the ref count is 1.
> >      E.g., x86_cpu_apic_create() in target/i386/cpu-apic.c.
> >
> >    - sometimes no object_unref(), then ref count is 2.
> >      E.g., exynos4210_realize() in hw/arm/exynos4210.c, creats "cortex-a9".
> 
> In C, having a ref count of 2 is usually a latent memory leak (because
> most of the time there's not going to be an object_unref() in the
> instance_finalize() method). In this case the leak is latent, because
> TYPE_EXYNOS4210_SOC is not hot-unpluggable and thus will never really
> go away once realized.

Further, what about doing object_unref() in object_property_add_child()
or object_property_try_add_child()?

Then we can ensure the object will have ref count of 1 on the exit of
object_property_add_child() and people will no longer miss
object_unref().

Although, there are a few more devices involved to fix similar issues.

> In Rust, this class of leaks simply does not exist with the right API.
> ObjectMethods::property_add_child() could either:
> 
> - take an Owned<T> and consume it, thus always giving a ref count of 1
> on exit. If you want to keep the object you would have to clone it.
>
> - take "&'owner self, &'child T where 'owner: 'child", then you can
> pass an embedded object like object_initialize_child().
> 
> In the latter case however you *still* need to keep the reference
> count elevated until Drop runs. That is, unlike C, Rust code will
> always have a ref count of 2 for children. For this reason, instead of
> having a "T" in the struct you would have another wrapper---something
> like Child<'owner, T>. This wrapper cannot be cloned but it does an
> unref when dropped.

Thanks, the whole picture is nice.

> My expectation is that property_add_child() will be used exclusivel
> for the first case, i.e. it will take an Owned<T>. If you want to
> create a child property from an embedded object, something like
> object_initialize_child() can be used once pinned-init is used to
> rewrite how instance_init is used. It will look something like
> 
> pin_init! {
>   &this in MyClass {
>     ...,
>     iomem <- MemoryRegion::init_io(
>             this,
>             &MY_MR_OPS,
>             "memory-region-name",
>             0x1000,
>     ),
>     child_obj <- ChildClass::init().to_child(this, "prop-name")
>   }
> }
> 
> where to_child() wraps an "impl PinInit<T>" and turns it into an "impl
> PinInit<Child<'a, T>>". Or something like that. :)

Elegant code design, looking forward to pin_init.

> > From this description, I understand your goal is:
> >
> >  * For embedded child object, its lifetimer is managed by its parent
> >    object, through Child<> for the most cases.
> >
> >  * For non-embedded child - a pointer/reference in parent object, its
> >    lifetimer is managed by `Owned<>` (and with Child<>).
> >
> > Am I right?
> 
> Yes, you're right.
> 
> I am not sure if you meant Child<> as the QOM concept, or as a Rust
> struct. If the latter, you're really really right.
> 

Thank you :-) It seems virtio device will have an embedded case to adopt
Child<> struct (virtio_instance_init_common()).

Regards,
Zhao


