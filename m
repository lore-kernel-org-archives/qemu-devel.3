Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D4FCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdAA-0000rB-Sb; Fri, 02 Oct 2026 09:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCdA3-0000qe-9P
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:18:52 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCdA0-0000ps-3G
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:18:51 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso13199555a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 06:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790947124; cv=none;
 d=google.com; s=arc-20260327;
 b=k2aTou/U+dlL3SmV4R4bUkdvVQZsnJ/HQziQWqocnYJz3FksE9+eVVu4tx0ciJ9tpb
 5y3CMGZtFQZubP7JS+SST//NtV4WMVXq7UihYNHvj4rcM6cChcZCY8QVWi6r8r+r1BDh
 X85xwVzaOTM+nJxnw9F8zRAiuNMT6/5YaM9hRSMKWMC2M3fZMBUJtt1hlE3Po0wyRE3n
 4/EPJP96okH1kCFdTXP5IwzpwZKAdzRkfv2M8uqgPmvGn0OEGJ7uftzr0IZF++79wRC3
 ZdAcs6DDfcKnSrmyuDU6Xt5P4YYVSMKsywNPaBob45bA9+yUy6E5E3QZeUcribhiP5Ob
 UUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
 :mime-version:dkim-signature;
 bh=9fbxp9v3agmpywD9Qv+/uJbWTAA1PxebC03hZgUiL8k=;
 fh=lgu5DXaluqoheOb4+nP0lQozQqbjUeOmtzLYLd1zWTg=;
 b=RuGe7GspiX9CwB3+rSeWumJJfT7wD26pCB2M+Aa7/qsgQwdPMysSqSEgFaCAeUDgsa
 fFgT+5x7tmJNAeXA2kqyB6Pmwbu+fVm+Qf+2GZj9lNy9czVWiwOStszVd2EgV9NNZRg+
 CPVpxFvqJtrAi530ZuSqvparbs2IUkwQFBsae+vVz12CzaJUa7A0YeuT2CkxHNhZqQf3
 hOsONhd4a8Aok28ASjO38BKbYySqTau+g+0jPySctqsqpjsGXFiMFzb/Esa1b99NmBN8
 8qXEIWv1QB3+egErvXtjrjUx38xjAs5J5a3Wag42Q8/M7t0svuY+ySPKj2DsumR7ZUUQ
 8SAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790947124; x=1791551924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9fbxp9v3agmpywD9Qv+/uJbWTAA1PxebC03hZgUiL8k=;
 b=d2BE2539lhai0oFO/Fe3FmYuv7HplL16ZntVFqsbXiq+/RkAWnxmo5D9g2ywaH5vTU
 jTo0E2rdIo05uTqjKcHcKEl7n0i5lW4Hom8N8Pbx5mYHjqjOOVZGfcdhksIQKNN9j7Dt
 BVtUVf1Zg3NVSQC5BIOw9XyJDn7dm5lJlYAN3FplKv25WPrfwb1AyytlSiFPgg9OSRCE
 HmzDoJfIQf6X8sC/4mQvP1GgtT4vuph+TluelGRCQrNXe/3vecPL6Wfas9MZHqegHevd
 DDSOc4wXJYg83WzWwiHqq6jPw3T8rrUezE9DnZ+irGXzdk1a1qg0hAjxdgrxx7RylyM3
 IU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947124; x=1791551924;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9fbxp9v3agmpywD9Qv+/uJbWTAA1PxebC03hZgUiL8k=;
 b=CvNk+4ljJohcw2531rY9uXtrOIdXPPUGI/oRu/nM6qpuGfxxRvDokbNW39yLip+mSb
 DvJWezHuXoOctwqrlpFJ6CkH2rnFMyTftA0vk4N05ZQbabOHQI9uEGoE5ckEBFrfpN0k
 Xi6xwlmjLoMe+kYm8bkXY15S3B1R7I2e+CfJS7DtSE6nosafVXsOlpIxwO/d36yOyDxF
 jOKVMxMtJor0ZHffb6k029WUel2A7/nBOzRuat9NIdgDhPABw42OXJdeMU14X6PHY/km
 Qsv2osMAK/iY9mUVtUNLEdojmjBAVq7Jj9hKp+luY7k5SLrn0i3dmFqqV+A0MZUKN150
 q0Fw==
