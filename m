Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4768CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refaM-0001f8-F8; Mon, 26 Feb 2024 13:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refaE-0001bU-EW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:20:11 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refa7-00060F-RR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:20:08 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so5979867a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708971600; x=1709576400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Vy8XrCUGCZFXrVdlkgzA75I+qAilXgipfSOtnC2c1k=;
 b=sO+PfuZPlF6MtcCvSE+llU3bs8Oby2KU1ffjhDvpwYHTRK0vaG7K2kO5Ogha0o+Z35
 McjPgmRXxjfyrSVl8MMLr8Y0SSD/odVYZAwPofNOHmUvnTkBOpP3iYszxO0mi1omQZcJ
 EDwm69Xre70Fm0T6Pfars3XQyDkGEY1C+TeUgDDvkJxGTxyUZRmaGZWi4vc719pXXUOn
 +g/g/Xl1N4LgYgty2s8orcZfIx9+RgNim1Xd5K+2JkIcYG610BwsgGIxSNLzy/9WEMzQ
 +JGBH62h0jPmwfnTs+2ZMgNM1PxR9HN8fM+KC6pAoR3DuSRuW4OpbUT0QgRjYSgpf9ZD
 KPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708971600; x=1709576400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Vy8XrCUGCZFXrVdlkgzA75I+qAilXgipfSOtnC2c1k=;
 b=lg15gsMv+PJwcgfFGOMS3aJSjCVx6wp8sTUy0FbwbhFIcMZ8Vng+e7M01bUWv3vSz1
 aF4seYY6LzVRbp0Grc+wbRtk268RJ4r5Xx/FRGN2Q3zK8+N+TeEOpn4z/jCWmMnCSKKG
 zbV0U6CwmcaR92BPfSWhD54BVlckl2WF8kgPTdS/2H0+iLTb46mazF+Kxsx5TbWxJlMo
 KBK2GMRiJp6Rqg4GTuH8tQ00xkoUbqQ4WJqF/nW9BVUZr5xVNLeWF4xnqeX6BDyvW+Gu
 MLgz/4gwzXDjy8PvGt9ERZjkYzig19lWlajNNtgF17UL11+CbZFvxjqZdNOZXlNcVYch
 Z5QA==
X-Gm-Message-State: AOJu0YyT8BB6e6sX0XfjFRV9c4MAO/HDyGb3bOKBx2Roz8gSlswkvvax
 cJRzH4hcHqtY+dIuBQ3zjRRc5Rj3X3MCokEw1wRKagvIcM4adZoU5CVzkrb9K5E=
X-Google-Smtp-Source: AGHT+IFjn9p/q/pjPsPZnozDY0kXdnCJddnhDbcj/OuQyviKgSgdUu2FYpY04UD01V/mcrHA1l4D0g==
X-Received: by 2002:aa7:c318:0:b0:565:211b:32ea with SMTP id
 l24-20020aa7c318000000b00565211b32eamr7026359edq.19.1708971600238; 
 Mon, 26 Feb 2024 10:20:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a50c942000000b005657eefa8e9sm728edh.4.2024.02.26.10.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 10:19:59 -0800 (PST)
Message-ID: <35055891-c514-493b-980a-993dfc3b6a14@linaro.org>
Date: Mon, 26 Feb 2024 19:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/10] ui/cocoa: Use NSWindow's ability to resize
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/2/24 13:43, Akihiko Odaki wrote:

> Akihiko Odaki (10):
>        ui/cocoa: Split [-QemuCocoaView handleEventLocked:]
>        ui/cocoa: Immediately call [-QemuCocoaView handleMouseEvent:buttons:]
>        ui/cocoa: Release specific mouse buttons
>        ui/cocoa: Scale with NSView instead of Core Graphics
>        ui/cocoa: Fix pause label coordinates
>        ui/cocoa: Let the platform toggle fullscreen
>        ui/cocoa: Remove normalWindow
>        ui/cocoa: Make window resizable
>        ui/cocoa: Call console_select() with the BQL
>        ui/cocoa: Remove stretch_video flag

Series queued, thanks for all the people involved over
the various iterations!

