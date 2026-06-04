Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EBECD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUxrt-00038I-7x; Wed, 03 Jun 2026 22:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wUxrj-00036R-Oe
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:31:28 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wUxrf-0000H3-1H
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:31:27 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-39657d28132so991151fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 19:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780540277; cv=none;
 d=google.com; s=arc-20240605;
 b=IMQNdpmNIooqeaP6DRt/l+xvQEZ+rxu3bkqtBdBFoTD8b64e8YisoxLIprRPx0aPuW
 vA/arIVIq+sX28IfU4s8gSQI2v0yJM1AQknsa+7OUqK5IzW0mgtiHi8Cj55YmlhZNHsJ
 O/rtq2fsAOUIJSyA+B5k73UUtgHhwTeoVZalRMGdnkCUow5b5AcAYkD+UesSVSfXh8SM
 JP0SoRoTFjKCXnAnQ25zRkVhEGsoqbO6YlGxTZb+nzh3dJqaq0i6gT+YeXBK0duUg2JS
 kFnMYhYq7sw/N0uOxpjbbT6z0F2E6pWFQgO0ZYBE6hM0OGtfVZwQts8drNwRA1Gq21Jg
 iIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2oo+CMQOODaPa7P0Xom5u7QfUaA8hXzkPq3nSwzZTvk=;
 fh=V8WSqJrcdCEqqnLPfIBRvUappUhgn/Nw1a0Q5QNc0Jk=;
 b=LbwPb4ZtGLkVFNjzBL0La+i1SzgGiIxOd3kppSSNQDYywerMiywa4C+J9YhgULEw/q
 RduO3LeZD6cE75UjKQSLwD0DjTtphTk5S17NKBc/UImtYWXjggFkBKau3/uKg/7p5dhF
 r6IUcFe4aginxq4k9Ln0y27MtYHEwr70htB3RTb71jiUEoKfh0+w6A2sBubaTI1hFwOo
 KwIRYn2pbm1E2FBhwKBNoNTG5+NdfOXdKEboiqaRW7Tyc/p/vPK8H0b09t7YXPMKPJPe
 g7ngkwbhZGmc6IpiQ4aS1LUByRPzX0CKDfJPbT3nk/a4QGGv8S6cjHRKm5U0dHca3KFm
 mJWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1780540277; x=1781145077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2oo+CMQOODaPa7P0Xom5u7QfUaA8hXzkPq3nSwzZTvk=;
 b=CY2//13Z+s/I+dXwc8j4FJuXK8Hc40XZO2JUXsPNaVcEHlvtUSW7Q7ln6vnxKrdx57
 0yZJrEwWopI4+4ksAfNRb99psiUyF1zAwZlLt21VTWGd2LtrHnsEDSUU9HgTgAvzc7DF
 s43p0FNPFjDMZaey1TaFXpa7uSfImJVEPQc3IUkUogUMb+UthIvPP5ExBN97WfgGVDbE
 GTD4PyoGXrQhnjSxYSKNAVv7fwAM9fau7QnkM1IgbgjhNjlm0NiBlV1dyrsFzILJqedF
 LczcQnEbfI/kVZgp6BgKmaTw5NXf9XgkloFFnS+gFrsLNyM5rXm5h/W+Nk0+vtiWawNk
 p+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780540277; x=1781145077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oo+CMQOODaPa7P0Xom5u7QfUaA8hXzkPq3nSwzZTvk=;
 b=WVQ1za/Vq2KruCIkehFAry9wslBbCy2pamaZSA8G6PhFFmN5blOT5sJEPKcu3gPf7f
 Swub8LHSQKHyLOB64hLyNH3JWJE5mKa+kcL5TjDHe+xPZ6ImO5UKhmKHV7c9NkuD6Khq
 ywo3qy2ugZBsUr1s4flRJ9HWMtKARxjC/JIGivZjSZv0+8ZpKgO4pMd95CI+aUArG84K
 qoVBqmf6oeB49YoVZ4SBczlIjTCg/3sU/XmMeEvvqg2hDT5e2c3BjwAgYU8AlmTirhxk
 a/Vyr9atSQ8cmXIIJd94ivsABEyYoYn53j+xh4E/W8L6NiuWiCRzvmNcO+NyO4DCnNam
 BLJw==
X-Gm-Message-State: AOJu0Yy+4ky6IWwwu4UPl1miGtarIXE63b7AbZnwxijPmMGb6gJi8bYE
 JuSnqwZic+t34fH8soBP6kkXbDuQgnSsRWCCwacdGqxPaSC7KL83JhnDeQgzoqsZI+jgz7kFN39
 RNexF0mKlVcWYcfIdTnxcd9hLvTy8LE/gllIrIns4UA==
