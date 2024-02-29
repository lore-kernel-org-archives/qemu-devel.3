Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7DEC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfe9x-0005mA-RZ; Thu, 29 Feb 2024 06:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfe9w-0005lr-LI
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:01:04 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfe9u-0008EV-5b
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:01:03 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-566adfeced4so354617a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709204457; x=1709809257; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aihek9liypx3sg6+jDyRe8w5Y71RlzjoJ8pSKlmVXow=;
 b=z43myUy8Yelvu/+QjIXJYvKY+sXVoUXmZt2oy/gL2pkGoVBTfxUfKt/ELrbylF0LM6
 44VIw1TgVqL9ON/MdoFv5wrdhv+t7ATF4OvKqu3VBYuc88ghwQR15Rf5InnwHj45+ZJf
 D1qSuFn4gzT4PRbJ74QEzVPURPKNBJVnFKAi2usZXmUwDmFK8Phl/LRAawMMQSlDVcUw
 ehkyJhGNXcOjxPElgaYWQt50IT8n96kfyG75UxjOiKCtT0pmooQ2ANTZ1yP6EMmXeBNW
 sNIB7YZjBfzJg71Xq+SQ+Et5YMSUR79iMWvVRC+GsxNK/EKr++YxlRuAzQd2aBUg1NGf
 zusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709204457; x=1709809257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aihek9liypx3sg6+jDyRe8w5Y71RlzjoJ8pSKlmVXow=;
 b=acszZyPxHe88l4LA+EVdapHIEQkgm1js6J0jEivaj6qifMkG26b0nIVUUOlmf0wIim
 tpHOK/yMXdnVKiXhBGGaSUJYeqAYpBPl0gQM/3Dt6jgPUIt2y9cgspRAgzZSXs476RQD
 8u/RwQQU4jLYNXp2pjX73smjy+IEtwfny2+6qZHP9QBvYxHq+IeHhU5ZSL4A3jVSCh+Z
 xmLoVOLX32SpPvanVzkUI9SNHQKTMLfxwfhTNMrKpJQ4uBPDXAK6bvQe0Jqhe+zdLI8x
 evBTG4eDgBp4zo9cBmDMN4u3/oyyAAXTvOMUQWc4dXN5fJLOl8YytQIO1bnbxqZWTw1R
 iILw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaQAop5eDRmrg7noi/9crKXKtJeGUGP/UDxv4IKhWGjfnOP6D6aEYX3o0IUyYXOcIs0HeqOrMPsXfgnstjjOUlwcq1e68=
X-Gm-Message-State: AOJu0Yw3kB5Zp5Qz4O8O7uY3CV/efb5BjsW6+GpQyg7k176/48/tKM8d
 UgRmAn6axjsS94P/dGJn4iVVWGcXVuIJ3K+dI//B8YGZtVMCVZPqpdt5e+yqc2PhsHwyJjPKTj/
 /mENeG9Iwz7LYcfFwIlAXcT1AEsLJ8w2hzgr60w==
X-Google-Smtp-Source: AGHT+IEMo1TW4/eZ1XMS+j7gy+I9AurYjfnCe21C5KMwZ6pCBdLBif5Pla2M8daP26YxVDcP9wDxQfop0CA5ZG6fN2A=
X-Received: by 2002:a50:cdd8:0:b0:566:821:d183 with SMTP id
 h24-20020a50cdd8000000b005660821d183mr1037803edj.42.1709204457137; Thu, 29
 Feb 2024 03:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20240221063431.76992-1-shahuang@redhat.com>
 <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
 <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
In-Reply-To: <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 11:00:45 +0000
Message-ID: <CAFEAcA-Yv05R7miBBRj4N1dkFUREHmTAi7ih8hffA3LXCmJkvQ@mail.gmail.com>
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>, 
 Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 29 Feb 2024 at 02:32, Shaoqin Huang <shahuang@redhat.com> wrote:
>
> Hi Peter,
>
> On 2/22/24 22:28, Peter Maydell wrote:
> > On Wed, 21 Feb 2024 at 06:34, Shaoqin Huang <shahuang@redhat.com> wrote:
> >>
> >> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
> >> which PMU events are provided to the guest. Add a new option
> >> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
> >> Without the filter, all PMU events are exposed from host to guest by
> >> default. The usage of the new sub-option can be found from the updated
> >> document (docs/system/arm/cpu-features.rst).
> >>
> >> Here is an example which shows how to use the PMU Event Filtering, when
> >> we launch a guest by use kvm, add such command line:
> >>
> >>    # qemu-system-aarch64 \
> >>          -accel kvm \
> >>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
> >>
> >> Since the first action is deny, we have a global allow policy. This
> >> filters out the cycle counter (event 0x11 being CPU_CYCLES).
> >>
> >> And then in guest, use the perf to count the cycle:
> >>
> >>    # perf stat sleep 1
> >>
> >>     Performance counter stats for 'sleep 1':
> >>
> >>                1.22 msec task-clock                       #    0.001 CPUs utilized
> >>                   1      context-switches                 #  820.695 /sec
> >>                   0      cpu-migrations                   #    0.000 /sec
> >>                  55      page-faults                      #   45.138 K/sec
> >>     <not supported>      cycles
> >>             1128954      instructions
> >>              227031      branches                         #  186.323 M/sec
> >>                8686      branch-misses                    #    3.83% of all branches
> >>
> >>         1.002492480 seconds time elapsed
> >>
> >>         0.001752000 seconds user
> >>         0.000000000 seconds sys
> >>
> >> As we can see, the cycle counter has been disabled in the guest, but
> >> other pmu events do still work.

