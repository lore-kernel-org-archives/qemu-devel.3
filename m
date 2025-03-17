Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7E7C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 11:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu8Jp-0001DG-Hs; Mon, 17 Mar 2025 07:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tu8Jb-0001Bp-IE
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:07:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tu8JZ-00021k-5r
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742209645; x=1773745645;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k5W7aJHoyc9RtxT/s/LlELHVqJxMJ6x+kzqirpBGnKw=;
 b=e44tqmRD+1OtmULorgtTpD+e3ZSfZucMDFDRebdphGYKUc0aQuoDPoHk
 qyrfwphWPLH3x95kyUCSmFuv1267O889CMlpdGJpMaiYk1aKhZLpX4XuH
 Kht6rlLt+TnoPytDPtgkRj0zDrEY8MyEtfvdh1RFtISfbi43qTw1Ma/sQ
 8mVHaPtnXVjpwVJ3kICeuxmiS8ZW8sy+WqukM2QXE1QwyJDEuDFTdCrd8
 xz6jZ9KN0vZ7a5S6QuwYY8NMZUkLPYfmX+6LhgW77tLTry76x4BcDQ4h/
 IrYQnjcucdogTUglPoy/3RrGGCeNNI6LzFUjT+JCgu8vdX0VGpeZm5GHA g==;
X-CSE-ConnectionGUID: LKCBD8X7StCKMaiZRYIR4g==
X-CSE-MsgGUID: hDM7ssaER6mxXTiTiFxuKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="53506227"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; d="scan'208";a="53506227"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 04:07:21 -0700
X-CSE-ConnectionGUID: Et/mW7WVSZOPEjjd1Rwh2A==
X-CSE-MsgGUID: JJvGKHbUQXq/o17sPaI4Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; d="scan'208";a="121710785"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.8])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 04:07:15 -0700
Date: Mon, 17 Mar 2025 13:07:10 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v3 6/7] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
Message-ID: <Z9gCXoWhTxzurXvb@tlindgre-MOBL1>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-7-chenyi.qiang@intel.com>
 <Z9e-0OcFoKpaG796@tlindgre-MOBL1>
 <b158a3ef-b115-4961-a9c3-6e90b49e3366@intel.com>
 <Z9fvNU4EvnI6ScWv@tlindgre-MOBL1>
 <ebc6f8ed-3525-4bd8-8be0-143b1c7e75ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc6f8ed-3525-4bd8-8be0-143b1c7e75ee@intel.com>
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=tony.lindgren@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 17, 2025 at 06:21:13PM +0800, Chenyi Qiang wrote:
> 
> 
> On 3/17/2025 5:45 PM, Tony Lindgren wrote:
> > On Mon, Mar 17, 2025 at 03:32:16PM +0800, Chenyi Qiang wrote:
> >>
> >>
> >> On 3/17/2025 2:18 PM, Tony Lindgren wrote:
> >>> Hi,
> >>>
> >>> On Mon, Mar 10, 2025 at 04:18:34PM +0800, Chenyi Qiang wrote:
> >>>> --- a/system/physmem.c
> >>>> +++ b/system/physmem.c
> >>>> @@ -1885,6 +1886,16 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >>>>              qemu_mutex_unlock_ramlist();
> >>>>              goto out_free;
> >>>>          }
> >>>> +
> >>>> +        new_block->memory_attribute_manager = MEMORY_ATTRIBUTE_MANAGER(object_new(TYPE_MEMORY_ATTRIBUTE_MANAGER));
> >>>> +        if (memory_attribute_manager_realize(new_block->memory_attribute_manager, new_block->mr)) {
> >>>> +            error_setg(errp, "Failed to realize memory attribute manager");
> >>>> +            object_unref(OBJECT(new_block->memory_attribute_manager));
> >>>> +            close(new_block->guest_memfd);
> >>>> +            ram_block_discard_require(false);
> >>>> +            qemu_mutex_unlock_ramlist();
> >>>> +            goto out_free;
> >>>> +        }
> >>>>      }
> >>>>  
> >>>>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> >>>
> >>> Might as well put the above into a separate memory manager init function
> >>> to start with. It keeps the goto out_free error path unified, and makes
> >>> things more future proof if the rest of ram_block_add() ever develops a
> >>> need to check for errors.
> >>
> >> Which part to be defined in a separate function? The init function of
> >> object_new() + realize(), or the error handling operation
> >> (object_unref() + close() + ram_block_discard_require(false))?
> > 
> > I was thinking the whole thing, including freeing :) But maybe there's
> > something more to consider to keep calls paired.
> 
> If putting the whole thing separately, I think the rest part to do error
> handling still needs to add the same operation. Or I misunderstand
> something?

So maybe you suggestion of just a separate clean-up function would work:

new_block->memory_attribute_manager =
    MEMORY_ATTRIBUTE_MANAGER(object_new(TYPE_MEMORY_ATTRIBUTE_MANAGER));
if (memory_attribute_manager_realize(new_block->memory_attribute_manager,
    new_block->mr)) {
    memory_attribute_manager_cleanup(...);
    goto out_free;
}

> >> If need to check for errors in the rest of ram_block_add() in future,
> >> how about adding a new label before out_free and move the error handling
> >> there?
> > 
> > Yeah that would work too.
> 
> I'm not sure if we should add such change directly, or we can wait for
> the real error check introduced in future.

Right, not sure either.

Regards,

Tony

