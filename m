Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C519E6ADFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqf4-0000gS-M2; Sat, 23 Nov 2024 08:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqey-0000e1-FF
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:58:54 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqev-0003bX-UI
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:58:51 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e601b6a33aso1890966b6e.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732370328; x=1732975128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84eOdktLJG2ouXBxixPGKoITvYWXVrM6j4co3SogX8k=;
 b=AndE0So4YIaajqaBWWrUsfRzSFtLXyNohpE5cb1UsoM7MrBSU6hYdUdqPOFGc3WbbK
 WOUWFwJbMvNNpyv2ocu0Vc+EjAd0skfLw5Ik3KaB1GdiecKQXNwIttDlwitBFdxyVwBs
 I2l895s/8aCWNWciWj27HpCReTT7xJvM7wwVSEfs0Mzet/c0HN+G1kyYa2S+fKN0Qcmf
 vq0v27EdqryieUR9LgRABL2EP+Sr9pa7Mi0AtxsVtz21XUByE3uIONs2ptQl+px2IYcU
 oYLE0NPq1glTEvpzte8O09x4rAO5Qr0H721FYa55W+P0+IjURRNIsvIFccFXTflBs194
 H94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732370328; x=1732975128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84eOdktLJG2ouXBxixPGKoITvYWXVrM6j4co3SogX8k=;
 b=guPY3EvJY3g3t/YNbzF5fZrTxYtNnQEEOsIc2QOmrkWj/xkcZcLv2qw9/Mrkbr18KU
 7jvjn7ZbR+Q9uCd3+v3tUrEgY9/k91ZOiF5zOfiEPQS5z68Iw/Re1NH1cxGGeYK4U1ww
 LPKomZdRUpYpxJ3a2hv3FuIU8621ZyDlDtnslz1Bz8n4syp7P1f49/uK71I1X77mEGAW
 Zo9fNDz8FhrJKuGYl+jknyLcC5sy6DahLcHOnxvwWdMkltn5cfo8kk+v2I/ukAS8+AL9
 r/vFWB8zpMSroGXE7n1kZMPLgXzrV3/MhYrwtv5ICOKB3spYTnE8Bsg4Y7TEH7rZBqEF
 Iayw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa//oh3M63Xgo8ANFsGEY8cQjWrV8+JYWy5bvn7M2XHLHlAWnmZ5U4XpCiaiI1/IGTvByw2CVv/2F0@nongnu.org
X-Gm-Message-State: AOJu0Yw8f7IAfjTlF7okEIA3BsganTMLSMoPyIqLCjy2aJSXQgXc0yAP
 0TmA/Qu3GCWETi8nJVeBYzdnTJwyrq3AcEYXgP8fmVz4fa9pvHkX+nizZ5pUV10=
X-Gm-Gg: ASbGnct/wbMfFP5iQ83W4LY+YP/elgzUX8hd3Crajuk4qt/iv6TqpLk/2+fLKRO4OYj
 KiK4IcdrlRSdOfWpQDSJxqayQvuYDVukUaA8lAtXrEhTmiWm+LmjuhYc1HNjVr70ltiU/vgPm2Z
 FnvMH8wgle9Rebgbfs5MR++46/V2910NO9jhMuYLumMJtQ9Aj+MxGro6yIcgiV2imX98vMeyWMJ
 1/YZP7hi0bS//HAq7gOsUsWnek4TVgoIJyX9g43/7ATnDsonuhmHbeQOVW98OwkXg==
X-Google-Smtp-Source: AGHT+IG5RlTNpMDPMsk9Ialvv/4acS/Pop9lxkDg8eo6hdJZP5y1jrhUextfTt91xb1jNUTpbO9ZyQ==
X-Received: by 2002:a05:6808:2e93:b0:3e6:37a3:a172 with SMTP id
 5614622812f47-3e9158214e3mr7715434b6e.16.1732370328210; 
 Sat, 23 Nov 2024 05:58:48 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c037590a3sm1025013a34.8.2024.11.23.05.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:58:47 -0800 (PST)
Message-ID: <5ee0b525-10c1-47c4-be5d-3c5ea88300f9@linaro.org>
Date: Sat, 23 Nov 2024 07:58:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] docs/system/arm/fby35: update link to product page
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/fby35.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
> index 742b887d44c..bf6da6baa2a 100644
> --- a/docs/system/arm/fby35.rst
> +++ b/docs/system/arm/fby35.rst
> @@ -12,7 +12,7 @@ include various compute accelerators (video, inferencing, etc). At the moment,
>   only the first server slot's BIC is included.
>   
>   Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3 sleds
> -can be fit into a chassis. See `here <https://www.opencompute.org/products/423/wiwynn-yosemite-v3-server>`__
> +can be fit into a chassis. See `here <https://www.opencompute.org/products-chiplets/237/wiwynn-yosemite-v3-server>`__
>   for an example.
>   
>   In this generation, the BMC is an AST2600 and each BIC is an AST1030. The BMC


