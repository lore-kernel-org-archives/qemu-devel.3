Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR50U-00038m-L4; Fri, 27 Dec 2024 02:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR50I-00038H-MC
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:43:26 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR50E-0008Ks-1Y
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735285403; x=1766821403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zEBzQLLSMNLM8P7ykZJel66rBbFjyKWYgf/S3S26AFo=;
 b=jzIk8ho3Djd2bAhyc8XXWSO2WLJRz04Wcrrxf9J5KTOFnLA4Kzk3EYFR
 iOVdvHu/eFuMnVu8y7EaEEkdSnTVGNJsAuV+jOZIS1eYD4gOAxXjbQSMf
 sjUqnhIOFiCiroZmKO5NSvkSZ605EpfMcq7wT6yv+tgrvw28QBVOUhNIj
 p8xQxWN/60wM4/9267otyvnkmoLExewMmIgpTn9tXlqY0G1mEsq6ddyXK
 Lvnl4R/RtX/idvhz2oDX4dKbdsTm12zcch3eEFynFdMPYsuq6NaGDhXPU
 4fRv+tLdxV8ndF/5n9CYGVWUCmv0lqqdWPwV4B1/KXMqJ3ytEEUQyapDC w==;
X-CSE-ConnectionGUID: o24eBknpQmSb2Wu5nfP63A==
X-CSE-MsgGUID: 1u7TFqN7QY+pmjhaFvVfOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46689259"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="46689259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:43:19 -0800
X-CSE-ConnectionGUID: S5M22e3pTNW1/ZFARRf5SA==
X-CSE-MsgGUID: YWd7+OXTQFyJN0U5rF20KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="99952043"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 26 Dec 2024 23:43:16 -0800
Date: Fri, 27 Dec 2024 16:01:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 06/10] i386/cpu: Track a X86CPUTopoInfo directly in
 CPUX86State
Message-ID: <Z25e982iFtTovEs/@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-7-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-7-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

> @@ -8165,9 +8157,6 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>  
> -    env->nr_modules = 1;
> -    env->nr_dies = 1;
> -

Instead, initialize topo_info?

>      /* thread, core and socket levels are set by default. */
>      set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);

