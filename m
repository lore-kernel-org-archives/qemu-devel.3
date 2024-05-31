Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBEEC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 06:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCvYI-0005HE-G0; Fri, 31 May 2024 02:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCvYG-0005EU-5D; Fri, 31 May 2024 02:15:44 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCvY9-000797-Jy; Fri, 31 May 2024 02:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717136137; x=1748672137;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dbWz0roPC+BiDonfeRkP5l6XQe7KEue07Rbsj182rlM=;
 b=fHe7SwK528NtiVhgFuG/dox6y3XfH77DMyiCMn4+FmrlWUiH6q74dueO
 dBYS/qh34JMdYS2e/IP3mv6WpPpufmbnFYgJ7KtJu9A831hO2eDX5gGoD
 DXt3hUPANd4VK06Gfje5Kq0Xt6aQV1XeYLa3uOtwRPTuJNXJK39tnpXg3
 g5Z8XfB9MQe1TqhQgiWnnjMDicZ6Y7bV9GD3NNOGfnXdMkCskFdx3Q28d
 CknB9iJeoBmUdbElCY7bz1q8dTbOU7TAwHrdtqWZSfFAc4f901V9j4sKz
 MTBNMmIKVvk52M7au34Nb81JQY4c5lKF+7uT48Lj11zhiZnui9GvZ2gbv w==;
X-CSE-ConnectionGUID: d6HAp9kxS+SGg3MDQTwmpg==
X-CSE-MsgGUID: eOPi0JzHRJm+bUe46rTEsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17511251"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; d="scan'208";a="17511251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 23:15:34 -0700
X-CSE-ConnectionGUID: dYu3fxnDS8edpainkQageQ==
X-CSE-MsgGUID: IAJDmtMNSw+bm9noxAKb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; d="scan'208";a="40984128"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 30 May 2024 23:15:32 -0700
Date: Fri, 31 May 2024 14:30:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
Message-ID: <ZlluoKXUF6ctecVt@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524200017.150339-3-zide.chen@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zide,

On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:
> Date: Fri, 24 May 2024 13:00:16 -0700
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
>  x86_cpu_filter_features
> X-Mailer: git-send-email 2.34.1
> 
> cpu_exec_realizefn which calls the accel-specific realizefn may expand
> features.  e.g., some accel-specific options may require extra features
> to be enabled, and it's appropriate to expand these features in accel-
> specific realizefn.
> 
> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
> 
> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
> that it won't expose features not supported by the host.
> 
> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  target/i386/cpu.c         | 24 ++++++++++++------------
>  target/i386/kvm/kvm-cpu.c |  1 -
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bc2dceb647fa..a1c1c785bd2f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    /*
> +     * note: the call to the framework needs to happen after feature expansion,
> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
> +     * These may be set by the accel-specific code,
> +     * and the results are subsequently checked / assumed in this function.
> +     */
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);

For your case, which sets cpu-pm=on via overcommit, then
x86_cpu_filter_features() will complain that mwait is not supported.

Such warning is not necessary, because the purpose of overcommit (from
code) is only to support mwait when possible, not to commit to support
mwait in Guest.

Additionally, I understand x86_cpu_filter_features() is primarily
intended to filter features configured by the user, and the changes of
CPUID after x86_cpu_filter_features() should by default be regarded like
"QEMU knows what it is doing".

I feel adding a check for the CPUID mwait bit in host_cpu_realizefn()
is enough, after all, this bit should be present if host supports mwait
and enable_cpu_pm (in kvm_arch_get_supported_cpuid()).

Thanks,
Zhao


