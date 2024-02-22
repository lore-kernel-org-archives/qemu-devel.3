Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D230C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdA41-0005eW-GD; Thu, 22 Feb 2024 09:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdA40-0005eO-V3
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:28:40 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdA3w-0006L0-0B
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:28:40 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so2787384a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708612114; x=1709216914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eC+CYy2oEug9+rMCzsvGNr80fqPIx2W2fhrxncPzcUU=;
 b=RHK4S1jK+r8xTS1Z7X41NcalgIXrcmxVUjSutwuHuyIOADW7bchP06B/mIJ0AZP2Jf
 qC5Ml5hla11Zx46j3LPPV0lbnj9fbtMy0MO1Asxu9YMWY9vLn60nD+ohyZWRbPYdyM4h
 mjOv8/jkPrrnQqOKPkBU4KCTGssQVnU2oeCLb6vsY+sQ5keh2qhB2LrygvQzjsHmmw++
 NepfYVJPqSmEelsJdIZLJ3H9hBSDNq3p2WbvgtvOM449VlnDOD4BwIvtGY3gnLb0HN0o
 fApqRywN6Sne5/PuuIom1LcY5By+MPfd0DDxOAVW7/TLfR1QvRtR8l14+kJHQ7g6amUc
 sRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708612114; x=1709216914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eC+CYy2oEug9+rMCzsvGNr80fqPIx2W2fhrxncPzcUU=;
 b=RqdGqNuE7Gzsv972RchmQZryrE6ZlVp8D9hV8Zel72fNjojgdktkHT2aEd5hbRqXm3
 G2Pkq/qz50PXO9ipdfAyyalCskfAmUhd2xiSwerBCJqdZNeoEPr6d/BW87NGgGnBPLUp
 9UZdpnUNYw1VJ89W86UpfKCTJibdMjN3VHC8seN3qyteS+Q/PWF0qzIAuNe5xIEu298o
 ooWZbELApy21mYHmZcK2kcmbKo8xKHvkI3r2q0IpwCU5nEGZ2QlSSM+iI3xwIWDgCo+8
 enXjvQUhUibIEKc/l9usmr9harrHDLEehSgfByl3aTplpBAeQhb/2izyfx2SBdKKQLYV
 2QmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPeaOlaczHt2CHLiCGl4B3pVH75+eCW4DO7AHGgiB5DlCm67yrPNvu0001O9m2LE0EUDQ5941RLFdpXmoqgfSnrFsRHbI=
X-Gm-Message-State: AOJu0Yxgx+Aa883EJsB0zU1eHz2VeElMLSpqTlthQTk/kWrEIW3KYW9d
 /v5l89O5kENAEAlK6+j4F7hz8/KaSY6sOT83W34//oQP8OvM9NNn28Oukry9R3ajV1pS/2HUcMe
 p5fIALpD/C/dv3/g6rcOVvlm0pEGoI4E2/W17K1qwr+iw0WZP
X-Google-Smtp-Source: AGHT+IHGGZd198Umwm6cmbEPRtl4kxak3bT5a7pDH9biI6YaDN0S4+0apb2JWG0jrJmJoKkPaMS7NeVGTGmdlOSqYX4=
X-Received: by 2002:a50:bb2e:0:b0:565:11c5:c7db with SMTP id
 y43-20020a50bb2e000000b0056511c5c7dbmr2909011ede.5.1708612113988; Thu, 22 Feb
 2024 06:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20240221063431.76992-1-shahuang@redhat.com>
In-Reply-To: <20240221063431.76992-1-shahuang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:28:22 +0000
Message-ID: <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>, 
 Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 at 06:34, Shaoqin Huang <shahuang@redhat.com> wrote:
