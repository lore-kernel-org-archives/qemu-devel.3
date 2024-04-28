Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9773BC19F53
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 12:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s13Q4-00023G-OW; Sun, 28 Apr 2024 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s13Q2-0001ze-To
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 08:14:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s13Pz-0004Qh-CI
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 08:14:10 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so3294586b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714306444; x=1714911244;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pxi1nhySvDdWFFLHrh42RTy7sNIg3/IiFA7vC1VBw+M=;
 b=BTs40Wrf5Zq5VOORntHcw1Yc320FH+E/Sd0cdalWjF1Vgp3E2qv0WX6n8CqQz3tf0i
 f5IXHT6UWJWuG4NlvCJ30pWYLEoTyrTxZHOu72lmeThFJPyXt3TsAgHzr/t0Ra3ejQax
 eWV6Y9n9LUSDSh24DbPO3Pe5mhiNG10WmImEAUo5yhg22mdl7VRkFFTy2Nyen0EBBGpc
 ET8WflMnWgmTxasY1s/QlwlOODrhB8cSY0n0ZyER9JAqJoEXG0l3R/7e0I3cW3y1G/oe
 cBvZxjhMr+fKqnS/QE217+WNXhQldZoMN3S0kdxgVcnrbb8SQlUn52aYOI2+HDj92JHw
 3uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714306444; x=1714911244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pxi1nhySvDdWFFLHrh42RTy7sNIg3/IiFA7vC1VBw+M=;
 b=XvyMJlwN96lPuSepW4stC/A79qm/HP6k0YDauXiY94GdzZXOTV4+ZH4QXSXwJxJSiY
 GLocb8rhuLTvBn0Q/ergv//wO/kbLAmzaNfjyfgNLlPOW2R+dd2Q8RyJtjt503hRnQtn
 n8B/N7+Htbolm+yDuqzmHitZTw8TaeFg5R8XLyaRsaOO+CKOdAjXkjV4DxCGL2+yF3i8
 /uP4ffkSbNNUBwHFHCRjsdO9mCGnHdo2z5fDV9+ex+Js3Dl4JO2rNs1kmiie4Yx+g3rZ
 cA+xKU4ECb4hxAxrKmRvGKNiY/dSiX4zm2S/u7OQe1YkvrJzQdsiaOib5lNz28kXEYBE
 fCsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxdEatYf8SucaA1I00AWMKVT+Dq+niLyWhpq764sh/UU6J2YJ3kQTeNbubYBPc+X0e7/4U3d8VBYnc+3cR2FfuWU9D2CE=
X-Gm-Message-State: AOJu0YzaOfu+YG18a+5oZ+fr70WhCINnmIOhCevRibcw9Cx6q7oK4S0M
 BxPWmLc/tQGQZErDos5H5AHFlKaaxq4+hQRav0CmBoaaWpuaM8Nnbg8beLmpb94=
X-Google-Smtp-Source: AGHT+IEJy26udM8VoGc/ZSphZVOWGxbX5RN7gcUvJxIpxJnxh1AepDIYAOfJHnDiSjBc7t37hXmPcQ==
X-Received: by 2002:a05:6a20:5655:b0:1a9:8152:511c with SMTP id
 is21-20020a056a20565500b001a98152511cmr6925523pzc.62.1714306444366; 
 Sun, 28 Apr 2024 05:14:04 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a170902e54800b001e2bb03893dsm18377253plf.198.2024.04.28.05.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 05:14:04 -0700 (PDT)
Message-ID: <9f9feaca-3028-403f-b9e2-36f64e8638f2@daynix.com>
Date: Sun, 28 Apr 2024 21:14:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Fix safeAreaInsets not being available on OS X 10.13
To: Tobias Markus <tobbi.bugs@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com
References: <fa98f79e-f682-4efc-9cfd-37a108b853b5@googlemail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <fa98f79e-f682-4efc-9cfd-37a108b853b5@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, PDS_OTHER_BAD_TLD=1.874, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2024/04/28 20:57, Tobias Markus wrote:
> Hello,
> 
> to prefix this: I previously filed 
> https://gitlab.com/qemu-project/qemu/-/issues/2314 for this compilation 
> error and I'm quite aware that QEMU only supports the most recent two 
> versions of Mac OS X by default. However, given the small change 
> required for this to work, I hope you can make an exception and include 
> the attached patch into QEMU.
> 
> It would really help me continue to run QEMU on my legacy MacOS X 10.13 
> version.

Hi,

I'm sorry to tell this but I'm not for making an exception.

While this change is indeed small, we already have many codes that are 
only needed by unsupported macOS versions. They were not added to keep 
QEMU work with unsupported macOS versions, but they were added when 
those versions were still supported. Maintaining all of them is not a 
trivial task so they are now eligible for removal.

Regards,
Akihiko Odaki

> 
> Thanks in advance!
> 
> Kind regards,
> Tobias Markus
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2314
> Signed-off-by: Tobias Markus <tobbi.bugs@googlemail.com>
> ---
>   ui/cocoa.m | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 25e0db9dd0..96992736ef 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -539,9 +539,11 @@ - (NSSize)fixAspectRatio:(NSSize)max
>   - (NSSize) screenSafeAreaSize
>   {
>       NSSize size = [[[self window] screen] frame].size;
> +#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
>       NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
>       size.width -= insets.left + insets.right;
>       size.height -= insets.top + insets.bottom;
> +#endif
>       return size;
>   }
> 

