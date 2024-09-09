Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5411ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniZk-0001oI-8N; Mon, 09 Sep 2024 13:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniZU-0000Xr-4f
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:53:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniZP-0008V2-TN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:53:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so4327888a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904377; x=1726509177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NfV9SQXAHLo9/KAtRORQWx31pG/kb2qFRuacXqEj+7c=;
 b=NIjMrAhFHO0tPmP3/OOt/VpQbOhdefHCTIo33Cgu2FS4Q+JdwUA991fwHQzgy3ojaH
 +Tfsq8MCRn/3kn3WesONwmgkK3bEwWw9raKwDXeaS7Hk5kpsSO0m6GzWgYd66B7qgUqG
 +0pvjbQBr6GRuTMAlQhX73W/j3+khbyM8aHT4GjFytV4eCNFHoiAShOzmiU9PQTWVsdx
 y4GJCeJ5GRSrqscrgjwGBrDmJrEgFa53ZyvouDJT9rwE7csJ4yABKLRS4h5lMFlNnScq
 nnk5Z9of054YfuRxX+FlsTe8zqX5+8vmxouHfnsO0RKjMykINRGKibKDatwkjWpAJf/D
 ZNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904377; x=1726509177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfV9SQXAHLo9/KAtRORQWx31pG/kb2qFRuacXqEj+7c=;
 b=F1Dr4KmXnCWxYJW+jHVYP2Rn+Nm8r7QkUVAyQIUi/MZh0kz2QEqhj86GBMAHDMCpHx
 /5H7oVn5MyHcs0q4BLjTjtFmUU8wmdx+ukA7sgQMR91zthWMSxhVwpeGFPfTu0Igs2Du
 oPAN64aBUYhoB31tGxDS2hAVxOTv30SnX0jZe6zsvTSWO3zYEedGpNxM8pT30Skso1/o
 rfX4c/JizhfOq84jw3G8Ay0MdGPTLCT01crGks136+i5UOQgeAhZ/ntX8ILbQWPCkIRG
 Y56uNmNwLp3TqaPTk3yzTTMIO7dDF19dQvdOPz6HDkC8dJYJbWpFO0VsUkrrpoW3bJFQ
 /3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdzxwbJ6tDkO4mpxDKdZXNeV4pJp32AhDJIuyXZBmo97qvakqN+ueejgul1OX9tdXuGiWprtAL+Q8l@nongnu.org
X-Gm-Message-State: AOJu0YwnbX9onh0w2+xJwV+pdhjOvVRTiLDTJI1B06A0/7jKqnEoaExC
 pA3yukjxPiWi9TnfyEH+fOt/6qle7P359i0WCdj8/t617IJyQWsN2D8e3c6vDVQ=
X-Google-Smtp-Source: AGHT+IEEGnl2CQpFEvmMLQ6RI8us1Sy+l9erSY64h7WdCMtUFPjI1on5HWjNKhq4VE9MM8CYUFTj/Q==
X-Received: by 2002:a05:6402:5203:b0:5c2:6311:8478 with SMTP id
 4fb4d7f45d1cf-5c3dc7bb4e1mr8106278a12.25.1725904376693; 
 Mon, 09 Sep 2024 10:52:56 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76ec1sm3259768a12.70.2024.09.09.10.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:52:56 -0700 (PDT)
Message-ID: <07d667cc-8f34-423b-b5f2-f6e2378a25a0@linaro.org>
Date: Mon, 9 Sep 2024 19:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 39/53] hw/char: Remove omap2_uart
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-40-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the OMAP2 specific code from omap_uart.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |   5 --
>   hw/char/omap_uart.c   | 113 ------------------------------------------
>   2 files changed, 118 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

