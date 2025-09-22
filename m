Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F2ACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ftl-0003vH-DN; Mon, 22 Sep 2025 08:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0ftF-0003Uc-13
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:43:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0ftA-00072M-EZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:43:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so2710377f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758545005; x=1759149805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+AQRU5D6V12P4jEQ1/5rEpDjVxKlca8uQBKv4v8I4E=;
 b=roqbcAroqGT3fGZO9fV6v5yh1Ii8et6rPoQMz0qpCm38ZETNwsgl24GQ8MgDQBJ+a/
 TGqUqidRUBUgZ47GHJk+QI7QQ7O9jz1t4t5ijOJgvNFGelLY6iSmmlyupsE/Hrc/1Bm3
 FpschiQ4ZU5NL2fV+gLkAZgN2oz/upzUw/dmBswcVQVbkJk9FDaGyLQkw85zRI10rwA6
 wB4oB00fHjZCdwpL+zPoiMQYN7fbuG0DCVj6wmsGbFom+sX8Lql4Cxwy4c4m+SXz/u+d
 IHD33Kdf7T11BmP7v9BEpZEjhNd4GT49rgwO3FSh2p+bZ1iLaaKj8aCrAwgzWzOFbXRv
 /JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545005; x=1759149805;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+AQRU5D6V12P4jEQ1/5rEpDjVxKlca8uQBKv4v8I4E=;
 b=UzBZ2479Vs47XhmyM7inr9rxCeHeSsvrPE35rbiivLVPQgvK1FhpPDytav26vbv8aE
 PeDsEyiRKsPo7FD2Lu+gxmWzssBQ+GRyqebwGem9UhJdW7MmzjDPbONlK3nsIAOeHgyZ
 J2b8iauHiEBcTkJDuoJBqUxotHUiFYQSWrPyrQa/M+C1hVdO3gzRnPXLZH6Pgx8p/3se
 zjOXAKZtwlKXwGhpDHp5m5nbhW10cKAB2abrAu2VnqhRcvy4dUkUiExugkfhTMxprCvV
 scOHQuW8JM7GnawL+kuRFTirvADkFs5f6Ebu/MxK6FVDkOeVuVyOkcHSR+6j6USHJbvD
 IUYg==
X-Gm-Message-State: AOJu0YzqRhASrTKjrvrr0x0OkwAQYGXJsfPcZqO1UX7FwXCly78si0+T
 n38BweB0wEqJyhYFnqDfpYitJ57W/RAAt3TScKhgXaJVWgfNipT6pdsw96zky2JQGkM=
X-Gm-Gg: ASbGncvuLCSx2V7u5+E7/dQTOy2oLRTS4aAwXAftrHtTtDLm7XJlpdzapxWZj9onvD5
 ucewJCw63UkMlBKEj+bpga/DAtIOMWXaxzUAtktTyQNUJC0Ix7JdH0xGGdXPDBgycCmQky0lBGv
 1CzsnAQ1B4k6r3j3wAVN/Rg3K2X0SY9+TCk15Ty5Aj0i4sfj8YWbDBpN7Pm4JuVCd4IC8tu9waJ
 97ShBR3/NKht4T4H8S/i+yP3WHPTrOqG+MS7KdVFhF95Hk7sx1jz5s+/7za6wH4cpcET1yEMYib
 igPpxJQWtaGkXybV8koTQDOBa5QEhv84t8PYA9Yn3qR6HUCtBe0nuFuYbalOdA2hP46VMAELdGX
 9js3e7tmLCgmGrSNAY8Wr6aPMDuFY6xAmeQ==
X-Google-Smtp-Source: AGHT+IGQR2xdxGcXqBlgPnaB7JWL9i+RW4RsClC3SkqmkHr3AnnY9UQv11HUhmWWvNdssr/MZqPpyA==
X-Received: by 2002:a05:6000:2509:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-3ee7c55298emr11459511f8f.7.1758545005430; 
 Mon, 22 Sep 2025 05:43:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm14335469f8f.56.2025.09.22.05.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:43:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F2035F7C4;
 Mon, 22 Sep 2025 13:43:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Palmer Dabbelt <palmer@dabbelt.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-riscv@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Alistair Francis
 <alistair.francis@wdc.com>,  qemu-arm@nongnu.org,  Weiwei Li
 <liwei1518@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 12/25] semihosting/arm-compat-semi: replace target_ulong
 with vaddr
