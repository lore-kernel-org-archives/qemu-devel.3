Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8EECEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAq9-0001nc-TF; Tue, 08 Oct 2024 10:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syAq7-0001dO-6Z; Tue, 08 Oct 2024 10:05:27 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syAq4-0005p8-Na; Tue, 08 Oct 2024 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728396325; x=1759932325;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TFp0mPpSxqq/2y2H4/2NEB/BNEhUBDeWC98LUzcdMXY=;
 b=S3Es8VfriZtcqHgdzq/Eej1iwAfaWKDGCoSXa2pXEtWO4oPQK74lqc8g
 sfs1yyfUvY1oLh94IQxwg7QQ1BtifAaK3kt2F9VjjAlkipdxKlNG19+WF
 oIgbGYdEvDpXGFBhIjqJi54xRGdIbTpTcbQOsxYQYsf/MwFLOUwD2Hm/2
 tb15zmuQAx8/UDgQyFueAHyYXmJbTlMyspVoBLIL8dne8j6c+Yc3CrTrR
 6otkW1QoYCKTdt8vuIhSiGpjw5dkEeeaM2tICdLY/37eHT2Rn+kFUmEH2
 QBCJeRkIPiUVFMMxGOroTOErVwqIpRxNew9yVC7uLygqAQ2LhR4k7Eqyp g==;
X-CSE-ConnectionGUID: yEtLIBHQR+O3ChLSCNIHtw==
X-CSE-MsgGUID: IBiiE+TWSRCqTe7tsCd+Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45118654"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; d="scan'208";a="45118654"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 07:05:18 -0700
X-CSE-ConnectionGUID: ujiwutJaSy2tW/9h+ckrQw==
X-CSE-MsgGUID: FJeN987NRpWN/e4jY6hsiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; d="scan'208";a="80686769"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 08 Oct 2024 07:05:16 -0700
Date: Tue, 8 Oct 2024 22:21:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZwU/5yGEuwFlsMLJ@intel.com>
References: <20241008133326.26767-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008133326.26767-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Chuang,

Many thanks for the quick action! But we still need some more patience
to consider AMD case. (Cc Babu)

I just realized AMD and Intel have different definitions for this field...

On Tue, Oct 08, 2024 at 09:33:26PM +0800, Chuang Xu wrote:
> Date: Tue,  8 Oct 2024 21:33:26 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v5] i386/cpu: fixup number of addressable IDs for logical
>  processors in the physical package
> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
> 
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
> 
> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though threads-per-core should actually be 2.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> to solve the unexpected result.
> 
> In addition, we introduce max_thread_number_in_package() instead of
> using pow2ceil() to be compatible with smp and hybrid.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff227a8c5c..0749efc52c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6462,7 +6462,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;

... I checked AMD's APM: for AMD, this field is "Logical processor
count", not max addressable IDs number (pls refer APM, vol 3, E.3.2 and
E.5.1).

Then we need to check the vender here, like this (with a note of
explanation):

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff227a8c5c87..1f144b30e98e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * AMD requires logical processor count, but Intel needs maximum
+             * number of addressable IDs for logical processors per package.
+             */
+            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+                *ebx |= threads_per_pkg << 16;
+            } else {
+                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
+            }
+
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {

In addition, it's necessary to briefly mention the differences between
AMD and Intel for this field in the commit message, similar to my comment
example, and mention that the case you're comparing is on an Intel platform.

Thanks,
Zhao


