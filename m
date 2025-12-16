Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C238D5E391
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWII-0001Xv-IM; Tue, 16 Dec 2025 09:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVWIH-0001Xf-Dt
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:44:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVWIF-0006Vn-Ne
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:44:53 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so3354276f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765896289; x=1766501089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9oT+wJPfisoFL1eZlH1HjHNoP+4MLQIy1YzGxkhvYo=;
 b=f0qwdPaGGU7Nlf/Y2fjq8/DSzAFxZS3rLil2dK2G4Yu+50jTqUtAkGiecVgtGLtHbo
 I0tQvy0bkuNRSO21DbyxXjZBTPSBz1+4rU2v4R5KmQvpysVblrw40Dj2lk+33s9lBhCq
 smtP/TMEhD7W6+Eb6SSzK8NuYTRw7ewiI8jyeb6Gtg4HEnrK1Kx9IeY+UedDCYoV3vZp
 6mXQF6NvC6qIQqz8xrjPZLAVLT5AYM48wrDI/YHiugCnmzk4DuGwc0RwL//wxkG6x4j/
 jslal9+6CEBnCNCUSvq5DvhaSol4caXwbfV97CuFFkvV1LOXzjZoZ0oNFMn2gSI+NTiy
 /oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765896289; x=1766501089;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9oT+wJPfisoFL1eZlH1HjHNoP+4MLQIy1YzGxkhvYo=;
 b=aerA9KULJx7AtGNgGKM3wYfYIM5ofPTvs1TnHO1cOzJkj1+rGtauYoES8bN+3yiLMi
 nrgSFNUoCrvlldDsaF66RzN8cttk3FG3LCuBa+YS4KkF1zJUHYKUu3cfb9HNyG4KMT7u
 2+J6EQnIDCWxuQ/50zqef4dbMm9keC5s8BEBGDTA9WbMUUTn+c0cBY5omw5unOqCGzvT
 UiXCmF3VsaFURbRQBPJVhWARyyKH+4olisJJRtupxXIa6Id1COclxXgyYGvrEEK0FrPn
 KobeZGrE0vrdGBvTPQdxmOAEtQUAo6GKzwbuagKhSoLIyxvzuAxRhfaQFPzRIBXNC3Ox
 vbow==
X-Gm-Message-State: AOJu0YxGiyt4bn8IIQatO79DWiyCRyHHAcmTggwzDc3/bnVuZAKMbKKo
 WbbJj8vKspH3gjpQUZ6sHN8pfCAOEkP26CQcgmQdhPm6Vwl23+jCvRXogB8nWVcrNqAYwKOst5T
 N2ie/
X-Gm-Gg: AY/fxX4oi/7qoFOQhwLoU849aR5MZlY99c2ZJ4L9Orrm5VOICGUE0oO+LwpKeIr8pSZ
 1chWy9z7Bt8dosadcBTVWC8mFpKUBOd6U2K4/H1X86jXgmSrIzsUIlku0iIMH+XxEYqlmtnIu/H
 /ENtHVLlShH/bWuN1F/gbz9Hf9ZM6OolFKlldFDROxzbxRfTkfg5waLv5lZZ52yWF74/yaWwjwN
 Dc4zhxvtE5gNc3CLlj0z8t4LXE3qlIRhn1IeD4D7unVgtiEHfmLddLW6/Bt3wgWorxSN8ML8qqE
 wnNl0px0VCJVYmKnwWELxFB+k9WetTZlZeTBpuP+hm+60BD6B5KrArgwvziaYByLJ6DjyAmT+I8
 +3+IxPrAyHaBvQVp7Hps3VCLR1xl2snOq4AL+of7ovba3dOS/2Yd0Tegw19ySdRfX6kx2kYlT85
 PeihSYtgrs+sk=
