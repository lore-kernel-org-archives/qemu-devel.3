Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DB1C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 08:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp2bj-0002zt-BI; Tue, 26 Mar 2024 04:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp2bh-0002za-Q6
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:56:33 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rp2be-0004AI-Db
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 04:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711443390; x=1742979390;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MEogc2y9SVsZn/zlyU+PJ3ab+ax7hy4nWn69RJbvhsk=;
 b=O7f1XHiq/gmlf3pb6SINqyuA1T/CPP1qzTMKbVhnMW9YM7jaeCSzb4JT
 B/8D2g35mLTPWyrJrGXuCtOpqNEkoqV20cJxii/OARdqaWQECH0GbHRMf
 1BvCvGD8V+LbMnfedgx4Q8lYaH6dP/MG4N1NuwTZzypMLKxokzvu+Mq73
 3zkwCGd8uKKLYslupkz/L0OUOViwQzBJ4mNqCqMkmIwYipmKk7ttCEEQR
 U6bZwfGYp0zy2n/XCKlbABpjTMgBIYTlEP+P5UlZJbrqS0oLQqAvJ2GES
 IJf3PYqhRGiiQSyyuCoyYWcAyzO7E/E0LCkLQQKKBbWeUG9av5fWWTAss A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6418215"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6418215"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 01:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; d="scan'208";a="20373943"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7])
 ([10.124.224.7])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2024 01:56:26 -0700
Message-ID: <20f2b954-67ee-4c05-b4d3-687670028c79@intel.com>
Date: Tue, 26 Mar 2024 16:56:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/26] kvm/memory: Make memory type private by default if
 it has guest memfd backend
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-22-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240322181116.1228416-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/23/2024 2:11 AM, Paolo Bonzini wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> KVM side leaves the memory to shared by default, while may incur the

/s/while/which/

fix typo from myself.

> overhead of paging conversion on the first visit of each page. Because
> the expectation is that page is likely to private for the VMs that
> require private memory (has guest memfd).
> 
> Explicitly set the memory to private when memory region has valid
> guest memfd backend.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Message-ID: <20240320083945.991426-16-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 7fbaf31cbaf..56b17cbd8aa 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1430,6 +1430,16 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                       strerror(-err));
>               abort();
>           }
> +
> +        if (memory_region_has_guest_memfd(mr)) {
> +            err = kvm_set_memory_attributes_private(start_addr, slot_size);
> +            if (err) {
> +                error_report("%s: failed to set memory attribute private: %s\n",
> +                             __func__, strerror(-err));
> +                exit(1);
> +            }
> +        }
> +
>           start_addr += slot_size;
>           ram_start_offset += slot_size;
>           ram += slot_size;


