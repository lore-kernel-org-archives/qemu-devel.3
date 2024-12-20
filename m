Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EDAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkpy-0005ja-CA; Fri, 20 Dec 2024 16:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOkpm-0005iO-4E
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:46:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOkpj-0003rC-7i
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:46:56 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso22431915ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734731213; x=1735336013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OUSzdSgAwpL5uG0+bNxD0uobLS6BqjlaULjJ6Jrjhk8=;
 b=anopo/I24oDsZlPKPZ5GQEwdWrHh65IoEYeq+cc+JeXUcR+uDY/6Os8SFyBNORz3g/
 s3v9IIiT0mlx24SwtlHrEnGspQEY1qsp+mbIDEvolMO8VwfICDjrAx9Mt0h1+EreaR62
 M+7erAKIdRyRTRUQbW2t2GI9/syXJf99MaYfFzQ4B1jpnHANVTNNuMOgHXI0SzmdDPZL
 gPdrzkeBg/684z3LUk33H4Xs0FOWZcIQS6+cBnS8YFQQpnZc60j/p+JuuxxDbxDd6fOf
 +BllUaVIm0LsFy1MSYQQ91aAy0O4j9C+k4BqKWRmbEErpjBuw2cQo9wW8ylK3HraZ+dQ
 ZhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734731213; x=1735336013;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OUSzdSgAwpL5uG0+bNxD0uobLS6BqjlaULjJ6Jrjhk8=;
 b=NwhxoYUwqwJy5T70xImDmSie6f6CzJIB3xlrmUQ8IXPrMRr1jPP0z2A3yDBFn/wRT3
 hyry0HMR5a0ssKB2BYQHXgO9H1dCINoFIbaWpD1dwjWMnK64LDuXSx3+1elpo1j5taL0
 rUiJl2Wey7PPQgGycsFg/6SnjbZPwhMoWiVdy2PsGrish7VYm3RjgYw1tsV208ojNAHx
 6AXKBS+m+X5JTQIAv+TnPucFH+UBwzmyYb+b2uZ9QdhOQ6riCVdckLDY7fzn3zxtsCh7
 M8bIaypThOz2LQKyceUs4t9AQT+HOoBiFB5nMt9MW9lFOpJnh359guEUam+2EOKP6xI1
 7bzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2a0bP8gNq8xr1/W40jf7MCEfXM2IRXT0jibd33ftockLJjarfpJi9ND8oPigiA7383hzdhQRgXOg5@nongnu.org
X-Gm-Message-State: AOJu0YwMvd2O1CLFAtHVOk569GDJWQmzKWytlyfug1RaB8l2PFPK46XQ
 RPlAxEvWlJOU5XPqc+qKUYj0EPJXw51cftuoyZSXfSQW3PhGHQ0PdtfCIm7UGpw=
X-Gm-Gg: ASbGnctdkpucC/3ZmnbR1x7MsvsoudnvY9tgvfJ+oo+E/MjgjEBOhloY4MLybG4uOzb
 Bn+fNVSoAp7PONMzX29Uxuo/pY6HQQKEI8CC/aIUlUJzHtP83zd8UasU92IsLnlR7B+4yhmpfAA
 T+eCortL6hHU9cNxlVWFlluM9k/4gxsfL6AWl3QWgb40HZfd2r+Zv3dFU1MMHjI6U+2/H9YBKe4
 UEZm3asm0VfUEHfUzkjGW5cBB8PlMbTXX2rdEuN/cJkljR7F/76DIZnxqtB5egF9o2MLg==
X-Google-Smtp-Source: AGHT+IFuyZJIOZ8htUmUEjuZT6PgNMMR1oygggoS/4GyJeBTHChSnVbwc7sR7g3PbubKUkASQjDbWQ==
X-Received: by 2002:a17:902:e5cc:b0:215:577b:ab77 with SMTP id
 d9443c01a7336-219e70bf185mr61529695ad.39.1734731213413; 
 Fri, 20 Dec 2024 13:46:53 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f502asm33449575ad.183.2024.12.20.13.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 13:46:53 -0800 (PST)
Message-ID: <86f28c7e-eaac-4350-a3cd-000108d8943e@linaro.org>
Date: Fri, 20 Dec 2024 13:46:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
 <11ae3330-71bb-4da9-9dcb-b7378f1682bc@linaro.org>
