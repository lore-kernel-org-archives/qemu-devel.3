Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8611DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgAAk-0004im-M8; Fri, 01 Mar 2024 16:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAAi-0004ge-PM
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:12:00 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAAh-0005xC-Dn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:12:00 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so2295695a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709327518; x=1709932318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mWdjiPjr30glgV0WFI/rH5rwT595It0dyq+bAo7uky4=;
 b=LMW+hD0ecKupOnm0PLIz129NkO0MC0ntNQ1MRiVLlyuG91kuYkj1UXJW9sHQmMeipz
 j07qx1rVqtEit4ulVT++j3gzrfclarz8A6LIkPC6CV92CVBCB9ErrVbBlQVRbw2NxItO
 Uj/mrbp/3DNuQPIcm0pj04pKg1L+XiVzyOHIQZfllmz/VKmhWod5nFK0qbJq3fo54UVe
 KNTrxoo8Ip3zY9cUIWMZnuvS/n8n++heaCOcf7dBikAIjLKjkC4i1AoQDdZOeq5eg8+S
 6MLVNx/uANs3hnvUNXtnoHh9n+TzkgWi1bv2JPUyNblbJryZiz4HK+jh8nnoxN5J83mY
 vNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709327518; x=1709932318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWdjiPjr30glgV0WFI/rH5rwT595It0dyq+bAo7uky4=;
 b=tezgngMS7g1cmQ9ECWCE5gbbtYLeVjRTAkzO+JstlZjtbR3I2g6gQSOrak84gTmZ99
 R4cjiZd1QD1BcbY6vc64fcLMf7EeW8n5JHJ6+/pV5E/EUySgEPne+siMweEiz9ciVN0q
 hZyWMSjOV178Jznh7k6OEounfqDl20deiY1+8u3ERkgrPkdTh4/CCr0D486qG5BYIBUJ
 75bToFH1Wa/yhCy0mQBWnC16OvLTjNDx22GWJDT8d9TsBbMt4VKuyIU6KwaxrlVmOLCR
 X0xTaXFMCTEfeDYp0lQex7QRZwXzk7cjSrQTIkpjWdKnzHb3jJkblPYPpGJB3MM/mbMi
 A6Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrL6LZNCdOPsTiRvd/KeNOTRaPt0YhIIClXwiQVEOUUtsT9HWIJudEpsOCSFf+Q7HyE/ZdAPig65zPflnN+KvlEHjales=
X-Gm-Message-State: AOJu0Yy8Sc1NmV9bkoPmx3XdEm8Qy4foGuollTiiERFTmIhx+S+fGI7i
 X5agHP5S1Xwl+AWM+e4yH6ZNSCfVAJf7DmiWJ2YVrznAbO6sGPaHZrr4wGeUICY=
X-Google-Smtp-Source: AGHT+IHWegscd1XQ5vmJgnYe9GOgyi+NIHYpKR6zt4v5n4jTEhUyntox8EVf4IPwvYtX2WwtM0Q5LA==
X-Received: by 2002:a17:90a:9b0b:b0:29a:2788:c9d1 with SMTP id
 f11-20020a17090a9b0b00b0029a2788c9d1mr2800110pjp.39.1709327517840; 
 Fri, 01 Mar 2024 13:11:57 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 i2-20020a17090a718200b0029ab17eaa40sm3654043pjk.3.2024.03.01.13.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:11:57 -0800 (PST)
Message-ID: <0404e89e-9d15-4f4c-9a0a-b9f4c46b9eb9@linaro.org>
Date: Fri, 1 Mar 2024 11:11:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/arm: Don't allow RES0 CNTHCTL_EL2 bits to be
 written
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/1/24 08:32, Peter Maydell wrote:
> Don't allow the guest to write CNTHCTL_EL2 bits which don't exist.
> This is not strictly architecturally required, but it is how we've
> tended to implement registers more recently.
> 
> In particular, bits [19:18] are only present with FEAT_RME,
> and bits [17:12] will only be present with FEAT_ECV.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

