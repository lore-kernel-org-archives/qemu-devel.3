Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F074E64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIV0R-0006KV-5I; Tue, 03 Dec 2024 10:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV0O-0006H6-3K
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:40:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV0M-00012l-2x
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:40:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a736518eso70285375e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733240400; x=1733845200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgxWjMbGVj36P5iujF8l+0H0BqFxjJd0qrVoacn97/8=;
 b=ZxqtiQCiveKnkj+9+8wXa0apn0z1QXSnYPgXrYhRr4YUP7P1Moyo0mOisLoEL7HDRI
 +tXpjrErOuRKTLdvMMxkfyxxg87otYN1z5MdTUawP1QojNi5GvIEyPG+gxh4f5ybr9Qu
 srkameQmsxSKrrm03ElCfXclwfzmaZacW+2feBLAbORkAtWdhIEDtdcShJ34EaFz9bSQ
 Axat44z/YKyGiJM/77D7llfgZ170WCvkhatYGqsTl8qWA3nFwzqm1CvDft2gISTJO2FV
 VB0A6u5ew/0BNKWRcqCX4iUVejSFDr7zwOb9wXdd0zv24iCn/1I1NxU/61lHqqzXWX1E
 yByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733240400; x=1733845200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CgxWjMbGVj36P5iujF8l+0H0BqFxjJd0qrVoacn97/8=;
 b=risVh7+gLJMTkwEk5yWp1M+ip2+q+dyaiyK4CVFnNZfL+KSwcJxizzs8WiaBASwSyX
 hbBbnGbjnjLkH9bNlmExXd6y4X4NtrZnCxVe9yNnVps/is3h3NwL1CICtQj+fWvAbNOZ
 S0JYnMrTN9lfRj26yWHItabxIl6MP1XBxq9pRcGWrFOaNe9Q/CF6HI/xU6AGEFyKFECM
 dylXCmlNJRzieMpI70EIKSCa2fpqnWtgpM5kpE9WNYSJxQT0IISLx8EBpC5hGFrlrzeD
 5Bdy674U+CrTPcpI9trTy/W2o3Ivf2YFIv00cwQJNu+vRE2mLOwUeMMjDKry/Va0zBVp
 y59w==
X-Gm-Message-State: AOJu0Yz345nC+XA0DE8uZLnFlFZVUXdDciSLqyZRalWWMHNCo99ybB+j
 NfZK/6F07u74RhnQ+XlEQcokQkyk/CdDJf4aHnuMKBFZDjyYNUKcCnl+YMn0TUH8JnOkCcLiBFd
 Gs4I=
X-Gm-Gg: ASbGncvZxeOY1ba38/Kak793pr/CnskMyA0kRbXlC/CDFio8AlzBgvwVQOtdcYLivhm
 +BDTJgiscSGJvsz+f5g/vF9C5B4iYP/JCGmlymU25SOhmWBUbbBWU6Bxtfs+yhftXwpM6U4ybKl
 CSDwILaPuD8cSDTeDwmiKTf6b+uwTfnL4idSNpqIcOcmVcoG2v3J2BIKYB37qqwbI0Yt9u8WeQR
 //xhgoWA3fE/A0l7iOSPWtmtCQkfamQs9CukyMACemn1WTXNZ9DI0ihC9YopV8aig==
X-Google-Smtp-Source: AGHT+IGNGavK/uPJuyqA0ePAazUm/85Zy+h/qTZitvu+chiaoap9ZNBQWdRBCBT5rvjRvAMcGPPJMA==
X-Received: by 2002:a05:600c:1c93:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-434d09d092fmr31617385e9.16.1733240400020; 
 Tue, 03 Dec 2024 07:40:00 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e5b9csm225279815e9.43.2024.12.03.07.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:39:59 -0800 (PST)
Message-ID: <86548da4-836f-4408-a377-b805b696a0e8@linaro.org>
Date: Tue, 3 Dec 2024 16:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2] ui/cocoa: Temporarily ignore annoying deprecated
 declaration warnings
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20241121131954.98949-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121131954.98949-1-philmd@linaro.org>
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

On 21/11/24 14:19, Philippe Mathieu-Daudé wrote:
> These warnings are breaking some build configurations since 2 months
> now (https://gitlab.com/qemu-project/qemu/-/issues/2575):
> 
>    ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
>      662 |         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
>          |              ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:89:20: note: 'CVDisplayLinkCreateWithCGDisplay' has been explicitly marked deprecated here
>       89 | CV_EXPORT CVReturn CVDisplayLinkCreateWithCGDisplay(
>          |                    ^
>    ui/cocoa.m:663:29: error: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
>      663 |             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
>          |                             ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:182:18: note: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' has been explicitly marked deprecated here
>      182 | CV_EXPORT CVTime CVDisplayLinkGetNominalOutputVideoRefreshPeriod( CVDisplayLinkRef CV_NONNULL displayLink );
>          |                  ^
>    ui/cocoa.m:664:13: error: 'CVDisplayLinkRelease' is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declarations]
>      664 |             CVDisplayLinkRelease(displayLink);
>          |             ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreVideo.framework/Headers/CVDisplayLink.h:249:16: note: 'CVDisplayLinkRelease' has been explicitly marked deprecated here
>      249 | CV_EXPORT void CVDisplayLinkRelease( CV_RELEASES_ARGUMENT CVDisplayLinkRef CV_NULLABLE displayLink );
>          |                ^
>    3 errors generated.
> 
> For the next release, ignore the warnings using #pragma directives.
> At least until we figure the correct new API usage.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   ui/cocoa.m | 5 +++++
>   1 file changed, 5 insertions(+)

Patch queued.

