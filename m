Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B86D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ryq-0003hX-An; Wed, 01 Apr 2026 05:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ryo-0003h5-6X
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:35:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ryl-0006zo-Jy
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:35:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso1906468f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036112; x=1775640912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyyKHMKgNHrh6480le+LswMVxRzoaQcD5ikJX5DMnjY=;
 b=r9mqMUc8NUf7aZWLEY7uPMI0MJxiHas84C21VowISIej00kdDOyCa+BrihBeo63+Ep
 NGoK8rPYhhIO8Pbouy7qoPAQqkhrqXO/UKWy4h0ImI1wFq8ZgszMejH7v+5UVsMPksyx
 l7EI8bhsISSEs1NtMWBFWSXqPd7OZmpU0askKBU1aCshQoLmrgq1AdYScH/ijg/x7Twk
 jJ/p5fEq1LKFUchjw156Y6/9E98CZ/AadMgbqQw8tKIrLq76Aj6HQATGp/MuC+nuowLW
 +Zw40SVcFu+G+3JK6WlDjeugGm3JItHp6x15WjMbtT0EIPAIJFtRrCxUV5PooCyrdn7T
 fWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036112; x=1775640912;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyyKHMKgNHrh6480le+LswMVxRzoaQcD5ikJX5DMnjY=;
 b=tKiso5JC6eELTFOPwwwRcxcQvSOKsUw4oJeWCdSe+P8J5w9f+YmcGquNe+MHwi+YoJ
 1p5g1shdqh33iNt9k/1qQIHXtzfT7R0WOlwNsI9GvUVvO7BaCjCqCcyAYRYXJFSNu0g6
 Mbrqe/nhir7WCE0dIqz4hgDq1EEAMyiLYWhCmBAaHHmzh2zfNMYIfWJW3Eyrj/B+JH86
 R88BvSyu2irra4rRBpEZceJFSVfQbjytebAG1sTHLYEu31A5Qw7Ln/qDB9tn+n4+jnV1
 9A9MRb1Y8f/fCXON7KLOv7NO3RKNoc7aql5MKESlUaj2j+MZdpy4WWm8iOc4xLiW8LTu
 9FOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPc9JixZ9cm6uXVYfoDa9eamKEtTWybAVihw3TLd270MBNNJ4MAqG+eH/zLAXDyVKbehENz4EcmIcl@nongnu.org
X-Gm-Message-State: AOJu0YwXWnwG6omTq4VdUU67X4EkVEeWGQVeBOYLkEhWhZVJNYQ9Foo7
 Db2YE5BJKI1cVLvoEutjolaQNrYp4D4ZyQsMWviXREAhQ08x7QhNleAKgC8tETvMcUg=
X-Gm-Gg: ATEYQzze3G/fm91JtY3PCfLbHaxf8cYKUReTVOW8aHHRM6eWe4aoTSRQPwRZ1bWj0+y
 jFYu1YalJ/jA0NKdNSMtpzNmt52vQJFe84vGmILjlV2anzQfA+pJcQML4/DuDzr1vgCfqZ3aAxe
 0rpsAbi/fdZWMrdiSRV50V0ymzoyPUgLpANh3Dfn8wvLe6uvvZOjXNU1LD1brWMZF4QifwVrP4b
 eHRG3B+ScwSuer5yhzyOdm3svW3JiZq25QB17HQ0cZaC5P0X5AVtWs4t4vV8yNNi7zZ7CmT7aCz
 N+vok71+Fm1T3dwVwAeIZcwxZ/EHVcxn6IG6m5/wQejRCrVw7N574ZEn+vbevIKLK7fyGfa2g1f
 +NAVUkQDMg30VnhFH262TQSsot3Q6ME0VAqcyCDe8laZ5tWw9Po4Q30ezbT1jejBribp/iBQ68c
 wTcTTUvnzQgZef/ZW10bJXTMXM12wReWtTbFvh1zogBuBzxfo77+5u/lcA39VZQbcrJA==
X-Received: by 2002:a5d:5f53:0:b0:43b:3d54:3154 with SMTP id
 ffacd0b85a97d-43d150452a1mr5284761f8f.7.1775036111863; 
 Wed, 01 Apr 2026 02:35:11 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf247102dsm39853990f8f.27.2026.04.01.02.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:35:11 -0700 (PDT)
Message-ID: <8a9bc774-a3a3-442a-9faf-02ec000e242b@linaro.org>
Date: Wed, 1 Apr 2026 11:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/60] ui/vnc: explicitly link with png
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-49-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-49-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/3/26 09:51, Marc-André Lureau wrote:
> The VNC code uses PNG directly.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

