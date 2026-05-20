Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FF9CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgj-0007ZV-HK; Wed, 20 May 2026 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkgS-0007MK-CU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkgP-0004OE-MA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so2681701b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297972; x=1779902772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLuo/t16axaVgNDuvZNn5zkWfPM5x0pxxDbNPCoQofo=;
 b=EeftiTsGN1hTV8r0iVJiIfFVwNDrUhFz/DaI+BqRt3Zxxf4ALwWPnz+wn0qXnv+917
 XJIQ52suOmaAfWQH4H2z7oQqGu6+rI/BQkAQ4qB1u7kaBAfZE5OhAg6mCfIdBE6FEa/c
 Q53SfvW7MrNB/NTDDPZaEdFPtfTu/7fJFRDah76cd8gqX6ufIZaw3gFdHuLVyfPKZKdl
 HEq9EZMfOIAjzbUxl9XVD9dK2F3lUBdqgywFA302IQYGTHZCo4tOenkV1dHqFxi3YbHZ
 b9EGuAwZtLCiMxy3hYM5hATGJEfYt6in3T4t/LhPJrvitfgSKMmWBpOX25HDoVMJVk1P
 HzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297972; x=1779902772;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLuo/t16axaVgNDuvZNn5zkWfPM5x0pxxDbNPCoQofo=;
 b=jpaDlUiRd0NzjxN5r3+iGeye+3m7/eJzYcqFB/SLhVjVcQQApmszjq++I0CfQhmhCg
 ZQ63JXv6Ia5VQeA+8r+DnQHqI52jKYNynovVGCiAUhtkP6dFQZSZL4d3fmaK8tPB8LlK
 GkrmAkrN1Db16Cazk9ytq2O6pB2qRxAG5ZkB2je9t43GyHy4DboBuktuOP/meHmsNCGX
 p5ZGBm0A8QW0eRBlknedXxUvTeZ0Fdq2jpEnRyiCXJlVS1NaetFC3saqvw2Lp8rPq/O+
 OvE227sPZgyMoJYYqePCJGOwTm4hnuHGUrFZNWYqXukGsTmuACfLJ7k8kHvTgQirZVUs
 WsDQ==
X-Gm-Message-State: AOJu0Yy9uD9zTqnqukekG+XAcmc+5D6f1V6uZ5y4HCN6L0FcWrFOY9cz
 h7nlFiDsX6APCoPzuL/zutXfMa5RVwv01BmCNqP0JNVvDkot5EUluOCZ58M021jrde0oSQQYH1z
 KSMBYRfI=
X-Gm-Gg: Acq92OGlHHSkxm6ZXjcTkazY/R9qvvwp1gwOyNAukDgFh0Uz2SHetYXA6iE+Zp8A9/u
 /+nCr2m65UM7653FuD4ZbofTI/ljxTeuUd7Wwl7zGIQEd+BCDtPldbCVcHfSx0cS2M4zPRW1Lce
 1+xRvdKQCeQvhBfNz77cFuikUsjrg+/4JCVC1KAVclE4erCulgtvqlv00WdVjJqlD8LzPLK411/
 V7l7TMyLlyDYBgy68MRNH4diKrtJFgIA2sDuqUv3RvQkAvgauQ0ocQALQZcKW79NFHwuVz/owFQ
 v3C8kVzxcd25TGFiwDa6WArlcONiNCa6unSIJDlwq56ml89u3tKG5Z2DsOKmn87w0c7DaXwwwls
 F0UjGX7LFwcoy/+tcEasLggEMAt4v4v7DMUlpj5SxYkZW9L2c/k5suusC+ZRL/vwfeZe/fEDh67
 gPG6/qSsMx2+csMG+WIXLpSMt91c6UR/fa4LERcP8JM1AWivo=
X-Received: by 2002:a05:6a00:908a:b0:838:3404:c2b1 with SMTP id
 d2e1a72fcca58-83f33c9cf52mr24909168b3a.18.1779297972008; 
 Wed, 20 May 2026 10:26:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm27377330b3a.10.2026.05.20.10.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:26:11 -0700 (PDT)
Message-ID: <672cc2e2-93cd-4146-bcf2-cc000695a122@linaro.org>
Date: Wed, 20 May 2026 10:26:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 59/63] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-60-richard.henderson@linaro.org>
 <CAFEAcA971nFuXNkQbswiDzRXQ7WsrW9GTVzH5A2rPGym20yMKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA971nFuXNkQbswiDzRXQ7WsrW9GTVzH5A2rPGym20yMKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/20/26 09:36, Peter Maydell wrote:
>> +void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
>> +                           CPUARMState *env, uint32_t desc)
>> +{
>> +    FP8MulContext ctx = fp8_mul_start(env, -1);
> 
> The scale_mask here should be 0xf as this is a halfprec
> output, right?

Yep, copy-paste error from fmmla_sb.


r~

