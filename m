Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D08CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwii-0007QZ-R9; Fri, 12 Sep 2025 01:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwid-0007QG-KR
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:53:12 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwib-0002nS-T8
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656390; x=1789192390;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=74QQHGNvfPET3KVxpI7c3jfT/5/3xbP22PmvT+Ykefk=;
 b=GTN+QxunJHK4G+TVCsEpoWOIw3+r+3tBto+hNZCnyPIPlJ8cWJORsaoI
 3IjWirQMdb4p4QgmmOKF+tYDIbJrjNu3UGMEMMlYYUPAwqJ85Qq829gnQ
 OIosahWyqFKlpxMhI8IPkIVeyAEZAIDGfyZjkUFEEUX0KQgZMgQt3s6qH
 s6Gki/o0LxPJtScpCB4VYE9Yu6BKZLtitB/GliQOd/13Q1XS6pvKYR28O
 dieOylN6hm/KA3XM8o4NM2UwVCZMofJHSnLFkJ3EqvcQW45sVAlPASo+P
 k8EmNFpgY4drSJpXTBHhnOWDPBSyVaphJoxtgAT9nXCl8jDNAawnJiatZ A==;
X-CSE-ConnectionGUID: Ij7i8Y5ES220OQQ2/AqhLQ==
X-CSE-MsgGUID: nrVwGaNWQJa1IBftAxr2ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="85434632"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="85434632"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:53:08 -0700
X-CSE-ConnectionGUID: FVc3r3FDSIe8eDUx5f/2nQ==
X-CSE-MsgGUID: gD/wh6N/RA+mjOW7Sw+z9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="204878448"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:53:07 -0700
Message-ID: <e75197fe-9b58-425c-8bf8-092270a5c01d@intel.com>
Date: Fri, 12 Sep 2025 13:53:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tdx: Use .has_gpa field to check if the gpa is valid
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250710141512.170302-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250710141512.170302-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Gentle ping.

On 7/10/2025 10:15 PM, Xiaoyao Li wrote:
> There is actually the .has_gpa field when translating the QAPI data
> type GuestPanicInformationTdx to C structure.
> 
> Stop using the magic number -1 as the indicator for no valid gpa.
> Instead just use .has_gpa field.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   system/runstate.c     | 2 +-
>   target/i386/kvm/tdx.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index 38900c935a35..87cdcab4f388 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -690,7 +690,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>                             " error code: 0x%" PRIx32 " error message:\"%s\"\n",
>                             info->u.tdx.error_code, message);
>               g_free(message);
> -            if (info->u.tdx.gpa != -1ull) {
> +            if (info->u.tdx.has_gpa) {
>                   qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
>                                 "can be found at gpa page: 0x%" PRIx64 "\n",
>                                 info->u.tdx.gpa);
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 370a9b6e656c..14704eb523c5 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -1298,7 +1298,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>       uint64_t reg_mask = run->system_event.data[R_ECX];
>       char *message = NULL;
>       uint64_t *tmp;
> -    uint64_t gpa = -1ull;
> +    uint64_t gpa = 0;
>       bool has_gpa = false;
>   
>       if (error_code & 0xffff) {


