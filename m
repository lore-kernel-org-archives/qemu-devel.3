Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E937510A1E7D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5j9N-0003Y5-B9; Thu, 26 Mar 2026 07:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5j9L-0003Xl-Kp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:45:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5j9J-0002nX-1r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:45:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-66847de014aso1489356a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774525515; x=1775130315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cek1PjrKX2zO9OcDY3GKsSwCpqhvQjV4M0wCcx7MAao=;
 b=ZtXlXdwr3QDpS5xrCu0DJLdXgCHiP6tVrJlXIciVU1p3CUetgScMYSNNItw4aaE12B
 0x7iKmjAeHhid3ZZWKbvuUhzUlIUqqzHGpep1CX2OP5Qp1jNyvY4nSqMe8w8UMrTS5Vy
 wNv78gnfpaN2p8i3co6T4cLLXFTNIYK2pDrmlN32rpuF93CsGn2DCiZjsVliKX4HH2s+
 pK0bg1fTY5nyLx5YWLjb1f0VKjZjUSgJRcp/AgLIN/bx4aJvbzdDDzqVPvtMDGE8EHgK
 VFvu0Q6OIpu9L05WchmXMVQZSyR4VlCdpzuU80WK5TGpfERhh7r7YexUrCwm4WQxyCOF
 GItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525515; x=1775130315;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cek1PjrKX2zO9OcDY3GKsSwCpqhvQjV4M0wCcx7MAao=;
 b=U6VIPujNGRxLj68mw9FNz42O+OTZ2gZGHlkjQVzX0qvzc+7fPO3NSnyZ5QDfMUcfxk
 /pR1r+XEXB5sz/hw0UfT1wHTmQXLqC6wMpTL9GaYAEXrpA/0+BaK01OH5cvbRBQkoYQt
 EhNj4v5rbC+54K+ZWTyArBZbtMHuodu0igGffb4qEo/XuKh96PKCqfGjKEudoei2lywy
 vi8xDVQK4Wr/+ZWCU81ogNdboLQCqgws1ynCe+tPky7eN7q0Wt3+vgMuGAzE2AvZowmN
 yuFm6LJ67H/zHYnLaFuEl17ji0Vjqw0RvzW+FON3izhVP4FTGP1CtttBhBfTpG1gq/NF
 Zvxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9VSsLf0XaG0hmTyP3CA+i4ztUL2Zi6qUyUWBgK8XXIKW7gzKCwxn3XNjvdGDfdzvEQeHyo7cJwtux@nongnu.org
X-Gm-Message-State: AOJu0Yx88AsHXKWlyU5wmzIGJKRIiwRg9chjQp+x3LINZeg8/nkfXpkY
 qXogrc9P58cdYwAKgqgO2IJQjKOgT2j4371o90mWXV8VBF2RBA6IXaDsrtmXZ1Zxf44=
X-Gm-Gg: ATEYQzw9DorYJzc9mHMAsFrkXjYeO8X514xGC/hs5bAI1KdWVwZkZ1wFVna/fy1BLFp
 L/vhXp3RTecys+S+ehTP4OhGCzB14SMFZGMGRPLDvphB5ZI5cdB8P7Jfm3Nkv0VYngtSBM38KG5
 uOjJgW2OXkFPrecskI9qhBwy38KuqV0+3Y3jpa+fiLDZH+/K4CuWolnDBGSJu2VlxaSeqYLKl72
 E8VdwPCyVQFFEXaIy4DBwwEspV+CuFNKVQNcpmQg6cglPdjXV1V3HXny1Otzw0HA1WjW46FPiVs
 k7w7LuZsmuWFWTEE6mLEK923KNezA29dDLDtiuP+WU+pEp5WyzjAOBU3dnkf+upj/nVcXsEasDP
 49quYOul4yjAwrapQO1TX28x2Lt1aLBodnItEdWtFNuwZ8bl7+Fbd734cGCLnKCQl8f57X5LSxN
 nED54WJ6bpyd1g2i4I+/NNwm0=
