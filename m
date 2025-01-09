Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8ACE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnOU-0006gF-9z; Thu, 09 Jan 2025 02:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVnOH-0006fF-2g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:55:46 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVnOD-0004gQ-Mv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736409338; x=1767945338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pyZmZFyKDBHekyYEQGRVyICCu9kWdK7pV256wvcoNRI=;
 b=f4Mpp2XjNlDd9GcQgEAKN2laCYE99/7/WyDXsWncYJcDtjegYOgz3ls3
 JrbXydJyoG+a4QGd43ILqnzlYlaXtdHyJ9xihTTCFhK9I7C3fRPptaMtH
 IqqBGpJI3P3sjL9whfrEW7iQGIY1gIy1ya0S3eppgb5Y/ifohCDKVMiVX
 txmJyrZIaf9Zx4Uf0v8WpFu+fBG+eV+uNF7YN31KpYCO91FlrbIgYWlGz
 Roopc1Tel6l1OgLa/qj77JB+AqcrgH6yAsFWYFUknHC1aLsPgpuo6wFDe
 IB9DUSWL7FknYmgCC3HxzpctIo8IJzli0zJUII/lNhu2lewlW/Zi4vC7a A==;
X-CSE-ConnectionGUID: tgJCSFVaR9manGK2YRCAKA==
X-CSE-MsgGUID: q9KA5WRyR3eUT0BC5yd+Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36885075"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; d="scan'208";a="36885075"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 23:55:31 -0800
X-CSE-ConnectionGUID: In0HEq3YQQWKLhk9Q1wvMg==
X-CSE-MsgGUID: WI+43nBfQFaAxKWBm/njXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; d="scan'208";a="103872722"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2025 23:55:28 -0800
Date: Thu, 9 Jan 2025 16:14:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 5/7] memory: Register the RamDiscardManager instance upon
 guest_memfd creation
Message-ID: <Z3+FWW9v3QqL/gEw@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-6-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213070852.106092-6-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> @@ -1885,6 +1886,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
>          }
> +
> +        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(object_new(TYPE_GUEST_MEMFD_MANAGER));
> +        guest_memfd_manager_realize(gmm, new_block->mr, new_block->mr->size);

realize & unrealize are usually used for QDev. I think it's not good to use
*realize and *unrealize here.

Why about "guest_memfd_manager_attach_ram"?

In addition, it seems the third parameter is unnecessary and we can access
MemoryRegion.size directly in guest_memfd_manager_realize().

>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> @@ -2139,6 +2143,9 @@ static void reclaim_ramblock(RAMBlock *block)
>  
>      if (block->guest_memfd >= 0) {
>          close(block->guest_memfd);
> +        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(block->mr->rdm);
> +        guest_memfd_manager_unrealize(gmm);

Similiarly, what about "guest_memfd_manager_unattach_ram"?

> +        object_unref(OBJECT(gmm));
>          ram_block_discard_require(false);
>      }
>  

Regards,
Zhao


