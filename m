Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7930C0218B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 01:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taPnD-0002yM-HO; Tue, 21 Jan 2025 20:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPnB-0002xu-EP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:29 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1taPn7-0005KT-PL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737510266; x=1769046266;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=alIalLH68/jG+o9wk2iihHEZ8Qcb6kiESOkjA8J4pF8=;
 b=DQiTTKcJy8W5w6GnspShEBYtLu879DSSt0g8ylIox7PKtT46HiFEm7Bl
 LpOznGJmR+lVUhMMFo0xkVW8LSOfIiKNsmpf77/iwrNrvtRwGKzrQG0sN
 1GKQKaZaoQ6eGWuHvrUDizUrKcTj/QJfMVTsC+cl5xn/7YCSFycoBZHTM
 k+Qu9rtITrA2oJUw+BuON3xmGC15QWmJGsHmf19qMNHy6eLBGvm2xjfBU
 DIqVpuHAgcgNmpDBQCuif36a7LwaiypkHgBN/8uJqIZi44P5oE+aYG08d
 8d+ZBz03ucl2D3fnRJ8+vpUACie+YNcpDJltOKF7blHCQZJehbw0yeTIh Q==;
X-CSE-ConnectionGUID: OVrluVSkQVGpXbFDtQ6qmA==
X-CSE-MsgGUID: zS7dWONnRsSi0vv5PdMHEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38203937"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="38203937"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:24 -0800
X-CSE-ConnectionGUID: dN+Q1Cf6QmyIndZKimn/dw==
X-CSE-MsgGUID: xu3EERF5S7OAHQwoStqAFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="107590234"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:44:22 -0800
Message-ID: <42f553b4-4f52-4584-8944-23e4689f0197@intel.com>
Date: Wed, 22 Jan 2025 09:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: Export BHI_NO bit to guests
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, zhao1.liu@linux.intel.com,
 xuelian.guo@intel.com
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-3-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250121020650.1899618-3-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 1/21/2025 10:06 AM, Tao Su wrote:
> Branch History Injection (BHI) is a CPU side-channel vulnerability, where
> an attacker may manipulate branch history before transitioning from user
> to supervisor mode or from VMX non-root/guest to root mode. CPUs that set
> BHI_NO bit in MSR IA32_ARCH_CAPABILITIES to indicate no additional
> mitigation is required to prevent BHI.
> 
> Make BHI_NO bit available to guests.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6db8d6c9ba..33fb27a611 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1364,7 +1364,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "taa-no", NULL, NULL, NULL,
>               NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
>               NULL, "fb-clear", NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "bhi-no", NULL, NULL, NULL,
>               "pbrsb-no", NULL, "gds-no", "rfds-no",
>               "rfds-clear", NULL, NULL, NULL,
>           },


