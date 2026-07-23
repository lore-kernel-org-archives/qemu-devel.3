Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3492C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsHa-0007bi-G9; Thu, 23 Jul 2026 08:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmsHU-0007aM-Jm
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:12:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmsHS-0004fw-Hu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784808722; x=1816344722;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=eII1PBzEE8SnfKcy8G5nVpzEv4kxcnItr8poopo4trY=;
 b=lTRhPTy6/Oa0te+0k0TGXNMXZKGyPH9TpYV8wGRteoGu3Uq6Ga9vsgon
 xafe2dsbTabeTlZU3YR+rLaW8QueUyivfeHWUT1Wbk6IDhvuD87SAt4e3
 TqwSgfXUsRJgY6a/Vtn1wC1kqKfSDLMocHVSH/MLbVFuMvCmsRAE6Ce+E
 t1t31geJHCfMe6J6zA2+tNIGVJrv53HRXtj+Z2yqeXR82x5I71zH+DqtX
 0cLGzRfcosJbvJFs7C+hVPvFCBmYur2/YeocAmeFFILWZnMZF44i1mrxK
 RS4sTUciuaMeLgz1yaNeXDDLd7P+f/jxvxKhVfg872+HhfolR577b0meN w==;
X-CSE-ConnectionGUID: bRVVnmwnTGuSuZFU82naeQ==
X-CSE-MsgGUID: xLvF/becRe+pQT/mALr6Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85313377"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85313377"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 05:11:59 -0700
X-CSE-ConnectionGUID: YLyN8t9OR2KOojv6uusv6w==
X-CSE-MsgGUID: T9HsjTKRRja0zGk4/DYerg==
X-ExtLoop1: 1
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2026 05:11:56 -0700
Date: Thu, 23 Jul 2026 20:11:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <amIFC5OwQ5eCPdI0@intel.com>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
 <87mrvightj.fsf@pond.sub.org>
 <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 23, 2026 at 11:45:47AM +0100, Peter Maydell wrote:
> Date: Thu, 23 Jul 2026 11:45:47 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
>  gpa2hva callers
> 
> On Thu, 23 Jul 2026 at 10:46, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> >
> > > Hi,
> > >
> > > On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> > >> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> > >> (inherited from memory_region_find()), but both SEV callers were failing
> > >> to release it.
> > >
> > > Comment orthogonal to your fix; odd to have a non-monitor code
> > > call an undocumented monitor method.
> >
> > Which one?
> 
> The gpa2hva() function, presumably. It does seem a bit odd to
> have the target/i386 code directly calling this. The function
> in monitor.c works on the system memory AddressSpace and
> assumes that there is only one kind of "guest physical address",
> because that's the implicit "everything is an old i386 PC"
> kind of assumption that got backed into the human monitor
> command. But it's not really something we should be doing
> more widely.
>
> The i386/sev code looks rather odd to me. It seems to be
> using gpa2hva as a way to get at the host memory that is
> backing the guest memory. Why can't it use the usual
> address_space_map() etc APIs for this?

Yes, I agree.

For sev_inject_launch_secret, it's straightforward to use
address_space_map().

> Worse, it looks like
> it keeps that host pointer around in a SevLaunchUpdateData
> struct, and it's not immediately obvious to me that it won't
> go wrong if the memory map later gets moved around and that
> pointer becomes invalid. And it looks like it writes into
> guest memory in a way that will bypass the dirty-tracking.

For snp_populate_metadata_pages() and SevLaunchUpdateData,
I think maybe we can use address_space_map() to get pointer,
and add a flag to SevLaunchUpdateData marking that data entry
owns a mapping. Then sev_snp_launch_finish() can unmap if that
flag is set, in its loop.

Thanks,
Zhao


