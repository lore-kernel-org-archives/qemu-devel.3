Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E99EC1428
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNLX-0004Yq-Uu; Tue, 03 Mar 2026 05:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNLW-0004YJ-7b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:51:22 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNLU-00057i-Dr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:51:21 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ca09f2170so5548608d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535079; cv=none;
 d=google.com; s=arc-20240605;
 b=bEdQiW5zXEBGxXVRPogsHHgTlZMWIvXzFekq3e+HLsXyP5sUgwV4IPgG+LS2VZ9f1N
 NM+RmRI+RboVKE7ADNzLwVb1AJwxJDWBXz2ySpDLyd1vEE45RHcXSvF+9iERbIBRejyL
 q6JQlczWEwV4fZp0+UoE+LLl/ZrUoJfONRQuns5nEgSE8HK0hSo86GK1CJvrLzUmy27b
 F1AAehNo1aGfUcOIvaMYYZO2GNUJRhw6momqn4vMYPEGesTNqQ8/l8b5XpNMLYbiwvFR
 sNqj7qFt1HbVtRiPv2TF1AxrM/7Itd95nCrObYMz13+Tz9g7W41Ab8T5h3VhR0c1PykZ
 c4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=miL/sZTIH3G3KbR5lZo9Es/VdDkY8PR+6X5Pv0rkeEg=;
 fh=DxWijlXe286AR+nL8xyiJ/CceyDPdSWkqDZfGRXaeOQ=;
 b=cDEZTS8MygCbXjwguFGYK46W/7L6DJl+M5YukbSHVuZF8gEldVavJy2S2Rvf3mBwfU
 tyh4DbjauXrMiVuNIoObCj6hkeL/B5V6trFSI13GNxHK5nfv+l0NLc7QxmvTlmOCjzLD
 zejNWjt443SmXoZtJ2HOeVYBBwzeLlB5qtgP9fDG9jUMqSNRP0Wytbo6mi4Rn1KBQTU2
 YPxihuPjh5VAjOVQaImxF0hppXjEFfD+HtAyCGHC84Q/jauMnDTqCCS3tZd6J5BnFZPc
 0yPWb+3suty5H9WMRbwm9kS7JlWDrO9EWPEL4PjDJc0p90A4xBHv8N/+mQbKIPZEOrvS
 Tu/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535079; x=1773139879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=miL/sZTIH3G3KbR5lZo9Es/VdDkY8PR+6X5Pv0rkeEg=;
 b=QJaLBQJ3u7e+qS4eF1UeslOUCJCIYdXU/Dj0WhBSHwyocf4GO+wcqZiHwLk5IF1Aih
 2+rnYhe3TBaOJiEnNco6nd13v0FQuEumQgpDkT3vMV4HktfZ01/HNXzEpFCECblDJh3q
 rFgOan+noKSvL94IKn9SqJWMCvnzQC9k+y16uTlQOh5Jzx5OEUAGbSOoLKb/hJBfpGm6
 W6cQ+HJu6ILzT8HZ0WSRgfbxW+BrOR8M0jHFzrgbMEAuX6AUqrQgtK5U7olmUCPrCwb8
 SAxgyMZYNqm7dgKiWBwBeo4pLL7uQBFOrpddCHCsLMOnGp8Hj/f7Xam9UYUZwXaMTZqM
 IcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535079; x=1773139879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miL/sZTIH3G3KbR5lZo9Es/VdDkY8PR+6X5Pv0rkeEg=;
 b=IRnJjZxd4JYp5oCvuYxt3iPRXPx6DcWuO6Kzi3EHWaTvrW8I3S5V009KB0otk4Ihfn
 u1OHyivTo5zVDvf8DCaXKlck9hmhJAm2GEWxOWRxoE4XqJ4s/x9PLXoGOasRjlb5LgRc
 qF8lbI7b5ghJn8vX4geM81j8CKG56VDSwyZmy4X+4j0kwR+wVlMk9AA9g/9wwV6VVooZ
 7QY7W8/6II5omgnx/zz9my80erhlIJ52tU//k6sem0W4q7vOw1QdoVoDqyDKREmh41Eq
 kZDEkjfhALqgqRPBN2CjYrvxT6N5vZFKoao/2bMjWiu3z87f0tQK9j+eAihA+I9TIQVR
 Qv0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX32puApRIsA1XnBPcp/hqYz90xdrPd9l4clIsTbiVXapxosvcoyWDR+5F2OMkI6u7U5HHt81zNuXh@nongnu.org
