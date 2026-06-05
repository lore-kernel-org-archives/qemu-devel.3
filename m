Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC64CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPp8-0004Wk-4A; Fri, 05 Jun 2026 04:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wVPp5-0004WF-Vw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:22:36 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wVPp3-0004CP-HV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:22:35 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-396779b9a7fso13848231fa.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 01:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647749; cv=none;
 d=google.com; s=arc-20240605;
 b=beMcfEj+mE5Pi1G2E32EGUzMo9cUxdDrxwPZZnEri0bglXhrcQVEvENAa3ubjUNuAH
 fdpeM8AbnfEP07FcybhAikYOhSWmcxVrfMXVvmzg+MS7JLru6TBNoB8dh1YJpebdkbid
 pW6HJIa8jKRmYUQ96lzP618KisCid1WEDDoauW5XZSx4I8fOc/c7b44wlgPeOkuawTDB
 Hb4SprqiP/t4X5LG2NGqUvl+0M7ys+sBmQrV5s10spRjbDaXEtm9UsC2i1x2m0fCKr3e
 t19jq5c5ZqCT275fAm2XJdqGrcSR9RZz70C+l40133H9Y2W7h48Gd9+mSp3CqnW9cY8H
 U3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
 fh=P5AvhEwpGW6PR/Vm2nnvPJX0qS7I1LrMms1RbUf8wfg=;
 b=jnP08zT/Z+FBdVLW/jK9KEO72pXxEs57nQFNKFEuZmzbbkWBwN9I9aO1D9nSwHi69H
 fay8brQpvJxT0sxSETl0RuMFCc2mFnH6SS/5A+djrXIqF+1YFozRI4tEsuvyfNIVUtwo
 1dVjrSJL878a24o+pST1NeOTt2DAeqgnVJjVxOadUs8jwFCJMagrZNldK/dw0lYZ0//+
 9xkOEnx+0KmdkCsrscghWeRxnctsv/cMjx6LY5pXl7fpOHo0cvZ0PA0VVXk4XldVV2Ij
 GmjaCE7VHS/YOqDFLCB+PJcZfE1UCUurkn3rFp3QhQ9h0lGm+guGxnW9uGYNpVfU+G1Y
 riTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1780647749; x=1781252549; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
 b=pq9WAeO1b/eaFPbRwS1yMMGxCJgKzDfDXqVLqpL+jq6obDpEKQ4EuI+fEDWQihcr4R
 FzE2qo3XZnZeNA3DbPidJx08KMKNSrzv0MigqgQksNhV+mxJXjaOzM3ULXCFAF7gUfP8
 oUoSWX1IrnSpGMD+kkUc0EFkPs4HYbr94s64q8lV0RiyFHpKdDw3mvcb5LnvvhCwFnBz
 wGh2UHlomPqx1z99OC/P80PaUCW+prYxG737CcJATIpDKin6susPiOpmGv0o+6Pq4kw/
 SW2iVc7sbLW90LWuIpfeFHViektZPICF+syOrxtpBNLEcHOxvsam6VdLkB9SxP3xj9wd
 DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780647749; x=1781252549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpEHuE5kPK7Pr7bmO5Kq29IlE/AYkLhUV+YgYWTUjog=;
 b=OrG5QL9NJ33Nh9RZSYBQvzMAmsco+4VvpJx1AKfOeH+pCn5reU2WE+cRLuLNCuM/IG
 d3zw5X2uLuTzDSCqukJzMSKg6bAvcAwWAqWcsc95lyC2A/HfLgY3Ox6a4ERzuOpXXGUt
 pcFE5jcL4/LG+AP9qs8dZAM+5vBPsDcZFFq27wFm8Jg7OQ05NOGhRv3FJnZ/cljcWld8
 KGWV6VJ6M7gOCtDaCFd16pgvbPVow6sqdImFeCS2Sa7zV04Zb0f8vW8pltGh0J2Jaq4R
 5YQuqRBqdr92ZhCerSsZ4oQPXC0bdW6yakUskT7iKVI0V5rxCpbHntgJdLEtlshnjLTe
 bDVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bVbuBOnH7wsfTCrPeyLX6RG4/3746x55XUAtBNxvuZTd1qRTZWEj4RMvMH27gbdUdK0yIG8A1hLke@nongnu.org
X-Gm-Message-State: AOJu0Yzy6X1nqP1giL99Yn57XyopNv6LfWvK0kGqUBflOY4jPw/j036i
 D8hb4NzINTQTvBV6pQLhP4Q557CdI/W2A0wcP1MIiffgWu+HCDrVrK1+gvxX8o4z7v5gUZNGtId
 3IHJUHnQNd58xwwkGMffk6fwjYh6DagBYuGftmWUzgA==
X-Gm-Gg: Acq92OGXL2eHBBktTn8Hdl7JSla9j63ihBjhruuiZwjFYDhEX3F99WCdcO2leWmtIEG
 YH1Jl71lVyiCEpqpxIH5Rdg5tzmzfG64LqNO591FAOBo1pFUh3mbjJM6wLnnZbD69DXIReCb8n5
 1Nl03KpDPqiYsGSPPc8bpU4efPfXkv4z86jEUfa0hQHnZRftHBGraMYPVjnM74uuR7Vk7RMT7YM
 0gBw5zYG53pWA9B79XwniRstbPDA9hXzOOZyBCIUYCr+qzUiT/GBJ1apoWrHYpzWEbpg0p3deSm
 RrEsIt58axSJv9Sw25T8
