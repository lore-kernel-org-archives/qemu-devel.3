Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAEFD64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SUX-00061c-Fk; Fri, 08 Nov 2024 12:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9SUW-00061T-HV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:09:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9SUU-0002lr-V7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:09:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4319399a411so21993935e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731085785; x=1731690585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=anre3UX/Q9LKNUKzlTXXRzRTgzlC4t64X4GOdMvZ1/o=;
 b=sb5hUYf9QDIETrPfHGatmpEZXD1RjJWPv3kjsAr2SkEZo+QCruaaUpsZAqQwchjMz8
 FYIq5szVMoEK7o7Tsf10i0bKt9mP41XMFa+9TN1dxUdDrrdpbm47vMPD7+gZswOPh41F
 oCVUhVb74V1SbMA21JqCCdXQ/l71ezPgJ6zy6HRRCfBXZ0uVrIZqBoAoQPjVgh7EyX2m
 9U2GRd/6A6z+JwAS8NjVRsIBqFIOkTvv61CordUxkjp+A2cw//vjVPENtZ0q2Bp6uSNu
 Xvolbf4F6W67znU3VerWDNRRLoWcPpr7K40VF3CQK76E2M4RaffSiUR/p5XwHrHR1VHZ
 LG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731085785; x=1731690585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anre3UX/Q9LKNUKzlTXXRzRTgzlC4t64X4GOdMvZ1/o=;
 b=O8oys7dlgNI0RbNHJ2m+A4/8wHctUOMqqYMl7NslmD8fYRm3OuJar3Zyok/mSAdoLs
 4n57zF0LOUCDbwToL9f2P2FUgq9DrcIT2OWlaLNMUBywXVed+QkE0XajBlEK1RZSjfGg
 185LqOTl3Woemd3lSCaIqi+vAHs7Zb5AsONVBndPpQkiuyashoM/z+MWTo4kNEhwMXB2
 nRbxnhh2cvLQbvdTOD5kGrrQTUIvwKekmkeub57mMZpEnwR7WxWCInWDJpT1BWahqFy3
 pu/Z0iCoeAkPNbdiIfjvGPWhLUKi+eTunzrSBIK03yK4CBwkhHDvJcmO88eydBL81kXL
 E2rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc1x5zKiBSBBA2rZz5GkDJGebVwh06EvXFM4rN9It0RyXy6mcH5tIyZjJUqWZ+wXTt9HtyL8B3/52N@nongnu.org
X-Gm-Message-State: AOJu0Yy6oiEXJ/jlKd3mA8AXxdx0eDI5l55NVA+HzDeC6oCkPd6NZBiE
 ossgZ01iieKxflPMeQcUwW7WZl091CqVP4IE4MYoQJl+5pV0ovLW1N2/GnIIC14=
X-Google-Smtp-Source: AGHT+IHzQljYn9zl9Qcm6YZiPfAWUj7AE1ac0UDgGwwxPgi27XtLgRxV1d1YA6Pi1v37BZm/v9LlMw==
X-Received: by 2002:a05:600c:5124:b0:431:46fe:4cad with SMTP id
 5b1f17b1804b1-432b7501d4emr32509205e9.9.1731085785371; 
 Fri, 08 Nov 2024 09:09:45 -0800 (PST)
Received: from [172.20.143.32] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c26e3sm77999075e9.33.2024.11.08.09.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 09:09:44 -0800 (PST)
Message-ID: <7a3a49eb-6527-45fc-8294-275d1985d9b4@linaro.org>
Date: Fri, 8 Nov 2024 17:09:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] system/dma-helpers.c: Move trace events to
 system/trace-events
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
 <20241108162909.4080314-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108162909.4080314-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/11/24 16:29, Peter Maydell wrote:
> The dma-helpers.c file is in the system/ subdirectory, but it
> defines its trace events in the root trace-events file. Move
> them to the system/trace-events file where they more naturally
> belong.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/dma-helpers.c | 2 +-
>   system/trace-events  | 7 +++++++
>   trace-events         | 7 -------
>   3 files changed, 8 insertions(+), 8 deletions(-)

Fixes: 800d4deda0 ("softmmu: move more files to softmmu/")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


