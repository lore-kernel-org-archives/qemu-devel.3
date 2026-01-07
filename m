Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D3CFD621
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdStr-0002fP-JX; Wed, 07 Jan 2026 07:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdSti-0002XY-6E
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:44:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdStg-0004Av-Fx
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:44:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 67788596A0A;
 Wed, 07 Jan 2026 13:44:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id L1f5L9XbEecF; Wed,  7 Jan 2026 13:44:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6594C596A41; Wed, 07 Jan 2026 13:44:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6430B596A10;
 Wed, 07 Jan 2026 13:44:17 +0100 (CET)
Date: Wed, 7 Jan 2026 13:44:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/tcg: do not leave non-arithmetic flags in
 CC_SRC after PUSHF
In-Reply-To: <866bd2d5-4ec0-42bf-904b-90eef42efd24@nutanix.com>
Message-ID: <9c799048-b278-a6a1-65ac-761948d7c043@eik.bme.hu>
References: <20260107045235.94348-1-pbonzini@redhat.com>
 <866bd2d5-4ec0-42bf-904b-90eef42efd24@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 7 Jan 2026, Mark Cave-Ayland wrote:
> On 07/01/2026 04:52, Paolo Bonzini wrote:
>
>> The value that is pushed by PUSHF is the full EFLAGS, while CC_OP_EFLAGS
>> only wants arithmetic flags in CC_SRC.  To avoid this, follow what other
>> helpers to and set CC_SRC/CC_OP directly in helper_read_eflags.  This

Small typo: other helpers do

Regards,
BALATON Zoltan

>> is basically free and fixes an issue booting Windows 3.11.
>> 
>> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Fixes: e661e2d7a37 ("target/i386/tcg: update cc_op after PUSHF", 
>> 2025-12-27)
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/cc_helper.c | 4 +++-
>>   target/i386/tcg/emit.c.inc  | 3 +--
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
>> index 91e492196af..6ddd64fcb07 100644
>> --- a/target/i386/tcg/cc_helper.c
>> +++ b/target/i386/tcg/cc_helper.c
>> @@ -414,7 +414,9 @@ target_ulong helper_read_eflags(CPUX86State *env)
>>   {
>>       uint32_t eflags;
>>   -    eflags = cpu_cc_compute_all(env);
>> +    CC_SRC = eflags = cpu_cc_compute_all(env);
>> +    CC_OP = CC_OP_EFLAGS;
>> +
>>       eflags |= (env->df & DF_MASK);
>>       eflags |= env->eflags & ~(VM_MASK | RF_MASK);
>>       return eflags;
>> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
>> index 0fde3d669d9..e55b65176fc 100644
>> --- a/target/i386/tcg/emit.c.inc
>> +++ b/target/i386/tcg/emit.c.inc
>> @@ -3253,8 +3253,7 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn 
>> *decode)
>>       gen_update_cc_op(s);
>>       gen_helper_read_eflags(s->T0, tcg_env);
>>       gen_push_v(s, s->T0);
>> -    decode->cc_src = s->T0;
>> -    decode->cc_op = CC_OP_EFLAGS;
>> +    assume_cc_op(s, CC_OP_EFLAGS);
>>   }
>>     static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
>
> Thanks Paolo! I've given this a quick test and it fixes the issue here:
>
> Tested-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
>
> ATB,
>
> Mark.
>
>
>

