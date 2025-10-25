Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F92CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 15:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCg8g-00075D-Hb; Sat, 25 Oct 2025 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vCg8e-00074G-BZ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 11:25:04 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vCg8c-0006mD-3b
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761405898; x=1762010698; i=deller@gmx.de;
 bh=PF26YYeMwopvx72sD6M81VJT2mRyVryehadt8glqYb8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=B8y6eVGmCye2ekkzvXdz/m2VPX0CMZoIQ7Ve73alzW8It1U/o82/UYnibZ9rN7eB
 JstBcpDa1Dfaf58khjxS/0CEISjL6OPvUmot0WWuSIrL3wCZdOk74tSrF/4W+l623
 +XPyS2X4utuAEs9R5kpfrMH0hKuFpkc1HxUDG3tpxg+wDAcAmMqyrxIszTJ0yftWl
 jJrlkHu6iPPXmfVXQAySmBXd/78QpJm112fDX9QDq3lx2NaHc3VPah9pSrrLf35I0
 CbQMfNHFlZjeA+3UNEmOEkUMeHG0SONe0aUu588ZrdwWuicodJvupHm4JmqtSoz6C
 QlVETyxuzwBUm7c+gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.19]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1uqM2A3K0V-00Ma16; Sat, 25
 Oct 2025 17:24:57 +0200
Message-ID: <80a84374-3ba9-4b9b-b710-945e6d7f1dc6@gmx.de>
Date: Sat, 25 Oct 2025 17:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Set FPCR exception flag bits for non-trapped
 exceptions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gabriel Brookman <brookmangabriel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251017085350.895681-1-peter.maydell@linaro.org>
 <6c4d97fc-56fc-417c-9f2b-6a89c9c86591@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <6c4d97fc-56fc-417c-9f2b-6a89c9c86591@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bdE1A0dqqgFA2ofWCeCmdzOM0oAP701c4m/5PzZK3jE4TSSIXgt
 oW/D33t9C34gSgk49eCQsVFyXbrcZnUiKJl/OVBAyFco3dQZFVIXg52fhcHzCS0dI9IzYM2
 m5yzWWJrARLUPlc+OzC+bLwXn7jPkHTI7HK/POp/cXtOmxZ3nkxQmxdjPA5nanH/PzXfHp5
 r/Q/DDwqiCBsf64212ilg==
UI-OutboundReport: notjunk:1;M01:P0:WRYm9JzQXiY=;f26qd0Axc4f7JbijNYc9X1kXsNk
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/22/25 21:00, Philippe Mathieu-Daud=C3=A9 wrote:
> On 17/10/25 10:53, Peter Maydell wrote:
>> In commit ebd394948de4e8 ("target/hppa: Fix FPE exceptions") when
>> we added the code for setting up the registers correctly on trapping
>> FP exceptions, we accidentally broke the handling of the flag bits
>> for non-trapping exceptions.
>>
>> In update_fr0_op() we incorrectly zero out the flag bits and the C
>> bit, so any fp operation would clear previously set flag bits. We
>> also stopped setting the flag bits when the fp operation raises
>> an exception and the trap is not enabled.
>>
>> Adjust the code so that we set the Flag bits for every exception that
>> happened and where the trap is not enabled.=C2=A0 (This is the correct
>> behaviour for the case where an instruction triggers two exceptions,
>> one of which traps and one of which does not; that can only happen
>> for inexact + underflow or inexact + overflow.)
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: ebd394948de4e8 ("target/hppa: Fix FPE exceptions")
>> Resolves:=20
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

>> ---
>> =C2=A0 target/hppa/fpu_helper.c | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
>> index 45353202fae..2d272730f60 100644
>> --- a/target/hppa/fpu_helper.c
>> +++ b/target/hppa/fpu_helper.c
>> @@ -94,7 +94,8 @@ static void update_fr0_op(CPUHPPAState *env, uintptr_=
t ra)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t soft_exp =3D get_float_exceptio=
n_flags(&env->fp_status);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t hard_exp =3D 0;
>> -=C2=A0=C2=A0=C2=A0 uint32_t shadow =3D env->fr0_shadow & 0x3ffffff;
>> +=C2=A0=C2=A0=C2=A0 uint32_t shadow =3D env->fr0_shadow;
>> +=C2=A0=C2=A0=C2=A0 uint32_t to_flag =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fr1 =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(soft_exp =3D=3D 0)) {
>> @@ -122,6 +123,10 @@ static void update_fr0_op(CPUHPPAState *env, uintp=
tr_t ra)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fr1 |=3D hard_exp << (R_FPSR_FLAGS_SHIFT - R_FPSR_ENABLES_SHIFT)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Set the Flag bits for every exception that was n=
ot enabled */
>> +=C2=A0=C2=A0=C2=A0 to_flag =3D hard_exp & ~shadow;
>> +=C2=A0=C2=A0=C2=A0 shadow |=3D to_flag << (R_FPSR_FLAGS_SHIFT - R_FPSR=
_ENABLES_SHIFT);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->fr0_shadow =3D shadow;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->fr[0] =3D (uint64_t)shadow << 32 | =
fr1;
>=20


