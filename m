Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D416C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EX6-00085V-Vx; Fri, 25 Apr 2025 04:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8EWz-00082f-K1; Fri, 25 Apr 2025 04:35:33 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8EWw-0001nb-MR; Fri, 25 Apr 2025 04:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745570131; x=1777106131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RwMNTg3WBWQ4a8WIx76dSHsYi7CDIjlLKh74S0G5rbQ=;
 b=T/Yj7Lg5q4oeLJERXoGmrqXl+nfnt/t/fr9hOHN1Emaz/7SM15Ktov5C
 Zz6iBuegh1R4O26wbmH1cL00e88Lxir5OyuzTeyp95S+tMvJ81OZa6pWR
 MKe/a4KfIywGHxVV8AyG9h/CG7Yx+EP8rJPn/ftOjwUQHHcWl+PPzeKHW
 kZWug683c8dFgoZOM4kgxNWMcD4qUOEZ6Mf1MqdMpFcmpIsQZYjCpEQ2c
 0oxeY6asrYtZbH56BXFtYSw/XxItevm0wRtnFdX5dOkwmWSKHa1ioVfl6
 2/RVf5DB59RW1shWbCHtpDFKVmJJibAUkbp3HV7DnolKPJ8i+bG+5dlT5 Q==;
X-CSE-ConnectionGUID: xFcDNXcBRE+dXNFmDmAfAg==
X-CSE-MsgGUID: HYmCwiU5Snm22pW8vaIsiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="64643809"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="64643809"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2025 01:35:26 -0700
X-CSE-ConnectionGUID: cqhfZVHdRK+lj3h0O7mKlQ==
X-CSE-MsgGUID: 419sEBXVT3GtDZNwsfRe7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="132730130"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 25 Apr 2025 01:35:12 -0700
Date: Fri, 25 Apr 2025 16:56:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com,
 kraxel@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v4 08/11] target/i386/kvm: query kvm.enable_pmu parameter
Message-ID: <aAtOKvlY+X8ERZ/S@intel.com>
References: <20250416215306.32426-1-dongli.zhang@oracle.com>
 <20250416215306.32426-9-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416215306.32426-9-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Wed, Apr 16, 2025 at 02:52:33PM -0700, Dongli Zhang wrote:
> Date: Wed, 16 Apr 2025 14:52:33 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v4 08/11] target/i386/kvm: query kvm.enable_pmu parameter
> X-Mailer: git-send-email 2.43.5
> 
> When PMU is enabled in QEMU, there is a chance that PMU virtualization is
> completely disabled by the KVM module parameter kvm.enable_pmu=N.
> 
> The kvm.enable_pmu parameter is introduced since Linux v5.17.
> Its permission is 0444. It does not change until a reload of the KVM
> module.
> 
> Read the kvm.enable_pmu value from the module sysfs to give a chance to
> provide more information about vPMU enablement.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v2:
>   - Rework the code flow following Zhao's suggestion.
>   - Return error when:
>     (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu)
> Changed since v3:
>   - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
>     suggestion.
>   - Rework the commit messages.
>   - Bring back global static variable 'kvm_pmu_disabled' from v2.
> 
>  target/i386/kvm/kvm.c | 61 +++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 17 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


