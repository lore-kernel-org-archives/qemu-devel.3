Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC8AC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdQ8-0007qd-Sc; Mon, 23 Jun 2025 05:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTdQ6-0007qJ-Ju
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:24:54 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTdQ4-0008Sw-Du
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:24:54 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso833568066b.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750670689; x=1751275489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoqqEZy5VbkKBL+lKxMvZFDUricn8vy6fC0fpbYdX8g=;
 b=KYLZod558GsESTQ2leHdOqCG7wpNNBvVvCV7c+uUlj/vb5+gQLFbolTtEzDjrwny0I
 CHMw1712DMKnIX0iiktPVTCupAIl8E90WEQJn2eayuGHk9YxBrsSS7PYAc7MFj+rPNlN
 hBrnyGfFoplYeLoElT3dHIUjZOi159XaCb5hsV7IsvMztqkiLTuZYaxd6JDVubmgfQxR
 54p9XT2+f1RptvyLF5zOopJTfm/d2yaLnTG/85AqJZjSQdn8ScuE1OWq/7oLntuWfzJQ
 /siSCO5Skb9EM2Ta/t5R5RA09yhcQdc3rGMzoShILZiR12ILappsWDHNp1adq9TBlGXM
 CPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750670689; x=1751275489;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qoqqEZy5VbkKBL+lKxMvZFDUricn8vy6fC0fpbYdX8g=;
 b=H4GDtYnmOlbgSItIrG4u6A+4nn+OP7tKO5ii9ZoKvgg1hzxUuI4eOc+SeS3DLeGciW
 ezoHSY/ge/H45RvB12bYKzIPE6Y9ZZHsxVCeh87Y8hHBDIxDY2mh0bbyM9/UwDRv8E8B
 U04sBJs8P8l1u6lxHlNOPp1ytxQ5VOkYTUll96f0MXuOPdGp4jygTxFZLMF8K438QK3K
 DLHoQicbyJ/chkRpO7gVTFEhHiezGxfITpggVO97UP9eho/tTPqUhU4bhwsTsBRE24Vt
 rvhqt2GESMczwQuwbtiXoNFx7RLe3l16ng/rOhCQrHqp/WLZZ0m1xVlIB2XyoYIip36v
 CYgQ==
X-Gm-Message-State: AOJu0YzgbzZSknS4jigCuNcco9bYmsN3Ng67eXw0bKAuF1euDCL9Ao8Q
 cd4EsoiFOdXEEUHFbDspZXK4/GptUBCR7103XrspwkV9VYxhfA2RSDTyz+Tfjzs+hQdVjfVA46G
 xrsodQo4=
X-Gm-Gg: ASbGncsZxqkZXhm3zEcfIH9gxA0lcosByl/+hq6ipLM+MglJ64S6X+cEds3z6dMkYxK
 TdyfhFyxsL4f2VdIg7+EragngfGeosNz7S/1cOrZbCPXp4IVZu5ldBNVvmBYznQkM+oUpgIBANR
 LCQ6EwDhQzb2N9GSgMtOLbRLtvw3LZqFd54Q/vSRmb3K92f+w1jMfLEPnSulpgO1mCGIJ4awhCE
 5Lt9eFgpT9Wx/3tC0LMvm1o/sh4hUhC1s+7HtvOQl3A6WZZyfENwMEN02unS5pynimW6zwNENfI
 J68e7nLvfPgDL8s3lu/2BFaRCTc7fUdseJlcGGfFizrXW36tBHQ7Yf1B4Uh2A50=
X-Google-Smtp-Source: AGHT+IG1EKkOSGMi+3HWNRLDmBuH3aqPzSP4wX0IucC6j//y9KIJ2w/7UfaVoGD6RgpsbB5We9fZ8w==
X-Received: by 2002:a17:907:97ce:b0:ad8:9844:1424 with SMTP id
 a640c23a62f3a-ae057c7ec71mr1054132166b.61.1750670689380; 
 Mon, 23 Jun 2025 02:24:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054084c01sm667526566b.80.2025.06.23.02.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 02:24:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B889F5F815;
 Mon, 23 Jun 2025 10:24:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 067/101] target/arm: Implement FCLAMP for SME2, SVE2p1
In-Reply-To: <3269e3a4-1117-4e0f-b28a-e23d2cc4596d@linaro.org> (Richard
 Henderson's message of "Sun, 22 Jun 2025 10:22:33 -0700")
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-68-richard.henderson@linaro.org>
 <3269e3a4-1117-4e0f-b28a-e23d2cc4596d@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 10:24:47 +0100
Message-ID: <87h6063j4w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 6/21/25 16:50, Richard Henderson wrote:
>> This is the single vector version within SVE decode space.
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
>>   target/arm/tcg/sve.decode      |  2 ++
>>   2 files changed, 24 insertions(+)
>> diff --git a/target/arm/tcg/translate-sve.c
>> b/target/arm/tcg/translate-sve.c
>> index abdcafd952..235022110f 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -7381,6 +7381,28 @@ static void gen_uclamp(unsigned vece, uint32_t d,=
 uint32_t n, uint32_t m,
>>     TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz,
>> gen_uclamp, a)
>>   +static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
>> +{
>> +    static gen_helper_gvec_3_ptr * const fn[] =3D {
>> +        gen_helper_sme2_bfclamp,
>> +        gen_helper_sme2_fclamp_h,
>> +        gen_helper_sme2_fclamp_s,
>> +        gen_helper_sme2_fclamp_d,
>> +    };
>> +
>> +    /* This insn uses MO_8 to encode BFloat16. */
>> +    if (a->esz =3D=3D MO_8
>> +        ? dc_isar_feature(aa64_sve_b16b16, s)
>> +        : dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
>
> Missing !'s.  Fixed.

With the fix:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

That looks like it was the only blocker for the kleidiai tests (causing
an unexpected SIGILL). There are failures in some of the tests after but
no crashes.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

