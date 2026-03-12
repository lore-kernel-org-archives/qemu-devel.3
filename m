Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D87106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kci-0008BD-1N; Thu, 12 Mar 2026 14:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0kca-0008Ab-K3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:18:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0kcT-00065k-Ry
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:18:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso11413165e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773339527; x=1773944327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yYXudM48uZQlkTe2pswR3W6pvCIzv1XYfDWsmr17sy0=;
 b=EIzh31vTCxjQsy1ab7BP1/BVSjHKqcYJiHM9gH6Oe0Aij/bciUa4RVQhJi6iz/xgkl
 mxOXsdRDSZfpFNEqB5fhTFzScxHMoz/vYO5cqFiWQuAjKTTcW9u2vVAj9QLZu5qB8Fmt
 AhkJF4wku2FVyUPWJKzNraEga82ZjLzVlFZve8dySwnduFJQhZDAxAMOCOixdFErwO+B
 nPbAz0Q6feBWrlp857Kx2+rNxZkek6UlmIgTibQOaoDiWt6WBfVpC//7FYuHP5G7lj6N
 IfDOSWyk92ywfViPw/Rvg38kh3UqwOh2dXhNyDmT/4M3Qt68y0z4isix2cljbp0LWXqC
 LCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339527; x=1773944327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yYXudM48uZQlkTe2pswR3W6pvCIzv1XYfDWsmr17sy0=;
 b=QOkSIuhpYepk06xd+KW1d6etOVMrMn3hljbBgp7x3Gvfckg98D9ZQIEyB6RmfZOk/o
 ln2km4rnm1DK/VjKkOWjlMJGsv1nTsA/bsZu7Lmy+fSMtBxvwhCyXylLw2l/1bYeaCdk
 qQo/NeKt2TZBHhJ9de2lwbKToPFxtx19X+szzOMNQe12oLAYd/OBCIhpLJ+M/U/zCjRy
 vUtnD/m2KTlvr097FnZAiGh/DuESRQuYX94pjv4nb9xC0Mob/vpG2pED8J/UO63PGHD4
 a0R8qTwGMPxlaDBgXZ6Ip+cKmbEaRIeVndi3xPMxfH0O22H8ZH/Irdi9Y9UlM22SUlsg
 59Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqNYxJflBApuw/BDUpyvzQde15VhiRWjZHq1tPE/wMLpmSerAxZib5xf5u9D3djxLaK5qYRM4L/D2U@nongnu.org
X-Gm-Message-State: AOJu0Yw+ZFMhSsbL68O7pAjZkHOUN0Ri3rAucfxQAEZE6TTQI0QJ32iw
 YS5DVM9KcVQYqOm7TvGFtlulemAKSMjrp+Pm6AN0C7aLauOnNHr7iJ2OrcMzi33Xl1U=
X-Gm-Gg: ATEYQzwXMlnXPawRlhgGtRPZ+GFK+WE+J21ZLo5AkNw8cPBm7VPT/prK/HoRqebE1tn
 gy4ytA2F5fCtCu/oamd+9mNmgIkQ/aE+omQd2AOdLyx3+pbpTAnNN3BDO/s9GB5H5bvH3bIT0c3
 QUWW9SWyz61XOpPU7dWt2TXrARdb1BanaDsrN+cVJHHZMoJU7ilCaf0C1YW6Ftjp3qEsZqppE97
 YN4HsQkDED6BAJ+gmeS1bq+4pBupSKZo8KxDb7W3H5pfgihiEapUL0lHI7j/IMDVcAUGbamc1xt
 cLisGfb7Xgi/dmpv+jSc4ZpoayxNYvQIkXIoxcGrUT5s9ZUg8sPWHMZz5I9OitzVKsinnoWW3eY
 nrSpVDvC7j6cOfJJkPsInB+38SCT6MvVg6iPG4AKS7Hayj/Y47Q96ypI5vGkCOOVUVjutQ2rzhz
 OjxdcetSKUQ4sxH+QUGvUAx3VVz7RgWBZEHO9miaDqMAq3MjnXSLnrw+0yjdFwn9/q9hekNEkfH
 Pbs
X-Received: by 2002:a05:600c:8b70:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-485566f9445mr5981535e9.16.1773339526933; 
 Thu, 12 Mar 2026 11:18:46 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f406sm240866345e9.13.2026.03.12.11.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 11:18:46 -0700 (PDT)
Message-ID: <f333a91d-df3c-4b8f-8476-1dc82d72ba39@linaro.org>
Date: Thu, 12 Mar 2026 19:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] whpx: arm: fix -cpu host
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
 <20260311151014.55915-2-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311151014.55915-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/3/26 16:10, Mohamed Mediouni wrote:
> "hw/arm/virt: Register valid CPU types dynamically" went under my radar, so fix this for WHPX.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

