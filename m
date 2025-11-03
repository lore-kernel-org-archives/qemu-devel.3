Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9420ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtES-0003kh-DQ; Mon, 03 Nov 2025 07:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFtEI-0003iK-Rc; Mon, 03 Nov 2025 07:00:11 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vFtEA-0008AG-5g; Mon, 03 Nov 2025 07:00:10 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A3BxEKw024010
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Nov 2025 20:59:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wX/EAr9MBpwid2C1opk/j+bgbu4H3+7mhfaLpVRxrvY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762171155; v=1;
 b=I7AxSWraaePRZ/Rs4A/YFERii4cE4bYglfqNlp+0/pIZbGm9Ksfyekq1YYCwjQn0
 HnH8gJBxSY5s3Ew8T5tbs8GiYb2cyu6m0R/OdBpwfOwQPzPqP7BdpXTZ1ZRU2Buw
 U19FPnxwKAnih86t4NF0hDCHRFW+9jalxGEPXLy+n+bs7vaL0fUVMTyMlK8Hwoq5
 LneZBJrmrcujdg4FSofcInzKxbb0+yxqV6aMW3vRD4E8V2aQzELsAfZIJb0kMrWg
 7Z9c14TJTDegnES7VAZjoHz9qg4URSpkdVjTzybhztMXiwoZyVnkqinhr6JY1qDE
 XxKxtnD64/Z0CiHJT3kmhg==
Message-ID: <34fc930f-0ef1-42d6-9666-235ca88d9f91@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Nov 2025 20:59:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/23] accel/hvf: Simplify hvf_set_phys_mem
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Collingbourne <pcc@google.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20251103101034.59039-1-philmd@linaro.org>
 <20251103101034.59039-9-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251103101034.59039-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/03 19:10, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> All of the complicated parts of updating the address space
> are handled by address_space_update_topology_pass.
> Do not create or use hvf_slot structures.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-all.c | 111 +++++++-------------------------------------
>   1 file changed, 17 insertions(+), 94 deletions(-)
> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index f203a6251f0..76b8d4d4068 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -87,45 +87,16 @@ void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
>                        HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
>   }
>   
> -static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
> -{
> -    struct mac_slot *macslot;
> -    hv_return_t ret;
> -
> -    macslot = &mac_slots[slot->slot_id];
> -
> -    if (macslot->present) {
> -        if (macslot->size != slot->size) {
> -            macslot->present = 0;
> -            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
> -            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
> -            assert_hvf_ok(ret);
> -        }
> -    }
> -
> -    if (!slot->size) {
> -        return 0;
> -    }
> -
> -    macslot->present = 1;
> -    macslot->gpa_start = slot->start;
> -    macslot->size = slot->size;
> -    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
> -                     flags & HV_MEMORY_READ ?  'R' : '-',
> -                     flags & HV_MEMORY_WRITE ? 'W' : '-',
> -                     flags & HV_MEMORY_EXEC ?  'X' : '-');
> -    ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
> -    assert_hvf_ok(ret);
> -    return 0;
> -}
> -
>   static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
>   {
> -    hvf_slot *mem;
>       MemoryRegion *area = section->mr;
>       bool writable = !area->readonly && !area->rom_device;
>       hv_memory_flags_t flags;
>       uint64_t page_size = qemu_real_host_page_size();
> +    uint64_t gva = section->offset_within_address_space;
> +    uint64_t size = int128_get64(section->size);
> +    hv_return_t ret;
> +    void *mem;
>   
>       if (!memory_region_is_ram(area)) {
>           if (writable) {
> @@ -139,69 +110,28 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
>           }
>       }
>   
> -    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
> -        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
> +    if (!QEMU_IS_ALIGNED(size, page_size) ||
> +        !QEMU_IS_ALIGNED(gva, page_size)) {
>           /* Not page aligned, so we can not map as RAM */
>           add = false;
>       }
>   
> -    mem = hvf_find_overlap_slot(
> -            section->offset_within_address_space,
> -            int128_get64(section->size));
> -
> -    if (mem && add) {
> -        if (mem->size == int128_get64(section->size) &&
> -            mem->start == section->offset_within_address_space &&
> -            mem->mem == (memory_region_get_ram_ptr(area) +
> -            section->offset_within_region)) {
> -            return; /* Same region was attempted to register, go away. */
> -        }
> -    }
> -
> -    /* Region needs to be reset. set the size to 0 and remap it. */
> -    if (mem) {
> -        mem->size = 0;
> -        if (do_hvf_set_memory(mem, 0)) {
> -            error_report("Failed to reset overlapping slot");
> -            abort();
> -        }
> -    }
> -
>       if (!add) {
> +        trace_hvf_vm_unmap(gva, size);
> +        ret = hv_vm_unmap(gva, size);

I think you meant gpa.

> +        assert_hvf_ok(ret);
>           return;
>       }
>   
> -    if (area->readonly ||
> -        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
> -        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
> -    } else {
> -        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
> -    }
> +    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? HV_MEMORY_WRITE : 0);
> +    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
>   
> -    /* Now make a new slot. */
> -    int x;
> -
> -    for (x = 0; x < hvf_state->num_slots; ++x) {
> -        mem = &hvf_state->slots[x];
> -        if (!mem->size) {
> -            break;
> -        }
> -    }
> -
> -    if (x == hvf_state->num_slots) {
> -        error_report("No free slots");
> -        abort();
> -    }
> -
> -    mem->size = int128_get64(section->size);
> -    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
> -    mem->start = section->offset_within_address_space;
> -    mem->region = area;
> -
> -    if (do_hvf_set_memory(mem, flags)) {
> -        error_report("Error registering new memory slot");
> -        abort();
> -    }
> +    trace_hvf_vm_map(gva, size, mem, flags,
> +                     flags & HV_MEMORY_READ ?  'R' : '-',
> +                     flags & HV_MEMORY_WRITE ? 'W' : '-',
> +                     flags & HV_MEMORY_EXEC ?  'X' : '-');
> +    ret = hv_vm_map(mem, gva, size, flags);
> +    assert_hvf_ok(ret);
>   }
>   
>   static void hvf_log_start(MemoryListener *listener,
> @@ -260,7 +190,6 @@ static MemoryListener hvf_memory_listener = {
>   
>   static int hvf_accel_init(AccelState *as, MachineState *ms)
>   {
> -    int x;
>       hv_return_t ret;
>       HVFState *s = HVF_STATE(as);
>       int pa_range = 36;
> @@ -281,12 +210,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
>       }
>       assert_hvf_ok(ret);
>   
> -    s->num_slots = ARRAY_SIZE(s->slots);
> -    for (x = 0; x < s->num_slots; ++x) {
> -        s->slots[x].size = 0;
> -        s->slots[x].slot_id = x;
> -    }
> -
>       QTAILQ_INIT(&s->hvf_sw_breakpoints);
>   
>       hvf_state = s;


