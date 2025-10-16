Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285FACCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Wh4-0001if-E8; Thu, 16 Oct 2025 18:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v9Wh2-0001iO-R4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:43:33 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v9Wgz-0004Ey-Sz
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760654605; x=1761259405; i=deller@gmx.de;
 bh=K9nBCthlZLh93cG3C6xrQt/Ed9HV9WpBLXD/ZkawtD0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T93oMXLuEXgpsit1Y3ZX4Lfze8zhdhaEDxadk/BzTxPdkcOxdAtwBKWLa2Slyu9v
 eas+I7NzlYILyqR/upxdnB0mydF/ybWMCa8iNxjID/l1tRYGqAedHcutFIMR7dKNN
 zi+kDPsCd2z1Yi8ycGfZDoXI35eBI5TEEf/uJ6M908LaYhTIIZ4DDbxhwEvVKBrqV
 gPcFqTgDaBq+09iwAlDDk9LgbyflLznaj8A2rsxJ3jsvHL/sDK5Uho73zFx0xRBDJ
 yzR7EFOHs5xJ5LdEf6betYwSInjSCYFeg/wSwE35j/bTHVWMQBsElVlDcwLMDQjEz
 j1VPfLg1HE63ycOL3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.145]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1uKRlz2874-00wNVr; Fri, 17
 Oct 2025 00:43:25 +0200
Message-ID: <bcdb6d13-6c55-40ae-b768-e5f34cb73d8d@gmx.de>
Date: Fri, 17 Oct 2025 00:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: Fix FPE exceptions
To: Peter Maydell <peter.maydell@linaro.org>, deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250517120053.18231-1-deller@kernel.org>
 <20250517120053.18231-4-deller@kernel.org>
 <CAFEAcA8i31Btj4KLXb+4oL9fxEQsCOwsZxJtw4qXcorboG=tDg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA8i31Btj4KLXb+4oL9fxEQsCOwsZxJtw4qXcorboG=tDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QrLUndLfCCGU3YbMxgqSvyv+O0eMAjUEZ1OaNIHWRBHRarc8tgY
 +gDVblPWHeyLl2M31m3K5SmO3+36TNZO56B5eUGxfwe9YMF+U7L8JvrqpDSYUJsu7jgwsHV
 R8jXHFU/N9DomBO3qwkp4ujXUbn51jXX8vBUDdnxLKthHKWPH3JN/BFmnYE9GZGx4I9XmtL
 Yq534BE8KNzAYVN2JFcWw==
UI-OutboundReport: notjunk:1;M01:P0:/fRyz8gUv3w=;j8YmT7r2Nm7CwXhs1qpLSBY3LH1
 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
 4e+4J2gcD8sSdEAMX0HB1Cjwb8=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/16/25 19:23, Peter Maydell wrote:
