Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA14D5E146
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 12:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVUNR-0004E7-TK; Tue, 16 Dec 2025 07:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVUNQ-0004Dn-Bn
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 07:42:04 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVUNO-0007xy-Rv
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 07:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765888923; x=1797424923;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=i3WKu+1Mjb8Y7N9LC2TOJD63DnpmYnVPqbQ6XMBMJ2A=;
 b=ejnj9AaASqbxsnGDqjUOUwNdtkiYpYSbpG1wOaxrKC0twyq+IK/4ZnEm
 mi55YGQJ+7fKyMZgKxflqgYb9MWnjJpv4p15YeZ744usHUJF8qFXhbOVG
 FzBuTAnJIS6j/Q2W846zLWLSXH9iRsUqWoH8lqk6txNasAzTh/uvXp5lS
 U7hhJpoIt9ASd9CR4lF/WmBl6vhVU65OdXFxPaTlyZIhOYKW5yGL8wo43
 dgnYAs+Jj5djKvnS4MZx6wpvqQxEjw7/jlqYzHhFsVaCX7tEm6u4dgk7f
 akCNcKyx4+eo0njmTgOWnqe0DqyZFFOBeFSPyVqBtb05bbMulM1M0GS5K g==;
X-CSE-ConnectionGUID: M47MC/O6SA6YlejSbVdSLQ==
X-CSE-MsgGUID: V3JFPAZVTpmQRXZ5COc5bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78516028"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="78516028"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:42:00 -0800
X-CSE-ConnectionGUID: 72rDeK1YSRaPC5PzSyfGew==
X-CSE-MsgGUID: tnSLi3IgQlqXeRi8jPHoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="202198542"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:41:56 -0800
Message-ID: <76d1fec9-0bb4-43f3-a50a-c66f065fcb59@intel.com>
Date: Tue, 16 Dec 2025 20:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-2-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Hi Peter,

On 12/16/2025 4:51 AM, Peter Xu wrote:
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..3555d2f6f7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                          object_get_typename(OBJECT(current_machine->cgs)));
>               goto out_free;
>           }
> +
> +        if (!kvm_private_memory_attribute_supported()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: "
> +                       " KVM does not support private memory attribute",

There is one redundant blank space at the beginning since the previous 
line leaves one at the end.

Please help fix it. Thanks!

> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }
> +
>           assert(new_block->guest_memfd < 0);
>   
>           ret = ram_block_coordinated_discard_require(true);


