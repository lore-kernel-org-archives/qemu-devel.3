Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100A4CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96AV-00083N-Gp; Wed, 15 Oct 2025 14:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96AT-00082b-5D
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:24:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96AQ-0001dw-WF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:24:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2909448641eso2597125ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552641; x=1761157441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiAqh6nyIXIrUNeIOBSZyPCXFhQTs9A8R814sLO73eI=;
 b=CeFdaLnB/sRSOA0EkacHN1mufSNUXPnDKQtBtKaQ4FPPCxKva7gvyP6ZiXeEQDw0DQ
 BrV7TkzZkNfHgoL3gWGLWr0tJn6TEWjG1CLtg4H4ZnXO/XEOhmmvBS9H9PMoZg6pao5H
 I1SBJRp1+svOzu23kxV9deGy/Y+iLgMkLyIKi05HCDCtBeONidUKjr+Vwk2xTulpY2Wo
 FUw/qHEpia+kqs081Gh+rTDghmijhT0hMjwSFBg8EqOJUH3cDmiptU+Cx4hWqZZJ6XN6
 r9g9ZYMu8h7yHxQVHVXOUMhvEGmGBdWyGUHD8EVkm2z9roA8CGnkKNGztdPaS5DY7EuH
 T34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552641; x=1761157441;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EiAqh6nyIXIrUNeIOBSZyPCXFhQTs9A8R814sLO73eI=;
 b=i8IbkxgE+Tw5AwiudOFTHSwjs6dwh2A9i5MXB5vepRZDgr3HwfuxB8RYbYZtD37K8Y
 yVO8xUcTt+92PKifdoMS7P2vCqgErP/r1us28eQXhuFxNvsYADVvXbs1ET/PP7RIiuyE
 9AC8VV8tIlwV2deR4E0RIQSO5mNcR2lJwgDnEgv9eq/Q/SeBCzEjYfnqTMEZTo15OGIe
 KSJnH9lyxMPYPfcl6qtliJNUl8+O3tQgF64c8LtdkLWVipVs7BnHtGatIpBngt2rRzCa
 o5piu+ojj3+iJUWD22Cd15GqUeVUCzS1BoAuNdrgPb12kvlapbgYwEhR7GJE9+1I1KNM
 2LOQ==
X-Gm-Message-State: AOJu0Yx50+gFiK2FGsTGxXQuQ1gFrb8g+6bKDFTBNvqErms7662A01a9
 ipT072O8DMFlB/eFvJUGNR6a9EoQplzkSzIG6sYvbLahGNte8gH2YPehvJA/6g6JxXaU/XCXYdo
 gW7ehIfM=
X-Gm-Gg: ASbGncuMEUisYHWMDVnGbFru4iocmf9wE58S6sZtNY+8vFScxOeFG8KbCycwtdS4mmH
 mddWEAklvIcm2/QQN3Qzmk9XMItSn8ijE8exCLZVCZrHr4cESwZwl76mbQglt6755N/IQC9mAms
 gq7FfTqCG1amNMB9pA+REG6na5SFs0kUupKHyJ39NS7uGkt7SJapr6t7YRfaLcRE8/UZpjhZHJe
 W/UgSvqiYPbq4g3p8Msv/oZxqjBstcaBjHw2S3Ym0BnPoutU3K2f1ZVToDbRwZvxAvJMe2zM4zk
 9oZaP3DrgN2lZIQYMP5RdmUkw1YKcqfxKgEcy/ro88o9oLTLNxLWOks31S+r3Y7fhQBecMrY/8U
 jeWuvhcnLjOjRG4nPzpTx6uVQCkeFEmJfCcSMb1Yb8V5zjiXn+eMmqKNfFu5jxYl5zsPVsw==
X-Google-Smtp-Source: AGHT+IECwmeUnt5COvCnfvf1fFiPzLC0usL15baw9Rg/67bbsVSOjPBrM54r2+3/3wwQCnXC3fxodw==
X-Received: by 2002:a17:902:dac6:b0:272:a847:cabb with SMTP id
 d9443c01a7336-29091bdc6b0mr14633365ad.28.1760552640907; 
 Wed, 15 Oct 2025 11:24:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aaf693sm3015705ad.80.2025.10.15.11.24.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:24:00 -0700 (PDT)
Message-ID: <a1d3df84-395e-48c0-9aa7-403f6cf35ba2@linaro.org>
Date: Wed, 15 Oct 2025 11:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCG_i32
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
> bodies use a TCG_i32, so return the same type.
> 
> Suggested-by: Anton Johansson<anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 48 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