> >
> > The new syntax for the filter property seems quite complicated.
> > I think it would be worth testing it with a new test in
> > tests/qtest/arm-cpu-features.c.
>
> I was trying to add a test in tests/qtest/arm-cpu-features.c. But I
> found all other cpu-feature is bool property.
>
> When I use the 'query-cpu-model-expansion' to query the cpu-features,
> the kvm-pmu-filter will not shown in the returned results, just like below.
>
> {'execute': 'query-cpu-model-expansion', 'arguments': {'type': 'full',
> 'model': { 'name': 'host'}}}{"return": {}}
>
> {"return": {"model": {"name": "host", "props": {"sve768": false,
> "sve128": false, "sve1024": false, "sve1280": false, "sve896": false,
> "sve256": false, "sve1536": false, "sve1792": false, "sve384": false,
> "sve": false, "sve2048": false, "pauth": false, "kvm-no-adjvtime":
> false, "sve512": false, "aarch64": true, "pmu": true, "sve1920": false,
> "sve1152": false, "kvm-steal-time": true, "sve640": false, "sve1408":
> false, "sve1664": false}}}}
>
> I'm not sure if it's because the `query-cpu-model-expansion` only return
> the feature which is bool. Since the kvm-pmu-filter is a str, it won't
> be recognized as a feature.
>
> So I want to ask how can I add the kvm-pmu-filter which is str property
> into the cpu-feature.c test.

It doesn't appear because the list of properties that we advertise
via query-cpu-model-expansion is set in the cpu_model_advertised_features[]
array in target/arm/arm-qmp-cmds.c, and this patch doesn't add
'kvm-pmu-filter' to it. But you have a good point about all the
others being bool properties: I don't know enough about that
mechanism to know if simply adding this to the list is right.

This does raise a more general question: do we need to advertise
the existence of this property to libvirt via QMP? Eric, Sebastian:
do you know ?

If we don't care about this being visible to libvirt then the
importance of having a test case covering the command line
syntax goes down a bit.

> >>
> >> +static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
> >> +{
> >> +    static bool pmu_filter_init;
> >> +    struct kvm_pmu_event_filter filter;
> >> +    struct kvm_device_attr attr = {
> >> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> >> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> >> +        .addr       = (uint64_t)&filter,
> >> +    };
> >> +    int i;
> >> +    g_auto(GStrv) event_filters;
> >> +
> >> +    if (!cpu->kvm_pmu_filter) {
> >> +        return;
> >> +    }
> >> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
> >> +        warn_report("The KVM doesn't support the PMU Event Filter!");
> >
> > Drop "The ".
> >
> > Should this really only be a warning, rather than an error?
> >
>
> I think this is an add-on feature, and shouldn't block the qemu init
> process. If we want to set the wrong pmu filter and it doesn't take
> affect to the VM, it can be detected in the VM.

But if the user explicitly asked for it, it's not optional
for them, it's something they want. We should fail if the user
passes us an option that we can't actually carry out.

> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * The filter only needs to be initialized through one vcpu ioctl and it
> >> +     * will affect all other vcpu in the vm.
> >
> > Weird. Why isn't it a VM ioctl if it affects the whole VM ?
> >
>  From (kernel) commit d7eec2360e3 ("KVM: arm64: Add PMU event filtering
> infrastructure"):
>    Note that although the ioctl is per-vcpu, the map of allowed events is
>    global to the VM (it can be setup from any vcpu until the vcpu PMU is
>    initialized).

That just says it is a per-vcpu ioctl, it doesn't say why...

> >> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
> >> +    for (i = 0; event_filters[i]; i++) {
> >> +        unsigned short start = 0, end = 0;
> >> +        char act;
> >> +
> >> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
> >> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> >> +            continue;
> >> +        }
> >> +
> >> +        if ((act != 'A' && act != 'D') || start > end) {
> >> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> >> +            continue;
> >> +        }
> >
> > It would be better to do the syntax checking up-front when
> > the user tries to set the property. Then you can make the
> > property-setting return an error for invalid strings.
> >
>
> Ok. I guess you mean to say move the syntax checking to the
> kvm_pmu_filter_set() function. But wouldn't it cause some code
> duplication? Since it should first check syntax of the string in
> kvm_pmu_filter_set() and then parse the string in this function.

No, you should check syntax and parse the string in
kvm_pmu_filter_set(), and fill in a data structure so you don't
have to do any string parsing here. kvm_pmu_filter_get()
will need to reconstitute a string from the data structure.

thanks
-- PMM

