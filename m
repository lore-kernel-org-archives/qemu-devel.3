Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25946E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkNR-00023n-5d; Fri, 20 Dec 2024 16:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOkNM-00023Q-HN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:17:37 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOkNK-0004QE-H2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:17:36 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2167141dfa1so22379585ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734729452; x=1735334252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MA0x3yePLab9QX7eKJiMmBbyUbNpcqd6QQh5Sv8kG+I=;
 b=XwJUe66httpaMPKPk/CVn1NEJS0RfiOAZ6D2e7pzZHwdOwNeCSr9CU2gpmy81//DNi
 PLOBjb15uG36gtT9Ycux9iZBpozN+m+WYVF1uZLrMeS0M2PllviUM2DHQQT8/qXaQWGS
 zc9GY2pfDnc1TTMSn4gx77QxVm0vWbQ3Q8TA9sprIZY9nTj6LB79VjPWvIT+8mSgunlm
 A2MLYUlgsXs6dHN23o8Z4P/N/hhuAhk3sFis0gUeVWfUuEMeh7uqLs+66nGEC/hdXQgM
 C95Ptu+FvRpjF9VKTcJVtWAxSKFEuQ1yzKGyFOefYUK5/Jb5BiATnw5Casb8pKjhPtV4
 +gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734729452; x=1735334252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MA0x3yePLab9QX7eKJiMmBbyUbNpcqd6QQh5Sv8kG+I=;
 b=BgMYVVX5b/QoxOF7/BN8ggW1Crwoa1/oYsnNVokFkPIidktEs++BjmG+zPyyEAMeeo
 ngJKkiqyn1zoiPSp+lF+RvPec25ZlvbX614ju0YFNPj+886Eer4uUHlX7S8ULU1nTZ8J
 SdV5U81KarQV+T5IfgGYJocDdY4E2OW1cKrpyy70EFv20udBOWk1VZuHL8r7vaWGvkHp
 +QX3hdNKKgn8i9D0Xz9Y4/LPBoKh4/EaVelIjcPdhtJ8gMeXCNx7sw83PT2QRrrFKTeE
 /XUpP2f1fUIeMRr9FpJKjxUgGfiqMNeEKaR9f3oBCyWrNBIK8Oy+EI9tGSkjYX1/rzsR
 cxtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlbNHN+LTnim9GlJttLMSRdttVdBncRoKTOdwy6cJXViicIOf+nsnFij8HsLHp5o2qDRHUmCOr5bQY@nongnu.org
X-Gm-Message-State: AOJu0YwLdqIGFfaV9zdpIbF+OJrbZWVzFC0pWM45v5VSSdk2CeOfgySF
 b+EXc5PPbreAC25/Tlw7yiYW4N9DSAtIu8VtYl09Pt2q5Pp0h/bT8OSNjkmt9J0=
X-Gm-Gg: ASbGncsjYVqnPvwwGoHi6EDmOyEsmbx6G2nNKlPxCwCFxI7ygZH2yfgnIQVhMxjgGdk
 icpYyvd2mMjUMfrF07knMVRqkz+ibmtm/JsHpZEC2v/xjK+dWm0r/lip/83le1b43OZZWJJHa+Y
 m4OypXSmLSyM121wdc0DDnKHEZtNexyvgY4RbZFjCqJvOwAsMSqy0og/TnOYMwBTeADJubvDCPJ
 CRPgnZmKBKuD+fKaWnuhKT/PnVJps8Uv8duamtokGHH+GyAouHCtVv5Z6SNjDEIgSczyw==
X-Google-Smtp-Source: AGHT+IFZOVGzqap9rt/p9d2by5U+Pw3K1ytmI1INBaznYN/yRQkKnPRZDI/QTLgl/ua/EG+I1Pky5Q==
X-Received: by 2002:a17:902:ecc2:b0:216:5448:22c3 with SMTP id
 d9443c01a7336-219da5b9c2cmr109994125ad.6.1734729452237; 
 Fri, 20 Dec 2024 13:17:32 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dc7edbdbsm3302628a12.59.2024.12.20.13.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 13:17:31 -0800 (PST)
