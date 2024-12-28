Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6188E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 21:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRe6p-00040b-EU; Sat, 28 Dec 2024 16:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tRe6n-000408-Bn
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 16:12:29 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tRe6l-00049z-Dy
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 16:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735420339; x=1736025139; i=deller@gmx.de;
 bh=V7UAF1i0ohTp9Ae5pcfCdcZzwgLJZ5SYQySZlAD9x5U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H0MUwVC2HHEFXOEuWhGMyPuyLlhE64waRh461b3t21bFm90uncByzUdFIJeQm9Gw
 9P271nKy3TuY3PtMjQq5lZ+50Imfc8mdmISKvYiPVv1e0rkmobfizL3u7eeAyyI9M
 ckuQLVqz+urLiFkgvbclHx63QiiIm20Vy0oZUr93bpnpiCQUsIZXBI9JJmSru9zp7
 OIL+PyeUa7Je7EvWgrZEuoerzgmjrcEO3Zqjei5fAhsvaS1LhylpZkJVukwk/nnxI
 fT7U8TVN7QMwwrg54S99M7bLwEkcBQXeJZgvnhByevm+GnR+2SxVOdJ4xFNlgvu2e
 sQAEBK8g4v50iB/JAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1t1hFx0qu2-00U26u; Sat, 28
 Dec 2024 22:12:19 +0100
Message-ID: <96b8aad9-1eda-495c-a0f0-0e955151d4fb@gmx.de>
Date: Sat, 28 Dec 2024 22:12:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Speed up hppa_is_pa20()
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@kernel.org>,
 richard.henderson@linaro.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <Z2-nWcZ5l6oklIZW@p100>
 <8150fda8-7f13-75d6-57cf-e2099b14ff33@eik.bme.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8150fda8-7f13-75d6-57cf-e2099b14ff33@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8OYvz+FVyD2ZkX0o2PU5gqdM3teDaTk1NOLK6CwuKPIDahBVRf
 ltyLqBBfkUakONwRdSrT4OhQi2EM77cxo53CJ4dPjBYodijf6ZGhHZYb7YGFS0JIfGhi6hV
 dSxhwZzDurCrijmidBk3VZisEQoikeJ7RFV2qfO1i82JDBKDdYuM7VpITAle4HqTZRRnHjk
 UrnDeXyx0NavK947qyEWw==
