Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D98C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR7I4-0003ko-ON; Mon, 16 Jun 2025 06:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR7I2-0003ju-Vu
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:42:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR7I1-0000Di-7j
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:42:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so34680265e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750070527; x=1750675327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yfbXf2J4PhPWdMLbh3iR7m+U1DLWdwWj3p/fccBjIaA=;
 b=cKwDZqRO+lSnhnDHA3ReWv4lf14QC0eWyknM1I0ysHTOuuwtXL+ks+C839EXGIK71Q
 jmqvtysthzo+7Z/f6L0GvyXcfFhtlt/+Oa96inNJIBguvPcOPPSLanv+7QA4zCw2n9GS
 lNmblMTHl/dl9FCLg9vYYmDQ8lqHXClZDJ2qhwa57LOAjHIpVESauIS3nJrT6X8qkMGj
 5drZNscjzyxwcOquIIeOQQZvA2WIWPTOILN/YF1gTzst+0e8uyxC53xTm3KipvhA4ZRs
 Qv91Dw43JhbWyTEIdA8st/Qc0SAO7Z+6n7Nxbd2XX1CCqFYhuvPmSLgqUBrxibYhmuAr
 LhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750070527; x=1750675327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfbXf2J4PhPWdMLbh3iR7m+U1DLWdwWj3p/fccBjIaA=;
 b=VNMV1nRkfkgmy6yMqxX98VRXjCv/dPgMy6BOHQC734QNdGDJWxlV6Lt5ZMREFXVv1x
 mRWplzrG8v0q5mhNJfS0toCsH1dz58ViF5I52nPVJPPnDRQLMlsGO4RfabaECUqPTfEJ
 pt2DfYfaMua9S1yG8+VqaZM4U8HkW16LG/j/CaW3PB87Tg8CXG8oVNcWogFzpOEFaffp
 00AkVEpO/qt/I/jjZU4JgdZhNPijQcs5Vg9y20+/Zh2oWdWn9GqAxyveb3uYnV90Ey9Y
 wyKh0PkQGSpa40x4I8P0/bMrTjseyFKZhh7VpAfz8kQfu7uwzXacxFaHLirMYaIJDJyN
 jZTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdjg3UbKHNbPV2gqVWIqGOVTNCtTugwp6r6MhnXbh9CLB4N4ch6Zae2bPn9kagozW3gG8on/zkAMjx@nongnu.org
X-Gm-Message-State: AOJu0YwceJ/5i8twwqR/dwkqElbtLtVAf+psjg/8MilHp+Sirfg8Shke
 DaFp2DCr2qxzjXT8hqGJ0yZsef3ES9w35ohIx3ycEcMlrfCsr5V9UW+WDHPKWvZSQ7I=
X-Gm-Gg: ASbGncvU0ineH9ev7hMHPM5LCwAx3uR9LTCHmSl3NcR+ON4EnPWoM9af26eWFIvHPPf
 3FJqB1rYcKXSyzajTfmt+XIxtNo8sIM3WZ6DpnNiLxnuz9U7jKHxg9aCtJqEjcZbcZB0S1kt4Ut
 cmqxcu+sMqauOsa2hA0fNZ/18QWL/oayz2piHmlMeBPcHLo/gkXSqvTqjsb3syFmXnxyTxFuhJ8
 SkaY+kcDnMV+qH9tKLM18EXnCX4eovBRAlndD8p1h5Rx4iNjo7pmSFqmpKh+PYhtKGFDhSbt5NN
 ZCcn6ADn6CDWYbjjgnaEJa+WBxBwmzM5NddZgIqoE6rGb92NGKNd3gONY3L9XSTetGciONhscLA
 lvrb2i/yp/EADMs5XJPeZHl8e2A18DA==
X-Google-Smtp-Source: AGHT+IFe3v4WR2Sdd6uaotn3Nw8zNp85vGgONyx3ujoO5zHiE66IOv/1HUcLoVtpIM37dnbOQLMrmA==
X-Received: by 2002:a05:600c:468c:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-4533caa5fb4mr79873545e9.19.1750070526653; 
 Mon, 16 Jun 2025 03:42:06 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e2354fbsm138865165e9.15.2025.06.16.03.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 03:42:06 -0700 (PDT)
Message-ID: <84c1902b-9396-418a-8fc5-246eabde3f46@linaro.org>
Date: Mon, 16 Jun 2025 12:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add vfio_device_get_region_fd()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250616101337.3190027-1-john.levon@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250616101337.3190027-1-john.levon@nutanix.com>
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

On 16/6/25 12:13, John Levon wrote:
> This keeps the existence of ->region_fds private to hw/vfio/device.c.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h | 12 ++++++++++++
>   hw/vfio/device.c              |  7 +++++++
>   hw/vfio/region.c              |  5 +----
>   3 files changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