X-Google-Smtp-Source: AGHT+IGEf5xmNxQLaPRj71+iOY3QCNgN7T/F4Iis4wsiQy4v8DpTgSd9xgSrkQ+yqzZKiwKvWNiDpA==
X-Received: by 2002:a05:6000:4382:b0:431:1d4:3a6d with SMTP id
 ffacd0b85a97d-43101d4429amr6031807f8f.48.1765896288555; 
 Tue, 16 Dec 2025 06:44:48 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430fa5f6ab7sm16801779f8f.25.2025.12.16.06.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 06:44:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 059005F861;
 Tue, 16 Dec 2025 14:44:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
In-Reply-To: <01a56a53-ef95-4c63-8f4d-21458bbc3668@epfl.ch> (Florian
 Hofhammer's message of "Tue, 16 Dec 2025 13:28:47 +0100")
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
 <87cy4jubc9.fsf@draig.linaro.org>
 <341e0334-7bc3-4186-94c7-fba1c92cfc9d@epfl.ch>
 <01a56a53-ef95-4c63-8f4d-21458bbc3668@epfl.ch>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 16 Dec 2025 14:44:46 +0000
Message-ID: <87tsxqlc4h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 16/12/2025 10:27, Florian Hofhammer wrote:
>>>> diff --git a/plugins/api.c b/plugins/api.c
>>>> index eac04cc1f6..fc19bdb40b 100644
>>>> --- a/plugins/api.c
>>>> +++ b/plugins/api.c
>>>> @@ -41,6 +41,7 @@
>>>>  #include "qemu/log.h"
>>>>  #include "system/memory.h"
>>>>  #include "tcg/tcg.h"
>>>> +#include "exec/cpu-common.h"
>>>>  #include "exec/gdbstub.h"
>>>>  #include "exec/target_page.h"
>>>>  #include "exec/translation-block.h"
>>>> @@ -450,13 +451,27 @@ int qemu_plugin_write_register(struct qemu_plugi=
n_register *reg,
>>>>  {
>>>>      g_assert(current_cpu);
>>>>=20=20
>>>> -    if (buf->len =3D=3D 0 || qemu_plugin_get_cb_flags() !=3D QEMU_PLU=
GIN_CB_RW_REGS) {
>>>> +    if (buf->len =3D=3D 0 || (
>>>> +                qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS
>>>> +                && qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_=
REGS_PC)) {
>>>>          return -1;
>>>>      }
>>>
>>> If we are exposing a specific qemu_plugin_set_pc we should probably
>>> forbid setting it via write_register. Can we filter out the PC from the
>>> register list?
>>=20
>> The qemu_plugin_write_register API silently swallows writes to the PC
>> even though such a write doesn't actually have an effect, so excluding
>> the PC here might make sense and I'm happy to update the patch
>> accordingly.
>> Are there other registers that should be excluded as well?
>> General-purpose register writes are visible to the guest immediately,
>> but what about special registers? Do writes to those actually always
>> have the intended effect or should they also be excluded here?
>
> Actually, after looking into this for a bit, I don't think it's easily
> feasible without a big revamp (but please correct me if I'm wrong or
> simply missing something).
>
> The problem is that the opaque handle passed to the plugin API only
> encodes a register offset, not its name or type. So to exclude the PC,
> we'd need to expose the register name to the API (which would
> likely require either duplication of the name in both `struct
> qemu_plugin_reg_descriptor` and `struct qemu_plugin_register` or
> changing the API) and then filter in the API based on the register name
> ("pc", "rip", "eip", ...). This seems rather hacky and fragile to me.
>
> Alternatively, we could encode whether a register is to be filtered out
> or not in the opaque handle itself (e.g., by setting the topmost bit).
> This still requires getting this information from somewhere, though.
> Currently, registers are created by parsing the target XML in `gdb-xml/`
> at compile time. The PC is generally marked as `type=3D"code_ptr"` in the
> XML, so we could expose this type information to the code and adjust the
> register handle if it's a code pointer. The problem here is that it's
> not just the PC that is marked as `code_ptr` in the XML; there may be
> other registers as well (e.g., `lr` or `ra` for Arm and RISC-V).

Hmm thats interesting. I wonder what the semantics of that for gdb are?

However I think thinks like the link registers are normally rectified.
For example from the systrace plugin I'm toying with:

But I'm not always able to catch it on being automatically set:

  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc0809d3d38 msr daif, x23
    REG: id_aa64pfr0_el1 is 1100000011110012 (previously 1100000010110012, =
0 to 1 hits)
    REG: sctlr_el1 is 0200000034f4d91d (previously 0000000000000000, 0 to 3=
 hits)
    REG: spsr_el1 is 00000000000003c5 (previously 0000000000000000, 0 to 1 =
hits)
    REG: elr_el1 is 0000000041406100 (previously 0000000000000000, 0 to 1 h=
its)
    REG: vbar_el1 is ffffffc080010800 (previously 0000000000000000, 0 to 1 =
hits)
    REG: mdscr_el1 is 0000000000001000 (previously 0000000000000000, 0 to 1=
 hits)
    REG: ttbr0_el1 is 0000000041408000 (previously 0000000000000000, 0 to 2=
 hits)
    REG: ttbr1_el1 is 0000000041409000 (previously 0000000000000000, 0 to 5=
 hits)
    REG: tcr_el1 is 001000f5b5593519 (previously 0000000000000000, 0 to 3 h=
its)
    REG: mair_el1 is 000000040044ffff (previously 0000000000000000, 0 to 1 =
hits)
    REG: midr_el1 is 00000000414fd0c1 (previously 0000000000000000, 0 to 2 =
hits)
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc0800cd6dc msr daif, x21
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc08010fe9c msr daif, x27
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc08010fe9c msr daif, x27
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc08010fe9c msr daif, x27
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc08010fe9c msr daif, x27
  CPU: 0 taking host call from 0xffffffc08003a35c to 0xffffffc08003a35c
    LAST SYSREG: 0xffffffc08010fe9c msr daif, x27
  CPU: 0 taking irq from 0xffffffc08121102c to 0xffffffc080010a80
    LAST SYSREG: 0xffffffc081211028 msr daifclr, #3
    REG: cntkctl_el1 is 0000000000000002 (previously 0000000000000000, 0 to=
 2 hits)
    REG: tpidr_el1 is ffffffbfbe084000 (previously 0000000000000000, 513 to=
 4453 hits)
  CPU: 0 taking irq from 0xffffffc08121102c to 0xffffffc080010a80
    LAST SYSREG: 0xffffffc08001207c msr spsr_el1, x22
    REG: spsr_el1 is 0000000000000005 (previously 00000000000003c5, 1 to 3 =
hits)
    REG: elr_el1 is ffffffc08121102c (previously 0000000041406100, 1 to 3 h=
its)
  CPU: 0 taking irq from 0xffffffc08065c988 to 0xffffffc080010a80
    LAST SYSREG: 0xffffffc080657970 msr daif, x21
    REG: spsr_el1 is 0000000020000005 (previously 0000000000000005, 3 to 5 =
hits)
    REG: elr_el1 is ffffffc08065c988 (previously ffffffc08121102c, 3 to 5 h=
its)
  CPU: 0 taking irq from 0xffffffc0806591c4 to 0xffffffc080010a80
    LAST SYSREG: 0xffffffc080657ad8 msr daif, x22
    REG: spsr_el1 is 0000000060000005 (previously 0000000020000005, 5 to 7 =
hits)
    REG: elr_el1 is ffffffc0806591c4 (previously ffffffc08065c988, 5 to 7 h=
its)

I think the elr_el1 changes I'm picking up are where its explicitly set
by the code and not the implicit updates.


>
> I'm not sure whether the above explanation is clear enough, so please
> let me know if you'd like me to clarify anything or point you to the
> exact spots in the code.
>
> Thanks,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