X-Gm-Message-State: AFq9FYJoTRzThXeWAOjuhxOKvr3I3el/ssA3nUDndl6eXjB8xLL2EGmT
 x7vJnq74H3N0H/qnbZB+Q58Uer3A2RRa9RozL1mvKWzVci8WxaTWYNi4kUtq2GCgrYlseithkYt
 yZNwAcb56BM2U8ohJ4e8yg19SsoVBCXh2/Uy0gTU=
X-Gm-Gg: AYBFou14LIna559VReda900Mn/jNw17GBlLssG4VFoSwl0csdNRKnBWXtGTD9CJjICZ
 5qdBDd4LfAccq6cPuyb2NSMr0K9qgo0T29sOiKs2eC9JevOLvANgTfXIaVo42VdveV+kvbvlR3z
 Q0AAOBMZXZfBGTlAkWh+xtITYquNaS8KIu5KyzGwSMegoAxpUygUQ76lmWKpAWxD9CpkLwQNN08
 8sv6h7JLFOkDzqYGuehZYQZ2ZJE3B7NX6Ksfc9DaKql0bxo21NCikp/TJr8CBGM+XA63muPd50H
 OMivcUgaZWdk0BJ/pXcvcP2PNTVceacmgt7fUC6O89tGC+UXjKld/tVGEQD+GnXCAA==
X-Received: by 2002:a05:6402:2788:b0:6aa:9830:aa21 with SMTP id
 4fb4d7f45d1cf-6af9e374f3dmr1745177a12.39.1790947123728; Fri, 02 Oct 2026
 06:18:43 -0700 (PDT)
MIME-Version: 1.0
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 21:18:31 +0800
X-Gm-Features: AclHuK-Da7LuaqZ1n6YxW1PpTwBa2DGUO6wm2wQ_7-VsleSZLnvndw7faPbztYA
Message-ID: <CAE2XoE9X99kzBMWBo8rxmRGnT3NysHjf-GffC9X2796GGipUkg@mail.gmail.com>
Subject: [RFC] Target-aware machine inventory in combined qemu-system
To: qemu-level <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

## Goal

The goal is to specify the minimum useful design for a combined `qemu-syste=
m`
binary and use it as a basis for iteration, not to define multi-target supp=
ort
for every QEMU machine, CPU, and device.

The prototype combines two configured `SysEmuTarget`s that provide machines
with the same public name, `virt` (for example, AArch64 and RISC-V). Its fi=
rst
runnable case is concrete: start AArch64 `virt` with CPU `max` using an
explicit target:

```text
qemu-system -target aarch64 -machine virt -cpu max
```

It also defines what happens before a target is chosen. With target `none`,
QMP can inspect the complete machine inventory, and each `MachineInfo` repo=
rts
its supported targets. The CLI must not guess which `virt` to run; it repor=
ts
the targets that provide that name. Inferring a target from `argv[0]` is
deferred because the current build does not provide target-named symlinks t=
o
the combined `qemu-system` binary. Existing per-target binaries and their
familiar machine names remain unchanged.

Implementation branches:

- [single-binary-arm-riscv](https://gitlab.com/lygstate-qemu/qemu/-/tree/si=
ngle-binary-arm-riscv?ref_type=3Dheads)
  combines `none-softmmu`, `aarch64-softmmu`, `arm-softmmu`, and
  `microblaze-softmmu`.
  [CI pipeline for
single-binary-arm-riscv](https://gitlab.com/lygstate-qemu/qemu/-/pipelines/=
2906623802).
- [combined-binary-multi-targets](https://gitlab.com/lygstate-qemu/qemu/-/t=
ree/combined-binary-multi-targets?ref_type=3Dheads)
  extends the combined target set with `riscv32-softmmu`, `riscv64-softmmu`=
