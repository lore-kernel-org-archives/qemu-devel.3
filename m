Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718A6C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9muL-00019M-RH; Tue, 29 Apr 2025 11:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9muJ-00017q-RA
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:30:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9muI-0005TX-4d
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:30:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so24204395e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745940600; x=1746545400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcR/48vA20vSoICEE1sIu/cVLt9/pwqBLkytLSHavfk=;
 b=xkf1sbUCzQApcjfstSDLpJG7SLAJWMbFYkDHuvhNBb3NpfSe5VS6IbV2Zk5qIhHmeB
 5bRGpAff2QFJNUpf4ZsnTi32xpcPv/nWImbeD6eWtTkf3iUT09dMGPz1T+KDesy8Hjve
 B/D3eHLx+zBYqJVVh8pFi8gXZBHxtpyiQ5fhqIqeoZDjbqDtsgMCYvCQTLSUFWzekF9Y
 Loj82jOgAL+TFJQ8xtQKna3QZCtgo4E6KfmpTC4Ip0lfQdIwLZp+u4x+rzlS7PYS2PII
 j/DgJV/kKkULpB8ARuKvs6tPmXFHaNJoZZyiSFv4U+475wIw3XHCrY1ehKzAb+onyKvf
 Lwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940600; x=1746545400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcR/48vA20vSoICEE1sIu/cVLt9/pwqBLkytLSHavfk=;
 b=XIU7lyTax2FuqMWZZd/DPqXFJUKnHFqAxvWRcbFZvOApNXdK0DBIUEnAgHtfH7vf1e
 l9XC+aDrR7QpekoCLBmbBHs+tZazvsNpyiMX3OJbKMf07rVTu181Hq1WlTBlMArReldn
 SJF1vJdUM6cty6oZG8YjYp7DD6cHUP2+t2lAShwWi1N7K42JmS7A2Duqs+oBzfp3y5Zc
 yspM/5sPXlLstd83ChYzI1wBT2sg0YnuM08/a3UmtQXf3x0/t7LzxtUlcWqRhyFWKYrO
 /3nH8KmIUiQKLok0LLYAHdAO8o1+lRpc2ufdb8kLXfqtkRIFyC0oxgQHDz0gi8oJTs+2
 LJpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDA6mB305Y7v8bvZ6wocXY9bPCFM0YrTJ0txqgLekxHlyHoLwPMoHjZKpQ+diE6FQbJHVef3k100Cs@nongnu.org
X-Gm-Message-State: AOJu0YwjP/EGGpRz1LsmOBB/3DOWVjoMxs3fATCYM5M2iYtGa/e2Y2Br
 WDkou+poWOA9VKzL/uzC3kJxTCTrxA9nb41DgNOiD9hNgyWFnaQy2UjzotHrHIk=
X-Gm-Gg: ASbGnct1UEZiXS9qhh5XTSkNz4andoGcH/RypXpues0TL0jV9U7HxwsMsgWKaxaUbq/
 6ZqlRvzXYXw8YmxAqHcA8FVWgnwzgyRiW5URY5SNsRlnXrHFr3tceRKD1Xu27igPg6Ar08nkdFW
 rPyCrwqPI0l9UGBNcxm70ygs/HJM6oAcjIeqop+thYpzNCKi8xqq5NwVffRxTojwdGFnQubOI6m
 okIXpIt2CFuyUrTHNMjuaqUU8KzKgBhyESfBgVOCqadmpfuLJdGUqq4CPcFaPbSwuVzFzI3z+lt
 U24OJJQF/Do/cbaR+2vbP6xPrwkynzafgGBeqF10X3kfjOJ0MPzD7wXpFlxjksQvE2JLgLyC0WZ
 1HDFAh6V7dEE+JQ==
X-Google-Smtp-Source: AGHT+IEp9oMJW5zthKuAsxN07dLTNQ5ohwpv8PRYKRVC1dsV0LMR4kZkZ4GNRSlX8YLQ+67XKx71qg==
X-Received: by 2002:a05:600c:4f8f:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-440ab7b5f6emr132826025e9.10.1745940599837; 
 Tue, 29 Apr 2025 08:29:59 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm162858425e9.26.2025.04.29.08.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:29:59 -0700 (PDT)
Message-ID: <57a4f76e-43b8-484e-9a7f-5cf85374a177@linaro.org>
Date: Tue, 29 Apr 2025 17:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/vmstate-static-checker-data: Remove old dump
 files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429152141.294380-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 29/4/25 17:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These files reference QEMU machine types that have already been
> removed and thus are of no use anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                  |    1 -
>   tests/vmstate-static-checker-data/dump1.json | 1163 ------------------
>   tests/vmstate-static-checker-data/dump2.json |  968 ---------------
>   3 files changed, 2132 deletions(-)
>   delete mode 100644 tests/vmstate-static-checker-data/dump1.json
>   delete mode 100644 tests/vmstate-static-checker-data/dump2.json

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


