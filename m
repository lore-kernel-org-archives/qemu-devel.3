Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79F9E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNH72-0002r5-46; Mon, 16 Dec 2024 14:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNH6z-0002qH-3x
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:50:37 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNH6x-0007m4-HT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:50:36 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f2efd94787so2930094eaf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734378634; x=1734983434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fejvPhzi5X4SqyXtznRZBlck6serC3lB1rcPiv5G7l4=;
 b=e9JtaVFXqc33ttRa3QbfTgST0eH7M0pt3n3c2EAezUrpQhVTsUwN7yqr4oi40sfxNE
 Wqux53CIBeF5HWaqGf394tUcUw1J4q7rHvZYkXQlNvuG+3ol9td0WupznECRJFqiVif8
 AU5wWIKKzNnvW2dmOBEJuj3HdVcmWeqSzuH1zrl3S2BBjrJJw+CiBuJgDuDWzkElnH47
 M7dabXIJWaa5185gZu+bJr/+FQ1zvtuEj2He5S3sntfP93fTMMsUkafoXD54dCHYnylK
 vf/28uZ91ec7J/bo4gUwqj/lDpDj2P12TnPunnwBZmb2+wZBSmzy7xhwYtKr6Fov9gK5
 Vp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734378634; x=1734983434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fejvPhzi5X4SqyXtznRZBlck6serC3lB1rcPiv5G7l4=;
 b=BG9DbWgLU9w8vsB6Eh3QUx3eIKuS3w5wS8nr/7xVtcXhK05QycXpOldj0H+FpKb6nI
 MZqBiagNSu7xyICb2yjbfUDT0DA8u1h1gJy4k0kcJ8NqmdyxEPFmveK6GX91MhHslNgG
 Dgiu8Xohrnk+J6FR63CWf6DTvhhI7wlYHkyJbHzzpFeUjyUAfHiVcvdPd00QkdSkRoWG
 eAAKphcEPIxcYOQmFdmNdvlCs/UWNB+ot8iJH9fXMLCtW3dJhCw64fsFixPxs8i7Itfp
 ZhCRxWCfXCSeFxypFBLCKeUwxb4svjAlqAZPq5qMjjkW/yvKWlPTHdIchGj+Lf//5srX
 7E8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZrYZmDJXJVdhySMsGJPPKbzUZtdffFKHYP5cpneqcBf8NA6/oE/BFWisQJe3LfT0M4Rlmq3TMYdo4@nongnu.org
X-Gm-Message-State: AOJu0YyBEpxNAK+IZYgkxpohHnEmv1WTFx0aRriUwZv9RRC9Vdq0skxn
 dMI8prSp81AK3J4dtIMcDGDAOtRTehb6jBpVplOsTVEPDr0f3wuVJ4PpqSjF2As=
X-Gm-Gg: ASbGnctgBqLLzTaiB2Si5g+x9ADiNFNCJyb2owKyPMA8uHbd37j5VjGwYdnHW01kK6Q
 NiNGrTDIHuU32tdwoXw7lNcE8x2qK32gF8xfAucfPKe6J8lvP+Vr6O5fVEA0h4bvqQ4bVTPZMMl
 I8sg8Hya+s7bgsqEakMjf5NpejBGuyJeIQISPQ6N8f+pV/uZUVWWwgTJZHciPqy/sGGr1BtO/of
 ppokItxd1W8eEB330ai8lJm48LJOp2wgVQpXotzLJ/T2rTInC9jcOTAnZhQnUyDBiC/ZUUfSsYi
 BQUUoskBLBOazbX/HUNGIao3AtNGDCVeLU8=
X-Google-Smtp-Source: AGHT+IHVCEq+SvfI5ngEqj5HwAyKrTumqaUWoDFddPCgD2SY4JpDd0ZlOrNn+3r6erBYyXRfe16WEg==
X-Received: by 2002:a05:6820:1895:b0:5eb:b282:5916 with SMTP id
 006d021491bc7-5f32950f02cmr8517471eaf.7.1734378633915; 
 Mon, 16 Dec 2024 11:50:33 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484cfed1sm1584063a34.61.2024.12.16.11.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 11:50:33 -0800 (PST)
Message-ID: <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
Date: Mon, 16 Dec 2024 13:50:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 12/16/24 13:26, Pierrick Bouvier wrote:
> On 12/16/24 11:10, Richard Henderson wrote:
>> On 12/4/24 15:12, Pierrick Bouvier wrote:
>>> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
>>> spent up to 50% of the emulation time running it (when using TCG).
>>>
>>> Switching to pauth-impdef=on is often given as a solution to speed up execution.
>>> Thus we talked about making it the new default.
>>>
>>> The first patch introduce a new property (pauth-qarma5) to allow to select
>>> current default algorithm.
>>> The second one change the default.
>>>
>>> Pierrick Bouvier (2):
>>>     target/arm: add new property to select pauth-qarma5
>>>     target/arm: change default pauth algorithm to impdef
>>>
>>>    docs/system/arm/cpu-features.rst |  7 +++++--
>>>    docs/system/introduction.rst     |  2 +-
>>>    target/arm/cpu.h                 |  1 +
>>>    target/arm/arm-qmp-cmds.c        |  2 +-
>>>    target/arm/cpu64.c               | 30 +++++++++++++++++++-----------
>>>    tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>>>    6 files changed, 38 insertions(+), 19 deletions(-)
>>>
>>
>> I understand the motivation, but as-is this will break migration.
>>
>> I think this will need to be versioned somehow, but the only thing that really gets
>> versioned are the boards, and I'm not sure how to link that to the instantiated cpu.
>>
> 
>  From what I understood, and I may be wrong, the use case to migrate (tcg) vm with cpu max 
> between QEMU versions is *not* supported, as we can't guarantee which features are present 
> or not.
This doesn't affect only -cpu max, but anything using aarch64_add_pauth_properties(): 
neoverse-n1, neoverse-n2, cortex-a710.


r~