In-Reply-To: <11ae3330-71bb-4da9-9dcb-b7378f1682bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/20/24 13:17, Pierrick Bouvier wrote:
> Hi Julian,
> 
> On 12/20/24 03:47, Julian Ganz wrote:
>> Hi Pierrick,
>>
>> December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>>> On 12/2/24 11:41, Julian Ganz wrote:
>>>>    +static void insn_exec(unsigned int vcpu_index, void *userdata)
>>>>    +{
>>>>    + struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
>>>>    + uint64_t pc = (uint64_t) userdata;
>>>>    + GString* report;
>>>>    +
>>>>    + if (state->has_next) {
>>>>    + if (state->next_pc != pc) {
>>>>    + report = g_string_new("Trap target PC mismatch\n");
>>>>    + g_string_append_printf(report,
>>>>    + "Expected: %"PRIx64"\nEncountered: %"
>>>>    + PRIx64"\n",
>>>>    + state->next_pc, pc);
>>>>    + qemu_plugin_outs(report->str);
>>>>    + if (abort_on_mismatch) {
>>>>    + g_abort();
>>>>    + }
>>>>    + g_string_free(report, true);
>>>>    + }
>>>>    + state->has_next = false;
>>>>    + }
>>>>    +}
>>>>
>>> When booting an arm64 vm, I get this message:
>>> Trap target PC mismatch
>>> Expected: 23faf3a80
>>> Encountered: 23faf3a84
>>
>> A colleague of mine went to great lengths trying to track and reliably
>> reproduce this. We think that it's something amiss with the existing
>> instruction exec callback infrastructure. So... it's not something I'll
>> be addressing with the next iteration as it's out of scope. We'll
>> probably continue looking into it, though.
>>
>> The mismatch is reported perfectly normal and boring exceptions and
>> interrupts with no indication of any differences to other (not reported)
>> events that fire on a regular basis. Apparently, once in a blue moon
>> (relatively speaking), for the first instruction of a handler (even
>> though it is definitely executed and qemu does print a trace-line for
>> that instruction):
>>
>> | Trace 0: 0x7fffa0b03900 [00104004/000000023fde73b4/00000021/ff020200]
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
>>
>> It does show up with both single-core and multi-core VMs, so that at
>> least eliminates some possibilities. Maybe :/
>>
>> The issue is nasty to reproduce in a way that allows any meaningful
>> investigation. It usually involves sifting through many GBs of Qemu logs
>> for maybe one occurance. We could add another testing/dummy plugin that
>> just prints the PC for _any_ instruction executed and have a skript
>> check for non-alternating Trace-lines from Qemu and that Plugin. But
>> then we're talking nearly double the amount of Lines to look through
>> with probably little additional information.
>>
> 
> Thanks for the investigation.
> I could reproduce this with this command line:
> ./build/qemu-system-aarch64 -M virt -plugin
> ./build/tests/tcg/plugins/libdiscons.so,abort=on -m 8G -device
> virtio-blk-pci,drive=root -drive
> if=none,id=root,file=/home/user/.work/images/debianaarch64.img -M virt
> -cpu max,pauth=off  -drive
> if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd -drive
> if=pflash,file=/home/user/.work/images/AAVMF_VARS.fd -d plugin,in_asm,op
> -D crash.log
> 
> # -d plugin,in_asm,op allows to dump asm of every translated block,
> plugin output (for discon plugin), and tcg op generated.
> 
> It reliably crashes with a single address.
> Looking at the debug output (crash.log):
> ----------------
> IN:
> 0x23faf3a80:  d108c3ff  sub      sp, sp, #0x230
> # => This bb has a single instruction as input
> 
> OP:
> # this is the TB instrumentation
>    ld_i32 loc0,env,$0xfffffffffffffff8
>    brcond_i32 loc0,$0x0,lt,$L0
>    st8_i32 $0x1,env,$0xfffffffffffffffc
> 
>    ---- 0000000000000a80 0000000000000000 0000000000000000
> # => we can see that there is no call_plugin, looks like instrumentation
> # is not applied
>    sub_i64 sp,sp,$0x230
>    add_i64 pc,pc,$0x4
>    goto_tb $0x1
>    exit_tb $0x7f7eedd355c1
>    set_label $L0
>    exit_tb $0x7f7eedd355c3
> 
> ----------------
> IN:
> 0x23faf3a84:  a9b007e0  stp      x0, x1, [sp, #-0x100]!
> 0x23faf3a88:  a9010fe2  stp      x2, x3, [sp, #0x10]
> ...
> 
> OP:
>    ld_i32 loc0,env,$0xfffffffffffffff8
>    brcond_i32 loc0,$0x0,lt,$L0
>    st8_i32 $0x0,env,$0xfffffffffffffffc
> 
>    ---- 0000000000000a84 0000000000000000 0000000000000000
> # instruction is correctly applied
> call plugin(0x7f7eec96d530),$0x1,$0,$0x0,$0x23faf3a84
>    mov_i64 loc2,sp
>    ...
> 
> Trap target PC mismatch
> Expected:    23faf3a80
> Encountered: 23faf3a84
> 
> The thing interesting here is that we can notice that 23faf3a80 is a
> translation block with a single instruction, and we can see that
> instrumentation is not applied for this instruction (call_plugin is not
> present).
> 
> Overall, it really looks like a bug on QEMU side, where we miss
> instrumenting something. I'll take a look. You can ignore this for now.
> 

It seems like we have a problem to identify tb as mem_only. This was 
introduced to prevent double instrumentation of some memory access 
(touching MMIO), but it seems that as a result, we skip some 
instructions sometimes.

I need to dig into this further, but for now, you should be able to 
workaround this on your side with this patch:

diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de5..6cb9d81a0a2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -92,6 +92,7 @@ void 
qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,

  static bool tb_is_mem_only(void)
  {
+    return false;
      return tb_cflags(tcg_ctx->gen_tb) & CF_MEMI_ONLY;
  }

>> Regards,
>> Julian
> 

Regards,
Pierrick

