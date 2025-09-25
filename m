Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FA8CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m1L-0002VG-Lk; Thu, 25 Sep 2025 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0v-0002IU-Np
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:28:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0m-00044T-Da
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:28:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so5382955e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758806855; x=1759411655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIKIQS0e4SSFIehEF/z0Pjj2S5uTgnqXK7kSBhCNOSQ=;
 b=VAuYTZsgIdCMoBr/vomY3OBNVxJJCmUOx8YYWIRKg4qRi/XendOitNZbmf1iYrkYmT
 CRG/33GL9HwZdHv0HSb67pqal0kwws+N/eO90AXF+/Y3ucF3da+B6szDrBXrV4OlX9Yr
 CkJyZM4iz1OMOIUElyWkWsrba/QkBvNmTP9aXrBlLbCiA/tF/AeRbLc9I7ul0Z3qt2Ts
 REynp+O5ZCpOGARi5onmnJY9JYjbIv7dkWUxUnCbTRrWqGvC/D9OSwfv7dEmCFZnyH14
 qdUy5RuheNievvYxajfwnjKD132FoMj6Hm7vx/Yjf1MuU8yeM1bDx4+p3fujPusW1teb
 xY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758806855; x=1759411655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIKIQS0e4SSFIehEF/z0Pjj2S5uTgnqXK7kSBhCNOSQ=;
 b=sS61+XTbKocogkYlY4hLCWZ66J9mOkQcNQtee8eW4i0oBIqVQR0q/SWHnVM5L8pMqg
 0E5PEWbyADOopuOFsHmwvbeGlae1CIxwPEg7maaN0mzucqHu7NIS1N/qnHKxBF8l+HjN
 BO2oXPuhfUytIN5bNsimY8uu3QfpV3qDUkC3VqH3pE27pzA788NAlvCn5JAD7KBFAfJ5
 jiOpuG5gL0TEdAOPobsv2JU/f1vuU4WdJlOZsEu/yySWVZ/v8eBcqBySCpZCORuae3Xq
 PkOuxi5/ZNNACISEVVYWqoVXDK9MIZQI2jZJHbe9J1qPww2qYx/IQNsHd1Fck7HJmOAj
 xbUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDg9U1SVCrlDT9FjIHOCDd30dO9Z7JN7DzCj3V5xzctsAmTt0DrSjCJDxLqrRwurT3dHIr85GUJyDV@nongnu.org
X-Gm-Message-State: AOJu0YzUdUtvOs25MaxwzGt3E6pgh+QrrUGDnDqeW1WGtBG0Lvs9e4N0
 6zYPxmSH3LOfIIac53c6zhMcq+hKZaU/Kcp6RnFBkBfB1vCUt8vXkScd3p77Jlvr5HQ=
X-Gm-Gg: ASbGncuELpsUTGar8r6JNVIt5O9AeQkkh68+uwxvqwqlYsuBj/P1hNaW2dITBHYLAX2
 n2n9tQtsfHulgJ0JWiYcVVxYrHH6xTkTfPFP28EuYABVfyJjWMlF7iccYQM+lLle3Nme6XJ+l7/
 s/YLG09FEYpt7KUOs2N+PZbt0Itsa6q5gEqedJ+7RVu1hLBMezsD00O09puGcerJgASpEdDAuZG
 agXZtzBawWoOGNXP72Q4m4S2xLzFN7RyBS9CFN3FuIUWX3txVSHhC+8D+loRpufmfYsKgA2tfQU
 ZFTI5Xgs8rucyT0IKfvBnghQE9YNvqoAe2WhB/pb1Il2HOPCwAEtTtpRnj/wWnP0eOEKi/Bq+ux
 w9zDsS1O0xG/68KK3bbNBGzFuzf1ZIJAueM8dE+a6z2wnZMyutCkJdKMR5pU1s1lFLA==
X-Google-Smtp-Source: AGHT+IECzjF1Xg4U/lSxMAEMWLQ4P1KclpSXvy5SCibuYk4ylSveQYXga2Wn6rbYQQ/GpPcy8jTN4A==
X-Received: by 2002:a05:600c:3588:b0:45d:d5cb:8dee with SMTP id
 5b1f17b1804b1-46e32a1c465mr44916365e9.33.1758806854821; 
 Thu, 25 Sep 2025 06:27:34 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm75846255e9.17.2025.09.25.06.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:27:34 -0700 (PDT)
Message-ID: <d8915b07-fab1-4ef0-9bbc-6fda4260b7c6@linaro.org>
Date: Thu, 25 Sep 2025 15:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/36] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2
 during translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  6 ++++
>   target/arm/gdbstub.c           |  5 ++++
>   target/arm/helper.c            | 53 +---------------------------------
>   target/arm/tcg/translate-a64.c |  9 ++++++
>   4 files changed, 21 insertions(+), 52 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


