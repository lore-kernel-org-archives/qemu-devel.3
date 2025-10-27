Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC07CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGP7-0002Lc-SF; Mon, 27 Oct 2025 02:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDGP5-0002KV-Cn
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:08:27 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDGP2-0003xP-KS
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761545305; x=1793081305;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9aPOXXMZhxckm5IZ7JpMj9IGhEIB7o2FEzlDFbTBEoU=;
 b=SWKAQjwL8spCrvEFwFGT54qdXs1ViZ59wbir1NL5BekWIemg3HoRNmCW
 L9LkufGDXjnYzQ74ut5Qu/JmOEZMA2PfdVDu5G/Ip+gsTkUxFcLcI0sWQ
 +XSVJXigSpNbaOEnJO8QxTxeDeIV2RqrT4n/3msVS8stVFhLKXWGuyqn3
 A/zIhbm4dchWIgcSQy65j986B4nwi8KRfwPpHC/qsetMb/k9NlKyeop0I
 8+B+RwNyfbBbt5MbkiL7UR6QkQWCvN/4dZCQ5iHl1Vme5ULK+4F4eZTKf
 2DytQggTu89dpHbhNhA3mYED+W2Bq16YlbwvyWtniwDW/v1C7Fc6BSCcr g==;
X-CSE-ConnectionGUID: QjaWCEJeS2WBylhGkwAzZw==
X-CSE-MsgGUID: MifpeIcGSrGz6rQGOjt4nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74221014"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="74221014"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:08:22 -0700
X-CSE-ConnectionGUID: lhf6TAAkRSe+kOxDaTi8jA==
X-CSE-MsgGUID: IV3fH1M7RyWUH2aTni8zmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184571603"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:08:18 -0700
Message-ID: <9d72b723-aeef-474c-8e46-3b8dc027774d@intel.com>
Date: Mon, 27 Oct 2025 14:08:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] i386/cpu: Clean up arch lbr xsave struct and
 comment
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-4-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.57, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> Arch LBR state is area 15, not 19. Fix this comment. And considerring
> other areas don't mention user or supervisor state, for consistent
> style, remove "Supervisor mode" from its comment.
> 
> Moreover, rename XSavesArchLBR to XSaveArchLBR since there's no need to
> emphasize XSAVES in naming; the XSAVE related structure is mainly
> used to represent memory layout.
> 
> In addition, arch lbr specifies its offset of xsave component as 0. But
> this cannot help on anything. The offset of ExtSaveArea is initialized
> by accelerators (e.g., hvf_cpu_xsave_init(), kvm_cpu_xsave_init() and
> x86_tcg_cpu_xsave_init()), so explicitly setting the offset doesn't
> work and CPUID 0xD encoding has already ensure supervisor states won't
> have non-zero offsets. Drop the offset initialization and its comment
> from the xsave area of arch lbr.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 3 +--
>   target/i386/cpu.h | 8 ++++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f0e179c2d235..b9a5a0400dea 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2058,8 +2058,7 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
>       },
>       [XSTATE_ARCH_LBR_BIT] = {
>           .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
> -        .offset = 0 /*supervisor mode component, offset = 0 */,
> -        .size = sizeof(XSavesArchLBR),
> +        .size = sizeof(XSaveArchLBR),
>       },
>       [XSTATE_XTILE_CFG_BIT] = {
>           .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d0da9bfe58ce..886a941e481c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1747,15 +1747,15 @@ typedef struct {
>   
>   #define ARCH_LBR_NR_ENTRIES            32
>   
> -/* Ext. save area 19: Supervisor mode Arch LBR state */
> -typedef struct XSavesArchLBR {
> +/* Ext. save area 15: Arch LBR state */
> +typedef struct XSaveArchLBR {
>       uint64_t lbr_ctl;
>       uint64_t lbr_depth;
>       uint64_t ler_from;
>       uint64_t ler_to;
>       uint64_t ler_info;
>       LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
> -} XSavesArchLBR;
> +} XSaveArchLBR;
>   
>   QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
> @@ -1766,7 +1766,7 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
>   QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
> -QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
> +QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>   
>   typedef struct ExtSaveArea {
>       uint32_t feature, bits;


