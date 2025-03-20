Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5563AC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9of-0003D9-2Z; Thu, 20 Mar 2025 02:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv9od-0003CS-NE
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:55:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv9oc-000196-14
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:55:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso1584465e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742453740; x=1743058540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daPdedih6TBtuRJGD6J/YbjyQOU5bA7H/LL1UCXxGFk=;
 b=WW5+n+EYj/j20oHt6c1Ujzuwwp+l0m1FccQZX9IByQr2dEHnfrKFgtfm6Qr04x+usV
 vM1M1vQcvCHNNX8l+VbgAuFLbnHMMvQi2s9itsqDV2faK/LnhKWgXls4xIyGkTDzd61M
 GLTDrkbw4ODZKdgOvqYnB9IbluHFQcoEsSfR20tIYnzhbJfvElaV5YKHNoNZK4B7eJKZ
 2ShwMOX0jtDvyr+WjG4LrBFecChalVuDmOI/4iCgkUiYb4tUf2l1jhG0URm2c6YIvN9l
 1l6aDKWgOZEaIDxJLFoaPGjtIqKJW2idfyvHO/AK/aFeUTxqBAMjB2vVSguNmq++iEvZ
 UGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742453740; x=1743058540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daPdedih6TBtuRJGD6J/YbjyQOU5bA7H/LL1UCXxGFk=;
 b=IGhRoqMYOswzQxCZaEF12O5rq2YqhuDUoI4BeM7TAWpTFKRXW+3StLhrxTvdf59+b/
 PlqWD3XG1aI3qm9xZdv/PNinRVkkOA5mf85nYrmjynr5Trj0DpDJLkMOXD4buf6ZYau1
 T/WyCk2zbF6v0B6ZCvIs5N19Y8PRDeZJDXohhhZVjZiKSaFeSLRwF9l8sMVQbrDSmB6n
 9reIZ86RV3UL7A0w8DC8jt0G0dxCdcaF/Aj8UPyqtAkjkQlVC3zYg8Qjt/Dn8dTaY3Iw
 odzgMOkpkb62whtw7S1A7qjkynqP/lhgmy6GS37PWEqy1IhnUKyuXkxLWeISKzn8ZRmD
 f4qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vd5eY9rpIYhvK4kG/9CACuvnyQVFP/i8yH/Cho9pDmwEI5vNXvhbDRWcqO9FeHI+W8tJcfy7K3s7@nongnu.org
X-Gm-Message-State: AOJu0Yy5wzlVJuiaStczxYmK48SXpj+HpOPZWd5JJfAX82lef/neV+qY
 czvL+1cZ+LZl4Yt70XngY9gdww0ul2P3Kns586DZ83lPtu/G1zLUV8A7sMcrxpo=
X-Gm-Gg: ASbGncuQC5BbPRth5AJ7xsn5ck5/3LFaKDTk5IXiWabImH0jKTUCs5ypaFBuQ96v6Hz
 bpikyVQc6XUm1TvqegQw5h2vBThvzswfsVZB503vbhyd4hbvwd4TW0ua6MXZaD6mu+Zr8RQavrN
 2affpLCnMRsxFTbH5HDWs5QupQxrdEQmUEAgC6pDn+q6ga3Ogz35U4vcSanszi0n2LivYapomtl
 Mwbpvk925vTaRdk5hi87c9ef3/dDa5ayS0Fmp+MtKPE+evroYB4CV1CzLnM6oTg8ahbh7p36HPd
 fdCqYzybZkmIM/xS1HwHOtYsKteZhpQJlP2HjcmVJiwkJH6av61pfJQlca7Jl194B6aKyk20jda
 nLB0sf8RDoA4e
X-Google-Smtp-Source: AGHT+IFSg0Ekfq8E1br+jOiFHSZpUF+Q+mclaFtVZfSQAnDpgTjuNK1Z1h1nWiZtmlU+/VLAxO9iJQ==
X-Received: by 2002:adf:a41a:0:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-399739c96acmr3525089f8f.29.1742453740327; 
 Wed, 19 Mar 2025 23:55:40 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3978ef9a23bsm18697793f8f.15.2025.03.19.23.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:55:39 -0700 (PDT)
Message-ID: <575d70d4-a9e4-438e-97c3-1ff40d6ca5a3@linaro.org>
Date: Thu, 20 Mar 2025 07:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/ppc: make ppc_maybe_bswap_register static
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-7-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-7-alex.bennee@linaro.org>
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

On 19/3/25 19:22, Alex Bennée wrote:
> It's not used outside of the gdbstub code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/ppc/cpu.h     | 1 -
>   target/ppc/gdbstub.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


