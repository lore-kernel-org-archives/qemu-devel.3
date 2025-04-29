Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE4AC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9pEG-0007gf-IB; Tue, 29 Apr 2025 13:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9pEE-0007dF-3p
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:58:46 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9pEB-0001t4-D8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:58:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso1033695066b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745949521; x=1746554321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqJb4fQ9W9CzRrk3yxmUL0LXdnoEUT+Wq+6bE/TvB2E=;
 b=fRYpLZBLWz6sWZ9YoDKpAaFR5eKuSSMwJYSoQoV0yM67102sgujPVIDI1Ckffvb+dw
 uZocOEXGjX/QZAEqfWypGMsCh4ZRNML6yUuh+FgWHnAWxwxzQH/VI05Z7gLVLDof07wu
 MEhbT1A3QL9Ia+RfxDls5Xsplt3/TFwII2keXHUAQs4f9gcC8gy86wRrtf13PbiVOzST
 Q+mDpVXAxNjo+jx89EieGkxSNz8HhbdvbYZsFd0yfIrX5tN14I1LSY8XLydL+iDfAxU2
 996PEgXvtspmMsx68A5Ilwu7zBHo56uHFkGJfGV44yF1ipANV17K4NuJ4Odurf7o54Wq
 pNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745949521; x=1746554321;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PqJb4fQ9W9CzRrk3yxmUL0LXdnoEUT+Wq+6bE/TvB2E=;
 b=h9pFqOwn1JnEzYBkfL9pmdjC7UJ/H/kqEgaLr42UnhVHxhS5lbP6AhjkB19LbzdDMv
 IXSwAhaiygF61oKbQm3YMVHeC9l9Qk8oQlkCKQIgh5b2wbqHxNWdaFbkkWbEZ1zHVD7Z
 3bhb9wWIt6NY2M8c3jCzXkrGxZZnv6/XR8eowtY5B5VJf3KWLLq/eyGQn4v3fIlzqEFw
 h8cAdYE2hyRjAjKA7Nf6qkcm2DQFqhyKasTScJN5Ww1YiJRan1MDiighhlMdemZfLvrE
 029enRuAX2i6Sxv4PSMYslEqqOUMCqlvbSWDoJFDyJOzj0iu5xscEg0V1nuf3BnyYfVm
 xX3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNiwPWTW7AE3XdighfH2UIORBAyCZoKnv498zs+IbDEKLkgdGrtMS9AMyZUsuTb6Yo2iugVLHOGRjY@nongnu.org
X-Gm-Message-State: AOJu0Yw6hQvfL15ijcpLkBRmySB2MeK2ykEXeh4DH7A3kC1tgqP8vCLJ
 XQr6AS1NTqtgI5L3GqPDRK2R4+8I1Od3TlklUFlRqHgLE/BiOy5re9FTF3uKwO4=
X-Gm-Gg: ASbGnct7qicu3Ubtdg1JSJM+4y25kktRhETPTsZ5d1VZkEGYlKoWYqwvUwXUf1D383W
 SURABgZCqQdUXCOJp5uNG90Yw6ewLyFj9BrSvEmRkdj3M3YNqpQtt/aQhE1+hd9p3u4IDfMBxZL
 0cIeOWCeGEXMnjR69NsMYbZ7sDyi5R52c7yHK2fRMaOD7u+51qUswJujKHxRQAf51niURf4BSsS
 E8XJ9UAU/fAjtqlQq0n/vomiw4EhBnqM/mMO5nwiGAjG1CEsdk4fqtYWwLPwvdUn/LVAsS4yN1s
 UgIm/uKQ0GlVIWbD9hRvBFUJcdSEIOqMkqhBFLEhXl3kEznW0sB47A==