>
> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
> which PMU events are provided to the guest. Add a new option
> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
> Without the filter, all PMU events are exposed from host to guest by
> default. The usage of the new sub-option can be found from the updated
> document (docs/system/arm/cpu-features.rst).
>
> Here is an example which shows how to use the PMU Event Filtering, when
> we launch a guest by use kvm, add such command line:
>
>   # qemu-system-aarch64 \
>         -accel kvm \
>         -cpu host,kvm-pmu-filter="D:0x11-0x11"
>
> Since the first action is deny, we have a global allow policy. This
> filters out the cycle counter (event 0x11 being CPU_CYCLES).
>
> And then in guest, use the perf to count the cycle:
>
>   # perf stat sleep 1
>
>    Performance counter stats for 'sleep 1':
>
>               1.22 msec task-clock                       #    0.001 CPUs utilized
>                  1      context-switches                 #  820.695 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 55      page-faults                      #   45.138 K/sec
>    <not supported>      cycles
>            1128954      instructions
>             227031      branches                         #  186.323 M/sec
>               8686      branch-misses                    #    3.83% of all branches
>
>        1.002492480 seconds time elapsed
>
>        0.001752000 seconds user
>        0.000000000 seconds sys
>
> As we can see, the cycle counter has been disabled in the guest, but
> other pmu events do still work.
>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> v6->v7:
>   - Check return value of sscanf.
>   - Improve the check condition.
>
> v5->v6:
>   - Commit message improvement.
>   - Remove some unused code.
>   - Collect Reviewed-by, thanks Sebastian.
>   - Use g_auto(Gstrv) to replace the gchar **.          [Eric]
>
> v4->v5:
>   - Change the kvm-pmu-filter as a -cpu sub-option.     [Eric]
>   - Comment tweak.                                      [Gavin]
>   - Rebase to the latest branch.
>
> v3->v4:
>   - Fix the wrong check for pmu_filter_init.            [Sebastian]
>   - Fix multiple alignment issue.                       [Gavin]
>   - Report error by warn_report() instead of error_report(), and don't use
>   abort() since the PMU Event Filter is an add-on and best-effort feature.
>                                                         [Gavin]
>   - Add several missing {  } for single line of code.   [Gavin]
>   - Use the g_strsplit() to replace strtok().           [Gavin]
>
> v2->v3:
>   - Improve commits message, use kernel doc wording, add more explaination on
>     filter example, fix some typo error.                [Eric]
>   - Add g_free() in kvm_arch_set_pmu_filter() to prevent memory leak. [Eric]
>   - Add more precise error message report.              [Eric]
>   - In options doc, add pmu-filter rely on KVM_ARM_VCPU_PMU_V3_FILTER support in
>     KVM.                                                [Eric]
>
> v1->v2:
>   - Add more description for allow and deny meaning in
>     commit message.                                     [Sebastian]
>   - Small improvement.                                  [Sebastian]
>
>  docs/system/arm/cpu-features.rst | 23 +++++++++
>  target/arm/cpu.h                 |  3 ++
>  target/arm/kvm.c                 | 80 ++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)

The new syntax for the filter property seems quite complicated.
I think it would be worth testing it with a new test in
tests/qtest/arm-cpu-features.c.


> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index a5fb929243..7c8f6a60ef 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -204,6 +204,29 @@ the list of KVM VCPU features and their descriptions.
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>
> +``kvm-pmu-filter``
> +  By default kvm-pmu-filter is disabled. This means that by default all pmu

"PMU"

> +  events will be exposed to guest.
> +
> +  KVM implements PMU Event Filtering to prevent a guest from being able to
> +  sample certain events. It depends on the KVM_ARM_VCPU_PMU_V3_FILTER
> +  attribute supported in KVM. It has the following format:
> +
> +  kvm-pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
> +
> +  The A means "allow" and D means "deny", start is the first event of the
> +  range and the end is the last one. The first registered range defines
> +  the global policy(global ALLOW if the first @action is DENY, global DENY

Missing space before '('.

Why the '@' before 'action'?

> +  if the first @action is ALLOW). The start and end only support hexadecimal
> +  format. For example:
> +
> +  kvm-pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
> +
> +  Since the first action is allow, we have a global deny policy. It
> +  will allow event 0x11 (The cycle counter), events 0x23 to 0x3a are

