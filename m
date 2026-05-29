Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194B7CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwpC-0003oY-46; Fri, 29 May 2026 09:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSwow-0003la-Nk; Fri, 29 May 2026 09:00:21 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSwou-0000N7-5R; Fri, 29 May 2026 09:00:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE884444F7;
 Fri, 29 May 2026 13:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1C71F00893;
 Fri, 29 May 2026 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780059609;
 bh=ig5z6GvTcvtiouWzhZB2hwdFrrm6k/U19rfC10wc4is=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=b8vw+y4SdFWT8VnoECDZiWcxjHj9FtvQ4lDmgvbez6matOoW0ITHwMGLy0luh9oc1
 DM59iByfXQ2mxTt7x2/nrhM4zHgdIMOEwxH81gSrC9LFn/9cPqpCQBXygAzfxO3EkY
 5mD6+gVK0l+ZOJTXUmhz5zm67g5FrImeF73JFY/cJ83OzMplN6yqg+h8qY6HiQzdlm
 adKjB+4RIBZzqYbAj6gF0amwX89/f9feMJK4DgGrSrYL3zdpfrfKtu7yDFSA5WwPXK
 W0/XMcDor3xlVWiD/OUkfloRptM2+QCQfGk03IDYInneR0CehlkIJya8Vmpum73EA7
 rbsNLy3LcxycQ==
Date: Fri, 29 May 2026 14:00:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fan Ni
 <fan.ni@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] hw/cxl: Fix cxl_fmws_set_memmap() range check
Message-ID: <20260529140001.435eaebd@jic23-huawei>
In-Reply-To: <20260528-cxl-v1-1-a470c8255264@rsg.ci.i.u-tokyo.ac.jp>
References: <20260528-cxl-v1-1-a470c8255264@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 28 May 2026 21:24:05 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> cxl_fmws_set_memmap() leaves the zero-initialized base address of a CXL
> fixed window unchanged when it does not fit in the memory map, which
> results in incorrect mapping. Change the function to report an error
> instead.
> 
> The Arm virt machine passes the exclusive end of the memory map while
> the i386 pc machine passes the inclusive end to cxl_fmws_set_memmap().
> Change the i386 pc machine to pass the exclusive end and perform the
> range check accordingly in cxl_fmws_set_memmap().
Hi,


+CC linux-cxl as more folk there who might take a look at this.
(also my remove my dead huawei address)

What are the results of this on users?  Obviously the CFMWS doesn't
work, but how do they observe that.

Also seems like this is a fix and it can be a lot more minimal
(just one error_fatal use).

Jonathan


> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/hw/cxl/cxl_host.h |  2 +-
>  hw/arm/virt.c             |  6 +++---
>  hw/cxl/cxl-host-stubs.c   |  4 ++--
>  hw/cxl/cxl-host.c         | 12 +++++++-----
>  hw/i386/pc.c              | 12 ++++++------
>  5 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> index 21619bb748ab..ed34c3159f59 100644
> --- a/include/hw/cxl/cxl_host.h
> +++ b/include/hw/cxl/cxl_host.h
> @@ -16,7 +16,7 @@
>  void cxl_machine_init(Object *obj, CXLState *state);
>  void cxl_fmws_link_targets(Error **errp);
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
> +bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp);
>  void cxl_fmws_update_mmio(void);
>  GSList *cxl_fmws_get_all_sorted(void);
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b090233893c5..a22778575cfb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2536,9 +2536,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>      if (device_memory_size > 0) {
>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>      }
> -    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
> -                                                    256 * MiB),
> -                                           BIT_ULL(pa_bits)) - 1;
> +    vms->highest_gpa = ROUND_UP(vms->highest_gpa + 1, 256 * MiB);
> +    cxl_fmws_set_memmap(&vms->highest_gpa, BIT_ULL(pa_bits), &error_fatal);
> +    vms->highest_gpa--;

Hmm. The previous code kept the tight coupling of cxl_fmws_set_memmap()
returning an address that we then decremented as the value is inclusive.
This loses that clarity to my eyes.

