Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B763AC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRyk-00012y-98; Thu, 16 Jan 2025 10:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYRyb-0000w9-ES
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:40:10 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYRyZ-0004Kl-Pf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:40:09 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso184171866b.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737042006; x=1737646806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3AOxITgAmYo0EJ9+8kN3n1FOhUqJFNOUYYSf+R25CM=;
 b=pnDcjMOhM+3Ty8ErQpiMFau3mw054QjgJYabkHWevmxQPwLoAvPfB+RisKERZ7z/Oi
 GVSbO4g+Mqhzh0E/pPd0qwWTphnIZzalFZafhvQfJSaSmQUnljtS4mr2+flV9qEWKkQ+
 AOqwyS7gxRlJ5MdbOtkmeP2Vs6XdFkq3UWZ5pgkOLjl/Y1A48i4CdXzQmm8DSgxFyBAa
 Qhyha0zpjCIMcpTsBhv1ujaXbnI1iKPP0EMWzlQ68B8I+7kSGdLkFEEDzxoWWeAeiDRv
 v0p30QQ2Ad6pYs/BeCWeKHDSL/GRijh38NLIPwiiQ27br7Ki6mQ3Fcr6nSmZEZDkB46u
 YHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042006; x=1737646806;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q3AOxITgAmYo0EJ9+8kN3n1FOhUqJFNOUYYSf+R25CM=;
 b=kA366NXmQRkqmPpghaZ9+gyjL7cHuNp1gPOUJFswoDNixkVVhknR4v8ghqrdyXsndE
 /6/+8+Qt0qojjj8krde477sTvZ7rJdDXqbMDuHW4GFyv7adxqvIRlN70TS4EmVzSGUqq
 hU/G5SU8JZdWB0WB7pqSQyHBDHaln/7ns0pry+ZBIMUKcDoEM86+lZQwDj6RI3hqNKv1
 WZW1D6K8VoArurC59i7rott4SzSPSX4HaBroClS13Hpn0UO78bUKLjSwneb3Em20Te4S
 KNi5xqnAP8a+Iv+jCXDNy6bIGAQ3ETiI8iu8W2z1onaVCFgovqkl6cy5FvzzMrG67Evl
 Gxxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeEeUo3vPYBphRaiM0t501VTpSOhFT70Ore9n9SErFPU0p1ykVVyZ87DlAuoQAxTRHWubitHYtUY2K@nongnu.org
X-Gm-Message-State: AOJu0YzOROrYMGM0phfQqJ87Its/BPmdEMLMvHg3o0dspj6d4m4yuYU+
 kM6tyXuc1lbuwtebWdOEGnDK4OUxadZtoeaCWcZ82gDyxN85xt6EWv0NIz7uEB0=
X-Gm-Gg: ASbGncsKiA8GO5ZM2Y2Km3yepABwjoO59Y9Z1nN2nX7zcV1YqsSkxZng3L/3fBU5PAX
 sGh40fHP3yjVJOc4cbiKN43PRqgKOZB3WOOBcnOt1GhA7ItCpxL+473BycW0lE3BTraJ1YQh9Yq
 g7qNwVCT4oBQHzZ/1zVLK4XZ8tWr3xcke8AmU46aCws8RY/yXRWeKZgjYfzFc0j+h8MSJy/hlkG
 ug07yPRFddT4KkkkIfCP0OCcX5jZd4Y5TmBRYS0P1Jd+p8uA5Q0yDM=
X-Google-Smtp-Source: AGHT+IELfjUFXl90VigTkPISo9Yu8ov56chPzBy9ac2C7Z3KeqTyMh2d6W/f0Pw0SL5Y8hWQQfHPBA==
X-Received: by 2002:a17:907:8686:b0:aa6:7220:f12f with SMTP id
 a640c23a62f3a-ab2ab70a733mr3037192666b.18.1737042005909; 
 Thu, 16 Jan 2025 07:40:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8442esm10214166b.129.2025.01.16.07.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 07:40:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 959DD60812;
 Thu, 16 Jan 2025 15:40:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
In-Reply-To: <e344e8da-8460-42da-850d-79623daffa06@linaro.org> (Richard
 Henderson's message of "Thu, 16 Jan 2025 07:17:31 -0800")
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
 <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
 <e344e8da-8460-42da-850d-79623daffa06@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 16 Jan 2025 15:40:04 +0000
Message-ID: <87sepihinf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/16/25 07:06, Ilya Leoshkevich wrote:
>> On Thu, 2025-01-16 at 06:54 -0800, Richard Henderson wrote:
>>> On 1/15/25 15:20, Ilya Leoshkevich wrote:
>>>> Currently single-insn TBs created from I/O memory are not added to
>>>> region_trees. Therefore, when they generate exceptions, they are
>>>> not
>>>> handled by cpu_restore_state_from_tb(). For x86 this is not a
>>>> problem,
>>>> because x86_restore_state_to_opc() only restores pc and cc, which
>>>> are
>>>> already correct. However, on several other architectures,
>>>> restore_state_to_opc() restores more registers, and guests can
>>>> notice
>>>> incorrect values.
>>>>
>>>> Fix by always calling tcg_tb_insert(). This may increase the size
>>>> of
>>>> region_trees, but tcg_region_reset_all() clears it once
>>>> code_gen_buffer
>>>> fills up, so it will not grow uncontrollably.
>>>>
>>>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> ---
>>>>  =C2=A0 accel/tcg/translate-all.c | 16 ++++++++--------
>>>>  =C2=A0 1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>>> index 453eb20ec95..6333302813e 100644
>>>> --- a/accel/tcg/translate-all.c
>>>> +++ b/accel/tcg/translate-all.c
>>>> @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tb_reset_jump(=
tb, 1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>    +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Insert TB into the corresponding region tr=
ee before
>>>> publishing it
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * through QHT. Otherwise rewinding happened =
in the TB might
>>>> fail to
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * lookup itself using host PC.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 tcg_tb_insert(tb);
>>>
>>> I think what we need is to mark the tb CF_INVALID before inserting
>>> it. That way we'll
>>> never match in tb_lookup (comparing guest state, including cflags),
>>> but *will* find it in
>>> tcg_tb_lookup (comparing host_pc).
>>>
>>>
>>> r~
>> How can tb_lookup() find it? With this change, it is inserted into
>> region_trees, but not into tb_ctx.htable - this is done by
>> tb_link_page(), which is not called. And because it's not in
>> tb_ctx.htable, it can't end up in tb_jmp_cache either.
>
> You're absolutely right.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It would still be nice to update the docstrings on the two lookup
functions to make it clear what they are for though.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

