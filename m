Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67736C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX1RG-0001AB-Dh; Wed, 02 Jul 2025 13:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uX1R7-00018c-RR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:39:58 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uX1R3-0002mf-9a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:39:55 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-408d14c7e92so3598822b6e.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751477990; x=1752082790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCO1pmG/oEoX7h1ClzEvRpSe1x+90mjgXsV/sza5k54=;
 b=m1hYM9+79++4ua7Nj0I9nudlI6idtiML2DR4oKZSoTWL6hiAHz6xfjW9LUwH997Rm5
 YN9sNInXH0eSm0lu7LO713O6Ilb03FVNHipq+ivXTj5qMQTH2hnub8s4gFwGKVRTQiuL
 pQFkogErVgfJwkzFsQJEdviASaAdHM3QiS2bULh3FQdPpv6qQWHxl1UdO+G4ZF+RSzSa
 oD8BjPT48Ol/Iogdq+JkU/Sfa25nHVgorg9Sf4uBcr9cU5OQ83I3udEW5mijHZS/Egb3
 msAZofc7VggZ+9T3N2usmu0eD5CerIr6zHeOShc4NywtP42o6fjl6HTLtBXAw1hauzo8
 v5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751477990; x=1752082790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCO1pmG/oEoX7h1ClzEvRpSe1x+90mjgXsV/sza5k54=;
 b=wV7jmo1i7TNRWgq/SWN7mzmTdWLyO7rmwrFa054U/nRaxP18FLiYCxBWkMXBpj8beB
 dsouoqMqGvBqjfU1hyJK9Hp8lZuUn0Z+uqjCEjxuPQ8RfehVGUvpx4i7xf4rn7etjggP
 Oek8iv4upE9Ygt+FAGmKEaKd+WRCTCH9i22ot0VxylqHYBcZWyYNaijkLNA8YWnvhv60
 Kn80IGtw4zbtQgEqAaPKUxZt6Jq6EWLS4xXzXhmV7w/K26koRdxrilTIYRBnKb5cDyl0
 seuAa8s5WLpazoXC7Lyrs2PQazwctk0Qdqluboxep7A1KoirdvIV+PjKoYrrJNGtYDAG
 cO/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+8Oy98o65WXt4QrrTe9aQASfrc1azB7+Mm1+7RpwDHRJlQs1W2UrxFSlTE7aUfDu5k5VgS3dyBAS@nongnu.org
X-Gm-Message-State: AOJu0YyN8KBhHsBwuZK+BVTw5wh6lGUasWzYGet5a4Th4++ry/O6R7/s
 WrIPE/wwe6kUoxhymV22Npe1x+e+re+u9UByFnzitCIYr42Zc3tD+8Y5U/w1j9SE4AXjQiRaWwO
 xFd+mCJI=
X-Gm-Gg: ASbGncuTMCk32gS3q01yu1sYF8AtKHl4xTTe08/zNNkjz3VfCqqnhDKz5UWLKIsi6GW
 yKibCoJuABvEbmsIg6Htyr6EyzZ+krfVqZjk5cbRx3CAgaDWIBwLDNPXqccjBQ5EvupW/mfyL/A
 6EuMLP4t+fDqpuH9AZbnokvbOVNEUBgPGqrrMM+WJJPDbWkJbuMDsqrJkP5YQnfx7nD0xx8T0/j
 kPaTohkByqqYTjeLCY+684226MPDP/wD5bPkyhHLZ6uqq2MvlqKYdxske0ecRpiIL7iyyFssUYE
 d/oOwlUE/YGLNGXFSI9NWAcBvabW6nIPQH2DR9i7tTdwazRL84jvIW8PaofdQIw5QTbnV+CShza
 o
X-Google-Smtp-Source: AGHT+IG/e/AqhqdwiXGEuHcVUvfdtzp/YC9hrUV6rymh/qlCXh+cLR0npKFrUa1UNquXUdnjIKGR7A==
X-Received: by 2002:a05:6808:f10:b0:40a:a971:3918 with SMTP id
 5614622812f47-40b8932ad13mr2679341b6e.38.1751477989690; 
 Wed, 02 Jul 2025 10:39:49 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32421047sm2625336b6e.41.2025.07.02.10.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 10:39:49 -0700 (PDT)
Message-ID: <6fc27701-4355-404b-9277-a5d323d86c78@linaro.org>
Date: Wed, 2 Jul 2025 11:39:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips: Restrict ITU to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250702164953.18579-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702164953.18579-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 7/2/25 10:49, Philippe Mathieu-Daudé wrote:
> MIPS Inter-Thread Communication Unit is implemented using
> TCG. Check for TCG both in Kconfig and CPS source.
> 
> Fixes: 2321d971b6f ("hw/mips: Add dependency MIPS_CPS -> MIPS_ITU")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/cps.c   | 4 ++--
>   hw/mips/Kconfig | 2 +-
>   hw/misc/Kconfig | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