,
  `i386-softmmu`, and `x86_64-softmmu`.
  [CI pipeline for
combined-binary-multi-targets](https://gitlab.com/lygstate-qemu/qemu/-/pipe=
lines/2906685964).

## Design

There are three possible policies for deciding which target a combined
emulator should run:

1. **Infer from `argv[0]`.** A target-named symlink to the combined
  `qemu-system` binary could provide a target-specific invocation name and
  allow target selection from `argv[0]`. Defer this policy: the current bui=
ld
  does not provide those symlinks, so there is no target-specific invocatio=
n
  name to inspect.
2. **Require an explicit `-target` for execution.** This is the current
  selection mechanism. Parse `-target` early, select its `TargetInfo` befor=
e
  module and QOM initialization, then resolve `-machine` and `-cpu` within
  that target. For example:

  ```text
  qemu-system -target aarch64 -machine virt -cpu max -S -display none
  ```

  This makes target choice explicit when starting a target-specific machine=
;
  it does not prevent a target-neutral inspection mode.

1. **Expose no target-specific machine for execution while the target is
  `none`.** Do not guess which same-named machine to start. This is not a
  policy of hiding machines from management clients: `query-machines` still
  reports the combined inventory and each machine's supported targets.

The implementation below combines the second and third policies. The first
can be considered later without changing the inventory contract. The design
has three stages: register the combined type set, use target availability
when resolving a requested machine, and expose the complete inventory throu=
gh
QMP.

### 1. Combined Registration Before QOM Hooks

Before the optional QOM hooks described below, `type_register_internal()`
skipped availability filtering in the combined binary and retained
`TypeInfo`s from all configured targets. Single-target binaries continued t=
o
filter each type against the selected target during registration. Retaining
the full type set lets the target-`none` inventory report machines and the
targets that provide them.

`type_init()` functions are collected before they run, so `TypeInfo`
registration is not guaranteed to be parent-first. A child may register
before its parent. When a `TypeInfo` is registered, `type_new()` copies its
`is_available` function pointer into the new `TypeImpl`. The registered typ=
e
retains the callback value supplied by that `TypeInfo` for later processing=
.

### 2. Resolve Machine Names Without Guessing

For a selected target, normal machine lookup sees only machine classes
available to that target. If lookup fails, the error path scans the complet=
e
registered machine list and evaluates each matching name or alias against a=
ll
registered `TargetInfo` values.

For example, the existing qtest exercises the `none` case. The target is
selected as `none`, but machine registration has retained the target-specif=
ic
classes, allowing the error path to explain where `virt` is available:

```text
$ qemu-system -machine virt
unsupported machine type: "virt" for target "none"
Available for targets:
  aarch64
  arm
Use -machine help to list supported machines
```

The command fails rather than selecting an arbitrary `virt`. This also lets
users of a target-specific binary continue to use the familiar machine name=
;
the combined binary's explicit target path remains available when starting =
a
machine:

```text
qemu-system -target aarch64 -machine virt -cpu max -S -display none
```

Here `-target aarch64` selects the target before QOM and machine setup, and
`-S` leaves the guest paused. This is an example of the existing target
selection path, not a new CLI proposal in this RFC.

### 3. Report the Combined Inventory

`query-machines` iterates over the registered machine classes. For each cla=
ss,
it returns the public machine `name`, the actual QOM `typename`, and every
configured target for which the class's availability callback returns true.
This allows clients to distinguish machines that share a public name and
look up the right QOM type without deriving it from `-M`.

An abbreviated response for a combined build containing ARM-family and
RISC-V targets can look like this; the exact records depend on the configur=
ed
targets and machines:

