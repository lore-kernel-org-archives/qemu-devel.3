Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8424E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOUc-0001S7-2o; Wed, 11 Dec 2024 10:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLOUa-0001Rm-2U; Wed, 11 Dec 2024 10:19:12 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLOUX-0007nk-Af; Wed, 11 Dec 2024 10:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733930349; x=1765466349;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=V+IF91RnFmWIgV9M5T6wVfRAj5Yvc+Z9uPR42MeFPXk=;
 b=DBmkTehCd03afrzDdD1/FLqGhqdphRnVe9kzA7a3Jd7fxDEs/5zfi1u/
 oAe3TjocFUfvVIv3DtkTBGayHhFqEBSCyZzGHzueKWEnp+P8jHLNTDoTS
 R6IZ9L1L/Z/KzGKSUEFExUTaU+kJ5+RFAQDtP893dFUNPwwTsR9CvGJE7
 Tm4ZzWR0Py2OgYuENJOG7lNHIxaF5Npf7bESVCcfm2ToZth55pLMucxAZ
 E8gvhvl/gLl+E73yvaERMSRNrFxLrs0jWGx5zf0N7AQN1D1S8s7hwflCu
 U1XMwvMuFB+B0APNxUyJblpF+xVvn3H54oDF6W8klNYa6Ay6IZzmTECO9 w==;
X-CSE-ConnectionGUID: 1tYOVv3+TuuV56BrBi5fDA==
X-CSE-MsgGUID: +Q9LJA4iRYSO6PwWQDLBjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45697017"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; d="scan'208";a="45697017"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 07:19:06 -0800
X-CSE-ConnectionGUID: UI8nKOhJQxCmEkUEw1EoEQ==
X-CSE-MsgGUID: XHg9YqcDQsGunqCFdOPBXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="95671935"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 11 Dec 2024 07:19:05 -0800
Date: Wed, 11 Dec 2024 23:37:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 13/26] rust: qom: automatically use Drop trait to
 implement instance_finalize
Message-ID: <Z1mxrzMyCqsGoqQa@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-14-pbonzini@redhat.com>
 <Z1hpT6F9jVlj2+ba@intel.com>
 <CABgObfYa1HZoRs+RVSxax02jAcMb86P3VM-fJa0KHHTTiDTuYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYa1HZoRs+RVSxax02jAcMb86P3VM-fJa0KHHTTiDTuYw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Dec 11, 2024 at 01:42:32PM +0100, Paolo Bonzini wrote:
> Date: Wed, 11 Dec 2024 13:42:32 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 13/26] rust: qom: automatically use Drop trait to
>  implement instance_finalize
> 
> On Tue, Dec 10, 2024 at 4:58 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > Great idea. It nicely balances the differences between Rust and C QOM
> > conventions.
> 
> Except it does not work. :(  Suppose you have
> 
>        pub struct MySuperclass {
>            parent: DeviceState,
>            field: Box<MyData>,
>            ...
>        }
> 
>        impl Drop for MySuperclass {
>            ...
>        }
> 
>        pub struct MySubclass {
>            parent: MySuperclass,
>            ...
>        }
> 
> When instance_finalize is called for MySubclass, it will walk the
> struct's list of fields and call the drop method for MySuperclass.
> Then, object_deinit recurses to the superclass and calls the same drop
> method again.  This will cause double-freeing of the Box<MyData>, or
> more in general double-dropping.

Good catch! Yes, there is indeed such an issue... The above example
could become a test case :-), which I supposed could trigger a double-
dropping error when compiling.

> What's happening here is that QOM wants to control the drop order of
> MySuperclass and MySubclass's fields.  To do so, the parent field must
> be marked ManuallyDrop<>, which is quite ugly.  Perhaps we can add a
> wrapper type ParentField<> that is specific to QOM.  This hides the
> implementation detail of *what* is special about the ParentField, and
> it will also be easy to check for in the #[derive(Object)] macro.
> Maybe in the future it will even make sense to have special functions
> implemented on ParentField, I don't know...

I also looked into the implementation of ManuallyDrop, and I agree with
a new ParentField (or simply ObjectParent). This wrapper is simple
enough but also useful for QOM. I will pay more attention to the
recursed relationships in QOM in review as well...

Thanks,
Zhao