X-Gm-Gg: Acq92OFk9Z+ZLJX7Lw+T0TkWjOT7m2QEkSio9sk4ZAIZ3XR0e3IKQqOQ95BMqa6TtGn
 +mCUVsm4onJAXeZR4aSfuoM8TPe62fgJU/mmjZuUg3a6rVMLmDiw0/ZFGzMdNYlEZQxlR2bfr69
 BfnsAQdX5zxMesLmNfcIli6e4tDRCSz1ZMjXMVV6Pt4o8U+MrOOrJz0wBSfbnYsH4wkUtXpOtCX
 attutXLwEGBFe7o84Z+WaE2Uqx7enSJPQoUR6YwJ/cH6GE7YIyM6WJNuR625GjSClKligVpS8GE
 owGAx4u+y+gH5GWF80Gs/C8UVv/nvVQ=
X-Received: by 2002:a2e:a9a3:0:b0:396:375:aa7f with SMTP id
 38308e7fff4ca-396af14fb6emr14991041fa.10.1780540276599; Wed, 03 Jun 2026
 19:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260603031612.6173-1-guobin@linux.alibaba.com>
In-Reply-To: <20260603031612.6173-1-guobin@linux.alibaba.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 4 Jun 2026 10:31:05 +0800
X-Gm-Features: AVHnY4I8b5OdZpgFdx30205R5OM0QV5Zb1S-FSq4C66xAutnUc_Edc8dI8_bXQ0
Message-ID: <CAFWXh4xc83KuhT7uDbF7vZNzd_RnaRkLs0bFAgg=6MXaUtssQw@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: event-driven wakeup for dirty ring reaper
 thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000b2094f06536456fc"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000b2094f06536456fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The patch looks good to me overall, but I encountered a compilation error
(see details below). I suspect it might have been tested on a
vendor-specific
version; could you please re-verify it against the latest mainline version?
I=E2=80=99ll be happy to merge it once the build issue is resolved.

On Wed, Jun 3, 2026 at 11:16=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com> =
wrote:

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
> @@ -1764,12 +1767,30 @@ static void *kvm_dirty_ring_reaper_thread(void
> *data)
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
> @@ -1789,13 +1810,39 @@ static void *kvm_dirty_ring_reaper_thread(void
> *data)
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
> +                         "Failed to initialize dirty ring reaper
> notifier");
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
>

Compilation error: 'errp' is undefined in this context.

