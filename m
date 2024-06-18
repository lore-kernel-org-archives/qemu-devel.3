Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2346EC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZJt-0008Lb-Bk; Tue, 18 Jun 2024 09:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJZJs-0008K9-2f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:56:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sJZJp-00029O-MK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:56:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so4849497f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718718975; x=1719323775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QDK180+org5a+/a7Y9YHyMQ+UVON0MoKX7CNLCnvKXw=;
 b=mJXQntludAlN5nh/sfvT6x57bAjToFLcHu0jiDNuXK+y99bszvRfpnhlKAPcUurVA5
 eNYScIJzujkW5nEsnJ+rMbNf/Kqcj0PY8F7u5WqrUcViwrMxn6K1m2nfbRqeuNjQoxSN
 yAnBSbDzX22fV4kzBw2Bejqz2buPhgIhjzb49ivALkUACHnvX83IQObsKldfgnwFa/j5
 QV0Tcx/PPSp9W288e9T6dTWuKUg7fh5e2ZDQc0zObGOM8ukjwJAbRasPE9OilnOMD4eF
 LwRiJcbh4QLpXKX1g8nEdGabtfe+VQCUbP754+w3myhqc9qm6e9Z8FqQCO9Fvxa2hejJ
 B2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718718975; x=1719323775;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDK180+org5a+/a7Y9YHyMQ+UVON0MoKX7CNLCnvKXw=;
 b=aJ719pVn9RBaDU3SYEuw3glO94iv5OzmNeXOTdHjTIlfWJLRl7+nYBWDzMeQ6dJSfY
 ESUVmnsGMOLViYFuiBZ6Qf3N2+5D08L1VXdDsrpr/PqWvu1knJQ6aAedeFFrG/IRhr/M
 a73C4jEEU90WtA/H0h3MTk/CmDaWEdw/lGeobGjiDg2/wN2m/FUeJ9R4p3z9fuKg9pMA
 R1OKeYyO/5zRt7CJgjCtACvtnz2UZ9jhr3NzvnXdTVxkmWR8WeGPDythko6SrbU84RbF
 N1zGqOiBsRE+q8w83u8jUw19tLblMWPF+v9aa+RjabjBf8uyqGBMPzRNzXs4AxSnaLzc
 i1wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHlCZCWE3s9QNhMHskue/K/dZSl75bW0Qv9mXHD5PtLqbnbLUl4QtLxKN17cJ7gN8ta2ZzqMMTsSlmq01lVwOrL/7MkRw=
X-Gm-Message-State: AOJu0YzEJC9Drv1bwUAUqL+10rzJ6i3MSJKnYDC9YEqrbtwZ7BncQ3xJ
 37zrsyV9b7nzklZRoVzuJb0qNDYF9smQ8GLeChWclfs+nyri5+WbypT2xPf0yaI=
X-Google-Smtp-Source: AGHT+IHodjDPzRHe8lpJMNl3knVerb3iUvdPPenDTrxGsPx20UAG0gIzCxeptmDOxnUy23B/hWBSJA==
X-Received: by 2002:adf:edc5:0:b0:362:f291:6f97 with SMTP id
 ffacd0b85a97d-362f291710emr59540f8f.18.1718718975438; 
 Tue, 18 Jun 2024 06:56:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362c7c2dffdsm353934f8f.35.2024.06.18.06.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 06:56:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 99DDB5F8AC;
 Tue, 18 Jun 2024 14:56:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Anton
 Johansson <anjo@rev.ng>
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
In-Reply-To: <8a22ada3-34e6-4d6d-aebe-67bc07d0f38f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 18 Jun 2024 13:33:28
 +0200")
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
 <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
 <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
 <8a22ada3-34e6-4d6d-aebe-67bc07d0f38f@linaro.org>
