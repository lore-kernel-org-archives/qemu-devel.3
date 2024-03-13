Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E5EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHfN-00069P-VG; Wed, 13 Mar 2024 02:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkHfE-00068z-Eo; Wed, 13 Mar 2024 02:00:32 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkHfA-00070S-D4; Wed, 13 Mar 2024 02:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710309629; x=1741845629;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PVsToUiCUiOhSzkdiRM4zUD+fdyiF34qLsiHYhQsYC4=;
 b=NxhHUwDnuxK9Twb5dAvsc/4ilkervYNghh2cDUqLEMKXhJBXw5OTSyX7
 FWHI1uCfH0rnUcVFEhaZ/ccxVe0nVWF46cZF1WQmYsYXoyqBdZUSfOu0i
 tBA2wKORViNni/YTFYnUBpGrtc1N5eXkqEykbPJp1mLmKzks5CEDogXS3
 tQ9U9ZJ1Z8uksv5DQHyfycoAwn1weJiRN8DtxPJ6uwTUA6qhPxLSjPFbp
 qyHAC97uMUTyc4IAyW+ZXWr7nivdK0NjaGjI0Dbz/nzVqKqxD1uGvOyS5
 jQUcGlmu2JhEfLbFCsgMhWc4aHRIEpt4AvNlWDAgqhY8l8DfUyuwRMlVo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16501385"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16501385"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 23:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16519824"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 12 Mar 2024 23:00:12 -0700
Date: Wed, 13 Mar 2024 14:14:02 +0800
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
 lixianglai@loongson.cn, linuxarm@huawei.com
Subject: Re: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <ZfFEKgpRiEOZo9xd@intel.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-4-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312020000.12992-4-salil.mehta@huawei.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

It seems my comment [1] in v7 was missed, but I still hit the same
issue. Pls let me paste the previous comment here again.

[1]: https://lore.kernel.org/qemu-devel/ZXCqp32ggIFvUweu@intel.com/

[snip]

> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>  }
>

I find this cpu_hotplug_hw_init() can still cause qtest errors (for v8)
on x86 platforms as you mentioned in v6:
https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net/T/#m108f102b2fe92b7dd7218f2f942f7b233a9d6af3

IIUC, microvm machine has its own 'possible_cpus_arch_ids' and that is
inherited from its parent x86 machine.

The above error is because device-introspect-test sets the none-machine:

# starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3094820.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3094820.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -machine none -accel qtest

So what about just checking mc->possible_cpu_arch_ids instead of an
assert in cpu_hotplug_hw_init()?

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 4b24a2500361..303f1f1f57bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -221,7 +221,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     const CPUArchIdList *id_list;
     int i;

-    assert(mc->possible_cpu_arch_ids);
+    if (!mc->possible_cpu_arch_ids) {
+        return;
+    }
+
     id_list = mc->possible_cpu_arch_ids(machine);
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);

This check seems to be acceptable in the general code path? Not all machines
have possible_cpu_arch_ids, after all.

Thanks,
Zhao