> On Sat, 17 May 2025 at 13:02, <deller@kernel.org> wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> Implement FP exception register #1 (lower 32-bits of 64-bit fr[0]).
>> A proper implementation is necessary to allow the Linux kernel in
>> system mode and the qemu linux-user to send proper si_code values
>> on SIGFPE signal.
>>
>> Always set the T-bit on taken exception, and merge over- and underflow
>> in system mode to just set overflow bit to mimic the behaviour I tested
>> on a physical machine.
>=20
> It looks like this patch broke the setting of the Flag
> bits in the FPSR for non-trapped exceptions, which is
> https://gitlab.com/qemu-project/qemu/-/issues/3158 ...
>=20
>> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
>> index a62d9d3083..294ce0a970 100644
>> --- a/target/hppa/fpu_helper.c
>> +++ b/target/hppa/fpu_helper.c
>> @@ -95,7 +95,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_=
t ra)
>>   {
>>       uint32_t soft_exp =3D get_float_exception_flags(&env->fp_status);
>>       uint32_t hard_exp =3D 0;
>> -    uint32_t shadow =3D env->fr0_shadow;
>> +    uint32_t shadow =3D env->fr0_shadow & 0x3ffffff;
>=20
> We used to have 'shadow' contain all the existing Flag bits,
> but now we mask them out. So whenever we call this function
> we will zero out any previously set Flag bits.
>=20
>> +    uint32_t fr1 =3D 0;
>>
>>       if (likely(soft_exp =3D=3D 0)) {
>>           env->fr[0] =3D (uint64_t)shadow << 32;
>> @@ -108,9 +109,22 @@ static void update_fr0_op(CPUHPPAState *env, uintp=
tr_t ra)
>>       hard_exp |=3D CONVERT_BIT(soft_exp, float_flag_overflow,  R_FPSR_=
ENA_O_MASK);
>>       hard_exp |=3D CONVERT_BIT(soft_exp, float_flag_divbyzero, R_FPSR_=
ENA_Z_MASK);
>>       hard_exp |=3D CONVERT_BIT(soft_exp, float_flag_invalid,   R_FPSR_=
ENA_V_MASK);
>> -    shadow |=3D hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT=
);
>=20
> ...and we used to set the Flags bits for any exception that
> had happened, and now we don't. So setting Flags for
> non-trapped exceptions doesn't work.
>=20
>> +    if (hard_exp & shadow) {
>> +        shadow =3D FIELD_DP32(shadow, FPSR, T, 1);
>> +        /* fill exception register #1, which is lower 32-bits of fr[0]=
 */
>> +#if !defined(CONFIG_USER_ONLY)
>> +        if (hard_exp & (R_FPSR_ENA_O_MASK | R_FPSR_ENA_U_MASK)) {
>> +            /* over- and underflow both set overflow flag only */
>> +            fr1 =3D FIELD_DP32(fr1, FPSR, C, 1);
>> +            fr1 =3D FIELD_DP32(fr1, FPSR, FLG_O, 1);
>> +        } else
>> +#endif
>> +        {
>> +            fr1 |=3D hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_=
SHIFT);
>> +        }
>> +    }
>>       env->fr0_shadow =3D shadow;
>> -    env->fr[0] =3D (uint64_t)shadow << 32;
>> +    env->fr[0] =3D (uint64_t)shadow << 32 | fr1;
>>
>>       if (hard_exp & shadow) {
>>           hppa_dynamic_excp(env, EXCP_ASSIST, ra);
>> --
>=20
> "Set all the Flag bits for non-trapping exceptions" seems
> straightforward. I can't see anywhere in the function which
> would care about the Flag bits in the 'shadow' variable,
> though, so I don't understand why you were masking out the
> Flag bits in this patch; so I'm not sure whether undoing that
> will break anything. (I don't have a setup to try the test
> program you give in this commit message.)
>=20
> This patch fixes the "don't trap" case:
>=20
> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index 45353202fae..2d272730f60 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_t=
 ra)
>   {
>       uint32_t soft_exp =3D get_float_exception_flags(&env->fp_status);
>       uint32_t hard_exp =3D 0;
> -    uint32_t shadow =3D env->fr0_shadow & 0x3ffffff;
> +    uint32_t shadow =3D env->fr0_shadow;
> +    uint32_t to_flag =3D 0;
>       uint32_t fr1 =3D 0;
>=20
>       if (likely(soft_exp =3D=3D 0)) {
> @@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintpt=
r_t ra)
>               fr1 |=3D hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_=
SHIFT);
>           }
>       }
> +    /* Set the Flag bits for every exception that was not enabled */
> +    to_flag =3D hard_exp & ~shadow;
> +    shadow |=3D to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT);
> +
>       env->fr0_shadow =3D shadow;
>       env->fr[0] =3D (uint64_t)shadow << 32 | fr1;
>=20
> If it looks OK I'll send it as a proper patch
Yes it looks good, so please send a patch!
I've tested your patch.
It indeed fixes the testcases as reported by Bruno:
https://gitlab.com/qemu-project/qemu/-/issues/3158
On a physical machine those testcases succeeded too.
Last, even my testcase still shows the same result (same signal)
as on real hardware.

So, thanks for fixing this issue!

Helge

