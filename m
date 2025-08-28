Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE0FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOcf-0004h7-T3; Sat, 30 Aug 2025 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkKr-0005gU-7y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:39:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkKp-00028e-7i
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:39:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7c01a8c1so8842725e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756417145; x=1757021945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/ybPDxuccjEds2ecUsFslOZm0UVG2uyqnDmrkMIpJw=;
 b=YdTlnIIxoT6zVkQTkBjoOo2xS4kZ16WDFXH0D93EQPaT8xqzmyhJb24qjLB+UXjyPd
 +elv5p2RJhkOeUqXQtpUDgFwmYlW2ixXUq8edz6qRH0jomgqOPTSwoqe9WFXljKQULtz
 a2o6DUhiWGky+xEa9sp5AzB5VU6rKeeyFyYs3cyRRhTgvcIJMjWczo3ISKpGP6sluGQm
 BAttdcOC2y7r9nog05WOltthHC5mP9Gqwn8qewWUv5P75+D91p6tvmB41Z9uIBwiJEhS
 XcYmjBzQSSomoJYRXMmjZo8Rzd1uw1usxY47XrFr2tMFA5YsgX+fqPE9PFXzsgoOykRs
 R+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417145; x=1757021945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/ybPDxuccjEds2ecUsFslOZm0UVG2uyqnDmrkMIpJw=;
 b=Thv/0n9rcCAB6Y9qwnGCN/MWQbRl0ghkFYMeqigrz5IHxOLvjrzlcuzgnvOyONaiaD
 0dp/z3eBMmEb13TnOrWSCVxNnr1s72ftHykdvPatIUfaUTkLOCtN6X0DLtrfNB92oUdU
 +1C8Oz+Sbt7cwoWsAC6Ijtc4pWtew9Ja2Kn+7S5hxCTDyw6EU7WDzJ3tOnV2GwaJg5oQ
 UX+8ZTmQlWHvMk2g3HEyvwOOGinKfFdr7V6FbD3oR4uMSUJFvmdO2ms/171OR6rVC2uY
 6F+o18rMnECaX3fwRpRHDZW4SEKH56lDZxKTp+p43pHn8Z7lUKw6Scvub9m6tBbd8Prq
 vA/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNyYDbbIK+PmHphlmzqIMhnqxn9x0FrVLoaYXm2DZEHlHaUrPHPAIguagL3te0J5XzOZt3FXtnRbAa@nongnu.org
X-Gm-Message-State: AOJu0YxXCISteUwGOT4ljP2wSgStmBDStZZyHAAFAsoKC4zOFLCNfJQx
 IGHWkY6zF1+SFkys2VswxrkBokEzFrOiFEDc8TCpoJVP1wcbJGjYx6zeKYFUVy26WEdVOrNU2lX
 +G/rO
X-Gm-Gg: ASbGncvlIKy94W6EvVqdnGbXSClGigQPzsrfGOwEdd/x6sfnnZejfm979XQTlQNtOwv
 +7URsajx59MTSB+OnhmgadQ7gK947rh8V/NwCeNjTG7CGxbiKSRbqVTH5p7bIPLVMXtgoaKs5QA
 f1lpuzFEaRkGaNkok/AKc0B1kpylrEwcbMaXyh7dLY1Ivoy2iyRh6fvJRrtKf1EztYh5odlQnOs
 Jx7/Mq+nLXgxk8puKdHst5kvdu4SQsihlIoe/F/uTHrIpzjgMRjQVJuaFrPwhRHhMP8JbC7TbSW
 Rx87HU3zKBPh7A83F2nJtAP6xdOEZKoFMJCFQXIcuvKh6H6BH0qVWXRkn0xFNW0AhfSllZPC5YD
 tYwIKwf6UqyO0Vvndaet3ZxDSfNP1LsMUsQGZ20NvoT5/bZFi8sUAbiVBv2MkQk1JD+UZG5ZU8J
 +5
X-Google-Smtp-Source: AGHT+IH/w3FYCh3UrvnXbWtg4uotCc/a//IsVK9EtqOD4USrWXmSl2qWAGX0FxtVgxH/ox1fSkg4dg==
X-Received: by 2002:a05:6000:24c9:b0:3b7:93d3:f478 with SMTP id
 ffacd0b85a97d-3c5dce01212mr19690915f8f.51.1756417145105; 
 Thu, 28 Aug 2025 14:39:05 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d305fsm103163985e9.8.2025.08.28.14.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:39:04 -0700 (PDT)
Message-ID: <9de20042-35c5-4fec-90cc-e322406694e1@linaro.org>
Date: Thu, 28 Aug 2025 23:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828162012.3307647-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 28/8/25 18:20, Peter Maydell wrote:
> The user-mode '-p' option has been deprecated since 9.0 and
> doesn't do anything except emit a warning. We are well past
> our minimum deprecation period, so drop the option.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 10 ----------
>   docs/about/removed-features.rst |  8 ++++++++
>   bsd-user/main.c                 |  8 --------
>   linux-user/main.c               | 12 ------------
>   4 files changed, 8 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


