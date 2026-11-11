Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77126606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lY7WaBev
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRE7Q-0002hw-Ue; Wed, 11 Nov 2026 14:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xRE7P-0002hV-5b
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 14:36:27 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xRE7N-0006yK-3t
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 14:36:26 -0500
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6ECBE20B7166;
 Wed, 11 Nov 2026 11:36:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6ECBE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794425780;
 bh=PFIMXLbh6/bwWJFKvdCFfStNm4X3xyuPJxjWfUyMphk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lY7WaBev4eyRCK9rNr1RdawzXQ0yCqZeuR+lvDVFIR6z7Tq/PzebU5zNjryZznFgk
 J54y1sIaWETnxnXvco7WwRwPqt3LcNC4dR94sybY2Au6PygjZQDQAALRlSFrKB+VfE
 +bFtxlkPKdRwNEp2iziDFfubVqR91CyhwAveZLzI=
Date: Wed, 11 Nov 2026 20:36:18 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>, Feng Liang <feng.liang@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: Re: [PATCH] accel/mshv: freeze time during TSC MSR write
Message-ID: <avTDso4VTz7mWf+t@example.com>
References: <20261106143928.443144-1-magnuskulke@linux.microsoft.com>
 <avHzONXmKN0hu1fP@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avHzONXmKN0hu1fP@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 06:22:16PM +0200, Doru Blânzeanu wrote:
