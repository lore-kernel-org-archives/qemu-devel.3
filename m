Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2830C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww5ud-000146-6B; Mon, 17 Aug 2026 18:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ww5ub-00013c-GF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 18:34:33 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ww5uZ-0005oB-Ta
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 18:34:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso50711775ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787006070; x=1787610870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BaaZvlNe7aydluBl82HSBJ+zgp4NFADzCcccrgiurrI=;
 b=Hs8YhSSADnhb8K653N1J26N5h/Qhw4YrM4fjKgc3ewmUHso27Zr5kx2tLQSYnrt4x8
 /dVp5c7pB2/P9IrhQg6bWOAQsN2bD00oVkgiu24MmEk1XKLgQhir6SGSHY8ZlahXzvDo
 VjHA+K32rxGYl+QW2nfiHhRGhnj1i5yeZ8hZnR+w3ifBJE126F2JLGRjv30to6kEyCap
 0qZiju2cZMihGTTlurQ9B8pYlaB2w1r2UkYfv/5MtQhzvkyqYU7WmngrOwYc8KneK/X/
 x3K9kXrbMJgjoZ9tn/rit5vquJTkz6UFftqqEtvliTYF7vzeugfT71DXJTiq+BosjrSL
 AdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787006070; x=1787610870;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BaaZvlNe7aydluBl82HSBJ+zgp4NFADzCcccrgiurrI=;
 b=PWCLZ2VIEcg/kpJktDxetukxtNIIgOmyUPxy3n7GWgdJvn2qKE88Pnqnx0dMGgYePp
 VCX/910VxQU5EApHb5v+BQsJb3D3hXC0KUamT7ooM33cT0eWstRjnpVQFEhJ2aMaBpbt
 UH4NjSZffN9IJmnw4CoDsKibHi5Pd7h79vkKgtylw2MNtVkeNfoUmpyBpPg62KrhhvfL
 otZi/47ABmj2qe+/iVqkSjgMhHF4wgxsXO3kXfi37rtkIHU8usY/MTlkZOgaBrdUlLKO
 k3XE3QU1Vcug7EqStJXsNrOw9DC4NpO7znw5087/vgqnziH60Xl7R96fFvOadUalA8fO
 3w/A==
X-Gm-Message-State: AOJu0Yxj2PkhCejoy2sEamt+/46Rxm2+YEqKGMayIGOIGLx4k83yyDR8
 kMLbrUCFiPWMxnoOtVgZPLg+8MjnRkssrUmnOaG6xpUEDwluTdfGHXu33MVRECbhlCk=
X-Gm-Gg: AR+sD11vNXNBhakrrGPx63KwRkjcxw0K5WGfczOfBWVnR4ZlhYLXbADIbySrxh7G3dY
 kmPlio0U3tPxSfPhdzO8WaAawm5WLJrq9WgAlw8LKdwzS11CsR6rsGbiCJr7xhmsa1tpIr7yfsM
 C2Z+3AdKv9H2RRE1ARQzpGzdIZqdkLXHWRSD5zVKS8gnvcaacI/iXeSZOoY0ehA6zXHSXMUNOlJ
 Bv9V8TTz9yLRgEPdN4eG9jLgeprrgq62LT+T+5D+GlynuWQNlftCAaZsA2IfhdBKfgHwEIiA7NV
 OmTsSuqnrQEoNSD2y06mpQO3tnivIEswoV4PLnWQABwF9dMLn6E6mDcSaBxopG/vCgGtta9U2Gb
 3ThgaCxIA1CRdZmZXSllrtPKQY4sSn/NspYilHU0jVaLxF54qqH2TGOvYSdqy+mEGDHkYcJxnA/
 dfB0lY9Orv798lVpeSWQuICVoB0zqwBppSaOESC9P6ajAuPlwWO0Kp4/KjpA8+fsmbVA9bYHF52
 SfAe78pc3objCVRYIYQpgeyXUCDKtbia780WxKHAdqcAC8=
X-Received: by 2002:a17:90b:2684:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-3955a756226mr3569133a91.9.1787006069491; 
 Mon, 17 Aug 2026 15:34:29 -0700 (PDT)
Received: from [10.213.131.227] (c-73-181-156-132.hsd1.wa.comcast.net.
 [73.181.156.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e31a9dsm6448395a91.4.2026.08.17.15.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 15:34:28 -0700 (PDT)
Message-ID: <c931ce6c-1146-4bd7-8769-02e98ede0f82@linaro.org>
Date: Mon, 17 Aug 2026 15:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-3-richard.henderson@linaro.org>
 <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/17/26 09:37, Peter Maydell wrote:
>> +    tcg_gen_addi_i64(diff, diff, -1);
>> +    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
>> +
>> +    /*
>> +     * Since we're bounded, pass as a 32-bit type.
>> +     * Sink the diff += 1 from above into the 32-bit type.
> 
> Is it worth doing that? Hosts are all 64-bits now, and surely there's
> not going to be a perf or codesize difference between "add 1"
> on a 32-bit type vs a 64-bit type ?
Technically one byte difference on x86_64.
But we could drop the whole truncation thing it you like.


r~

