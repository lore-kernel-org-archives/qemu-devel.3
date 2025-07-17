Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C70C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucM9j-0007kq-M9; Thu, 17 Jul 2025 06:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucM9c-0007hC-Ke
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:47:59 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ucM9a-0002QL-8J
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752749274; x=1784285274;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vYjlUOntGnmJAibyw1xm8s2fZs+pkxqH0hQWiB8zba0=;
 b=QrZXihflXvmNs5Gue+ERtSg6RMPDa5YyEeiorCoTEGPQqO0BTpe6yMxc
 O6ZAGn7jVzsgEVoPW98cbGDZslTucEafXOFMQSYTzygK1sLxL6M4baHgv
 pq5zwOA6gpsYKsa2mx3mZPAjO1vQ/WRVVEZHhl0X1qFVYXIE5pckfmEPE
 5kuRg5Xefgebc5BMBd05o0rSPtIp7YrvO2e2q/MVMlL/iZvXy1Lkr01Bf
 G/2AWgwWJNNZQndPt00SaM7ymbCtCzQpuAP57QegebuBfuGODEsIPc3hx
 jU7ZVIpbey6F+sB/9vXImxQHb6a+LGkAgEbz8G8j+MWgbmhRLu16iPIhd w==;
X-CSE-ConnectionGUID: EKVg4VXjRdy/Bamiezmtsg==
X-CSE-MsgGUID: JaUL3EpSTPWGpTorggiUFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65588998"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="65588998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:47:52 -0700
X-CSE-ConnectionGUID: mxZ6V3Y6QAWACtgHm16a2g==
X-CSE-MsgGUID: 3m95SUU5RkS7FXJ2700L2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="194896931"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 03:47:51 -0700
Message-ID: <48791f8d-0b24-4435-93bd-ceb4cf341919@intel.com>
Date: Thu, 17 Jul 2025 18:47:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: tdx: fix locking for interrupt injection
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250717103915.331309-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250717103915.331309-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/17/2025 6:39 PM, Paolo Bonzini wrote:
> Take tdx_guest->lock when injecting the event notification interrupt into
> the guest.
> 
> Fixes CID 1612364.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/kvm/tdx.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 7d69d6d7b06..7dcf2f75026 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -1126,10 +1126,15 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
>       return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
>   }
>   
> -static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
> +static void tdx_inject_interrupt(TdxGuest *tdx_guest)
>   {
>       int ret;
> +    uint32_t apicid, vector;
>   
> +    qemu_mutex_lock(&tdx_guest->lock);
> +    vector = tdx_guest->event_notify_vector;
> +    apicid = tdx_guest->event_notify_apicid;
> +    qemu_mutex_unlock(&tdx_guest->lock);
>       if (vector < 32 || vector > 255) {
>           return;
>       }
> @@ -1179,8 +1184,7 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
>           error_report("TDX: get-quote: failed to update GetQuote header.");
>       }
>   
> -    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
> -                         tdx_guest->event_notify_vector);
> +    tdx_inject_interrupt(tdx);
>   
>       g_free(task->send_data);
>       g_free(task->receive_buf);