Perhaps we now need a comment.

>  }
>  
>  static VirtGICType finalize_gic_version_do(const char *accel_name,
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index 9b515913ea4d..fa87cea0e8b9 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -11,9 +11,9 @@
>  void cxl_fmws_link_targets(Error **errp) {};
>  void cxl_machine_init(Object *obj, CXLState *state) {};
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
> +bool cxl_fmws_set_memmap(hwaddr *base, hwaddr max_addr, Error **errp)

Feels like a more minimal solution is to just use error_fatal() internally and
keep the original return of value.

>  {
> -    return base;
> +    return true;
>  };
>  void cxl_fmws_update_mmio(void) {};
>  
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index a94b893e9991..33421b3ca174 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -429,7 +429,7 @@ void cxl_fmws_update_mmio(void)
>      object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
>  }
>  
> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
> +bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp)

The cursor naming makes little sense to me. It is an address.
Also the rename to end doesn't seem to bring any more clarity over max_addr.
I guess maybe you did this because it's an exclusive value? I'm not sure end
conveys that any more than max_addr.


>  {
>      GSList *cfmws_list, *iter;
>      CXLFixedWindow *fw;
> @@ -437,14 +437,16 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>      cfmws_list = cxl_fmws_get_all_sorted();
>      for (iter = cfmws_list; iter; iter = iter->next) {
>          fw = CXL_FMW(iter->data);
> -        if (base + fw->size <= max_addr) {
> -            fw->base = base;
> -            base += fw->size;
> +        if (end - *cursor < fw->size) {
I'm not seeing why this form is an improvement on the original test.

> +            error_setg(errp, "A CXL fixed memory window does not fit in the memory map");

This bit I'm fine with!  Makes sense to error out as otherwise we get a rather
confusing result.

> +            return false;
>          }
> +        fw->base = *cursor;
> +        *cursor += fw->size;
>      }
>      g_slist_free(cfmws_list);
>  
> -    return base;
> +    return true;
>  }
>  
>  static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2ecad3c503fb..eadf37096533 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -747,7 +747,7 @@ void pc_memory_init(PCMachineState *pcms,
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>      hwaddr maxphysaddr, maxusedaddr;
> -    hwaddr cxl_base, cxl_resv_end = 0;
> +    hwaddr cxl_cursor = 0;
As above, I'm not sure how the cursor naming is useful. Its
an address so I'd expect naming to reflect that. To me base does
and cursor (which to me is typically the current position of an
iterator) does not.

>      X86CPU *cpu = X86_CPU(first_cpu);
>      uint64_t res_mem_end;
>  
> @@ -857,11 +857,11 @@ void pc_memory_init(PCMachineState *pcms,
>          MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
>          hwaddr cxl_size = MiB;
>  
> -        cxl_base = pc_get_cxl_range_start(pcms);
> +        cxl_cursor = pc_get_cxl_range_start(pcms);
>          memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
> -        memory_region_add_subregion(system_memory, cxl_base, mr);
> -        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
> -        cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
> +        memory_region_add_subregion(system_memory, cxl_cursor, mr);
> +        cxl_cursor = ROUND_UP(cxl_cursor + cxl_size, 256 * MiB);
> +        cxl_fmws_set_memmap(&cxl_cursor, maxphysaddr + 1, &error_fatal);
>          cxl_fmws_update_mmio();
>      }
>  
> @@ -892,7 +892,7 @@ void pc_memory_init(PCMachineState *pcms,
>      rom_set_fw(fw_cfg);
>  
>      if (pcms->cxl_devices_state.is_enabled) {
> -        res_mem_end = cxl_resv_end;
> +        res_mem_end = cxl_cursor;
>      } else if (machine->device_memory) {
>          res_mem_end = machine->device_memory->base
>                        + memory_region_size(&machine->device_memory->mr);
> 
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260528-cxl-d3bf91bac0c6
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> 


