Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9922C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9Xq-00039d-NK; Fri, 14 Mar 2025 14:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tt9Xn-00039S-VD
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:14:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tt9Xk-000533-KK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:14:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fe9759e5c1so42044a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741976038; x=1742580838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6VfTcNoY63WBIBdPgbofusWcI/xQAJEX36HY8a4cNc=;
 b=ycWAv8lqo7jUMdjP5e41NsOxFO1euj39iNtwdBcDdi++8y74oU5n/x33RVrjopmGzo
 sxnuUaFHXsCoStRekVAGaaPIpEhyIQv3xY1zldJ5XRGODF3O5IT6ljHYAvFlAyaGqmiB
 e5QqasS1/Hm4cXMZxSj52pRVWH9mKnUSY6y2uEqCBIMlFyemasaY5rM3rN/EtTTl9T2v
 4mCmVUehEYgI0eRhr5l3iiFL7dbmfjBPezqplTxIrpbngBejyqet1jrtk+yuRJ9shD1B
 VajpVNVOIjfEX0drsBUO532dHLBWU2ghKbTJlTOfMupeamNxxT3KRKXB+UppYZuvEMa4
 ZFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741976038; x=1742580838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6VfTcNoY63WBIBdPgbofusWcI/xQAJEX36HY8a4cNc=;
 b=L4e9E4ZM/VHeO2LP33pvMefwUUm7k4LfX/Bcuhi5AfCjCBYQlVT9643MehQAA+hzGD
 dMJs7JBQUy+9socZJS9clwEc9+t0uk18WZu6DgoVqgk/59hka5stlwiPAh3fa9SPO5nz
 qTI8QaPmRdkgGyjhA2La3JVl0otggEE7Bl5IIPcUrMy4YGAQC5zanzwZMFhSkH+jo9dM
 14c3fCAey1nphESP1pEx0G50sTJYO8Ml2uzuTgWE+RuuhGTzidolqSAO22wD6eJNfsDM
 UJpKJP0kbApBDGscS2s3/Ms58svuAqtjwf8pE3UQoN8RyG4YNFiWuUQpa8bgt9kuOcWD
 JKAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOY/mbQ73sHmpOPqeMxlMR0DiKwiRKt/Hmyi8pHgtS2Sk1tc2oIv3Rxb22H4iiay2vVZ7KQYFwXvRV@nongnu.org
X-Gm-Message-State: AOJu0YwVUIvCS+hTjvudrzwMExtg3YiMKdnX23z5iIFUH6N/UDZZY78B
 MeYmUJVCqnYyfxhNJvdoSOQS/loNwveni9aitEZXGnGA2+hMMEqjEfu+7EJ4urc=
X-Gm-Gg: ASbGncvB4qn8pVmr1/BG2ihgdPPGy0qrkJWsmiJVoSiar9B1Jenwt4IHBUitS556Q/B
 bGLhwJuwNjqLAz8p2wCz0NbnCGdSfkWyMWJMafJxRo3hYLF7jfcLPCj5UEZxgwR4KqCqvaAvG07
 9n37+J96nYzeQ0FfDYtG0WLLMjwqMZAKyL0NXuF2I0NXhk4fDWFmiKFtwJ+qSym9qrzFI15RRUN
 oT7dUlalnpzoF2VxN5WqA0rtrCZoSjcFmrMfhZIftj/kaygIKeYBsmWuC4p1/DWNGMMNzja8kNP
 C1L9Dym/DhGIE+STjqIUEZKfSngxeqFrDWXHzTtgMUjGiUZRFKYWov9al+wIk7rZKAvGXKLAqDN
 Vu79rgozP
X-Google-Smtp-Source: AGHT+IGCN+hpQCXlLSz8rYo4l9NZGS7xJGFTf4NnBlVWleWs2RoOItZ3Pffm3HbrrULXyO304ytXtw==
X-Received: by 2002:a17:90a:e70b:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-30151cefa35mr5026044a91.17.1741976038060; 
 Fri, 14 Mar 2025 11:13:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153385044sm1356386a91.0.2025.03.14.11.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 11:13:57 -0700 (PDT)
Message-ID: <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
Date: Fri, 14 Mar 2025 11:13:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/13/25 14:00, Pierrick Bouvier wrote:
>> diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
>> index 89fe8aedaa..7b9964fe7e 100644
>> --- a/include/hw/intc/armv7m_nvic.h
>> +++ b/include/hw/intc/armv7m_nvic.h
>> @@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
>>    * @secure: the security state to test
>>    * This corresponds to the pseudocode IsReqExecPriNeg().
>>    */
>> -#ifndef CONFIG_USER_ONLY
>>   bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
>> -#else
>> -static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
>> -{
>> -    return false;
>> -}
>> -#endif
>> -#ifndef CONFIG_USER_ONLY
>>   bool armv7m_nvic_can_take_pending_exception(NVICState *s);
>> -#else
>> -static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
>> -{
>> -    return true;
>> -}
>> -#endif
>>   #endif
> 
> I'm a bit worried we might have regression when doing things this way.

I expect link errors to diagnose errors.


r~

