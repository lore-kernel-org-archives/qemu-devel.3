Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427C3C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYS0Z-0002LR-DR; Thu, 16 Jan 2025 10:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYS0X-0002Kr-4F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:42:09 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYS0V-0004ju-I7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:42:08 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so2014359276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737042126; x=1737646926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvQeqEG8VZJod7tJnAfpPn3/4Mgp2ixpJMfd3pe8+w8=;
 b=xVTpIZ7HSlSxpSVVbWC87smXquJV+Zd4OWFrkKHUFLyJDIHmNJ9Zgks6XE+I1mS71v
 DAOvTOKgQqJFwnOePjyIodJm04yJmxmU/jzVj6orzrHCBOybdsXP1uL6NZr2clZ+NxEI
 AgHs1fayZUpnb3Fhb1jzl7wz1bHizTuyCrTjxiuuTqhlEUjorukB5E50hRu6Ze1C4BbK
 mi/3p8PQd5/lfmYASNzNnXIi4+Oi/aBDF8mtZY+cwlJ+fizvmGf9lMki2xqwlViELvnD
 tU18Xa5PlBjH72u/S59MPERnLAQEYRDz8ISV6nzvkyY9HAfqLbEsHM88SdaOYowkaXTR
 lFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042126; x=1737646926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvQeqEG8VZJod7tJnAfpPn3/4Mgp2ixpJMfd3pe8+w8=;
 b=wGZq2TXAeokM61Oc1W8heqwI8Weahimn0ZTf5rTOoGTsrOcXZtH4fOg+31kGlf5zKR
 3TzmhVBwxHfzosppf++iJHP5oYVbI3RD6d3a7v7Bmhf5DxwToSyB1FqBO19MBMY7ZbSj
 KpS39vuw8WWBQnFpQwNR6nuSm4YwJ6ZeGg2j3oRTMaE8ZaGpCtdi6TCL0ViThJ8tTBd3
 shbgfuGBY8KDEqgOmh2CyaK93K5xIvFy8pzQ+dAGY6RaLWbd2iRbygU5xEhPvyapNC5z
 iGWy2zUBwY3IZf9/HynaUFi+KfFtaZoNLGzjFh0CaEi9LeMUGqeZfTgJQriyIvzWU58f
 DEwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk12NInngzHebb9bwTw0PQJNlKKSui77ad5RjCLO9aFDT1aoM2uMHQd5AemjPatizBvSF+dn7DWoUB@nongnu.org
X-Gm-Message-State: AOJu0Yynf4JBqPOR+4u5Mt6aWw/4dJpFxGriZfmYtMlumJsB3ccC2X45
 LYecFJC+1gkR47yU8J0ablLj5/n/ngny5ye+8HC0IN+JQgsXOSAGsLWhKyuvLuN+gli0uvAbytW
 YwDjjxSuP6hWute1OlX1becwbENhtDbWSdGi5vg==
X-Gm-Gg: ASbGncvaSgsf9fPwuae+z5D+THDJ/EarGiEvHp+SpVMkqSznzgMQ8qFSceKlpkRUlWQ
 WPtaPkCmSsqj0/Sljn8gWhmc7LUvpOXxME+WyLjI=
X-Google-Smtp-Source: AGHT+IF3Dcvv0O45wuPGTXtw3yOD3o1QgNIcz6LKXXoVC2TovKiN/VOUjYlSn2Y6J3ExQmGK77QPu9Z6iXwnHHohfFM=
X-Received: by 2002:a05:690c:4b12:b0:6f6:8b81:4cb4 with SMTP id
 00721157ae682-6f68b815131mr165420637b3.31.1737042126509; Thu, 16 Jan 2025
 07:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
 <5bd1b396d06a3ab42a98cdff25a1dc2051e98b0b.camel@linux.ibm.com>
 <e344e8da-8460-42da-850d-79623daffa06@linaro.org>
 <87sepihinf.fsf@draig.linaro.org>
In-Reply-To: <87sepihinf.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 15:41:55 +0000
X-Gm-Features: AbW1kva2yAa6xABvwZ7SnKlj2m3V3q79X0iNI2R_X6XsY-9KwquoaSOATelDyjs
Message-ID: <CAFEAcA9zpD6oO6fU-yq+MsSj-WGh5p7Zvaz=VtdvCykrzJW+ww@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 16 Jan 2025 at 15:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 1/16/25 07:06, Ilya Leoshkevich wrote:
> >> On Thu, 2025-01-16 at 06:54 -0800, Richard Henderson wrote:
> >>> On 1/15/25 15:20, Ilya Leoshkevich wrote:
> >>>> Currently single-insn TBs created from I/O memory are not added to
> >>>> region_trees. Therefore, when they generate exceptions, they are
> >>>> not
> >>>> handled by cpu_restore_state_from_tb(). For x86 this is not a
> >>>> problem,
> >>>> because x86_restore_state_to_opc() only restores pc and cc, which
> >>>> are
> >>>> already correct. However, on several other architectures,
> >>>> restore_state_to_opc() restores more registers, and guests can
> >>>> notice
> >>>> incorrect values.
> >>>>
> >>>> Fix by always calling tcg_tb_insert(). This may increase the size
> >>>> of
> >>>> region_trees, but tcg_region_reset_all() clears it once
> >>>> code_gen_buffer
> >>>> fills up, so it will not grow uncontrollably.
> >>>>
> >>>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> >>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >>>> ---
> >>>>    accel/tcg/translate-all.c | 16 ++++++++--------
> >>>>    1 file changed, 8 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> >>>> index 453eb20ec95..6333302813e 100644
> >>>> --- a/accel/tcg/translate-all.c
> >>>> +++ b/accel/tcg/translate-all.c
> >>>> @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
> >>>>            tb_reset_jump(tb, 1);
> >>>>        }
> >>>>    +    /*
> >>>> +     * Insert TB into the corresponding region tree before
> >>>> publishing it
> >>>> +     * through QHT. Otherwise rewinding happened in the TB might
> >>>> fail to
> >>>> +     * lookup itself using host PC.
> >>>> +     */
> >>>> +    tcg_tb_insert(tb);
> >>>
> >>> I think what we need is to mark the tb CF_INVALID before inserting
> >>> it. That way we'll
> >>> never match in tb_lookup (comparing guest state, including cflags),
> >>> but *will* find it in
> >>> tcg_tb_lookup (comparing host_pc).
> >>>
> >>>
> >>> r~
> >> How can tb_lookup() find it? With this change, it is inserted into
> >> region_trees, but not into tb_ctx.htable - this is done by
> >> tb_link_page(), which is not called. And because it's not in
> >> tb_ctx.htable, it can't end up in tb_jmp_cache either.
> >
> > You're absolutely right.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> It would still be nice to update the docstrings on the two lookup
> functions to make it clear what they are for though.

Given this thread, perhaps also consider briefly mentioning some
of the details in the commit message and/or the comment?

-- PMM