X-Google-Smtp-Source: AGHT+IFWGkvtLM9ju5vcrmCSam/ADagRcHujtmxVojHtS6zZK+OiejC2XMuK/Ks7kpqbPjHykD6yHA==
X-Received: by 2002:a17:907:86a6:b0:ac3:5c8e:d3f5 with SMTP id
 a640c23a62f3a-acedc63426cmr33355666b.27.1745949521380; 
 Tue, 29 Apr 2025 10:58:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7011fc52fsm7715648a12.11.2025.04.29.10.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:58:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C61C5FAEE;
 Tue, 29 Apr 2025 18:58:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu> (BALATON
 Zoltan's message of "Tue, 29 Apr 2025 19:14:31 +0200 (CEST)")
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
 <875xin3qeh.fsf@draig.linaro.org>
 <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 18:58:39 +0100
Message-ID: <87zffy3l4g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 29 Apr 2025, Alex Benn=C3=A9e wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Mon, 28 Apr 2025, Richard Henderson wrote:
>>>> On 4/28/25 06:26, BALATON Zoltan wrote:
>>>>> I have tried profiling the dst in real card vfio vram with dcbz
>>>>> case (with 100 iterations instead of 10000 in above tests) but I'm
>>>>> not sure I understand the results. vperm and dcbz show up but not
>>>>> too high. Can somebody explain what is happening here and where the
>>>>> overhead likely comes from? Here is the profile result I got:
>>>>> Samples: 104K of event 'cycles:Pu', Event count (approx.):
>>>>> 122371086557
>>>>>  =C2=A0 Children=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self=C2=A0 Command=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shared Object=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Symbol
>>>>> -=C2=A0=C2=A0 99.44%=C2=A0=C2=A0=C2=A0=C2=A0 0.95%=C2=A0 qemu-system-=
ppc=C2=A0 qemu-system-ppc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [.]
>>>>> cpu_exec_loop
>>>>>  =C2=A0=C2=A0 - 98.49% cpu_exec_loop
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 98.48% cpu_tb_exec
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 90.95% 0x7f4e705d=
8f15
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 helper_ldub_mmu
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 do_ld_mmio_beN
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 cpu_io_recompile
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - 45.79% cpu_loop_exit_noexc
>>>>
>>>> I think the real problem is the number of loop exits due to i/o.  If
>>>> I'm reading this rightly, 45% of execution is in cpu_io_recompile.
>>>>
>>>> I/O can only happen as the last insn of a translation block.
>>>
>>> I'm not sure I understand this. A comment above cpu_io_recompile says
>>> "In deterministic execution mode, instructions doing device I/Os must
>>> be at the end of the TB." Is that wrong? Otherwise shouldn't this only
>>> apply if running with icount or something like that?
>>
>> That comment should be fixed. It used to only be the case for icount
>> mode but there was another race bug that meant we need to honour device
>> access as the last insn for both modes.
>>
>>>
>>>> When we detect that it has happened in the middle of a translation
>>>> block, we abort the block, compile a new one, and restart execution.
>>>
>>> Where does that happen? The calls of cpu_io_recompile in this case
>>> seem to come from io_prepare which is called from do_ld16_mmio_beN if
>>> (!cpu->neg.can_do_io) but I don't see how can_do_io is set.
>>
>> Inline by set_can_do_io()
>
> That one I've found but don't know where the cpu_loop_exit returns
> from the end of cpu_io_recompile.

cpu_loop_exit longjmp's back to the top of the execution loop.

>
>>>> Where this becomes a bottleneck is when this same translation block
>>>> is in a loop.  Exactly this case of memset/memcpy of VRAM.  This
>>>> could be addressed by invalidating the previous translation block
>>>> and creating a new one which always ends with the i/o.
>>>
>>> And where to do that? cpu_io_recompile just exits the TB but what
>>> generates the new TB? I need some more clues to understands how to do
>>> this.
>>
>>  cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
>>
>> sets the cflags for the next cb, which typically will fail to find and
>> then regenerate. Normally cflags_next_tb is empty.
>
> Shouldn't this only regenerate the next TB on the first loop iteration
> and not afterwards?

if we've been here before (needing n insn from the base addr) we will
have a cached translation we can re-use. It doesn't stop the longer TB
being called again as we re-enter a loop.

>
> Regards,
> BALATON Zoltan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

