Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSeS5-0001GT-PA; Tue, 31 Dec 2024 10:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSeS0-0001GH-UI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:46:32 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSeRx-0001D4-Sa
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:46:32 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso8618157f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735659985; x=1736264785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cvT/pIc0yf23O1K5niwbHNBn2XX6MUbv8wSaBPEAG0Y=;
 b=jL94U3kwVaIcWElnhsdT5DoD9mC3b/Z6HpTU66j4f36EoJ7S60W2/dDTWf+rn7nhoV
 ZiYzw09RYScEGb7+3z/v85Frxo2d3EXBAtAOFtJZDYgDVtyB9P4UuUGZi8Q70fU9MXLi
 uIi6ZFyAps4tiyUaFGh1foabAC1nS14f/6aX7uv+BwdFAo0sKL55HzlOonNRmftDC1ID
 E5KEgUE9w0ZGJSs+A4xEsWXbcBI2eIaD9/6uafSpljD5FGiqJZXId7uXVgy8Xm3DkifJ
 oPtKMQgWmIP5wzQ+kjWMAjJ3Z1W8gu9pOIHdTElihEe0bP8wXaTUiEUi37gEIQ1o9W3c
 aSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735659985; x=1736264785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvT/pIc0yf23O1K5niwbHNBn2XX6MUbv8wSaBPEAG0Y=;
 b=A61DQIe3kTPtm04uEg8ZZEh6s5OP3jUxc0ZIQ/RWGErgSyYUObweNyOEFnQ7senLnp
 oOR4QeXZwXAaj/spVbKu6naUGfBXvJVZBRaeCudH9ZsZ1BTSBlJV3TgpOJ6D0kFi14n3
 sV5FtiSYD+2neDAacho0TA61XXwj7wtgKS59paIhoXENW5J333+V4o2yPSTqXAORbUvW
 wmWElR+FdFUocLZwAK4gpSvF8HhXrfce49cv+esHlMGit2vCRU3B2qKIOVIUliTZ0Uc2
 vhue1JDkyDheycchVYgPuaGHgXg1ExXsw1ungNBxNjYZ2p2HMVwRtDgzzuSOUFDZ/9kA
 2BXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2pNjfZ94irkJ8yyxcIS6qeEqQor3dNVw+vi5oQzt6q+aGdpledfu8PfMCZ/+TfRqDRRDyVV5k+xO2@nongnu.org
X-Gm-Message-State: AOJu0YzKP4QqniMHOZWulFrL/qIXycewRRgMjCQX5Ru1Y05qnNJQCAER
 1mCGMkyJ7y58zm9zHmMZ1QJt/C9gve/z1SISu4OQoOM1ppjqsM7g69y60DsUoL4=
X-Gm-Gg: ASbGncuAEA85X3Lhf8511BnuZuiIv88MaaWu+jw4CArtXKosHbKyFq4zDRSxNF3eNec
 bYAugVEiNztH6pMTkdOPvgZwhEDzqwwabvRRMkEzCH8AH5O8S2V4ShhjO0XI44MN6QmHqeMAf2b
 QFvwMcUuJgP3qNKShF1t8Pq/bzoPPGqem3DESHhuU5a52qEb7BuPO6X942VPTuGQLdIJfArYHN3
 rQHKjDsy1bzS/FW1vs+hfKjUl0AXIA4i829QH3z41VJmAnU/HzkenWKCn3ZMxbUWRKLmetIuDDQ
 6cHItqsqiguhb8imjjFNaAiD
X-Google-Smtp-Source: AGHT+IELKna2feY+gRNf0rE5OKXRiDU/jjhI01agTnI8ff3pK4TF/eWr6dw1KPT4qCeRV6NAwcWsqg==
X-Received: by 2002:a05:6000:144b:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38a223ffb44mr33425330f8f.46.1735659985478; 
 Tue, 31 Dec 2024 07:46:25 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a457584bcsm15627024f8f.89.2024.12.31.07.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 07:46:24 -0800 (PST)
Message-ID: <e12a9b2d-3b51-4340-892f-f4e5da7ef161@linaro.org>
Date: Tue, 31 Dec 2024 16:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
 <6db51529-4754-49dc-8af5-2b40019ed30e@linaro.org>
 <3cc7d9a4-8153-4f40-8b84-142ba455913e@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3cc7d9a4-8153-4f40-8b84-142ba455913e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 30/12/24 22:30, Helge Deller wrote:
> On 12/30/24 21:47, Philippe Mathieu-Daudé wrote:
>> On 30/12/24 21:24, Helge Deller wrote:
>>> Hi Philippe,
>>>
>>> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>>>> Respin of:
>>>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>>>> deller@kernel.org/
>>>> "Add CPU reset function and speed up runtime and translation."
>>>>
>>>> - Remove hppa_cpu_init()
>>>
>>> Thanks for picking up my patches and integrating them properly
>>> with the reset code.
>>
>>
>>>> - Reset PSW using M bit (untested)
>>>
>>> We haven't implemented PSW-M support and the first
>>> thing the firmware does is to reprogram PSW.
>>> So, basically it's not needed.
>>
>> Good to know it isn't needed yet (I grepped and noticed
>> very few uses). Are you OK with the patch as is (as it
>> matches the spec)?
> 
> At least I don't have any objections as long as 32- and 64-bit
> CPUs still boot.
> 
> Will you respin the series, then I can test and review?

OK!


