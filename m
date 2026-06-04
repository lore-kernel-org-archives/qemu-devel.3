Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB072CD6E55
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUy5r-0005ss-5n; Wed, 03 Jun 2026 22:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wUy5p-0005sV-Gs
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:46:01 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wUy5n-0003QK-Eq
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:46:01 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39677245e15so1252021fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 19:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780541158; cv=none;
 d=google.com; s=arc-20240605;
 b=P23Wz1YwfkW9jBprhwfKnq1mOwPNNvEaYMgpY7166ujqSRBcepvwPNvr+1e/od9SiN
 wj6s7hsMB63OhPlFGcWnfe/ukdehMuDfeFDyIm1u2gEYya87cM+fdEf0Buv6PFpt+2Uh
 Kz4sACKUFApzQXB4kq/6mHvExcaAli+/HVtWDFHfG1xebAy92Afb/edsYizFR9+OFP6h
 BLwMNCA/fZiInYbp3ewxiVmCSv7iPDebgwIquogNg05cFEsr0AlXnaP0jPFqucnO5li0
 +tvRTKm5RhzqQavhf+Mot6AX+/V58autT0ncvi6aP219zt292rqPvbtdiyhaDwFCW2T1
 nYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
 fh=V8WSqJrcdCEqqnLPfIBRvUappUhgn/Nw1a0Q5QNc0Jk=;
 b=im6dr8TPUIszfrLIxsy4Yd/uQ0QJ9SxCd/7gSBdjXq5HJIr2xMCU1bcMFIdZk4sY/K
 l3zz98bGMIwE4MQnD+9OH91DCuYAH0NI0Ow7rFvvInUVLj0p75D9kiKiAJMzsRvTQETD
 +oFhLfNTKJiwTGnN8Iw5ZfO+5oNfeCrfGOGrEpTu7mbpGAigXUwlf6Ms6rCS2hk4+bs/
 m4E2YSEPwTjnZ4IkycYdZQDiJBylaouecN1QWu2qxy2G8cEK6IZ2MHpxWo60ZQr/Z234
 HL+VwaPXarrlXPkkKdlQx+E7UW0NbsWXlVtBql4JepW7SHU/aGtdcnYL5GY9p9fdbz53
 03tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1780541158; x=1781145958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
 b=kZr0MLPaFthlTB8iN4z0bO9H7iJJc3snbpcbHBwZAKKD7GmQmLupE8tDtC1khIqpzf
 t+PuK/x2wnSkQVxNi2An85nxtZXIWKb6Kyj6IGwpLh0TiYnXAtdG7wdn7CKJaROnhswv
 VWd8uzpXYn0WVJ5K+8YaLCn3AM/weoykC5DpgRfAkcL6QYpcmwBD27JsM1PVg5sRWacd
 tV6Bmt9Ehxjd4kGDiXF/e1mGP7hQNCCl5jBQ10zcIKzd2u4PL6t8sL8C6NEUI1MgR0Ff
 5Q6F0WVZwGrBZXTsyrHAJYLANl0O1bwW2IQQ4iQYJSP3GBuY0szrIaLNQ1ntF28onGaE
 1aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780541158; x=1781145958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFP2ipEuZjDlN4mA8+0J7o2ZgbAl9Y2Nwnp0st3IxfQ=;
 b=B0snZpaLH78j2/Pe0v9UoljjcKjSCvLMzfxdV/p8NqVGUqw3SuYqF2lshHPR1gTazg
 oMx5KA6VWAX59Sl9KoOgJcJcc/oBN266GUl9mH7dz9iBEk1cDzxbKW983fpuJuFXCTYA
 1+y2qDK040oE3dtwVXymMYOcZR6+Sk65G40w5DoDBnV+zItW6ElrZ15i9DZ1qQf9+VRB
 0EaDrXTVEyiYbTloC9nSVRs+Zo/PKahc3hL4ganbq7a0YtsNZIyGfS8wkil4s45fINaP
 h5IVtSoMy7BMuoLFmipTtE8KEcE4eH0oyii+zFA1oDRBVwv20JgX/BQIh8WECHQIYp/a
 A7VA==
X-Gm-Message-State: AOJu0Yxsie+nmZk4TQrpoMPMOcRki9vVw3XE2qhfjtEPg5IjH5k7rTt6
 Mn8topA0N+uHMQEbHNAmmVvc2JpXxiDod7OeSshIDUyu4LqlVsy4BkpQGE4RwjUdCrfKSkspKn7
 mJ3OqgwmcKeipuUQYok5uKBi8vBaipiv6QA2Gtt7qjw==
