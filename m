Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FC3CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 08:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF766-0002Wx-56; Sat, 01 Nov 2025 04:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF763-0002Wp-W9
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:36:28 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF761-0004TD-Mj
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:36:27 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d6984a5baso548760466b.3
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761986183; x=1762590983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwmzxnxMcNWTg1qgGvXZT3qjbU2W+Lne50o0I3zfZ1s=;
 b=U/03rMliEABLn/VMgtr8iBZZuK+QqqHkWPIcbrJwml9IWmLhRZvGBHiKu/0l2qfXlo
 GULe9NxXAbmu5TaJwbZ28upfeCG8xnIagh7lHZD5QeYcrpBKMBWTvKG1kdellDnzBq9G
 wgpBWcX+1vnZ/A3ysB+/HYdr0Yp20IQ6qAxLI85jFHpKEwvxTHqUqK75Dn1iQyi+yOL0
 mjmYLttb2c0CjVGirzDKouvMqT8ZZHV+QrfTQI0lxaPoU8L2/Lj4uuM70XC8D1KiHjW5
 a6aO+Gnsv+OELPZ0Vxhu2RVC+dSnWFiURz1dAsdGzD3BsgSweTraTs/mSa3xMHNl2NY9
 FblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761986183; x=1762590983;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwmzxnxMcNWTg1qgGvXZT3qjbU2W+Lne50o0I3zfZ1s=;
 b=W9a8qZXaNLN56KbEu1J7eQ8TPCar9vTnEh6eaaL+jTzKtDntuN8VawCSzUTsQYb0Ik
 SIQBD2qiUO1n6128lNM132zyUYH7Oi6QJ3eieXToffawwEanzUTcMN6H++BFn7KofKJ9
 axuI4pjPUJnFFMqpwimBZZ5UoqL6t6pi0iHOhesP44dSaDHrueesFg7nks5XtY22K9PX
 loGzILpPgWfiLAlXwGJIZ/+ZmxrsI0kAgSeEbM7UVJ5vs03pxUxILUpJ/RCce5qoyyT+
 SUBPRMEGU9KXqpTqH2384bJ3u72WKtLbJWh6vSUe6V9HQ1N4n+LYh81tJ5t0rGwxG8/y
 9abQ==
X-Gm-Message-State: AOJu0YziHg2NKhDdsZkDUJhoZhAxIYKEkO2jL+OptHY7Ag5aBG9zO57R
 Xal04VHw5jLXTzGJUlP6EfUJXtHkCLgywvBiliRpIeL5ZSDKnPYnSaH0h8JLzWdep1uiyuTIuzm
 kYeaurAU=
X-Gm-Gg: ASbGncskMR2JdzEtUo024Sl6h4rq/TGyw+cFW3fnotQ/JUpkC4GjPRjFsGmsrSIKba5
 mCSYN4ShYhydaf+ZZvM+ihJFbJy4jcgoKqqUGTd4oWXObDrLu1Sj6bXK38P1dpyDDMUf2y+ZjgI
 Sykfzm6hL39OYpt/IOckDV1q1Va7WeTKMWMPsN4KPzWcuPYsIVeOi4MTThTOBp1ZdEd4WbVyX3D
 ymixIi1mhOxbaY7xqg3gzH0iBz2zT0rY/qV+V811WASn6wKOOmPU7t2g/ydpFuYgVS6gr6LsfzX
 SeZQy96VjpXbWHWaXd7RZazbqx5lV/GPuo3yOctsj7pHtvku4cqQx3kAhzjMQFOoP9XB2q3gM0s
 G0RaGV5VNG6phYWwCYfsKkHHrkVqQpqkDhWRNFf0kppIzBNLWCOgFLl2dHU+Q1Gu329MQIfkJ53
 2k5ytvOfXYJKd8GHgkZ/tuahZWUcHJPD24jQriOsUxytYI4UBqkKKGwsFuAXD0aQ==
X-Google-Smtp-Source: AGHT+IFlvQMdTwlSY3lU2uM5+7bBP4MEpWxD1xKwPdrZaF7pEeDqK3HVSkW8ijxH33rq37vDtlMoAg==
X-Received: by 2002:a17:907:7207:b0:b45:8370:eefd with SMTP id
 a640c23a62f3a-b70700b5700mr639116066b.5.1761986182565; 
 Sat, 01 Nov 2025 01:36:22 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779a92besm399518566b.17.2025.11.01.01.36.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 01:36:22 -0700 (PDT)
Message-ID: <0d5bfe9c-332c-4006-951d-bf76d0914475@linaro.org>
Date: Sat, 1 Nov 2025 09:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] loongarch queue
To: qemu-devel@nongnu.org
References: <20251030024703.3730929-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030024703.3730929-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 10/30/25 03:47, Bibo Mao wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251030
> 
> for you to fetch changes up to c981119dab04ac20f86ae755a669d74fc1373cb7:
> 
>    target/loongarch: Add PTW feature support in KVM mode (2025-10-30 10:34:58 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20251030 queue


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

