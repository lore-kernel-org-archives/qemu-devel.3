Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4054109E528
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 23:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Xp6-0001ks-KS; Wed, 25 Mar 2026 19:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w5Xp2-0001kO-Qk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 19:39:37 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w5Xoz-0000We-C4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 19:39:36 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7d50516e9so211441a34.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 16:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774481971; cv=none;
 d=google.com; s=arc-20240605;
 b=Gw3PyMIf2Rqu/oce7wGBGd1hGeYyVQdz5cOm5mX0dWsqReqvNb9+YgwpFnCq0jqcUj
 ysYRYjdt+NuBvdBMyKdXhWY3EntswZINd/024kJWD5+tgz1IzzkK71xmol5sXHn3bATu
 MZhHMQ+NNHnk/dUYnoR3I331lDC/uAcQjyaadligGuQiY3hmbQxF3pU8ABaEm9p9uOrR
 agdD+7n+288dbP/IOo+5lAWoCq8B2/ysHnGgtZsb9kUEaocwsc8UtMEAcW5G++wxyRW+
 aPJdqg3Xj3R2kkyGdRCQHMmFdNKsEtLIFnp8PHtHXSRdHoRUamlMHC1HJdzigBKlYhQQ
 wnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SgLc3mfPZyRdlY4U8Vz1Wy6i87NX/+kzMFo8QkopqDQ=;
 fh=q4q/vXes3FoEamFAzRw19gQc6zeAKWvBwB+8E/Ot0+E=;
 b=kc0Cao6NdeOpYSaPcwufctjPek7I6ROJRSfoLgsX6utgPlLJuw5xItdRIaVk0WsEtJ
 wzOfP0NXxnPELA/1kNNrnedf/5grz7Y5q2gx1imxE6/u9sNv06RFaWvdvDQZnlLamFJY
 L+zPmCrBoHGXxoY0KhhFra+BuWnSBAwxBR/IJkPCkGRkdRLf7CjPJaUj/it/g1zj2YYe
 8a3OxMK+VRwKF3sW2xC2et2ZBIrj075Qnk1XSvUKzQYa300kUDrNR82QhH2AjyU498mv
 6OPlCez2lwC+bLoWmcbGueeaY0ooyCoduv3TNO5eZ9S08ghw/U1blmARgkoVC+1fWJYW
 rlBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774481971; x=1775086771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgLc3mfPZyRdlY4U8Vz1Wy6i87NX/+kzMFo8QkopqDQ=;
 b=ZKy4NMoQal6l4w0ZRQGhpg3SXfF6LmNbd/EsbsD2fl1T7taBATMViAmUXgaKk3uDHV
 /p/1MHxvaaq1AUMFIuYN2tewnEpKdzMq+Nx9je/SA/TGutXshezmtluXJh6oDMKXj2Lo
 MbgPuiSI/5Z7uJx0vNxV6TfEP448NqG8SfLo5ys22DG74MEOyOz/Oi12P2iBG2mfKjzX
 Lb6AUHYhsNOwf9vuRkl6DPJbSvHNtVUrA8WTcjOolMC7S4b2g+hEGLUfgHODzOJ5ZAvv
 Z/YtcMJn/coO1i26S7bBGf7hCZH3/GQherhvnQvS1BTkxPoKHmjMKJ6EDKDVwB5x2XFh
 9QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774481971; x=1775086771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgLc3mfPZyRdlY4U8Vz1Wy6i87NX/+kzMFo8QkopqDQ=;
 b=LSeH0JbJnlR2zURGQb4QoLF3prn0+zY4d61C1uzzG1OXEUddca8CTEWAcVVZDD5y/1
 iQHDyYSh7zmhD3hGV73qc0mNJMZ9yYpK1xeFMj+53Va0tQqa7ZYu8BPH9VKHLzidHeG/
 Gy+v7J0/+IfTNRfvhdmR1nIwFjl+NTcwhSbfAnu9YGZYlmNqXN7BC8NtnPMBPnjEWsVr
 k4zRkD8u/DC7LSbCfTDICacScKM9ZtlwfiLJPzflWyykNURs1i3x6Md5Pp31p3cIEZIY
 cCFML20TCZNxs/W2uh8Jww9yHrQCZJogdqlcFODSio2OdzSP8EVgLcCfueLQAz/hA53R
 ZQMw==
X-Gm-Message-State: AOJu0Yy1udTjBe0T67KDQuC5zsVTvCI5F5nlTwV5NQWwy6+AhiBV1f7x
 LGQ6dLhut9SeHhNFE88dAb74QAOwRMBrhQz858+LAbNO4QghxXu9gFmFhWltZou+Iuo5IpG9nRe
 oKZEHDOi95f/NZTesKJrfYC3w3pvAXdE=
