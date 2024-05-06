Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC12C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3u4q-0002Y2-VJ; Mon, 06 May 2024 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3u4i-0002Ui-DP; Mon, 06 May 2024 04:51:57 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3u4f-0004cJ-VB; Mon, 06 May 2024 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714985514; x=1746521514;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xl9SAidf/IAvag53ZON+iKmnnx/oQRppsBE+55au41E=;
 b=FbFJ0CXftIzsy5HOq/3VHO/1431DMSn8UJUJGl6IRMcu+QzEyeX3fhOh
 LBY/1eXTwYjQUr41WojzSyUPHRfXzTuD8+oUbNxDc/2xykuCC6tY+QmmP
 ssQB+MQKWsP+yyANY/1sQyzDcC6RzBxRNIUd+xaNT0WZeSzXuA3L9IILy
 361vnyMhAo3o3FZIGCwQOOz6Mtp7SckG3e/L6RrEhm6e0DH7Ci/OC9ccB
 GIexfcjt+WA1Ed0syDTYlC5g5jCutVCp6za2Jjc/+wZxyPJAU1vlM8zDL
 sqIZwj2VKg9uSFTw8Cebl768/RGkbV3ldxJVcTpZrLpFjyRPWHRScbJ4C w==;
X-CSE-ConnectionGUID: 6DF3CwGaRqClrcr78fV3hw==
X-CSE-MsgGUID: BGWIDw7zRmmfBy+twrnaSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10599849"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10599849"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:51:49 -0700
X-CSE-ConnectionGUID: Spa7drKlSsWej+cuhfs7Qw==
X-CSE-MsgGUID: bPUX185UTb+qdDp+mHCIWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="32581742"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 06 May 2024 01:51:41 -0700
Date: Mon, 6 May 2024 17:05:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <ZjidcX8p1ERW276J@intel.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-4-salil.mehta@huawei.com>
 <ZfFEKgpRiEOZo9xd@intel.com>
 <6acc5b10128d431ca8bfa26ec45ae0f6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acc5b10128d431ca8bfa26ec45ae0f6@huawei.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Salil,

On Fri, May 03, 2024 at 07:59:32PM +0000, Salil Mehta wrote:
> Date: Fri, 3 May 2024 19:59:32 +0000
> From: Salil Mehta <salil.mehta@huawei.com>
> Subject: RE: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support
>  vCPU Hotplug
> 
> Hello,
> 
> Sorry, I missed this earlier.
>
> >  From: Zhao Liu <zhao1.liu@intel.com>
> >  Sent: Wednesday, March 13, 2024 6:14 AM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  Hi Salil,
> >  
> >  It seems my comment [1] in v7 was missed, but I still hit the same issue. Pls
> >  let me paste the previous comment here again.
> >  
> >  [1]: https://lore.kernel.org/qemu-devel/ZXCqp32ggIFvUweu@intel.com/
> 
> Yes, I have this in my mind. 
> 
> >  
> >  [snip]
> >  
> >  > @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
> >  >      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
> >  >                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
> >  >      sysbus_init_mmio(sbd, &ged_st->regs);
> >  > +
> >  > +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp
> >  container",
> >  > +                       ACPI_CPU_HOTPLUG_REG_LEN);
> >  > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> >  > +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> >  > +                        &s->cpuhp_state, 0);
> >  >  }
> >  >
> >  
> >  I find this cpu_hotplug_hw_init() can still cause qtest errors (for v8) on x86
> >  platforms as you mentioned in v6:
> >  https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-
> >  820f4a254607@opnsrc.net/T/#m108f102b2fe92b7dd7218f2f942f7b233a9d6a
> >  f3
> >  
> >  IIUC, microvm machine has its own 'possible_cpus_arch_ids' and that is
> >  inherited from its parent x86 machine.
> >  
> >  The above error is because device-introspect-test sets the none-machine:
> >  
> >  # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-
> >  3094820.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-
> >  3094820.qmp,id=char0 -mon chardev=char0,mode=control -display none -
> >  audio none -nodefaults -machine none -accel qtest
> >  
> >  So what about just checking mc->possible_cpu_arch_ids instead of an
> >  assert in cpu_hotplug_hw_init()?
> >  
> >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
> >  4b24a2500361..303f1f1f57bc 100644
> >  --- a/hw/acpi/cpu.c
> >  +++ b/hw/acpi/cpu.c
> >  @@ -221,7 +221,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as,
> >  Object *owner,
> >       const CPUArchIdList *id_list;
> >       int i;
> >  
> >  -    assert(mc->possible_cpu_arch_ids);
> >  +    if (!mc->possible_cpu_arch_ids) {
> >  +        return;
> >  +    }
> >  +
> 
> 
> Yes, we can do this with some debug print or trace maybe.

Here it is just to return early without touching mc->possible_cpu_arch_ids().
If you adopt this workaround, then in the meantime I suggest adding a comment
to this "if" to clarify that it is for compatibility with certain machines
that do not implement mc->possible_cpu_arch_ids().
 
> >       id_list = mc->possible_cpu_arch_ids(machine);
> >       state->dev_count = id_list->len;
> >       state->devs = g_new0(typeof(*state->devs), state->dev_count);
> >  
> >  This check seems to be acceptable in the general code path? Not all
> >  machines have possible_cpu_arch_ids, after all.
> 
> True. BTW, have you tested this with Qtest?

Yes, by "make check" on x86 platform. This workaround can help us pass
the x86 tests.

Regards,
Zhao


