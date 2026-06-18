Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9176ACD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 01:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa166-0006PQ-4R; Wed, 17 Jun 2026 20:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wa15w-0006MB-1f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 20:59:00 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wa15s-0008K3-E2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 20:58:59 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aa68d7d757so465498e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781744308; cv=none;
 d=google.com; s=arc-20240605;
 b=azlWB2UyYqRKY8MeUrxNNzpouMr7XT8edXvoefyG6WeiGNtxTmKAkMrkaNomTPGGHs
 q+In9dXgdtWp7KpekPxvB4X8eEGcK5HJYq950gIs4D8LOGQmpSP0mMceZza0sH20Dj6W
 J1KgvooDMuiiiFWrb15R5kbvetiNSHOcJbmkT2NaUamc3wVqMrfqfxeJXh1MqN+vMBy5
 08v2gxIXTitxQchzdUAuuok71Olwii9bZE1TTpecada1ZOEBTyFYylJKP3HdH4h1NSnr
 gLiCiNX1NEX+nWGuvboGYpIlPqsv49pyHgJjRPyIlUzLNpyalvNi4knsJlulWvQD4Asb
 39Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
 fh=C2vyTixf302xLSsVV+DS2smT68SiXz17rN9IM9N6nEI=;
 b=QLCQVWAsnZuvYOvTYi1tjVrS4YmKifSzqVX0n72kVLNjgC+k2UWecODAHq9UDNbYnt
 mj/NmbyatgddOl4qxpcwB1AU5kCcaAdxTiAd+vEIY1LcnEHOkyTLoxLurM3wUnwKWbA1
 Yh0y32w4SK/tEdAC7fZMWjDHfDtXqc4HIM7E+0KMnfOnQbBkbQV5b5YnPtbWsjxuk1Yf
 +mIBqZcy4yFw+jNz2cseKZHdWkpmZG0goFRYNkvyedm+t7W8JbZ2KSnav2w5O1QXJSi1
 R6w0reIA6akwB9NsCjoZseMp+2bcV+eeFwzSYhjZzuWNNln9X5QaDobCNrMOrOvWXe2j
 AbSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1781744308; x=1782349108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
 b=YcL16yzolihResLKV3ZWxHaA45EQMe7Um8ysFM3baiPV6jffxJ+iXck1eI0WMKzQR9
 YNAuWTfSGQdiKVxpdHaJIARdWLOlmS90/XEqutWCgngDRMxYwbRXhj8hdV0B+yr1MGNz
 sw1+hMB9E+k3frndx8Nnp5SLProUFSgCUoHI8lJvpiggR31De6EKRVV3Vp9DlowkiNdC
 eIGVPt+yrqyUAQ9F9SY6EX26P8B2AaiHQlDzjAQ50SJozZUPDA7p4DPbD879ELvNe6RZ
 uq3l888RqqQO3hZFZNLV5n3Avy6+h1DR9fT+ka0LucIUdHaFCeMq3jNGQt8ORrlUEfcl
 I4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781744308; x=1782349108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Kca6haeo+bA5ndGmY6EX+BgtmeyApAqd1+b+zpsD3M=;
 b=IR+UkVsj8f3lYy22Qkxqjzj19p1RqnzpO2NMBb9zBI+eOAnOOr3/9I3kpuursc5/M5
 5SiETg+8VQePlDaGr5++alNKjOfvV3VjS6sVS90r0l7OrLW5V090q4O1BhxDTBNe9z6y
 Qp2X0Qfy0wg4HJiwBqN87D8o8iT6NH2bIfJbpnnWudxPqYBHwVdRdP6fnwJzkw75CIR5
 PMbRmCkP9LG/n3K/d7jLD8JQDkSBBYjnovhUtkV81kRvCsd/13ZD4LsNZIR63+4ZUjRt
 7op4E21ZXLKvVuVEb1TDOZpD7kqGUMH/dY2zHsqcRTe50NaEJm/wgp0qferI1HJpES9j
 UJCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F2/6ivuC4IJIfwaZ3vQdAZmUTHxFZ76SS9AI6t5vp+AiLbNHEVQBZFEM5iOCCBsA0p1ImjJbYfUdA@nongnu.org
X-Gm-Message-State: AOJu0YzkiW/XbTIuqnh0mcHlj1y8c2x3+u6auxr1Oad1GtEBH2celMmg
 GTXpypQjXrHdBB0xMYx+gA1X86Eu9uUTNFipfuJwChkH9fi+arf3hbxV31Pst+6z9KoMFHdO8uA
 YwF6HEmOWvrhRJNfTS4gtIHzNsDKfWMJKXPHt6YCB2w==