X-Gm-Message-State: AOJu0Yz1+Tmc4sIBPki1pVEs9pbnEQbCrHSt9ny/+lAxNpEfoAp7tI4B
 TBbE2vs6BybvnH5alR0DmmHAzqZdAW50TlVgrGOewpdWryvjQ8s+WQS1WLZer98yOSLGzag0l73
 Uj+cSBxyp0lQtMYeazucK2O5qVCpriIzh5I+bljJxG8YWDAd6lZNG
X-Gm-Gg: ATEYQzx0g3+j1IaB+AXXy+i4bBrssHDdLVBOgnGaUaxhyHoGdLJ6NWY8ySaC9zeShH2
 jHwleMTu6IXF4elO3LxDtmIdW88StvjhhPCpZzPqBTInrOc3xN7M5Xso+WHP7Q8jp1EiMBjEmWN
 MV9wtDaQhsZLHMQhpnGwn47rXDq8vkfO0FlLZ4Sk04NYxKgCaN1MsehPlPSEUjw6q9rY2wAFCT9
 9otQoZXdHBH20zQTBXhpctQJxPgQSpLjm5TfH3LMlEGjRbAnlfPqCfiqWeW+C/SoYeXTPaGDGXZ
 tGMyQHMK9ZMEcKhUEfB/ri9hJyb4K1Y8IxAbHt7WFWGm/tO5CpuVCzM7q3CWhkG2UbE=
X-Received: by 2002:a05:690e:4499:b0:649:c7dd:d2e7 with SMTP id
 956f58d0204a3-64cc217f050mr11252874d50.33.1772535079136; Tue, 03 Mar 2026
 02:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-3-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:51:06 +0000
X-Gm-Features: AaiRm50_5CkSmBqV-J1e2zUj2BybBLYbkssVgtYvocltSpZ7iPMhYQtLLxVWo_w
Message-ID: <CAFEAcA800joxbtiwBhnqXvRpbkrKsJj+1QDg_h-DPhb7TbF5=w@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
 for cpreg arrays
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 26 Feb 2026 at 10:02, Eric Auger <eric.auger@redhat.com> wrote:
>
> This removes the need for explicitly allocating cpreg_vmstate arrays.
> On post save we simply point to cpreg arrays and set the length
> accordingly.
>
> Remove VMSTATE_VARRAY_INT32 for cpreg_vmstate_array_len as now
> the array is dynamically allocated.
>
> Also add a trace point on post_load to trace potential mismatch
> between the number of incoming cpregs versus current ones.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c     |  5 -----
>  target/arm/kvm.c        |  5 -----
>  target/arm/machine.c    | 24 +++++++++++++-----------
>  target/arm/trace-events |  3 +++

target/arm/whpx/whpx-all.c also has the code to
initialize cpureg_vmstate_{indexes,values,array_len}
that needs to be updated like the TCG and KVM code.

