Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF516C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MMK-0004PH-8N; Thu, 17 Sep 2026 20:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1x7MMI-0004Ow-Ti
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:21:42 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1x7MME-0006sy-Vc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:21:42 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db22383fe8so883015ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1789690897; x=1790295697;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=97TDR70D9CUjsZCdV4r40XKTc/2M9oFwzn6aISGw0JU=;
 b=G2T1HgwA2KOJ7rCDZjyr9NZIKUkX5msnT/2jyICJZMDfp4afL9F8BK9euDiAO8ngA1
 gmGMTLWkmoSmU4ExFjeZbDs2r2rlPLFQfXvsoBlxfXbei/7Qhp5O/3unYcDsltmc6giN
 JI7lRvJVJQSTKPEFFBJBTGcIKQus/6t9zAlO3vO3QXayZs7JVjwpwW9a84Sxmg3N1AYp
 li79CKMHTdXwU2O4IqlUqrqI4Hzl/Q8bQSikrzEWZDLgrrawh4cBCOL8GdJJ6NAmwPD5
 lpmyfwCpfBivnEE2sPYDczkUMmQDqTqLG3ag8lZllpgww0LycTkePNtC9koQMQwsdsBR
 kfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690897; x=1790295697;
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=97TDR70D9CUjsZCdV4r40XKTc/2M9oFwzn6aISGw0JU=;
 b=E1JyIjr3LvW4LIq7GHqEFTlG7OP5WPvd8A9hlTF2cw9AOw2Dt99zTp0T7gns35qtz9
 H1V3h51PbnMWlA7qcbA4fK+Y61ECYw/E0KQbwRYrrUFYlD6hm6JOz8wIf+Wu8y0cSGmi
 XQWoWy8LW8YZM79RMm36vT3bWNxf9gmPTze0CYMC4Bf2/A36lIpMeI8Wcg4yXifuOfwQ
 aRw6nHeN7Hsdzj0OZ/DIFUhPoZ28ZveetAJBwzi2F4we5Kc2a+OjAOIHV5ZtYf6ND54y
 U/kNNQALNrcEnsHTNROmALbevY73GFXh82asC6pfA6y+4lnc6BwltmC3tNnghF2d1gVr
 6hmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3Eu8omMq+UXv0Y71NwQ/emfXi/p6YbkPucQr5b3YNjr/PafPQdoTXlCyhadIh3rC/fqogISy4ScSU@nongnu.org
X-Gm-Message-State: AFuF++lHKn83lokTUneCynLDE/ODlqsgjg/Ujj1l8wpRKXW9bEF6woFD
 UPcs1PcyDtWgsEgXzjHYoVrn525tzeADQawWaipVWAGN50AAsXCB36APK5dWTLk2qqs=
X-Gm-Gg: AYBFou1H4AP3Z4XwEvE1G2ZsAULni16xvVcNL/wmeN7+rpeCjKSnRZmPocuj0tPvTy+
 QTK+K/cx4BU3q+Xm7PgYhjQ9JdUoEv5vKdktwgGv6tB5j1PksOutoQ5ghbYNZc2X7BsniipVIrX
 It1s1btG7h1+gubqRoY5uPFfRTORWiUDVbZ1jRdQsSzz2IshWokUb6JMa2HiyM+akAf7HoCt4Bx
 V453jJDqrOa9Vj44qQjao6fdxkPnvnDgvXDV73x9pJS/+RuXVfTE+hVRTFjJn4h/DWYlJjNOyZY
 BARxCM9UWNoiOwQJOGGNDzYPUjK96nbgIYzeyjPX6JUtDpGFEDG4lVROuEW9aMRYRvSS/J9ZGIR
 PiiS3Udwh06qzkPmQef53kp5LuElom5dvV+p7z3G1USq5lAjk1GXRY5hUkDCbwubYvZ1fasz9JF
 lcahIpDlGgmEr+APYa0dwcWe18+gNa4cSYLHuAsnN3BqsA/ha3fQJmkZJkaa5JtE7EFc16SNVOM
 +LbEphYZYAxyGjCAXqohkS0rAZ5iQ==
X-Received: by 2002:a17:903:2f84:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2ddb1af51a9mr14384985ad.13.1789690896524; 
 Thu, 17 Sep 2026 17:21:36 -0700 (PDT)
