Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F94C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus4w-0004ho-Lw; Wed, 19 Mar 2025 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus4r-0004WB-8i
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:59:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus4p-0001on-EX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:59:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso29896855e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742385553; x=1742990353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RA0jSh4Xws1oJayOknuQkQKG9Vgp9fVGftx95wsd/UU=;
 b=Kj+MNsiykoowtkauQ+SULZ7/6Q69z4k9VloNtO0QEJirsALDSgaXvklOA5OlPUpGje
 ZUOHSjMQA8w5jwhnhgUFKauQU8tRP/+WuMTDw4RXd0bVxRUc4qIBMnFFYgVz1KaGiBd3
 KJTf4QBIn3/XVhsdbqsT+o5hlrZEQzt8Za+Ytyc7tCRe1hlqK643D7+ZIxzj206uZYM6
 vnUYtm8O3jjmdGhfaslHKrHdfgyiLbZYeTgl1t28jm4vnpqXz9RxQn2+B14Ss2muQhRd
 tMZcGMhHxeC3cHRC6Cb5jT8vTVPLGyIjVcJmBA0QQBrLi12++3h4tOsEVvywBZiN/SIp
 K8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385553; x=1742990353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RA0jSh4Xws1oJayOknuQkQKG9Vgp9fVGftx95wsd/UU=;
 b=GlWRMYZRhZfbFsvkrkayWloXOREE7keJj/rK8yHjJsjAZxEh/6f3SbtSiIXma6i3Hn
 cURW5bIBw4aDTqWw63ZwEkG/8xgmeqxYL03C2TohQn1CoNq01zhjN1YZiH1fIe5PFxDb
 4YToPGhNxSH1PtyHETZ6AUmh8T5SdRtvIHk0nartNNSg/+C51IDivOwuctyKQRS/Riha
 pUgjjdkyNf2+9c1j+iqKkWtisrgzf0fhxnGziC1+W0vKekLrlYWKT8FluUOrht4yePZT
 st7HOeSbLLqGwzQfY+EAfb1Vc3Y0kyR0dmz75F07az3jQQVOlsW6skU9AM59G4N1m6dI
 CDxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0YM1ekCdWfpuK0Cqhp5n5gQlt71LwgTSSRvWyAUrzLp5whQVC2YT1qHwNHF4RGMLPIvVOG6Qoby2@nongnu.org
X-Gm-Message-State: AOJu0YxC28taYgaDXeHqbsxw0YVZBEjP9McTJNB4S3D4OjoZQS/MsgaQ
 XavmRqiyTVMpPmeEx8JorQNoUpM29n0eMw85om3HNzK8uenA3t0DplH96UUXOfb9SOBjiDCvuqW
 U
X-Gm-Gg: ASbGncvNoo2jN+7wPHftSEA/gWeHALJK81rDzbfnoQjIjQRuGSzgf5WHrRgYfp8UOAQ
 mPPZIcO4UkbKFzI/HeHD4lcyXwdDDpEYSGPlIIHLl4slmn1iGBd5l/VswCKkK4m3SXkjtx+jT5w
 Z7+JJt7Ly1mLl3+dzrvOVvzhXTt532nBm2oHSBd3cPa9hPzvG07Au4vtUqUE4y2PfG+uIlrQXpX
 FUXoiM2A1n9IjmSB1xlLDVB+VIyqqlbHydsXc8gBiH24SQFWLpWMmw2pE/FQadkssyncropVuvC
 kqZNBaqQgTpXt+pNDnmyUc7z7xKaGWLMNSxEJev0ue8QkONGIejNc6hVEG+xlCdI9vOlYaAeaWn
 pRP+6B9aLacp9
X-Google-Smtp-Source: AGHT+IEG8/ZRexdltCwHljV5fyGSw6ZpHUXbFXExNw5+dlaNcmQEDvgsamVMTQmtoNWd36NTrAE+ng==
X-Received: by 2002:a05:600c:198e:b0:43c:fded:9654 with SMTP id
 5b1f17b1804b1-43d438220c3mr22807075e9.19.1742385553447; 
 Wed, 19 Mar 2025 04:59:13 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e35sm16811755e9.14.2025.03.19.04.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 04:59:13 -0700 (PDT)
Message-ID: <1545aa76-6319-4158-854a-1edfd2e8a595@linaro.org>
Date: Wed, 19 Mar 2025 12:59:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/uefi: fix error handling in uefi_vars_json_load
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-4-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319110152.1309969-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 19/3/25 12:01, Gerd Hoffmann wrote:
> Catch lseek errors.  Return on read errors.
> 
> Fixes: CID 1593154
> Fixes: CID 1593157
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-json.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


