Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD61CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMPT-0008Fu-P6; Fri, 24 Oct 2025 14:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPS-0008Fi-Au
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:06 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPN-0008EP-Ai
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761330061; x=1792866061;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dsTKYI2tavi9iR5GYwHm3XNJQdogM73BnjgCufX5w34=;
 b=AQOq+R4s8HfmjLIM/rA0Ci/SyKgjZ+V9ZvyVUWvBuL2okFES9rpOAnGV
 4qFXVH+BzB5Z6f5dtmbQi4J2jP6Aulta9ipHK5dPCKXJGLoEgHjz5rNAz
 sAkHiw3+EiMYd9eSepYxi9pY82hRsHQqgrKZPKCvs4ePz3OTUZ8HAVDx1
 dF3xtmk5XAkbUkR+awcHMy/ryKzlEhKM/qILmuz7H2sYSCmXt+SU8jq4Q
 bPmcgYKCeUl7/juDxDaazD/J4hbHwHwg8pqo0QN+jvsMp/P5TZqvlIaiL
 PTOLsYszYQlXlqT8/Yo25QBTAqG7ZARmENf4vi01U8GL/E3WiOAg8+3V3 g==;
X-CSE-ConnectionGUID: jzvTDofJSV6xt4PEA+nGFA==
X-CSE-MsgGUID: 786HbB2SSQyt8PbkRdJDjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74119586"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="74119586"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:20:56 -0700
X-CSE-ConnectionGUID: Sfbz+b2xRfOOmIF5BmsdkQ==
X-CSE-MsgGUID: /Hv5XVoGRCOJkJC5vJnBAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="188882449"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.181])
 ([10.241.241.181])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:20:55 -0700
Message-ID: <1bcebd76-877e-41eb-a21e-5a49c648fd37@intel.com>
Date: Fri, 24 Oct 2025 11:20:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] i386/cpu: Reorganize arch lbr structure
 definitions
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-5-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251024065632.1448606-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zide.chen@intel.com;
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



On 10/23/2025 11:56 PM, Zhao Liu wrote:
> - Move ARCH_LBR_NR_ENTRIES macro and LBREntry definition before XSAVE
>   areas definitions.
> - Reorder XSavesArchLBR (area 15) between XSavePKRU (area 9) and
>   XSaveXTILECFG (area 17), and reorder the related QEMU_BUILD_BUG_ON
>   check to keep the same ordering.
> 
> This makes xsave structures to be organized together and makes them
> clearer.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
>  target/i386/cpu.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 886a941e481c..ac527971d8cd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1652,6 +1652,14 @@ typedef struct {
>  
>  #define NB_OPMASK_REGS 8
>  
> +typedef struct {
> +    uint64_t from;
> +    uint64_t to;
> +    uint64_t info;
> +} LBREntry;
> +
> +#define ARCH_LBR_NR_ENTRIES 32
> +
>  /* CPU can't have 0xFFFFFFFF APIC ID, use that value to distinguish
>   * that APIC ID hasn't been set yet
>   */
> @@ -1729,24 +1737,6 @@ typedef struct XSavePKRU {
>      uint32_t padding;
>  } XSavePKRU;
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
>  /* Ext. save area 15: Arch LBR state */
>  typedef struct XSaveArchLBR {
>      uint64_t lbr_ctl;
> @@ -1757,6 +1747,16 @@ typedef struct XSaveArchLBR {
>      LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
>  } XSaveArchLBR;
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
>  QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveBNDCSR) != 0x40);
> @@ -1764,9 +1764,9 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
>  QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
> +QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
> -QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>  
>  typedef struct ExtSaveArea {
>      uint32_t feature, bits;


