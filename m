Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D30C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHfW-0003Sd-89; Thu, 02 Jul 2026 09:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfHfT-0003S4-Rl; Thu, 02 Jul 2026 09:41:27 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfHfS-0002iR-8Y; Thu, 02 Jul 2026 09:41:27 -0400
Received: from example.com (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0F47420B7167;
 Thu,  2 Jul 2026 06:41:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F47420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782999682;
 bh=diPdz2O4JYNPu3wSZ0yX/ls8aW8WSEAk0f0/e/oPw6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LLa/4rVwYWP6mkjDuMUlLanfcNyBKzf46+H62/gx35VijE5JW9nhtFdnZGz8CxDFd
 QQpFW8WUfl46GHQJlRfvxUZjLfnZPpmD5I3El2HT0hQLx5fKQoiEO6CYgUx3AyEzVX
 QflGV1ejsVi9+Kod551XaI+ux+JGhP8hzcUiEiuY=
Date: Thu, 2 Jul 2026 15:41:18 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 05/33] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <akZqfrgAahvBs7vz@example.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-6-philmd@oss.qualcomm.com>
 <695e34f0-09d2-4fe2-a88a-a63da6568730@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <695e34f0-09d2-4fe2-a88a-a63da6568730@oss.qualcomm.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

On Thu, Jul 02, 2026 at 03:00:07PM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing Magnus.
> 
> On 1/7/26 00:00, Philippe Mathieu-DaudÃ© wrote:
> > No need for accel-specific @dirty field when we have
> > a generic one in CPUState. (Other accelerators already
> > did that in commits 6f13a0ada01..36ab216b81d).
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > ---
> >   include/system/mshv_int.h   |  1 -
> >   accel/mshv/mshv-all.c       | 18 +++++++++---------
> >   target/i386/mshv/mshv-cpu.c |  6 +++---
> >   3 files changed, 12 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> > index ba3073888ac..b91c4d661a3 100644
> > --- a/include/system/mshv_int.h
> > +++ b/include/system/mshv_int.h
> > @@ -43,7 +43,6 @@ typedef struct MshvHvCallArgs {
> >   struct AccelCPUState {
> >       int cpufd;
> > -    bool dirty;
> >       MshvHvCallArgs hvcall_args;
> >   };
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index 9452504ac28..1959baf6672 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -531,7 +531,7 @@ static int mshv_init_vcpu(CPUState *cpu)
> >       }
> >       mshv_arch_init_vcpu(cpu);
> > -    cpu->accel->dirty = true;
> > +    cpu->vcpu_dirty = true;
> >       return 0;
> >   }
> > @@ -617,7 +617,7 @@ static int mshv_cpu_exec(CPUState *cpu)
> >       cpu_exec_start(cpu);
> >       do {
> > -        if (cpu->accel->dirty) {
> > +        if (cpu->vcpu_dirty) {
> >               ret = mshv_arch_store_vcpu_state(cpu);
> >               if (ret) {
> >                   error_report("Failed to put registers after init: %s",
> > @@ -625,7 +625,7 @@ static int mshv_cpu_exec(CPUState *cpu)
> >                   ret = -1;
> >                   break;
> >               }
> > -            cpu->accel->dirty = false;
> > +            cpu->vcpu_dirty = false;
> >           }
> >           ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
> > @@ -746,7 +746,7 @@ static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
> >           abort();
> >       }
> > -    cpu->accel->dirty = false;
> > +    cpu->vcpu_dirty = false;
> >   }
> >   static void mshv_cpu_synchronize_post_init(CPUState *cpu)
> > @@ -763,13 +763,13 @@ static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
> >           cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> >           vm_stop(RUN_STATE_INTERNAL_ERROR);
> >       }
> > -    cpu->accel->dirty = false;
> > +    cpu->vcpu_dirty = false;
> >   }
> >   static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
> >                                                  run_on_cpu_data arg)
> >   {
> > -    cpu->accel->dirty = true;
> > +    cpu->vcpu_dirty = true;
> >   }
> >   static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
> > @@ -779,7 +779,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
> >   static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
> >   {
> > -    if (!cpu->accel->dirty) {
> > +    if (!cpu->vcpu_dirty) {
> >           int ret = mshv_arch_load_vcpu_state(cpu);
> >           if (ret < 0) {
> >               error_report("Failed to load registers for vcpu %d",
> > @@ -789,13 +789,13 @@ static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
> >               vm_stop(RUN_STATE_INTERNAL_ERROR);
> >           }
> > -        cpu->accel->dirty = true;
> > +        cpu->vcpu_dirty = true;
> >       }
> >   }
> >   static void mshv_cpu_synchronize(CPUState *cpu)
> >   {
> > -    if (!cpu->accel->dirty) {
> > +    if (!cpu->vcpu_dirty) {
> >           run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
> >       }
> >   }
> > diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> > index 126ca40b481..1c433c408c8 100644
> > --- a/target/i386/mshv/mshv-cpu.c
> > +++ b/target/i386/mshv/mshv-cpu.c
> > @@ -1692,7 +1692,7 @@ static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
> >       return ret;
> >   }
> > -static int handle_pio_non_str(const CPUState *cpu,
> > +static int handle_pio_non_str(CPUState *cpu,
> >                                 hv_x64_io_port_intercept_message *info)
> >   {
> >       size_t len = info->access_info.access_size;
> > @@ -1748,7 +1748,7 @@ static int handle_pio_non_str(const CPUState *cpu,
> >           return -1;
> >       }
> > -    cpu->accel->dirty = false;
> > +    cpu->vcpu_dirty = false;
> >       return 0;
> >   }
> > @@ -1909,7 +1909,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
> >           return -1;
> >       }
> > -    cpu->accel->dirty = false;
> > +    cpu->vcpu_dirty = false;
> >       return 0;
> >   }

thanks, applied and tested.

Tested-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

