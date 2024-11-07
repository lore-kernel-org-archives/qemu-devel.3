Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC65ED5AE60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 05:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8uco-0000VT-Mw; Thu, 07 Nov 2024 00:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8ucn-0000U9-4k
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 00:00:05 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8uck-0006Ec-Gl
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 00:00:04 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7181b86a749so299287a34.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 21:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730955600; x=1731560400;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CR9dQFSd9mLM/+/pqi5uPtiGA6rgSVROGDApZjnCZdc=;
 b=wZgmxPLSKJ4o8JaEip+j61D64lqmxnD3xrdSNjh2rIH51egAg79crOAL+0fP4qiJwU
 02iONGB9IjKUdeOJcRKv7ZO4MwL330P0OLz4MCrrAvT5bLYSufZfvmWwwK/dTXzgXLwp
 CwtUH3j5wdfQeEkK76KPgq7AppA2EMElKRbBEh2S+0pjnAiVV/xOKG0xVKxf4ryy1Hgk
 ZGf9+Q2x7bbV8g43lrMJE6k+808LW9C8GkbaHxAnr55vLI3zhij2XhTrocgLmwYpwdUv
 Z/781YQ/4d3ZfBHZ/WolkZAhaypwyU4eEZ7iUP1zOP/bX8QFxiQXCYM5wWFhZ2V7erv9
 DlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730955600; x=1731560400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CR9dQFSd9mLM/+/pqi5uPtiGA6rgSVROGDApZjnCZdc=;
 b=XjeLMHHLD1tnE2y0BTwbgZFB+EHRS8+jberDV+9tC9mccERIrfvI4aSnMQstdQVmqV
 O8WLtgdATRnl2SYMRmJmF8JQfjZTOdIsEps7jHbhNPyvWIAilso8Zw0NOCFrGJaMyeB0
 hUfBQuxt4d/rCvZZTcHx0pGk2j3R3Zbp9UNfW41Dl7DrFkzKwGHbxfhLo4ayYFUjS2YI
 5d+wLtb8rDNOuYhFjl0A6Z09hGw4Zo/bdgZfUJU/U6TxsRPmlqV8slbI1vZ8QjEQpQHz
 hWoKuccMDuH8gp/P04zDz5NswzCvSI3JO7Ti497o7XMd+brdoUm0jWq44E20/y+I/ERl
 cmTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYWKQx6CJQP4t2qd3//dAl45sCXA0M4fYfa4CsMtxQhMt7/DuOkDQucGkHA/DJo+NeTZ2eXxCgWZ16@nongnu.org
X-Gm-Message-State: AOJu0YyZq9uj1Qv3xGVhRhaUFJkesUUqYptUE66jsqQdSTL1sT1cg/4J
 HqqRLEOnhftWk5/MeZXh4X2WKLfiV1KwCZHYu73Q/MNtFPHdM+mF0CPFB2TakpA=
X-Google-Smtp-Source: AGHT+IEItlXl6V+5IEBTXWxLsGHSJ/dkZMK6og2lOpA9dFYVAMK1sXzcRFXZxAzodQczXRkzX04Blw==
X-Received: by 2002:a05:6830:44a5:b0:718:9d91:6a17 with SMTP id
 46e09a7af769-719ca192061mr23540011a34.11.1730955600345; 
 Wed, 06 Nov 2024 21:00:00 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d758sm426039a12.69.2024.11.06.20.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 20:59:59 -0800 (PST)
Message-ID: <77a7268f-06c7-4e2f-ace2-14290f16f2b6@daynix.com>
Date: Thu, 7 Nov 2024 13:59:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFT] cocoa: Remove deprecated
 CVDisplayLinkCreateWithCGDisplay() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241106175051.561352-2-pbonzini@redhat.com>
 <c78fe9ea-11e6-4f3f-858b-7fe5f6331c58@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c78fe9ea-11e6-4f3f-858b-7fe5f6331c58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
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