Received: from localhost ([2001:5a8:4687:d600:a432:5959:dbd9:36fd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a93f1fsm18873823eec.11.2026.09.17.17.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:21:35 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:21:35 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Sep 2026 17:21:34 PDT (-0700)
Subject: Re: [PATCH v2] tcg/riscv64: Set vtype before whole-register vector
 moves
In-Reply-To: <1f02f0fc-fee2-4722-9798-97bb0132561d@linaro.org>
CC: max.chou@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, daniel.barboza@oss.qualcomm.com,
 joel@jms.id.au
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <mhng-2ECF390B-6BDB-4DF3-8133-18F4AC3A4DD2@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=palmer@dabbelt.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 17 Sep 2026 14:49:07 PDT (-0700), Richard Henderson wrote:
> On 9/17/26 10:59, Palmer Dabbelt wrote:
>> On Thu, 17 Sep 2026 13:51:10 PDT (-0700), Richard Henderson wrote:
>>> On 9/17/26 03:37, Max Chou wrote:
>>>> According to the RISC-V unpriviledge spec,
>>>>    "vset{i}vl{i} and whole register loads and stores do not depend upon
>>>>     vtype."
>>>> The whole-register vector move instructions reuqire legal vtype that
>>>> trap when VILL is set.
>>>>
>>>> The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting
>>>> the
>>>> OPC_VMVNR_V.
>>>>
>>>> Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
>>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Signed-off-by: Max Chou <max.chou@sifive.com>
>>>> ---
>>>>   tcg/riscv64/tcg-target.c.inc | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
>>>> index 2ce9d47a633..e3cfedb579d 100644
>>>> --- a/tcg/riscv64/tcg-target.c.inc
>>>> +++ b/tcg/riscv64/tcg-target.c.inc
>>>> @@ -778,6 +778,10 @@ static bool tcg_out_mov(TCGContext *s, TCGType
>>>> type, TCGReg ret, TCGReg arg)
>>>>           {
>>>>               int lmul = type - riscv_lg2_vlenb;
>>>>               int nf = 1 << MAX(lmul, 0);
>>>> +
>>>> +            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
>>>> +                set_vtype_len(s, type);
>>>> +            }
>>>>               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
>>>>           }
>>>>           break;
>>>
>>> Do you have a reproducer for this?  I ask because I still wonder how
>>> this can occur.
>>>
>>> Given that
>>>
>>> (1) all vector registers are call-clobbered, there should be none live
>>> across tcg_out_call_int (which clears the remembered vtype),
>>>
>>> (2) the first vector action with no vector registers live must be a load
>>> or movi (which will initialize vtype).
>>>
>>> Performing a move between vector registers when all such registers must
>>> be dead is... wrong.  It indicates that there's a bug elsewhere.
>>
>> I'm not quite sure the commit message is right here, but this whole area
>> is a bit of a landmine: one of the post-ratification changes to V was
>> either this (or very close to this), so we've been through it for every
>> project.
>>
>> Here's the LLVM thread, which I think has links to everything else:
>> https://github.com/llvm/llvm-project/issues/114518 (there's a GCC change
>> as well).  IIRC hardware is a bit all over the place on this one, for
>> the compilers we decided to just emit the code that's safe either way --
>> that's not really an option for QEMU, though, so we'll have to pick one
>> side or the other.
> Yes, I get that.  But my point stands that after a function call (which
> can set VILL), all vector registers should be dead.  A move of a dead
> register is itself a bug.

That's true for standard ABI functions, but there's a variant for 
vector-ABI functions that allows some registers to be saved and that 
variant doesn't preserve vtype.  That's basically how we ended up in the 
mess with whole-register moves: pre-change vector-1.0 versions didn't 
trap whole-vector moves on vtype=VILL, so variant functions could use 
whole-register moves to save/restore registers and it was legal.  It was 
only when Linux started clobbering with VILL on implementations that 
respected the post-change ISA that we ended up with the traps.

That said, in GCC we just had a proper bug in there where we treated 
vytpe as saved over calls, so it was pretty easy to roll it up into that 
fix.  Here's the GCC bug, if you're interested: 
<https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117544>.  IIUC it was a 
little different in LLVM because they didn't have that bug and were thus 
actually correct for the pre-change ISA, but they also decided to just 
emit the code that's safe for both cases.

> There should have been *something* that brought the source vector
> register back to life: a load or a movi.  Both of which reinitialize vtype.
>
> That's why I'd like to see a reproducer, or if there isn't one,
>
>      tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
>
> I'm currently running the assert through the testsuite to make sure I've
> not gone loopy.

Ya, seems reasonable.  It's certainly pretty likely this is masking some 
other bug as it was in GCC.