X-Gm-Gg: ATEYQzxZl6IzPnjzr8UuYCRWI+whLneZ3OHSEw9jIp92mCBCHNKKon+35JZ2/xdI8gz
 l62/8zlwftPppWirRpWbv63v72h2NhN9sSaLeZy+v2/wGr0pTwYmLC5jbh6eqrOV6I713ER1rgu
 LVyKUGzHS6/ukbxwTM8sfHfkAdewbfIFbMuepXyQjnu7hA88xdhvY0X8pf3t/jLNsN0OxEDCpCw
 n2fQ+jCg6G7LeN1Ytbd6VAa/CM/O7iYufeJrz6XefLZhXuPMyldYD+t9PuwoFFIDgJal08LTsRS
 MEYyW237
X-Received: by 2002:a05:6830:6f83:b0:7d7:e782:214a with SMTP id
 46e09a7af769-7d9d651d592mr2899802a34.6.1774481971113; Wed, 25 Mar 2026
 16:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
 <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
 <4d2d16df-0047-4b96-8312-46489ba0f1bf@linaro.org>
 <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
 <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
In-Reply-To: <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Thu, 26 Mar 2026 00:39:19 +0100
X-Gm-Features: AQROBzA7S-qs_Fgk2WnQBYXRNWrpZjZ9qFpkevuDDkDoz_Cap1u8NQZ3Hfgx074
Message-ID: <CAN-aV1HRZPxuS_U4mHYhnobbKkq2G5T9P2cJ2=LahT3TzGsC6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework and
 API extensions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 20, 2026 at 7:08=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/19/26 3:29 PM, Ruslan Ruslichenko wrote:
> > On Thu, Mar 19, 2026 at 8:04=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> On 3/19/26 11:20 AM, Ruslan Ruslichenko wrote:
> >>> Hi Pierrick,
> >>>
> >>> Thank you for the feedback and review!
> >>>
> >>> Our current plan is to put this plugin through our internal workflows=
 to gather
> >>> more data on its limitations and performance.
> >>> Based on results, we may consider extending or refining the implement=
ation
> >>> in the future.
> >>>
> >>> Any further feedback on potential issues is highly appreciated.
> >>>
> >>
> >> By design, the approach of modifying QEMU internals to allow to inject
> >> IRQ, set a timer, or trigger SMMU has very few chances to be integrate=
d
> >> as it is. At least, it should be discussed with the concerned
> >> maintainers, and see if they would be open to it or not.
> >>
> >> It's not wrong in itself, if you want a downstream solution, but it do=
es
> >> not scale upstream if we have to consider and accept everyone's needs.
> >> The plugin API in itself can accept the burden for such things, but it=
's
> >> harder to justify for internal stuff.
> >>
> >> I believe it would be better to rely on ad hoc devices generating this=
,
> >> with the advantage that even if they don't get accepted upstream, it
> >> will be more easy for you to maintain them downstream compared to more
> >> intrusive patches.
> >>
> >>> On Wed, Mar 18, 2026 at 6:16=E2=80=AFPM Pierrick Bouvier
> >>> <pierrick.bouvier@linaro.org> wrote:
> >>>>
> >>>> Hi Ruslan,
> >>>>
> >>>> On 3/18/26 3:46 AM, Ruslan Ruslichenko wrote:
> >>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >>>>>
> >>>>> This patch series is submitted as an RFC to gather early feedback o=
n a Fault Injection (FI) framework built on top of the QEMU TCG plugin subs=
ystem.
> >>>>>
> >>>>> Motivation
> >>>>>
> >>>>> Testing guest operating systems, hypervisors (like Xen), and low-le=
vel drivers against unexpected hardware failures can be difficult.
> >>>>> This series provides an interface to inject faults dynamically with=
out altering QEMU's core emulation source code for every test case.
> >>>>>
> >>>>> Architecture & Key Features
> >>>>>
> >>>>> The series introduces the core API extensions and implements a faul=
t injection plugin (contrib/plugins/fault_injection.c) targeting AArch64.
> >>>>> The plugin can be controlled statically via XML configurations on b=
oot, or dynamically at runtime via a UNIX socket (enabling integration with=
 automated testing frameworks via Python or GDB).