lowercase "the".

> +  also allowed except the event 0x30 which is denied, and all the other
> +  events are denied.
> +

Did you check that the documentation builds and that this new
documentation renders into HTML the way you want it?

>  TCG VCPU Features
>  =================
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 63f31e0d98..f7f2431755 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -948,6 +948,9 @@ struct ArchCPU {
>
>      /* KVM steal time */
>      OnOffAuto kvm_steal_time;
> +
> +    /* KVM PMU Filter */
> +    char *kvm_pmu_filter;
>  #endif /* CONFIG_KVM */
>
>      /* Uniprocessor system with MP extensions */
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 81813030a5..5c62580d34 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -496,6 +496,22 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>
> +static char *kvm_pmu_filter_get(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return g_strdup(cpu->kvm_pmu_filter);
> +}
> +
> +static void kvm_pmu_filter_set(Object *obj, const char *pmu_filter,
> +                               Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    g_free(cpu->kvm_pmu_filter);
> +    cpu->kvm_pmu_filter = g_strdup(pmu_filter);
> +}
> +
>  /* KVM VCPU properties should be prefixed with "kvm-". */
>  void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>  {
> @@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>                               kvm_steal_time_set);
>      object_property_set_description(obj, "kvm-steal-time",
>                                      "Set off to disable KVM steal time.");
> +
> +    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
> +                            kvm_pmu_filter_set);
> +    object_property_set_description(obj, "kvm-pmu-filter",
> +                                    "PMU Event Filtering description for "
> +                                    "guest PMU. (default: NULL, disabled)");
>  }
>
>  bool kvm_arm_pmu_supported(void)
> @@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
>      return true;
>  }
>
> +static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
> +{
> +    static bool pmu_filter_init;
> +    struct kvm_pmu_event_filter filter;
> +    struct kvm_device_attr attr = {
> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> +        .addr       = (uint64_t)&filter,
> +    };
> +    int i;
> +    g_auto(GStrv) event_filters;
> +
> +    if (!cpu->kvm_pmu_filter) {
> +        return;
> +    }
> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
> +        warn_report("The KVM doesn't support the PMU Event Filter!");

Drop "The ".

Should this really only be a warning, rather than an error?

> +        return;
> +    }
> +
> +    /*
> +     * The filter only needs to be initialized through one vcpu ioctl and it
> +     * will affect all other vcpu in the vm.

Weird. Why isn't it a VM ioctl if it affects the whole VM ?

> +     */
> +    if (pmu_filter_init) {
> +        return;
> +    } else {
> +        pmu_filter_init = true;
> +    }

Shouldn't we do this before we do the kvm_vcpu_ioctl check
for whether the kernel supports the filter? Otherwise presumably
we'll print the warning once per vCPU, rather than only once.

> +
> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
> +    for (i = 0; event_filters[i]; i++) {
> +        unsigned short start = 0, end = 0;
> +        char act;
> +
> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> +            continue;
> +        }
> +
> +        if ((act != 'A' && act != 'D') || start > end) {
> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> +            continue;
> +        }

It would be better to do the syntax checking up-front when
the user tries to set the property. Then you can make the
property-setting return an error for invalid strings.

> +
> +        filter.base_event = start;
> +        filter.nevents = end - start + 1;
> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
> +                                       KVM_PMU_EVENT_DENY;
> +
> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {

Shouldn't we arrange for an error message if this fails?

> +            break;
> +        }
> +    }
> +}
> +
>  void kvm_arm_pmu_init(ARMCPU *cpu)
>  {
>      struct kvm_device_attr attr = {
> @@ -1716,6 +1794,8 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
>      if (!cpu->has_pmu) {
>          return;
>      }
> +
> +    kvm_arm_pmu_filter_init(cpu);
>      if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
>          error_report("failed to init PMU");
>          abort();
>
> base-commit: 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
> --
> 2.40.1

thanks
-- PMM

