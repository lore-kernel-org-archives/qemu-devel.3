Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3BD109190B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Hz4-0002Z1-FJ; Thu, 19 Mar 2026 14:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w3Hyv-0002Xx-7w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:20:30 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w3Hyt-0003vW-6c
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:20:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46702742c99so723897b6e.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773944425; cv=none;
 d=google.com; s=arc-20240605;
 b=CPBgKO4b1JKiefvnElpQxrzn0/R+d2gpj2TQ98QitzzA3Sg2VEh4qvIkkQEAyLtON6
 v1mnjhiwWu1Rjo8WNngptNTZOQ84XiA9Wl/Rz9OLvnh1KOGEUkivYOWomVeqmQhS+gWw
 GfLnvLK5M31wS+RSTcHxlru3ghh/93nivTlTXllYYe34cqak4naIvMzPJ2WwmX0FXsKs
 Nqi0i+cFeHKS5uJkiANQsa2URUz3aEicvd/gweSt1PQnmou7Tb5QwO3ltX4HUlwJCb+c
 +mGpneYV/xRs0QId+0gsUEjfwbDO5FZYFDrPUDoO9Ndf+Ttsws7Q4SHaVE+XPmmG2HP3
 sFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HZ2dwR8jhlz6FuGqGwsHXSIftlVo13eRV+oZX8fBA6o=;
 fh=q4q/vXes3FoEamFAzRw19gQc6zeAKWvBwB+8E/Ot0+E=;
 b=IsIzS50SQApmwJOHufS4ydN/Dco2axdm8HScjFZC9g7ayXxiUi+fwd68iW+IeSlNcg
 n91E8Xq7UNpZeHhJWTibQCAf2Vc32BACfRHERskOdmBbtJxqtaoDOYTBeC0ApItMvrCW
 KEq4ENX1ztQhDGa75xSESoCUAzoEuzn0uhiyf50SrHE26C/VnJwUkTLAqrB0MjHNgxn5
 uW0QWlh+sdCHyGJVLKaJM6v01CXsZSXzcTrMtXrjzdD2dsdM7HiGTBFNHfOQJZWWTX7s
 Abix1yInjsu1NVqbTyHBEWv+3qoA+A7pg4dqr/r3MIsEYlT7AwDXiuaQrBH5mYcexdic
 69hQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773944425; x=1774549225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ2dwR8jhlz6FuGqGwsHXSIftlVo13eRV+oZX8fBA6o=;
 b=h9m0BL3H0EixSg7XTNJpr6Uft7jyYO4uip4xTfbNNWZJmI3UhMd9wBL+nXL5ziunrZ
 vAecdkaybLrtKGH2ywKlFkHMAoA7GMoF3HZd1/iSjvGRFXu/bo9Jh/2rUpI+A8Kgz/ZW
 M0WNNgeRuG2PXYsSuBpMeaDUBAIz7zIIlF/nHdTavLvj8gbEEXXO3jcH14HpcXV9CrXX
 PLMdSCc1GdLyJzEjJn/sq1lo9BzmChVAaGc9ldGZWaT5u03pCvZTsZnwvivoFt8oiLEE
 AK2zJ9HeYlt5cSxzBIHQPT+UEFfjlY+lu5GkL1lKj+klTmZeLx9BnenrGcP3BXCvn5IQ
 CFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773944425; x=1774549225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZ2dwR8jhlz6FuGqGwsHXSIftlVo13eRV+oZX8fBA6o=;
 b=R7TDLh7K6HJYGJ+h8vtk23cDqrHuCitznEP2eEa/gBg13O0OMJyM84DtkdU1D2Gofi
 8NoF40O+ShrSHJcdEmpjGMyznqSypq4cYypmirGLoYI/wAmVmvxbINWsk9oMDR9otkrI
 RC65GIZlP4ej0slGG2zXXlEdE3+G7iL4JE0mvA2og7l+myA+Mwz1shy/CiHD2iKdpIKn
 y9klAcqKFcGNngGqkKNe1VWLzEgAOSASdsVyDi7MgwHH7A2sm0U42LgHnD7eTm0aTR6v
 Ly5fb62x314/kWY8U7C8+6XFQkrplXdC3JcX3+tNBvMDPzpsLAooC0QGEevoySx5KixL
 ElAQ==
