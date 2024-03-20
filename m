Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C6FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvLq-0003ri-Ge; Wed, 20 Mar 2024 08:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvLQ-0003dX-TU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:47:03 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmvLO-0000yf-AB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710938818; x=1742474818;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5Pc5otTiuaW1G2T2W/OHh2HBC5/VGR6g8aNIheIBxfg=;
 b=f3If4pRabaYuwdHYAajthoB6wpYwoEAZAqYWbO8YaCbeeEqSgInjzBSd
 KYorA3hLSqzFigufvW5TVkdE4H4XJnnTJ73m3M7ZohM4156ZNhDmaQov4
 Ir0azJjGomm5EI/VDyoX/4aXW/cadVvq/F/rcrQ6T9uKD8LATCPz57Hdy
 fYWHdaXmQT5RwKcifNyftLMh8VgoXsDa9dO6CPgRWjgMVW+RQ6defxDnW
 LSxaeDzWoXgJ2TLflxQHLqCt2GIgVx1QGvcGnlycXpXo6lQ+hJS2DKRDn
 7CH3pnjLIwpTXe2qm5rhyuigKsL1NC0uqV8BPGNsWRG9HwFqOHPuDCh12 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5980509"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5980509"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14785336"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 05:46:54 -0700
Message-ID: <e9def9a5-8669-4246-8c81-c4a0fe350051@intel.com>
Date: Wed, 20 Mar 2024 20:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/49] [FIXUP] "kvm: handle KVM_EXIT_MEMORY_FAULT":
 drop qemu_host_page_size
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-14-michael.roth@amd.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240320083945.991426-14-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/20/2024 4:39 PM, Michael Roth wrote:
> TODO: squash into "kvm: handle KVM_EXIT_MEMORY_FAULT"
> 
> qemu_host_page_size has been superseded by qemu_real_host_page_size()
> in newer QEMU, so update the patch accordingly.

I found it today as well when rebase to qemu v9.0.0-rc0.

Fix it locally, will show up on my next post of TDX-QEMU patches. :)

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   accel/kvm/kvm-all.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 2fdc07a472..a9c19ab9a1 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2912,8 +2912,8 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>       void *addr;
>       int ret = -1;
>   
> -    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
> -        !QEMU_PTR_IS_ALIGNED(size, qemu_host_page_size)) {
> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_real_host_page_size()) ||
> +        !QEMU_PTR_IS_ALIGNED(size, qemu_real_host_page_size())) {
>           return -1;
>       }
>   
> @@ -2943,7 +2943,7 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>           rb = qemu_ram_block_from_host(addr, false, &offset);
>   
>           if (to_private) {
> -            if (rb->page_size != qemu_host_page_size) {
> +            if (rb->page_size != qemu_real_host_page_size()) {
>                   /*
>                   * shared memory is back'ed by  hugetlb, which is supposed to be
>                   * pre-allocated and doesn't need to be discarded