```json
{
  "return": [
    {
      "name": "virt",
      "typename": "arm-virt-machine",
      "targets": [{ "arch": "aarch64" }, { "arch": "arm" }]
    },
    {
      "name": "virt",
      "typename": "riscv-virt-machine",
      "targets": [{ "arch": "riscv32" }, { "arch": "riscv64" }]
    }
  ]
}
```

A client can then use the returned QOM type directly:

```json
{
  "execute": "qom-list-properties",
  "arguments": { "typename": "arm-virt-machine" }
}
```

This RFC describes inventory and diagnostics; it does not change the target
selection CLI or propose globally filtering devices.

### Optional: QOM before/after hooks

The hooks are an optional implementation of post-registration processing:
they run around `MODULE_INIT_QOM` to validate parent chains after registrat=
ion
batches. The after-hook walks the full registered-type set, validates paren=
t
links, and inherits each missing `is_available` callback from its parent.
`TYPE_OBJECT` and `TYPE_INTERFACE` are distinct roots; each root's `TypeInf=
o`
explicitly sets the callback to `target_is_any`. A child may provide its ow=
n
callback or leave it NULL to inherit from its parent. The completed pass
therefore gives every registered type an effective callback before filterin=
g.
Filtering is optional; when used, it runs after registration and parent
validation, reclaiming runtime QOM metadata but not compiled code.

#### ARM and AArch64 example

The unit test registers a shared ARM-family parent, narrower ARM and AArch6=
4
parents, and callback-free children. It uses `TYPE_OBJECT` as the test root=
:

```c
#define TYPE_ARM_BASE_MACHINE_FAMILY "test-avail-arm-base-machine-family"
#define TYPE_VIRT_MACHINE_VERSION "test-avail-virt-machine-version"
#define TYPE_ARM_MACHINE_FAMILY "test-avail-arm-machine-family"
#define TYPE_ARM_MACHINE "test-avail-arm-machine"
#define TYPE_AARCH64_MACHINE_FAMILY "test-avail-aarch64-machine-family"
#define TYPE_AARCH64_MACHINE "test-avail-aarch64-machine"

static const TypeInfo arm_base_machine_info =3D {
    .name =3D TYPE_ARM_BASE_MACHINE_FAMILY,
    .parent =3D TYPE_OBJECT,
    .abstract =3D true,
    .is_available =3D target_is_base_arm,
};

static const TypeInfo virt_machine_version_info =3D {
    .name =3D TYPE_VIRT_MACHINE_VERSION,
    .parent =3D TYPE_ARM_BASE_MACHINE_FAMILY,
};

static const TypeInfo arm_machine_family_info =3D {
    .name =3D TYPE_ARM_MACHINE_FAMILY,
    .parent =3D TYPE_ARM_BASE_MACHINE_FAMILY,
    .abstract =3D true,
    .is_available =3D target_is_arm,
};

static const TypeInfo arm_machine_info =3D {
    .name =3D TYPE_ARM_MACHINE,
    .parent =3D TYPE_ARM_MACHINE_FAMILY,
};

static const TypeInfo aarch64_machine_family_info =3D {
    .name =3D TYPE_AARCH64_MACHINE_FAMILY,
    .parent =3D TYPE_ARM_BASE_MACHINE_FAMILY,
    .abstract =3D true,
    .is_available =3D target_is_aarch64,
};

static const TypeInfo aarch64_machine_info =3D {
    .name =3D TYPE_AARCH64_MACHINE,
    .parent =3D TYPE_AARCH64_MACHINE_FAMILY,
};

