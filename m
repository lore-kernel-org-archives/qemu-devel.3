Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3AFC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhOh-0004gC-00; Mon, 10 Mar 2025 13:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhOe-0004fx-SD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:58:36 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trhOc-0007oQ-Rs
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:58:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso87084765ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741629513; x=1742234313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1ppuBJHFnrg+OKN2yUdfCK1aWVUx3q5PnTVwgoEhVI=;
 b=eCXwWXQtwDa6lrxHCqm3zgOWUz6mVOYnXsdux6tVSA6964XPCYOYeIUiFVwXd/pGPc
 kBnt9eQ5EEbaqJkWcM19gyXuhOLTOy8UE7yXLWDmhup0iD4IwEizVZQZjyJzMADTkZOb
 5xqDaGAEjA2u2ICpjStTwduSQVqBAByWf0BOHXFEv5rCm1PQ3GsUPrSbo/yuhPz4GhDy
 WiQ3JPtHC8UNUx/9k3n8QJN9EREkY7qw7W9zpyikFijQJhCvmAQCF/IMW/PHZRAU5SEH
 SDBmxKHFwz4j0C7Mlz1iGs4Gb6KWFBpfHLuoyukHkyku279z4in+wRZlTS6i7etFVlLO
 /gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741629513; x=1742234313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1ppuBJHFnrg+OKN2yUdfCK1aWVUx3q5PnTVwgoEhVI=;
 b=LAD9RUPy+axIyeQNE743YiidWva1AXsZ6pU1rLWDbTxLdDwlqQiO1ihvJtdHbC8/0l
 EEYAIN7cOUJKmAqcO3A7Gh15IhbmGTqDeNQOTezo6UJN/FyFthWZzATV8YfT9Jh+iLaR
 sA2UDZA4q/TzNPtk5ddmRjtIDWcbjOpsc8xGTV3fXIMWuBuBTZ47si7VgC68uRAakdUy
 cppSG3HM6gBtKpvP3rzHMg1Jpa5AePD3nugiT9yKcc4UBTm/ehHn7xYKSfPNMkQIMeqb
 gN2XJp5rlqXBixNuUMZzNNTnTbU23f07FvBSTf+Q2h8D6UoIYK/XwW4AfZsIoKcvPUEM
 YTrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcI+CSNio36rXzt7Xj0eFS/pzvNTLk5/pczlrsmUIs27Xbs/VJZed4/SD2LyUjxELdTpwNr7v0Ob+8@nongnu.org
X-Gm-Message-State: AOJu0Yz4Gcey30hOK5BlVqnqbaBopxpGuvAIDBzhwYAQy5LEwE90Tyj7
 IHBHCOkJK3bgthuelJotgcgyY+2lKpdTBbRjIxRV6ju1Es1cTOhX/HTIVsGooag4HP1gLLe9Q7j
 h
X-Gm-Gg: ASbGncuzAXlZy/llo/AE6ethlhylZJDiaa4chZLTvvW+H2iR7PQtleSKjbt9I+gv1Yx
 WqtkqTKYXUwvGdeMz8eJeJlt/kxt98bzvz/xbc7IM/ggrSH5BesPtb6fHs/popVpThvYjS1921a
 X6sPSm1hddqL7QuC9b7Uia4yPd9mAK5xIz+8lZe5TJbd45E0ZwZJH5AbzcReaKu96nW4Paq+cGa
 XKh4OZfMkrwy99U6pr2a6Taf2B1V3/afQgN1ApKSYidvoas3qdRz1WPijGF2LeZHIwCDxjdv1I/
 opmiS0qtkzWpIKtbK36j+QFKM7fPcH3PWvTnTTSU+remKVBqZfpqIbMB/i8QrfSbZuR8keyEhUe
 t0tKtr3SzzxU5kIrAcro=
X-Google-Smtp-Source: AGHT+IE7zqw7rL1KHosFGdpv9WEM37GGDiOuZRZD4Kk1Hb173PErx/9n1Taz/+70+CnIgv1SJXOVPA==
X-Received: by 2002:a17:903:2b0f:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-22428a9d15dmr211025755ad.30.1741629512921; 
 Mon, 10 Mar 2025 10:58:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109fefa6sm81387755ad.106.2025.03.10.10.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:58:32 -0700 (PDT)
Message-ID: <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
Date: Mon, 10 Mar 2025 10:58:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/10/25 10:47, Pierrick Bouvier wrote:
>> Maybe better as
>>
>>       MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
>>       adjust_endianness(mr, &mrfd.data, size_memop(size), mop);
>>
> 
> Do you think defining MO_TE as this expression is a good idea?

There are not so many references to MO_TE outside target/ or accel/tcg/.

Indeed, after this change, the only ones left are in hw/arm/armv7m.c,
which (because it's Arm) can be changed to MO_LE.


r~

