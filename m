Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B5D10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXhi-0001jT-L6; Wed, 08 Apr 2026 14:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAXhg-0001dm-Vp
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:41 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAPfI-0004bS-2E
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:57:41 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64edf260b49so1325624d50.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 02:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775642258; cv=none;
 d=google.com; s=arc-20240605;
 b=HgXlFY8ncShcIyTieyzohs7N/bk+5eYg3/2LAwSdpCxyQWLNLgPTCUn72VoC2+qBWA
 OlJUfW+uD99C9iMEiHKTllpw8EYsWESfG5CCrSL15rqLHkBVuVIslDuA429vPe3YXqpe
 HFBK/sDPOHZ1UgRiGMBXdgZAEfVC3+tDiciBZOIAvhNEQEqBmCFnFq0xaJOVDqjZr1VR
 otg3gp0m2B3Er3K0BUIGhhH//xJIVDxD3FHPZV5ng7Ld/xSGvoFHOi/mfxhdLvZY/C20
 G2D99uh+XWeTeWMlAhQ/utMOz19twKo5L3tVBnE5cimp7mzi8aF9kWzL1sgnwQrxpcLM
 gs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wTD4ToS5hyVfquW3+9Z9ksu2E6XruAKTXd11VgdlD1k=;
 fh=EAwS+xaAAdFCR/1JaTBHTxHClDI4cGX6QnJt5dVLtTE=;
 b=jCBNNM+o6y/qF1+iNCgNHlion7jJjsakgS4F77pZk7rt6qN+gF6i66eJ1q0y0QlOBr
 9UhOJO19snWyKCoegtXzLHkhGxefJZQccOfLblPLg+3tqTc5hN4SlPvTq7upBHSZFMkA
 SgJ70UyYhAn+xfnyS4A2sWvk3bawFFDMf1fVArdDBlJwkSI0gTenzT/LNH1Sd28peEEA
 qR9Z9LQPsskOYoaKQpbdJne85STkLh+B0dseeFlt96dGVnVYK7maVqtMuI4HMINva5/Y
 fybJP0e3XRMMFZ7To8IjaiTT4p0fmhkzTp45TIwLL1t3ZSowfkdfI5pTHT4OT3jaQ21s
 iRvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775642258; x=1776247058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTD4ToS5hyVfquW3+9Z9ksu2E6XruAKTXd11VgdlD1k=;
 b=LkNJcq5vodJAUTh5K9czwAjteu5Bah0t+fuQR+PJcro+H43SdtHr+XFlpF37pI/9LT
 BDOgVWUc7KRtGvvg+4Pm202mRZkmU108AC1qXHUli6acZeC9c66Iqularbf1i6N2QR/M
 kE732vaZBeaTO8Elvz+vTQSCK3OU794rrfwF+sb+l7y8iUubWedikD8AyGv9Y3KKzliQ
 6FVFjanGnqbbT14OlcLvJrCVgGj/DET1+6alGhp1SOhwtygBqd1GDjSvXA7jQ4IB5qWT
 Tbl04u0qzMkRdOXfMto++Y1vK7Dpqkq6eo5oydOKVgGNMNhfDT3QFEI9qARLQb5Ng8yS
 sZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775642258; x=1776247058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wTD4ToS5hyVfquW3+9Z9ksu2E6XruAKTXd11VgdlD1k=;
 b=ftpZIhp7F+1KcQFu2XuIHPjvhOuwW2k1Iop4gzuq79CdOGzWSfbSn5g+iXFdCQ2qGr
 jifxs8x5zHK1f9v3sTDq0BkaVihIEixpj13IsXtK0HhyhuAejNiZpB0U/rzmABqMJpGX
 ZtDiILmq1BnYaWv+CM3NrKBi2B+Sx7LodFROhNjtzXuekkoUYpHojOvFAx/3Qil2DoZq
 qaZJvgmIIoWZg1IPorbXwSq2BDr/onyd74/M8bmaCfaHRTY56gLm923Auyb8kxqml0vd
 2mak1+1TAULTOIPyunD5OXnuNY7hc1iDx9SkcbVMjmOI24JMvbPPrg4Hp1CwbZ4SQ1PL
 l1YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgovSMGDWq+oQxAYW1CnwrqDEB3A0bvi/VYmMNl1zfqDlzQVGVuBxvmhdbKZ/q4rFPCNcIaTKwU0g@nongnu.org
