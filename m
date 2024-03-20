Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D934C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0AJ-0001L3-7B; Wed, 20 Mar 2024 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rn0AG-0001It-59
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:55:48 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1rn0AA-0005zA-HG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710957342; x=1742493342;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jMWF46sbhfs/k1gmIhnSS7Ujnub/iP1jOCKSSBybAsg=;
 b=iqP9v3kzb80+RnGLLhyX3gIljx7uRMWsJzP4RRVGJgZy+rzwyCiGAJJa
 F1pnfWCx3WwuFP+LTr+Astz7u2D9X79dcyuxQamMXb3yW4/7iHWjBB1t3
 O6VQpUdMDn18HvRr4UM3qCCPlwvfA855PhZlOrLN4e4Us7nCvGIbHXdUy
 Z/kMfC0iTZtrstmpTz5VoIQPl9oW22q3rG6rKRQggVNDZhIFMjq7pmIUN
 2IcBX+0xM6LIB+Ce77X1izVUth/1Vd8cOr/6iKapiOFEhsybrxftYz+Nb
 HS2+z8bE7CEGTT6yxefl6W7n1VUhkmH2qnsyh9qDqr8sApCrsoYcGhOzm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5840929"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5840929"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 10:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14634905"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 10:55:37 -0700
Date: Wed, 20 Mar 2024 10:55:35 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 40/49] hw/i386/sev: Add function to get SEV metadata
 from OVMF header
Message-ID: <20240320175535.GF1994522@ls.amr.corp.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-41-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-41-michael.roth@amd.com>
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 20, 2024 at 03:39:36AM -0500,
Michael Roth <michael.roth@amd.com> wrote:

> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> A recent version of OVMF expanded the reset vector GUID list to add
> SEV-specific metadata GUID. The SEV metadata describes the reserved
> memory regions such as the secrets and CPUID page used during the SEV-SNP
> guest launch.
> 
> The pc_system_get_ovmf_sev_metadata_ptr() is used to retieve the SEV
> metadata pointer from the OVMF GUID list.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  hw/i386/pc_sysfw_ovmf.c | 33 +++++++++++++++++++++++++++++++++
>  include/hw/i386/pc.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
> index 07a4c267fa..32efa34614 100644
> --- a/hw/i386/pc_sysfw_ovmf.c
> +++ b/hw/i386/pc_sysfw_ovmf.c
> @@ -35,6 +35,31 @@ static const int bytes_after_table_footer = 32;
>  static bool ovmf_flash_parsed;
>  static uint8_t *ovmf_table;
>  static int ovmf_table_len;
> +static OvmfSevMetadata *ovmf_sev_metadata_table;
> +
> +#define OVMF_SEV_META_DATA_GUID "dc886566-984a-4798-A75e-5585a7bf67cc"
> +typedef struct __attribute__((__packed__)) OvmfSevMetadataOffset {
> +    uint32_t offset;
> +} OvmfSevMetadataOffset;
> +
> +static void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
> +{
> +    OvmfSevMetadata     *metadata;
> +    OvmfSevMetadataOffset  *data;
> +
> +    if (!pc_system_ovmf_table_find(OVMF_SEV_META_DATA_GUID, (uint8_t **)&data,
> +                                   NULL)) {
> +        return;
> +    }
> +
> +    metadata = (OvmfSevMetadata *)(flash_ptr + flash_size - data->offset);
> +    if (memcmp(metadata->signature, "ASEV", 4) != 0) {
> +        return;
> +    }
> +
> +    ovmf_sev_metadata_table = g_malloc(metadata->len);
> +    memcpy(ovmf_sev_metadata_table, metadata, metadata->len);
> +}
>  
>  void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
>  {
> @@ -90,6 +115,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
>       */
>      memcpy(ovmf_table, ptr - tot_len, tot_len);
>      ovmf_table += tot_len;
> +
> +    /* Copy the SEV metadata table (if exist) */
> +    pc_system_parse_sev_metadata(flash_ptr, flash_size);
>  }

Can we move this call to x86_firmware_configure() @ pc_sysfw.c, and move sev
specific bits to somewhere to sev specific file?  We don't have to parse sev
metadata for non-SEV case, right?

We don't have to touch common ovmf file. It also will be consistent with tdx
case.  TDX patch series adds tdx_parse_tdvf() to x86_firmware_configure().

thanks,

>  
>  /**
> @@ -159,3 +187,8 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
>      }
>      return false;
>  }
> +
> +OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void)
> +{
> +    return ovmf_sev_metadata_table;
> +}
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fb1d4106e5..df9a61540d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -163,6 +163,32 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
>  #define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
>  
> +typedef enum {
> +    SEV_DESC_TYPE_UNDEF,
> +    /* The section contains the region that must be validated by the VMM. */
> +    SEV_DESC_TYPE_SNP_SEC_MEM,
> +    /* The section contains the SNP secrets page */
> +    SEV_DESC_TYPE_SNP_SECRETS,
> +    /* The section contains address that can be used as a CPUID page */
> +    SEV_DESC_TYPE_CPUID,
> +
> +} ovmf_sev_metadata_desc_type;
> +
> +typedef struct __attribute__((__packed__)) OvmfSevMetadataDesc {
> +    uint32_t base;
> +    uint32_t len;
> +    ovmf_sev_metadata_desc_type type;
> +} OvmfSevMetadataDesc;
> +
> +typedef struct __attribute__((__packed__)) OvmfSevMetadata {
> +    uint8_t signature[4];
> +    uint32_t len;
> +    uint32_t version;
> +    uint32_t num_desc;
> +    OvmfSevMetadataDesc descs[];
> +} OvmfSevMetadata;
> +
> +OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void);
>  
>  void pc_pci_as_mapping_init(MemoryRegion *system_memory,
>                              MemoryRegion *pci_address_space);
> -- 
> 2.25.1
> 
> 

-- 
Isaku Yamahata <isaku.yamahata@intel.com>

