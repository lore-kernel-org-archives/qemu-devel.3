Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650E6E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvTQ-0003GR-H6; Thu, 09 Jan 2025 11:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvTD-0003Dv-Em
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:33:19 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvTB-00020z-9B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:33:19 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso1852469a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736440394; x=1737045194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bp7UzDfH2pPsTosVt241TS66sDCetMr3RcvaR1vrE6s=;
 b=Q9AKFXGw9g4a3aBjcLtqtLvtlVtSlWJHgQqzFStFo1TjF7D/bMB6ejcDzDAMLh1gWn
 77BAjrjOXe2wEb78miTrRdPfxP/1b98df0UGYrZkXHh+bqtM/zTkvKwo3BtAQsSmXFGe
 m5/ILqspj9wgOur4QrK2YPid6xTFXRKa0TZFAVINmbFu1v4VB7nbwwXXCu20JweEQEnZ
 Rjnw7iKeZaLH5ZdR4KkDMh2qw9dWOSNu/PcMThS7RYsrNWG+sdpmyeXcbrTvWYLPtd4t
 kWybNUITPUHo+bUT75msq5TSORtSgu0ei57wX0tnj/fDwdDVH2XkKiA1X8J48wPKIK8n
 eWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736440394; x=1737045194;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bp7UzDfH2pPsTosVt241TS66sDCetMr3RcvaR1vrE6s=;
 b=TNfsYKNlJ0MCcWNa5bMwjjc/3FbmcIAWNMlGQ3+3Xwl1JLmAGjnyg7t2PRKYIfLvfP
 OZarT1N4S9Vfi/ZLtY3UxP976UGkKZygrutBKMqSWsbCBPTUZQhCe7s/6kRT9LI1oM7l
 SE8uyHdfJ87nERlupu2ajdXLvmF4LBnw892efv7cCvBOaCEwW6T9idyqjFJmtxGotcv7
 OoWJdYb0xId0QnC8mg3RkLswan05i1qMCRwUsnnx8JEBsJkOx/JE7bDc4W2Pej92LPY5
 6GhDecDmJvm9R9wSc2LnZ0kYsISHsTUWfwS3ODTjOB9GKi35nFEwjT07gJMjY8W2XkKA
 uSZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjKXsC3htau/xjo8vZJjFidKczsJwi7UrcT6ybVQWqwLgm0maSrg+ee01fS1SLxUq8m0z+jzcIXz5X@nongnu.org
X-Gm-Message-State: AOJu0YxlfXu0spcjXGEml+B/QRXTzAV7oAzOvpsoZA/1HgOPrxdmJfZr
 mhJ6gjyTr5L7cMT+hOw8wbZyTPBVpbdC8n8uQw6G5Mov0ldNpxso1VymLiIrSQo=
X-Gm-Gg: ASbGncvfudF0ZE6ESu9g/x22fO93/mbJJ8MhsutjMMbq59UxnYqfU89skFhjDzHXS6z
 HMat0JsF9cWHTJi37pDyRMhh6WkJkAU0+UpUTmgIVc9XDjsubeAQMy/LxZcLLLVkskX6uvht4Un
 ndXsVRR3OkTJwXMAMEc+PHx17xD5rbhRRmmR8ytyB522nLRlj0zKUm6hpCFYf6M+5GZFecA7jJW
 H83/D+rTSQUve+r3ZpJHlfN59v4LhwoJpmwQn5CNg5uLXRNfrRMHpw=
X-Google-Smtp-Source: AGHT+IFCrhRF8J/UuUVsbyefk5sDE/hxGiyQrEj2fHa1VLmoHr31P8mluWUcTdzfotEKfGKAOXHa0g==
X-Received: by 2002:a05:6402:13c6:b0:5d9:a61:ed1d with SMTP id
 4fb4d7f45d1cf-5d972e4e931mr7147542a12.27.1736440394456; 
 Thu, 09 Jan 2025 08:33:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9904a4132sm759523a12.75.2025.01.09.08.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:33:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80DB15F75D;
 Thu,  9 Jan 2025 16:33:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <neither@nut.email>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  "Alexandre Iooss" <erdnaxe@crans.org>,  "Mahmoud
 Mandour" <ma.mandourr@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
