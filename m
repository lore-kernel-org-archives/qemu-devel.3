Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1159C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWQ5-0006eo-CT; Mon, 27 May 2024 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBWPx-0006dk-BF; Mon, 27 May 2024 05:13:21 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBWPu-00017d-VU; Mon, 27 May 2024 05:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716801199; x=1748337199;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LsG0NLsb5plzK+avJgF7+hm1ZHCZyBHLoqlRGeaxzhw=;
 b=l/EyX8ozg94fE6tliowvGlWROiW+lH9RaiNQMzWrwM8VUyDpoqjQjPdc
 MiPwrHIHyaB8P1fuQISdFdJBEqzx/po3JntbL/hNNXZGRrpok/pcVopLD
 BlJdbC65Vpc1kQq41llBw23yI5mXVIfFKfbh//HyhwrUulayFNZo8yJj3
 v24LDdktLsVvLYclW05DJzMm8e7dtaPBNaZvpHYhSbNjdF1iJb/agXHN1
 q1EsZy5ppG5V8aKQ4qL5nncB+dEMbLIDt4QvCOtOnkQ7gfLMf9Ba6DGu/
 vx0kmjfcwrA5GjgAuEw1qffIzqbA3XSvgLzck6fWP6YsWRRSS6UQY4ftq g==;
X-CSE-ConnectionGUID: Kob8+NLqQGetW6SbAhBu8A==
X-CSE-MsgGUID: TFoaPSjDQWmjUVK310E/JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13331240"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="13331240"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 02:13:15 -0700
X-CSE-ConnectionGUID: n0LwNNVDRLSA5yHjI2bAxw==
X-CSE-MsgGUID: ToIL70hdRumgFncpPohcaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39673742"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 27 May 2024 02:13:07 -0700
Date: Mon, 27 May 2024 17:28:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com
Subject: Re: [PATCH V11 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <ZlRSPuJGBgyEUW6w@intel.com>
References: <20240522211111.232114-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522211111.232114-1-salil.mehta@huawei.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Wed, May 22, 2024 at 10:11:03PM +0100, Salil Mehta via wrote:
> Date: Wed, 22 May 2024 22:11:03 +0100
> From: Salil Mehta via <qemu-devel@nongnu.org>
> Subject: [PATCH V11 0/8] Add architecture agnostic code to support vCPU
>  Hotplug
> X-Mailer: git-send-email 2.34.1
> 
> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
> 
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> 3. ACPI CPUs AML code change [Patch 4,5]
> 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
> 5. Docs [Patch 8]
>

Ran QTESTs on x86 platform, now this series no longer breaks x86-related
tests, so,

Tested-by: Zhao Liu <zhao1.liu@intel.com>