+        if (kvm_dirty_ring_reaper_init(s, errp) < 0) {
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
r
> */
>      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr stat=
e
> */
> +    /* Wakeup channel: kicked by ring-full vCPU exits, dirtylimit toggle=
,
> ... */
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
>

--000000000000b2094f06536456fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The patch looks good to me overall, but I encountered=
 a compilation error <br>(see details below). I suspect it might have been =
tested on a vendor-specific<br>version; could you please re-verify it again=
st the latest mainline version? <br>I=E2=80=99ll be happy to merge it once =
the build issue is resolved.</div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, 2026 at 11=
:16=E2=80=AFAM Bin Guo &lt;<a href=3D"mailto:guobin@linux.alibaba.com">guob=
in@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The dirty ring reaper thread polls with a fixed sleep(1=
), which the<br>
code itself flags with a TODO for a smarter timeout.=C2=A0 Events that<br>
would benefit from a prompt reap must wait up to one full sleep tick<br>
before the reaper notices them.<br>
<br>
Replace the polling loop with an EventNotifier-based wait via<br>
qemu_poll_ns(), kicked by paths that have first-hand evidence that<br>
a reap is desirable.=C2=A0 A 1s fallback timeout is retained as a<br>
defensive backstop.<br>
<br>
Two kick sites are wired up:<br>
<br>
=C2=A0 * dirtylimit_change(false) -- when dirty-limit is cancelled, kick<br=
>
=C2=A0 =C2=A0 the reaper so it resumes real reaping immediately instead of<=
br>
=C2=A0 =C2=A0 waiting for the next sleep tick.<br>
<br>
=C2=A0 =C2=A0 Measured with strace on the reaper TID (20 set/cancel cycles<=
br>
=C2=A0 =C2=A0 against a stress-ng dirty-page workload), latency from the<br=
>
=C2=A0 =C2=A0 cancel-vcpu-dirty-limit QMP ack to the reaper actually waking=
:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 before: median 530ms, max 937ms<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 after:=C2=A0 median &lt;1ms,=C2=A0 max &lt;1ms<=
br>
<br>
=C2=A0 * kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler -- the handler<br>
=C2=A0 =C2=A0 already reaps the exiting vCPU synchronously; the kick hints =
the<br>
=C2=A0 =C2=A0 reaper to also check other vCPUs whose rings are likely filli=
ng<br>
=C2=A0 =C2=A0 concurrently.<br>
<br>
kvm_dirty_ring_reaper_kick() is exposed as a public API; multiple<br>
kicks collapse into a single wake via the eventfd counter.<br>
kvm_dirty_ring_reaper_init() now returns int again (it was made void<br>
in commit 43a5e377f4) to propagate event_notifier_init() failure.<br>
A stub is added for non-KVM builds.<br>
<br>
Signed-off-by: Bin Guo &lt;<a href=3D"mailto:guobin@linux.alibaba.com" targ=
et=3D"_blank">guobin@linux.alibaba.com</a>&gt;<br>
---<br>
=C2=A0accel/kvm/kvm-all.c=C2=A0 =C2=A0 =C2=A0 | 62 ++++++++++++++++++++++++=
+++++++++++++---<br>
=C2=A0accel/stubs/kvm-stub.c=C2=A0 =C2=A0|=C2=A0 4 +++<br>
=C2=A0include/system/kvm.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++++<br>
=C2=A0include/system/kvm_int.h |=C2=A0 3 ++<br>
=C2=A0system/dirtylimit.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++<br>
=C2=A05 files changed, 80 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
index 96f90ebb24..f964102f09 100644<br>
--- a/accel/kvm/kvm-all.c<br>
+++ b/accel/kvm/kvm-all.c<br>
@@ -1754,6 +1754,9 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,<=
br>
=C2=A0 =C2=A0 =C2=A0} while (size);<br>
=C2=A0}<br>
<br>
+/* Fallback liveness timeout for the dirty ring reaper, in nanoseconds. */=
<br>
+#define KVM_DIRTY_RING_REAPER_FALLBACK_NS=C2=A0 (1 * NANOSECONDS_PER_SECON=
D)<br>
+<br>
=C2=A0static void *kvm_dirty_ring_reaper_thread(void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0KVMState *s =3D data;<br>
@@ -1764,12 +1767,30 @@ static void *kvm_dirty_ring_reaper_thread(void *dat=
a)<br>
=C2=A0 =C2=A0 =C2=A0trace_kvm_dirty_ring_reaper(&quot;init&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GPollFD pfd =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .fd =3D event_notifier_get_fd(&a=
mp;r-&gt;reaper_notifier),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .events =3D G_IO_IN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r-&gt;reaper_state =3D KVM_DIRTY_RING_REA=
PER_WAIT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_kvm_dirty_ring_reaper(&quot;wait&qu=
ot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: provide a smarter timeout rather=
 than a constant?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Event-driven wait: sleep until somethi=
ng kicks the reaper<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (vCPU ring-full exit, dirtylimit disab=
led, ...) or until the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* fallback timeout fires.=C2=A0 The fall=
back preserves the original<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* sleep(1) worst-case behaviour as a liv=
eness backstop in case<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a kick site is ever missed.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_poll_ns(&amp;pfd, 1, KVM_DIRTY_RING_REAPE=
R_FALLBACK_NS);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Drain the notifier whether or not the =
wakeup came from it --<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any pending kick is satisfied by the r=
eap we are about to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* perform, so we must not leave a stale =
event behind that would<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* cause the next iteration to spin witho=
ut sleeping.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_notifier_test_and_clear(&amp;r-&gt;reape=
r_notifier);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep sleeping so that dirtylimit not b=
e interfered by reaper */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dirtylimit_in_service()) {<br>
@@ -1789,13 +1810,39 @@ static void *kvm_dirty_ring_reaper_thread(void *dat=
a)<br>
=C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0}<br>
<br>
-static void kvm_dirty_ring_reaper_init(KVMState *s)<br>
+static int kvm_dirty_ring_reaper_init(KVMState *s, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct KVMDirtyRingReaper *r =3D &amp;s-&gt;reaper;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D event_notifier_init(&amp;r-&gt;reaper_notifier, 0);<=
br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to initialize dirty ring reaper notifier&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_thread_create(&amp;r-&gt;reaper_thr, &quot;kvm-rea=
per&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvm_dirty_ring_reaper_thread,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s, QEMU_THREAD_JOINABLE);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+/*<br>
+ * Wake the dirty ring reaper thread so it performs a reap as soon as<br>
+ * possible.=C2=A0 Safe to call from any thread; safe to call even when th=
e<br>
+ * dirty ring is not enabled (no-op in that case).=C2=A0 Coalescing is<br>
+ * provided by the eventfd counter -- multiple kicks before the reaper<br>
+ * runs collapse into a single wakeup.<br>
+ */<br>
+void kvm_dirty_ring_reaper_kick(void)<br>
+{<br>
+=C2=A0 =C2=A0 KVMState *s =3D kvm_state;<br>
+<br>
+=C2=A0 =C2=A0 if (!s || !s-&gt;kvm_dirty_ring_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 event_notifier_set(&amp;s-&gt;reaper.reaper_notifier);<br>
=C2=A0}<br>
<br>
=C2=A0static int kvm_dirty_ring_init(KVMState *s)<br>
@@ -3097,7 +3144,9 @@ static int kvm_init(AccelState *as, MachineState *ms)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;kvm_dirty_ring_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_dirty_ring_reaper_init(s);<br></blockquote=
><div>=C2=A0</div><div>Compilation error: &#39;errp&#39; is undefined in th=
is context.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_dirty_ring_reaper_init(s, errp) &lt; 0=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS=
_FD)) {<br>
@@ -3571,6 +3620,11 @@ int kvm_cpu_exec(CPUState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvm_dirty_rin=
g_reap(kvm_state, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Ring-full pressure is th=
e strongest signal that background<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* reaping should stay hot;=
 wake the reaper unconditionally.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_dirty_ring_reaper_kick();<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirtylimit_vcpu_execute(cpu=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c<br>
index c4617caac6..b878598552 100644<br>
--- a/accel/stubs/kvm-stub.c<br>
+++ b/accel/stubs/kvm-stub.c<br>
@@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+void kvm_dirty_ring_reaper_kick(void)<br>
+{<br>
+}<br>
+<br>
=C2=A0bool kvm_hwpoisoned_mem(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
diff --git a/include/system/kvm.h b/include/system/kvm.h<br>
index 5fa33eddda..c42c8e0b74 100644<br>
--- a/include/system/kvm.h<br>
+++ b/include/system/kvm.h<br>
@@ -553,6 +553,15 @@ bool kvm_dirty_ring_enabled(void);<br>
<br>
=C2=A0uint32_t kvm_dirty_ring_size(void);<br>
<br>
+/**<br>
+ * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.<br>
+ *<br>
+ * Hint that an immediate reap is desirable (e.g. ring-full pressure<br>
+ * detected, dirtylimit disabled).=C2=A0 Coalesced via eventfd.=C2=A0 No-o=
p when<br>
+ * the dirty ring feature is not in use.<br>
+ */<br>
+void kvm_dirty_ring_reaper_kick(void);<br>
+<br>
=C2=A0void kvm_mark_guest_state_protected(void);<br>
<br>
=C2=A0/**<br>
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h<br>
index 0876aac938..08e28d075a 100644<br>
--- a/include/system/kvm_int.h<br>
+++ b/include/system/kvm_int.h<br>
@@ -12,6 +12,7 @@<br>
=C2=A0#include &quot;system/memory.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-types-common.h&quot;<br>
=C2=A0#include &quot;qemu/accel.h&quot;<br>
+#include &quot;qemu/event_notifier.h&quot;<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;system/kvm.h&quot;<br>
=C2=A0#include &quot;accel/accel-ops.h&quot;<br>
@@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {<br>
=C2=A0 =C2=A0 =C2=A0QemuThread reaper_thr;<br>
=C2=A0 =C2=A0 =C2=A0volatile uint64_t reaper_iteration; /* iteration number=
 of reaper thr */<br>
=C2=A0 =C2=A0 =C2=A0volatile enum KVMDirtyRingReaperState reaper_state; /* =
reap thr state */<br>
+=C2=A0 =C2=A0 /* Wakeup channel: kicked by ring-full vCPU exits, dirtylimi=
t toggle, ... */<br>
+=C2=A0 =C2=A0 EventNotifier reaper_notifier;<br>
=C2=A0};<br>
=C2=A0struct KVMState<br>
=C2=A0{<br>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c<br>
index c934ceb0de..3ee9c58479 100644<br>
--- a/system/dirtylimit.c<br>
+++ b/system/dirtylimit.c<br>
@@ -393,6 +393,12 @@ void dirtylimit_change(bool start)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qatomic_set(&amp;dirtylimit_quit, 0);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qatomic_set(&amp;dirtylimit_quit, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The reaper has been short-circuiting v=
ia the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* dirtylimit_in_service() branch.=C2=A0 =
Kick it so it picks up the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* policy change immediately instead of a=
fter the next 1s tick.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_dirty_ring_reaper_kick();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div></div>

--000000000000b2094f06536456fc--

