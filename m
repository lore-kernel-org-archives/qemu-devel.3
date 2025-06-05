Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC43C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7R8-0001Ma-3o; Thu, 05 Jun 2025 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uN7R5-0001I6-Om
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:02:59 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1uN7R2-0004cW-Qp
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:02:59 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 555A2eLO005843
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 18:02:40 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.74) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 5 Jun 2025
 18:02:40 +0800
Date: Thu, 5 Jun 2025 18:02:29 +0800
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/tcg: Make round-robin kick period configurable
Message-ID: <aEFrNTMKkQgQ6kSf@ethan84-VirtualBox>
References: <20250605061852.2081342-1-ethan84@andestech.com>
 <369151f7-cde7-4065-ac0a-5364214e8d2c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <369151f7-cde7-4065-ac0a-5364214e8d2c@linaro.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.74]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 555A2eLO005843
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, PDS_RDNS_DYNAMIC_FP=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

Thank you for your response.

Since TCGState is currently defined only in tcg-all.c, we’re unable to access
rr_kick_delay_ns from other .c files through the struct.

One potential approach would be to introduce a tcg-all.h header and move the
TCGState definition there. This would allow us to access the struct in other
components by including the header and using TCG_STATE(current_accel()).

Would you be open to this direction, or do you have any alternative 
suggestions?

Thanks,
Ethan

On Thu, Jun 05, 2025 at 09:21:55AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Ethan,
> 
> On 5/6/25 08:18, Ethan Chen via wrote:
> > This change introduces a configurable round-robin kick period, giving users the
> > flexibility to balance SMP simulation accuracy and performance according to
> > their specific needs.
> > 
> > The round-robin kick period is the time one vCPU can run before scheduler
> > switches to another vCPU when using a single thread TCG. The default value of
> > 0.1 seconds may allow one vCPU to run for too long before the scheduler
> > switches to another. This behavior may not be suitable for workloads with
> > strict timing requirements.
> > 
> > Reducing the period can improve the fidelity of SMP simulation by allowing
> > more frequent vCPU switching, though it may negatively impact overall
> > simulation performance.
> > 
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >   accel/tcg/tcg-accel-ops-rr.c |  2 +-
> >   accel/tcg/tcg-accel-ops-rr.h |  2 +-
> >   accel/tcg/tcg-all.c          | 35 +++++++++++++++++++++++++++++++++++
> >   qemu-options.hx              |  9 ++++++++-
> >   4 files changed, 45 insertions(+), 3 deletions(-)
> 
> 
> > diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
> > index 2a76a29612..324bb772cb 100644
> > --- a/accel/tcg/tcg-accel-ops-rr.h
> > +++ b/accel/tcg/tcg-accel-ops-rr.h
> > @@ -10,7 +10,7 @@
> >   #ifndef TCG_ACCEL_OPS_RR_H
> >   #define TCG_ACCEL_OPS_RR_H
> > 
> > -#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
> > +extern uint64_t rr_kick_period;
> 
> No need for another extern, pass it as argument:
> 
> -- >8 --
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index f62cf24e1d4..551864b5509 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -62,9 +62,9 @@ void rr_kick_vcpu_thread(CPUState *unused)
>  static QEMUTimer *rr_kick_vcpu_timer;
>  static CPUState *rr_current_cpu;
> 
> -static inline int64_t rr_next_kick_time(void)
> +static inline int64_t rr_next_kick_time(uint64_t kick_delay_ns)
>  {
> -    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + kick_delay_ns;
>  }
> 
>  /* Kick the currently round-robin scheduled vCPU to next */
> @@ -83,15 +83,20 @@ static void rr_kick_next_cpu(void)
> 
>  static void rr_kick_thread(void *opaque)
>  {
> -    timer_mod(rr_kick_vcpu_timer, rr_next_kick_time());
> +    CPUState *cpu = opaque;
> +
> +    // here use rr_next_kick_time(cpu->accel->rr_kick_delay_ns):
> +    timer_mod(rr_kick_vcpu_timer, rr_next_kick_time(TCG_KICK_PERIOD));
>      rr_kick_next_cpu();
>  }
> 
>  static void rr_start_kick_timer(void)
>  {
> -    if (!rr_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
> +    CPUState *next_cpu = CPU_NEXT(first_cpu);
> +
> +    if (!rr_kick_vcpu_timer && next_cpu) {
>          rr_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                           rr_kick_thread, NULL);
> +                                           rr_kick_thread, next_cpu);
>      }
>      if (rr_kick_vcpu_timer && !timer_pending(rr_kick_vcpu_timer)) {
>          timer_mod(rr_kick_vcpu_timer, rr_next_kick_time());
> ---
> 
> > diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> > index 6e5dc333d5..69390020aa 100644
> > --- a/accel/tcg/tcg-all.c
> > +++ b/accel/tcg/tcg-all.c
> > @@ -36,6 +36,7 @@
> >   #include "qapi/qapi-builtin-visit.h"
> >   #include "qemu/units.h"
> >   #include "qemu/target-info.h"
> > +#include "qemu/timer.h"
> >   #ifndef CONFIG_USER_ONLY
> >   #include "hw/boards.h"
> >   #endif
> > @@ -50,6 +51,7 @@ struct TCGState {
> >       bool one_insn_per_tb;
> >       int splitwx_enabled;
> >       unsigned long tb_size;
> > +    uint64_t rr_kick_period;
> 
> 'rr_kick_delay_ns' seems more accurate.
> 
> >   };
> >   typedef struct TCGState TCGState;
> > 
> > @@ -76,9 +78,11 @@ static void tcg_accel_instance_init(Object *obj)
> >   #else
> >       s->splitwx_enabled = 0;
> >   #endif
> > +    s->rr_kick_period = NANOSECONDS_PER_SECOND / 10;
> >   }
> > 
> >   bool one_insn_per_tb;
> > +uint64_t rr_kick_period;
> 
> (Drop)
> 
> > 
> >   static int tcg_init_machine(MachineState *ms)
> >   {
> > @@ -125,6 +129,7 @@ static int tcg_init_machine(MachineState *ms)
> >   #endif
> > 
> >       tcg_allowed = true;
> > +    rr_kick_period = s->rr_kick_period;
> 
> (Drop)
> 
> > 
> >       page_init();
> >       tb_htable_init();
> > @@ -234,6 +239,30 @@ static int tcg_gdbstub_supported_sstep_flags(void)
> >       }
> >   }
> 
> Patch LGTM otherwise.
> 
> Regards,
> 
> Phil.