X-Gm-Gg: AfdE7cnnJvmTpNT6LFcolFKMYNuB7fDpxP0Wr9CDqBjVUt68IlBjYiRCa3LlpnH1kTs
 I6gOFQTyJcDrDArMgRRLbE4tEo5PCgY0C7NhiXr8SrBtrwFxOkyJlvgpSnwDlo7MsB3JA92ja9M
 SVrRfdKaRaMZtvwOQA1gNWQacwQfL6NVbWBrlY5gqHQBOQFNwFlN4C+ZALNqqmHtOGdNX2w4802
 8mscRQ0wT939kT2ZJr9SgLBbHTdKJwyF4euPsyYIZO+uWKo+B/KWUXXHsXarXbGIjcm3jJf
X-Received: by 2002:a05:6512:4505:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5ad4dac9004mr356478e87.41.1781744308586; Wed, 17 Jun 2026
 17:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260604070029.34982-1-guobin@linux.alibaba.com>
 <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
In-Reply-To: <CAFWXh4w==tF6VA1QyHWRqBX0hBE2R1Ko7u2Expwn+xv7=Fed2w@mail.gmail.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 18 Jun 2026 08:58:16 +0800
X-Gm-Features: AVVi8Cfm8jUtP1ZNvxp4Kd7bFS0JLkQTUW1aXsGc10fTA5ejVxAM2Xi7bj8wZ_w
Message-ID: <CAFWXh4x7sP-r6i9n-X7-gzkNNNqE5OegYkJZ=6TQvzhtgFLPdg@mail.gmail.com>
Subject: Re: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper
 thread
To: Bin Guo <guobin@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lf1-x12c.google.com
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

Ping=E3=80=82

Hi Paolo, could you please take a look at this patch, I=E2=80=99d appreciat=
e
your feedback on this patch.

On Fri, Jun 5, 2026 at 4:22=E2=80=AFPM Hy Man <infra.ai.cloud@bitdeer.com> =
wrote:
>
> Reviewed-by: Hyman Huang <infra.ai.cloud@bitdeer.com>
>
> On Thu, Jun 4, 2026 at 3:00=E2=80=AFPM Bin Guo <guobin@linux.alibaba.com>=
 wrote:
> >
> > The reaper polls with sleep(1) (TODO in the code) and only notices
> > dirty-limit teardown at the next 1s tick.
> >
> > Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
> > from dirtylimit_state_finalize() after dirtylimit_state has been
> > cleared.  The kick must follow the NULL assignment: kicking earlier
> > wakes the reaper while dirtylimit_in_service() still returns true,
> > so it just loops back to wait.  A 1s fallback timeout remains as a
> > liveness backstop.
> >
> > 20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
> > cancel-ack| measured with strace on the reaper TID:
> >
> >     before: median 255 ms, max 502 ms
> >     after:  median 0.6 ms, max  27 ms
> >
> > kvm_dirty_ring_reaper_init() returns int again (was made void in
> > commit 43a5e377f4) to propagate event_notifier_init() failure.
> >
> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> > ---
> > Changes in v2:
> > - Fix compilation error: kvm_init() has no Error **errp parameter, so
> >   kvm_dirty_ring_reaper_init() now uses error_report() directly and
> >   no longer accepts an errp argument.
> > - Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
> >   it already reaps synchronously (all vCPUs or the ring-full one), so
> >   a background reaper kick would only be redundant or a no-op.
> > - Move kick site from dirtylimit_change(false) to
> >   dirtylimit_state_finalize() after dirtylimit_state =3D NULL, ensuring
> >   the reaper actually proceeds past the dirtylimit_in_service() check.
> >
> >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
> >  accel/stubs/kvm-stub.c   |  4 ++++
> >  include/system/kvm.h     |  7 +++++++
> >  include/system/kvm_int.h |  3 +++
> >  system/dirtylimit.c      |  2 ++
> >  5 files changed, 52 insertions(+), 6 deletions(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 96f90ebb24..be005832bc 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *k=
ml,
> >      } while (size);
> >  }
> >
> > +#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND=
)
> > +
> >  static void *kvm_dirty_ring_reaper_thread(void *data)
> >  {
> >      KVMState *s =3D data;
> > @@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void =
*data)
> >      trace_kvm_dirty_ring_reaper("init");
> >
> >      while (true) {
> > +        GPollFD pfd =3D {
> > +            .fd =3D event_notifier_get_fd(&r->reaper_notifier),
> > +            .events =3D G_IO_IN,
> > +        };
> > +
> >          r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
> >          trace_kvm_dirty_ring_reaper("wait");
> > -        /*
> > -         * TODO: provide a smarter timeout rather than a constant?
> > -         */
> > -        sleep(1);
> > +
> > +        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
> > +
> > +        /* Drain unconditionally so a stale event can't spin the next =
loop. */
> > +        event_notifier_test_and_clear(&r->reaper_notifier);
> >
> >          /* keep sleeping so that dirtylimit not be interfered by reape=
r */
> >          if (dirtylimit_in_service()) {
> > @@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void =
*data)
> >      g_assert_not_reached();
> >  }
> >
> > -static void kvm_dirty_ring_reaper_init(KVMState *s)
> > +static int kvm_dirty_ring_reaper_init(KVMState *s)
> >  {
> >      struct KVMDirtyRingReaper *r =3D &s->reaper;
> > +    int ret;
> > +
> > +    ret =3D event_notifier_init(&r->reaper_notifier, 0);
> > +    if (ret < 0) {
> > +        error_report("Failed to initialize dirty ring reaper notifier:=
 %s",
> > +                     strerror(-ret));
> > +        return ret;
> > +    }
> >
> >      qemu_thread_create(&r->reaper_thr, "kvm-reaper",
> >                         kvm_dirty_ring_reaper_thread,
> >                         s, QEMU_THREAD_JOINABLE);
> > +    return 0;
> > +}
> > +
> > +void kvm_dirty_ring_reaper_kick(void)
> > +{
> > +    KVMState *s =3D kvm_state;
> > +
> > +    if (!s || !s->kvm_dirty_ring_size) {
> > +        return;
> > +    }
> > +    event_notifier_set(&s->reaper.reaper_notifier);
> >  }
> >
> >  static int kvm_dirty_ring_init(KVMState *s)
> > @@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState=
 *ms)
