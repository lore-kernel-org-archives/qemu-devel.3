Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53981FC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYj4-0006Kt-5E; Thu, 26 Feb 2026 05:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvYj0-0006KA-JA
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:36:06 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvYiy-0006oG-Eh
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:36:05 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b904e1cd038so89260566b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772102162; x=1772706962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+SwGcXK2mWpRhBmt4eGxbxhVXoDRpxwqXqeSoPaYHs=;
 b=h9Cy2O46gzHV+BpjAehL17AUdfNcUaBEOv6RseiXaILyJJCMbFvHmWwpSdCyC1RS5e
 ThLhEYp+Omy1eNxenMVYaOJKEOuYA4rD5gGRcVNz19qdSvQ9z0yhnbrZlqC1jtJ1zzyf
 dYtEQ5+Ak4Pu9uffjjEfhpBRyvn83otJcBEJWWiv6bVhNDZXvRNTsy6jdBOzxqYHJ1eC
 ph8A767niH5l3HLQ/6mYICxAxhaSr3Xv8Clzg1ea711r6K1GIvxt/+mL/anT+C3LGun6
 bfdiAFfkNYoxoD3DN9nnc2U9dt3YHUqqwvkxK/1q8ZKEN2efBU9M+RR89oSKZN8DFMoD
 YIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772102162; x=1772706962;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+SwGcXK2mWpRhBmt4eGxbxhVXoDRpxwqXqeSoPaYHs=;
 b=Zti5cLpmWAF8+vtXwN4K+56LFzZ02EAYEMp5cMHiQKmPybBof6p8vvPCUbG7iVTY9F
 veJk6hVvu1Jl/qqeqnt7W94gwNTytl5SMqGq8QJpNga30FgxOEym+hGfOGScO6Q7+e/l
 SOY1nXAH2eBj4Vq877EqLogLib34M3uHuVM+90hSsTdM8qSd65ohR+L+0GwATAtc3hg3
 30nzLx2E5OU7W0c/zl3Z8QVyfitGnY9MXtWG5iYn5C6wpwzQetxMY4jEW2gW62o5Kvw0
 BHhhzXoejzr2qgGNskPSVC3+h6aslzCqfqzF1ed4ZSntUOFGM0z3sv/7PsUBGB+B+fos
 K5ig==
X-Gm-Message-State: AOJu0YzRNhnjztgOhER1o+VG/jsCCTbLinGEkkmKEGPAPHk+kFKVKT/w
 Jo9t8NEkT2krFK9tYsZmBVtR3egcr92iO9ue3Ax/aBJ+o4BMxn+FXydBZITgvKInKPQmP7mmfjk
 SKbVZ
X-Gm-Gg: ATEYQzzMPtX0RC1LNSsnUjdYQR641rgqXMmv0VW9MMOVui9rm7/JQsvlrX0VA7mT9jZ
 OTCK2gjzFt9gFiUEM/2NkA0CyYSci59Zvq3iSOZ1WMiytKgOOhTrWu1OfFRIoOP4qUhsdYJ2wFO
 p19HvRtxlWur4tqF2OHv0JzC+TbCUXI7zyLZHgafvfnM9Sbw0CkhXdmPVKpwrLyg1uKg5aS6kRF
 iC8CTEbt5iXnExFuaa4YV9GClMWApv5MTDIWwyC/bx5TzpYnRbPr6Up/7QNNjmV1GbBFVihyorv
 FvNqCBAtj63MiYoUT31p3BlkI4MhHwtUqVDwbLI3UWx7wrb9J4JRu17IkklLt25O7scEXbnDxfd
 t8mNVNa4WvRmEN6mnTYOILaBaPRGXtfeYf1tqCRqd8X4KGmfJPndXVymulSEoiaXaeaTFbiLtzT
 SFv12Pj1M/1yz2gOdTs2Ay7RM=
X-Received: by 2002:a17:907:1b1b:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b9351494c43mr209320766b.8.1772102162535; 
 Thu, 26 Feb 2026 02:36:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ac5138bsm45776566b.15.2026.02.26.02.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 02:36:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21B1A5F7C6;
 Thu, 26 Feb 2026 10:36:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: use FIELD_DP32 instead of open-coding
 syn_wfx
In-Reply-To: <CAFEAcA8BX-YdALLhyYB_mDOycnUaLQ_abmSyK3VcPNQz9E3imA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 26 Feb 2026 10:19:31 +0000")
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-3-alex.bennee@linaro.org>
 <CAFEAcA8BX-YdALLhyYB_mDOycnUaLQ_abmSyK3VcPNQz9E3imA@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 26 Feb 2026 10:36:01 +0000
Message-ID: <87ldgfzt9q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> We can use the registerfields API to safely set the individual fields
>> and avoid open coding magic numbers. The EC and IL fields are still
>> driven by defines but we could convert them later.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>> +FIELD(WFX_ISS, TI, 0, 2)
>> +FIELD(WFX_ISS, RV, 14, 1)
>> +FIELD(WFX_ISS, RN, 15, 5)
>> +FIELD(WFX_ISS, COND, 20, 4)
>> +FIELD(WFX_ISS, CV, 24, 1)
>> +
>>  static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
>>  {
>> -    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
>> -           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
>> -           (cv << 24) | (cond << 20) | ti;
>> +    uint32_t res =3D (EC_WFX_TRAP << ARM_EL_EC_SHIFT);
>> +
>> +    res =3D FIELD_DP32(res, WFX_ISS, CV, cv);
>> +    res =3D FIELD_DP32(res, WFX_ISS, COND, cond);
>> +    res =3D FIELD_DP32(res, WFX_ISS, TI, ti);
>> +
>> +    if (!is_16bit) {
>> +        res |=3D ARM_EL_IL;
>> +    }
>> +    return res;
>>  }
>
> I'm not hugely enthusiastic about this mostly because it
> means we would have one syn_foo function that's written totally
> differently to all the rest.

I did consider running through the rest of the file updating with proper
field setting but I didn't want to bloat the series. I think it does
help with readability compared to open coded constant shifts.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

