Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFAAC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0ts-0006O0-Ou; Wed, 30 Apr 2025 02:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0tq-0006Np-6A
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:26:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA0tm-0005Hy-UU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:26:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so63006865e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745994385; x=1746599185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lHu33LUDtg0kcAgSiKjUqcyTlQI9RlTC4ZuwujDN2RA=;
 b=XAfE4re5/lU99szHK/idIlLdir2NSCXX2MkT4JEGGmZB7x+TVUl4tqhUcq8D49uT9w
 EO96evbMUoyTKwhZyR/DJBCBDSqy3TpLPU6QFUA3xNCaSPOhGfPc1kWemnz9pZzWvBcu
 3sp0h8EtDz6ezdEEk4mefcBti0YHEKQLHjjlgryd9YyquDEq1Upn42HssavPMHpXH68M
 J84krqqBiB7r4ZR203ySnBp0iuqPn6ecaSjQ/lOIgyzjrvgZJ1QzdJu+6EITFfIGbVmE
 mCM+Fs9iyNW2AjMlfo4iglNFEr+hcoV9AKDjuBxGJ+IqOr5CtpNDkbmHXvC+iGeERSTm
 IFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745994385; x=1746599185;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHu33LUDtg0kcAgSiKjUqcyTlQI9RlTC4ZuwujDN2RA=;
 b=hSd6gBTBBY1cmF+500qHADLVFClESfgVi0U7AaheR0s1yuqM17tJl/7Cw/e1lN0tl8
 z7bV8Hq7kRhEjmGK7NdHEXEBPemdpLQcg8zNdS1MmE2LuX0C3fPGlo2TYX3foPNzQWSF
 ErbsWxqBTHfXSPf2g66BvsvPvXEmTqrQexZT4FTH4zKfPRwGm4O9GvHnkfJTmeYEo8f9
 ERVGHt9dtXIBH9WQgjvsOrgcgOHSJn1HUgxF5rMQt18XUtnz4NAfb8bbA0q0vNT7H6hh
 6nw6VIcTFdGshgFCVGXX09i2I4hrVR0NWB4wBGWqLpC0h6sS2MWRGY0u6QuhM/xO3xDW
 1Ldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0X6BW/HGbXa8au9iXS/GHH4gz8jepN1UAt8d2llQsu/g2N0RVra3HtoD+JfVkyIuAJmON0q1zvmYd@nongnu.org
X-Gm-Message-State: AOJu0YzjBxrJT+1l86kV/dwk1N8nDiVCeCzGK//A0x9h7+yDvIn3oq4m
 oEzqGvNNkMxAkjeB9pZ/ijo0Xno9hm1bWERxvNF9+zkz5040C8DRaMhKhX10KuqNRPF82v78ALq
 T
X-Gm-Gg: ASbGnctilzpDptS8u3wMMZyUbPVw8Mw8nHZJjps/GFq/H0Pu31WDOr2cCTFpl+YBFj4
 n7NJfRckKejSSyCqZzzR+Wc03uwoDZVWAKoMkUYnD44QES1CNCSfsX+Msi4WCq4d5Gfac6UFK2o
 /UtRkdOpG5XYyiKoe7GUc1zZHRFTq3K14KbqmCyjQmg4xeRDwM14G8SbHy/2ZvfnGMLln/l7j+a
 qjk9eeem3LuJoQo1Omz3fwtCZfC5aqlulNI7O00SV82N/Az7dhbpByZwqiqfB8YefgHd9xVmrcJ
 jT+Fml1B9HuAkOnzDhVzhR22wL7VSHa2/Tyz0vFtUFyFCYJClOW381WHgSwAEfvV4CsAxseLRpy
 a+/As72ny
X-Google-Smtp-Source: AGHT+IGYSOmmiSCwzVMs610b9QkqaQcb85BvaceQNoaVvCzEjUJ1ZpVSqwvAVilpsbrjtlf+y4QaaQ==
X-Received: by 2002:a05:600c:1912:b0:43d:ac5:11e8 with SMTP id
 5b1f17b1804b1-441b1f5be91mr12053815e9.21.1745994384524; 
 Tue, 29 Apr 2025 23:26:24 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af457bsm12895175e9.24.2025.04.29.23.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 23:26:23 -0700 (PDT)
Message-ID: <d57e4f5c-a677-4cba-bbe6-85b997a3b57a@linaro.org>
Date: Wed, 30 Apr 2025 08:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
Content-Language: en-US
In-Reply-To: <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
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

Hi,

On 13/2/25 13:37, Philippe Mathieu-Daudé wrote:
> +AMD folks
> 
> On 12/2/25 23:01, Richard Henderson wrote:
>> Use out-of-line helpers to implement extended address memory ops.
>> With this, we can reduce TARGET_LONG_BITS to the more natural 32
>> for this 32-bit cpu.
> 
> I thought about something similar 2 months ago, but then realized
> MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
> not much missing (I'd say effort would be to add 20% more of what
> we currently have). Just wanted to mention before taking the
> decision to restrict to 32-bit. OTOH if there are no plan for
> adding 64-bit support at AMD, then I'm more than happy to simplify
> by considering only 32-bit.

I gave this series another go, and figured the microblaze target
addition was done way before the 64-bit. C_DATA_SIZE value was fixed
as 32, and C_ADDR_SIZE was not mentioned. Later C_DATA_SIZE became
configurable as [32, 64] and C_ADDR_SIZE appeared.

Indeed what this series does is correctly implement the current
target as C_DATA_SIZE=32 (C_ADDR_SIZE=32 implied).

I had a quick look at what is missing for C_DATA_SIZE > 32 and it
is more than the 20% I first roughly estimated. So with the current
implementation, this series is doing the right thing IMHO.

Regards,

Phil.

