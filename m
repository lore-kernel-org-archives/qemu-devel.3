Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D56ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untCI-0002RA-RS; Mon, 18 Aug 2025 02:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untC9-0002Hj-8e
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:18:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untC6-0007R6-Bf
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:18:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b0b42d5so25153155e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755497889; x=1756102689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hQjPiFK/NCUlRDJasVDm1+ZRRFRuqMOgLkBCbpILOhw=;
 b=V7uwvsZX6YHZy275k/RS+VPW+5opuVAd01BsI/Lfrhn1W02JmuTgWXQyIwP4HL9jSy
 j5mUnvi8S5Md3lRiTrLbG8/2liWOx0Upp2DCt3oHHy1Nv4XRWQ0F3Pd2CWXUX66i/JK8
 8jECm7eNGA69pdFAshAj1/atrk5z+Bx6Gt4gJsGj3b2mMGCmPX4euis3eMsBxtYD6koA
 wT+UPk7PQWEo66Hiu81/vp7I73LTRxmKrG6oF+r+0szNE/mr/HOtFHTBQPyNNn+M5g4K
 oI+YjBNTvjJBfgYjLOpd4Hza+3lIobAe7HKCTh5CktfBQkXrBIlw9+leY04Ha2QqMh3t
 hKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755497889; x=1756102689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hQjPiFK/NCUlRDJasVDm1+ZRRFRuqMOgLkBCbpILOhw=;
 b=vHpSjSFg8xnpAm5Mjm6QPu8cinx1BagVMWsjkdw3QP6xfINroT31KZwdck5ZXYP7Wf
 CiuY4F6Cc3j1DQ4ztq0emC4MgLbGZlU6e1kYSwZIcd8nMbMUxqN+JWrXINbvC4LayS0Q
 tX1S4lwCd+GkpMIny7PAiVBAbtvJI3VtpPs4sE07DagTjSJkmYENqA7hlxEI92D3hP5V
 MjjQ7XUhG8vrJeozpLA/bQzax87x7FBFKgH6ZCVFa6pFhLa4KfOSyGH9KEdX6LKs1yM7
 r+OKW2ngr8rlmnPjGo3Fqfgtu9e/yBH4cRVj3bP31KLImhBMXfmv++avJhReYP63dycb
 AW1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtfPgp2pl28ke/P1vAOVzdICbUtYFCWItnCl+JXE2rg+RAHTxoBFvXtPJ6IBI9Z4gl1dgEan0p+dD5@nongnu.org
X-Gm-Message-State: AOJu0Yxr5fTwcs+MrT6VhTBxiIkNqwyWIE8M6XfeZRw9vh+i5uVmtFVD
 gmejxooCImJcLr3C6od/5cXqrOydTz39bM0wq6pN9UpM5tODRyqR/ugUB+nvtX2qk4CZinJHxV8
 ZhC2D
X-Gm-Gg: ASbGncsxg7sKiD+ZXFOoHaWdq3/cfCGKCB0nduniIG5zgnCQxh9dfoh3+WQXqfm23ND
 Hqo04P7XTNbSQNr5RsPyWrN8ON3AykiM/SSSFfmDBvDVwyeSDOdNsBTk7Bl6XCY5SIJxW/XALml
 7ePBoTwgerKAmFKdHmJ2VzVy3Vvc9O/PXVDod4i9x2u+d4v/DYjkR44xEGT5DdQTaMRo1m9JoBm
 OeVjveAN7RNpgGLkEa0aOc5TVvFuwj7ncSf8eGOnhG2Yq0kIBzVXbYKPf60rQyLH0rgI8UnDizT
 9guGMQv/ioogBMttXaLUJUiR4TwjN37eizKHDxxDKVOg/jcIohX1gaPkG5r8xh9AsZvjWAkICrg
 jxTXifxAsMi2hxdD7l+S2XQXva9kO3uGICnRM/TAukJ8dJBtd7xXL/gjumbT8dEQY5A==
X-Google-Smtp-Source: AGHT+IFbkhviztC1XRHSdB/uBbBenBHTlWdqcJVjykGBGW4AomZdE5cJsMOHNcpbJd+bfcQrlc+CwA==
X-Received: by 2002:a05:600c:3b20:b0:459:e06b:afbd with SMTP id
 5b1f17b1804b1-45a2185e958mr81252675e9.29.1755497888829; 
 Sun, 17 Aug 2025 23:18:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1fe2c019sm138401305e9.17.2025.08.17.23.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:18:08 -0700 (PDT)
Message-ID: <b4e7a5ba-fc67-44a2-b662-927e14cae5f2@linaro.org>
Date: Mon, 18 Aug 2025 08:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/arm/hvf: Sort the cpreg_indexes array
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 18/8/25 06:13, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