> >>>>>
> >>>>> New Plugin API Capabilities:
> >>>>>
> >>>>> MMIO Interception: Allows plugins to hook into memory_region_dispat=
ch_read/write to modify hardware register reads or drop writes.
> >>>>> Asynchronous Timers: Exposes QEMU_CLOCK_VIRTUAL to plugins, allowin=
g callbacks to be scheduled based on guest virtual time.
> >>>>> TB Cache Flushing: Exposes qemu_plugin_flush_tb_cache() so plugins =
can force re-translation when applying dynamic PC-based hooks.
> >>>>> Interrupt & Exception Injection: Exposes APIs to raise/pulse hardwa=
re IRQs on the primary INTC and inject CPU exceptions (e.g., SErrors).
> >>>>> Custom Device Faults: Introduces a registry where device models (e.=
g., SMMUv3) can expose specific fault handlers (like CMDQ errors) to be tri=
ggered externally by plugins.
> >>>>>
> >>>>> Patch Summary
> >>>>> Patch 1 (target/arm): Adds support for asynchronous CPU exception i=
njection.
> >>>>> Patch 2-3 (plugins/api): Exposes virtual clock timers and TB cache =
flushing to the public plugin API.
> >>>>> Patch 4 (plugins): Introduces the core fault injection subsystem, I=
RQ/Exception routing, and the Custom Fault registry.
> >>>>> Patch 5 (system/memory): Adds the MMIO override hooks into the memo=
ry dispatch path.
> >>>>> Patch 6 (hw/intc): Registers the ARM GIC (v2/v3) with the plugin su=
bsystem to enable direct hardware IRQ injection.
> >>>>> Patch 7 (hw/arm): Registers the SMMUv3 with the custom fault regist=
ry to demonstrate how device models can expose specific errors (like CMDQ f=
aults) to plugins.
> >>>>> Patch 8 (contrib/plugins): Implements the actual fault_injection pl=
ugin using the new APIs.
> >>>>> Patch 9 (docs): Adds documentation and usage examples for the plugi=
n.
> >>>>>
> >>>>> Request for Comments & Feedback
> >>>>>
> >>>>> Any suggestions on improvements, potential edge cases, or issues wi=
th the current design are highly welcome.
> >>>>>
> >>>>> Ruslan Ruslichenko (9):
> >>>>>      target/arm: Add API for dynamic exception injection
> >>>>>      plugins/api: Expose virtual clock timers to plugins
> >>>>>      plugins: Expose Transaction Block cache flush API to plugins
> >>>>>      plugins: Introduce fault injection API and core subsystem
> >>>>>      system/memory: Add plugin callbacks to intercept MMIO accesses
> >>>>>      hw/intc/arm_gic: Register primary GIC for plugin IRQ injection
> >>>>>      hw/arm/smmuv3: Add plugin fault handler for CMDQ errors
> >>>>>      contrib/plugins: Add fault injection plugin
> >>>>>      docs: Add description of fault-injection plugin and subsystem
> >>>>>
> >>>>>     contrib/plugins/fault_injection.c | 772 +++++++++++++++++++++++=
+++++++
> >>>>>     contrib/plugins/meson.build       |   1 +
> >>>>>     docs/fault-injection.txt          | 111 +++++
> >>>>>     hw/arm/smmuv3.c                   |  54 +++
> >>>>>     hw/intc/arm_gic.c                 |  28 ++
> >>>>>     hw/intc/arm_gicv3.c               |  28 ++
> >>>>>     include/plugins/qemu-plugin.h     |  28 ++
> >>>>>     include/qemu/plugin.h             |  39 ++
> >>>>>     plugins/api.c                     |  62 +++
> >>>>>     plugins/core.c                    |  11 +
> >>>>>     plugins/fault.c                   | 116 +++++
> >>>>>     plugins/meson.build               |   1 +
> >>>>>     plugins/plugin.h                  |   2 +
> >>>>>     system/memory.c                   |   8 +
> >>>>>     target/arm/cpu.h                  |   4 +
> >>>>>     target/arm/helper.c               |  55 +++
> >>>>>     16 files changed, 1320 insertions(+)
> >>>>>     create mode 100644 contrib/plugins/fault_injection.c
> >>>>>     create mode 100644 docs/fault-injection.txt
> >>>>>     create mode 100644 plugins/fault.c
> >>>>>
> >>>>
> >>>> first, thanks for posting your series!
> >>>>
> >>>> About the general approach.
> >>>> As you noticed, this is exposing a lot of QEMU internals, and it's
> >>>> something we tend to avoid to do. As well, it's very architecture
> >>>> specific, which is another pattern we try to avoid.
> >>>>
> >>>> For some of your needs (especially IRQ injection and timer injection=
),
> >>>> did you consider writing a custom ad-hoc device and timer generating=
 those?
