Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2ECCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB92m-0007JO-C6; Tue, 21 Oct 2025 05:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB92i-0007J7-Lp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:52:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB92g-0002Hj-OL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:52:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so2578429f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040352; x=1761645152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=usf1vV8lWoqEiAKo6nfwZTXRIkr4Vh/CzcHP0nf3mb4=;
 b=oVFET1o0YBA6RyM8K/n5U5/JRCbMzF0UBDnb3U6bLe6WMYeK4v/lfI7oMqISQZYfA0
 0b3U8kWiUKU8fY93wCeL5t0ib96qvRaGZbKD0xFKDRxszGASkM3GXubZm1FRJQfElIuW
 g4Nz8D9eL/qEAwXNcCADddoIKuGnU5KcNSyxrfeun3zELkqdU9ktPQ7VYojf9v0cyguv
 gnZ6XFHJF8E/LFcIpaXtlJYpzRk//MEXXWo1tPGP95x6rHffUBRqjtOLL652uzxSz1H/
 KTfLmoSCYtBmRKf6T18mY9pzRQDLHv2FW2D0+8LL7XNqcIGuPuxIvoWQgkqnquOBdKK4
 Fy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040352; x=1761645152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=usf1vV8lWoqEiAKo6nfwZTXRIkr4Vh/CzcHP0nf3mb4=;
 b=B99ENcKswWAA6UP8XS6lGRZvJG+w0+M9Pd38LJ/RPBGMxWoVhx6VSVJOmNDeyUlcKc
 L4FCnhJ2+nbnjj5MRMbiyjbKJiq14P6boe6JyDjAhVsU6rCdUQjDtOTeQcKW+uDZV8Ch
 yzJvtMYgPQsyBVgMFLO4vGKLY8WqC5aRklBSs4C7wsuKjuUDG0dx5Oiqrjp1Pl+vCd6C
 atBaE8CznCXUfzHBnzm3xLFkfdXLRhXScZ9N/atjFf7l6UQnq5mWHcos/oa0YMALyK+g
 wBfz2zFGRef8mNBdUC+/K3wUFb0iXv70Y8dye8A7KQ95iu5WxxiRuLOTblx2Di9xsr+Q
 +MPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeRQi8JtqjeromOmvzqaDDwwYV7E/HfYBIDNrnHXaz2FhZ6F5dX4OTTuh737xWq16i/vXYBny7f6LG@nongnu.org
X-Gm-Message-State: AOJu0Yzm6mPNryQ2vHV7dFa8dO19EpSD855GQ0ED9VIp9F3PEaK2kBlc
 DH6PtNGn3TyM/lOgBZW7IcrzBmKGz8v3kKoHJlKtNLWBbnLMKbIzrOoBCWXA77/xUFizNNzUJkZ
 R8O8jn90=
X-Gm-Gg: ASbGnct33QuVDNIJHnya82LLDCLYrOa3FmU9ozl6I+9RyrjU8T822/c/mv62iJa4Vvg
 MdVecjYrLo/QH2hR70VbPTf1W+mocowK36avm6XsccKzLFZHc9qR0t3HJBoGawJ29a//sE/JzIw
 uZmr7JJeBXsAstL7szdKjoHZSaodoWxUIB+wMYlT/Nd1ZpWRSldPblcID4vs2//ndqkpceAomgE
 WckkF/mKAV3ooSFtB6TwffZp2wrLkcJcAuglf9L2BTiwRJXz+y8s81kUd21Bf4YH8q883TfMkVc
 h61QW74JGPET3qpAQhblhmj/NdCBnn8WiKfIrejaJlDYmbnmhrfzRnMCEaPD5LgQ4n7cbjqnBNh
 eDth4nqEqeJ2IVoY9Mzbt5eYV1mXwOHp5ZwRokfmSdFjWWGk0/kmUQPcM20gvtnWvRe7USGrSTH
 +JVrKfBacEhp6sFRkfhWb4zvEVVN5mdofms0pngha50EFm7Ha6qpP2EA==
X-Google-Smtp-Source: AGHT+IEw7HQS1nfEmb3+PebSGiUAWUTG3JmpIg7/tCawi4qx1sLh2oQ9EeSuC7qBbwc6wX4aRyPCcw==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id
 5b1f17b1804b1-4711791fa34mr115959105e9.40.1761040352495; 
 Tue, 21 Oct 2025 02:52:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496bf7137sm13381405e9.3.2025.10.21.02.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:52:32 -0700 (PDT)
Message-ID: <a84f731f-16b7-4e74-8024-778c15f7a78c@linaro.org>
Date: Tue, 21 Oct 2025 11:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/43] audio: rename audio_define->audio_add_audiodev()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-11-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For readability.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h | 4 ++--
>   audio/audio.c | 8 ++++----
>   system/vl.c   | 6 +++---
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