Date: Tue, 18 Jun 2024 14:56:14 +0100
Message-ID: <87zfricq2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> ping :)
>
> On 12/6/24 15:12, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Paolo,
>> On 30/5/24 15:58, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 30/5/24 09:31, Paolo Bonzini wrote:
>>>> On Thu, May 30, 2024 at 9:22=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> On 30/5/24 08:02, Paolo Bonzini wrote:
>>>>>> On Wed, May 29, 2024 at 5:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
>>>>>> <philmd@linaro.org> wrote:
>>>>>>> It is pointless to build semihosting when TCG is not available.
>>>>>>
>>>>>> Why? I would have naively assumed that a suitable semihosting API
>>>>>> could be implemented by KVM. The justification (and thus the commit
>>>>>> message) needs to be different for each architecture if it's a matter
>>>>>> of instruction set or insufficient KVM userspace API.
>>>>>
>>>>> I wasn't sure where semihosting could be used so asked on IRC and
>>>>> Alex told me TCG only. Maybe the current implementation is TCG
>>>>> only, and I can reword. It certainly need some refactor to work
>>>>> on KVM, because currently semihosting end calling the TCG probe_access
>>>>> API, which I'm trying to restrict to TCG in order to ease linking
>>>>> multiple libtcg for the single binary (see
>>>>> https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linar=
o.org/).
>>>>
>>>> Ok, that goes in the commit message though.
>>>>
>>>> "Semihosting currently uses the TCG probe_access API. It is pointless
>>>> to have it in the binary when TCG isn't".
>>>>
>>>> and in the first two patches:
>>>>
>>>> "Semihosting currently uses the TCG probe_access API. To prepare for
>>>> encoding the TCG dependency in Kconfig, do not enable it unless TCG is
>>>> available".
>>>>
>>>> But then, "select FOO if TCG" mean that it can be compiled out; so
>>>> perhaps "imply SEMIHOSTING if TCG" is better? Same for RISC-V's
>>>> "select ARM_COMPATIBLE_SEMIHOSTING if TCG".
>> Building qemu-system-mips configured with --without-default-devices:
>> Undefined symbols for architecture arm64:
>>  =C2=A0 "_qemu_semihosting_console_write", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0 "_semihost_sys_close", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0 "_uaccess_strlen_user", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0 ...
>> So this one has to use "select".
>> Similarly m68k:
>> Undefined symbols for architecture arm64:
>>  =C2=A0 "_semihost_sys_close", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _do_m68k_semihosting in target_m68k_m68k=
-semi.c.o
>>  =C2=A0 ...
>> I can link m68k using semihosting stubs but I'm not sure it is
>> right:
>> -- >8 --
>> diff --git a/semihosting/stubs-target-all.c
>> b/semihosting/stubs-target-all.c
>> new file mode 100644
>> index 0000000000..1f33173f43
>> --- /dev/null
>> +++ b/semihosting/stubs-target-all.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Semihosting Stubs
>> + *
>> + * Copyright (c) 2024 Linaro Ltd
>> + *
>> + * Stubs for semihosting targets that don't actually do semihosting.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "exec/exec-all.h"
>> +#include "semihosting/syscalls.h"
>> +
>> +void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulon=
g fname, target_ulong fname_len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int gdb_fla=
gs, int mode)
>> +{
>> +}
>> +
>> +void semihost_sys_close(CPUState *cs, gdb_syscall_complete_cb
>> complete, int fd)
>> +{
>> +}
>> +
>> +void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complet=
e,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GuestFD *gf, target_ulong buf, target_ulong len)
>> +{
>> +}
>> +
>> +void semihost_sys_read(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fd, tar=
get_ulong buf, target_ulong len)
>> +{
>> +}
>> +
>> +void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb comple=
te,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 GuestFD *gf, target_ulong buf,
>> target_ulong len)
>> +{
>> +}
>> +
>> +void semihost_sys_write(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int f=
d, target_ulong buf, target_ulong len)
>> +{
>> +}
>> +
>> +void semihost_sys_lseek(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int f=
d, int64_t off, int gdb_whence)
>> +{
>> +}
>> +
>> +void semihost_sys_isatty(CPUState *cs, gdb_syscall_complete_cb
>> complete, int fd)
>> +{
>> +}
>> +
>> +void semihost_sys_flen(CPUState *cs, gdb_syscall_complete_cb fstat_cb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_syscall=
_complete_cb flen_cb, int fd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulon=
g fstat_addr)
>> +{
>> +}
>> +
>> +void semihost_sys_fstat(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int f=
d, target_ulong addr)
>> +{
>> +}
>> +
>> +void semihost_sys_stat(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulon=
g fname, target_ulong fname_len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulon=
g addr)
>> +{
>> +}
>> +
>> +void semihost_sys_remove(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 target_ulong fname, target_ulong fname_len)
>> +{
>> +}
>> +
>> +void semihost_sys_rename(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 target_ulong oname, target_ulong oname_len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 target_ulong nname, target_ulong nname_len)
>> +{
>> +}
>> +
>> +void semihost_sys_system(CPUState *cs, gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 target_ulong cmd, target_ulong cmd_len)
>> +{
>> +}
>> +
>> +void semihost_sys_gettimeofday(CPUState *cs,
>> gdb_syscall_complete_cb complete,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong tv_addr, target_ulong tz_=
addr)
>> +{
>> +}
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb comple=
te,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int fd, GIOCondition cond, int timeout)
>> +{
>> +}
>> +#endif
>> diff --git a/semihosting/meson.build b/semihosting/meson.build
>> index 34933e5a19..aa8b7a9913 100644
>> --- a/semihosting/meson.build
>> +++ b/semihosting/meson.build
>> @@ -7,7 +7,7 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING',
>> 'CONFIG_SYSTEM_ONLY'], if_true: fil
>>  =C2=A0=C2=A0 'config.c',
>>  =C2=A0=C2=A0 'console.c',
>>  =C2=A0=C2=A0 'uaccess.c',
>> -))
>> +), if_false: files('stubs-target-all.c'))
>>  =C2=A0common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'],
>> if_false: files('stubs-all.c'))
>>  =C2=A0system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false:
>> files('stubs-system.c'))
>> ---
>> For mips more stubs are needed:
>> Undefined symbols for architecture arm64:
>>  =C2=A0 "_qemu_semihosting_console_write", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0 "_uaccess_lock_user", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _uhi_fstat_cb in target_mips_tcg_sysemu_=
mips-semi.c.o
>>  =C2=A0 "_uaccess_lock_user_string", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting.cold.6 in target_mips_=
tcg_sysemu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting.cold.6 in target_mips_=
tcg_sysemu_mips-semi.c.o
>>  =C2=A0 "_uaccess_strlen_user", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0 "_uaccess_unlock_user", referenced from:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _mips_semihosting in target_mips_tcg_sys=
emu_mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _uhi_fstat_cb in target_mips_tcg_sysemu_=
mips-semi.c.o
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>=20

Oh sorry I was waiting for a re-spin. I should just apply the above to
3/3?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