static void register_target_family_types(void)
{
    type_register_static(&virt_machine_version_info);
    type_register_static(&arm_machine_info);
    type_register_static(&aarch64_machine_info);
    type_register_static(&arm_base_machine_info);
    type_register_static(&arm_machine_family_info);
    type_register_static(&aarch64_machine_family_info);
}
```

The test selects an ARM-family target, verifies that its child inherits the
parent callback, and checks that the other family's child is filtered out.
Production ARM `virt` uses the same shape with `TYPE_ARM_BASE_MACHINE` pare=
nted
to target-neutral `TYPE_MACHINE`; each versioned `virt` TypeInfo inherits f=
rom
that family parent.

`DSO_BEFORE` registrations defer validation until normal QOM initialization=
,
so parent types from the static `type_init()` batch have a chance to regist=
er.
`DSO_AFTER` registrations are checked after each batch. This hook arrangeme=
nt
provides incremental validation for late registrations; it is an
implementation choice, separate from the combined binary's requirement to
register types before applying target filtering.

## Reviewer Concerns and Design Responses

The responses below describe the current prototype. Broader policies that
remain open are listed under [Remaining Questions](#remaining-questions).

- **Pierrick Bouvier: RFC request and machine-selection ambiguity.** Pierri=
ck
  requested this focused RFC:

  > @Yonggang: can you try to provide a RFC based on this, to see what it
  > could look like? No need to cover all machines/cpus, just select one of
  > machine+cpu, ideally with multiple SysEmuTarget (like virt and max cpu
  > for aarch64), and let's iterate from this.

  On target-qualified machine names and ambiguous lookup, he wrote:

  > That's my point, the current abstraction will create something ambiguou=
s
  > by design. When people will specify -M virt, without $arch:, a random
  > machine will be selected. At least, maybe this series should ensure the=
re
  > is only one virt alias, or make it forbidden and uses unambiguous names
  > only.
  >
  > "$arch:" is just a workaround to not add -target option, except that it
  > comes with additional problems, creating inconsistent command lines. I
  > already expressed my skepticism about the "machine prefix" based approa=
ch,
  > being more in favor to strongly filter types per target with an
  > unambiguous -target option.

  **Response:** the prototype uses the dedicated `-target` option, selectin=
g
  `TargetInfo` before QOM setup, while preserving `virt` as the `-M` name.
  With target `none`, `-M virt` fails and reports the targets that provide =
the
  name instead of choosing one. A spelling such as `-machine aarch64-virt` =
is
  not a reliable general alternative: hyphens already occur in machine name=
s
  such as `virt-11.1` and `sbsa-ref`, so a parser cannot safely split a mac=
hine
  name at the first hyphen. Resolving the name by searching registered
  machine classes would require QOM initialization, but the target must be
  selected before QOM setup. A literal alias could be added for one machine=
,
  but that would be a per-machine convention, not general target selection.
  The concrete run and failure cases are shown in [Design](#design).
- **Daniel P. Berrange: target metadata and device compatibility.** Daniel
  wrote:

  > It would require that we introduce a new field in MachineClass
  > that returned that information about what target a machine is
  > associated with.
  >
  > I note the SysEmuTarget covers both 32-bit and 64-bit variants.
  >
  > It might be better use QEMU_ARCH which correlates directly to
  > the TCG targets, rather than the traditional binary target
  > names?
  >
  > Likely the CPU class would also want to declare its list of
  > supported targets.
  >
  > IMHO just leave devices to raise an error when passed to '-device'
  > if not compatible with the requested machine.

  **Response:** the prototype represents availability with
  `TypeInfo.is_available(TargetInfo *)` on each type, rather than adding a
  separate target list to each machine and CPU class. A NULL callback inher=
its
  availability from the parent; the root types default to `target_is_any`.
  `SysEmuTarget` is retained because it distinguishes system-emulation
  variants such as 32-bit and 64-bit targets. `query-machines` evaluates th=
e
  availability callback for each configured target and returns the resultin=
g
  `MachineInfo.targets`; the `-target aarch64 -machine virt -cpu max` examp=
le
  demonstrates selecting a compatible machine/CPU pair. The prototype does
  not add exhaustive per-device target metadata: devices may fail setup whe=
n
  their required machine bus is absent, with better diagnostics left as
  follow-up work.

  Target identity is kept distinct from the base architecture with
  `TARGET_SYS_EMU`. Meson defaults it to `TARGET_NAME` for softmmu targets =
and
  to `TARGET_ARCH` for other targets, unless a target config overrides it.
  Thus system-emulation variants such as `arm` and `aarch64` remain distinc=
t
  even when they share a base `TARGET_ARCH`. `TargetInfo.target_arch` is bu=
ilt
  from `TARGET_SYS_EMU`:

  ```diff
  - .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
  + .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
  ```

  Full change: [GitLab commit
diff](https://gitlab.com/lygstate-qemu/qemu/-/commit/b765db23b4294a7ca829e1=
5e8577af228f229f37).

- **Philippe Mathieu-Daude: target discovery and scope.** Philippe wrote:

  > Why mix target information parsing at machine level when the
  > machine already know it is target specific? People wanting to
  > use the ARM virt machine don't want to know (and don't care)
  > about the M68k virt machine.
  >
  > You still did not explained what you are trying to achieve
  > with all your contributions, so my view is surely biased by
  > what we envisioned 3 years ago when we started to pave our
  > way for heterogenous emulation.
  >
  > My options so far for a single binary:
  >
  > - infer from argv[]
  > - enforce with CLI -target
  > - not expose any machine

  **Response:** The goal here is the target `none` inspection case, not a
  requirement that ARM users select or even list unrelated machines to run
  ARM `virt`. All registered machines remain visible through `query-machine=