Message-ID: <11ae3330-71bb-4da9-9dcb-b7378f1682bc@linaro.org>
Date: Fri, 20 Dec 2024 13:17:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <590990025f1f43704ca8831254754661c176c42f@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Hi Julian,

On 12/20/24 03:47, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>> On 12/2/24 11:41, Julian Ganz wrote:
>>>   +static void insn_exec(unsigned int vcpu_index, void *userdata)
>>>   +{
>>>   + struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
>>>   + uint64_t pc = (uint64_t) userdata;
>>>   + GString* report;
>>>   +
>>>   + if (state->has_next) {
>>>   + if (state->next_pc != pc) {
>>>   + report = g_string_new("Trap target PC mismatch\n");
>>>   + g_string_append_printf(report,
>>>   + "Expected: %"PRIx64"\nEncountered: %"
>>>   + PRIx64"\n",
>>>   + state->next_pc, pc);
>>>   + qemu_plugin_outs(report->str);
>>>   + if (abort_on_mismatch) {
>>>   + g_abort();
>>>   + }
>>>   + g_string_free(report, true);
>>>   + }
>>>   + state->has_next = false;
>>>   + }
>>>   +}
>>>
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
> | Taking exception 5 [IRQ] on CPU 0
> | ...from EL1 to EL1
> | ...with ESR 0x0/0x3800000
> | ...with SPSR 0x20000305
> | ...with ELR 0x23fde7b90
> | ...to EL1 PC 0x23fd77a80 PSTATE 0x23c5
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

Thanks for the investigation.
I could reproduce this with this command line:
./build/qemu-system-aarch64 -M virt -plugin 
./build/tests/tcg/plugins/libdiscons.so,abort=on -m 8G -device 
virtio-blk-pci,drive=root -drive 
if=none,id=root,file=/home/user/.work/images/debianaarch64.img -M virt 
-cpu max,pauth=off  -drive 
if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd -drive 
if=pflash,file=/home/user/.work/images/AAVMF_VARS.fd -d plugin,in_asm,op 
-D crash.log

# -d plugin,in_asm,op allows to dump asm of every translated block, 
plugin output (for discon plugin), and tcg op generated.

It reliably crashes with a single address.
Looking at the debug output (crash.log):
----------------
IN:
0x23faf3a80:  d108c3ff  sub      sp, sp, #0x230
# => This bb has a single instruction as input

OP:
# this is the TB instrumentation
  ld_i32 loc0,env,$0xfffffffffffffff8
  brcond_i32 loc0,$0x0,lt,$L0
  st8_i32 $0x1,env,$0xfffffffffffffffc

  ---- 0000000000000a80 0000000000000000 0000000000000000
# => we can see that there is no call_plugin, looks like instrumentation 
# is not applied
  sub_i64 sp,sp,$0x230
  add_i64 pc,pc,$0x4
  goto_tb $0x1
  exit_tb $0x7f7eedd355c1
  set_label $L0
  exit_tb $0x7f7eedd355c3

----------------
IN:
0x23faf3a84:  a9b007e0  stp      x0, x1, [sp, #-0x100]!
0x23faf3a88:  a9010fe2  stp      x2, x3, [sp, #0x10]
...

OP:
  ld_i32 loc0,env,$0xfffffffffffffff8
  brcond_i32 loc0,$0x0,lt,$L0
  st8_i32 $0x0,env,$0xfffffffffffffffc

  ---- 0000000000000a84 0000000000000000 0000000000000000
# instruction is correctly applied
call plugin(0x7f7eec96d530),$0x1,$0,$0x0,$0x23faf3a84
  mov_i64 loc2,sp
  ...

Trap target PC mismatch
Expected:    23faf3a80
Encountered: 23faf3a84

The thing interesting here is that we can notice that 23faf3a80 is a 
translation block with a single instruction, and we can see that 
instrumentation is not applied for this instruction (call_plugin is not 
present).

Overall, it really looks like a bug on QEMU side, where we miss 
instrumenting something. I'll take a look. You can ignore this for now.

> Regards,
> Julian


