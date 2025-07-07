Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD62C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYofP-0001hE-2r; Mon, 07 Jul 2025 12:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYobi-0008I4-Dh
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:22:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYobg-0002yc-9u
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:22:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso3280082f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751905334; x=1752510134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMzSasTd9fqmqki7I/moZNBuhtq3frEbKrrNQ/giGP4=;
 b=jcJMFj9hXNzICbZPG+9SSvGYRn+e7NSn6xVYpaBLSsQNdmIqZ3iSpvFSL+peX+XJeP
 Q0KEFsnpEthUw9CWKW1zmm1H6pJE3AImfW/LD6grhJMb4mffBX/QDBT70V9M+xvvptO1
 iL4OqtcYF2ZQO9vFf/DJeEPx1DeOqYI6O53hq6LaQJxhTsXANAx8hnInue89nKdULNrv
 GQKVLA+mtkyiYvKxENF2mR2k7MN57pUhTEAhWMo5eazYjHh08o5uiSCiYZTfJUluJg9V
 UPvGOfnP0nWng/4GDNoNgAtj/Kxzwb3jgy0ubGo20iwLlRhWUyp5h0DxxbDilOy6vVtT
 zoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751905334; x=1752510134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMzSasTd9fqmqki7I/moZNBuhtq3frEbKrrNQ/giGP4=;
 b=ujAOggUPFHgsmu3nvfZ5KZLQ46zlPsvm4jc6V4xdXXrPxJ9r9ZUTZ6dQ1jX+RIS+sI
 FaLbvyikViu6rFjVRXiZyWFzRmrPK38M42IRrZS1qRVM7Tz5KPfUvJzQuTSs8EyjO/rw
 0ceggWIqCtfxSqlxOb+1ssJDMDQRHDTZGOsNIFYaheg6tHY1U9B4tMcMnU5LquA9+MQT
 SYewR/wsDI6kgU/Rs/qR6iv1VNDS873+qKe028RzvxFda8Q5+cW3fmfFItXUPnh7hCLc
 HlCCywqJ4bSBgaUQ7978Exc8UQFQ3TN0dA1vI6COQW6Tm/2WOkHGyTc5H48A2h6mQhlN
 QaZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBO2ZnWV2LSFReVO9+Ln8lOp4VdRd3Lcw8AHjbw9qSCeTanvb1V5LNm3rnx1E4sY8zJ4M9JOUqZm6G@nongnu.org
X-Gm-Message-State: AOJu0Ywwk50MQY1dETvYAkv3+cJ7opByZdMNVf7SPY122qWmzPxWkoum
 pG2DDOAIzaUkEQHNHawnUbLV6DRIKKv0v/27fV714ehkge2jh4KJdDEVD4NDwnWV3uRTTpi004V
 9yY5U+l4=
X-Gm-Gg: ASbGncu+rsb9DnFSzjQ+ZVZF2gd2tPTswV1faRNj/Ko4E34Rd537Z6rYsCkERnFd7hL
 admkUWLNIvVxd23FFdxMRvJp/ImYdjExJQ8SMGjM1HL3o6QFPVJGlqOSzLzUduMELHo3RhM5QKY
 o/Ndg8RYX3IPFKDeWOrGiiD1SpOmlnvOyyVLiOY9CQxso231icWexZg9H8PT5BClLjnglGAOhGn
 6VWqq/PecvbN0DSK2dxwKh6gGuq46tGB0/AD67QZYBCMYqXez5/S47zE7geyad/ADOqiUFOL8sU
 +1Fn/u0VoYSXh+CNXldHeDTRIvd/Mu1J3HBOAxMDFXVeIDOTBqo4KyGSufZsYMlrIbDexLKDbtB
 qpFuNUxGJ1fecUyEE7WEhLpxxDuXTwA==
X-Google-Smtp-Source: AGHT+IGV+rk0Mid5gpcxeEjY1WicyxRVJjSuhsyN3xiuZknvRoDc6rgJJXNG3phbTcKgaAwF5PC2sA==
X-Received: by 2002:a05:6000:238a:b0:3a4:f513:7f03 with SMTP id
 ffacd0b85a97d-3b49aa7ae9fmr7884712f8f.44.1751905333680; 
 Mon, 07 Jul 2025 09:22:13 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a2e8sm10673221f8f.75.2025.07.07.09.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:22:13 -0700 (PDT)
Message-ID: <2d0c5898-76f6-43da-8789-96d0345f771e@linaro.org>
Date: Mon, 7 Jul 2025 18:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm: Split out performance monitor regs to
 cpregs-pmu.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250707151547.196393-1-richard.henderson@linaro.org>
 <20250707151547.196393-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707151547.196393-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/7/25 17:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h     |    3 +
>   target/arm/internals.h  |    2 +
>   target/arm/cpregs-pmu.c | 1309 +++++++++++++++++++++++++++++++++++++++
>   target/arm/helper.c     | 1287 +-------------------------------------
>   target/arm/meson.build  |    2 +
>   5 files changed, 1319 insertions(+), 1284 deletions(-)
>   create mode 100644 target/arm/cpregs-pmu.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


