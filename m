Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FBECA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCHv-0000qX-Lk; Mon, 28 Sep 2026 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBCHp-0000pv-Pr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:24:57 -0400
Received: from mail-ed2-x0d.google.com ([2a00:1450:4864:33::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBCHn-0005La-LA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:24:57 -0400
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab06778bdfso2408575a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790605494; cv=none;
 d=google.com; s=arc-20260327;
 b=IYxF0SLF8+aoWwVnldjQGq27ausX1eb2SFuhNtBohlOggx/TmLdiqVaALk7/ZhY349
 ikg4tuQzcThI6Us89qDtC9ProWcXdOewLzVCp3UwezVvpCrLbNTL7wC3b5chx3UR6AsU
 MK0g2NN4/XSKTf1KeBYcNXu1zAcps4gOan6pdpvGB3O7KwyQcYDO75RcHq1m7lIdiEUN
 MEmiKNT7y8iZCngonE6hO9qeIRaKd0WP13RTUd1bkkicO4fCyvLEJrL+mtSuI03d/LqQ
 yQOrkrTHLOAAQzI0u2QWVsl3zgW+e/Ngcv2P5x9IT85vxUECK3rIEe1Efv/e+tslyxA4
 Zwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
 fh=4eeYYN7SaSVMgnkle1XNo8n3Za5vqgebzO1th9Am2XA=;
 b=Xn1BG2FJ5ObYSNdOM1G2+LAbFAyBdDwlIsFFOZpBnMp9L4h7ZxVCAlqll1H4hmVV3P
 T85vH2HSWbb+4Z3coQ45rBljd26SsXp7MpGti3hoiKzYdYTRXN1p0WuwSPFwvITU2TeM
 2OUb+KO67voXoZMQ4MidazsJctXlFPk3heWzN3EIfQj4ecokuGupuhAvZn7/l3Ne6IS4
 zMdfHJaDWn2HyXJx4ggVCDXJyylNi7I9EM7Wtg1k1TGkO15xryWMN+j5aFlUgwVX13+7
 tHnoXVuCDIIGR5DY1Bbbrilf1Axu5gRlyM7M9JiYrCSfZVvtahV89G6ReknnxGobeRZK
 QUGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790605494; x=1791210294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
 b=QTBfeR5R5d35Fu47R5GzlLBKCN4YhZ1rkf5zSk+ww9HsczuuPi8HqsgXORMcuM6d+G
 xwXNG3ds8S5mTK4wGL2GagXndrf3OPNT683o6AKtGKEzkGiBf6mAIjzDHzRxN0S8F7dS
 /NkN93bJK2S5nChO5e3WURr4IIvJwRY+FrOKAfD9dcFHjvGsClBF9l04KWlUDaC8UKIV
 GJzA3BZH3RtHW98m/Ypu8OHdc48xvawkm87qIgDJEk0/ep+4qp8R9xej+2CNuzgXvHNj
 /r1dWBuSwWl6is5ee9jRtxCOzmuNlvgNKoeh6o5ZebMagsy6p1lcszTu/kIo3MxAfG4c
 qQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605494; x=1791210294;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
 b=EcsGrhJYyBQXbIiSJvmjhmKPeZQ3GXxncOl01Pxr2TwAvUUvWvmxQ0N/nK6aDjPMYD
 OvL7BBhkJ8aaF+eveCtAycjY7NQpOnSChkDfZIE6dgPBiJgBS+RMCkH5qXRiEzxdkYjS
 zuAC95XTg5D1XT0hsaSeOsvNO241A2cyiC1WMRAKCEhgEzYRp7KOqPbmCClTgjXgIOJV
 4mKMsWbNPH0ky9PQgMjUc6wbetNyJsiKfHkxZE+HISx+1N7qMRsTjovIoNK//bMGzqUK
 jz8SBuUMeUtJksf20P+E8V+PGiew50MdRBi/eT4CFwMw+czZTdtC+gYNA/OO5kjggQl0
 AlYQ==
X-Gm-Message-State: AFq9FYLTAAr9BixMAz897WgnoF+ewlwGRXkVwNlKd0DJkk6+WQBs3bWR
 3HO3szH4SOWI3cz85CQVpFJA/X+gQg+gkQ9s6KuRM0ME4ltccbqn5LqkUoKeO+yuseJTJ7UgMFk
 acTBx+O60LXUbBH1dZebWvbi6303jEHY=
X-Gm-Gg: AYBFou2WVSKp4VFdCWvxIG2469JkdRwjkZP2xAqV9Mf13DKFQzNmGBuYH82a1kp0TdT
 zgXTjfVSc1toMqMSoERgpvoMBAnkbNG7rSc2G7cd6wdON8x95fq/zC7iwIkS/lMsXJo9BdNtzes
 5VAcYd7qxRESX9kFLdORY6PDKHSeJfsDG6fD17bg1+JgR0jfCJ3+xZGTZYZTKqe2p622dEKiutz
 t/NkIj8Y0XzYHWrS5kiFqVCKt8U+v5c4wa904MOaEJqn5DyKcakUIH+gun8RaYTuEyvYHP59b26
 qGnOvEb/7DsUa6T+sDzJgLA9B7jOLj6A7zBt3re1g3b/KD6KK6f8Tn8=
X-Received: by 2002:a05:6402:2406:b0:6aa:734b:1a2d with SMTP id
 4fb4d7f45d1cf-6aac908f34amr10185339a12.39.1790605493584; Mon, 28 Sep 2026
 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
In-Reply-To: <aro93NuZBXYGbD33@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 22:24:39 +0800
X-Gm-Features: AclHuK_TF7EH46o0FV_02vjDQ7TfERSCRkWxvOvxDGTBInzpkGOWpF_MFAtARQg
Message-ID: <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0d.google.com
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

On Mon, Sep 28, 2026 at 6:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> I don't think that we need to report machines though.
> We already have 'query-machines' which gives much broader
> information on the machines. "MachineInfo" needs to
> gain
>
>    "targets": ["SysEmuTarget"]
>
> to list which target(s) a machine can be used with.
>

This is my final design for the query-target / query-targets / query-machin=
es,
for consistency and testability.

Per review: reuse `QemuTargetInfo` for both target commands, drop the
per-target machine list, and let
`MachineInfo` say which target(s) each machine runs on.
`QemuTargetInfo` stays small; `query-target` and `query-targets` return a
derived struct that adds the target's device and accel Kconfig state.

## QemuTargetInfo

```
{ 'struct': 'QemuTargetInfo',
  'data': { 'arch': 'SysEmuTarget' } }  # since 1.2
```

`mips` and `mipsel` are distinct `SysEmuTarget` values; the target value
identifies the system emulator, including its endianness, rather than only
the underlying architecture family.

## QemuTargetDetails: QemuTargetInfo plus kconfig

```
{ 'struct': 'QemuTargetDetails',
  'base': 'QemuTargetInfo',
  'data': { 'kconfig': 'any' } }
```

`kconfig` maps every device and accel `CONFIG_*` symbol to whether it
is enabled for that target.

For example, `TYPE_NITRO_ENCLAVE_MACHINE` is available only when
`CONFIG_NITRO_ENCLAVE` is enabled for the target:

```
{ "arch": "x86_64",
  "kconfig": { "CONFIG_NITRO_ENCLAVE": true } }
```

Examples below are trimmed.

## query-target (now returns QemuTargetDetails)

Adding members to a return type is backward compatible; existing
clients reading only `arch` are unaffected.

```
{ 'command': 'query-target', 'returns': 'QemuTargetDetails' }
```

Single-target binary (`qemu-system-aarch64`):

```
-> { "execute": "query-target" }
<- { "return": { "arch": "aarch64",
                 "kconfig": { "CONFIG_ARM_VIRT": true,
                              "CONFIG_Q35": false,
                              ... } } }
```

## query-targets (new, returns ['QemuTargetDetails'])

Single-target binary:

```
-> { "execute": "query-targets" }
<- { "return": [ { "arch": "aarch64",
                   "kconfig": { "CONFIG_ARM_VIRT": true,
                                "CONFIG_Q35": false, ... } } ] }
```

Combined `qemu-system` linking aarch64 and riscv64 (`none` is always
present):

```
-> { "execute": "query-targets" }
<- { "return": [ { "arch": "aarch64",
                   "kconfig": { "CONFIG_ARM_VIRT": true,
                                "CONFIG_RISCV_VIRT": false, ... } },
                 { "arch": "riscv64",
                   "kconfig": { "CONFIG_ARM_VIRT": false,
                                "CONFIG_RISCV_VIRT": true, ... } },
                 { "arch": "none",
                   "kconfig": { "CONFIG_ARM_VIRT": false,
                                "CONFIG_RISCV_VIRT": false, ... } } ] }
```

## query-machines: MachineInfo gains targets

```
{ 'struct': 'MachineInfo',
  'data': { 'name': 'str', 'typename': 'str', ...existing members...,
            'targets': ['QemuTargetInfo'] } }   # since 11.2
```

Combined `qemu-system` (other MachineInfo members trimmed):

```
-> { "execute": "query-machines" }
<- { "return": [
       { "name": "virt-11.2", "typename": "arm-virt-11.2-machine",
         "alias": "virt", "is-default": false,
         "cpu-max": 512, "deprecated": false, "secure": true,
         "targets": [ { "arch": "aarch64" } ] },
       { "name": "virt", "typename": "riscv-virt-machine",
         "cpu-max": 512, "deprecated": false,
         "secure": true,
         "targets": [ { "arch": "riscv64" } ] },
       { "name": "none", "typename": "none-machine",
         "cpu-max": 1, "deprecated": false,
         "secure": false,
         "targets": [ { "arch": "aarch64" },
                      { "arch": "riscv64" },
                      { "arch": "none" } ] }
     ] }
```

Single-target binary: every entry has exactly one element in
`targets`, equal to `query-target`'s `arch`.

A client that wants the old "machines per target" view filters
`query-machines` on `targets`.

## Open questions for the list

Machine names are not unique in a combined binary (`virt` above exists
for aarch64 and riscv64). `typename` is the unique QOM identity, so the
list contains one `MachineInfo` per `typename`; `targets` lists the
targets on which that machine type is available.

1. `kconfig` on `QemuTargetDetails`. The use case is tests telling "not
   built" apart from "missing". Open points:
   - `'any'` (a JSON object) vs. a list of enabled symbol names.
     The object makes a typo (symbol absent) distinguishable from
     "disabled" (`false`).
   - Stable, or an `unstable` feature, given that Kconfig symbol
     names are internal and can be renamed.
   - Size: several hundred entries per target, which is why it is
     in `QemuTargetDetails` (`query-target`, `query-targets`) and not
     in `QemuTargetInfo` (which contains only the target architecture).

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

