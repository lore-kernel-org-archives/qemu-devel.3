Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375E2E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 02:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOAd-0001or-Tl; Thu, 05 Dec 2024 21:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOAb-0001oC-Uh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:34:17 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOAZ-0000iI-RN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 21:34:17 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea5f158138so464097b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 18:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733452454; x=1734057254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DdVCpbnp8Jy1Agb4lnXkLcMMusYALlOyzv+oIkXH4Oo=;
 b=oQm6An7iY+xz72Z0ZqwzxZ5jgJnzU6pAwhg0pzfjhpKH5xTvhIpOMjtxaFQ0QwDiem
 8JPeUliJfOWk0VteNIfT691xeCsb7M1KDWaKNRBRzPpJMrH9FDKvi3ihTWhDl88tXyCa
 a71m6zVJD1L6IuBQFO4T27myctfIDHiEnu4TUZT5S5VveotSihYWuLZumm3VXRjCVuS0
 MVaobhITOk4Q+aZRwLIZ4Ow3DlRnpTljsiY6k9Ih1Oa2ZmaVlz66Hqmg/GwEVR2E99pv
 eJLdEYWlyPdTBfb+nnxrII27G441CF7jirGB0wqK2DhedghhrY3NUby+fMpSqiXtiFSy
 Qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452454; x=1734057254;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DdVCpbnp8Jy1Agb4lnXkLcMMusYALlOyzv+oIkXH4Oo=;
 b=bT/2Uvg8QqSKZt139Id6mWS4u5RaE/NVjcgDeAkx3ywFkOyPfHQ7E8gm/QU4v3l9HN
 cKryXFxUtgF1LF8WUekKYCw4rtZtKoOHgcOlgLvKp3zM3JH771kh4yT4imYzdLiNcndy
 EgpbULsKPfpBbuXWk8G/uGc8W958VbkJZUiR6kMlX2eRzGFZlZ+jk/a4NUrcWVr/mt1c
 n/Qh/8pu00ALWU8kn9o4cr/q/2y6anesxse42UGgY6JAl7gOSgjJLXv6ix45Y9ZBdyCn
 jQWMuf5F7GcVykc0r+gb+toYsVYPj6OIAQnzwY2jZQvVtHTONzhrti3g3SOmRDlXx0OI
 lVYw==
X-Gm-Message-State: AOJu0YwxyWpNvHZJhSM1RbVZUPM5zy60TQqMBpbnJRkjJBDg3HwXKvg+
 cFHzjF9kMURKwMVFSV1q5Pw0l2r6k/Qfpd+WxEtM2G+bbMemZE1sOgYXb0MFSRk=
X-Gm-Gg: ASbGncvvM2Q5Iy0Zd1a0yZ8GLzA+/32FUJajHyNR5tcumfmfHKYJr42/l2HBO5xMGK6
 Mx4ZhK/ScqCYsOQJPFjpjyqi+VbOdkzmh8HQGK3aSFKSxXvfYhFxMX0jkq46XIr7fP385alxXwW
 tThOiJCJ1aNHp6KYHkL43rE4GobLUMBmpGVbA4FserSy8/tlVL3MdqkwxlyXZPvfFtHrREfyo+D
 9N1sx52J+RoOvxHdNn3XOt0w7i3VbpjGApaTBpgRz92kGLS6zJWT2y9VExgN5cw98KUy5Myn0jq
 4B0DqXSRSdWx2lsXY1WxduN/AYNR
X-Google-Smtp-Source: AGHT+IF1fCQfAzS6e+ADoTuYO07qxp/hZI1a8ePvNoJXA5Is3cNkr+iLETo/fQAgu0wNOgwoMzlUzg==
X-Received: by 2002:a05:6830:6217:b0:717:f701:4842 with SMTP id
 46e09a7af769-71dcf5530b0mr749589a34.28.1733452454032; 
 Thu, 05 Dec 2024 18:34:14 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f27930470fsm542553eaf.27.2024.12.05.18.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 18:34:13 -0800 (PST)
Message-ID: <39e6a66d-6c38-4ca5-a864-1a672a42456f@linaro.org>
Date: Thu, 5 Dec 2024 20:34:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/67] target/arm: Convert FMOV, FABS, FNEG (scalar) to
 decodetree
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-24-richard.henderson@linaro.org>
 <CAFEAcA9ECxgGvsSuw+GGsj4h2reKs9bVRSG=TD0oHPh519m7yA@mail.gmail.com>
 <4b1b91c2-80c2-4ed1-b313-a2e9ebba4049@linaro.org>
Content-Language: en-US
In-Reply-To: <4b1b91c2-80c2-4ed1-b313-a2e9ebba4049@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/5/24 19:52, Richard Henderson wrote:
> On 12/5/24 15:12, Peter Maydell wrote:
>>> @@ -8295,15 +8356,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int 
>>> rd, int rn)
>>>       TCGv_i32 tcg_res = tcg_temp_new_i32();
>>>
>>>       switch (opcode) {
>>> -    case 0x0: /* FMOV */
>>> -        tcg_gen_mov_i32(tcg_res, tcg_op);
>>> -        break;
>>> -    case 0x1: /* FABS */
>>> -        gen_vfp_absh(tcg_res, tcg_op);
>>> -        break;
>>> -    case 0x2: /* FNEG */
>>> -        gen_vfp_negh(tcg_res, tcg_op);
>>> -        break;
>>>       case 0x3: /* FSQRT */
>>>           fpst = fpstatus_ptr(FPST_FPCR_F16);
>>>           gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
>>> @@ -8331,6 +8383,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int 
>>> rd, int rn)
>>>           gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
>>>           break;
>>>       default:
>>> +    case 0x0: /* FMOV */
>>> +    case 0x1: /* FABS */
>>> +    case 0x2: /* FNEG */
>>>           g_assert_not_reached();
>>>       }
>>>
>>
>> In these changes to the "handle this op" functions we make the
>> function assert if it's passed an op we've converted. But shouldn't
>> there also be a change which makes the calling function disas_fp_1src()
>> call unallocated_encoding() for the ops ?
> 
> Yes.  I missed that because the line is
> 
>      case 0x0 ... 0x3:
> 
> without the usual set of comments.

The next two patches have the same problem.  All fixed now.

r~

