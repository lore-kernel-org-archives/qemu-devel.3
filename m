Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01338C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2O1-000539-UN; Fri, 14 Jun 2024 04:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sI2O0-000511-AP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:34:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sI2Nx-0004os-Fb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718354054; x=1749890054;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NC5NOlSne8d0qmG34/IP21rBACHo8yPr9eKqSZdP9mk=;
 b=Rug8DD+6bjDGoiquyIo09QQDlcLw81Y2mgIgvIhEHxNugC6xvHXFb96K
 dhmJNJNhg9HaMtqJyBGq1asjMKtQZ3L5umxoWmE/jtoeUuKyhlJSzHhyr
 dzH4oV8TvQtfcYJ1onGUYH6oEB/iBRg/LmCRPEBjEwb17m5CJyID6l41F
 F9duzNSn+L+QPodnF8/CXzUmaJ40WOPOitS/Kx2rS7q4y4k5VCKWi47cD
 UsYGbMKw/XWo0n7sl7m3ML1/qptS5SFMNCCzjvrsZrNWzLqRPG42uT0ZY
 jgkxubOUPPFfNHSetAlMpvX9bJNDfJV5YAAEbE9lOA9NY6q7pXBheZNNy Q==;
X-CSE-ConnectionGUID: XBsUTvyKSpG2uPLD9oEskQ==
X-CSE-MsgGUID: UOfzCKAeTvKfWChkEnFzag==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="26347434"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="26347434"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 01:34:10 -0700
X-CSE-ConnectionGUID: J62/y7vPS4CD01cPxopgww==
X-CSE-MsgGUID: Xo+hnqw9QCaM/x7I9GYzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; d="scan'208";a="45389342"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 01:34:07 -0700
Message-ID: <434b5332-a7fb-44e4-88f5-4ac93de9c09b@intel.com>
Date: Fri, 14 Jun 2024 16:34:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/31] hw/i386: Add support for loading BIOS using
 guest_memfd
To: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 michael.roth@amd.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, berrange@redhat.com, kvm@vger.kernel.org,
 anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-29-pankaj.gupta@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240530111643.1091816-29-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/30/2024 7:16 PM, Pankaj Gupta wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> When guest_memfd is enabled, the BIOS is generally part of the initial
> encrypted guest image and will be accessed as private guest memory. Add
> the necessary changes to set up the associated RAM region with a
> guest_memfd backend to allow for this.
> 
> Current support centers around using -bios to load the BIOS data.
> Support for loading the BIOS via pflash requires additional enablement
> since those interfaces rely on the use of ROM memory regions which make
> use of the KVM_MEM_READONLY memslot flag, which is not supported for
> guest_memfd-backed memslots.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>   hw/i386/x86-common.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index f41cb0a6a8..059de65f36 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -999,10 +999,18 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>       }
>       if (bios_size <= 0 ||
>           (bios_size % 65536) != 0) {
> -        goto bios_error;
> +        if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +                g_warning("%s: Unaligned BIOS size %d", __func__, bios_size);
> +                goto bios_error;
> +        }
> +    }
> +    if (machine_require_guest_memfd(MACHINE(x86ms))) {
> +        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
> +                                           bios_size, &error_fatal);
> +    } else {
> +        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
> +                               bios_size, &error_fatal);
>       }
> -    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
> -                           &error_fatal);
>       if (sev_enabled()) {
>           /*
>            * The concept of a "reset" simply doesn't exist for
> @@ -1023,9 +1031,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>       }
>       g_free(filename);
>   
> -    /* map the last 128KB of the BIOS in ISA space */
> -    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> -                      !isapc_ram_fw);
> +    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +        /* map the last 128KB of the BIOS in ISA space */
> +        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
> +                          !isapc_ram_fw);
> +    }

Could anyone explain to me why above change is related to this patch and 
why need it?

because inside x86_isa_bios_init(), the alias isa_bios is set to 
read_only while guest_memfd doesn't support readonly?

>       /* map all the bios at the top of memory */
>       memory_region_add_subregion(rom_memory,


