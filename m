Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A43C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 00:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9vQh-0004y2-7k; Tue, 29 Apr 2025 20:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9vQg-0004wN-3U; Tue, 29 Apr 2025 20:36:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9vQb-0003ng-27; Tue, 29 Apr 2025 20:36:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2264aefc45dso99785285ad.0; 
 Tue, 29 Apr 2025 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745973355; x=1746578155; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOlo69ZX6xx9qZ8ovbNVqcFPoJA/P2fhbRZGobMJjX0=;
 b=jydY75mHRIJooLrkce7s2rKkZsnlilPLCs9wJKyZJA0fpBuG/zN4MzMDMlMugfre5+
 LrmLCUEa/OPVqYvHXRQO3zmvnQAWUC583h+AE9FoSHJwfxc1q0fqpnu4rCR/i/x9zOhI
 97QEVFjg2P70rVLuszl6m5jeGQW7Cotnex5+J4B3GrCnS0kiKRwcNYRAOYvslyVqOFSo
 pfdai+/J1tKhcnF1njzqxOV/nwY4Rv1HYn13o7vsMAcN1lhI3EvEPy40w9/VsNqv6OVp
 QRmhvrLqVc/63XX78chkNwK4iSM9NO87KLIHlfWVDWdiAJ8hu68WhIeRM7LWlHjB+/H9
 UA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745973355; x=1746578155;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nOlo69ZX6xx9qZ8ovbNVqcFPoJA/P2fhbRZGobMJjX0=;
 b=QyhauKnlIIGwxn7veUtnoQBAeTBl9AGPhPVS9Vt27vFqhrIQOLRIQ6OI1hwWf66uaG
 Gv4kpmxpAruC9u+rVIhx+qyspciF2pHImddMPPY26tT0Dc5DX/L/mq16OllX6nqDwQI3
 kFLEEiXXdz+j9Be1O7w4IX5mKar/tAPxl/6r63JZ+zCzjiCztT1mM77Wjs4O75DYD89/
 rjQzgOFpWbeyzubNx5rZxQVoi9ShDT4Obro937WXE01ayLf9qYPEWEOEMTgtdY0DRYHK
 ajhOQtzUVmR7OXlmueQUkbG15b3tzlul82FW1NUF0Kuli09UQxVX5+4vHMBfPRUMW4sL
 MRyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsw+2nIAeUg/+MeE4hn7+nwve5W8/gzBz4UionlE6GQmmnGGniGLVD/sgPvnD9KpLc+m/hh05Wzjp1@nongnu.org,
 AJvYcCWkAaCEvMiWS2jRrq+8ep1NFVvwCzajBFd9nPW0vWtxfWIZBHZE9mLJwg17660oF+Z3DJK9oAcQU+Y=@nongnu.org
X-Gm-Message-State: AOJu0Yw11s8onuQTlHaFkswiSg5tapkwYDH5Sek0sjcqUBhWDcCy4ol6
 pWGZ57/ibJ41t0tlq8DCrIXf6+Cb2th90ixaF/5xh5zg8KITsmQr
X-Gm-Gg: ASbGnctKW2levdead+Fxj86xrdzuzMAsg4U2VNXryTZxwiLDlaLr5hPXDYymtj2sGM5
 oVs48uFN7Km2ij8gxonAqqDE7k1O8aNf1clVZi+jNMGnbhFs3MfkzcggqlgKJJXJPg0rlIsPiD3
 nBpSzS2Tselvix+Jeqy6rTb5HbOVq/OwcjEM/0hVyoz9Y1VUwcOKGnI365sNd5ysWI1RIpD0/xe
 N8Mqfgny/+epTXJQImtMjKFKJGlgY+cDsCK1hmCA8Y5wMLFVjkR1YU1Z1iJ7Mh2+cBLvdk7LhV7
 wmahYN9+qQDETivwAC9Tbnpw9n1V+hw1
X-Google-Smtp-Source: AGHT+IGeQHBmFmyYvaia2fOMiXcq/6KkVqtsNeNDAXqC2CRrOqM3RlHMEZdlZ6eVGB/F+9uzalPr+Q==
X-Received: by 2002:a17:90b:4d08:b0:309:f407:5ad1 with SMTP id
 98e67ed59e1d1-30a332e99f2mr1792738a91.14.1745973354942; 
 Tue, 29 Apr 2025 17:35:54 -0700 (PDT)