X-Received: by 2002:a17:907:6b8e:b0:b97:8503:8313 with SMTP id
 a640c23a62f3a-b9a54237358mr509741566b.27.1774525514569; 
 Thu, 26 Mar 2026 04:45:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20263997sm106047166b.14.2026.03.26.04.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:45:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F251F5F7F7;
 Thu, 26 Mar 2026 11:45:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com,  peter.maydell@linaro.org,
 philmd@linaro.org,  Ruslan_Ruslichenko@epam.com, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework
 and API extensions
In-Reply-To: <005aa40d-4749-44d5-a65c-8f59cbd06d0c@linaro.org> (Pierrick
 Bouvier's message of "Wed, 25 Mar 2026 17:17:29 -0700")
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
 <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
 <4d2d16df-0047-4b96-8312-46489ba0f1bf@linaro.org>
 <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
 <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
 <CAN-aV1HRZPxuS_U4mHYhnobbKkq2G5T9P2cJ2=LahT3TzGsC6A@mail.gmail.com>
 <005aa40d-4749-44d5-a65c-8f59cbd06d0c@linaro.org>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Thu, 26 Mar 2026 11:45:12 +0000
Message-ID: <87a4vu3jcn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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


(adding Richard to Cc)

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/25/26 4:39 PM, Ruslan Ruslichenko wrote:
>> On Fri, Mar 20, 2026 at 7:08=E2=80=AFPM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> On 3/19/26 3:29 PM, Ruslan Ruslichenko wrote:
>>>> On Thu, Mar 19, 2026 at 8:04=E2=80=AFPM Pierrick Bouvier
>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>
>>>>> On 3/19/26 11:20 AM, Ruslan Ruslichenko wrote:
>>>>>> Hi Pierrick,
>>>>>>
>>>>>> Thank you for the feedback and review!
>>>>>>
>>>>>> Our current plan is to put this plugin through our internal workflow=
s to gather
>>>>>> more data on its limitations and performance.
>>>>>> Based on results, we may consider extending or refining the implemen=
tation
>>>>>> in the future.
>>>>>>
>>>>>> Any further feedback on potential issues is highly appreciated.
>>>>>>
>>>>>
>>>>> By design, the approach of modifying QEMU internals to allow to inject
>>>>> IRQ, set a timer, or trigger SMMU has very few chances to be integrat=
ed
>>>>> as it is. At least, it should be discussed with the concerned
>>>>> maintainers, and see if they would be open to it or not.
>>>>>
>>>>> It's not wrong in itself, if you want a downstream solution, but it d=
oes
>>>>> not scale upstream if we have to consider and accept everyone's needs.
>>>>> The plugin API in itself can accept the burden for such things, but i=
t's
>>>>> harder to justify for internal stuff.
>>>>>
>>>>> I believe it would be better to rely on ad hoc devices generating thi=
s,
>>>>> with the advantage that even if they don't get accepted upstream, it
>>>>> will be more easy for you to maintain them downstream compared to more
>>>>> intrusive patches.
>>>>>
>>>>>> On Wed, Mar 18, 2026 at 6:16=E2=80=AFPM Pierrick Bouvier
>>>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi Ruslan,
>>>>>>>
>>>>>>> On 3/18/26 3:46 AM, Ruslan Ruslichenko wrote:
>>>>>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>>>>>
>>>>>>>> This patch series is submitted as an RFC to gather early feedback =
on a Fault Injection (FI) framework built on top of the QEMU TCG plugin sub=
system.
>>>>>>>>
>>>>>>>> Motivation
>>>>>>>>
>>>>>>>> Testing guest operating systems, hypervisors (like Xen), and low-l=
evel drivers against unexpected hardware failures can be difficult.
>>>>>>>> This series provides an interface to inject faults dynamically wit=
hout altering QEMU's core emulation source code for every test case.
>>>>>>>>
>>>>>>>> Architecture & Key Features
>>>>>>>>
>>>>>>>> The series introduces the core API extensions and implements a fau=
lt injection plugin (contrib/plugins/fault_injection.c) targeting AArch64.
>>>>>>>> The plugin can be controlled statically via XML configurations on =
boot, or dynamically at runtime via a UNIX socket (enabling integration wit=
h automated testing frameworks via Python or GDB).
>>>>>>>>
>>>>>>>> New Plugin API Capabilities:
>>>>>>>>
>>>>>>>> MMIO Interception: Allows plugins to hook into memory_region_dispa=
tch_read/write to modify hardware register reads or drop writes.
>>>>>>>> Asynchronous Timers: Exposes QEMU_CLOCK_VIRTUAL to plugins, allowi=
ng callbacks to be scheduled based on guest virtual time.
>>>>>>>> TB Cache Flushing: Exposes qemu_plugin_flush_tb_cache() so plugins=
 can force re-translation when applying dynamic PC-based hooks.
>>>>>>>> Interrupt & Exception Injection: Exposes APIs to raise/pulse hardw=
are IRQs on the primary INTC and inject CPU exceptions (e.g., SErrors).
>>>>>>>> Custom Device Faults: Introduces a registry where device models (e=
.g., SMMUv3) can expose specific fault handlers (like CMDQ errors) to be tr=
iggered externally by plugins.
>>>>>>>>
>>>>>>>> Patch Summary
>>>>>>>> Patch 1 (target/arm): Adds support for asynchronous CPU exception =
injection.
>>>>>>>> Patch 2-3 (plugins/api): Exposes virtual clock timers and TB cache=
 flushing to the public plugin API.
>>>>>>>> Patch 4 (plugins): Introduces the core fault injection subsystem, =
IRQ/Exception routing, and the Custom Fault registry.
>>>>>>>> Patch 5 (system/memory): Adds the MMIO override hooks into the mem=
ory dispatch path.
>>>>>>>> Patch 6 (hw/intc): Registers the ARM GIC (v2/v3) with the plugin s=
ubsystem to enable direct hardware IRQ injection.
>>>>>>>> Patch 7 (hw/arm): Registers the SMMUv3 with the custom fault regis=
try to demonstrate how device models can expose specific errors (like CMDQ =
faults) to plugins.
>>>>>>>> Patch 8 (contrib/plugins): Implements the actual fault_injection p=
lugin using the new APIs.
>>>>>>>> Patch 9 (docs): Adds documentation and usage examples for the plug=
in.
>>>>>>>>
>>>>>>>> Request for Comments & Feedback
>>>>>>>>
>>>>>>>> Any suggestions on improvements, potential edge cases, or issues w=
ith the current design are highly welcome.
>>>>>>>>
>>>>>>>> Ruslan Ruslichenko (9):
>>>>>>>>       target/arm: Add API for dynamic exception injection
>>>>>>>>       plugins/api: Expose virtual clock timers to plugins
>>>>>>>>       plugins: Expose Transaction Block cache flush API to plugins
>>>>>>>>       plugins: Introduce fault injection API and core subsystem
>>>>>>>>       system/memory: Add plugin callbacks to intercept MMIO access=
es
>>>>>>>>       hw/intc/arm_gic: Register primary GIC for plugin IRQ injecti=
on
>>>>>>>>       hw/arm/smmuv3: Add plugin fault handler for CMDQ errors
>>>>>>>>       contrib/plugins: Add fault injection plugin
>>>>>>>>       docs: Add description of fault-injection plugin and subsystem
>>>>>>>>
>>>>>>>>      contrib/plugins/fault_injection.c | 772 +++++++++++++++++++++=
+++++++++
>>>>>>>>      contrib/plugins/meson.build       |   1 +
>>>>>>>>      docs/fault-injection.txt          | 111 +++++
>>>>>>>>      hw/arm/smmuv3.c                   |  54 +++
>>>>>>>>      hw/intc/arm_gic.c                 |  28 ++
>>>>>>>>      hw/intc/arm_gicv3.c               |  28 ++
>>>>>>>>      include/plugins/qemu-plugin.h     |  28 ++
>>>>>>>>      include/qemu/plugin.h             |  39 ++
>>>>>>>>      plugins/api.c                     |  62 +++
>>>>>>>>      plugins/core.c                    |  11 +
>>>>>>>>      plugins/fault.c                   | 116 +++++
>>>>>>>>      plugins/meson.build               |   1 +
>>>>>>>>      plugins/plugin.h                  |   2 +
>>>>>>>>      system/memory.c                   |   8 +
>>>>>>>>      target/arm/cpu.h                  |   4 +
>>>>>>>>      target/arm/helper.c               |  55 +++
>>>>>>>>      16 files changed, 1320 insertions(+)
>>>>>>>>      create mode 100644 contrib/plugins/fault_injection.c
>>>>>>>>      create mode 100644 docs/fault-injection.txt
>>>>>>>>      create mode 100644 plugins/fault.c
>>>>>>>>
>>>>>>>
>>>>>>> first, thanks for posting your series!
>>>>>>>
>>>>>>> About the general approach.
>>>>>>> As you noticed, this is exposing a lot of QEMU internals, and it's
>>>>>>> something we tend to avoid to do. As well, it's very architecture
>>>>>>> specific, which is another pattern we try to avoid.
>>>>>>>
>>>>>>> For some of your needs (especially IRQ injection and timer injectio=
n),
>>>>>>> did you consider writing a custom ad-hoc device and timer generatin=
g those?
>>>>>>> There is nothing preventing you from writing a plugin that can
>>>>>>> communicate with this specific device (through a socket for instanc=
e),
>>>>>>> to request specific injections. I feel that it would scale better t=
han
>>>>>>> exposing all this to QEMU plugins API.
>>>>>>>
>>>>>>> For SMMU, this is trickier. Tao recently (6ce361b02c82) an iommu te=
st
>>>>>>> device, associated to qtest to unit test the smmu implementation. We
>>>>>>> could maybe see to leverage that on a full machine, associated with=
 the
>>>>>>> communication method mentioned above, to generate specific operatio=
ns at
>>>>>>> runtime, all triggered via a plugin.
>>>>>>>
>>>>>>> Exposing qemu_plugin_flush_tb_cache is a hint we are missing someth=
ing
>>>>>>> on QEMU side. Better to fix it than expose this very internal funct=
ion.
>>>>>>
>>>>>> The reason this was needed is that the plugin may receive PC trigger
>>>>>> configuration
>>>>>> dynamically and need to register instruction callback at runtime.
>>>>>> If the TB for that PC is already translated and cached, our newly re=
gistered
>>>>>> callback might not be executed.
>>>>>>
>>>>>> If there is a more proper way to force QEMU to re-translate a specif=
ic
>>>>>> TB or attach
>>>>>> a callback to cached TB it would be great to reduce the complexity h=
ere.
>>>>>>
>>>>>
>>>>> I understand better. QEMU plugin current implementation is too limited
>>>>> for this, and everything has to be done/known at translation time.
>>>>> What is your use case for receiving PC trigger after translation? Do =
you
>>>>> have some mechanism to communicate with the plugin for this?
>>>>
>>>> Yes, exactly. If the guest has already executed the target code, the n=
ewly
>>>> added trigger will be ignored, as the TB is cached.
>>>>
>>>> For runtime configuration, the plugin spawns a background thread that =
listens
>>>> on a socket. External Python test script connects to this socket to se=
nd
>>>> dynamically generated XML faults.
>>>>
>>>
>>> Ok.
>>>
>>> Internally, we have tb_invalidate_phys_range that will invalidate a
>>> given range of tb. This is called when writing to memory for a given
>>> address holding code.
>>>
>>> Thus from your plugin, if you write to pc address with
>>> qemu_plugin_write_memory_vaddr, it should trigger a re-translation of
>>> this tb. You'll need to read 1 byte, and write it back. As well, it
>>> should be more efficient, since you will only invalidate this tb.
>>>
>>> Give it a try and let us know if it works for your need.
>>>
>> Thank you for your suggestion. This is really useful information
>> regarding
>> internals of tb processing.
>> I set up a test to simulate a scenario where a TB flush is needed
>> and used the described mechanism. However, there is a threading limitati=
on:
>> qemu_plugin_write_memory_vaddr() must be called from a CPU thread.
>> In our current implementation dynamic faults are received and processed
>> by a background thread listening on a socket, so we cannot directly
>> use API from that context to trigger invalidation.
>>
>
> Indeed, when writing to a virtual address, we need to know the current
> execution context and page table setup to translate it. I have two
> ideas:
> - Register a callback per tb. When hitting a tb containing address
>   where to inject the fault, perform the read/write described above.

You could use a conditional callback with a scoreboard (or possibly
introduce a map feature similar to ebpf). You would track the address
ranges and latch the scoreboard when you want to look at something more
closely.

I wonder if allowing the TB itself to be invalidates conditionally would
be ok? We do try really hard to avoid exposing internal implementation
details to plugins but the concept of a block of instructions is kinda
already baked in. However we want to avoid plugins having to track a lot
of translation state to be useful.

> You always instrument, and selectively "poke" the code to trigger a
> new translation.
> - Simulate a given number of cpu watchpoints (N) by using N
>   conditional callback on every instruction, comparing current pc to N
>   addresses. I'm afraid it will be too slow.

I think you want at most one conditional check per instruction and then
take the slow path to check.

>
> One thing that could be considered on API side is to add a possibility
> to invalidate a specific hardware address (not all tb), based on
> tb_invalidate_phys_range. The problem is that plugin now need to keep
> track of all physical addresses matching virtual ones you want to
> invalidate, which is not convenient.
>
> Else, the easiest way to solve all this is to expose tb_flush, like
> you did, but keep this patch downstream for now.
> If your final plugin will stay downstream (which I expect, given it
> has its own protocol for injecting faults and no source for it), it's
> really the cheapest solution.
>
> The current design is built around the assumption that instrumentation
> is made at translation time (and not later). So changing it by
> instrumenting after translation brings new constraints we can't solve
> at the moment without exposing internal details.

We should certainly consider automatically triggering tb_flush() on each
qemu_plugin_register_vcpu_tb_trans_cb() so at least the case of
dynamically loading a plugin doesn't miss previous translations.=20

>
>>>> There are several scenarios where this might be needed, mainly for fau=
lts that
>>>> are difficult to define statically at boot time.
>>>> Examples include injecting faults after specific chain of events, free=
zing or
>>>> overriding system registers values at specific execution points (since=
 this
>>>> is currently implemented via PC triggers). Supporting environments wit=
h KASLR
>>>> enabled might be one more case.
>>>>
>>>
>>> For system registers, you can (heavy but would work) instrument
>>> inconditionally all instructions that touch those registers, so there
>>> would be no need to flush anything. System registers are not accessed
>>> for every instruction, so hopefully, it should not impact too much
>>> execution time.
>>>
>> Agree, this is a good optimization and indeed simplifies dynamic
>> faults
>> handling for system register reads.
>> Thank you for the recommendation!
>>
>>> With both solutions, it should remove the need to expose tb_flush
>>> through plugin API.
>>>
>>>>>
>>>>>>> The associated TRIGGER_ON_PC is very similar to existing inline
>>>>>>> operations. They could be enhanced to support writing to a given
>>>>>>> register, all the bricks are there. For TRIGGER_ON_SYSREG it's a bit
>>>>>>> more complex, but we might enhance inline operations also to support
>>>>>>> hooks on specific register writes.
>>>>>>
>>>>>> TRIGGER_ON_PC may also be used for generating other faults too. For =
example,
>>>>>> one use-case is to trigger CPU exceptions on specific instructions.
>>>>>> Supporting TRIGGER_ON_SYSREG as an inline operation sounds like a
>>>>>> really interesting
>>>>>> direction to explore.
>>>>>>
>>>>>
>>>>> In general, having inline operations support on register read/writes
>>>>> would be a very nice thing to have (though might be tricky to impleme=
nt
>>>>> correctly), and more efficient that the existing approach that requir=
es
>>>>> to check their value everytime.
>>>>>
>>>>>>>
>>>>>>> For MMIO override, the current approach you have is good, and it's
>>>>>>> definitely something we could integrate.
>>>>>>>
>>>>>>> What are you toughts about this? (especially the device based appro=
ach
>>>>>>> in case that you maybe tried first).
>>>>>>
>>>>>> I agree such an approach can work well for IRQ's and Timers, and wou=
ld be
>>>>>> more clean way to implement this.
>>>>>>
>>>>>> However, for SMMU and similar cases, triggering internal state error=
s is not
>>>>>> easy and requires accessing internal logic. So for those specific ca=
ses,
>>>>>> a different approach may be needed.
>>>>>>
>>>>>
>>>>> Thus the iommu-testdev I mentioned, that could be extended to support=
 this.
>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Pierrick
>>>>>>
>>>>>> BR,
>>>>>> Ruslan
>>>>>
>>>>> Regards,
>>>>> Pierrick
>>>
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

