Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35F4C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9CX-0005cR-9f; Tue, 09 Apr 2024 06:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ru9CQ-0005c5-4V; Tue, 09 Apr 2024 06:59:34 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ru9CN-0003WT-Mp; Tue, 09 Apr 2024 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712660372; x=1744196372;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kQ5/iifoDjm2545ej6pWbM0neVWPPDk5fmy69fVHjmI=;
 b=b63K22cQONMDpJNwxyNBqnbnqmEwYV0UYQsYoxRYwSGqH41xyN6PIQOl
 AqZB3nkaC7eKy14pe3W8VFXM0Ak31OmvbmTc5HC/kd2vu6pw0ozx+8W95
 PlVh/JgqgsdJtJUrRN7uGuPaF+ByAi4G7P2j1TNwQ7VCdqeqea43kRDid
 8NzEqSbyrHB6OgThZGca+ObxUHQeD/yJoIY6UeqIsY2tgh7PiKffD36FY
 NY/gO62oeW5xDWl5NtBW17eNnd/TnWT+4D4DICc9xMkp1v74cpZ2vFJZ7
 BF1rBY1oL8iQLTv1pk3f7hwDQgcRr1v43WBcbJbfHZO8Jlhab4nyB7trf Q==;
X-CSE-ConnectionGUID: QWF7d1GdTPO5Fdd4hq/1Ng==
X-CSE-MsgGUID: HYgxL8wlRWG/VpmzP2L9GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19399208"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; d="scan'208";a="19399208"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2024 03:59:27 -0700
X-CSE-ConnectionGUID: sRpFCGYAS7yjRHHuJ9PwiQ==
X-CSE-MsgGUID: 3Wlo+GXaTyWr/vvWv+BO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; d="scan'208";a="24968563"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 09 Apr 2024 03:59:24 -0700
Date: Tue, 9 Apr 2024 19:13:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Giuseppe =?iso-8859-1?Q?Ghib=F2?= <ghibo@mageia.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
Message-ID: <ZhUi1NpSeUzXUuMu@intel.com>
References: <20240311075806.668555-1-pbonzini@redhat.com>
 <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
 <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfcda496-5781-49b2-a30b-8e28aa373218@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Michael & Paolo,

On Fri, Apr 05, 2024 at 08:30:43PM +0300, Michael Tokarev wrote:
> Date: Fri, 5 Apr 2024 20:30:43 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
> 
> 01.04.2024 09:02, Michael Tokarev:
> 
> > Anyone can guess why this rather trivial and obviously correct patch causes segfaults
> > in a few tests in staging-7.2 - when run in tcg mode, namely:
> > 
> >    pxe-test
> >    migration-test
> >    boot-serial-test
> >    bios-tables-test
> >    vmgenid-test
> >    cdrom-test
> > 
> > When reverting this single commit from staging-7.2, it all works fine again.
> 
> It sigsegvs in probe_access_internal():
> 
>   CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr); -- this one returns NULL,
> 
> and next there's a call
> 
>   tlb_addr = tlb_read_ofs(entry, elt_ofs);
> 
> which fails.
> 
> #0  0x0000555555c5de8a in tlb_read_ofs (ofs=8, entry=0x0) at 7.2/accel/tcg/cputlb.c:1455
> #1  probe_access_internal
>     (env=0x555556a862a0, addr=4294967280, fault_size=fault_size@entry=1,
> access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=5,
> nonfault=nonfault@entry=false, phost=0x7fffea4d32a0, pfull=0x7fffea4d3298,
> retaddr=0)
>     at 7.2/accel/tcg/cputlb.c:1555
> #2  0x0000555555c62aba in get_page_addr_code_hostp
>     (env=<optimized out>, addr=addr@entry=4294967280, hostp=hostp@entry=0x0)
>     at 7.2/accel/tcg/cputlb.c:1691
> #3  0x0000555555c52b54 in get_page_addr_code (addr=4294967280, env=<optimized out>)
>     at 7.2/include/exec/exec-all.h:714
> #4  tb_htable_lookup
>     (cpu=cpu@entry=0x555556a85530, pc=pc@entry=4294967280,
> cs_base=cs_base@entry=4294901760, flags=flags@entry=64,
> cflags=cflags@entry=4278190080) at 7.2/accel/tcg/cpu-exec.c:236
> #5  0x0000555555c53e8e in tb_lookup
>     (cflags=4278190080, flags=64, cs_base=4294901760, pc=4294967280, cpu=0x555556a85530)
>     at 7.2/accel/tcg/cpu-exec.c:270
> #6  cpu_exec (cpu=cpu@entry=0x555556a85530) at 7.2/accel/tcg/cpu-exec.c:1001
> #7  0x0000555555c75d2f in tcg_cpus_exec (cpu=cpu@entry=0x555556a85530)
>     at 7.2/accel/tcg/tcg-accel-ops.c:69
> #8  0x0000555555c75e80 in mttcg_cpu_thread_fn (arg=arg@entry=0x555556a85530)
>     at 7.2/accel/tcg/tcg-accel-ops-mttcg.c:95
> #9  0x0000555555ded098 in qemu_thread_start (args=0x555556adac40)
>     at 7.2/util/qemu-thread-posix.c:505
> #10 0x00007ffff5793134 in start_thread (arg=<optimized out>)
> #11 0x00007ffff58137dc in clone3 ()
> 

I debugged it manually, and found the problem occurs in tlb_index() with
mmu_idx=5.

For v7.2, the maximum mmu index supported by i386 is 4 (since
NB_MMU_MODES = 5 defined in target/i386/cpu-param.h).

On Michael's 7.2-i386-mmu-idx tree, the commit 9fc3a7828d25 ("target/i386:
use separate MMU indexes for 32-bit accesses") introduced more indexes
without relaxing the NB_MMU_MODES for i386.

Before this fix, probe_access_internal() just got the wrong mmu_idx as 4,
and it's not out of bounds. After this fix, the right mmu_idx=5 is truly
out of bounds.

On the master branch, there's no such issue since the commits ffd824f3f32d
("include/exec: Set default NB_MMU_MODES to 16") and 6787318a5d86
("target/i386: Remove NB_MMU_MODES define") relaxed upper limit of MMU
index for i386.

So these 2 commits should also be picked (with these 2 commits, tests in
"make check" passed).

However, the cleanup for NB_MMU_MODES is a big series (total 23 patches,
from the commit ffd824f3f32d ("include/exec: Set default NB_MMU_MODES to
16") to 00da6b49a227 ("include/exec: Remove guards around NB_MMU_MODES")),
maybe changes in other arches should be picked together?

In addition, I think maybe we could add assert() in tlb_index() and
tlb_entry() to ensure the mmu_idx not exceed the limit of NB_MMU_MODES.
But I'm a little unsure if this will hurt performance, because these 2
helpers look like the hotspot functions.

-Zhao


