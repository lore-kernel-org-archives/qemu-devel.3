Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162EAC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTjT-0004Mo-Io; Fri, 23 Feb 2024 06:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdTjR-0004M7-BU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:28:45 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdTjO-0005nY-Pj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:28:44 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e2e6bcc115so105497a34.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708687721; x=1709292521;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ls5vQacCF0G8Uvo1mVdX+EMSTYrFJ3Uk+K0MXDyqp+A=;
 b=XS0AfrVmdB37Nl32HMHOyYZxGC3Yk9H1rctrtL31PHgPF9NrrKPgLJhlOifLwAbIM8
 QDw/38JLhwqtL9WlPiILLgfYj5Gpaw9XMrIg6GPc6IeqKnuO9mn/NyCF9Ki0TVGsPl7D
 zfKdXlKYUjVnWrKDNYXWbj6RocF4Rp/reSTLYhWTzVheQopiB01v8pjxAsdX02zeA4Mc
 ioc9x4nKe0JN3lLD8P2Gs2aUs+4hl/LDL4lQEG0SuXMcldCqhPVsje7kY8Ohk5hMyBsp
 tNLh50QVyJCC5YUYCf19YUQ+iBoTUHqBKIDdy/rDOx6YjcC4eUX1shUeD+ZOBn30kY0Z
 PMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708687721; x=1709292521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ls5vQacCF0G8Uvo1mVdX+EMSTYrFJ3Uk+K0MXDyqp+A=;
 b=IWy7ivTlBZAo5GArw/XX/9oLcpsQrqepm1OAIyOVPfbT47SYVWXVrToXBDP0cKBCBP
 47SIZo9IC0woXdxwHd8sNkfJbt9BVHhXOZoxUUGKD1ynYfHhV3PuOgUI9qv/uQ9poeXh
 L7g0BIhSMG7stRnzNe17Wn27WKbEIvTrc5b1fnsGaKKoExJclgFHeQEblX0t7rbI3yDl
 +n6kcxSf6svvPXqCn1zVXVGLnRkJYo+vUngPYw4hNj1Z2Zo/P+Zcok7Itgmi7pOdLCSX
 nV6vXh7h6xyotu2iqknqrmqB9QioLcD+HW4IUcpf9rR/TfcVERfIYXkau2YOUFjBPjxM
 495A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSpN6XY8tMIt9utGLsIe80eMgdh6ZdHlp59Hj8RBOexZetVYY0zS+XUKCUxa6XG9Aye10Rs8NQ9jQ2Qlu2YJcscki16E=
X-Gm-Message-State: AOJu0YyAG/jYUsvpfXMDwQY3GQSz5cWC/foM6QSyvPwdYCS/fbhkDZAf
 icwZCAt5DQ+TacLHJGe18yIZ6lkhgv9zymKe///Y5Ec++/acSekdhBXM0qzrCQA=
X-Google-Smtp-Source: AGHT+IH5h4EhmIwUNTTDJmOkd+68/PrMRGnnM98pDgADQb6bLMia5IVZkq7+pjsqzoYJu8/E1P2sEA==
X-Received: by 2002:a05:6359:5096:b0:17b:6e2c:524a with SMTP id
 on22-20020a056359509600b0017b6e2c524amr1557032rwb.27.1708687720896; 
 Fri, 23 Feb 2024 03:28:40 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a17090276c600b001db693d89fdsm11419880plt.179.2024.02.23.03.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 03:28:40 -0800 (PST)
Message-ID: <c018e266-0092-4d9e-ba2f-397cb0a1518e@daynix.com>
Date: Fri, 23 Feb 2024 20:28:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cocoa: Fix incorrect window clipping on macOS Sonoma
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: David Parsons <dave@daveparsons.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <DDADA9A9-DED4-4510-A532-7600C0233467@daveparsons.net>
 <fdda385d-2e18-4554-88d0-e43cb5b90e39@tls.msk.ru>
 <CAFEAcA9psJuvPz+mWYzWz0NLTcQTCNhknFrGZ2bx7Frtb3=B4A@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9psJuvPz+mWYzWz0NLTcQTCNhknFrGZ2bx7Frtb3=B4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/23 2:10, Peter Maydell wrote:
> On Thu, 22 Feb 2024 at 06:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> [Adding a few more Ccs]
>>
>> 17.02.2024 18:58, David Parsons :
>>> macOS Sonoma changes the NSView.clipsToBounds to false by default where it was true in
>>> earlier version of macOS. This causes the window contents to be obscured by the window
>>> frame. This fixes the issue by conditionally setting the clipping on Sonoma to true.

Thanks for posting a patch for this critical problem.

>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
>>> Signed-off-by: David Parsons <dave@daveparsons.net>
>>>
>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>> index eb99064bee..c9e3b96004 100644
>>> --- a/ui/cocoa.m
>>> +++ b/ui/cocoa.m
>>> @@ -365,6 +365,9 @@ - (id)initWithFrame:(NSRect)frameRect
>>>            screen.width = frameRect.size.width;
>>>            screen.height = frameRect.size.height;
>>>            kbd = qkbd_state_init(dcl.con);
>>> +        if (@available(macOS 14, *)) {
>>> +            [self setClipsToBounds:YES];
>>> +        }
>>>
>>>        }
>>>        return self;
>>>
>>
>> Hi David!
>>
>> While the code change is tiny, I for one know nothing about MacOS and
>> its cocoa thing, so to me (with my trivial-patches hat on) this is a
>> no-go.  I'd love to have a review from someone more knowlegeable in
>> this area.
> 
> Mmm. Akihiko is the expert here, but I do notice that we don't
> seem to be handling the "macos-version-specific" stuff in a
> way we've done it before (we don't use @available elsewhere).
> 
> I did wonder if we could call the setClipsToBounds method unconditionally;
> The release notes say
> https://developer.apple.com/documentation/macos-release-notes/appkit-release-notes-for-macos-14#NSView
> "This property is available back to macOS 10.9. This availability is
> intended to allow code targeting older OSes to set this property to
> true without guarding the setter in an availability check."
> 
> but I think that might only mean "you can do this building on a new
> SDK that's targeting an old version", not "you can do this
> when building on an older SDK" (at least judging from the
> comments in the gitlab issue).

Apparently it is that case.

Please check if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
instead of using @available. See commit 5e24600a7c1c ("ui/cocoa.m: Fix 
macOS 10.14 deprecation warnings") for example.

> 
> The other option would be to fix whatever it is that we're
> presumably not getting right that means this default change
> caused the bug. My guess is that we are in the case
> "Confusing a view’s bounds and its dirty rect. The dirty rect
>   passed to .drawRect() should be used to determine what to draw,
>   not where to draw it. Use NSView.bounds when determining the
>   layout of what your view draws."
> But unless the fix for that is really obvious and easy I guess
> that flipping the default back to its old value is the better
> approach.

It is a chore to convert the coordinates using NSView.bounds. Let's keep 
using clipsToBounds.

> 
> -- PMM



