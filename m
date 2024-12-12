Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D08E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLnPM-0008J7-DH; Thu, 12 Dec 2024 12:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLnPK-0008Io-JA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:55:26 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLnPE-0000DQ-42
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734026120; x=1765562120;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WCauBqTZ+or2lrsOaY+8YEVqqP6EQVvDCkpfIihYUzo=;
 b=cPFo9tnpRI50nbd13bsTLZxTNjeSRX71Pg+A+Bgx7G8fiE9HfjWWN5MY
 OapFJXdCWUR/hA+RHjouuC5H6TKn8gjFJOvVUSmSknt3IGMcXSSUytI0r
 MPM+FkjQHdo9MCnNAaREF3gFUemT9ybUSv6Rm/N6GLFGSt3cdOwZyHC/f
 NQLGAwtBWIXiWRTii0eJ6wIMcPFY3BpLs+I1c6uvVjKXz9iZY9ID1B32N
 0X1aqXs7nd3CDHE0REy5QkyZr/66aUKtH5yxAJyyGZdn1J2Mcvavrasti
 +D2J9oLAVHz7Lcuqn/UKuTnrGJvYRJ8hQCxlmkI019kx2kxj60ggH0N+d A==;
X-CSE-ConnectionGUID: 3wTyCy/yRxqBDofJkSxLoQ==
X-CSE-MsgGUID: awbmnci9SxeSirVpfpI1CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34590993"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="34590993"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:55:17 -0800
X-CSE-ConnectionGUID: dzMcCecMSp+wxrLO8KOX5Q==
X-CSE-MsgGUID: hneBst+YQbutJ8arz2IQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="101328087"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:55:15 -0800
Date: Thu, 12 Dec 2024 11:55:13 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 19/60] i386/tdx: Parse TDVF metadata for TDX VM
Message-ID: <Z1sjgcTxgCpmFweY@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-20-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-20-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 05, 2024 at 01:23:27AM -0500, Xiaoyao Li wrote:
> After TDVF is loaded to bios MemoryRegion, it needs parse TDVF metadata.

This commit message is pretty thin.  I think this could be squashed back into
patch 18 and use the better justfication for the changes there.

Ira

> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/pc_sysfw.c         | 7 +++++++
>  target/i386/kvm/tdx-stub.c | 5 +++++
>  target/i386/kvm/tdx.c      | 5 +++++
>  target/i386/kvm/tdx.h      | 3 +++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ef80281d28bb..5a373bf129a1 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -37,6 +37,7 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  #include "sev.h"
> +#include "kvm/tdx.h"
>  
>  #define FLASH_SECTOR_SIZE 4096
>  
> @@ -280,5 +281,11 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
>          }
>  
>          sev_encrypt_flash(gpa, ptr, size, &error_fatal);
> +    } else if (is_tdx_vm()) {
> +        ret = tdx_parse_tdvf(ptr, size);
> +        if (ret) {
> +            error_report("failed to parse TDVF for TDX VM");
> +            exit(1);
> +        }
>      }
>  }
> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
> index b614b46d3f4a..a064d583d393 100644
> --- a/target/i386/kvm/tdx-stub.c
> +++ b/target/i386/kvm/tdx-stub.c
> @@ -6,3 +6,8 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>  {
>      return -EINVAL;
>  }
> +
> +int tdx_parse_tdvf(void *flash_ptr, int size)
> +{
> +    return -EINVAL;
> +}
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index d5ebc2430fd1..334dbe95cc77 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -338,6 +338,11 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      return 0;
>  }
>  
> +int tdx_parse_tdvf(void *flash_ptr, int size)
> +{
> +    return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
> +}
> +
>  static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
>  {
>      TdxGuest *tdx = TDX_GUEST(obj);
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index e5d836805385..6b7926be3efe 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -6,6 +6,7 @@
>  #endif
>  
>  #include "confidential-guest.h"
> +#include "hw/i386/tdvf.h"
>  
>  #define TYPE_TDX_GUEST "tdx-guest"
>  #define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
> @@ -30,6 +31,7 @@ typedef struct TdxGuest {
>      char *mrownerconfig;    /* base64 encoded sha348 digest */
>  
>      MemoryRegion *tdvf_mr;
> +    TdxFirmware tdvf;
>  } TdxGuest;
>  
>  #ifdef CONFIG_TDX
> @@ -40,5 +42,6 @@ bool is_tdx_vm(void);
>  
>  int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
>  void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
> +int tdx_parse_tdvf(void *flash_ptr, int size);
>  
>  #endif /* QEMU_I386_TDX_H */
> -- 
> 2.34.1
> 

