Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A78D3515E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rkO-0005u6-0G; Wed, 01 Apr 2026 05:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rkM-0005s4-Q5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:20:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rkL-0004sQ-2p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:20:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486507134e4so75090605e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035219; x=1775640019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=86zDf/B/bgXIdc+igYlw2nt4fGok3IM1Jc+gd4JURZU=;
 b=v213mzlKScrzcxkIMZcWDgE707FXdaaYGhnZ+TO3Q15gei+38s9rnGx+8FbAtrRpoD
 Q49Pps9mpOBakow3JSmhZzGp++GcrY+350yz4EWMDYQvBvA/UgsNXcfpO5olj6OrwAdZ
 xzLfUM+6V/P41LXnyPMd5hYUzxrVH44tt1tvYGmhUX6OZpvmoNYmO4pCW0VR/lipOvLQ
 zFRdwK0s5yFEfXb4lAt4XssqUn2SUWI7s0EkVOs3zYXZiolSmjP5qNTsLVzYtuCw19Wo
 jHheErCObax7Uvfm7cSS5ANxG5khtA5P2dXzSZNxCODNZvLIAR6VOqw1pQmCGu08zvbT
 992w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035219; x=1775640019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=86zDf/B/bgXIdc+igYlw2nt4fGok3IM1Jc+gd4JURZU=;
 b=brBpfiLvYoIkJkV24rYEhzZ1V0hOeWCsC3cLrP8ux2/ugnw6sXKnpNLbsGzbrgAogC
 GiHuHPCaDREJagvu9J2kVN8kUpIxrv6z8wozfu2thJZMkEP3X68OrpBJGcC1X5BSJm7L
 QRqXkWowt8cY78ckznCCcAjL+Aw25UfDxtj1v0ESUf1igP0vVxI9X9WPfEpQ7AKptUiD
 qbzvueuCgEdPb5/kTC+J7nCYOlAnAXQb5aT9LC9pKkXnf7Zi2Alt/oTWl4icBS4wYZT4
 fjeIfzqXKngkk7uVmjjAbb9CsWWt6FCSWEuhRZMlEmboPVdp33TlUD3YmsopUgcIgaqF
 p0+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtMVWrx4WPBcxYdSVqTfjUphcnFqUUpOHg8JTR9gaYXThekLvYz4rmd2KTbMPElKtb52AVwAKt9QG9@nongnu.org
X-Gm-Message-State: AOJu0YzmvjjiqiJNX2ayaSsZ2ZxpFU+rTHxc8/zrQVTW6MvJ+5VSA/Ef
 /JM9kjQ52V/JKQfvoPcsMVMgdL6/xIxY4PxtUJI+DGXxe3BaSqjMPZ0o62ox6cGHJwjJ/Yya0+L
 s5DsNtks=
X-Gm-Gg: ATEYQzy8Rn8MrP65jzLSUyqymDen+UFp6YmoT9hxZYcGtYdmXVQsNJQ5Dq4pDrbqFSG
 vn62IbpQoWluCnSv58X5b1AiH0q/3hcZBWEuvVvSyBOuNUp1yRi1esFq4YpxorIBJDJZCilkzVX
 ulVhKbhLeRW8nGtr7XZr8yWToHdLuPStl0b8nEjTpDynmPk5r/GKg8kDF+3+Q9s0jgrbEXm08Wz
 JibWkJbSDI9SwcEvPG5X5Ad++P3PCAZ5TGnch0z2J2dYyQoSEeYCw76gPYFZQdXqZWh3ZN575iO
 vRDPpGNz9fLpU+O+9/WAQnSoD9KjCg5cSnSD8HITjpZJziYmJRulV4T12YZZ3TLVFbEi4hhfIA5
 lQHuzTtY7k3At9L++wTpjlzx9iE/0Y5X21W/FWGXxFHN7V21BCyQ02JUe4d3bos3+Mo8ZIAbH6k
 hyZ7iqQCXB0k2j4rGd6KcxfHkb+pKWv+Rc5ob2hqR+1q3zp1IQ9fEWNEM6D9SqgpUP4A==
X-Received: by 2002:a05:600c:5298:b0:488:7ff5:2c67 with SMTP id
 5b1f17b1804b1-488835887f7mr48360335e9.12.1775035219332; 
 Wed, 01 Apr 2026 02:20:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e82e262sm103091085e9.10.2026.04.01.02.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:20:18 -0700 (PDT)
Message-ID: <c48c8f16-48c4-4dc4-8b02-3a035f03a7ae@linaro.org>
Date: Wed, 1 Apr 2026 11:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/60] ui/console-vc: refactor text_console_resize() into
 vt100_set_image()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-24-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-24-48eb1dcf7b76@redhat.com>
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Decouple the resize logic from QemuTextConsole by operating on
> QemuVT100 and taking a pixman_image_t directly, instead of reaching
> into the console's scanout surface. The callers now pass the image
> explicitly, which makes the VT100 layer independent of the console
> object hierarchy.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 40 +++++++++++++++++++---------------------
>   1 file changed, 19 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

