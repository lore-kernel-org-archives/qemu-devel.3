Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E29C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 19:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9VdR-0002qk-90; Tue, 21 May 2024 15:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9VdM-0002o3-LU
 for qemu-devel@nongnu.org; Tue, 21 May 2024 15:58:52 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9VdH-0003YV-VE
 for qemu-devel@nongnu.org; Tue, 21 May 2024 15:58:52 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bd9061eac8so544060a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716321526; x=1716926326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85DgAYPxX99iUlxvF+yptWqt/GizS9t9ebZT9g6XIDM=;
 b=D9X9HywpEzWDXSloJ/WHIh+ih4KnFiVBEP0H/kR1SBjjhSNWQEVSfjxeRPyDPf30vf
 tsX8xc1huQIPfKQY9uYn/YQhm3sVC/LxBVnvWSc7Xp9GKGd8mjGC4EDIzeAAWxaNsznY
 TjBbOkR31dqYgdiGb5ZnNAvkYfC5rRSkfulDIUEyFq56vi7UIbQrKP/VaBL+08/M5GgR
 MnbtOPhqpIZrszMr9BueEALCUY5Q9TKLP+AybQUn4TZEqPG/+WxciAE855vHKhgV0gGs
 e7VxYn/wJY4cmrYlOnx5OO0LxHqK8DCnSAnmfxqzlrwcM1OmFhua7Y8FaTs7VxRSX4kH
 rduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716321526; x=1716926326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85DgAYPxX99iUlxvF+yptWqt/GizS9t9ebZT9g6XIDM=;
 b=cSXPrHxO1Fot0au9mVHwsU5qqi1JCyUDZQRdEYIERDJOZM7BqNN7d8etDzOYYRnwwy
 VUEkWwQ47HG1hVa2pWvgV7mnip80yMWfjNOlPWyQo9VQuOqFvfSNvUHms/ifUAteeNHC
 DMA5udDBGebIXbLLh3CLhWXzm2wrh/8Y/2ESCGipmkaDcFtbbI7X8F6lYRVTUQhzUfza
 IA3sJRMVJyfHbD5FX7fthcEUlB1ynj/zEWUQRM9ZPlz1f4IplGZLe6WI9SJl9WkTftWU
 JOsF9vgPhNo5Y/1HM5GAax2qCOsoPjbN9R+FzT+kWdOGisxm1kyffbe3Qlit4A1oH11F
 5f+A==
X-Gm-Message-State: AOJu0YywrQRphp/pxWtjCLyqJnESRTnmN34ZSQQNYlW7pHkwZg5qj42I
 dl6HSQLvohGnS7WMiH4IUjvGP/sr+JItABU82Q2XleAsI9jxU43X/4d/CdIWJjk=
X-Google-Smtp-Source: AGHT+IEQAPKYpT+3O2Ozst7Kgjyg/r0WxSaAGYBD0Cn4sCrhOtJNeZoHWgKH5O7FpHxmioKhzx50vA==
X-Received: by 2002:a17:90a:53a3:b0:2bd:7fc1:c91 with SMTP id
 98e67ed59e1d1-2bd9f5a1718mr151108a91.38.1716321526016; 
 Tue, 21 May 2024 12:58:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd78b2125fsm5034421a91.23.2024.05.21.12.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 12:58:45 -0700 (PDT)
Message-ID: <06765e15-9545-4765-84fe-ddf2a77d0454@linaro.org>
Date: Tue, 21 May 2024 12:58:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/57] target/arm: Convert SQDMULH, SQRDMULH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-58-richard.henderson@linaro.org>
 <CAFEAcA8YQURkn5-SjVFmR16xcv6m2WRmnJpkeg9PVZ+eFGW8fg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8YQURkn5-SjVFmR16xcv6m2WRmnJpkeg9PVZ+eFGW8fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/21/24 09:16, Peter Maydell wrote:
>> +void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
>> +                                 void *vq, uint32_t desc)
>> +{
>> +    intptr_t i, j, opr_sz = simd_oprsz(desc);
>> +    int idx = simd_data(desc);
>> +    int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
>> +
>> +    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
>> +        int16_t mm = m[i];
> 
> Wrong type -- this is the 's' version so should be int32_t,
> I think.

Oops, yes.


r~

