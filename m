Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60EC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIDh-00010V-VE; Thu, 04 Jul 2024 04:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1sPIDg-00010I-31
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:53:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1sPIDd-0003SU-Qs
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720083214; x=1751619214;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+lF34JGBkAdyt9HCQOqpXFiCvpqwRAf+cHBgPF+ZnVU=;
 b=Lwyf3k7/1bu1FJHbYOmVDUm5kFQbRgJbPx0x8snyL7dHcvjt56oBVIHz
 g0QkXk8MImqcL6HOLNobTipZt5SlCFKxe9Zcnzttx1xffO91Hh+ouqZZU
 pQSUxm12lH7BSjZ0162ir53i9vxF8HCMepisRjh9vmtxvSebuggIAkc6E
 xQzXDl26Jh0ZT2Y/u3q2n1UEhyMi534978nOAhzdcpi+fL/a5MAl0pJZv
 jYT5k/xoIamA55c/8tlZU1h1Ae4VqDrpL3Om7V1Eycm1VRbBlcEFN9jwE
 xsc4nbzEY6Dpdw8GUitWZtjMuP02iwHxpnWUZDpMrjds84Yk773FpG55Z w==;
X-CSE-ConnectionGUID: eh+1AQpCRUio2+5zeqweAQ==
X-CSE-MsgGUID: ORIrxiGSSFWHgnqhwWnSzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="12390395"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="12390395"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:53:29 -0700
X-CSE-ConnectionGUID: /KZ/JQjzTZymZwam7D3/NQ==
X-CSE-MsgGUID: 1IoHEw6XTUS8aKcV3xujdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46486287"
Received: from chungegx-mobl1.ccr.corp.intel.com (HELO [10.238.1.52])
 ([10.238.1.52])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:53:26 -0700
Message-ID: <d25cc62c-0f56-4be2-968a-63c8b1d63b5a@linux.intel.com>
Date: Thu, 4 Jul 2024 16:53:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/31] i386/kvm: Add KVM_EXIT_HYPERCALL handling for
 KVM_HC_MAP_GPA_RANGE
To: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, dovmurik@linux.ibm.com, armbru@redhat.com,
 michael.roth@amd.com, xiaoyao.li@intel.com, pbonzini@redhat.com,
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com,
 kvm@vger.kernel.org, anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-31-pankaj.gupta@amd.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20240530111643.1091816-31-pankaj.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

[...]
> +/*
> + * Currently the handling here only supports use of KVM_HC_MAP_GPA_RANGE
> + * to service guest-initiated memory attribute update requests so that
> + * KVM_SET_MEMORY_ATTRIBUTES can update whether or not a page should be
> + * backed by the private memory pool provided by guest_memfd, and as such
> + * is only applicable to guest_memfd-backed guests (e.g. SNP/TDX).
> + *
> + * Other other use-cases for KVM_HC_MAP_GPA_RANGE, such as for SEV live
            ^
            extra "other"?
> + * migration, are not implemented here currently.
> + *
> + * For the guest_memfd use-case, these exits will generally be synthesized
> + * by KVM based on platform-specific hypercalls, like GHCB requests in the
> + * case of SEV-SNP, and not issued directly within the guest though the
> + * KVM_HC_MAP_GPA_RANGE hypercall. So in this case, KVM_HC_MAP_GPA_RANGE is
> + * not actually advertised to guests via the KVM CPUID feature bit, as
> + * opposed to SEV live migration where it would be. Since it is unlikely the
> + * SEV live migration use-case would be useful for guest-memfd backed guests,
> + * because private/shared page tracking is already provided through other
> + * means, these 2 use-cases should be treated as being mutually-exclusive.
> + */
> +static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
> +{
> +    uint64_t gpa, size, attributes;
> +
> +    if (!machine_require_guest_memfd(current_machine))
> +        return -EINVAL;
> +
> +    gpa = run->hypercall.args[0];
> +    size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
> +    attributes = run->hypercall.args[2];
> +
> +    trace_kvm_hc_map_gpa_range(gpa, size, attributes, run->hypercall.flags);
> +
> +    return kvm_convert_memory(gpa, size, attributes & KVM_MAP_GPA_RANGE_ENCRYPTED);

run->hypercall.ret should be updated accordingly.
At least for successful case.
For failure case, QEMU will shutdown the VM, is it the expected behavior?


> +}
> +
> +static int kvm_handle_hypercall(struct kvm_run *run)
> +{
> +    if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
> +        return kvm_handle_hc_map_gpa_range(run);
> +
> +    return -EINVAL;
> +}
> +
>
[...]

