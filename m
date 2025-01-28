Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F074C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqvN-0003il-No; Tue, 28 Jan 2025 14:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqvM-0003iV-Hr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:07:00 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqvK-0001iq-Va
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:07:00 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so8442960a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091217; x=1738696017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ti726nle6VuOmFKb12lxrLNXk0qyBZLp9aqDlvmtN68=;
 b=xIo8e94ZmFoH0LgB9neBZ65t0kjzvAVCclORhs0na+vn0InXodBm1EUQfxT4/wP8v1
 QsGw0Qww1TzEyyQ06jbVzy2zkNsfcWSUD5ju0hKpfZ7GPNZIGfiEv5ltxgXaVYAzx+LW
 Qd6+MvWY5zC+prR49wBX1iP1miiG/DfE1XAEyBkc7CqcDZjxR27N0Mb3WNQQh8SlZk1v
 +80Y3X/4tykK9NTzIy6FsgX+AQZTJ11j6x31hNOHB0uo7lDinRFhxe2ZxD2Fe+tG3Aub
 O7y5o6PioG+qQNMm3kcxM+24daipSwHzclXeLCyj4wMtwNLJAsC5Bd7r/BvjqJ505Y4F
 +xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091217; x=1738696017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ti726nle6VuOmFKb12lxrLNXk0qyBZLp9aqDlvmtN68=;
 b=egNtZtOzKz7WkiOdcHSw2o14rJ3VVpC2L9MDkMSetOpbOhewBYFdXE29ZXHZRmxO+3
 TXen62CO6PUQiQ0laHP0pXi/o72H8cdVJHX82ZAaM7sjPaUKCXrUHD+AKndkNPxqj70L
 5cavDd6iO8uFIgztq9YLmlxg8YXwmkmxN59RA+ETQayqXg2COCfbV5v3KEj6Fn4BUowo
 7sCUX6OjLLSKQO2u5xTBbqUKGywUdeqL3wTK3FmMpraJUXV5GSs1mY0Ya1so19aKbJN/
 vCjPDv2vLZN6tDtDLZKaXtfsDzUTusjMP0UIWbsD5XDg+ZxEwrzBSxLTjm0dRZK+O2ml
 qb/w==
X-Gm-Message-State: AOJu0YzsEwBVLkvBL3D4WH4YEQqqOlVdFgXN/7oPNvQx1vcnDV4nen/7
 Pp62vKsIeF0Juk2XN/5tKQ+x7A/yp3M+G2KpXiT55DN5Zgglx+8IrjdM2E1BHjeklt43KiABMbB
 R
X-Gm-Gg: ASbGncvqUCR3CQVPXy3YKxM9PexK/GoLvJcTo5rgRt9ZGUvq3BEa4L/0E8x/bgNmRor
 DqN6SnNn+3afIPfg/KIvjrh89NwDMCH82vXo1fQJUHuQvtH7GS+4uleKfkmdlDLRkthPae7Sw69
 YeJrtKuHIw3xWFy8I/Wd9e+pyketR0pKfmRy6ub8FO+nH/mDqDImOEig9xg3MNnk2rc3aiDYZkn
 OCfGx85MlriUgDgJIVgPrvVr5k0Uby1bIY7hqYUO0DmwWE1S2E563LDL677ybO/GxxNOqHiHg3s
 f2bHBmT9HPQxdnxAgImUOC9Si6KLjqjinjd/iKBHUZXB8gfrOK0JvLXjTg==
X-Google-Smtp-Source: AGHT+IGNiRBaXtB7ipZTGjN8j/O4xJK0kINQM7JHica4YDesfpFB/ci6h47uX1BdG9qDCE4WiOKd2Q==
X-Received: by 2002:a05:6a00:44ca:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72fd0c64f9emr387630b3a.19.1738091217166; 
 Tue, 28 Jan 2025 11:06:57 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a7614f4sm9839947b3a.97.2025.01.28.11.06.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:06:56 -0800 (PST)
Message-ID: <a46967cc-06cc-4c80-af21-ea03f889ca5a@linaro.org>
Date: Tue, 28 Jan 2025 11:06:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] hw/sd: Remove unused 'enable' method from
 SDCardClass
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 02:45, Peter Maydell wrote:
> The SDCardClass has an 'enable' method, but nothing actually invokes it.
> The underlying implementation is sd_enable(), which is documented
> in sdcard_legacy.h as something that should not be used and was only
> present for the benefit of the now-removed nseries boards. Unlike
> all the other method pointers in SDCardClass, this one doesn't have
> an sdbus_foo() function wrapper in hw/sd/core.c.
> 
> Remove the unused method.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/sd/sd.h | 1 -
>   hw/sd/sd.c         | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

