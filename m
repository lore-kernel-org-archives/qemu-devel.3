Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F36CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuX2-0002Wx-S9; Wed, 17 Sep 2025 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuX0-0002Vy-Qp
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:57:18 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuWz-0006aS-80
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:57:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so2014751a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124634; x=1758729434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bupv5B6htqsvBANyvY6uKCINKi9p3Pj1w/o59z56t6M=;
 b=tFFspdx1reg0rjJIc542pyjJUU9z/2nbGueN04jUeaFMv+1SnTYDGy6sMJO4N9P5Zn
 4QniXcu3IuBnCl2THjLJSdOOxwQ9NA3QFmjmrFNxP3xsbd+6zqgCnAUYG3QtqJzHZ82x
 dWy3lFTx/xLRovfHYme9PjJ0bCKWWXl+KhgQODRBX9NsjkqbD9EwKVA5OLFmUvBSGI/3
 +Po9Lnf3TPhA2WULgFgX/xkVxE19IAOUaTbW5eR0z3Cyf8VvVppVMXrSRDN4KJZogWJw
 mu7Ka6i0YfU216wkCA6coSO3415kDboxHqKAUaZ13Bmj3+MYBZhgkCd2MYwT8giv8LAi
 E8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124634; x=1758729434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bupv5B6htqsvBANyvY6uKCINKi9p3Pj1w/o59z56t6M=;
 b=eeWvfPZvWb8R/a3JIXtCX3wEdTQeuARcdhKUCOOEIExXwN2opKOI6B6Qg3KBYyijdg
 egW8NrceQgojS38k8A8uPPyc6JioyGT0IYrCD1bsMMHLGzOm74tNK3W7UUtxSXNwqeqh
 Qskc6ntnKLdPzjOzkp+5/gSzbYiypF8yY5J6LdnXejXT1XBfd1YgAHLY497qLseWlUKl
 gknaNqQP27IL7hitkgdLmojm60Ouz3+kQHr2f/cWRnzKmtKQM5PKuJegw2Kzba8RK6MG
 WXJPlOuYPfuHE4SjJquzJKgjvsVl+g3Kt8ftfSU7NUVDWyrQ61jvo1h4f6yX+2NE4t9Q
 c8GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX20Ive/pSrdn39M7iv5mWRoEYYr7Z5BkBDoWAm6UpbArpX/dGsjOs+MgJYEComHAxk0te4/Uq+d3jo@nongnu.org
X-Gm-Message-State: AOJu0Yzdgk2byBWa4jKQxuQV8l+ulW5MEOJnbYnBTSG7CXC9ipYfExvj
 XSxPWHlH7ESYghOgivFqqCg1iSt+f6C0C5b0gKP77r9MZfG8w2lXP69bVvY4rcn4RAQ=
X-Gm-Gg: ASbGncvDDe5ccdCnJXATEcBw71q1fLlWAbLwRhI+qempT8v+uYBeHNy2IQRMl2lMe2a
 l6gnHrr7Th3FEC7SJX86f+l5Fm5yDX6Hg2PKYIFpJe48LRvwACoSToyaD2HIfT2Cg9gKF3r5v6K
 19vEYUMzSKhw/UNkINtoQe0J5Dozoq4zEpt2BJo+OdhLa+sOcMAQ1fHpMVhPTNa5zrESrlodFHK
 Iod6eSvTEvO6qIOBnTyEbUorp9bFg2Dw1koPFVKXudFk8hxN1A2XsyY8x2uep5VzjSPJWJ6g58S
 WBqzoYtU7qQGxjenq0B3pzPTCSKLm1Zpue0pBER9iLf/gCuurJs0FJoNhEzqWL8EU2KE5rJdjhJ
 iOmOCNzLItZauq/K6leWNzDGTWEYaHJV5lFYyMPtjhQu1J75MmxSdWvo=
X-Google-Smtp-Source: AGHT+IFKecNGPTGOrseYU9xHTmWv7Z+nImG1VdLH0FmlBeJp4OO0Jf0YYc4Xbj35CIbgFtzt1Y70DA==
X-Received: by 2002:a17:90b:4a41:b0:32e:a6b6:6d00 with SMTP id
 98e67ed59e1d1-32ee3f20ab5mr3424219a91.25.1758124634179; 
 Wed, 17 Sep 2025 08:57:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed257bb5asm2809015a91.0.2025.09.17.08.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:57:13 -0700 (PDT)
Message-ID: <cd595791-a110-4088-98dd-fefb90fa2da2@linaro.org>
Date: Wed, 17 Sep 2025 08:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/35] hw/arm: QOM-ify AddressSpace
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-5-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917-qom-v1-5-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 9/17/25 05:56, Akihiko Odaki wrote:
> Make AddressSpaces QOM objects to ensure that they are destroyed when
> their owners are finalized and also to get a unique path for debugging
> output.
> 
> The name arguments were used to distinguish AddresSpaces in debugging
> output, but they will represent property names after QOM-ification and
> debugging output will show QOM paths. So change them to make them more
> concise and also avoid conflicts with other properties.
> 
> Signed-off-by: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/arm/armv7m.c         | 2 +-
>   hw/arm/aspeed_ast27x0.c | 2 +-
>   hw/arm/smmu-common.c    | 5 +++--
>   3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