X-Gm-Message-State: AOJu0Ywp0hEY9ERlOHHucHh+3BqqI8X/b7l/SObvXbhXIgkAp7LxtB4u
 pXytKFOqLulFqcFuz6TTSuxnile75XcS+k8VyduyrQy3DYXHTw0WMD/H704TbnXnjQS8mzRGJdL
 XP/uCEWxRAxZmDBfiFL1Atoj+9uYWImuW5QHZIo1KIA==
X-Gm-Gg: AeBDietWEv7RJiIpQPmawiWiMeU9vgtnTMSf7IJhIX6lfgAfPxYUeZT20fWJXENO3+x
 xvYnUgJgzaREdLA5cOqfvSRNtegTYGhzjHvp9k9lQdsNC/eogGWrKAYYUImM2neAXtTqRjsEiYI
 GFA0ezufAiTB5AoofxW9nu15trGGOi39LLC0NV0Ar0eE2Gb+Al/ySUPGYI4twp64g9eNkuF6LfI
 bYzOxfmKQy6pStlq5dICFCJGKe9qY3BMq6sru/Zq6B7HPyvzqCr72j/boaEl4Ya77diBiFp5TvP
 ItFf/tQSyounFnGqVNfJyHdnD1E+gcFO6Dj+9DZx+9p0doPucX2H/iu1x/YYF/5cZzA=
X-Received: by 2002:a05:690e:150c:b0:64e:ef3b:3bd8 with SMTP id
 956f58d0204a3-6503d84be01mr15898001d50.25.1775642258406; Wed, 08 Apr 2026
 02:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-28-alex.bennee@linaro.org>
 <0877e0da-c083-4293-bba2-5c1d2e2315b7@linaro.org>
 <87zf3fawif.fsf@draig.linaro.org>
In-Reply-To: <87zf3fawif.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2026 10:57:26 +0100
X-Gm-Features: AQROBzDEAVdEWYY7h1giqhQw3ug2LdaywwR2lLIGF-1lAJdmaHxA_Kvk6X5jBEw
Message-ID: <CAFEAcA_chK44yu1R6j2gw+Q6S8CbJUnJS6aD-uk7eXeQH-on0A@mail.gmail.com>
Subject: Re: [RFC PATCH 27/35] target/arm: wrap event_register in a union
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 7 Apr 2026 at 20:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 3/21/26 00:05, Alex Benn=C3=A9e wrote:
> >> While the event register is either set or not due to the
> >> implementation defined nature of bool types we can't set it directly
> >> from TCG code. By wrapping in a union we can alias a 32 bit value to
> >> the bool in a future patch.
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>   target/arm/cpu.h           | 9 +++++++--
> >>   hw/intc/armv7m_nvic.c      | 2 +-
> >>   target/arm/machine.c       | 4 ++--
> >>   target/arm/tcg/m_helper.c  | 4 ++--
> >>   target/arm/tcg/op_helper.c | 6 +++---
> >>   5 files changed, 15 insertions(+), 10 deletions(-)
> >> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >> index bf6cf74c2e1..9c25b60ae83 100644
> >> --- a/target/arm/cpu.h
> >> +++ b/target/arm/cpu.h
> >> @@ -763,9 +763,14 @@ typedef struct CPUArchState {
> >>       /*
> >>        * The event register is shared by all ARM profiles (A/R/M),
> >>        * so it is stored in the top-level CPU state.
> >> -     * WFE/SEV handling is currently implemented only for M-profile.
> >> +     *
> >> +     * It is treated as a boolean but we need the union so we can set
> >> +     * it from TCG.
> >>        */
> >> -    bool event_register;
> >> +    union {
> >> +        bool as_bool;
> >> +        uint32_t as_uint32;
> >> +    } event_register;
> >
> > What are you attempting here?  This smells like a big-endian bug.
> >
> > TCG is certainly capable of storing to a bool, via tcg_gen_st8_*.
>
> So the problem I had was I don't know what size bool will be as its up
> to each architecture to define the size. I originally had a compile time
> assert but that failed. Hence this hack to put something that would
> plausibly overlap.

If we need to write to it from TCG and we can't just write to a bool,
then we should make this a uint8_t or whatever, rather than messing
about with unions.

-- PMM