X-Gm-Message-State: AOJu0YxZ9eakGfKVqJDLWZwlbOKgXQ4pCECt9mfn0huc0mpXUG0HcW/a
 5H5OVRZoGHumOKbj66uE3bFNV9uKtk53QPMGCUnbUamYcDIInztvTiVmHDt68wv387Igz4lbFO/
 S7Ssr4jRkt2/l9VJ0xJVUeFbqM3dZk24=
X-Gm-Gg: ATEYQzzi50+azEX+RCe3S4ObLB7cbH6Rk8tKeuGs+aAl2Mj0U+hntopl6nHrnVFjbwu
 R0gCL+3aTnqVHj+UjA7p56RxZYQQK718hwJ/dA/KNZS2vP0KE+0nV3yd5wU/Mwftrtrf2jPl9pu
 5le1Uw29Fe7gCu4Aqlpj4rcZSv9nlUl0xEkfD473FUekaT1vEJ2Md7UjFAcrVkPt4oImcWatLkb
 gaf0gSSmIBAB/HQ1AenZie5mY+z7FjZyHn46B6xJCrSTd5MsyQQJEvNEEi0xVC25B8K77gx48Rw
 Qc23u2qZ
X-Received: by 2002:a05:6808:2508:b0:467:1e5:674a with SMTP id
 5614622812f47-467e5fc5af3mr35217b6e.52.1773944425335; Thu, 19 Mar 2026
 11:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
In-Reply-To: <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Thu, 19 Mar 2026 19:20:14 +0100
X-Gm-Features: AaiRm53aVuxsvJd0_9ygqtJDL00A3DdkbHEhGmhyNj7m9QdeiR-nkzsiIYsaa68
Message-ID: <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework and
 API extensions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 volodymyr_babchuk@epam.com, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Pierrick,

Thank you for the feedback and review!

Our current plan is to put this plugin through our internal workflows to ga=
ther
more data on its limitations and performance.
Based on results, we may consider extending or refining the implementation
in the future.

Any further feedback on potential issues is highly appreciated.

On Wed, Mar 18, 2026 at 6:16=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Ruslan,
>
> On 3/18/26 3:46 AM, Ruslan Ruslichenko wrote:
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > This patch series is submitted as an RFC to gather early feedback on a =
Fault Injection (FI) framework built on top of the QEMU TCG plugin subsyste=
m.
> >
> > Motivation
> >
> > Testing guest operating systems, hypervisors (like Xen), and low-level =
drivers against unexpected hardware failures can be difficult.
> > This series provides an interface to inject faults dynamically without =
altering QEMU's core emulation source code for every test case.
> >
> > Architecture & Key Features
> >
> > The series introduces the core API extensions and implements a fault in=
jection plugin (contrib/plugins/fault_injection.c) targeting AArch64.
> > The plugin can be controlled statically via XML configurations on boot,=
 or dynamically at runtime via a UNIX socket (enabling integration with aut=
omated testing frameworks via Python or GDB).
> >
> > New Plugin API Capabilities:
> >
> > MMIO Interception: Allows plugins to hook into memory_region_dispatch_r=
ead/write to modify hardware register reads or drop writes.
> > Asynchronous Timers: Exposes QEMU_CLOCK_VIRTUAL to plugins, allowing ca=
llbacks to be scheduled based on guest virtual time.
> > TB Cache Flushing: Exposes qemu_plugin_flush_tb_cache() so plugins can =
force re-translation when applying dynamic PC-based hooks.
> > Interrupt & Exception Injection: Exposes APIs to raise/pulse hardware I=
RQs on the primary INTC and inject CPU exceptions (e.g., SErrors).
> > Custom Device Faults: Introduces a registry where device models (e.g., =
SMMUv3) can expose specific fault handlers (like CMDQ errors) to be trigger=
ed externally by plugins.
> >
> > Patch Summary
> > Patch 1 (target/arm): Adds support for asynchronous CPU exception injec=
tion.
> > Patch 2-3 (plugins/api): Exposes virtual clock timers and TB cache flus=
hing to the public plugin API.
> > Patch 4 (plugins): Introduces the core fault injection subsystem, IRQ/E=
xception routing, and the Custom Fault registry.
> > Patch 5 (system/memory): Adds the MMIO override hooks into the memory d=
ispatch path.
> > Patch 6 (hw/intc): Registers the ARM GIC (v2/v3) with the plugin subsys=
tem to enable direct hardware IRQ injection.
> > Patch 7 (hw/arm): Registers the SMMUv3 with the custom fault registry t=
o demonstrate how device models can expose specific errors (like CMDQ fault=
s) to plugins.
> > Patch 8 (contrib/plugins): Implements the actual fault_injection plugin=
 using the new APIs.
