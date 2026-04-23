Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415AEF589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuW2-0004w0-Us; Thu, 23 Apr 2026 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuW0-0004uN-Ky
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:54:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuVz-00009g-5b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:54:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso61801265e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952485; x=1777557285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BO+9cN27AniM3x3/RtRo0CH+M0lv62CnQCN4/uXHCCo=;
 b=UskntsMFKkTTRmIymzvjcvYsbyDwH8EngnKpoRc5wBi4Un89wTz8qMgJnh/+gC0ff0
 nmUdn2899y3m4Zlt6TUmul13FY9NWJWuFSK2PnTuYUxtV+d9N81vI4ACANsmCYyrYL+Y
 S6wOE67lMf4vVqbLL1ebSn1CW3mg9eF8CCrY8lpZLOzDrZSEpf2yW5tee617acCTGrvC
 HjenTXfMzTXqBcQqbmGPuDE6pSDf3WGuhLgbKe0Xi/DOM9RaJGSKyGIuGZuagFWgEiqQ
 vwvKCCHq4o4zChd+3ChXP73F57ys89kOgCd8QWPLmWJEB7XUbTEB8mknLmo+DWNOdFR9
 fsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952485; x=1777557285;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BO+9cN27AniM3x3/RtRo0CH+M0lv62CnQCN4/uXHCCo=;
 b=TamMfHuzQ51kT+oxtadxwkfA9Iw7Igpq/uIAUS36PNIxGWsXmTjS89VD7tt1vnFha+
 g0/u/13H9tAndFQYKVpsNucSym7hsVYnL4tR2n+aKmn3nGTYv4EOUbC73LEWr8chOuHz
 9O+kbPyPrep74uxTmgLzuAUHbAT14TB/GBAn+DhYtnANZZEmTdchMuCyTZJeq8wareQs
 SBJYMq6yQFhYdP5f6eDLxHKZfdas3eZkg21+Aq2j/NvNr7yq5glfJEVRAkP5UBvBQnMX
 l6L0G2MIfZtq8NCFAzoPp+URN9r8aiAhKBRSGH47W+Fc3jDRdvUd3BxeQPfj1zfh2gpK
 bEyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oMWtcK1lF/IkSXKjmbb/+CgOhzrCi0iyteVy341TQuFfMQW2wFV2eMwSp0DiYvu1QZxZZ5/+Vos0y@nongnu.org
X-Gm-Message-State: AOJu0Yywze8m5cxW1gQApHqJEjuqKOy5mB/uxQ6C1SVRyYiboXs2LHid
 4/TAfva7bDRn1DioUckQ1EV4o7ugBGwBQbNg+NoH19OmVNLctLKVL58KKw7MNbX2GWcuCR7Qbea
 IVS71r7Y=
X-Gm-Gg: AeBDiesGE7SmwpqDvzQ37wKG9xZQ0tSkiceMDw0QCeFqF8zCLftFGq0t2c81RITsZ63
 Z7BzzxCq7fG8xqFdnIOYbbhcyMJ3XiHVRAL5jj6pDNVZt5MN0vTszHnabIsjjsNV6/CJdR1QPJz
 4qJklClHXmGUU1IwlOHpUYxQZ27UcmP9nPIb4I9S6Hi4ML1dBOgeRR+HGnsL/dO0DOMD4rQZQOP
 7K/U2Mstt+n7rWgPR6Zq0fEN1znRuPNwlnPUmxsICopAxEX9fljodvMIL9PSFHiw8denurLSwPJ
 vZjuz54zn1bihU0/yGQQKh2kSvfrbEkirD9EPQa5dH4v3Pibr6UFZ+PYeXaHf1UZ0g6XC3/Y9Im
 VlEEGwlaolK8Ywcx93TtTi2wA6jKO/LRyoaf+rqYP+p63OZI+yAgViHhoFIEmk0B2V2ZWqSLTcR
 XLKSXeYNnXlqQTYwtWhacgkkPL+DqHPntW7JLks6JqH/PNLBBuXPU3D2/z5/Gji+hAKLNRwC+bN
 jTl
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-489e69686a7mr229885855e9.10.1776952485486; 
 Thu, 23 Apr 2026 06:54:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c7a2sm164067445e9.1.2026.04.23.06.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 06:54:43 -0700 (PDT)
Message-ID: <1b685d72-1bc9-40cd-9f7a-df8ffac39bf2@linaro.org>
Date: Thu, 23 Apr 2026 15:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/dbus: fix warning for clients without "Interfaces"
 property
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260423132329.932887-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423132329.932887-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/4/26 15:23, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The "Interfaces" property is not strictly required. We can just assume
> the peer doesn't implement the given interface. Fix warning:
> GLib: g_strv_contains: assertion 'strv != NULL' failed
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