s`,
  with each `MachineInfo` carrying its supported `targets`; this lets
  management clients discover the combined inventory. For CLI execution, a
  target-specific machine is resolved only after explicit `-target` selecti=
on.
  At target `none`, a request such as `-M virt` fails with the supported-ta=
rget
  hints instead of choosing a machine. Inferring from argv is deferred, and
  the inventory/QOM-name work is kept separate from the broader
  heterogeneous-emulation selection design.
- **Markus Armbruster: QOM identity in `query-machines`.** Markus's message
  quoted the patch rationale and acked it:

  > query-machines returned only the -M name, so management apps inferred
  > the QOM type as that name plus "-machine". A prefixed type such as
  > arm-virt-11.1-machine no longer matches -M virt-11.1. Return the QOM
  > type in MachineInfo typename from object_class_get_name() in
  > qmp_query_machines(). test_query_machines_typename checks that
  > qom-list-properties accepts it.
  >
  > Acked-by: Markus Armbruster <armbru@redhat.com>

  **Response:** `query-machines` returns the public machine `name`, the act=
ual
  QOM `typename`, and supported `targets`. The QOM type is obtained from
  `object_class_get_name()`, so management clients can pass it to
  `qom-list-properties` instead of deriving it from the `-M` name.
  `test_query_machines_typename` covers this lookup.

## Existing Tests

- `test_combined_errors` verifies that `-M virt` at target `none` fails,
  includes the available targets, and does not fall through to an unrelated
  target-help hint.
- `test_combined_machine_list` verifies the combined machine inventory agai=
nst
  the configured target list.
- `test-qom-is-available` checks callback inheritance for ARM and AArch64
  family parents, target filtering, late registration, class-data destructi=
on,
  missing parents, and parent cycles.
- The combined machine-option tests also exercise explicit target selection
  and machine startup, including the AArch64 `virt` machine.

## Remaining Questions

- Is the current `-M virt` error with supported-target hints sufficient, or
  should a later CLI provide a separate way to choose among candidates?
- Is `MachineInfo.targets` sufficient for management clients to interpret
  the combined inventory?
- Should devices receive explicit target-availability annotations, or is
  machine setup failure with useful diagnostics sufficient?
- After registration, should the combined emulator free QOM metadata for
  types unavailable to the selected target to save runtime memory, or keep
  all types registered and require every lookup and listing path to check
  availability? Keeping all types simplifies the complete inventory but
  retains metadata for targets that are not selected.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

