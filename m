Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B1FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGcl-0006xK-F8; Mon, 27 Oct 2025 02:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDGcj-0006vA-8H
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:22:33 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDGch-000654-38
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761546151; x=1793082151;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3VPzMuspd46+dnLbU6SilaPw+leRh3PT5Rh5N1rdaCw=;
 b=NGWMs3z55hj964GMnbBir0LWTom4RkKJkcEbNqzsK4xFyt3ZoUfreOuA
 bXDBzBp1shZWrp4kBE29uXEMx7sab0XazyldOzbk+aHSy9mVK/FreRjU3
 FY1rgI2fudP6AE6Hl2AgFCvsrtj98h9MXWxVARNU56vM70rPcBRJZq/h5
 +AdmyKC10S9UL4mNWobt4dc2XnQDo9gNxyK7rK8zdVoqim3Q0OaB4w+v6
 rSNyYEtrvnY1utS3t9rqv8ylhgxNdo7g7UL9qZkDEKyd+h16mb0OnCUnl
 UwOj4Vp9aXdqrwas6v9/6KJzDdLU+3IywiiEWJ3BdlrNQte2pDgQuPMu/ w==;
X-CSE-ConnectionGUID: pjNTuv8QSNil4npQbFdjIQ==
X-CSE-MsgGUID: pq9p7/JTQmSieQw5wpJ/kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63322473"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63322473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:22:27 -0700
X-CSE-ConnectionGUID: HTMaOrlySYKo/mgmPvXoVA==
X-CSE-MsgGUID: eS2q2BmTRXm5qdnGEverYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184576018"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:22:23 -0700
Message-ID: <dcb87f98-bacd-4c57-9250-5122329ec400@intel.com>
Date: Mon, 27 Oct 2025 14:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] i386/cpu: Reorganize arch lbr structure
 definitions
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-5-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
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
> - Move ARCH_LBR_NR_ENTRIES macro and LBREntry definition before XSAVE
>    areas definitions.

personally, I prefer not moving them. Putting them together is friendly 
and convenient when reading the code rather than bouncing through 
different parts.

But considering the existing cases of BNDReg and BNDCSReg, I'm fine with 
the movement.

> - Reorder XSavesArchLBR (area 15) between XSavePKRU (area 9) and
>    XSaveXTILECFG (area 17), and reorder the related QEMU_BUILD_BUG_ON
>    check to keep the same ordering.

This reorder is good.

> This makes xsave structures to be organized together and makes them
> clearer.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.h | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 886a941e481c..ac527971d8cd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1652,6 +1652,14 @@ typedef struct {
>   
>   #define NB_OPMASK_REGS 8
>   
> +typedef struct {
> +    uint64_t from;
> +    uint64_t to;
> +    uint64_t info;
> +} LBREntry;
> +
> +#define ARCH_LBR_NR_ENTRIES 32
> +
>   /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
>    * that APIC ID hasn't been set yet
>    */
> @@ -1729,24 +1737,6 @@ typedef struct XSavePKRU {
>       uint32_t padding;
>   } XSavePKRU;
>   
> -/* Ext. save area 17: AMX XTILECFG state */
> -typedef struct XSaveXTILECFG {
> -    uint8_t xtilecfg[64];
> -} XSaveXTILECFG;
> -
> -/* Ext. save area 18: AMX XTILEDATA state */
> -typedef struct XSaveXTILEDATA {
> -    uint8_t xtiledata[8][1024];
> -} XSaveXTILEDATA;
> -
> -typedef struct {
> -       uint64_t from;
> -       uint64_t to;
> -       uint64_t info;
> -} LBREntry;
> -
> -#define ARCH_LBR_NR_ENTRIES            32
> -
>   /* Ext. save area 15: Arch LBR state */
>   typedef struct XSaveArchLBR {
>       uint64_t lbr_ctl;
> @@ -1757,6 +1747,16 @@ typedef struct XSaveArchLBR {
>       LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
>   } XSaveArchLBR;
>   
> +/* Ext. save area 17: AMX XTILECFG state */
> +typedef struct XSaveXTILECFG {
> +    uint8_t xtilecfg[64];
> +} XSaveXTILECFG;
> +
> +/* Ext. save area 18: AMX XTILEDATA state */
> +typedef struct XSaveXTILEDATA {
> +    uint8_t xtiledata[8][1024];
> +} XSaveXTILEDATA;
> +
>   QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
> @@ -1764,9 +1764,9 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
>   QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
> +QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
>   QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
> -QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>   
>   typedef struct ExtSaveArea {
>       uint32_t feature, bits;


