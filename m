Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F236E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBBI-00055l-C6; Fri, 13 Dec 2024 14:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9H-0001oD-Rk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:28 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9G-00085c-2x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1145456f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117384; x=1734722184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GwXJ20o47O0myZ807tC+6WLVB8CtFiG35efK/BxIlqk=;
 b=EBBeUOlgWGoDM3J+0mG5QVCofEG1Jq1Pbp+JPiLesuKjAUWHO/+z7R3GbyjyJdOIX+
 Kifa2plsh9LL8NPIO3+zBNCZxMqOhxOZvDVSTaeeZiRpn+X09JZv2Yj7fQwwtJmk5+ae
 ZsdBTavKKhnaOXm1xF830S5i5bMx0w0bVZ+q2dI2fOrLIpDx8XeO9doMWfm1I/c+YmwD
 eOyPl9quKm3wY+97WIuR2Fyo4HiZ22RjpQ3xW/F+cesYdk9XHUZLb7qXZe1eCEwixHz2
 7nQYZoeTf+uC5YhyRWjSR1YSDOQ8vUI7Im2vr/LcQHDNwTIHmN2mP5ecykUgiMEKNId8
 yqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117384; x=1734722184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwXJ20o47O0myZ807tC+6WLVB8CtFiG35efK/BxIlqk=;
 b=lbu/ioWGhJ2D5YVum04yakvM/dma9IIivqSCUDmk8KHpY7lg9WwTldeRJBbB8/5dyD
 GHOasK8AdWwdNig+dTTOSgVOYEwnaYxWvNNw2EsSSJteLL8FWSC30HhEfoznrUfkSrjI
 dw1udD/QRhpEk2VuJ3YfQFYvPZhnwqWDmgJj8PYXDPt/+esCvMBLugTmXLLEok4bYNLl
 biKhxaU2mXhkbauiLoqnM1hCxkL5Im0eHCDrBxW1auc4xvKpctbtWozJoYeeCDmmiBun
 8o9a+hbAaofYJbv0rwdpzfBAPxGFuibeB6PjFnHBs/4NJiohIgbJ9LECtDMTripBBKj0
 WjKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpY+3q9z9RzdI21ybgc8utulJdBd1hL42c4Q1Pd2VWQntmnQARvITz0g5or0YsEsQTKyFzwvVeZmdn@nongnu.org
X-Gm-Message-State: AOJu0Yy565VDOrfF5JGALkJ/9vu75QgRhr/i1vGMrA1R8qkkPzvuObp3
 dxbMLr7hNvrj1RnNjVPdgfVAjduqOJodVtYOjwukLW9qIRDEr4bcXG2I4nlD1nM=
X-Gm-Gg: ASbGncsr8AZJoNsWwhHWFam9idfGG61PJuwhg+pYzlkSJfvOWJKCVtwpyNkrgeKdaRk
 cHIKEDtoC0nk2Dn7dpQ+Rd9/oYSrKd7g6NqEYXuSj7qgwLHEt8n53rubyJZXj6r19NBVNlQ/Czg
 7WMPVDS+dNqVNrLl+r0dWBKQvyHFTLJnEVWH/P2ekqPMm8kcYFUArJq7vrz7j5dDwLad0hWSl2k
 tv3mtbvM5yClQJv8D1zjextwoPKfD9ags+G/ZE+7A2JwsYKo/xod678k6rU7z3YIG2fFMPwYxYi
 JWxOCz0nr9sgNQEstxDK
X-Google-Smtp-Source: AGHT+IE9EaE9q+eOTRyVS+Ej/dZUuzr5P76BaFSUIVzLalx3/4oNdOLXQxFZM43dPSy1rgme1yYiGw==
X-Received: by 2002:a5d:47c5:0:b0:385:fb66:faee with SMTP id
 ffacd0b85a97d-38880ad0de1mr2688391f8f.18.1734117384499; 
 Fri, 13 Dec 2024 11:16:24 -0800 (PST)
Received: from [192.168.224.213] (127.47.205.77.rev.sfr.net. [77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046ca6sm297070f8f.83.2024.12.13.11.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:16:23 -0800 (PST)
Message-ID: <8011248c-8ed7-46ef-9d8d-78ae05dfc0b4@linaro.org>
Date: Fri, 13 Dec 2024 20:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: graf@amazon.com, pbonzini@redhat.com, berrange@redhat.com
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241109123039.24180-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 9/11/24 13:30, Dorjoy Chowdhury wrote:
> We were storing the pointers to buffers in a GList due to lack of
> stateful crypto apis and instead doing the final hash computation at
> the end after we had all the necessary buffers. Now that we have the
> stateful qcrypto apis available, we can instead update the hashes
> inline in the read_eif_* functions which makes the code much simpler.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>   hw/core/eif.c                   | 202 ++++++++++++--------------------
>   hw/i386/nitro_enclave.c         |  12 +-
>   include/hw/i386/nitro_enclave.h |  16 +--
>   3 files changed, 91 insertions(+), 139 deletions(-)

Queued, thanks!

