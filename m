Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B39110F287A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GZf-0008Ng-8y; Fri, 27 Mar 2026 19:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GZc-0008N3-DX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:26:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GZa-0007A3-TL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:26:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so2095565f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653997; x=1775258797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ppeMeVByLNp4qiBcmX+UBdMmi4+J60tpyKAV+qKPIYM=;
 b=f6UkIWcoeoT3zE4G7JElE7uIxn9zGrPkqEWcc+FlY382/2HKEqTLGpmyQUNoLVNIOH
 p7EdjnbsAOsEc7O67o8D5WG7SMOAsqtVsqjQnbCCgJENGMVhZneiw6Xnd4tM8PfWk0BH
 BUSVe+wtNi2eJUexOhFQ3oSbmPdsoa247t4N8/scD1KzYS50sysw7LMCFQ3lv44/s0Ze
 oug33OMezy4Fpvfv7Bu/dScwah+WBGpeAo/L4nAhnuvIbgiCfuK1yU97p82U4MP+335Q
 PDfZSUaytaKbVdC/eHFKEn0vLogoWQLQFLZSQCV3cuV2/cnRxUn5Lw+l8GY2niOMla/z
 3KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653997; x=1775258797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppeMeVByLNp4qiBcmX+UBdMmi4+J60tpyKAV+qKPIYM=;
 b=IymjiQ0CeXrFEMhFzPs8Cd9wMPShvQz5hRz4KqERrXQPA/apOr8k2WfnzogNCOewWL
 lmYOXHgLlLFV06skhY7Gcjp/LAFDc7/fcuV6fWfyVCfe3CO7TIyvqeBpE5HcAkcO2RMw
 Qqmt23j49Z73Oupogcg8Mew2TmG1tsuxsU/Yd3uCkCkVhIzLH8rkr3NTV/IJSqOTzFqg
 9Hsw9w0i8uanbv0U0S0zMXhtB0xpA/WSTQosMLRudJQxsp/6oDrnVLvL6dGNR7IMqlTY
 IZYIql981k0o0tGfj6ZZdLh49fGVEkfBw/LiiZBJSv0740CSVUsqKerCFvxufvSfSjPJ
 Do6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJjNoHpe99htbWMZbSVwFmgmDuebqZ1nxAW3qNHOqCfht3O7aYERJQIkFY95Nh6WU9Y10SBO/MMf5c@nongnu.org
X-Gm-Message-State: AOJu0Yzv0uMnbrczqCD3OQ6XoeMENmqcHqypmUJMshRI4iKnlSNVnnPI
 i0iUeY+566uIxtUzxwRM7H/Ww1TyHTjH78R4IqufQWBU5uBnhVA11etU1QU/nb7Yox8=
X-Gm-Gg: ATEYQzyBvXMucyOzBPK52kRLGHIRG+99FflT56cr0zFVkrpVNQRFt3t24lIztMGt6hK
 fFlEdORjubm7+89Js08ghpayx77XAXwUSVEqRuBQS+Gk1yfEdekStiwIva8siU8gZ/qFh5hgxuC
 yskpKryXPR8Qitkc67TuTQVlq7Ir0kMyxEI0VfB/fxhI0TR4XWGL7xSd3dOEIbkjm+AhAwRO8Po
 4QsLjbfvyWur2cRb3GZA2Uzom0eM4bfekwvvJejJe4Tw/y3U4WsMAzrPAmQth2HIgEO3VOTkStU
 AWkrKMIi4b3KWM3G5fNdbpmEEoeNcNOBJR5amqUi0QZh+ZOZ5eBa3vQSwdbocXfEMeBZetqCmTb
 HWQEZaxUxJPE3GwWUVRIp8MTa4Nlbg+8d/8xN4VArGRyEQosxalh/RnSK219iAq0UdLzpBCxEsA
 8FUlBBRG0rNLjKZ3ycn0eqC1Eta7k6dYsgTblGI1FkCAy8hTCJXaDv7T8JzhQN4w==
X-Received: by 2002:a05:6000:4210:b0:439:cd26:ce0c with SMTP id
 ffacd0b85a97d-43b9e997835mr7356573f8f.17.1774653997248; 
 Fri, 27 Mar 2026 16:26:37 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf1db08e6sm2847056f8f.0.2026.03.27.16.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:26:36 -0700 (PDT)
Message-ID: <769c8779-d00f-4ad2-89da-3264ab912aaf@linaro.org>
Date: Sat, 28 Mar 2026 00:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] target/arm/tcg/gengvec.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-11-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 27/3/26 17:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