> >      }
> >
> >      if (s->kvm_dirty_ring_size) {
> > -        kvm_dirty_ring_reaper_init(s);
> > +        ret =3D kvm_dirty_ring_reaper_init(s);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> >      }
> >
> >      if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index c4617caac6..b878598552 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
> >      return 0;
> >  }
> >
> > +void kvm_dirty_ring_reaper_kick(void)
> > +{
> > +}
> > +
> >  bool kvm_hwpoisoned_mem(void)
> >  {
> >      return false;
> > diff --git a/include/system/kvm.h b/include/system/kvm.h
> > index 5fa33eddda..e127a5eb37 100644
> > --- a/include/system/kvm.h
> > +++ b/include/system/kvm.h
> > @@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
> >
> >  uint32_t kvm_dirty_ring_size(void);
> >
> > +/**
> > + * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
> > + *
> > + * Safe from any thread; no-op when the dirty ring is not in use.
> > + */
> > +void kvm_dirty_ring_reaper_kick(void);
> > +
> >  void kvm_mark_guest_state_protected(void);
> >
> >  /**
> > diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> > index 0876aac938..c14ebc927f 100644
> > --- a/include/system/kvm_int.h
> > +++ b/include/system/kvm_int.h
> > @@ -12,6 +12,7 @@
> >  #include "system/memory.h"
> >  #include "qapi/qapi-types-common.h"
> >  #include "qemu/accel.h"
> > +#include "qemu/event_notifier.h"
> >  #include "qemu/queue.h"
> >  #include "system/kvm.h"
> >  #include "accel/accel-ops.h"
> > @@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
> >      QemuThread reaper_thr;
> >      volatile uint64_t reaper_iteration; /* iteration number of reaper =
thr */
> >      volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr st=
ate */
> > +    /* Wakeup channel: kicked when dirty-limit is torn down. */
> > +    EventNotifier reaper_notifier;
> >  };
> >  struct KVMState
> >  {
> > diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> > index c934ceb0de..a33256ade7 100644
> > --- a/system/dirtylimit.c
> > +++ b/system/dirtylimit.c
> > @@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
> >      g_free(dirtylimit_state);
> >      dirtylimit_state =3D NULL;
> >
> > +    kvm_dirty_ring_reaper_kick();
> > +
> >      trace_dirtylimit_state_finalize();
> >  }
> >
> > --
> > 2.50.1 (Apple Git-155)
> >

