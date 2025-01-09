Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF87FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvVp-0005D5-Ud; Thu, 09 Jan 2025 11:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvVo-0005CZ-AQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:36:00 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvVm-0002Sw-FJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:36:00 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso1746484a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736440557; x=1737045357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgpRk2lAh7peEa3JTQ/+Q6ZEx3Kj9Dr2YIjd4Zw63Zk=;
 b=M3qkV51KJ81xiYhG7Vycu2Z55FIavHWA/QmTj141+Ll5BvvO9AhWvNGH4xNoeZTJIO
 JpAo3QjeJX2X0Dklib5LE7dN+Bzup9jUUD9/HVrnk36IUS5R4FoOOrmcjzlM27luwLVL
 BVZBQeQTH9e973xt8cgMZYUeUMtK1MBzr2N82NT9NtR2Rjj8VrPl1aiwP3y3a7Ru5l9Q
 7uYMjTzFACO4p/DIt1Qn/kj9f2MQDTht+3rwTzMbIn3p9/9onBE1JY0JQ7FTV+76962j
 3y6iRA09oqX/p6OZIgm+uIZmSRzXuGjBmTppILRI5BjIRC9L6knSxbJ681hZZHEFA8Nw
 6Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736440557; x=1737045357;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgpRk2lAh7peEa3JTQ/+Q6ZEx3Kj9Dr2YIjd4Zw63Zk=;
 b=en4RwtZZ8JYA7aWOtdWuqgmx1VCgP7Rpmo8v2Nxf8GDnE1rFnlDqDzkyK3MVLUB+uI
 RzXEkv/btAPaDUFDYn6Be2ixa9cR1qTsGM03EBMAKf7pnN2O3ySMJHw74PR9kej2lnN1
 Z7mxtMwbfYcyyHqTNYGSczcA8Ox6grMZGwO4HltrlZc8R561EBYsSE8Dbd7w+L4TsYSl
 xEth8YKRUn940dyCEFvE61v/rm2nIjGcUDUEzbHgMoWoot3RSlfCuT2X2h859BxpuVM4
 fCJkPleqir0JMBrXgBnrVRJVxv2AdEmxtV5eZzLtdDtQi0DK4rOGgnnu+gnwYgIfWBs2
 Ppow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6iz9I+d4dfnptc7VS8fzma5+996WXXKWYCptSru1Rpk7aPoP4PciamhAKV2HYptMyMeuSJIOFZ3E8@nongnu.org
X-Gm-Message-State: AOJu0Yx1Q8SL8+I9zz/MFXcXH8Dr7Va6EEOHfBZ9Sfve0lZ+DafbSBvH
 vkImQuHsXPpvoLwtGNUnQunJvGvrVLk86noAg4aWBAciN0vLcBfqfYNz7aGGzpQ=
X-Gm-Gg: ASbGnctWj50cW9eZgzlDe8Z3jJDHt78QQOIVyf+JBP/zqP7v0Y3F8yE+i2KGDUGV+Ld
 uetKfrerlyP4aqWxynEzXLDLMpN9T7h1p36qbiSh84yR9Ceg5wAH2JtfmuAJ93D81YrvAu+U9pC
 QwvUpNacab4s/YjCAJu4xVVDUl9LtaytOkpT7lqODK3GWssh8hvX83AlkTGQAb7Lh7M6Re2qB14
 eCypgY14MZEJ2pyq52Ro+/r7QjiWFSCfR+XfqXf+efprrNuRiT495w=
X-Google-Smtp-Source: AGHT+IGDHJ9vufNJ3naHdppxxz3+0Cvlm0xVmovtabc1y1cDuPd095/tAq8Ad06sCk0tiHyX9Gb0ew==
X-Received: by 2002:a05:6402:3585:b0:5cf:e66f:678d with SMTP id
 4fb4d7f45d1cf-5d972e6f913mr6624057a12.28.1736440556540; 
 Thu, 09 Jan 2025 08:35:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a07bsm759237a12.65.2025.01.09.08.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:35:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C49315F75D;
 Thu,  9 Jan 2025 16:35:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>,  qemu-devel@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