> On Fri, Nov 06, 2026 at 03:39:28PM +0100, Magnus Kulke wrote:
> > A regression was introduced when the HV_X64_REGISTER_TSC MSR state is
> > being written to the hypervisor as part of the migration framework. If
> > the MSR is written without the time being frozen, the tsc_page (a
> > hyper-v enlightenment) is zeroed out and cannot be used by a guest,
> > which results in a performance regression, because the guest falls back
> > to costly reads of HV_X64_MSR_TIME_REF_COUNT.
> > 
> > An implementation of pre_resume_vm hook was added to handle the clock
> > lifecycle, relying on the dirty_vcpu state to avoid redundant state
> > writes.
> > 
> > Fixes: d540dcc5e28c (target/i386/mshv: migrate MSRs)
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> >  accel/mshv/mshv-all.c |  33 ++++++++++++-
> >  hw/i386/mshv/clock.c  | 111 +++++++++++++++++++++++++++++-------------
> >  include/system/mshv.h |   4 +-
> >  3 files changed, 113 insertions(+), 35 deletions(-)
> > 
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index d820a67b95..ae7577d407 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -34,6 +34,7 @@
> >  #include "accel/accel-cpu-ops.h"
> >  #include "exec/cpu-common.h"
> >  #include "system/cpus.h"
> > +#include "system/hw_accel.h"
> >  #include "system/runstate.h"
> >  #include "system/accel-blocker.h"
> >  #include "system/address-spaces.h"
> > @@ -578,7 +579,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
> >  
> >      register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
> >  
> > -    mshv_clock_init();
> > +    ret = mshv_clock_init(vm_fd);
> > +    if (ret < 0) {
> > +        return -1;
> > +    }
> >  
> >      return 0;
> >  }
> > @@ -927,6 +931,32 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
> >      run_on_cpu(cpu, do_mshv_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
> >  }
> >  
> > +static void mshv_pre_resume_vm(AccelState *as, bool step_pending)
> > +{
> > +    MshvState *s = MSHV_STATE(as);
> > +    CPUState *cpu;
> > +    int ret, vm_fd = s->vm;
> > +
> > +    ret = mshv_clock_prepare_resume(vm_fd);
> > +    if (ret < 0) {
> > +        error_report("Failed to prepare clock for resume");
> > +        abort();
> > +    }
> > +
> > +    CPU_FOREACH(cpu) {
> > +        if (!cpu->vcpu_dirty) {
> > +            continue;
> > +        }
> > +        cpu_synchronize_post_init(cpu);
> > +    }
> > +
> > +    ret = mshv_clock_finish_resume(vm_fd);
> > +    if (ret < 0) {
> > +        error_report("Failed to finish clock for resume");
> > +        abort();
> > +    }
> > +}
> > +
> >  static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
> >  {
> >      if (!cpu->vcpu_dirty) {
> > @@ -962,6 +992,7 @@ static void mshv_accel_class_init(ObjectClass *oc, const void *data)
> >      ac->name = "MSHV";
> >      ac->init_machine = mshv_init;
> >      ac->allowed = &mshv_allowed;
> > +    ac->pre_resume_vm = mshv_pre_resume_vm;
> >  }
> >  
> >  static void mshv_accel_instance_init(Object *obj)
> > diff --git a/hw/i386/mshv/clock.c b/hw/i386/mshv/clock.c
> > index 02c586503a..2a03d3cef9 100644
> > --- a/hw/i386/mshv/clock.c
> > +++ b/hw/i386/mshv/clock.c
> > @@ -29,6 +29,7 @@
> >  typedef struct MshvClockState {
> >      uint64_t ref_time;
> >      bool ref_time_pending;
> > +    bool time_frozen;
> >  } MshvClockState;
> >  
> >  static MshvClockState mshv_clock;
> > @@ -110,52 +111,85 @@ static int mshv_set_time_freeze(int vm_fd, int freeze)
> >      return 0;
> >  }
> >  
> > -static void mshv_clock_vm_state_change(void *opaque, bool running,
> > -                                       RunState state)
> > -{
> > -    MshvClockState *s = opaque;
> > -    int vm_fd = mshv_state->vm;
> > +static int ensure_time_frozen(int vm_fd) {
> >      int ret;
> >  
> > -    if (running) {
> > -        /* Skip if we have nothing to restore, e.g. on initial boot. */
> > -        if (!s->ref_time_pending) {
> > -            return;
> > -        }
> > +    /* Ensure time is frozen */
> > +    if (mshv_clock.time_frozen) {
> > +        return 0;
> > +    }
> >  
> > -        ret = mshv_set_time_freeze(vm_fd, 1);
> > -        if (ret < 0) {
> > -            error_report("Failed to freeze partition time on resume");
> > -            abort();
> > -        }
> > +    ret = mshv_set_time_freeze(vm_fd, 1);
> > +    if (ret < 0) {
> > +        error_report("Failed to freeze partition");
> > +        return -1;
> > +    }
> > +    mshv_clock.time_frozen = true;
> >  
> > +    return 0;
> > +}
> > +
> > +int mshv_clock_prepare_resume(int vm_fd) {
> > +    return ensure_time_frozen(vm_fd);
> > +}
> > +
> > +int mshv_clock_finish_resume(int vm_fd) {
> > +    int ret;
> > +    MshvClockState *s = &mshv_clock;
> > +
> > +    assert(mshv_clock.time_frozen);
> > +
> > +    /* Skip if we have nothing to restore, e.g. on initial boot. */
> > +    if (s->ref_time_pending) {
> >          /* INVARIANT: reference time can only be written if time is frozen. */
> >          ret = mshv_set_reference_time(vm_fd, s->ref_time);
> >          if (ret < 0) {
> >              error_report("Failed to restore reference time on resume");
> > -            abort();
> > +            return -1;
> >          }
> > +        s->ref_time_pending = false;
> > +    }
> >  
> > -        if (mshv_set_time_freeze(vm_fd, 0) < 0) {
> > -            error_report("Failed to unfreeze partition time on resume");
> > -            abort();
> > -        }
> > +    ret = mshv_set_time_freeze(vm_fd, 0);
> > +    if (ret < 0) {
> > +        error_report("Failed to thaw partition");
> > +        return -1;
> > +    }
> > +    mshv_clock.time_frozen = false;
> >  
> > -        s->ref_time_pending = false;
> > -    } else {
> > -        /* Skip if we already have a to-be-set ref time */
> > -        if (s->ref_time_pending) {
> > -            return;
> > -        }
> > +    return 0;
> > +}
> >  
> > -        ret = mshv_get_reference_time(vm_fd, &s->ref_time);
> > -        if (ret < 0) {
> > -            error_report("Failed to capture reference time on stop");
> > -            abort();
> > -        }
> > +static void mshv_clock_vm_state_change(void *opaque, bool running,
> > +                                       RunState state)
> > +{
> > +    MshvClockState *s = opaque;
> > +    int vm_fd = mshv_state->vm;
> > +    int ret;
> >  
> > -        s->ref_time_pending = true;
> > +    if (running) {
> > +        return;
> >      }
> > +
> > +    /* Ensure the time if frozen before we capture the reference time. */
> > +    ret = ensure_time_frozen(vm_fd);
> > +    if (ret < 0) {
> > +        error_report("Failed to freeze partition time on stop");
> > +        abort();
> > +    }
> > +
> > +    /* Skip if we already have a to-be-set ref time */
> > +    if (s->ref_time_pending) {
> > +        return;
> > +    }
> > +
> > +    ret = mshv_get_reference_time(vm_fd, &s->ref_time);
> > +    if (ret < 0) {
> > +        error_report("Failed to capture reference time on stop");
> > +        abort();
> > +    }
> > +
> > +    s->ref_time_pending = true;
> >  }
> >  
> >  /*
> > @@ -182,8 +216,19 @@ static const VMStateDescription vmstate_mshv_clock = {
> >      },
> >  };
> >  
> > -void mshv_clock_init(void)
> > +int mshv_clock_init(int vm_fd)
> >  {
> > +    int ret;
> > +
> > +    ret = mshv_set_time_freeze(vm_fd, 1);
> > +    if (ret < 0) {
> > +        error_report("Failed to freeze partition time on init");
> > +        return -1;
> > +    }
> > +    mshv_clock.time_frozen = true;
> > +
> >      vmstate_register(NULL, 0, &vmstate_mshv_clock, &mshv_clock);
> >      qemu_add_vm_change_state_handler(mshv_clock_vm_state_change, &mshv_clock);
> > +
> > +    return 0;
> >  }
> > diff --git a/include/system/mshv.h b/include/system/mshv.h
> > index f98ddff9b5..864f2aa34d 100644
> > --- a/include/system/mshv.h
> > +++ b/include/system/mshv.h
> > @@ -58,7 +58,9 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
> >  extern MshvState *mshv_state;
> >  
> >  /* clock (partition reference time) */
> > -void mshv_clock_init(void);
> > +int mshv_clock_init(int vm_fd);
> > +int mshv_clock_prepare_resume(int vm_fd);
> > +int mshv_clock_finish_resume(int vm_fd);
> >  
> >  /* interrupt */
> >  int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
> > -- 
> > 2.34.1
> 
> Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

queued in pull-20261111

