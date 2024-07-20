Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D39C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 07:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV4eb-00046u-Fs; Sat, 20 Jul 2024 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV4ea-00046R-Jt
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 03:37:16 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV4eY-0003kS-Rd
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 03:37:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fbc3a9d23bso19147595ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721461032; x=1722065832;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrAZso19fqxeBKuRsdBPsgtjLxqPngIzRriCWaQphiE=;
 b=pvoafla+nh4vIGrxKcgvF3rpZKsG3UiAIa2pbRRMmxOQxMiAHI2IBe3xenBqKnNvgM
 YkM+fU9zevHDYccLnb1/sCBKJp/Ua0dZ0NydMh7hbTi2VepSgykWbS2C/lKLDNeboQT/
 vjIN/4zJ9dOJuT/GENvrSzJLw3vl/ZAtzU0Ys76hTYQocbcWgsEllsX/B4emBCRHAUmD
 H6+CrwQZRb+NuIab0uZS1UttpjdGj1fprW1Eb0hH3DqjKlRzDMgNMmeMefcGW4hGSxDT
 zSFmlbYrvhg5RpAbu/bz9vXWzrERh7nNRW+JhL8ePks0Fw6f7/7iiiCSXFiNhX5a9po8
 OCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721461032; x=1722065832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrAZso19fqxeBKuRsdBPsgtjLxqPngIzRriCWaQphiE=;
 b=oXTNM3YgJLCPGG/qmICYzxHhgCO46Lj/k68tMDaJlWlU6SUB6M0JkBn5GRZK1Q7tpG
 IAdxjTz4M8h2Ra7DHMOlHOoe5LTqgKbcyarWlzFsOiYi2dSpjHEQfrSGr1vcviCrUpHC
 XTaGrnshSuuuXWqC3YjSSzJqsEmwyGvpnNXooxWzzuNbcx8WEKcciMVoyLBW0q6PZpdS
 XKxK/WWL6U3qOPDnhDElbSzQ2zNHRAMeXoPGMCrT7Bz+9wrLvCmLxWDn7oiAP8NN2Cb4
 iwlUIFTJH9fHcd47gy7hBh05XL+73MraYVwYMaQSRmABCyGVHhT44h7ef2DAineHfuua
 e+2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs8iT/eoDuIpy+JAlUUc0s04vAopcZBRAa4XPY/TN/4TWDIqbuwhU2AI6DiKIX03Uf3vSE4Q6K3B8n/DZD6tIQybzqU3c=
X-Gm-Message-State: AOJu0YxpZCnljFIGN48pAnazh1C5jr5AjCl/86Jcv9ktZLN7bkVbGAjX
 qt1jl/JmQWFT479X4ns2W7PF+uMoF+6x6C9pX6keHTU1+ylmvdINVhKEZAiOmCM=
X-Google-Smtp-Source: AGHT+IHmGL0maaqF6LqKoCGen9+8kCK5m9cvoy0NrR3/JFEf2nh6kEzzPZEGMlZAOALaaLej9SUsnQ==
X-Received: by 2002:a17:902:e74d:b0:1fb:4f2e:8b7c with SMTP id
 d9443c01a7336-1fd74533ff5mr18346475ad.7.1721461032493; 
 Sat, 20 Jul 2024 00:37:12 -0700 (PDT)
Received: from [157.82.204.122] ([157.82.204.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f48cd7csm15999995ad.286.2024.07.20.00.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 00:37:12 -0700 (PDT)
Message-ID: <ff50879f-fca2-4658-bea5-fce60e396ad1@daynix.com>
Date: Sat, 20 Jul 2024 16:37:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cocoa: Do not automatically zoom for HiDPI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
 <CAFEAcA_i3Os6YPwxx99sWvK5qdzopMGBZgvVKJ7qX-waCc7RnQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_i3Os6YPwxx99sWvK5qdzopMGBZgvVKJ7qX-waCc7RnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/03/22 22:06, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 09:02, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Cocoa automatically zooms for a HiDPI display like Retina and makes
>> the display blurry. Revert the automatic zooming.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   ui/cocoa.m | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index fa879d7dcd4b..c5b3c28000ff 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -522,7 +522,10 @@ - (void) resizeWindow
>>       [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
>>
>>       if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
>> -        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
>> +        CGFloat width = screen.width / [[self window] backingScaleFactor];
>> +        CGFloat height = screen.height / [[self window] backingScaleFactor];
>> +
>> +        [[self window] setContentSize:NSMakeSize(width, height)];
>>           [[self window] center];
>>       } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
>>           [[self window] setContentSize:[self screenSafeAreaSize]];
>> @@ -575,8 +578,8 @@ - (void) updateUIInfoLocked
>>
>>       info.xoff = 0;
>>       info.yoff = 0;
>> -    info.width = frameSize.width;
>> -    info.height = frameSize.height;
>> +    info.width = frameSize.width * [[self window] backingScaleFactor];
>> +    info.height = frameSize.height * [[self window] backingScaleFactor];
>>
>>       dpy_set_ui_info(dcl.con, &info, TRUE);
>>   }
> 
> Could we / should we use convertRectToBacking and convertRectFromBacking
> rather than doing the multiply/divide ourselves? The docs seem to
> recommend against directly using backingScaleFactor when possible.

Sorry, I forgot to reply this.

Unfortunately, Cocoa does not provide a method to scale NSSize while 
convertRectToBacking and convertRectFromBacking work with NSRect, which 
is the reason why I opted for manual scaling here.

Regards,
Akihiko Odaki

