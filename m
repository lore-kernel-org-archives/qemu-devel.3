Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315C0E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 16:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRwWq-0008Dy-IX; Sun, 29 Dec 2024 11:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRwWW-0008CJ-EN
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:52:16 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRwWU-0003Lw-OR
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:52:16 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so17074211a12.1
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735491132; x=1736095932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjeV/RZHZwvSMRRXjg4ZPwPFxDU+k+K1tTM8v41g2jI=;
 b=B6LS9xyCU5gbgd/WgleHddjaJgOJOM8ty5qiaws5URpxlC+rEUfVD+vPUO++xEkVcc
 Fki0UIjOJ2Tb++ApHT6DZ4/+inY68MDJauJMijzpyCUkZeP3Y41JoLlNVzTUnxGwbq0X
 SUwqcHZSldzoWIx2ms3NpIjR4fR5SojiQqSy3zlja3QqM3GJYr1BFp1keqB5WrUay1G3
 NSNGJ6FeUHW50NwhCAxc/Dd7J/0F7PncFlAAGOhk/ztCPUS4LPSiR4NxyRVxrTRaFf61
 QBkqEK5x8nKeYUGNGWDbGI42euIrznTwhQigLL3tgwznha/votiN3kQ6n10QpWBhPcCL
 983A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735491132; x=1736095932;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YjeV/RZHZwvSMRRXjg4ZPwPFxDU+k+K1tTM8v41g2jI=;
 b=dUlVAIh5fTQctBaLHxXQdGsJrODKi1ApOO1e4tYLgUAsyISD9Mb9fMe9uDkJIbjD3n
 glwUXM8Fq26IKhjFQBHiB1p25ntlmV3dRBOSFt8es9iyoQ7ku2Hcw5xBQSDr89dN60CV
 jD2GEjiXfdfjM+qHgRTGTl1nZHtfyiUyL7gEX8iE+TYY4jHE4zFv07SGQsmjLFB2c3Un
 nGPH/qxaGiwIIrpLMu3SpsLTja8J8MwpXRJrw9EK5zMJcssDBTbHsdqc1rxKXk2BQ16X
 UfmAYN+W4UQ+pN/TxlbXZDUHIzbA1clKxNzCM6XMBCdMmxSPEzcZx44WPiiLZJO+02qZ
 wVrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg6Rwgwe/I1psKTbSsOox99sq3NK9Y8yJqKIma3siG/RvKZREBZivFjvw1TBQm4At0PCw8Ws8u0zS0@nongnu.org
X-Gm-Message-State: AOJu0YzHdG66Cris7Cf3bDXBs065qRL1EqPQyIBM8sytdmTN/gzIny7K
 k21EmUgKnJ7FI4cBXYoRue4WQpfGVhtJQ/K4n8+JwV/nwSJA+ivfY5v1dVjOEcU=
X-Gm-Gg: ASbGncv9V6xtPe93/+BiwFM8y9WpSQMezjvHFRQk5qss4F7buISuVDgEirvfGoqcgVe
 G/OS3hn7LDCzffc8USx+qAZKlfu4kolZNTbKsjtwbj3Ujrxl/3necJUvatRkeI07Ex3OO9BqrAS
 2QKvwMfPrCtOntho1TPWrb4AIc+NgsuiNlSUkpZPPPekls6dqgcj6LtP2wVvANmaAIpFgd0ge9H
 ej5vda+r2v5Fc2r/N5n2b48zkD6la03t9052WFhG2nngwwbULx+WEc=
X-Google-Smtp-Source: AGHT+IF8Hkb1Vaof5KCEoLv+zyYudSkf4zPuRyl6X1WONV6xoetmPxQkDBQirZ0z2GH+AXU+Bal/2w==
X-Received: by 2002:a17:907:1a4e:b0:aae:e52f:3d2b with SMTP id
 a640c23a62f3a-aaee52f3fcdmr1485220866b.28.1735491132270; 
 Sun, 29 Dec 2024 08:52:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895080sm1371875466b.47.2024.12.29.08.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 08:52:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC1B95F7C6;
 Sun, 29 Dec 2024 16:52:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,  qemu-devel@nongnu.org,  Laurent
 Vivier <laurent@vivier.eu>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v2] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
