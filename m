Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB9D6ACE6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 11:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWC7C-0001nQ-U4; Thu, 18 Dec 2025 06:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWC6y-0001hr-Pj
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:24:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWC6w-0002xn-3W
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:24:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso4370035e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766057036; x=1766661836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V1bLvIZQXiXM9LxnnKcWu/Yj9UvAis949LkpGaZbtPI=;
 b=kVsIMiSDL6m4VmpJQzw1RcDQ6rWKtYIN+en2ErakL3sjHsAlVHmiOSIu6Vwe6d6/9m
 E/HtzDgdhgqS+1fHzwMu+wn1o9YFVVgs+chRKTwKR7vwZJovO6akSP+reweMrkRboOXj
 LwW/7V7rhbCFCrQIQNmkO2ogSdDXGefeRveZoaRGFfboN9MPrrEW1DF3LxrTN2i/CnrF
 rmdMqC/6zkFka/XUBqMui2/a0Bu4m/NAVKkgECdi8jCKGLU6aZXPXHludSmlTjWpwxIo
 g5K4VG4qQWlJ9XmOfsmQthLfOFgoPjAyYyHG/b6pVhLgKlPLE38hjlxgX+k+Eg+whDXg
 PICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766057036; x=1766661836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1bLvIZQXiXM9LxnnKcWu/Yj9UvAis949LkpGaZbtPI=;
 b=gQaaoX7jFDfHwE1VqVvD9DnUXTQ7hiyg0tLpmPv+D+JI/qJ7QbVmnn8fwxX8hiLDhl
 /1dXxOwOG+/180YK4W+sjO3NjitccXUntYyHpsbVxgzxxVdPH2d8IEwI1IG2OC+TUQce
 lo7WCWw4AOfaX8Aug56YomxnM4HjI/gB864yuQfbifO7KVblN1ocIvvMWjo3QcV8uvSH
 MANrVX5liGtKxhYXb01sX4R2jdPFMCgt1qfajBlVmwKsuzv373AJVfTKwCPrtU7I2gka
 YZbd6n291hBOHbxYDBYeJoj+JUDTJ92oRXtR0xHBAnevfBciWx0a+TgfZapH9y7KmjFy
 FSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtk9n7ig/IqemyCXkgDOw5R0GvTAhBd9O74EhenoFfffoS9FUcq1lPnkQFMR/Xfpv+FhC7w7Mu48Tx@nongnu.org
X-Gm-Message-State: AOJu0YztcHfSItryfvfSPG1GgksEbPTH1M4P5OcazB2uAdYZjOvBIdGj
 g6ibiXX2jppfAeOCr5TF3H6yjcq86JS9TG+dgNIIp3PK8iKVnP9egFBtBd7z53rxObs=
X-Gm-Gg: AY/fxX7rdp4KIfMo7THPuNotjCQ8nx/pSbvvs7SwQRk4XUeKYfAntdunK3Ygn27tZqC
 TYHbk+tU/XpC+WkysAiTvynYu5nkYKwKm6CXw6bUJykORRjUD1/4p+p5OAUh+6V3cJVdrY5RQ99
 6+LqGM0X2VXWkRMHwlVltKIPE+2+dG7aPPvROftVlpeFwSvDh0Z8ZP8nIO8kXcHBnXtzmLbq0yy
 cDdKg+yQQrQVwnNmHeUu/cf5obQ3S3Nhy2VQo0v3XbaYmeY3SiKYZW4xbPZyZNZRdHY3+rcdCmB
 1ZyC2aC8FT6/iQ7fJq0YuqvS3Ya8OtxKL0RTDHtDxftOu4KBbhCJWxCw9FwFKq5depTOj0Lc1i9
 DqKyAdsSe+tDtkmryXsFMK8y33wVxPRVQl9eEbrQDT/6HWg+bAhGLJN/yhYPmWhfS03jzOaF+gc
 Q+Ac6j0xO3EUzMoGVoKFQVl1Qf4V4wprmXRK8Kp49CfLbKUSdmPBcQiA==
X-Google-Smtp-Source: AGHT+IEDUDVnoD9to2qjksSK332rjBbkyQbaYf+yX5Q01DIb86Xvl6o03MtSu/ZwN8glXn4AOE2D+A==
X-Received: by 2002:a05:6000:2087:b0:430:fbad:687a with SMTP id
 ffacd0b85a97d-430fbad6b51mr16705673f8f.13.1766057036527; 
 Thu, 18 Dec 2025 03:23:56 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324498fbdfsm4439024f8f.26.2025.12.18.03.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:23:55 -0800 (PST)
Message-ID: <6e850467-490e-4a32-b60f-2c91efb3efa1@linaro.org>
Date: Thu, 18 Dec 2025 12:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Remove stale comments related to iommufd
 dirty tracking
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
References: <20251218065042.639777-1-zhenzhong.duan@intel.com>
 <80397b14-160b-4a87-a0cf-d828f2974c85@linaro.org>
 <IA3PR11MB9136FEFC7DD10A5AECEEF40292A8A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <IA3PR11MB9136FEFC7DD10A5AECEEF40292A8A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 18/12/25 12:07, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH] docs/devel: Remove stale comments related to
>> iommufd dirty tracking
>>
>> On 18/12/25 07:50, Zhenzhong Duan wrote:
>>> IOMMUFD dirty tracking support had be merged
>>
>> [in merge commit dd4bc5f1cfe?]
> 
> Yes, or you want me to add [in merge commit dd4bc5f1cfe] to commit log?

Maybe Cédric can directly add that when taking the patch ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks,

Phil.