UI-OutboundReport: notjunk:1;M01:P0:G7DcUf2xohc=;piFhJzDlYoX3I7nh9bix2nc/Dfo
 yddyc2VbN1nHUj8AX+5lPI8atR0a/MNGr7nQQCf2+a/MVoJXaCY5YXgfM11ed5AdyDCUFC3Hk
 4lX384yLQPjTbPWtQxPwpbV8vO/LLsAZFUBvmDOvZ0StuL6FQnbVwdR1KJGy73mMHmQJpdOpe
 3VIQakzi4x8XvRU+UJ3Ks9wjv541hE9thLwXXuuRyq6F0jU/YIGEkN23AvLPT+3tcqggtGXi1
 rkAbh28WSvFB9bG4LRwxL801sg56aEOAiJm83+zRJ8a8Mof+W5FA9scVlAD3iL75SZjWCqEI0
 aiwRQ1sxu/LKi3DgiB3r9OONxaOjtE0OOOVeIf0216vFVpb6Ee2t9kqBD3h1x+F+/qMQDC8Md
 geUBHEB9fjeV9WK0Nfdk5ob2lNK1XEHZodJ5TwCJCLciZRNPDHVdAAxqWcq/jyc1cLpGZXxxd
 i4JuivshNCk8YO/TWjKZTWwIst1hR0ZJkNCO1qQxKpSJmy0tcky5F+8qSZklC0ZuGzVo+MupV
 izYs9j6lEVx74Ir7f1gh6mqQSJwz+f0rq/wwX9huMoDef7BNL5MTlZNFsi1Vlk6bWJIvXzbfl
 zFUNy4v2vB0lLqgMYBJiYiwppiRIZ5lb/irdjJiJQwgFLxHIC9bHch3X1RIIdImBCgVdJRpn7
 8QD7ZMqrkEnjOSPvmsYmtNUhPsISXlfbcb4RJOXVbEGMq1+Wy5nDD9ekbpZAP8BRwk0o9MtOC
 LBs14SfinK2ueJPYE6IWLfKgYHgNaV82oHsJPMsu/sZcS075QvwSVRMNTJUGaqcnDDWx17CKq
 YUoGnKRzkPwx4Mqtt3mzu5x3zf7heNrpMJoIWcKeAiY5jTki18G6tis8S4md0qNas8Bx1zI50
 IrjfMlPp4avOTR3Ii4oTTbaN+1HAmqTRre2thlPHzarUBEy7583H/xyTGNf+Xvx48+YYXzppP
 jPS9rOXez8yoS+nICr4Jd1B80w8nxFQeZx54y/TqNpqSBSH0CvTQ9Zq1+dLrhCf+PnZl09i95
 51lWMJK/HeA/6HRrXM8HDJX2eNU3R5hsQTRgAU3Zb6/ksZD3nXI05aQoHTV6s8HAtJmPkm5BI
 GEfLm8pS/dLrFW34JBo40AhPjFPywo
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/28/24 12:16, BALATON Zoltan wrote:
> On Sat, 28 Dec 2024, Helge Deller wrote:
>> Although the hppa_is_pa20() helper is costly due to string comparisms i=
n
>> object_dynamic_cast(), it is called quite often during memory lookups
>> and at each start of a block of instruction translations.
>> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
>> CPU creation and store the result in the is_pa20 of struct CPUArchState=
.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index a31dc32a9f..08ac1ec068 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -281,6 +281,7 @@ static TranslateFn *machine_HP_common_init_cpus(Mac=
hineState *machine)
>> =C2=A0=C2=A0=C2=A0 /* Create CPUs.=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 for (unsigned int i =3D 0; i < smp_cpus; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu[i] =3D HPPA_CPU(cpu_crea=
te(machine->cpu_type));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu[i]->env.is_pa20 =3D obj=
ect_dynamic_cast(OBJECT(cpu[i]), TYPE_HPPA64_CPU);
>> =C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0 /*
>> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
>> index e45ba50a59..c37a701f44 100644
>> --- a/target/hppa/cpu.h
>> +++ b/target/hppa/cpu.h
>> @@ -208,6 +208,7 @@ typedef struct CPUArchState {
>> =C2=A0=C2=A0=C2=A0 uint64_t fr[32];
>> =C2=A0=C2=A0=C2=A0 uint64_t sr[8];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* stored shifted into place for gva */
>>
>> +=C2=A0=C2=A0=C2=A0 bool is_pa20;
>> =C2=A0=C2=A0=C2=A0 uint32_t psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* All psw bits except the following:=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 uint32_t psw_xb;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* X and B, in their normal positions */
>> =C2=A0=C2=A0=C2=A0 target_ulong psw_n;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 boolean */
>> @@ -294,7 +295,7 @@ struct HPPACPUClass {
>>
>> static inline bool hppa_is_pa20(CPUHPPAState *env)
>> {
>> -=C2=A0=C2=A0=C2=A0 return object_dynamic_cast(OBJECT(env_cpu(env)), TY=
PE_HPPA64_CPU) !=3D NULL;
>> +=C2=A0=C2=A0=C2=A0 return env->is_pa20;
>> }
>
> Now this function name is longer than what it extends to so maybe it
> would be simpler to drop the inline function and use env->is_pa20
> directly where it's needed?

Yes, that's a possible cleanup which can be done afterwards.

> Is there a reason to keep the function?

Personally I like it more than the "env->is_pa20".
Richard, any opinion from your side? Should I send a such a replacement pa=
tch?

Helge