> >>>> There is nothing preventing you from writing a plugin that can
> >>>> communicate with this specific device (through a socket for instance=
),
> >>>> to request specific injections. I feel that it would scale better th=
an
> >>>> exposing all this to QEMU plugins API.
> >>>>
> >>>> For SMMU, this is trickier. Tao recently (6ce361b02c82) an iommu tes=
t
> >>>> device, associated to qtest to unit test the smmu implementation. We
> >>>> could maybe see to leverage that on a full machine, associated with =
the
> >>>> communication method mentioned above, to generate specific operation=
s at
> >>>> runtime, all triggered via a plugin.
> >>>>
> >>>> Exposing qemu_plugin_flush_tb_cache is a hint we are missing somethi=
ng
> >>>> on QEMU side. Better to fix it than expose this very internal functi=
on.
> >>>
> >>> The reason this was needed is that the plugin may receive PC trigger
> >>> configuration
> >>> dynamically and need to register instruction callback at runtime.
> >>> If the TB for that PC is already translated and cached, our newly reg=
istered
> >>> callback might not be executed.
> >>>
> >>> If there is a more proper way to force QEMU to re-translate a specifi=
c
> >>> TB or attach
> >>> a callback to cached TB it would be great to reduce the complexity he=
re.
> >>>
> >>
> >> I understand better. QEMU plugin current implementation is too limited
> >> for this, and everything has to be done/known at translation time.
> >> What is your use case for receiving PC trigger after translation? Do y=
ou
> >> have some mechanism to communicate with the plugin for this?
> >
> > Yes, exactly. If the guest has already executed the target code, the ne=
wly
> > added trigger will be ignored, as the TB is cached.
> >
> > For runtime configuration, the plugin spawns a background thread that l=
istens
> > on a socket. External Python test script connects to this socket to sen=
d
> > dynamically generated XML faults.
> >
>
> Ok.
>
> Internally, we have tb_invalidate_phys_range that will invalidate a
> given range of tb. This is called when writing to memory for a given
> address holding code.
>
> Thus from your plugin, if you write to pc address with
> qemu_plugin_write_memory_vaddr, it should trigger a re-translation of
> this tb. You'll need to read 1 byte, and write it back. As well, it
> should be more efficient, since you will only invalidate this tb.
>
> Give it a try and let us know if it works for your need.
>

Thank you for your suggestion. This is really useful information regarding
internals of tb processing.

I set up a test to simulate a scenario where a TB flush is needed
and used the described mechanism. However, there is a threading limitation:
qemu_plugin_write_memory_vaddr() must be called from a CPU thread.
In our current implementation dynamic faults are received and processed
by a background thread listening on a socket, so we cannot directly
use API from that context to trigger invalidation.

> > There are several scenarios where this might be needed, mainly for faul=
ts that
> > are difficult to define statically at boot time.
> > Examples include injecting faults after specific chain of events, freez=
ing or
> > overriding system registers values at specific execution points (since =
this
> > is currently implemented via PC triggers). Supporting environments with=
 KASLR
> > enabled might be one more case.
> >
>
> For system registers, you can (heavy but would work) instrument
> inconditionally all instructions that touch those registers, so there
> would be no need to flush anything. System registers are not accessed
> for every instruction, so hopefully, it should not impact too much
> execution time.
>

Agree, this is a good optimization and indeed simplifies dynamic faults
handling for system register reads.
Thank you for the recommendation!

> With both solutions, it should remove the need to expose tb_flush
> through plugin API.
>
> >>
> >>>> The associated TRIGGER_ON_PC is very similar to existing inline
> >>>> operations. They could be enhanced to support writing to a given
> >>>> register, all the bricks are there. For TRIGGER_ON_SYSREG it's a bit
> >>>> more complex, but we might enhance inline operations also to support
> >>>> hooks on specific register writes.
> >>>
> >>> TRIGGER_ON_PC may also be used for generating other faults too. For e=
xample,
> >>> one use-case is to trigger CPU exceptions on specific instructions.
> >>> Supporting TRIGGER_ON_SYSREG as an inline operation sounds like a
> >>> really interesting
> >>> direction to explore.
> >>>
> >>
> >> In general, having inline operations support on register read/writes
> >> would be a very nice thing to have (though might be tricky to implemen=
t
> >> correctly), and more efficient that the existing approach that require=
s
> >> to check their value everytime.
> >>
> >>>>
> >>>> For MMIO override, the current approach you have is good, and it's
> >>>> definitely something we could integrate.
> >>>>
> >>>> What are you toughts about this? (especially the device based approa=
ch
> >>>> in case that you maybe tried first).
> >>>
> >>> I agree such an approach can work well for IRQ's and Timers, and woul=
d be
> >>> more clean way to implement this.
> >>>
> >>> However, for SMMU and similar cases, triggering internal state errors=
 is not
> >>> easy and requires accessing internal logic. So for those specific cas=
es,
> >>> a different approach may be needed.
> >>>
> >>
> >> Thus the iommu-testdev I mentioned, that could be extended to support =
this.
> >>
> >>>>
> >>>> Regards,
> >>>> Pierrick
> >>>
> >>> BR,
> >>> Ruslan
> >>
> >> Regards,
> >> Pierrick
>

