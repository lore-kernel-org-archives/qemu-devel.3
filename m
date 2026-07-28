Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02781C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokYz-00016N-8L; Tue, 28 Jul 2026 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokYt-000145-Rk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:21:47 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokYr-0002bi-04
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:21:46 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6685001353fso3616907d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255704; cv=none;
 d=google.com; s=arc-20260327;
 b=ddE55adrCfHw/ePeio0seLZwwVISTK8soju5RjwKlV3+FpR6GOxZ5XhXDVnAk6a6wf
 eu156pYLYVEPMD0b2+ETL2xVXhPSHy+KKCichbxsW0XbCKJrgXCJgHBiIg99a9+KUXQq
 +axRIYz73tJKwWHRBtLuFm6lV8d7UoRo8QdtrwgpkH8x/Qu+MS3CE/1t7glXpTidKXfF
 eQ0UFSEKIqSL87Bb/etTy4nrZeETrjL7f8lN3XUrpE0DCF2xTs63vAeEQyMn3hNDZJlF
 dLyUg9CTh46j55LITkfTFn0YRdtqUZ1r93p+rERl89eSdhYsNnqLSlmmsGEDRXSVxMLj
 rZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Aqd1xv0JpXnuqL6Y1foBBz5WTXkBaepovOrceKkx33s=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=i4ybiVilVqfEYuHJOurgYtL3B0Z6YyBFE3da1cVSdK6T3aA1943ueeJ6S6JXq7pJI8
 cDHkAJ2QC0kkTi0xwSoCiGmRF4mTcXJ60eNhFwq3PL4eqYGvCVnR+iyTOt5VHa4rdssC
 eVsxA38bEVJBY4zZEu1PNeJRyMNLfZ8aGkDP6JPNNkLQxwf2bbsWMkifN/+zeYe1PmUL
 TFaBdtyE4zrUwjgWllq3SlDrg9OTTuWWKUccQcVXYBR9vijFkLnvo1ygeDsxFF2BRY5f
 R9FU8anRiw93ahXUitA+QjIqvXSQePn3Fp9dR5+DjKlN0dSByDDGuPE5nVW15cxZ+waq
 yBxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785255704; x=1785860504; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Aqd1xv0JpXnuqL6Y1foBBz5WTXkBaepovOrceKkx33s=;
 b=qN3p2BQGUArl4TBkdIu6SYWwsB3fgGimExJO5nFKbfnUl3okMQKc8RW7l0tKLIUh0S
 6Ad29kBqB5ugnQPHuVk68kPMhoDvagsuLFwnaw3wlDxH3CGeN161PJZuaucYk4NRAQ4Z
 ebyovxjdNmmca6k5ey2abaV6Xs39B2FYulIq5NKQMY+hqxpypnupGIx502km4O0fs0mm
 MjlxV1XGNXE8G/uVDO/2mcOn/f2zu9G318YEHY9fyRrQm50gl3mz7vXcfuDoZSEYk+zR
 BH/WpmxzFAyoxQqkFW0W7vdcV5QcfJ8Wiq4VifZpUpKRDvYuJZK9W+xylygL9Glr/7Kv
 X9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255704; x=1785860504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Aqd1xv0JpXnuqL6Y1foBBz5WTXkBaepovOrceKkx33s=;
 b=TuEZQR5P4j3ELJ1X6tbRSggeMLWCQUJpco2FuWDNN7G6EUJHAa0WTgXt2qvmy1iJpk
 r7PTkrHyawnZ4F9ejPBDzyv+AVGeH2QIyeo/9Rho+cNWn/AK6g1jiAuKS6CtLe3HZO2N
 5aKCj4uQm02APlMPIfO3W97K+JMqa9uXCSLHDi1aARXnf0plQ5MC5bflC6Dn+NEntDNc
 h8+/ev/ReTJG+K742i1L2PqlSOygpwnMa8nOmxPYBm10KN+1Gt8UUqlqetwxqu6j7+dt
 cHNs5Z8aeNTbbyMTYAP/0deM2a5nQ4g18aatMFPLuIECbqJDFkxvSe3hOF6O/SMfdBPD
 uMew==
X-Gm-Message-State: AOJu0YyuUJ4PVujYIug9mXxZ67bJb7xCvI5HtNM60PMnjQXnydKnZCjW
 htDoBhLf9ftiT3vU8Qd8hiylRk4PbEbv2yaBacJ0CLHFB63d/oSO9al1m4TWf3v13J3mNjhqUA2
 mZsXTiREp6YI4QbXZOwXthsd7DSmc9JSHOSrQkwYo7Q==
X-Gm-Gg: AR+sD13Ye4foVi9qUguPzTKg2V5GYd129aX5+oHy/kqr47ERI+L20nM9N4yBlCTAQjl
 9tHaRGb0cREY/CMYEj8t7HDYhe4igxM2oXu8kZSf6FvRzyN0hi408tXuxJazpzELglIiNjijHGd
 L1ae8YFsVumZhLpqRXAgZ6gBgo2crWNX0x6X8bsjRHkFUNOSMvjJp6GtIC9Tb0JOj94L9+jyJlY
 Y6pTvvLq9A0vqzAiR0fp3r/WbuQgIXMHp3ptCabHz2Komskma0XK5cVGZhAgST0AOiVghwXfZz/
 pLF5a5OSyf6Bd8sm8QvvrgZ1j98mumQkQM/dvP9rWotffEcpy9cSx0Qe
X-Received: by 2002:a05:690e:1348:b0:667:89c0:71b1 with SMTP id
 956f58d0204a3-6690d157f04mr626466d50.31.1785255703765; Tue, 28 Jul 2026
 09:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-18-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:21:32 +0100
X-Gm-Features: AUfX_mz3qjdLeaP64rgE-JM-WVOvdXjDaJ9OsQz-YmYAJJFs0eMEyCKvhlruclM
Message-ID: <CAFEAcA_ZWK5BDPu2bUp2adoZXDcXa4mhh0qJGD2Gxikf0786cA@mail.gmail.com>
Subject: Re: [PATCH 17/20] target/arm: Implement AESEMC
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    intptr_t idx = simd_data(desc);
> +    void *vm_idx = vm + idx * 16;
> +    intptr_t s = opr_sz - 16;
> +
> +    do {
> +        intptr_t base = ROUND_DOWN(s, 4 * 16);
> +        AESState rk = *(AESState *)(vm_idx + base);
> +        do {
> +            AESState *ad = (AESState *)(vd + s);
> +            AESState *st = (AESState *)(vn + s);
> +            AESState t;
> +
> +            /* Like above: Arm AK comes first; api AK comes last */
> +            if (HOST_BIG_ENDIAN) {
> +                t.d[0] = st->d[1] ^ rk.d[1];
> +                t.d[1] = st->d[0] ^ rk.d[0];
> +                aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
> +                ad->d[0] = t.d[1];
> +                ad->d[1] = t.d[0];
> +            } else {
> +                t.v = st->v ^ rk.v;
> +                aesenc_SB_SR_MC_AK(ad, &t, &aes_zero, false);

I did wonder why the Arm ARM describes this as "AddRoundKey(), ShiftRows(),
SubBytes(), and MixColumns()" whereas our AES functions do SB, SR, MC, AK,
but the answer seems to be that SB and SR can be done in either order
and you still get the same answer. (And the ordering of AK is as per the
comments here).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