>  4 files changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6bfab90981c..7389f2988c4 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -265,15 +265,10 @@ void arm_init_cpreg_list(ARMCPU *cpu)
>      if (arraylen) {
>          cpu->cpreg_indexes = g_new(uint64_t, arraylen);
>          cpu->cpreg_values = g_new(uint64_t, arraylen);
> -        cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
> -        cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
>      } else {
>          cpu->cpreg_indexes = NULL;
>          cpu->cpreg_values = NULL;
> -        cpu->cpreg_vmstate_indexes = NULL;
> -        cpu->cpreg_vmstate_values = NULL;
>      }
> -    cpu->cpreg_vmstate_array_len = arraylen;
>      cpu->cpreg_array_len = 0;
>
>      g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ded582e0da0..12a75f42e07 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -807,12 +807,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>
>      cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
>      cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
> -    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
> -                                         arraylen);
> -    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
> -                                        arraylen);
>      cpu->cpreg_array_len = arraylen;
> -    cpu->cpreg_vmstate_array_len = arraylen;
>
>      for (i = 0, arraylen = 0; i < rlp->n; i++) {
>          uint64_t regidx = rlp->reg[i];
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index bbaae344492..214087111bc 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "trace.h"
>  #include "qemu/error-report.h"
>  #include "system/kvm.h"
>  #include "system/tcg.h"
> @@ -984,11 +985,9 @@ static int cpu_pre_save(void *opaque)
>          }
>      }
>
> +    cpu->cpreg_vmstate_indexes = cpu->cpreg_indexes;
> +    cpu->cpreg_vmstate_values = cpu->cpreg_values;
>      cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
> -    memcpy(cpu->cpreg_vmstate_indexes, cpu->cpreg_indexes,
> -           cpu->cpreg_array_len * sizeof(uint64_t));
> -    memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
> -           cpu->cpreg_array_len * sizeof(uint64_t));

This is OK for pre-save, but it could use a comment, maybe
something like:

/*
 * On outbound migration, send the data in our cpreg_{values,indexes}
 * arrays. The migration code will not allocate anything, but just
 * reads the data pointed to by the VMSTATE_VARRAY_INT32_ALLOC() fields.
 */

>
>      return 0;
>  }
> @@ -1043,6 +1042,9 @@ static int cpu_post_load(void *opaque, int version_id)
>      CPUARMState *env = &cpu->env;
>      int i, v;
>
> +    trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
> +                        cpu->cpreg_array_len);
> +
>      /*
>       * Handle migration compatibility from old QEMU which didn't
>       * send the irq-line-state subsection. A QEMU without it did not

On post-load, something seems to be missing. The migration core
code will have allocated (with g_malloc()) the memory for the
arrays. When the post-load hook has finished checking and copying
the data out of there it needs to free that memory (and probably
set the pointers back to NULL to make accidental use-after-free easier
to spot). Otherwise we will leak the memory if we do an incoming
migration followed by an outbound migration.

Maybe we should enforce that these fields are always NULL/0 except
during a migration, by having:
 pre_save points them to the cpreg_indexes/cpreg_values arrays
 post_save sets them to NULL/0
 pre_load (maybe) asserts them as NULL?
 post_load uses the data and then frees it and sets them to NULL/0

and note that in the comment in cpu.h on the fields.

> @@ -1170,13 +1172,13 @@ const VMStateDescription vmstate_arm_cpu = {
>          /* The length-check must come before the arrays to avoid
>           * incoming data possibly overflowing the array.
>           */

This comment needs to be updated -- we still need the length first,
but it's no longer a length-check, and the reason is different:
we need to receive the length first so we can allocate the arrays
before their data arrives.

> -        VMSTATE_INT32_POSITIVE_LE(cpreg_vmstate_array_len, ARMCPU),
> -        VMSTATE_VARRAY_INT32(cpreg_vmstate_indexes, ARMCPU,
> -                             cpreg_vmstate_array_len,
> -                             0, vmstate_info_uint64, uint64_t),
> -        VMSTATE_VARRAY_INT32(cpreg_vmstate_values, ARMCPU,
> -                             cpreg_vmstate_array_len,
> -                             0, vmstate_info_uint64, uint64_t),
> +        VMSTATE_INT32(cpreg_vmstate_array_len, ARMCPU),
> +        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_indexes, ARMCPU,
> +                                   cpreg_vmstate_array_len,
> +                                   0, vmstate_info_uint64, uint64_t),
> +        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_values, ARMCPU,
> +                                   cpreg_vmstate_array_len,
> +                                   0, vmstate_info_uint64, uint64_t),
>          VMSTATE_UINT64(env.exclusive_addr, ARMCPU),
>          VMSTATE_UINT64(env.exclusive_val, ARMCPU),
>          VMSTATE_UINT64(env.exclusive_high, ARMCPU),
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 676d29fe516..2de0406f784 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -26,3 +26,6 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
>
>  # tcg/psci.c and hvf/hvf.c
>  arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
> +
> +# machine.c
> +cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
> --
> 2.53.0

thanks
-- PMM