Received: from localhost ([1.145.119.81]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd432sm109824995ad.90.2025.04.29.17.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 17:35:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Apr 2025 10:35:50 +1000
Message-Id: <D9JJWC1IWEEB.1IA8DSZF98YT4@gmail.com>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
 <875xin3qeh.fsf@draig.linaro.org>
 <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu>
 <87zffy3l4g.fsf@draig.linaro.org>
 <aec151d9-fae2-4bbc-c690-2b68f5906664@eik.bme.hu>
In-Reply-To: <aec151d9-fae2-4bbc-c690-2b68f5906664@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Wed Apr 30, 2025 at 7:09 AM AEST, BALATON Zoltan wrote:
> On Tue, 29 Apr 2025, Alex Benn=C3=A9e wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> On Tue, 29 Apr 2025, Alex Benn=C3=A9e wrote:
>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>> On Mon, 28 Apr 2025, Richard Henderson wrote:
>>>>>> On 4/28/25 06:26, BALATON Zoltan wrote:
>>>>>>> I have tried profiling the dst in real card vfio vram with dcbz
>>>>>>> case (with 100 iterations instead of 10000 in above tests) but I'm
>>>>>>> not sure I understand the results. vperm and dcbz show up but not
>>>>>>> too high. Can somebody explain what is happening here and where the
>>>>>>> overhead likely comes from? Here is the profile result I got:
>>>>>>> Samples: 104K of event 'cycles:Pu', Event count (approx.):
>>>>>>> 122371086557
>>>>>>>  =C2=A0 Children=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self=C2=A0 Command=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Shared Object=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Symbol
>>>>>>> -=C2=A0=C2=A0 99.44%=C2=A0=C2=A0=C2=A0=C2=A0 0.95%=C2=A0 qemu-syste=
m-ppc=C2=A0 qemu-system-ppc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [.]
>>>>>>> cpu_exec_loop
>>>>>>>  =C2=A0=C2=A0 - 98.49% cpu_exec_loop
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 98.48% cpu_tb_exec
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 90.95% 0x7f4e70=
5d8f15
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 helper_ldub_mmu
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 do_ld_mmio_beN
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - cpu_io_recompile
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - 45.79% cpu_loop_exit_noexc
>>>>>>
>>>>>> I think the real problem is the number of loop exits due to i/o.  If
>>>>>> I'm reading this rightly, 45% of execution is in cpu_io_recompile.
>>>>>>
>>>>>> I/O can only happen as the last insn of a translation block.
>>>>>
>>>>> I'm not sure I understand this. A comment above cpu_io_recompile says
>>>>> "In deterministic execution mode, instructions doing device I/Os must
>>>>> be at the end of the TB." Is that wrong? Otherwise shouldn't this onl=
y
>>>>> apply if running with icount or something like that?
>>>>
>>>> That comment should be fixed. It used to only be the case for icount
>>>> mode but there was another race bug that meant we need to honour devic=
e
>>>> access as the last insn for both modes.
>>>>
>>>>>
>>>>>> When we detect that it has happened in the middle of a translation
>>>>>> block, we abort the block, compile a new one, and restart execution.
>>>>>
>>>>> Where does that happen? The calls of cpu_io_recompile in this case
>>>>> seem to come from io_prepare which is called from do_ld16_mmio_beN if
>>>>> (!cpu->neg.can_do_io) but I don't see how can_do_io is set.
>>>>
>>>> Inline by set_can_do_io()
>>>
>>> That one I've found but don't know where the cpu_loop_exit returns
>>> from the end of cpu_io_recompile.
>>
>> cpu_loop_exit longjmp's back to the top of the execution loop.
>>
>>>
>>>>>> Where this becomes a bottleneck is when this same translation block
>>>>>> is in a loop.  Exactly this case of memset/memcpy of VRAM.  This
>>>>>> could be addressed by invalidating the previous translation block
>>>>>> and creating a new one which always ends with the i/o.
>>>>>
>>>>> And where to do that? cpu_io_recompile just exits the TB but what
>>>>> generates the new TB? I need some more clues to understands how to do
>>>>> this.
>>>>
>>>>  cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | =
n;
>>>>
>>>> sets the cflags for the next cb, which typically will fail to find and
>>>> then regenerate. Normally cflags_next_tb is empty.
>>>
>>> Shouldn't this only regenerate the next TB on the first loop iteration
>>> and not afterwards?
>>
>> if we've been here before (needing n insn from the base addr) we will
>> have a cached translation we can re-use. It doesn't stop the longer TB
>> being called again as we re-enter a loop.
>
> So then maybe it should at least check if there's already a cached TB=20
> where it can continue before calling cpu_io_recompile in io_prepare and=
=20
> only recompile if needed?

It basically does do that AFAIKS. cpu_io_recompile() name is misleading
it does not cause a recompile, it just updates cflags and exits. Next
entry will look up TB that has just 1 insn and enter that.

> I was thinking maybe we need a flag or counter=20
> to see if cpu_io_recompile is called more than once and after a limit=20
> invalidate the TB and create two new ones the first ending at the I/O and=
=20
> then what cpu_io_recompile does now which as I understood was what Richar=
d=20
> suggested but I don't know how to do that.

memset/cpy routines had kind of the same problem with real hardware.
They wanted to use vector instructions for best performance, but when
those are used on MMIO they would trap and be very slow.

Problem is we don't know ahead of time if some routine will access
MMIO or not. You could recompile it with fewer instructions but then
it will be slow when used for regular memory.

Heuristics are tough because you could have e.g., one initial big
memset to clear a MMIO region that iterates many times over inner
loop of dcbz instructions, but then is never used again for MMIO but
important for regular page clearing. Making something that dynamically
decays or periodically would recompile to non-IO case perhaps, but
then complexity goes up.

I would prefer not like to do that just for a microbenchmark, but if
you think it is reasonable overall win for average workloads of your
users then perhaps.

Thanks,
Nick

