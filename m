Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4002BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVTX5-0000O4-Su; Wed, 08 Jan 2025 05:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVTWv-0000NJ-JR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:43:19 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVTWs-0005Ku-Ii
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:43:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso119930395e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 02:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736332992; x=1736937792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7hxNikeIWnptUamVR5EzPXnGEWzCcUh7m/ykOY1+Kg=;
 b=enUp32C21F3amRmmuETDf8butEKOeA1sY1jPfsCNyhr5J5NJqEApS8ogRvi9lDcejv
 Mf0SO1gY6EgiJb9HJoo8QDzzFZ9bH03KjrmhWkzRE1DF+2XqXqedBslh996R8/5S6r+m
 SSEp8f1qO6QpzqCO2iCf0x5hYkHga1FUmFYx4RVoN+ud9BtIIwNwPTJcEplTpCBdZLi2
 ZanDAACcgCE2A62WgT9WuypkDMIuZgLMV+vXfcNA5MQPRS8R5IgBRFtOBzukvF7xtDtJ
 rpA1L7n3P7sHWCPzePOfKVjsH+kX65EI4i48HpuiR7rZacYucpH63lri9rKlsBeXDRly
 VsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736332992; x=1736937792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7hxNikeIWnptUamVR5EzPXnGEWzCcUh7m/ykOY1+Kg=;
 b=WEYq8ky0MgSenzIZAG8a9V4qXPS8VKKhfRs8WbbksTc9OWTOAMb1j/GuOz3iuPWT6f
 cvSRsTxfiGhLyVU46l4vvMyuFPv13EkMcgxRYPYUd8o/sliLpMxY6zRsdSLQzMrD/n7f
 tw5q4iMt4omcX7bRKnt0JN0DNxRpTy2f9H4tmEREwHHjsdYykeekj3S1cdF1lt3ilZ8H
 aZZsSNqpcS/evQ+7Qri3bU0fsRlz2Ru0j6ovviPAQjm1n1DnWxco2FvLLU52e6+Rl4w5
 CC1vxI+yQ26Kv6Etr+tuQqLV0AvG8tmNhGMAwWaPGNBFUvpnrWXHfO3+Vt2iSBCDSXHr
 LA2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoN2jEkeDO/8iOUg+3rYn/thjwibrmBkhs2ffF9ZwKtAtL+jQLcVFu7v6giSbiMYCxZLAo+Zrv4SPz@nongnu.org
X-Gm-Message-State: AOJu0YyWtMZJi/TAblQdRI/2lAIbcxdzcyayfSV7MLh+kz+8vgB0AZDC
 P1NDPRpajAM7X34kRRH/TpOTPIAB0FZBoXdjTFUdRUPHETXomt+x9lVN6kzjzj0=
X-Gm-Gg: ASbGnctALK/Gt3R07z7OJXic7dXJhA8WjfDT9GzuO/xenr+G+tjlgDXI+0p/jhMOJh2
 0lRlPp1OTLogF73hqzugiPpqJFDRQ5hxtR9mF+dK4lAGh87pFj5aAlSFkfSDNtoxE2sEiRuCOQO
 i9D8PcwaWOcgp5zTaDoeu6JaW+HXvdyQfSD+h+PmVq24BFNQAnnAzeHtkh/8Y8EqXEdNGhQd6Oi
 17C1swMrr81i/Jkc62Zdcz0q6j/WKovk6lKbgJEOmvZb9j8jrrIQ7BT1mOizzju53E686wQbSy2
 mxkJj9AGoOnpCmTLxLv5ghVj
X-Google-Smtp-Source: AGHT+IFsUyQhPyageAtgz0OYhqDpG9jzG6tynIQRhtsWMHodX2KcRvIRVsqffwSUjEbjiluUG8YUcA==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-436e26b9d45mr15944635e9.18.1736332992095; 
 Wed, 08 Jan 2025 02:43:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd1682e4sm24477145e9.1.2025.01.08.02.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 02:43:10 -0800 (PST)
Message-ID: <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
Date: Wed, 8 Jan 2025 11:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250108100240.960593-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108100240.960593-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/1/25 11:02, Cédric Le Goater wrote:
> Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
> Remove omap2_mmc device").

https://lore.kernel.org/qemu-devel/20240903200446.25921-2-philmd@linaro.org/
;)

> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/sd/sdcard_legacy.h | 1 -
>   hw/sd/sd.c                    | 8 --------
>   2 files changed, 9 deletions(-)


