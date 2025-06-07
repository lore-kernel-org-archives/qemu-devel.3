Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE5C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 04:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNlH8-0004fT-B5; Sat, 07 Jun 2025 00:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNlH6-0004fD-OF
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 00:35:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNlH5-0006cY-32
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 00:35:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so35419265ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749270917; x=1749875717;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQRvQiX8TrS8DipYcv2Tx/OVkhxa/4qgFndTB+Kfv8w=;
 b=0txJLJVr2A9R2knsJKi2SUHgZyUUPilmTRLqpfLJxfB9jul9mp/Wm/oVq+An3res7g
 qTM8j5rFkGcVAkaGVFEpq80ZkeZtd8Hk53e0l5uiYL4T252guXVpDHQJS5j2JF9/NZ+8
 UFL633GSKGPkYx8ZVkijboyp8H9bJ8jxFnDU+8gQpsEiWiRKyf1k1KDcY/4NVHDZZOSs
 ZXRcXl9bvGH6j7WUIvT7v7tGrvGDXUyyiffyjZCm5P1xGdTNBAMizSE9elHcvRQ+wdKl
 GsrfmXIGHGQD9s6GOfXwO7DoiW0/LmsMrSHjPr2xzJsJpLydlwwg7mYwTcW2PRowosEn
 EOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749270917; x=1749875717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQRvQiX8TrS8DipYcv2Tx/OVkhxa/4qgFndTB+Kfv8w=;
 b=GKYvEux4goeyu1XjjfbzlJF7QlJIYJwhuTHG2J6oswfrvYXrWAp1qXrbWXaAMVmp5q
 ySTEU1b5knyjx8ETHYw4XtxEAStmQEmwionFFgmFjGLzH/09/jp/Em7aw+50hT/sHbX1
 oXxbpCtceuyvdFKfTMHrrTlPTyWiPETv6FRm94SV9Ag8Bu0oItrCArUqkqGaomxXSMLG
 K0Ic4m/hYIV3eZm9Qwhr6cLxGofbVK3quB2SMo4h7fd+BpZwb0Z6Wj0/c/rXuHTygs7P
 MTu/RLSh2NLVLn04g++86YPbLQOqNDWy/m1wkzpaRofKnnRwd3o6xlJLXVtbE4ZSVPgw
 mj0Q==
X-Gm-Message-State: AOJu0YwM7XaQ7SflEOu+GgeujdBlmcVvGkRlA4+SzB6d0we8j69+e+Ur
 4At5nwRoeihzBhoQJXi+81l9JY0rEHNeqka7od6UjrwUemEvX7TdVB564ufNRPG611U=
X-Gm-Gg: ASbGncu7G2Dy+n+RYbE7UwgwPZ+uGVltq0zwur38NOVoKr8QzK7RGvkOpEYOP8Dl2Et
 xd7qu1HXGcf7DqAompVw366TGk5GFclmbB0t7NqQxPzgT8euK9MLAI2R7PZFnKZWOi2Q09xpEg9
 LUwqhlOJmqSJUULgC4PkUNvEa8o4LNzEMbQ9c1nGmoql8wma2WDbdKG0WMWZOSSgqCqsm//Qflb
 yzpfosDg02FwGsI3rCZfd2pkQZA8vwFQD7u6i8edZa8krIi+2QdN13icN8f90hf5FHeKDkdFXt6
 ioooy5ousXYKkU/tgLFc+ccRaMozKB2qSpb+yGdij9l7av1CjSedpu9vG0zusA==
X-Google-Smtp-Source: AGHT+IHIegA+Fo9I9tZuVG/f6HPYeQ+uhs1GnqsmiBYw7+EvjdYOZlSVlruvJM6GJtfqbyJ78tJrOA==
X-Received: by 2002:a17:902:f54f:b0:234:8ec1:4ad3 with SMTP id
 d9443c01a7336-23601d71b8bmr90263145ad.40.1749270917388; 
 Fri, 06 Jun 2025 21:35:17 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236034050a1sm20346585ad.145.2025.06.06.21.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 21:35:17 -0700 (PDT)
Message-ID: <51fc5e6d-1d46-48cf-8846-279e576e43dd@daynix.com>
Date: Sat, 7 Jun 2025 13:35:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] Improve futex usage
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@daynix.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250605132427.404551-1-pbonzini@redhat.com>
 <b41eb6f4-96b8-47bf-90cf-e4918a613dcf@daynix.com>
 <CABgObfYZ2mH5ogfjPG3Xmp7jpay7CPHh7L=phSTXzT344VWhgA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfYZ2mH5ogfjPG3Xmp7jpay7CPHh7L=phSTXzT344VWhgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/07 5:38, Paolo Bonzini wrote:
> On Fri, Jun 6, 2025 at 11:46 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> This conditional is unnecessary; docs/about/build-platforms.rst says we
>> only supports MinGW.
>>
>> I failed to catch this problem because I ran MinGW on Windows, which is
>> case-insensitive. Since it is case-insensitive, the lowercase name will
>> work for the OS too.
> 
> Possibly, but better safe than sorry... The official name is the uppercase one.

There are already two libraries that are referenced with lowercase names 
while they have uppercase characters in Windows SDK:

MinGW  | Windows SDK
-------+------------
ws2_32 | WS2_32
winmm  | WinMM

So there is no gain by trying out the name of the synchronization 
library in Windows SDK; the build will break anyway if a build platform 
requires case-sensitive matches with Windows SDK names.

I also think it's better to keep the library references consistent; 
there is no reason to check the case-preserved name of a library while 
not checking the one for another and vice versa. In this sense, we 
should consistently check the case-preserved names or consistently avoid 
checking them.

Regards,
Akihiko Odaki

