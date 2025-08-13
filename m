Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F005FC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCmr-00074X-8v; Wed, 13 Aug 2025 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCmo-00073v-LY; Wed, 13 Aug 2025 10:49:06 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCme-0000du-QY; Wed, 13 Aug 2025 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755096537; x=1786632537;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tIvV3E8n44J30cLpFV7os3SlUAlAuiUq0ZShXd5t0f0=;
 b=NG+oPkFwcZ/2GuRoshqE8nG3baxeHAPEWX0anprp1mihKdNi8N3NH04Z
 ykGHqZmyFJrv3nLrB7gfpx7kfZJvVzWFXAmtG2PBDAiVnPv//gPojUzNp
 oZZYjlctL19x+6u0kpw2oI+XwZ4BqMQIQIuS8o8bFieYG42N0UR1xUjTi
 KrT5kb7OgeCByQSDmXubwjLx06hsADc+54oLyVrBQPdBy3OfolbW4V9c5
 vbnpXswqQ8hr2biUBPet+T6PwAiJhi7UDPMv6G9m0U0KAD64IFo0udJ34
 QfFrICG22lPooiUJeu/ToCr4cnKpjZyIs+4/kcq+s5hIECUoPLBO/DZM8 w==;
X-CSE-ConnectionGUID: frwVyH/nTKKLieqcCGipIQ==
X-CSE-MsgGUID: 8ZexVYWCTJuPZplGO6KFPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44972098"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="44972098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 07:48:48 -0700
X-CSE-ConnectionGUID: 9E34JwdMRbyyStpiqebsVQ==
X-CSE-MsgGUID: yPXXwx5ISa2JjdsT7RHFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="171735616"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2025 07:48:46 -0700
Date: Wed, 13 Aug 2025 23:10:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 16/26] memory: Make flatview_do_translate() return a
 pointer to MemoryRegionSection
Message-ID: <aJyq4396vM2c+5qQ@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-17-zhao1.liu@intel.com>
 <beab841b-9c69-43d2-b996-879eee9e1120@redhat.com>
 <aJtgIBgl8JzDsJ1O@intel.com>
 <CABgObfbgX3yiBkyc0aH-6WXLf4bdEOgvY=m2AcPQXAXdruSkNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbgX3yiBkyc0aH-6WXLf4bdEOgvY=m2AcPQXAXdruSkNQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Tue, Aug 12, 2025 at 09:23:59PM +0200, Paolo Bonzini wrote:
> Date: Tue, 12 Aug 2025 21:23:59 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 16/26] memory: Make flatview_do_translate() return a
>  pointer to MemoryRegionSection
> 
> Il mar 12 ago 2025, 17:17 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > But look closer to Opaque<>, it has 2 safe methods: as_mut_ptr() &
> > raw_get().
> >
> > These 2 methods indicate that the T pointed by Qpaque<T> is mutable,
> > which has the conflict with the original `*const
> > bindings::MemoryRegionSection`.
> >
> > So from this point, it seems unsafe to use Qpaque<> on this case.
> >
> 
> Yes, it's similar to NonNull<>. I am not sure that you need Opaque<> here;
> since the pointer is const, maybe you can just dereference it to a
> &bindings::MemoryRegionSection. Is it useful to have the Opaque<> wrapper
> here?

I agree. Opaque<> is not necessary here. We can have a simple wrapper:

pub struct MemoryRegionSection(*const bindings::MemoryRegionSection)

or

pub struct MemoryRegionSection(NonNull<bindings::MemoryRegionSection>)
with immutable only use.

In future, if there're more similar case, then we can have a OpaqueRef<>
like Manos suggested.

Thanks,
Zhao