In-Reply-To: <4e51180d-9f2a-c778-13b7-5130ad4d660c@eik.bme.hu> (BALATON
 Zoltan's message of "Sun, 29 Dec 2024 16:15:35 +0100 (CET)")
References: <20241229-m68k-semihosting-v2-1-8a08b2d199a5@flygoat.com>
 <4e51180d-9f2a-c778-13b7-5130ad4d660c@eik.bme.hu>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sun, 29 Dec 2024 16:52:10 +0000
Message-ID: <87pllav3d1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Sun, 29 Dec 2024, Jiaxun Yang wrote:
>> EXCP_SEMIHOSTING can be generated by m68k class CPU with
>> HALT instruction, but it is never handled properly and cause
>> guest fall into deadlock.
>>
>> Moving EXCE_SEMIHOSTING handling code to common do_interrupt_all
>> routine to ensure it's handled for both CPU classes.
>>
>> Fixes: f161e723fdfd ("target/m68k: Perform the semihosting test during t=
ranslate")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Changes in v2:
>> - hoist both calls to do_interrupt_all (Richard)
>> - Link to v1: https://lore.kernel.org/r/20241229-m68k-semihosting-v1-1-d=
b131e2b5212@flygoat.com
>> ---
>> target/m68k/op_helper.c | 12 +++++++++---
>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
>> index 15bad5dd46518c6e86b6273d4a2b26b3b6f991de..9dd76f540b4871d3d0ab0e95=
747c85434e5d677d 100644
>> --- a/target/m68k/op_helper.c
>> +++ b/target/m68k/op_helper.c
>> @@ -202,9 +202,6 @@ static void cf_interrupt_all(CPUM68KState *env, int =
is_hw)
>>             /* Return from an exception.  */
>>             cf_rte(env);
>>             return;
>> -        case EXCP_SEMIHOSTING:
>> -            do_m68k_semihosting(env, env->dregs[0]);
>> -            return;
>>         }
>>     }
>>
>> @@ -422,6 +419,15 @@ static void m68k_interrupt_all(CPUM68KState *env, i=
nt is_hw)
>>
>> static void do_interrupt_all(CPUM68KState *env, int is_hw)
>> {
>> +    CPUState *cs =3D env_cpu(env);
>
> This could be within the if block if not needed elsewhere.
>
>> +
>> +    if (!is_hw) {
>> +        switch (cs->exception_index) {
>> +        case EXCP_SEMIHOSTING:
>> +            do_m68k_semihosting(env, env->dregs[0]);
>> +            return;
>
> Also why use switch for a single case? Why not write
>
> if (!is_hw && cs->exception_index =3D=3D EXCP_SEMIHOSTING)
>
> instead?

I'm getting confused at cs->exception_index already being looked at in
multiple places:

  -*- mode:grep; default-directory: "/home/alex/lsrc/qemu.git/target/m68k/"=
 -*-


  12 candidates:
  ./op_helper.c:200:        switch (cs->exception_index) {
  ./op_helper.c:211:    vector =3D cs->exception_index << 2;
  ./op_helper.c:217:                 ++count, m68k_exception_name(cs->excep=
tion_index),
  ./op_helper.c:266:        cpu_stw_mmuidx_ra(env, *sp, (format << 12) + (c=
s->exception_index << 2),
  ./op_helper.c:283:        switch (cs->exception_index) {
  ./op_helper.c:291:    vector =3D cs->exception_index << 2;
  ./op_helper.c:297:                 ++count, m68k_exception_name(cs->excep=
tion_index),
  ./op_helper.c:322:    switch (cs->exception_index) {

So I'm not sure splitting a case makes it easier to follow. Exceptions
are under the control of the translator - is it possible to re-factor
the code to keep the switch of all cs->exception_index cases in one
place and assert if the translator has generated one it shouldn't have?


>
> Regards,
> BALATON Zoltan
>
>> +        }
>> +    }
>>     if (m68k_feature(env, M68K_FEATURE_M68K)) {
>>         m68k_interrupt_all(env, is_hw);
>>         return;
>>
>> ---
>> base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
>> change-id: 20241229-m68k-semihosting-2c49c86d3e3c
>>
>> Best regards,
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

