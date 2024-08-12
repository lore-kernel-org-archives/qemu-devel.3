Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97329C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRU2-0002yV-GB; Mon, 12 Aug 2024 05:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdRTz-0002xN-H4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:36:55 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdRTv-0004Xf-Ui
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723455412; x=1754991412;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NQSRiD51P6+T0C4YuC9FKWrTU7LbpgpOqR+oy2IoxX8=;
 b=agLDL6andLpeS4oCno+B8pZi7PFIUWR4afaNkhbInqTykQzatZZi+DSU
 Gz7tRSjww/H/jKbTODpc0V3SS/NQHi4xAMHHFjePJOZ6RGPys9JgWM8JX
 Laf7rF6EgfRi08TxWoYC1UgX9c1ocgsspRclUBJy0C9zaKjAtZGRwdOxP
 GkaxGeUOHMvHA3aeYcQKj+qSXrq50yTgyPqGIRkvOtLpPDr0JCWU/A3gj
 PQN8B3SjCNHTKbEVNnQkxiT1rpsrJUq817EfmLpXTcbtWKQ1EudsuooI0
 Revm9h9i5fHwoObItm9JDscUE+gFD5AcpWvEhCroTfpAORzn8XtJ321LU A==;
X-CSE-ConnectionGUID: EujbUJynS2yn1PP1SV3UfA==
X-CSE-MsgGUID: gnWTCeXFT+O33ACbPs5XXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25323561"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="25323561"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 02:36:48 -0700
X-CSE-ConnectionGUID: /5z746NvQfWn6W1PyIR6gQ==
X-CSE-MsgGUID: y/9p3Pv4SB+wTJFFE8Lbuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="81438418"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2024 02:36:45 -0700
Date: Mon, 12 Aug 2024 17:52:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v3 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
Message-ID: <ZrnbZBwATjGBHzWY@intel.com>
References: <20240809094259.119221-1-ewanhai-oc@zhaoxin.com>
 <20240809094259.119221-5-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809094259.119221-5-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Aug 09, 2024 at 05:42:59AM -0400, EwanHai wrote:
> Date: Fri, 9 Aug 2024 05:42:59 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3 4/4] target/i386: Mask CMPLegacy bit in
>  CPUID[0x80000001].ECX for Zhaoxin CPUs
> X-Mailer: git-send-email 2.34.1
> 
> Zhaoxin CPUs (including vendors "Shanghai" and "Centaurhauls") handle the
> CMPLegacy bit similarly to Intel CPUs. Therefore, this commit masks the
> CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs, just as it is done
> for Intel CPUs.
> 
> AMD uses the CMPLegacy bit (CPUID[0x80000001].ECX.bit1) along with other CPUID
> information to enumerate platform topology (e.g., the number of logical
> processors per package). However, for Intel and other CPUs that follow Intel's
> behavior, CPUID[0x80000001].ECX.bit1 is reserved.
> 
> - Impact on Intel and similar CPUs:
> This change has no effect on Intel and similar CPUs, as the goal is to
> accurately emulate CPU CPUID information.
> 
> - Impact on Linux Guests running on Intel (and similar) vCPUs:
> During boot, Linux checks if the CPU supports Hyper-Threading.
> If it detects

Maybe "For the kernel before v6.9, if it detects"? About this change,
see the below comment...

> X86_FEATURE_CMP_LEGACY, it assumes Hyper-Threading is not supported. For Intel
> and similar vCPUs, if the CMPLegacy bit is not masked in CPUID[0x80000001].ECX,
> Linux will incorrectly assume that Hyper-Threading is not supported, even if
> the vCPU does support it.

...It seems this issue exists in the kernel before v6.9. Thomas'
topology refactoring has fixed this behavior:
* commit 22d63660c35e ("x86/cpu: Use common topology code for Intel")
* commit 598e719c40d6 ("x86/cpu: Use common topology code for Centaur
  and Zhaoxin")

> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Just the above nit. Otherwise, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



