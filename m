Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B09CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGcvh-0004Ew-S4; Wed, 05 Nov 2025 07:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGcvc-0004Cn-LB
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:47:57 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGcvY-0001Q1-Uk
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:47:55 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-640ace5f283so4242023a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762346869; x=1762951669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NMy4LBWJUHJKwFmoOUA7Js6JPiPfmzwchzLclgHPvP4=;
 b=kcjeTvrGn6hrYZVup3LwFjOlO9yqAdI3fr0RfvEVc0h8AXOSiX9fuanhcJyU2ghiVX
 F3HC42QuLTPSm//QdX1idpSQ30XMG1QsIN9VZfLzWPOGqtisrLmv5xK+Dz7tCUUnGCcL
 Jqo9sTv6EtsteKuvBYSTsEi+dtM/zP46w94APcFwZpnkE8UVoZhS2sKyN+W1J2CEHP9Q
 g1o7qP1zwA2jiyGQlsQ+0QhDWDS8ACWiwFBz7ONSJsjhqjgJPuXwJzpGmssUUw22vdei
 3OzLhQWOOQJnuz6UgsmQGuILstqABUEyUAOe0buQw2qIEL/kMxouRkN027PB8ZpOp/jJ
 oxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762346869; x=1762951669;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NMy4LBWJUHJKwFmoOUA7Js6JPiPfmzwchzLclgHPvP4=;
 b=e66QQ8pW+gZwLW8UnH9EtiOCZASIzdwWvD8CfeMiOGaoZUmxTCm1o7e+sbx6yDMPYA
 eZk9guMR8c4G2w7EXyQPyOuHqM2PTL+WyUxFNcCMk6x6U3ONvbq/XOdSH3idVLJnFsR+
 +Nrz178xEljSntIsTSXIBapowxiACezG5Ov++qoZrKdmEr9HvzLJn9N1ZufIpse/0+1E
 r99puIwe9X22mKQ68yen1eqd2JvM+X93M86/nKm2TbOHgbUTNg2LtKtd6UfG+EOrquHe
 FCspNwpcKozMXmKS/scBNv5EXwulGh3jFw8oHcRb0hpsBNVJKjkiDivtzCdmhLEbbonm
 Kfqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvc7Dn1YY9WFbn6f6pVdMqDz7RKCzTHJL9H6IPF2SGJ8FDt5cUz4Zi1gInGcyWITFhV6QDa40D+K4@nongnu.org
X-Gm-Message-State: AOJu0YyRzTf3GmCQLRm88v/2oRVx4uO1y3lmmQl49GxeLIKhAQzlNd1f
 qtZEHt9a/jdQck6PrCaf+T8+Vzh/GQ5FjRdsvuHxPvKFZHxMXSFU16zZVtgbpPI7S3xbCMJN30h
 Zk3JxtRXbMWGi
X-Gm-Gg: ASbGnctkWg+JWtJzXRhX+bTXfLrsfkggGcO7M3Djlij+V+7qgZICZbJQAJprJyPd+57
 70P4DO+fWh70HeGWbolO30SAQtNINuwv0R8ckFaD9TXQNbhZLPBr+aD5BaRbiNdXT3gPAX5fuK6
 To3DGo+fov+YpNoLqU3nktR9a8bWMOd3UgTN4YC7fc+m3oO++Qx1fKx5s+Zx+6YLhH2NdK++Wlb
 zUEi1yXuLNL1ajpoL7nkWf3A+Zhtjv7HUK2PlZFFJ2rE1n4CpENjtOdHIRcKnQqZxZyr57grYHv
 hPBho+XH8DSt4+T9oEhQyUrycABvYK4L2QZSXR2+lZIHQ6y4SNXFsqQ4oZQWfofwBGCrFLYg1hf
 tF1K6qj4DA6OTD9+gHOe8haMHvZYCr80iibcjS8xMjlEDgJGo9K3nBBCemtbl0twCJiwWZuL4zB
 YvGptyeEXHKgmqwm21+DCO9I4BCaZ8eA==
X-Google-Smtp-Source: AGHT+IF0gldEwZHUq1GZ0I7A320JoHep2EDnOimMSUvyHvdAI/m8b0HxHLg7Pr4/7eruNOjSK9hpmA==
X-Received: by 2002:a05:6402:3507:b0:640:b3c4:c22 with SMTP id
 4fb4d7f45d1cf-64105a47acbmr2347268a12.18.1762346869257; 
 Wed, 05 Nov 2025 04:47:49 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640ec115269sm3966387a12.30.2025.11.05.04.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:47:48 -0800 (PST)
Message-ID: <73fcec53-7c57-46d6-a0af-70ebf8215e8d@linaro.org>
Date: Wed, 5 Nov 2025 13:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: detect another GPL license boilerplate variant
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20251105114325.1362006-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251105114325.1362006-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

On 5/11/25 12:43, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the quick patch :)