In-Reply-To: <11ae3330-71bb-4da9-9dcb-b7378f1682bc@linaro.org> (Pierrick
 Bouvier's message of "Fri, 20 Dec 2024 13:17:31 -0800")
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
 <11ae3330-71bb-4da9-9dcb-b7378f1682bc@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 16:35:54 +0000
Message-ID: <874j286j2t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Julian,
>
> On 12/20/24 03:47, Julian Ganz wrote:
>> Hi Pierrick,
>> December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>>> On 12/2/24 11:41, Julian Ganz wrote:
>>>>   +static void insn_exec(unsigned int vcpu_index, void *userdata)
>>>>   +{
>>>>   + struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vc=
pu_index);
>>>>   + uint64_t pc =3D (uint64_t) userdata;
>>>>   + GString* report;
>>>>   +
>>>>   + if (state->has_next) {
>>>>   + if (state->next_pc !=3D pc) {
>>>>   + report =3D g_string_new("Trap target PC mismatch\n");
>>>>   + g_string_append_printf(report,
>>>>   + "Expected: %"PRIx64"\nEncountered: %"
>>>>   + PRIx64"\n",
>>>>   + state->next_pc, pc);
>>>>   + qemu_plugin_outs(report->str);
>>>>   + if (abort_on_mismatch) {
>>>>   + g_abort();
>>>>   + }
>>>>   + g_string_free(report, true);
>>>>   + }
>>>>   + state->has_next =3D false;
>>>>   + }
>>>>   +}
>>>>
>>> When booting an arm64 vm, I get this message:
>>> Trap target PC mismatch
>>> Expected: 23faf3a80
>>> Encountered: 23faf3a84
>> A colleague of mine went to great lengths trying to track and
>> reliably
>> reproduce this. We think that it's something amiss with the existing
>> instruction exec callback infrastructure. So... it's not something I'll
>> be addressing with the next iteration as it's out of scope. We'll
>> probably continue looking into it, though.
>> The mismatch is reported perfectly normal and boring exceptions and
>> interrupts with no indication of any differences to other (not reported)
>> events that fire on a regular basis. Apparently, once in a blue moon
>> (relatively speaking), for the first instruction of a handler (even
>> though it is definitely executed and qemu does print a trace-line for
>> that instruction):
>> | Trace 0: 0x7fffa0b03900
>> [00104004/000000023fde73b4/00000021/ff020200]
>> | Trace 0: 0x7fffa02d9580 [00104004/000000023fde72b8/00000021/ff020200]
>> | Trace 0: 0x7fffa02dfc40 [00104004/000000023fde7338/00000021/ff020200]
>> | Trace 0: 0x7fffa0b03d00 [00104004/000000023fde73d4/00000021/ff020200]
>> | Trace 0: 0x7fffa0b03e80 [00104004/000000023fde73d8/00000021/ff020200]
>> | Trace 0: 0x7fffa0b04140 [00104004/000000023fde7408/00000021/ff020200]
>> | Trace 0: 0x7fffa02dd6c0 [00104004/000000023fde70b8/00000021/ff020200]
>> | Trace 0: 0x7fffa02dd800 [00104004/000000023fde7b90/00000021/ff020200]
>> | cpu_io_recompile: rewound execution of TB to 000000023fde7b90
>> | Taking exception 5 [IRQ] on CPU 0
>> | ...from EL1 to EL1
>> | ...with ESR 0x0/0x3800000
>> | ...with SPSR 0x20000305
>> | ...with ELR 0x23fde7b90
>> | ...to EL1 PC 0x23fd77a80 PSTATE 0x23c5
>> | Trace 0: 0x7fffa13a8340 [00104004/000000023fd77a80/00000021/ff021201]
>> | Trace 0: 0x7fffa13a8480 [00104004/000000023fd77a84/00000021/ff020200]
>> | Trap target PC mismatch CPU 0
>> | Expected:    23fd77a80
>> | Encountered: 23fd77a84
>> | warning: 44	./nptl/pthread_kill.c: No such file or directory
>> | Couldn't get registers: No such process.
>> It does show up with both single-core and multi-core VMs, so that at
>> least eliminates some possibilities. Maybe :/
>> The issue is nasty to reproduce in a way that allows any meaningful
>> investigation. It usually involves sifting through many GBs of Qemu logs
>> for maybe one occurance. We could add another testing/dummy plugin that
>> just prints the PC for _any_ instruction executed and have a skript
>> check for non-alternating Trace-lines from Qemu and that Plugin. But
>> then we're talking nearly double the amount of Lines to look through
>> with probably little additional information.
>>=20
>
> Thanks for the investigation.
> I could reproduce this with this command line:
> ./build/qemu-system-aarch64 -M virt -plugin
> ./build/tests/tcg/plugins/libdiscons.so,abort=3Don -m 8G -device
> virtio-blk-pci,drive=3Droot -drive
> if=3Dnone,id=3Droot,file=3D/home/user/.work/images/debianaarch64.img -M v=
irt
> -cpu max,pauth=3Doff  -drive
> if=3Dpflash,readonly=3Don,file=3D/usr/share/AAVMF/AAVMF_CODE.fd -drive
> if=3Dpflash,file=3D/home/user/.work/images/AAVMF_VARS.fd -d
> plugin,in_asm,op -D crash.log
>
> # -d plugin,in_asm,op allows to dump asm of every translated block,
>    plugin output (for discon plugin), and tcg op generated.
>
> It reliably crashes with a single address.
> Looking at the debug output (crash.log):
> ----------------
> IN:
> 0x23faf3a80:  d108c3ff  sub      sp, sp, #0x230
> # =3D> This bb has a single instruction as input
>
> OP:
> # this is the TB instrumentation
>  ld_i32 loc0,env,$0xfffffffffffffff8
>  brcond_i32 loc0,$0x0,lt,$L0
>  st8_i32 $0x1,env,$0xfffffffffffffffc
>
>  ---- 0000000000000a80 0000000000000000 0000000000000000
> # =3D> we can see that there is no call_plugin, looks like
>   instrumentation # is not applied

