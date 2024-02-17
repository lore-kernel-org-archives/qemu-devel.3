Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB4C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQDv-0007TK-K5; Sat, 17 Feb 2024 14:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQDu-0007Oh-GM
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:19:42 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQDt-00037Q-3u
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:19:42 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-218e3197784so1823704fac.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708197579; x=1708802379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ejysNzHafe652bvfjfOkixAck/LLs+zTh6ljY0cgBRs=;
 b=IB01M9OMTOIvF6iTOIpn0pG+hdkAbJXGFmfUMKZN4iwRuPZOi9BdmDaN9ajwVKwpTT
 99ehGafMj+GMAxa6xnzvxOyiiutlqadEXWhArQNXa0+Q95Ij1/TUYidss4W0nQ7y9hmQ
 snQlgCaF+qHgemm0XfKi8h0GRxB5XlmK0grPrfs8lSGyBJN3/vBItDyvdNS+HRT/hT4/
 htwl/cV8hRYri0M2lpnFXMUgHLqOR0dhbIkDyyaNNQRVROjOlaeaU/u6ZN30UeaqWZpq
 k7YYAO0Gt49B+bdoY3z347/wACpQzFjrI4Bu8nptP1dCC7DSgjLUCR2zDWa3A1pI3/Ww
 //HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197579; x=1708802379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejysNzHafe652bvfjfOkixAck/LLs+zTh6ljY0cgBRs=;
 b=HaN+xqFfuPDgMEqsv0e/khNHmFKSmy7tYtQjCyzJ8CfY1BBrREWL9dbmLWvdxUP/sU
 8Gpei16g94jF4Cd45h2fI0Jm+OjbF+KwdToRn8HUdIB1Xd+t3WarFTYq2OWSkgEsw6NK
 z3mirnK8SFVwF38WRyhoWIiiXbYm4ToNvcU+WnunxschvLGjNL797dxD9fwtjhWRPtmb
 NFH/irj9aB4GzcS74V9OvAAti3Zgb764AllBzjp/de+xWxfU6vpB0oQLKPHgXSyztPN6
 W5FNShZtUh3gGzlNOCXIyDX2MN1jn7izDWAcTwPhXwC0YdusUtKKfjtYei81yFEiSavJ
 mCxQ==
X-Gm-Message-State: AOJu0Yx0zhqxbFhF/AycUhLm93pq2FzvFtyPjGIg81uWYeVvM2UPJeMT
 JYdzKxs8wd4fjr7dHlipw/EpBisXGRZatfbdto7vMWQ5ViCu0/trhcGGFcfGGyg=
X-Google-Smtp-Source: AGHT+IG0xkeaiLTndY6jS+SUX8nS3/f+ueFnK/dehZ4MeUMgjEDWONVMAt2ERCANJpSut1DvLWD5gA==
X-Received: by 2002:a05:6871:823:b0:219:92e5:8b4 with SMTP id
 q35-20020a056871082300b0021992e508b4mr8753696oap.5.1708197579532; 
 Sat, 17 Feb 2024 11:19:39 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k15-20020a6568cf000000b005dc5129ba9dsm1638118pgt.72.2024.02.17.11.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 11:19:39 -0800 (PST)
Message-ID: <4a8fce75-c415-49be-844f-3193577652db@linaro.org>
Date: Sat, 17 Feb 2024 09:19:37 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-10-richard.henderson@linaro.org>
 <61d2e428-5829-ec12-da2c-57736b9af86f@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <61d2e428-5829-ec12-da2c-57736b9af86f@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 2/17/24 01:33, Alexander Monakov wrote:
> 
> On Fri, 16 Feb 2024, Richard Henderson wrote:
> 
>> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
>> double-check with the compiler flags for __ARM_NEON and don't bother with
>> a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
>> and use VADDV to reduce the four vector comparisons.
> 
> Commit message will need a refresh (s/VADDV/UMAXV/, and there are no
> vector comparisons anymore, "reduce the four vector components" perhaps).

Fixed, thanks.


r~

