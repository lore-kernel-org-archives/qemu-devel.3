Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC400C4450E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKnU-0001g7-Q2; Thu, 16 Jul 2026 08:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wkKmR-0001FI-5l
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:01:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wkKmO-0001Wz-Ol
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:01:30 -0400
Received: from linux.microsoft.com (unknown [167.220.197.183])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4231820B7167;
 Thu, 16 Jul 2026 05:01:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4231820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784203277;
 bh=t5zP8bAJk32JcowzMhZUrtiIZUJKDg0XefZPWTtYfQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QvmSDX70B9AQas0ULFpW7gdz/Hup5hCtVjvuy49FKCBrd17uXU5I8yPfBZzwnL1V1
 BJYwWzf5swTIl+jACLc/8dro97stuh5fJiEk0sW4yB0N3Lqp+wg7ZwgjKrT6azrCK+
 91jAF41dH+x14Ck0vmKmsPagGEx1kLS7Z1+KKyLo=
Date: Thu, 16 Jul 2026 15:01:21 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 03/12] hw/i386/mshv: migrate REFERENCE_TIME
Message-ID: <aljIEVon0_qwyuB4@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
 <20260710101534.664604-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710101534.664604-4-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 12:15:25PM +0200, Magnus Kulke wrote:
> This is a partition-wide state for which we use a dedicated hw clock
> facility, similar to KVM. We have to freeze the time for a partition
> before we are allowed to set it. We register a state change handler for
> the clock device and a post-load handler for migration state. In the
> post-load handler we toggle a flag that will set the reference time
> state on next state to "running" on the partition.
> 
> We can move the time freeze and reference-time ioctls/hvcalls to the
> clock module.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  MAINTAINERS              |   1 +
>  accel/mshv/mshv-all.c    |  67 ++------------
>  accel/mshv/trace-events  |   1 +
>  hw/i386/meson.build      |   1 +
>  hw/i386/mshv/clock.c     | 189 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/mshv/meson.build |   4 +
>  include/system/mshv.h    |   3 +
>  7 files changed, 208 insertions(+), 58 deletions(-)
>  create mode 100644 hw/i386/mshv/clock.c
>  create mode 100644 hw/i386/mshv/meson.build
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..269876db3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -613,6 +613,7 @@ R: Wei Liu <wei.liu@kernel.org>
>  R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
>  S: Supported
>  F: target/i386/mshv/
> +F: hw/i386/mshv/
>  
>  X86 Instruction Emulator
>  M: Roman Bolshakov <rbolshakov@ddn.com>
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index b34fb34d05..7b3c13cf1e 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -60,54 +60,6 @@ static int init_mshv(int *mshv_fd)
>      return 0;
>  }
>  
> -/* freeze 1 to pause, 0 to resume */
> -static int set_time_freeze(int vm_fd, int freeze)
> -{
> -    int ret;
> -    struct hv_input_set_partition_property in = {0};
> -    in.property_code = HV_PARTITION_PROPERTY_TIME_FREEZE;
> -    in.property_value = freeze;
> -
> -    struct mshv_root_hvcall args = {0};
> -    args.code = HVCALL_SET_PARTITION_PROPERTY;
> -    args.in_sz = sizeof(in);
> -    args.in_ptr = (uint64_t)&in;
> -
> -    ret = mshv_hvcall(vm_fd, &args);
> -    if (ret < 0) {
> -        error_report("Failed to set time freeze");
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
> -static int pause_vm(int vm_fd)
> -{
> -    int ret;
> -
> -    ret = set_time_freeze(vm_fd, 1);
> -    if (ret < 0) {
> -        error_report("Failed to pause partition: %s", strerror(errno));
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
> -static int resume_vm(int vm_fd)
> -{
> -    int ret;
> -
> -    ret = set_time_freeze(vm_fd, 0);
> -    if (ret < 0) {
> -        error_report("Failed to resume partition: %s", strerror(errno));
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  static int get_host_partition_property(int mshv_fd, uint32_t property_code,
>                                         uint64_t *value)
>  {
> @@ -330,9 +282,6 @@ static int create_vm(int mshv_fd, int *vm_fd)
>          return -1;
>      }
>  
> -    /* Always create a frozen partition */
> -    pause_vm(*vm_fd);
> -
>      return 0;
>  }
>  
> @@ -578,13 +527,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
>          return -1;
>      }
>  
> -    ret = resume_vm(vm_fd);
> -    if (ret < 0) {
> -        close(mshv_fd);
> -        close(vm_fd);
> -        return -1;
> -    }
> -
>      s->vm = vm_fd;
>      s->fd = mshv_fd;
>  
> @@ -606,6 +548,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
>  
>      register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
>  
> +    mshv_clock_init();
> +
>      return 0;
>  }
>  
> @@ -643,6 +587,13 @@ static int mshv_cpu_exec(CPUState *cpu)
>              cpu->vcpu_dirty = false;
>          }
>  
> +        /* Corresponding store-release is in cpu_exit. */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
> +            trace_mshv_interrupt_exit_request(cpu->cpu_index);
> +            ret = EXCP_INTERRUPT;
> +            break;
> +        }
> +
>          ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
>          if (ret < 0) {
>              error_report("Failed to run on vcpu %d", cpu->cpu_index);
> diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
> index a4dffeb24a..859e8bfb0f 100644
> --- a/accel/mshv/trace-events
> +++ b/accel/mshv/trace-events
> @@ -4,6 +4,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
>  mshv_start_vcpu_thread(const char* thread, uint32_t cpu) "thread=%s cpu_index=%d"
> +mshv_interrupt_exit_request(uint32_t cpu) "cpu_index=%d"
>  
>  mshv_set_memory(bool add, uint64_t gpa, uint64_t size, uint64_t user_addr, bool readonly, int ret) "add=%d gpa=0x%" PRIx64 " size=0x%" PRIx64 " user=0x%" PRIx64 " readonly=%d result=%d"
>  mshv_mem_ioeventfd_add(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" PRIx64 " size=%d data=0x%x"
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index b611fbb5a7..f4d3122863 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -39,6 +39,7 @@ i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c', 'tdvf-hob.c'))
>  
>  subdir('kvm')
>  subdir('xen')
> +subdir('mshv')
>  
>  i386_ss.add_all(xenpv_ss)
>  
> diff --git a/hw/i386/mshv/clock.c b/hw/i386/mshv/clock.c
> new file mode 100644
> index 0000000000..02c586503a
> --- /dev/null
> +++ b/hw/i386/mshv/clock.c
> @@ -0,0 +1,189 @@
> +/*
> + * MSHV partition reference clock
> + *
> + * Copyright Microsoft, Corp. 2026
> + *
> + * Authors: Magnus Kulke <magnuskulke@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "migration/vmstate.h"
> +#include "system/runstate.h"
> +#include "hw/hyperv/hvhdk.h"
> +#include "hw/hyperv/hvhdk_mini.h"
> +#include "hw/hyperv/hvgdk.h"
> +#include "hw/hyperv/hvgdk_mini.h"
> +#include "linux/mshv.h"
> +#include "system/mshv.h"
> +#include "system/mshv_int.h"
> +
> +/*
> + * Partition reference clock (HV_PARTITION_PROPERTY_REFERENCE_TIME), captured
> + * when the VM is stopped and re-applied when it resumes.
> + *
> + * Mirrors hw/i386/kvm/clock.c.
> + */
> +typedef struct MshvClockState {
> +    uint64_t ref_time;
> +    bool ref_time_pending;
> +} MshvClockState;
> +
> +static MshvClockState mshv_clock;
> +
> +static int mshv_get_reference_time(int vm_fd, uint64_t *ref_time)
> +{
> +    struct hv_input_get_partition_property in = { 0 };
> +    struct hv_output_get_partition_property out = { 0 };
> +    struct mshv_root_hvcall args = { 0 };
> +    int ret;
> +
> +    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
> +
> +    args.code        = HVCALL_GET_PARTITION_PROPERTY;
> +    args.in_sz       = sizeof(in);
> +    args.in_ptr      = (uint64_t)&in;
> +    args.out_sz      = sizeof(out);
> +    args.out_ptr     = (uint64_t)&out;
> +
> +    ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to get reference time");
> +        return -1;
> +    }
> +
> +    *ref_time = out.property_value;
> +    return 0;
> +}
> +
> +static int mshv_set_reference_time(int vm_fd, uint64_t ref_time)
> +{
> +    struct hv_input_set_partition_property in = { 0 };
> +    struct mshv_root_hvcall args = { 0 };
> +    int ret;
> +
> +    in.property_code  = HV_PARTITION_PROPERTY_REFERENCE_TIME;
> +    in.property_value = ref_time;
> +
> +    args.code         = HVCALL_SET_PARTITION_PROPERTY;
> +    args.in_sz        = sizeof(in);
> +    args.in_ptr       = (uint64_t)&in;
> +
> +    ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to set reference time");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Freeze (freeze=1) or unfreeze (freeze=0) time for a partition. This will not
> + * pause/eject vCPU execution. It is assumed that the caller already has stopped
> + * the partition's vCPUs.
> + *
> + * NB: a partition's reference clock can only be written while the time is
> + * frozen.
> + */
> +static int mshv_set_time_freeze(int vm_fd, int freeze)
> +{
> +    struct hv_input_set_partition_property in = { 0 };
> +    struct mshv_root_hvcall args = { 0 };
> +    int ret;
> +
> +    in.property_code  = HV_PARTITION_PROPERTY_TIME_FREEZE;
> +    in.property_value = freeze;
> +
> +    args.code         = HVCALL_SET_PARTITION_PROPERTY;
> +    args.in_sz        = sizeof(in);
> +    args.in_ptr       = (uint64_t)&in;
> +
> +    ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to set time freeze");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void mshv_clock_vm_state_change(void *opaque, bool running,
> +                                       RunState state)
> +{
> +    MshvClockState *s = opaque;
> +    int vm_fd = mshv_state->vm;
> +    int ret;
> +
> +    if (running) {
> +        /* Skip if we have nothing to restore, e.g. on initial boot. */
> +        if (!s->ref_time_pending) {
> +            return;
> +        }
> +
> +        ret = mshv_set_time_freeze(vm_fd, 1);
> +        if (ret < 0) {
> +            error_report("Failed to freeze partition time on resume");
> +            abort();
> +        }
> +
> +        /* INVARIANT: reference time can only be written if time is frozen. */
> +        ret = mshv_set_reference_time(vm_fd, s->ref_time);
> +        if (ret < 0) {
> +            error_report("Failed to restore reference time on resume");
> +            abort();
> +        }
> +
> +        if (mshv_set_time_freeze(vm_fd, 0) < 0) {
> +            error_report("Failed to unfreeze partition time on resume");
> +            abort();
> +        }
> +
> +        s->ref_time_pending = false;
> +    } else {
> +        /* Skip if we already have a to-be-set ref time */
> +        if (s->ref_time_pending) {
> +            return;
> +        }
> +
> +        ret = mshv_get_reference_time(vm_fd, &s->ref_time);
> +        if (ret < 0) {
> +            error_report("Failed to capture reference time on stop");
> +            abort();
> +        }
> +
> +        s->ref_time_pending = true;
> +    }
> +}
> +
> +/*
> + * The incoming reference time should be applied on the next resume before
> + * vCPUs start executing.
> + */
> +static int mshv_clock_post_load(void *opaque, int version_id)
> +{
> +    MshvClockState *s = opaque;
> +
> +    s->ref_time_pending = true;
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_mshv_clock = {
> +    .name = "mshv-clock",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = mshv_clock_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(ref_time, MshvClockState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +void mshv_clock_init(void)
> +{
> +    vmstate_register(NULL, 0, &vmstate_mshv_clock, &mshv_clock);
> +    qemu_add_vm_change_state_handler(mshv_clock_vm_state_change, &mshv_clock);
> +}
> diff --git a/hw/i386/mshv/meson.build b/hw/i386/mshv/meson.build
> new file mode 100644
> index 0000000000..0e556851b6
> --- /dev/null
> +++ b/hw/i386/mshv/meson.build
> @@ -0,0 +1,4 @@
> +i386_mshv_ss = ss.source_set()
> +i386_mshv_ss.add(files('clock.c'))
> +
> +i386_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index 46fe3fcebc..a6f815b822 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -55,6 +55,9 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
>  
>  extern MshvState *mshv_state;
>  
> +/* clock (partition reference time) */
> +void mshv_clock_init(void);
> +
>  /* interrupt */
>  int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
>                             uint32_t vp_index, bool logical_destination_mode,
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

