Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2079CCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62vs-0001aa-1P; Tue, 07 Oct 2025 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62vq-0001Xl-9X
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:20:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62vo-0002Tk-1o
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:20:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e52279279so39296165e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825222; x=1760430022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AQpyYJda5BwQX7NaNKpvdpkdbXRzQ50X2bEAUJACW8=;
 b=WopvZ6cY9S+Z38xdKISLA8+Jsr599qBp6SLO9N/88xPtQUZvJp6Oq4mCjqKMgnm/FI
 LJBm3O04tjN4AebFW83K7h7Mp3DDFyZViX+dDWBBFQ6O3SZFx0IwvXqF3SeNTOI3oyor
 9VwpBSo2R7YW7OCq9srXXvvp30yKyeG/RGgaJA8bvgNo/AKKbQhnOdv5D8ulZGAW+2he
 C0g90pn4UM2JwFtsxZ8quqqwAiASiqEk8QaYHhw1VlOs2kbFUdq/encl0gK6t2zsaWhz
 RjTiidmEVPjMUVoss/CoP4WDxVrsNFcqfyaAyy3/P+CGQ2ZoVy4/X2R0szEtQyR0kBsE
 /LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825222; x=1760430022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AQpyYJda5BwQX7NaNKpvdpkdbXRzQ50X2bEAUJACW8=;
 b=fc/yPXOHF/dmSDV8BWSHdWUVEwUOiqdo7MrT5BMb+iW4yqpwty/dFPeg+ShC2FEG7g
 J/dD6clt7QiHLJS0gkyLrLiBWoMjkqxOGMKBcRIJNXvnCnWQRE7gx7YQz4YzfKFmsnza
 3tB1IJLrcvNRttUGlx06QIsXHVp43I6OykcfQs3fQEWIib3Vjqk7Z5T96xz6ipEc+txg
 SvYGPj0gqfSDDu+klDBTwjvbgpnosFHQEquDZ8w1MFwoDT2KG+1qmtbhxnktweGP3c00
 GM0fEHo6gYWjp1Pzm3RWQ80OTgYOjTTs2skAN0Vy05gtl+WGmwdA6yYrWTg1TfGDb4nd
 gHQg==
X-Gm-Message-State: AOJu0YxGRIJcICnG4ObeVe+qgeoMBNb6GAT3wNddamJ3QgkigpQ1N4z6
 6p/YpIdL4cBag8Tru6QyEcW2EY98zq29k2jRLfBSjhmXlDAjKL3BKpFVKfGWVlDhb0R6dK7yR32
 ODUaw77gB5A==
X-Gm-Gg: ASbGncvbAEPfsNj2k7n2Mul0MgkpDoVCQEgsfGd31m/oiFn6cUCBaveZKcejFpkTyD2
 Ev0/abBejTWKOOHTzXza3ZTgNEe/vpkdVmfCxFKNVe7CMBwMgMg35ADr7HEGEVpWjQMWRC8Hw/W
 7wK6reQU5cZAqnh6MgTiVllcXzXFWeSPbGvSw6EF2A5yXrMDQVFG62WyODJNu8NRW8tZfoBwHZ1
 pUFD58XOtwmtW+s0NN4MJKJjOWSJXni9gsl7FeJArv4Mzaa7aM6y8aGBjHRHw25FbCSTjgxommA
 iUv3XKCPUvJbN7D4zM/M7QPa0Op5BUMKRQa+6exYw6ngYU4bGzRlnKoqBhnXk1ee7Ywj8NYrr9F
 QrLx/Q8l7Oj4nwYeSvw9QnN5Q/TOEQtXZ4bi350ph5Mo9vsuzwVy0MQY7tUsPiCAzJ8L3q8mDY0
 zZ7rbPs/sDYTqCctdeLg==
X-Google-Smtp-Source: AGHT+IHPulp6NCTIbpYrLbKlwBwP2FiZyH9wWVz0BW9UCcxhOuyoE7/lpmGCq0wUdFnmWVuBvaqe2Q==
X-Received: by 2002:a05:600c:1389:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46e711002b0mr115086085e9.7.1759825221964; 
 Tue, 07 Oct 2025 01:20:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72359e0asm203071895e9.12.2025.10.07.01.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:20:21 -0700 (PDT)
Message-ID: <acb53ce2-447d-4e90-9563-8106b71a8849@linaro.org>
Date: Tue, 7 Oct 2025 10:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Remove pointless @cpu_halted TCGv
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250925012454.60602-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925012454.60602-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 25/9/25 03:24, Philippe Mathieu-Daudé wrote:
> Avoid registering a TCGv to write the generic CPUState::halted
> field. Access it directly via @env in both STOP / HALT opcodes.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250924171308.53036-1-philmd@linaro.org>
> ---
>   target/m68k/translate.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Queued, thanks.