X-Gm-Gg: Acq92OERlr41PQ6Or98YaPawNU7k3whEUux7dbuTm1jGKdwCNPmY1GZQMhh1EHsOfG+
 dBgaCxPBw5nHy+D678+/nRT3TJYWmZo3+Afa6td9/VbSz0jUBJJfbPiW3AJx33GA85Xnpg7wHYc
 DfgAcQKfW7EhN1pCsTCjCpi/66ed1FBipx+5xn2ml9ZK/JSFOxmBomCbKM7Pc11DavBQSWMXz7C
 awdNeY8BZubpBEgp+IjSbixsg+MwWzLK7qpwJj2VRPc1hRpOCzg1r044Zkc7HJJvCSqgVYXSiW8
 wElJrtEeREzX3qVYXMWR
X-Received: by 2002:a2e:a808:0:b0:38e:98b0:3a7e with SMTP id
 38308e7fff4ca-396af4f3da9mr18741191fa.22.1780541157516; Wed, 03 Jun 2026
 19:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260603031612.6173-1-guobin@linux.alibaba.com>
In-Reply-To: <20260603031612.6173-1-guobin@linux.alibaba.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 4 Jun 2026 10:45:45 +0800
X-Gm-Features: AVHnY4JwVXICSZ6pt0VBz2DLHWhyseFm8WoQ7GGgB1lZnPOIzqpHgYmM20IYoTE
Message-ID: <CAFWXh4wQZ6T77dNC8Dwy1fn57+GwGwjxs5f_2ghASe3xecNjJg@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: event-driven wakeup for dirty ring reaper
 thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The patch looks good to me overall, but I encountered a compilation error
(see details below). I suspect it might have been tested on a vendor-specif=
ic
version; could you please re-verify it against the latest mainline version?
I=E2=80=99ll be happy to merge it once the build issue is resolved.