That is expected. We have previously called the instrumentation for the
instruction in the block that triggered cpu_io_recompile() so we suppress
everything apart from memory instrumentation for the re-execution so we
don't double count.

>  sub_i64 sp,sp,$0x230
>  add_i64 pc,pc,$0x4
>  goto_tb $0x1
>  exit_tb $0x7f7eedd355c1
>  set_label $L0
>  exit_tb $0x7f7eedd355c3
>
> ----------------
> IN:
> 0x23faf3a84:  a9b007e0  stp      x0, x1, [sp, #-0x100]!
> 0x23faf3a88:  a9010fe2  stp      x2, x3, [sp, #0x10]
> ...
>
> OP:
>  ld_i32 loc0,env,$0xfffffffffffffff8
>  brcond_i32 loc0,$0x0,lt,$L0
>  st8_i32 $0x0,env,$0xfffffffffffffffc
>
>  ---- 0000000000000a84 0000000000000000 0000000000000000
> # instruction is correctly applied
> call plugin(0x7f7eec96d530),$0x1,$0,$0x0,$0x23faf3a84
>  mov_i64 loc2,sp
>  ...
>
> Trap target PC mismatch
> Expected:    23faf3a80
> Encountered: 23faf3a84
>
> The thing interesting here is that we can notice that 23faf3a80 is a
> translation block with a single instruction, and we can see that
> instrumentation is not applied for this instruction (call_plugin is
> not present).
>
> Overall, it really looks like a bug on QEMU side, where we miss
> instrumenting something. I'll take a look. You can ignore this for
> now.

See my other email. I think the bug was allowing an async IRQ to
interfere with our "special" single instruction block.

>
>> Regards,
>> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