X-Received: by 2002:a05:6512:3503:b0:5aa:7363:8219 with SMTP id
 2adb3069b0e04-5aa87bbc36dmr719979e87.17.1780647749283; Fri, 05 Jun 2026
 01:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260604070029.34982-1-guobin@linux.alibaba.com>
In-Reply-To: <20260604070029.34982-1-guobin@linux.alibaba.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 5 Jun 2026 16:22:18 +0800
X-Gm-Features: AVVi8CehWLP43yLhYl0QqKHuUEMtibp5cV8zT-_XbebMEoocv3nCz5FputHBJj8
Message-ID: <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper
 thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x233.google.com
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

Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>

On Thu, Jun 4, 2026 at 3:00=E2=80=AFPM Bin Guo <guobin@linux.alibaba.com> w=
rote:
>
> The reaper polls with sleep(1) (TODO in the code) and only notices
> dirty-limit teardown at the next 1s tick.
>
> Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
> from dirtylimit_state_finalize() after dirtylimit_state has been
> cleared.  The kick must follow the NULL assignment: kicking earlier
> wakes the reaper while dirtylimit_in_service() still returns true,
> so it just loops back to wait.  A 1s fallback timeout remains as a
> liveness backstop.
>
> 20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
> cancel-ack| measured with strace on the reaper TID:
>
>     before: median 255 ms, max 502 ms
>     after:  median 0.6 ms, max  27 ms
>
> kvm_dirty_ring_reaper_init() returns int again (was made void in
> commit 43a5e377f4) to propagate event_notifier_init() failure.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
> Changes in v2:
> - Fix compilation error: kvm_init() has no Error **errp parameter, so
>   kvm_dirty_ring_reaper_init() now uses error_report() directly and
>   no longer accepts an errp argument.
> - Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
>   it already reaps synchronously (all vCPUs or the ring-full one), so
>   a background reaper kick would only be redundant or a no-op.
> - Move kick site from dirtylimit_change(false) to
>   dirtylimit_state_finalize() after dirtylimit_state =3D NULL, ensuring
>   the reaper actually proceeds past the dirtylimit_in_service() check.
>
>  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
>  accel/stubs/kvm-stub.c   |  4 ++++
>  include/system/kvm.h     |  7 +++++++
>  include/system/kvm_int.h |  3 +++
>  system/dirtylimit.c      |  2 ++
>  5 files changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 96f90ebb24..be005832bc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      } while (size);
>  }
>
> +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
> +
>  static void *kvm_dirty_ring_reaper_thread(void *data)
>  {
>      KVMState *s =3D data;
> @@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
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
> -        /*
> -         * TODO: provide a smarter timeout rather than a constant?
> -         */
> -        sleep(1);
> +
> +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> +
> +        /* Drain unconditionally so a stale event can't spin the next lo=
op. */
> +        event_notifier_test_and_clear(&r->reaper_notifier);
>
>          /* keep sleeping so that dirtylimit not be interfered by reaper =
*/
>          if (dirtylimit_in_service()) {
> @@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void *d=
ata)
>      g_assert_not_reached();
>  }
>
> -static void kvm_dirty_ring_reaper_init(KVMState *s)
> +static int kvm_dirty_ring_reaper_init(KVMState *s)
>  {
>      struct KVMDirtyRingReaper *r =3D &s->reaper;
> +    int ret;
> +
> +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> +    if (ret < 0) {
> +        error_report("Failed to initialize dirty ring reaper notifier: %=
s",
> +                     strerror(-ret));
> +        return ret;
> +    }
>
>      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
>                         kvm_dirty_ring_reaper_thread,
>                         s, QEMU_THREAD_JOINABLE);
> +    return 0;
> +}
> +
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
> @@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState *=
ms)
>      }
>
>      if (s->kvm_dirty_ring_size) {
> -        kvm_dirty_ring_reaper_init(s);
> +        ret =3D kvm_dirty_ring_reaper_init(s);
> +        if (ret < 0) {
> +            goto err;
> +        }
>      }
>
>      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
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
> index 5fa33eddda..e127a5eb37 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
>
>  uint32_t kvm_dirty_ring_size(void);
>
> +/**
> + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> + *
> + * Safe from any thread; no-op when the dirty ring is not in use.
> + */
> +void kvm_dirty_ring_reaper_kick(void);
> +
>  void kvm_mark_guest_state_protected(void);
>
>  /**
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938..c14ebc927f 100644
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
> +    /* Wakeup channel: kicked when dirty-limit is torn down. */
> +    EventNotifier reaper_notifier;
>  };
>  struct KVMState
>  {
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index c934ceb0de..a33256ade7 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
>      g_free(dirtylimit_state);
>      dirtylimit_state =3D NULL;
>
> +    kvm_dirty_ring_reaper_kick();
> +
>      trace_dirtylimit_state_finalize();
>  }
>
> --
> 2.50.1 (Apple Git-155)
>

