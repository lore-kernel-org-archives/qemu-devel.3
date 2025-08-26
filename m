Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03557CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 07:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqo2Z-0007UR-Q5; Tue, 26 Aug 2025 03:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqo2X-0007TQ-0T; Tue, 26 Aug 2025 03:24:21 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqo2N-0004AL-Aw; Tue, 26 Aug 2025 03:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756193051; x=1787729051;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=llSjo8nqBIkCJDd83C0RW/c+eMmDrETs5JJkZ/VtjTU=;
 b=TG+AtMhLPyCE63/TYjaqf6SMc+cZXLYeWkZsZ/4mo6mmtFjsuFVgMaZv
 4LMWfCadgd2WoXDTtfCLZp5UqO9v8YySuORZEwq3M97EpqKG0sMxfqpvc
 IOeJ/YNHLrK80G6ngCcmHOpTaE7zmmwXY8TJqsmXmLgCHvKSgrObXMKUH
 9ZY5Ok4+9eFkqy8/OGhlqRX1vqBZJpk96n2Hk3OZpVchuXtSfPE1LqISP
 XY0gsM9i3dtcs7fpmqUjY07isYg8wfoKMckVtxaIHA2SxTyHl4h9A86qs
 KpJly8S8iP6cv2M/Tl01KF9fdNDjU7ede+I6+3c+KNIL+l9WrfsXE0q0+ g==;
X-CSE-ConnectionGUID: p4ewagIMRHiSKdA7Gxv1Hw==
X-CSE-MsgGUID: xyJ/XYWISwehVu1om8Ao5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58127798"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58127798"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:23:56 -0700
X-CSE-ConnectionGUID: cTSK7sqHQnaQxrFqGsB5wQ==
X-CSE-MsgGUID: L4ljTm+pSaWGPZp9CI2IBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173690384"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 00:23:46 -0700
Date: Tue, 26 Aug 2025 15:45:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com,
 mst@redhat.com, mtosatti@redhat.com, richard.henderson@linaro.org,
 riku.voipio@iki.fi, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, david@redhat.com, jjherne@linux.ibm.com,
 shorne@gmail.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peter.maydell@linaro.org,
 agraf@csgraf.de, mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de,
 dirty@apple.com, rbolshakov@ddn.com, phil@philjordan.eu,
 reinoud@netbsd.org, sunilmut@microsoft.com, gaosong@loongson.cn,
 laurent@vivier.eu, edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <aK1mHGan+n9NSAOk@intel.com>
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825171912.1bc7b841@fedora>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 25, 2025 at 05:19:12PM +0200, Igor Mammedov wrote:
> Date: Mon, 25 Aug 2025 17:19:12 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
>  helpers and use them tree wide
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
> 
> On Mon, 25 Aug 2025 23:28:22 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Hi Igor,
> >  
> > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > index 5eaf41a566..1dee9d4c76 100644
> > > --- a/include/hw/core/cpu.h
> > > +++ b/include/hw/core/cpu.h
> > > @@ -942,6 +942,31 @@ CPUState *cpu_by_arch_id(int64_t id);
> > >  
> > >  void cpu_interrupt(CPUState *cpu, int mask);
> > >  
> > > +/**
> > > + * cpu_test_interrupt:
> > > + * @cpu: The CPU to check interrupt(s) on.
> > > + * @mask: The interrupts to check.
> > > + *
> > > + * Checks if any of interrupts in @mask are pending on @cpu.
> > > + */
> > > +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> > > +{
> > > +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> > > +}
> > > +
> > > +/**
> > > + * cpu_set_interrupt:
> > > + * @cpu: The CPU to set pending interrupt(s) on.
> > > + * @mask: The interrupts to set.
> > > + *
> > > + * Sets interrupts in @mask as pending on @cpu.
> > > + */
> > > +static inline void cpu_set_interrupt(CPUState *cpu, int mask)
> > > +{
> > > +    qatomic_store_release(&cpu->interrupt_request,
> > > +        cpu->interrupt_request | mask);  
> > 
> > It seems the read access of cpu->interrupt_request is not atomic, should
> > we also protect it by qatomic_read(cpu->interrupt_request)? like
> > 
> > qatomic_store_release(&cpu->interrupt_request,
> >                       qatomic_read(cpu->interrupt_request) | mask)
> 
> it's not necessary according to doc:
> 
>   - ``qatomic_store_release()``, which guarantees the STORE to appear to           
>   happen, ...,                    
>   after all the LOAD or STORE operations specified before.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
> 
> that includes 'cpu->interrupt_request | mask' part

Yes, thanks for your explaination and patience.

> > 
> > or futher,
> > 
> > qatomic_fetch_or(&cpu->interrupt_request, mask)
> that would work as well  but it also could be more expensive than
> qatomic_store_release()

Behind this helper, I mainly considerred the case of multiple writers:

   thread 0      .        thread 1
                 .
load:  x         .
OR:    x | a     .
                 .
                 .      load:  x
                 .      OR:    x | b
                 .      store: x | b
                 .
store: x | a     .      (x | b is missed)

In the above case, "load" means the direct access:
cpu->interrupt_request w/o protection, and "store" is done by
qatomic_store_release.

The memory order is guaranteed, but the operation result of thread 1
seems lost. Only BQL or other mutex could avoid such case.

qatomic_store_release is already a great step to avoid issues outside
BQL, so I'm not sure if it's worth going further to ensure atomicity,
especifically for multiple writers (my initial understanding is that
iothread or callback may have multiple writers, but I'm also a bit
unsure.). The overhead is also indeed an issue.

Thanks,
Zhao


