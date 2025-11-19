Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9D2CF2567
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcZM-0000FE-VO; Wed, 19 Nov 2025 02:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLcZ6-0000BB-Eg
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:25:22 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLcYy-0008B1-OT
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763537112; x=1795073112;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4PhZgJ5p/fAYFjT9EQDC/elazvzshQlub5vAtKA0oHE=;
 b=eOaxpPe7lD+atMWY4udgowgaqzpIhyS9MZBgMhCswq1Ak5+fy9WVncPq
 LeeouuvPS/tWlCVg262A5eEHXNzParQwE1sdztEjY2sSjMFdnF/r5Yt8m
 Kic8toxbCQXGP2lQCcHppRTZ/94TzvAJZCZTqU8JzquXg9Lx8SsaWvh1w
 AKw7hr/dbqWbjCoSfXdAtPCQpXIZEE1L4vTht2QidoCTk48OZdomaLayh
 Zema2OpaNcC2rCBTJXrPGzunbQ7ds2g79whIzoHkkxxYJaUufSyB+IUJ2
 4XTqfvp23VJl4i1mJ5LnFkzLWnVCrIdCPjReZN+SGdzcyemCSLFyR5PDO A==;
X-CSE-ConnectionGUID: 88sZvrFvQ3+OUiEfbg/rTw==
X-CSE-MsgGUID: kfnCPifzRNOQW0ScxtJDFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68176975"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="68176975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 23:25:07 -0800
X-CSE-ConnectionGUID: yIu5F3gmSReum3H1F8gkyg==
X-CSE-MsgGUID: maoJ8l6pSFaSX8uXbi69MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191116663"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 18 Nov 2025 23:25:06 -0800
Date: Wed, 19 Nov 2025 15:47:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/5] i386/cpu: Cache EGPRs in CPUX86State
Message-ID: <aR12DVNhNuViq7sG@intel.com>
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-3-zhao1.liu@intel.com>
 <CABgObfbzzwCafmGehgzCC-pFSnRR1OW_wfQxR4OJDAbv4mCztQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbzzwCafmGehgzCC-pFSnRR1OW_wfQxR4OJDAbv4mCztQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Nov 18, 2025 at 09:43:26AM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Nov 2025 09:43:26 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 2/5] i386/cpu: Cache EGPRs in CPUX86State
> 
> On Tue, Nov 18, 2025 at 7:43 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > From: Zide Chen <zide.chen@intel.com>
> >
> > Cache EGPR[16] in CPUX86State to store APX's EGPR value.
> 
> Please change regs[] to have 32 elements instead; see the attached
> patch for a minimal starting point. You can use VMSTATE_SUB_ARRAY to
> split their migration data in two parts. You'll have to create a
> VMSTATE_UINTTL_SUB_ARRAY similar to VMSTATE_UINT64_SUB_ARRAY.

Thanks! VMSTATE_UINTTL_SUB_ARRAY is for target_ulong. I'll move EGPRs
to regs[].

> To support HMP you need to adjust target/i386/monitor.c and
> target/i386/cpu-dump.c. Please make x86_cpu_dump_state print R16...R31
> only if APX is enabled in CPUID.
> 
> Also, it would be best for the series to include gdb support. APX is
> supported by gdb as a "coprocessor", the easiest way to do it is to
> copy what riscv_cpu_register_gdb_regs_for_features() does for the FPU,
> and copy https://github.com/intel/gdb/blob/master/gdb/features/i386/64bit-apx.xml
> into QEMU's gdb-xml/ directory.

Good! Thank you for your guidance. I will add GDB support in next
version.

Regards,
Zhao