In-Reply-To: <590990025f1f43704ca8831254754661c176c42f@nut.email> (Julian
 Ganz's message of "Fri, 20 Dec 2024 11:47:16 +0000")
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 16:33:12 +0000
Message-ID: <87a5c06j7b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

"Julian Ganz" <neither@nut.email> writes:

(Add Richard to CC)

> Hi Pierrick,
>
> December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>> On 12/2/24 11:41, Julian Ganz wrote:
>> >  +static void insn_exec(unsigned int vcpu_index, void *userdata)
>> >  +{
>> >  + struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vcp=
u_index);
>> >  + uint64_t pc =3D (uint64_t) userdata;
>> >  + GString* report;
>> >  +
>> >  + if (state->has_next) {
>> >  + if (state->next_pc !=3D pc) {
>> >  + report =3D g_string_new("Trap target PC mismatch\n");
>> >  + g_string_append_printf(report,
>> >  + "Expected: %"PRIx64"\nEncountered: %"
>> >  + PRIx64"\n",
>> >  + state->next_pc, pc);
>> >  + qemu_plugin_outs(report->str);
>> >  + if (abort_on_mismatch) {
>> >  + g_abort();
>> >  + }
>> >  + g_string_free(report, true);
>> >  + }
>> >  + state->has_next =3D false;
>> >  + }
>> >  +}
>> >=20
>> When booting an arm64 vm, I get this message:
>> Trap target PC mismatch
>> Expected: 23faf3a80
>> Encountered: 23faf3a84
>
> A colleague of mine went to great lengths trying to track and reliably
> reproduce this. We think that it's something amiss with the existing
> instruction exec callback infrastructure. So... it's not something I'll
> be addressing with the next iteration as it's out of scope. We'll
> probably continue looking into it, though.
>
> The mismatch is reported perfectly normal and boring exceptions and
> interrupts with no indication of any differences to other (not reported)
> events that fire on a regular basis. Apparently, once in a blue moon
> (relatively speaking), for the first instruction of a handler (even
> though it is definitely executed and qemu does print a trace-line for
> that instruction):
>
> | Trace 0: 0x7fffa0b03900 [00104004/000000023fde73b4/00000021/ff020200]
> | Trace 0: 0x7fffa02d9580 [00104004/000000023fde72b8/00000021/ff020200]
> | Trace 0: 0x7fffa02dfc40 [00104004/000000023fde7338/00000021/ff020200]
> | Trace 0: 0x7fffa0b03d00 [00104004/000000023fde73d4/00000021/ff020200]
> | Trace 0: 0x7fffa0b03e80 [00104004/000000023fde73d8/00000021/ff020200]
> | Trace 0: 0x7fffa0b04140 [00104004/000000023fde7408/00000021/ff020200]
> | Trace 0: 0x7fffa02dd6c0 [00104004/000000023fde70b8/00000021/ff020200]
> | Trace 0: 0x7fffa02dd800 [00104004/000000023fde7b90/00000021/ff020200]
> | cpu_io_recompile: rewound execution of TB to 000000023fde7b90

So this happens when an instruction that is not the last instruction of
the block does some IO. As IO accesses can potentially change system
state we can't allow more instructions to run in the block that might
not have that change of state captured

cpu_io_recompile exits the loop and forces the next TranslationBlock to
be only one (or maybe two instructions). We have to play games with
instrumentation to avoid double counting execution:

    /*
     * Exit the loop and potentially generate a new TB executing the
     * just the I/O insns. We also limit instrumentation to memory
     * operations only (which execute after completion) so we don't
     * double instrument the instruction.
     */
    cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | n;

The instruction is in a weird state having both executed (from the
plugin point of view) but not changed any state (stopped from doing MMIO
until the next instruction).

> | Taking exception 5 [IRQ] on CPU 0
> | ...from EL1 to EL1
> | ...with ESR 0x0/0x3800000
> | ...with SPSR 0x20000305
> | ...with ELR 0x23fde7b90
> | ...to EL1 PC 0x23fd77a80 PSTATE 0x23c5

I guess before we re-executed the new block an asynchronous interrupt
came in?

Does changing the above to:

  cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;

make the problem go away? It should ensure the next 1/2 instruction
block execute without checking for async events. See gen_tb_start() for
the gory details.

> | Trace 0: 0x7fffa13a8340 [00104004/000000023fd77a80/00000021/ff021201]
> | Trace 0: 0x7fffa13a8480 [00104004/000000023fd77a84/00000021/ff020200]
> | Trap target PC mismatch CPU 0
> | Expected:    23fd77a80
> | Encountered: 23fd77a84
> | warning: 44	./nptl/pthread_kill.c: No such file or directory
> | Couldn't get registers: No such process.
>
> It does show up with both single-core and multi-core VMs, so that at
> least eliminates some possibilities. Maybe :/
>
> The issue is nasty to reproduce in a way that allows any meaningful
> investigation. It usually involves sifting through many GBs of Qemu logs
> for maybe one occurance. We could add another testing/dummy plugin that
> just prints the PC for _any_ instruction executed and have a skript
> check for non-alternating Trace-lines from Qemu and that Plugin. But
> then we're talking nearly double the amount of Lines to look through
> with probably little additional information.
>
> Regards,
> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

