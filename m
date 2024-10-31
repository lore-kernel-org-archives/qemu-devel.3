Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5A7D767E2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Y7z-0003IO-74; Thu, 31 Oct 2024 12:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6Y7x-0003Hv-Pi
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:34:29 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6Y7v-0003cR-Fu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730392467; x=1761928467;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VfnEEUUhVdUUg7uJ4ZRBdXwR6X5yL6+HA2L8AeYb8So=;
 b=K7yT/W4h6SSS3D98868I4WcgSRtyP8+8d+Phk/o9vy4N90EKpHsS5Sf2
 589x3Mdbs+0SyZZuFDTNLfa9Tet/taTOlw+/XeBJSJpvQ1s+wPAUO1fWi
 2lRHBSfDEpn7smKkMIRCdgSUJ/xy4OPOBPGUxAW5XWoGa1fQwzYRusCQC
 Uu9pFR2/q0hdS6Y7sMylRhfN8Ug7g7QeIKu4aaY2BqfKo6Fh43g6ZFsdi
 nZnryVPuHtsMAAl6/pRai5/D/XdNDzGtQnrYvoWjO/SFxG6AolDtEWHy/
 T1AkkZDszWpovcEDLNYCgRZ/b6cXtb599WyNULDONrUHwAiYxx7hLJxXa A==;
X-CSE-ConnectionGUID: mwR1k+7tRL2XCMm0gBtndw==
X-CSE-MsgGUID: 6+EEmrTRTWyRuVAm0aN2Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29916930"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29916930"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 09:34:24 -0700
X-CSE-ConnectionGUID: t/09Yy58R/a3etlin0Dl0g==
X-CSE-MsgGUID: zGrpsy+RQ4id/SL677IEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="83106813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 31 Oct 2024 09:34:23 -0700
Date: Fri, 1 Nov 2024 00:52:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyO1vL0o0SxgcW8q@intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
 <20241031085233.425388-5-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031085233.425388-5-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> @@ -7578,7 +7607,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>          }
>      }
>  
> -    return x86_cpu_have_filtered_features(cpu);
> +    have_filtered_features = x86_cpu_have_filtered_features(cpu);
> +
> +    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +        x86_cpu_get_supported_cpuid(0x24, 0,
> +                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
> +        uint8_t version = ebx_0 & 0xff;
> +
> +        if (version < env->avx10_version) {
> +            if (prefix) {
> +                warn_report("%s: avx10.%d. Adjust to avx10.%d",
> +                            prefix, env->avx10_version, version);
> +            }
> +            env->avx10_version = version;
> +            have_filtered_features = true;
> +        }
> +    } else if (env->avx10_version && prefix) {
> +        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
> +        have_filtered_features = true;
> +    }

prefix is just used to print warning. So here we should check prefix
for warn_report.

+    } else if (env->avx10_version) {
+        if (prefix) {
+            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        }
+        have_filtered_features = true;
+    }

With this nit fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks.
Zhao



