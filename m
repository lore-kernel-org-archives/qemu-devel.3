Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7D1107BCE6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1B7G-00053O-VC; Fri, 13 Mar 2026 18:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B78-000529-3W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:36:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1w1B76-0008DQ-Er
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 18:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773441373; x=1804977373;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Z7pQW8DKXMe+G+RmoHK68v2gfs13yb7qXD+tyy1qm9c=;
 b=LOdh5vo0K/8xWN6T52CbNetMryZi/iM44YMewhrzl+CVAhKdIELh7tXS
 /SDytzOunjnXXTU1kUnViQfw5I+mRBR/ixTY78BR9JgO3nj5ujCBoqFaV
 3lZ3swoJZeruhrCG5X7asjDCMxEn9jh7Rz5hzObG/JG77BWZI6x2dDOIy
 mdwzrOY0AeCug3j/l1CpuUnpZ4ZwIbHaKph8OBBnsTWoPlOPgnox8r9yu
 Z/HHziB/UozJtCErwNiLvcvSfs+5QTt3m3yk7jn2UKynwC5ewECvxa3Pp
 anKGn/dYYnm6WN4I60LyztDzzTDgZnPSgOcXvPDuBvza09nuVuVVOLFzE Q==;
X-CSE-ConnectionGUID: 40j0uSIfQOWcKWu2lA/Pmw==
X-CSE-MsgGUID: n8s49g1fQQ67IzDm04/FNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="91936075"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="91936075"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:36:12 -0700
X-CSE-ConnectionGUID: BILnOAAwSWCHU1PTlsMOyw==
X-CSE-MsgGUID: HUiInjwJSPKkemgp8+u6ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="221375413"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.205])
 ([10.241.240.205])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 15:36:11 -0700
Message-ID: <2b92a4c1-fadb-4672-ba76-e3a15572dc3c@intel.com>
Date: Fri, 13 Mar 2026 15:36:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/21] target/i386: detect user provided lbr-fmt via
 property flag
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-21-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260210032348.987549-21-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/9/2026 7:23 PM, Zhao Liu wrote:
> At present, QEMU determines if the user has set the "lbr-fmt" property
> by checking if its value differs from a special value,
> `~PERF_CAP_LBR_FMT` (`~0x3f`).
> 
> Relying on such a magic number to distinguish user input from the
> default state is implicit and fragile. It also prevents the helper macro
> `DEFINE_PROP_UINT64_CHECKMASK` from supporting a *valid* default value,
> as initializing the property with a valid default would make it
> impossible to distinguish from a user-provided value.
> 
> With the introduction of `OBJ_PROP_FLAG_USER_SET`, it's possible to
> directly check this flag to determine whether the user has modified the
> property, which can help get rid of invalid "sentinel" value.
> 
> Therefore, detect user-provided value by checking the USER_SET property
> flag in x86_cpu_realizefn(). The invalid initialization value will be
> dropped in subsequent work.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a594747f0030..a6d943c53a3f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9779,6 +9779,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      CPUX86State *env = &cpu->env;
>      Error *local_err = NULL;
>      unsigned requested_lbr_fmt;
> +    int lbr_fmt_set;
>  
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      /* Use pc-relative instructions in system-mode */
> @@ -9815,7 +9816,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
>       * with user-provided setting.
>       */
> -    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
> +    lbr_fmt_set = object_property_check_flags(OBJECT(dev), "lbr-fmt",
> +                                              OBJ_PROP_FLAG_USER_SET, errp);
> +    if (lbr_fmt_set < 0) {

lbr_fmt_set will never be -1.  How about remove the "< 0" case and hence
the variable lbr_fmt_set can be removed. Simpler code.

> +        return;
> +    } else if (lbr_fmt_set > 0) {
>          env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
>          env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
>      }


