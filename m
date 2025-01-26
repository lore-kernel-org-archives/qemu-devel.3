Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF290C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1qg-0003Do-3s; Sun, 26 Jan 2025 07:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1qe-0003DD-Ga
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:34:44 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1qc-0005gE-Ou
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:34:44 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2167141dfa1so62505045ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894881; x=1738499681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G4ESq0D9+k0uIOP7eXeKA41sVDLDwidgeZCm+Z3D0q4=;
 b=NC1A61we/nTExkxFxVnl/qd6u86OmuwQwvW7j5nJBxkoW++of7FD5iXuphgW9hQIUY
 qRLZSK6gGBHlTl2Q6Be1fvAJTCqu1RTyG8UgKPO9UOeKAtSu09fFJ7yIprNj4kIvFoYY
 Z8m8zwwfC5SvgGKVNTen47JD2Gsdlzw525KbiKRf5wi4UR/In41RrZuWgswCkBPwinmy
 DWsHtufsrR5kz7JdS1IRfmxEWsbSzsr2qL9/x+DvMI7ntsUBtnZO4s5v1sr0q8mMNswf
 DoCgMK8WK/Q7dAjPjR6431HcShD9LU05WrvyJwPFywmcj8Aj8/PmFwCm/QyvCLDF8DXK
 Cskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894881; x=1738499681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4ESq0D9+k0uIOP7eXeKA41sVDLDwidgeZCm+Z3D0q4=;
 b=txNpDBAqP3NgeSn7TNMjsuwKmCzgcu78sKQHfofw9ZLjT1xB9pE2iiHuVR7m5ikZYx
 xdt83yhnj8QqC3Dz+mM0N6Z3fn+nkMSMfaX8vuQJO9Mik/4eMhPvftnFLeCkG9EliEup
 zfk4xbYPCmPDt+kvHYhyDAFPpDGpLnFPAYiXZfVDl93TWGs/Jgw17rHMp1CN+ZUICCQM
 54AgL2KCAkrnuIKgPOpJzhx++Y3fWHs23+ohrD7NgQR97gJdiWUOMPQKNvlju0w5ZXlw
 ZR0VBIAKaVWxBxi/vbLe1cD9MxDjE84DNi7qGKtfHS6dDCu9NuB8ZXE4jgcnwJ0akB2r
 AFzg==
X-Gm-Message-State: AOJu0YxbaebAuJOzU6XkckOYXx9i2pAAk5txV0DCYNxoSjr+gD28jDRB
 czLYj66mNqYVlJ17+/Smg7z35TGDhYXVEEjRK7h/e2JBsAhqQUki/1BcXURuma0bJT1LKSyovUp
 5
X-Gm-Gg: ASbGncvLJI390jJ6+IwI/rsSdeyDgY794w92oJz0E6cOf3pYM7D/wImcb6VrIMuKWPZ
 tjP30igwbmAeEwBicwpCWLAsOdzFCxyPEuYwYrkbfvcn14u32FHhtgy80Ynq+7NPuZ4b+1tkETU
 auF2C8gu2oaUQJ7Dz0Y7WFo9U6XKWJoesFk2KCE0f6EKfCzMuXYcfkeD3hh2ebMmiMXW75zWPpk
 csRpKV+frPHcZxw5+c0MIL69QCJqAnGJTsyv6L9t9MqY+c6a762snwOZ+7uy5SNDba/hbo84Z0Q
 xQfhxDF9Mm083xWVEoPcOr5TZ8db+r5Z2Q==
X-Google-Smtp-Source: AGHT+IEt0yoPgA3EKeECAlOuaBd6rfgNN4ei2OpN2yUMxuJh3P7K3jyrA7ebDGIR9KNyC91Ki+cYdw==
X-Received: by 2002:a17:902:f541:b0:216:5db1:5dc1 with SMTP id
 d9443c01a7336-21d993172e2mr217824525ad.1.1737894881227; 
 Sun, 26 Jan 2025 04:34:41 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c59asm45171455ad.29.2025.01.26.04.34.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:34:40 -0800 (PST)
Message-ID: <ccfab95e-fa53-424a-8167-da96484e0506@linaro.org>
Date: Sun, 26 Jan 2025 04:34:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/76] target/arm: Handle FPCR.NEP for scalar FABS and FNEG
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-43-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-43-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle FPCR.NEP merging for scalar FABS and FNEG; this requires
> an extra parameter to do_fp1_scalar_int(), since FMOV scalar
> does not have the merging behaviour.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