In-Reply-To: <935cfb4b-1990-4ca8-91a2-b9b96b503c42@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 22 Sep 2025 13:53:26
 +0200")
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
 <20250922093711.2768983-13-alex.bennee@linaro.org>
 <935cfb4b-1990-4ca8-91a2-b9b96b503c42@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 13:43:23 +0100
Message-ID: <87ldm6odxw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 22/9/25 11:36, Alex Benn=C3=A9e wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Message-ID: <20250822150058.18692-10-pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   semihosting/arm-compat-semi.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>> diff --git a/semihosting/arm-compat-semi.c
>> b/semihosting/arm-compat-semi.c
>> index 6725dcf4ba7..29cdab66f73 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -123,7 +123,7 @@ static GuestFD console_out_gf;
>>    */
>>     typedef struct LayoutInfo {
>> -    target_ulong rambase;
>> +    vaddr rambase;
>
> This is what the subject describes. Most of the other changes aren't.

I was going to say vaddr is functionally a uint64_t but we actually made
it a uintptr_t in February. Shall I update to:

  semihosting/arm-compat-semi: replace target_ulong

  Replace with vaddr or uint64_t where appropriate

?
>
>>       size_t ramsize;
>>       hwaddr heapbase;
>>       hwaddr heaplimit;
>> @@ -214,7 +214,7 @@ static LayoutInfo common_semi_find_bases(CPUState *c=
s)
>>    * global, and we assume that the guest takes care of avoiding any rac=
es.
>>    */
>>   #ifndef CONFIG_USER_ONLY
>> -static target_ulong syscall_err;
>> +static uint64_t syscall_err;
>>     #include "semihosting/uaccess.h"
>>   #endif
>> @@ -260,8 +260,8 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t=
 ret, int err)
>>   {
>>       /* Recover the original length from the third argument. */
>>       CPUArchState *env G_GNUC_UNUSED =3D cpu_env(cs);
>> -    target_ulong args =3D common_semi_arg(cs, 1);
>> -    target_ulong arg2;
>> +    uint64_t args =3D common_semi_arg(cs, 1);
>> +    uint64_t arg2;
>>       GET_ARG(2);
>>         if (err) {
>> @@ -300,9 +300,9 @@ static void common_semi_seek_cb(CPUState *cs, uint64=
_t ret, int err)
>>    * is defined by GDB's remote protocol and is not target-specific.)
>>    * We put this on the guest's stack just below SP.
>>    */
>> -static target_ulong common_semi_flen_buf(CPUState *cs)
>> +static uint64_t common_semi_flen_buf(CPUState *cs)
>>   {
>> -    target_ulong sp =3D common_semi_stack_bottom(cs);
>> +    vaddr sp =3D common_semi_stack_bottom(cs);
>>       return sp - 64;
>>   }
>>   @@ -389,9 +389,9 @@ void semihosting_arm_compatible_init(void)
>>   void do_common_semihosting(CPUState *cs)
>>   {
>>       CPUArchState *env =3D cpu_env(cs);
>> -    target_ulong args;
>> -    target_ulong arg0, arg1, arg2, arg3;
>> -    target_ulong ul_ret;
>> +    uint64_t args;
>> +    uint64_t arg0, arg1, arg2, arg3;
>> +    uint64_t ul_ret;
>>       char * s;
>>       int nr;
>>       int64_t elapsed;
>> @@ -462,7 +462,7 @@ void do_common_semihosting(CPUState *cs)
>>         case TARGET_SYS_WRITEC:
>>           /*
>> -         * FIXME: the byte to be written is in a target_ulong slot,
>> +         * FIXME: the byte to be written is in a uint64_t slot,
>>            * which means this is wrong for a big-endian guest.
>>            */
>>           semihost_sys_write_gf(cs, common_semi_dead_cb,
>> @@ -688,7 +688,7 @@ void do_common_semihosting(CPUState *cs)
>>         case TARGET_SYS_HEAPINFO:
>>           {
>> -            target_ulong retvals[4];
>> +            uint64_t retvals[4];
>>               int i;
>>   #ifdef CONFIG_USER_ONLY
>>               TaskState *ts =3D get_task_state(cs);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

