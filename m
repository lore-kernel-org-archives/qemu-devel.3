Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6093AD172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmn2Y-0002cQ-Vd; Mon, 02 Feb 2026 01:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmn2X-0002bP-4v
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:04:01 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmn2V-0008MA-JQ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:04:00 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so1943618b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 22:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770012238; x=1770617038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFw9C0gh+CkpeZ2yt/6EQtxHFhJE48A+5hD3dIpZM9U=;
 b=wIt1HPNi/lpk5T5+NWWGpkMRqloOF6b4ZoldK2E64JIy6C8t4RFEpYY6k+qta5ORiU
 l+tWf9p7HU/Lv5lkw1IZALnvnOdtX8FCEkddSz5Ray7+PbYh7dfkn4ALZK1WesYZmqRq
 Jinu33O0m7AMJEswqqo4vfNEoTKeRTs9lU3jqsfWw1Z3A4ZnFYOgdTp0TYDozD0wNBnz
 pF2cmUFxEp6frAzmEqPc3YvI2yGRj/Vi1mnafmDjc2bdHrQ1ysEeCL0qjPFwXEU1uLhj
 /kSJoJj/pmNqNUg6n1Maq6Hao/t5ez7jMK3N9A3N9PG2UmjjV1P/Atk5Xpsew3dLA9b8
 kkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770012238; x=1770617038;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFw9C0gh+CkpeZ2yt/6EQtxHFhJE48A+5hD3dIpZM9U=;
 b=ik9CQeibASW3GxO9bGUzVaXLtRXUvbFYJBeFLu+dMWRAWQr8qnspdkKY8JxkcxyVIZ
 A76Mc1gNRK5bHsZQjrKcImbhMKSwzmsuLXDrQ/+Jw4CvgikG0Ha9MB+nf+xbZVYXNcns
 6N0qOoGS+w718AM/JSD4H3JYr2HwYSUR+KTyeO6E1ePiSSKrP95qJ20en4WuZWzmrp3X
 v4tEdm8sVAUUzWK5PIRRVVtGoajdRBx/K/+nH3awY+QktYz70xj+45sJvkGQVQHeXDbx
 nUlWfbhthHJz5kfda0rpjFSqwx7euC6nDBduEwBoeqXWhdbRgNsY8Utp/UyP7xvGg7eG
 GmBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK3pTzSVXgaElAN/ypMIs0fLNgQNcLE5x5LegLu6L58VOcG4THaadqvsJ69dnnux+PLrFWjxPssxkx@nongnu.org
X-Gm-Message-State: AOJu0YzGido4kuW53UZyyTd4PkD29echbpEe2J//J+Pugm0l1ANrpCiV
 Dl6c6M3Xownnef/LCG7z6m2zTbCTv1Sx1Q91pz8ZZAnUoQ2WF4ZAtqYvoU/eD6PxnGs=
X-Gm-Gg: AZuq6aICpOGKbEAHmBIdmfcMjNjgcazLxos7HepFkfDG05m17UfP1saj53rIq4Pjx01
 egw2vd7AGHxxF/ki4MH2vI4NN5nMNQldutZ20MF32sClCWi0/zOGCYH07enhwpIk1q8y9aBll5Z
 t/NBEyEpVwW1nAl9xNKvtmUgoFsa3cKO+NdCI/HB6fjVxPnWILR35RJEJAWS0JQEOmpmRzWKxjx
 D5QNJaQtEiJegjpBW1JJAqfNlcAAu+NlOxgqp6SVjzO2KEeqXlMhrXfvlzwf7c+sheD4rcVVkDy
 Z6PgmEvDWQ82tnvRZB1tiFc5CRt8HN2xOTlz2+wLPNkkB8QQM036D3rPYDpLaY0BVUWnMnRqdpI
 iliMf7PMMOFpJ43mPwLVSSfHJLJdldkvIyhHrM6/JeFAnoSE6jSl0sSppHAxUa+J2RXt+RZ6G6t
 1JFmkLfnJDa755AMxuzube9ypBM2+Ufm/968YbYx4UAHbsbjFzepnpJyGWLvsRVVboBHGzMhO8r
 mm5JcVrqM4V3310a8XEGJdtdnQu6/wquByv58EOVA==
X-Received: by 2002:a05:6a00:140c:b0:81e:8e66:38e0 with SMTP id
 d2e1a72fcca58-823ab666cd0mr9301902b3a.20.1770012237545; 
 Sun, 01 Feb 2026 22:03:57 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfcab8sm13391062b3a.36.2026.02.01.22.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 22:03:57 -0800 (PST)
Message-ID: <55ac2c17-f92f-464d-b28f-4cd9995fb362@linaro.org>
Date: Mon, 2 Feb 2026 16:03:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-4-iii@linux.ibm.com>
 <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
 <17cd88ba-52b1-46c4-9280-977bd50ac060@linux.ibm.com>
 <e4e159f1-63f9-4486-9dcc-710675018fb1@linaro.org>
 <ac9e64f4dcf1184b1e647da8c5fbaeac@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ac9e64f4dcf1184b1e647da8c5fbaeac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/30/26 04:24, Ilya Leoshkevich wrote:
> On 2026-01-28 21:38, Richard Henderson wrote:
>> On 1/29/26 00:19, Ilya Leoshkevich wrote:
>>> With some testcases I hit this condition in parts_round_to_int_normal():
>>>
>>>      if (a->exp >= frac_size) {
>>>          /* All integral */
>>>          return false;
>>>      }
>>>
>>> which makes it a no-op.
>>>
>>> I think the code assumes that FloatParts have just been unpacked and all low fraction 
>>> bits are zero, which is not the case for quotient here.
>>>
>>>>> +        float_exception_flags = saved_flags;
>>>>> +        parts_s390_precision_round_normal(&n128, fmt);
>>>>
>>>> parts_round_to_int_normal already takes a rounding mode and frac_size.
>>>> It also returns whether or not the rounding was exact.
>>>> This appears to be trying to reinvent the wheel.
>>>
>>>
>>> Apparently I use this to paper over the above issue, which is not great.
>>>
>>> I guess improving parts_round_to_int() to work with non-zero low fraction bits would be 
>>> better.
>>>
>>> What do you think?
>>
>> Yes indeed.  I think (a->exp >= N) should be sufficient?
> 
> Seems like this does not work for really large quotients, because we still need to trim 
> the fraction bits.
> So I'm currently evaluating the following, which looks promising so far:
> 
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, 
> FloatRoundMode rmode,
>           return true;
>       }
> 
> -    if (a->exp >= frac_size) {
> -        /* All integral */
> -        return false;
> -    }
> -
>       if (N > 64 && a->exp < N - 64) {
>           /*
>            * Rounding is not in the low word -- shift lsb to bit 2,
> @@ -1133,7 +1128,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, 
> FloatRoundMode rmode,
>           frac_lsb = 1 << 2;
>       } else {
>           shift_adj = 0;
> -        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
> +        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> MIN(a->exp, frac_size);
>       }

Yep, that makes sense.

r~

