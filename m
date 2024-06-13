Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1422C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeSu-0004LG-9J; Thu, 13 Jun 2024 03:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeSs-0004Kp-G1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:01:42 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sHeSq-00055Z-0s
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718262100; x=1749798100;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nGflPj+S5UvQccF2IZArInW/ao7c5S61HaAnPLdJnxE=;
 b=bS+Du2WNQ5Qgsgoly7oMuK9EFncFKvUafOFLqhCVquL0jIRUgkzpMcR5
 KajT00jBsgtgF1fxUxDLynrBsZRB+JLIP1nfa3BftF7Z0+Gy0PWfZoMOq
 6gVnhxhJlmDdeX1eoP+Hp0/JTWGKrmPUDLp04xt6y/U9V8SbjX6yFoZL/
 9bGWt/yDVkRn+aJ8o+nPUs1tsRXDzH6dP89otpYOijni5L/BmvEmG7Bcj
 QnZEgVHWag4pipI7mf3rntyMzR5W1YdHzET6biJ7yHtjmZN7tf66x11h6
 /ILT5epOyGVV1+5lzEftDg10g7Fo4Zwz2WG3SWlQeh2PtmzaMeit6/yfQ Q==;
X-CSE-ConnectionGUID: /DBChAVsS8660CbxoY3wDg==
X-CSE-MsgGUID: XMt5S4ubQN+AaBC8f2J49A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15290735"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15290735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 00:01:36 -0700
X-CSE-ConnectionGUID: m7uUozA2QJaigpRY+VqlnQ==
X-CSE-MsgGUID: TrREHAvaTV6AvTb8sn2Y3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="45173204"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 13 Jun 2024 00:01:36 -0700
Date: Thu, 13 Jun 2024 15:17:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] i386/cpu: Add support for EPYC-Turin model
Message-ID: <Zmqc8SjlgRlpgoBw@intel.com>
References: <cover.1718218999.git.babu.moger@amd.com>
 <a4d4eaafb69d855a5c5d7dec98be68b3e948cefb.1718218999.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d4eaafb69d855a5c5d7dec98be68b3e948cefb.1718218999.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 02:12:20PM -0500, Babu Moger wrote:
> Date: Wed, 12 Jun 2024 14:12:20 -0500
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH 4/4] i386/cpu: Add support for EPYC-Turin model
> X-Mailer: git-send-email 2.34.1
> 
> Adds the support for AMD EPYC zen 5 processors(EPYC-Turin).

nit s/Adds/Add

> Adds the following new feature bits on top of the feature bits from

s/Adds/Add/

> the previous generation EPYC models.
> 
> movdiri            : Move Doubleword as Direct Store Instruction
> movdir64b          : Move 64 Bytes as Direct Store Instruction
> avx512-vp2intersect: AVX512 Vector Pair Intersection to a Pair
>                      of Mask Register
> avx-vnni           : AVX VNNI Instruction
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


