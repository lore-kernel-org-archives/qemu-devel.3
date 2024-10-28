Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48434D33994
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RQ4-0005tp-0z; Mon, 28 Oct 2024 11:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RQ2-0005th-Ri
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:12:34 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t5RQ0-0008Pt-7T
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730128352; x=1761664352;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vQYxbEpeIAjs99MV8Tz53C6e0rZwCgsuxCLZvHwrvH4=;
 b=GMg/CgxMG851mMZVxvgmUa1UBgU6L/KFUpv9CK5n7IIgpwGOoLuY6fnd
 LT+xhx+dqZ6sXDmUwLhSRQXEScTQluXv39oTgcfnfwm6kB839UepWxTxM
 JzbpRoby8Bg0OcNRGTSp80tdZbcbS4YIXYHRKz1Gs9p/UFrKW2ZUw5eFT
 kNBVB5sel13vM+C55uE3weBsEGGzp2DvS7YBSNaXWh4Zk2zonQtveX6qf
 Hz0IDt0tg31o79NkgKpyPpu0mx7Jhg0UUVZMD3ihAPVH25BHcmcE8ZppE
 yFvHT8K6Ta7QftFPxMEpjJznVt8zgUhJdjHDFcKgyAVarjS+PZrumdzDn A==;
X-CSE-ConnectionGUID: u1ynhfNwSbeWjYcY8fsJ+Q==
X-CSE-MsgGUID: vDyktSOGQbeViOZWFAV7+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29187912"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="29187912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:10:50 -0700
X-CSE-ConnectionGUID: ZSYmD1y5SdSOcoPu0KDcqg==
X-CSE-MsgGUID: RwuntT19RGyhGedGDhe0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; d="scan'208";a="81750735"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.172])
 ([10.124.227.172])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 08:10:48 -0700
Message-ID: <65cd917f-b0d2-40f3-9818-a52b340b32e6@intel.com>
Date: Mon, 28 Oct 2024 23:10:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/i386: add avx10-version property
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-3-tao1.su@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241028024512.156724-3-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.782, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/28/2024 10:45 AM, Tao Su wrote:
> Introduce avx10-version property so that avx10 version can be controlled
> by user and cpu model. Per spec, avx10 version can never be 0, the default
> value of avx10-version is set to 0 to determine whether it is specified by
> user.

I think it's better to merge this patch into next one. It's intact to 
show how avx10_version is supposed to work.

> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>   target/i386/cpu.c | 1 +
>   target/i386/cpu.h | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d845ff5e4e..5b434a107a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8343,6 +8343,7 @@ static Property x86_cpu_properties[] = {
>       DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
>       DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
>       DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
> +    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
>       DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
>       DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>       DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 280bec701c..d845384dcd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1920,6 +1920,8 @@ typedef struct CPUArchState {
>       uint32_t cpuid_vendor3;
>       uint32_t cpuid_version;
>       FeatureWordArray features;
> +    /* AVX10 version */
> +    uint8_t avx10_version;
>       /* Features that were explicitly enabled/disabled */
>       FeatureWordArray user_features;
>       uint32_t cpuid_model[12];


