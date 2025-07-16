Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E24C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5LD-0007xj-Iv; Wed, 16 Jul 2025 12:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc5LA-0007wN-BJ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:50:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc5L8-0001Of-BY
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:50:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-749248d06faso128889b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752684639; x=1753289439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LSgmFtKK3NYAulFcWeRLt0tr4WWgLcadAvgUqjCKdc=;
 b=diwwxRQLyVB1lYV6ozV+lhJy5vDaZ+D7BNjcqSNNr4M5XwACzPys/uJLeNSDNpEwLn
 PfLGkl31ljMxwnW8ZOLHDkGEp+xc5mYiCKV5fdSKN6GPeoNOCBoRd0i7LOTMT7n53b/q
 LVk61x9hfCO1q650KVric1NHxz03X++h0zVX7lWz4+T4uPVJ7iOYsogNbRPTlrNmm2/e
 piTx79KGpZladc+c5ednI2WqVKpKvky0tgzpy0Bb9mAYOjhnQ/G6BU1porwUq1BFgtZU
 2vMz9kCRwu2eiDsbZ9mUOzREYMbefYuyDMlqZ3Y1TyZCapHbvC26J7YA1wg810g9tFyb
 8dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752684639; x=1753289439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LSgmFtKK3NYAulFcWeRLt0tr4WWgLcadAvgUqjCKdc=;
 b=JTH9CoB/6OLgFggm3sQkpP+rHkzNsI1jg6MD/WtIhaSnvC4bA6jvWwqeukbKSZhz1p
 IFAjEWC/JMdhYjYWmbW4gsE9MnzmsRFViPFELY+qm519Dm8iCYaZZT09q71IyddYQy5i
 EZUgOkBv0BodSCHXtQfftUgDBmOEpKnOVNz7lUg4NFx2TyPW0bFhL8fsHidYAMMa4NdY
 eBpCvjLzXFU13nrQ0EUZxe4eNPlO//z0bNaxkUem9g+sPW6+ZyscuwFhrjNdWNVsHrL0
 uB0CITOGSpuD/r+vEX13CM7yt5BM51Ap5dQn7MJpBBIEWuMUskzR3Wfq2srMo1aD3zfu
 AhTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKG6DwiHLG0RPEsHt/dz/zjmrv9DPYXF2w/BB6M4K7OgZzgGBV9pQSrY8RnB7wONNKrMTZAcykr1Y4@nongnu.org
X-Gm-Message-State: AOJu0YzK3FJ5hDNwS5apm4ylU8bNz94FL+/vvVZ0S6yU7pFFGjqPsw8d
 F4HYpQ1uDaUAGR/jGxrwRujbBWJsRALs83Bb4/MkMkDvrFYfI7YEZwRRfkWWmnDcOYU=
X-Gm-Gg: ASbGncuTq3HJYaClkafHQxrBBpZxOyS1otm64iQSwXtz43P+pvCA88EXQX6HHEQOsaa
 bGvGNjxfut4C+5S+LPg20nq8RAr7l9QNbNOA2WsFXv0n8Z2nV9HrjOcvqUAQbsKWF8Xrolk+BLq
 1upQgR0HuS35HmWCWyvcjXLu0L2Ebvi6EbtvzIyRIMntGz0CXQxffAkyPM3rQ4a4EklzfhrHdEF
 b3Dk6quNV9x865M3/hptyQtJEgfXXT+gvxL72kIZkfgsbR4JEvwTM+g5XXwjpIg9hqkpYSPn6lZ
 H8F8jpvgG0Tg1E811Q0ILLs9PHseAIYQjgoym1z4oJPlEAgQ3JOf3B1ojVzZQmxRJ0+O7w6eK6h
 R/33Dng6NkTqdBP/28kr+o9c0obb9ZJWdSkQ=
X-Google-Smtp-Source: AGHT+IHb1fSX6RHgfjtcLyMTDwWEIbaRAX5vRu82ib1Z7q3o/IyCNij7x1W8O3YqScz4mLjopXEZmw==
X-Received: by 2002:a05:6a00:1806:b0:749:ad1:ac8a with SMTP id
 d2e1a72fcca58-756ea8c31d7mr6361942b3a.11.1752684639075; 
 Wed, 16 Jul 2025 09:50:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-75619f92f63sm3199756b3a.22.2025.07.16.09.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:50:38 -0700 (PDT)
Message-ID: <1de7b0a3-846b-4e7b-b4a7-1b753f61ad0f@linaro.org>
Date: Wed, 16 Jul 2025 09:50:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] aarch64: update test images with new trusted firmware
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
 <52c5ed4a-0225-4360-b1c8-e3866041c4b3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <52c5ed4a-0225-4360-b1c8-e3866041c4b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/16/25 9:40 AM, Richard Henderson wrote:
> On 7/15/25 15:23, Pierrick Bouvier wrote:
>> The FEAT_MEC series [1] introduces FEAT_TCR2 and FEAT_SCTLR2.
>> TF-A needs to be aware of that change to allow accesses to those registers, and
>> thus must be patched [2] to enable this for QEMU platforms.
>>
>> Concerned test images need to be updated to allow them to boot.
>>
>> [1] https://lore.kernel.org/qemu-devel/20250714155836.1514748-1-richard.henderson@linaro.org/
>> [2] https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a/-/commit/c8836cec14213bf92dae79d353bc345254a0a31e
>>
>> Note: [2] will be upstreamed in TF-A once associated series on QEMU side is
>> merged.
>>
>> Pierrick Bouvier (2):
>>     tests/functional/test_aarch64_device_passthrough: update image
>>     tests/functional/test_aarch64_rme: update image
>>
>>    tests/functional/test_aarch64_device_passthrough.py | 9 +++++----
>>    tests/functional/test_aarch64_rme_sbsaref.py        | 9 +++++----
>>    tests/functional/test_aarch64_rme_virt.py           | 9 +++++----
>>    3 files changed, 15 insertions(+), 12 deletions(-)
>>
> 
> Thanks.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> 
> and queued with FEAT_MEC.  I'll re-post at some point closer to opening of the 10.2 tree.
>

Do you plan to merge FEAT_MEC for 10.1, or prefer to wait for 10.2?

> 
> r~


