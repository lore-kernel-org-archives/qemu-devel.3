Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2890FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOxE-0000Hl-OZ; Mon, 12 May 2025 04:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEOxC-0000Gq-UU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:56:06 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uEOx8-0003LZ-8I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:56:06 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 05647180100
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 10:55:59 +0200 (CEST)
Received: (qmail 32599 invoked by uid 990); 12 May 2025 08:55:58 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 12 May 2025 10:55:58 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: Re: [PATCH v4 18/23] target/s390x: call plugin trap callbacks
Date: Mon, 12 May 2025 10:55:44 +0200
Message-ID: <20250512085546.2918-1-neither@nut.email>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512084352.2424-1-ganz@fzi.de>
References: <cover.1746968215.git.neither@nut.email>
 <e7b270caf050f837fb9222a88cd4f156c608d197.1746968215.git.neither@nut.email>
 <f9602133-c616-4b41-b856-785767644257@redhat.com>
 <20250512084352.2424-1-ganz@fzi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-1.082426) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.182426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=Si7Qu1Fudi+gtePdfu5EYtbRVU3q7WuIjQr94kTJwXs=;
 b=UGt/Gb50+OIlOItxpiIRuEdpknT1ERUfrHjJehvWUJmU8wKN6apYb8q2XaavZ6bnUl4B2SdhD8
 Tdz3QENw5ODy9zI2qw5XL4SDT/BOJA4M9TRWAMQNZ+PlOyePlbYIeKnHiFm+REDFcK4kdfkTTZW+
 H0LLii2p41JUuqb91T6+9Xf/WEqG5YKVvjeSMiRpbKfbiUb1zsqriWxPUSOJRL8mPILkXJi/strv
 2vvXWJDbGqlupu+pttHeU1isYLqOBpepB+6szUW4cV1p+C2Aha6n0cFJFqBjBi0J7sXWbCUDu2yR
 YcZHQ+/3iYp1LMT8fTGkkPAVU/py+ppwbh2LErNiM9XRmQuk9Kjsx4gHeAX6vQ+NOHOuDgHRZc8G
 VI4mjRltxAVU4suDyxw/eiq8t4pFn4Je21Edn+YJl32IvrWUOescsWCVFSES4vQVyHgpsoYvWOvx
 EFioPGVUDWUr3S3WaH2ZDngvFxzP4YKaPa207mcvWyjl4jrMGb/A9r947znwCx9KGfLdUmtZdEIy
 IlmtURy4t01Qrxw7nOxPMM0PZQ2ZUMJs1MlEDVdS+tzUKFiNYBJcJSk8uF5tNVBbdg+FgzKLJNzy
 e6/Zs2ARt02vrODCn25Ioh7haPt0URx6DPJfWsTWz0Dzvaddg7z9XIqbQO4s3zreFsFivgZG6fUF
 k=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi list,

I messed up the last messages From-address when drafting the mail by
hand. Sorry for the noise.

> Hi David,
>
> It appears you only replied to the qemu-devel list? I just saw this when
> informing a co-worker about this series.
>
>> On 11.05.25 15:14, Julian Ganz wrote:
>>> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
>>> index e4c75d0ce0..b7e7a4deff 100644
>>> --- a/target/s390x/tcg/excp_helper.c
>>> +++ b/target/s390x/tcg/excp_helper.c
>>> @@ -34,6 +34,7 @@
>>>   #include "hw/s390x/s390_flic.h"
>>>   #include "hw/boards.h"
>>>   #endif
>>> +#include "qemu/plugin.h"
>>>   
>>>   G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
>>>                                              uint32_t code, uintptr_t ra)
>>> @@ -499,6 +500,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
>>>       S390CPU *cpu = S390_CPU(cs);
>>>       CPUS390XState *env = &cpu->env;
>>>       bool stopped = false;
>>> +    uint64_t last_pc = cpu->env.psw.addr;
>>>   
>>>       qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
>>>                     __func__, cs->exception_index, env->psw.mask, env->psw.addr);
>>> @@ -528,21 +530,27 @@ try_deliver:
>>>       switch (cs->exception_index) {
>>>       case EXCP_PGM:
>>>           do_program_interrupt(env);
>>> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>           break;
>>>       case EXCP_SVC:
>>>           do_svc_interrupt(env);
>>> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>           break;
>>>       case EXCP_EXT:
>>>           do_ext_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>           break;
>>>       case EXCP_IO:
>>>           do_io_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>           break;
>>>       case EXCP_MCHK:
>>>           do_mchk_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>           break;
>>>       case EXCP_RESTART:
>>>           do_restart_interrupt(env);
>>> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>
>> Might be easier to check for "if (cs->exception_index != EXCP_STOP)"
>> after that switch-case.
>
> I still need to differentiate between exceptions and interrupts, which
> would result in another switch-case.
>
>> But I'm curious about the semantics: are we supposed to call
>> qemu_plugin_vcpu_interrupt_cb() just after an interrupt got delivered?
>
> `qemu_plugin_vcpu_interrupt_cb` or `qemu_plugin_vcpu_exception_cb` need
> to be called after the CPU was set up (that is, after PC and any other
> relevant register was set) and before the next instruction is executed.
> So, yes, more or less.

Regards,
Julian

