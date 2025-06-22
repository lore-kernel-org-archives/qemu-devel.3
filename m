Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91088C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8jJ-000769-KI; Sat, 21 Jun 2025 20:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8j9-00075f-Nr
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:38:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8j8-0006Km-1Z
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:38:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2353a2bc210so25881965ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552708; x=1751157508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09Sc5vzD9cXtTYou4NrAnJxjs9BfTskMnoPzpu+3qPM=;
 b=gDbLaI/EhcfcY3vq/d7Rnrmna+IUO7V7d01bX6SBXkj/vyv4PIC17YfqfD5+zauP+N
 inAUIHzgUxsgqzycdIEKLJVI5ebgsUhSxiB9cJke4cMnNwWIgN1DQzvqP6oisitIJQZ+
 dli88X5iUpsUcjwCVWK+y0Cj5ZE+QhphL3Qxfw61Mq0gmHtjE1QCQkH5589sc9UClqGv
 95/6i3JqGF/8LpXN6QPlmjYNNfxjuwNG5FyFRDdjSAiyYs+IouTtWoOzJA7COx8Fq0Gn
 P9AUykMKiPZMSxARQ9da83dQfk0yhU4EPy49qkgvno1WRWii5/LxzyzrEjHZ20QxDDv/
 qPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552708; x=1751157508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09Sc5vzD9cXtTYou4NrAnJxjs9BfTskMnoPzpu+3qPM=;
 b=YrUJxlaY73z8eHOPDZkNu3ZPr2zM6cwxlUcjS6ntkowRbqv6wcCDvP8aWnfJ5Djxt5
 +Z4cv73nIOkO7Lo0R91CluOxVR+3aIuifdpetymvz/wtyk4lQLSoSlx6oayheFd3tjWE
 e/sQNFpVQBLZPJ6voItBcOMRg+wvrYspr7inTHgxjq4qnQjpW4Y5HGQhfxpvKM5yIdkQ
 TxiRyc2/L1J/LDTqqMbBZluOrTk7O/S7BEpStT5NoAU5pEIfLxCvCA2s7TlHJn1uNieD
 bMWLQXqp/PUTkd93wVTAAcA4PI2Xq8+T6V0zjzQLy95NoNnjoehAFy520w6ChH40MnBC
 i1Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiW8pAjisSLziaHT8R87N0mgthqVlHgrV89ZFl6YXwvAq+QY7ECrIHHbXx0iaBf4B9z+mcZN8H1G2h@nongnu.org
X-Gm-Message-State: AOJu0YxvCWZV/d3HWx1p4lFWco1sS+Trgljo4NfVrCm+Bvjx0qd9B6PA
 A7HHVSYFcTIJb2lSe4LM4d5Bi182XiDagEmTwFOX6vyFd5La9sHHVLbMBglKDckW6KdEEtYTplu
 xfWa1J1E=
X-Gm-Gg: ASbGncvY1g4tVs/N1FEiNBnRqiWxg+BTa3+uCQBnIb1IR+qrwFd6P6vzVqePsY78uZ8
 y/YE5xNFBgrhkoCsJh6vi5FWKkIKDxUOVWTiJsp+V+2AG+ZnW/gsPQXW/3Uhl+VCVntng4QankU
 3IlLfvlnV0rQ42tccttCuG9YRMMWvcwb4zOljdYLF8IjIncGBPPF+A0PAPl2cfK+bkHnQE1ZCXj
 5ebp0mNwl6foJUZVSIlT4evpAt3yx6y9nv0eQpa8yGh6WTFfRtcTUAcdPCiaXxs546QE6c0HinJ
 xY4NdImudXlHhMtyYoPIoJwrpvV8ZULX7rBbmnPaKw0QtrE/arD0LsanA2TxmYD08bCZcaYOjzO
 pwHSRAdeIc4I0QZGgpRgBQDZVTfVE
X-Google-Smtp-Source: AGHT+IF4j8wjQ1IOPfIt+Y3rMuolbXSpx0qNXwiapc7NWhos8jx5KvevGJLXrJ15/j6XW+SCFSL7Hw==
X-Received: by 2002:a17:902:ec8c:b0:234:a139:1203 with SMTP id
 d9443c01a7336-237d9960355mr125677305ad.32.1750552708366; 
 Sat, 21 Jun 2025 17:38:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393316sm50011905ad.12.2025.06.21.17.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:38:28 -0700 (PDT)
Message-ID: <33821a3e-38ef-4d8d-aa99-94ea535553c9@linaro.org>
Date: Sat, 21 Jun 2025 17:38:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/26] tests/functional: Add hvf_available() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-26-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   python/qemu/utils/__init__.py          | 2 +-
>   python/qemu/utils/accel.py             | 8 ++++++++
>   tests/functional/qemu_test/testcase.py | 6 ++++--
>   3 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