On Wed, Jun 3, 2026 at 11:16=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com> =
wrote:
>
> The dirty ring reaper thread polls with a fixed sleep(1), which the
> code itself flags with a TODO for a smarter timeout.  Events that
> would benefit from a prompt reap must wait up to one full sleep tick
> before the reaper notices them.
>
> Replace the polling loop with an EventNotifier-based wait via
> qemu_poll_ns(), kicked by paths that have first-hand evidence that
> a reap is desirable.  A 1s fallback timeout is retained as a
> defensive backstop.
>
> Two kick sites are wired up:
>
>   * dirtylimit_change(false) -- when dirty-limit is cancelled, kick
>     the reaper so it resumes real reaping immediately instead of
>     waiting for the next sleep tick.
>
>     Measured with strace on the reaper TID (20 set/cancel cycles
>     against a stress-ng dirty-page workload), latency from the
>     cancel-vcpu-dirty-limit QMP ack to the reaper actually waking:
>
>         before: median 530ms, max 937ms
>         after:  median <1ms,  max <1ms
>
>   * kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler -- the handler
>     already reaps the exiting vCPU synchronously; the kick hints the
>     reaper to also check other vCPUs whose rings are likely filling
>     concurrently.
>
> kvm_dirty_ring_reaper_kick() is exposed as a public API; multiple
> kicks collapse into a single wake via the eventfd counter.
> kvm_dirty_ring_reaper_init() now returns int again (it was made void
> in commit 43a5e377f4) to propagate event_notifier_init() failure.
> A stub is added for non-KVM builds.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  accel/kvm/kvm-all.c      | 62 +++++++++++++++++++++++++++++++++++++---
>  accel/stubs/kvm-stub.c   |  4 +++
>  include/system/kvm.h     |  9 ++++++
>  include/system/kvm_int.h |  3 ++
>  system/dirtylimit.c      |  6 ++++
>  5 files changed, 80 insertions(+), 4 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96f90ebb24..f964102f09 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1754,6 +1754,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      } while (size);
>  }
>
> +/* Fallback liveness timeout for the dirty ring reaper, in nanoseconds. =
*/
> +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
> +
>  static void *kvm_dirty_ring_reaper_thread(void *data)
>  {
>      KVMState *s =3D data;
> @@ -1764,12 +1767,30 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      trace_kvm_dirty_ring_reaper("init");
>
>      while (true) {
> +        GPollFD pfd =3D {
> +            .fd =3D event_notifier_get_fd(&r->reaper_notifier),
> +            .events =3D G_IO_IN,
> +        };
> +
>          r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
>          trace_kvm_dirty_ring_reaper("wait");
> +
>          /*
> -         * TODO: provide a smarter timeout rather than a constant?
> +         * Event-driven wait: sleep until something kicks the reaper
> +         * (vCPU ring-full exit, dirtylimit disabled, ...) or until the
> +         * fallback timeout fires.  The fallback preserves the original
> +         * sleep(1) worst-case behaviour as a liveness backstop in case
> +         * a kick site is ever missed.
>           */
> -        sleep(1);
> +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> +
> +        /*
> +         * Drain the notifier whether or not the wakeup came from it --
> +         * any pending kick is satisfied by the reap we are about to
> +         * perform, so we must not leave a stale event behind that would
> +         * cause the next iteration to spin without sleeping.
> +         */
> +        event_notifier_test_and_clear(&r->reaper_notifier);
>
>          /* keep sleeping so that dirtylimit not be interfered by reaper =
*/
>          if (dirtylimit_in_service()) {
> @@ -1789,13 +1810,39 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      g_assert_not_reached();
>  }
>
> -static void kvm_dirty_ring_reaper_init(KVMState *s)
> +static int kvm_dirty_ring_reaper_init(KVMState *s, Error **errp)
>  {
>      struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    int ret;
> +
> +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to initialize dirty ring reaper notifie=
r");
> +        return ret;
> +    }
>
>      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
>                         kvm_dirty_ring_reaper_thread,
>                         s, QEMU_THREAD_JOINABLE);
> +    return 0;
> +}
> +
> +/*
> + * Wake the dirty ring reaper thread so it performs a reap as soon as
> + * possible.  Safe to call from any thread; safe to call even when the
> + * dirty ring is not enabled (no-op in that case).  Coalescing is
> + * provided by the eventfd counter -- multiple kicks before the reaper
> + * runs collapse into a single wakeup.
> + */
> +void kvm_dirty_ring_reaper_kick(void)
> +{
> +    KVMState *s =3D kvm_state;
> +
> +    if (!s || !s->kvm_dirty_ring_size) {
> +        return;
> +    }
> +    event_notifier_set(&s->reaper.reaper_notifier);
>  }
>
>  static int kvm_dirty_ring_init(KVMState *s)
> @@ -3097,7 +3144,9 @@ static int kvm_init(AccelState *as, MachineState *m=
s)
>      }
>
>      if (s->kvm_dirty_ring_size) {
> -        kvm_dirty_ring_reaper_init(s);

Compilation error: 'errp' is undefined in this context.

> +        if (kvm_dirty_ring_reaper_init(s, errp) < 0) {
> +            goto err;
> +        }
>      }
>
>      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
> @@ -3571,6 +3620,11 @@ int kvm_cpu_exec(CPUState *cpu)
>                  kvm_dirty_ring_reap(kvm_state, NULL);
>              }
>              bql_unlock();
> +            /*
> +             * Ring-full pressure is the strongest signal that backgroun=
d
> +             * reaping should stay hot; wake the reaper unconditionally.
> +             */
> +            kvm_dirty_ring_reaper_kick();
>              dirtylimit_vcpu_execute(cpu);
>              ret =3D 0;
>              break;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index c4617caac6..b878598552 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
>      return 0;
>  }
>
> +void kvm_dirty_ring_reaper_kick(void)
> +{
> +}
> +
>  bool kvm_hwpoisoned_mem(void)
>  {
>      return false;
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda..c42c8e0b74 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -553,6 +553,15 @@ bool kvm_dirty_ring_enabled(void);
>
>  uint32_t kvm_dirty_ring_size(void);
>
> +/**
> + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> + *
> + * Hint that an immediate reap is desirable (e.g. ring-full pressure
> + * detected, dirtylimit disabled).  Coalesced via eventfd.  No-op when
> + * the dirty ring feature is not in use.
> + */
> +void kvm_dirty_ring_reaper_kick(void);
> +
>  void kvm_mark_guest_state_protected(void);
>
>  /**
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938..08e28d075a 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -12,6 +12,7 @@
>  #include "system/memory.h"
>  #include "qapi/qapi-types-common.h"
>  #include "qemu/accel.h"
> +#include "qemu/event_notifier.h"
>  #include "qemu/queue.h"
>  #include "system/kvm.h"
>  #include "accel/accel-ops.h"
> @@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
>      QemuThread reaper_thr;
>      volatile uint64_t reaper_iteration; /* iteration number of reaper th=
r */
>      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr stat=
e */
> +    /* Wakeup channel: kicked by ring-full vCPU exits, dirtylimit toggle=
, ... */
> +    EventNotifier reaper_notifier;
>  };
>  struct KVMState
>  {
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index c934ceb0de..3ee9c58479 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -393,6 +393,12 @@ void dirtylimit_change(bool start)
>          qatomic_set(&dirtylimit_quit, 0);
>      } else {
>          qatomic_set(&dirtylimit_quit, 1);
> +        /*
> +         * The reaper has been short-circuiting via the
> +         * dirtylimit_in_service() branch.  Kick it so it picks up the
> +         * policy change immediately instead of after the next 1s tick.
> +         */
> +        kvm_dirty_ring_reaper_kick();
>      }
>  }
>
> --
> 2.50.1 (Apple Git-155)
>