On 2024/11/07 7:59, Philippe Mathieu-Daudé wrote:
> +Phil & Akihiko
> 
> On 6/11/24 17:50, Paolo Bonzini wrote:
>> When building on macOS 15 we get:
>>
>> ../../ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is 
>> deprecated:
>>      first deprecated in macOS 15.0
>>      - use NSView.displayLink(target:selector:), 
>> NSWindow.displayLink(target:selector:),
>>        or NSScreen.displayLink(target:selector:)
>>      [-Werror,-Wdeprecated-declarations]
>>    662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, 
>> &displayLink)) {
>>        |              ^
>>
>> Instead get the refresh rate from either CGDisplayModeGetRefreshRate 
>> or IOKit,
>> following the model of https://github.com/gwm17/glfw/commit/4ec7daf3e92.

It looks complicated. We can use [-NSScreen maximumFramesPerSecond] and 
[-NSScreen minimumRefreshInterval] instead as they are available since 
macOS 12.0 and cover all versions we support.

>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2575
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> v1->v2: use kIOMainPortDefault
>>
>>   meson.build |  2 +-
>>   ui/cocoa.m  | 90 ++++++++++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 79 insertions(+), 13 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index c386593c527..b12ccc12223 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1135,7 +1135,7 @@ if get_option('attr').allowed()
>>   endif
>>   cocoa = dependency('appleframeworks',
>> -                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
>> +                   modules: ['Cocoa', 'IOKit', 'QuartzCore'],
>>                      required: get_option('cocoa'))
>>   vmnet = dependency('appleframeworks', modules: 'vmnet', required: 
>> get_option('vmnet'))
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 4c2dd335323..c3fa55477fd 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -25,6 +25,7 @@
>>   #include "qemu/osdep.h"
>>   #import <Cocoa/Cocoa.h>
>> +#import <IOKit/IOKitLib.h>
>>   #import <QuartzCore/QuartzCore.h>
>>   #include <crt_externs.h>
>> @@ -292,6 +293,75 @@ static void handleAnyDeviceErrors(Error * err)
>>       }
>>   }
>> +static bool get_fallback_refresh_rate(CGDirectDisplayID displayID, 
>> double *p_rate)
>> +{
>> +    bool found = false;
>> +    io_iterator_t it;
>> +    io_service_t service;
>> +    CFNumberRef indexRef, clockRef, countRef;
>> +    uint32_t clock, count;
>> +
>> +    if (IOServiceGetMatchingServices(kIOMainPortDefault,
>> +                                     IOServiceMatching("IOFramebuffer"),
>> +                                     &it) != 0) {
>> +        return false;
>> +    }
>> +    while ((service = IOIteratorNext(it)) != 0) {
>> +        uint32_t index;
>> +        bool found_display_id;
>> +        indexRef = IORegistryEntryCreateCFProperty(service,
>> +                                                   
>> CFSTR("IOFramebufferOpenGLIndex"),
>> +                                                   kCFAllocatorDefault,
>> +                                                   kNilOptions);
>> +        if (!indexRef) {
>> +            continue;
>> +        }
>> +        found_display_id =
>> +            CFNumberGetValue(indexRef, kCFNumberIntType, &index) &&
>> +            CGOpenGLDisplayMaskToDisplayID(1 << index) == displayID;
>> +        CFRelease(indexRef);
>> +        if (found_display_id) {
>> +            break;
>> +        }
>> +    }
>> +    if (!service) {
>> +        goto out;
>> +    }
>> +
>> +    clockRef = IORegistryEntryCreateCFProperty(service,
>> +                                               
>> CFSTR("IOFBCurrentPixelClock"),
>> +                                               kCFAllocatorDefault,
>> +                                               kNilOptions);
>> +    if (!clockRef) {
>> +        goto out;
>> +    }
>> +    if (!CFNumberGetValue(clockRef, kCFNumberIntType, &clock) || ! 
>> clock) {
>> +        goto out_clock_ref;
>> +    }
>> +
>> +    countRef = IORegistryEntryCreateCFProperty(service,
>> +                                               
>> CFSTR("IOFBCurrentPixelCount"),
>> +                                               kCFAllocatorDefault,
>> +                                               kNilOptions);
>> +    if (!countRef) {
>> +        goto out_clock_ref;
>> +    }
>> +    if (!CFNumberGetValue(countRef, kCFNumberIntType, &count) || ! 
>> count) {
>> +        goto out_count_ref;
>> +    }
>> +
>> +    *p_rate = clock / (double) count;
>> +    found = true;
>> +
>> +out_count_ref:
>> +    CFRelease(countRef);
>> +out_clock_ref:
>> +    CFRelease(clockRef);
>> +out:
>> +    IOObjectRelease(it);
>> +    return found;
>> +}
>> +
>>   /*
>>    ------------------------------------------------------
>>       QemuCocoaView
>> @@ -655,20 +725,16 @@ - (void) updateUIInfoLocked
>>           NSSize screenSize = [[[self window] screen] frame].size;
>>           CGSize screenPhysicalSize = CGDisplayScreenSize(display);
>>           bool isFullscreen = ([[self window] styleMask] & 
>> NSWindowStyleMaskFullScreen) != 0;
>> -        CVDisplayLinkRef displayLink;
>> +        CGDisplayModeRef mode = CGDisplayCopyDisplayMode(display);
>> +        double rate = CGDisplayModeGetRefreshRate(mode);
>> +
>> +        if (rate != 0.0 || get_fallback_refresh_rate(display, &rate)) {
>> +            update_displaychangelistener(&dcl, 1000 / rate);
>> +            info.refresh_rate = (int64_t)1000 * rate;
>> +        }
>> +        CGDisplayModeRelease(mode);
>>           frameSize = isFullscreen ? [self screenSafeAreaSize] : [self 
>> frame].size;
>> -
>> -        if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
>> -            CVTime period = 
>> CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
>> -            CVDisplayLinkRelease(displayLink);
>> -            if (!(period.flags & kCVTimeIsIndefinite)) {
>> -                update_displaychangelistener(&dcl,
>> -                                             1000 * 
>> period.timeValue / period.timeScale);
>> -                info.refresh_rate = (int64_t)1000 * 
>> period.timeScale / period.timeValue;
>> -            }
>> -        }
>> -
>>           info.width_mm = frameSize.width / screenSize.width * 
>> screenPhysicalSize.width;
>>           info.height_mm = frameSize.height / screenSize.height * 
>> screenPhysicalSize.height;
>>       } else {
> 