> > Patch 9 (docs): Adds documentation and usage examples for the plugin.
> >
> > Request for Comments & Feedback
> >
> > Any suggestions on improvements, potential edge cases, or issues with t=
he current design are highly welcome.
> >
> > Ruslan Ruslichenko (9):
> >    target/arm: Add API for dynamic exception injection
> >    plugins/api: Expose virtual clock timers to plugins
> >    plugins: Expose Transaction Block cache flush API to plugins
> >    plugins: Introduce fault injection API and core subsystem
> >    system/memory: Add plugin callbacks to intercept MMIO accesses
> >    hw/intc/arm_gic: Register primary GIC for plugin IRQ injection
> >    hw/arm/smmuv3: Add plugin fault handler for CMDQ errors
> >    contrib/plugins: Add fault injection plugin
> >    docs: Add description of fault-injection plugin and subsystem
> >
> >   contrib/plugins/fault_injection.c | 772 +++++++++++++++++++++++++++++=
+
> >   contrib/plugins/meson.build       |   1 +
> >   docs/fault-injection.txt          | 111 +++++
> >   hw/arm/smmuv3.c                   |  54 +++
> >   hw/intc/arm_gic.c                 |  28 ++
> >   hw/intc/arm_gicv3.c               |  28 ++
> >   include/plugins/qemu-plugin.h     |  28 ++
> >   include/qemu/plugin.h             |  39 ++
> >   plugins/api.c                     |  62 +++
> >   plugins/core.c                    |  11 +
> >   plugins/fault.c                   | 116 +++++
> >   plugins/meson.build               |   1 +
> >   plugins/plugin.h                  |   2 +
> >   system/memory.c                   |   8 +
> >   target/arm/cpu.h                  |   4 +
> >   target/arm/helper.c               |  55 +++
> >   16 files changed, 1320 insertions(+)
> >   create mode 100644 contrib/plugins/fault_injection.c
> >   create mode 100644 docs/fault-injection.txt
> >   create mode 100644 plugins/fault.c
> >
>
> first, thanks for posting your series!
>
> About the general approach.
> As you noticed, this is exposing a lot of QEMU internals, and it's
> something we tend to avoid to do. As well, it's very architecture
> specific, which is another pattern we try to avoid.
>
> For some of your needs (especially IRQ injection and timer injection),
> did you consider writing a custom ad-hoc device and timer generating thos=
e?
> There is nothing preventing you from writing a plugin that can
> communicate with this specific device (through a socket for instance),
> to request specific injections. I feel that it would scale better than
> exposing all this to QEMU plugins API.
>
> For SMMU, this is trickier. Tao recently (6ce361b02c82) an iommu test
> device, associated to qtest to unit test the smmu implementation. We
> could maybe see to leverage that on a full machine, associated with the
> communication method mentioned above, to generate specific operations at
> runtime, all triggered via a plugin.
>
> Exposing qemu_plugin_flush_tb_cache is a hint we are missing something
> on QEMU side. Better to fix it than expose this very internal function.

The reason this was needed is that the plugin may receive PC trigger
configuration
dynamically and need to register instruction callback at runtime.
If the TB for that PC is already translated and cached, our newly registere=
d
callback might not be executed.

If there is a more proper way to force QEMU to re-translate a specific
TB or attach
a callback to cached TB it would be great to reduce the complexity here.

> The associated TRIGGER_ON_PC is very similar to existing inline
> operations. They could be enhanced to support writing to a given
> register, all the bricks are there. For TRIGGER_ON_SYSREG it's a bit
> more complex, but we might enhance inline operations also to support
> hooks on specific register writes.

TRIGGER_ON_PC may also be used for generating other faults too. For example=
,
one use-case is to trigger CPU exceptions on specific instructions.
Supporting TRIGGER_ON_SYSREG as an inline operation sounds like a
really interesting
direction to explore.

>
> For MMIO override, the current approach you have is good, and it's
> definitely something we could integrate.
>
> What are you toughts about this? (especially the device based approach
> in case that you maybe tried first).

I agree such an approach can work well for IRQ's and Timers, and would be
more clean way to implement this.

However, for SMMU and similar cases, triggering internal state errors is no=
t
easy and requires accessing internal logic. So for those specific cases,
a different approach may be needed.

>
> Regards,
> Pierrick

BR,
Ruslan

