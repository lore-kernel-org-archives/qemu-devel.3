Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1982CC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkezK-0006pv-87; Fri, 17 Jul 2026 05:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wkezJ-0006ph-Cm; Fri, 17 Jul 2026 05:36:09 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wkezH-0002OP-KL; Fri, 17 Jul 2026 05:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784280968; x=1815816968;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gPpdV5FPTQEfVjnLQnL976+AGTIRVSKPWNh9KzQVND0=;
 b=j0znrJlB8G0UmLkiFH1mrecrhb11d9jG7ccUZSi7UU5uPECTfTWZeIV/
 YdPh1IrEm3PUrV0s7SdypEdukRdTJIbMzCdwAizhiWPOV1NyUnhhzA2z2
 FKpnRleVusllF7s/S282j+RMqOHaSN7v5P0fP3oMDyVSU9VGvujlPqe80
 Y1cP/MYzHLlbXSonjN9VevscckSAKLco8+IkupIjsWTPfGAuPK9VzUxRl
 yTS01U4fGaSDbk6avbviGc8eaW6l2DSqXfmI7T3bJ5M2YPsxyET0T1A0L
 OZRlk+PZjlnrlqZQX6y+oqeskeSaxtWMgJH3vfHcCb9TbEqOdsNK2gQ/r A==;
X-CSE-ConnectionGUID: 9FVb0cEsS0iz3GaSyvZpGA==
X-CSE-MsgGUID: Un7GrzDATmqEyUdqLJ0gKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="88773558"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="88773558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:36:00 -0700
X-CSE-ConnectionGUID: yW0c6JdTTFOpNoK7PNypbQ==
X-CSE-MsgGUID: GGERH+qRRp22pZO6VkIAww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="250392024"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa009.fm.intel.com with ESMTP; 17 Jul 2026 02:35:58 -0700
Date: Fri, 17 Jul 2026 17:35:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386/cpu: don't assert on out-of-range CPUID 0x1f
 subleaf
Message-ID: <aln3fXBIocLKn0nG@intel.com>
References: <20260609090046.2376016-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609090046.2376016-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 09, 2026 at 05:00:46PM +0800, Ewan Hai-oc wrote:
> Date: Tue, 9 Jun 2026 17:00:46 +0800
> From: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH] target/i386/cpu: don't assert on out-of-range CPUID 0x1f
>  subleaf
> X-Mailer: git-send-email 2.34.1
> 
> encode_topo_cpuid1f() asserts count <= CPU_TOPOLOGY_LEVEL_SOCKET, but
> count is the subleaf index passed straight from the guest's ECX;
> cpu_x86_cpuid() does not clamp it for leaf 0x1f. On a TCG vCPU exposing
> 0x1f, any CPUID(0x1f) with ECX > 5 aborts QEMU. SeaBIOS already trips
> this during POST (its cpuid() helper leaves a stale ECX from the
> EFLAGS.ID probe), and guests reach it too,the kernel walks 0x1f
> subleaves in a loop and /dev/cpu/*/cpuid forwards arbitrary subleaves.
> 
> Per the SDM, CPUID never faults and a subleaf past the last topology
> level returns the invalid encoding (EAX=EBX=0, ECX level type 0, EDX the
> x2APIC ID), exactly as the legacy 0xB leaf already does. Return that
> instead of asserting. KVM is unaffected.
> 
> Affected models: SapphireRapids (v4+), GraniteRapids (v3+), SierraForest
> (v3+), ClearwaterForest (v3+), DiamondRapids and YongFeng (v3+).
> 
> Fixes: 822bce9f58df ("i386/cpu: Decouple CPUID[0x1F] subleaf with specific topology level")
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

(cc stable list)

Yes, good catch!

On a TCG vCPU exposing 0x1f, requesting an invalid subleaf triggers
this abort, e.g.:

cpuid -1 -l 0x1f -s 8

Thanks for the fix,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


Regards,
Zhao


