Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B943EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRXr9-0004ca-CM; Wed, 10 Jul 2024 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRXr5-0004ZJ-OW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:59:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRXr2-0000YH-MJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:59:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367a183df54so3848579f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720619971; x=1721224771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJ4vIdBWINpISsNnSom9WLnNU/7LffLcmCsv6uUHM7g=;
 b=BJmovzUIP+wlc3/nctsxkAavd6/yBETvtKz++1pBo5tx9suQ9xoJV3RRTpj9L2qbRj
 J4vjxg9P6WX/T19QM2PnarpSs5tryDC8N17IcjOoTW/tkoPBGcIVidVBlhZQ0Yrcmcyv
 Qlma9LAmNgVCV6RNArQKc6J/sGsGUt04O9IywLs9hyZWqrSw5O2FV7erpf+Cj9spXaPc
 JLkH4Yna5OGB0uRDxNxAwc1yQLOtmy/xsjP5CHVCi+OMlJwUcvzm2ddb1a/L5P7d5b86
 s+HvWNLXtWZ2feWUE+I8fpAY116UuoAdplm2+LSW+arZ/qxeV/F4dtjd6bElZDex1Wr9
 PLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720619971; x=1721224771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ4vIdBWINpISsNnSom9WLnNU/7LffLcmCsv6uUHM7g=;
 b=EbBxF19698IqObLx0BJplk/5ol7RJ58dlJ16Qcxp5coiONhzB3NS7yXiJBNVHP4CIz
 O7E5I681jTa6O9U518aBJvmdcCdkhHIMy8GNLAgH6e6L5Maiucfyl7iLmVDSqmCe4vUJ
 xpzWI3QVzmz/Vjf5HBetJlassAV8D33X/IQ1meeEeNidJ1fGxGP/ACs6eNpei8eMgXZi
 YhtVFb52J91VGXexoZftSXdQ1jafWKjCQfI/VTpqjcela0Op6r/p0QlVP7sy7VuuOUPF
 we4oRigNBUMk9KwRRSR0HAlly22eLA578R0AUkH+GTVx5U3RooIhmmJ5TnKf4+baZlKr
 UuTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3+wSmxJ0Px1wXsdHuddnz98w7PiZkRaN3hn4v8V32DpZvGJqUH0XLNVSqQNSulh1dUkLGnFvFEksMXGGnzYeZIUaGACc=
X-Gm-Message-State: AOJu0YwnrggRu36Vac9si2gdky010YIy27uubVZNmaO6R9NJzW4smrxw
 5tcjkQnrxt6EaB2HUJp8Yyx1zVjF37NP0m5Y5CmmvGR87BdaozKqpbyE2Ja/4o0=
X-Google-Smtp-Source: AGHT+IEWw8ovDGVJYf9lATgxbhx+omcLO3jSJmbP+ZlLgTv8CVbAL6kdi2o25u7EIfmSgJbv3rH+8Q==
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id
 ffacd0b85a97d-367cea45cb1mr3622065f8f.7.1720619970836; 
 Wed, 10 Jul 2024 06:59:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06d3sm5342613f8f.75.2024.07.10.06.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 06:59:30 -0700 (PDT)
Message-ID: <fb9a6445-a4f9-41dc-829f-5566f41aa2a2@linaro.org>
Date: Wed, 10 Jul 2024 15:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Remove the non-working virtio_check_params
 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20240710120330.78581-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240710120330.78581-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/7/24 14:03, Thomas Huth wrote:
> The test has been marked as broken more than 4 years ago

[*]

, and
> so far nobody ever cared to fix it. Thus let's simply remove it
> now ... if somebody ever needs it again, they can restore the
> file from an older version of QEMU.

You might refer to:

[*] 
https://lore.kernel.org/qemu-devel/4bbe9ff8-e1a8-917d-5a57-ce5185da19fa@redhat.com/

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/virtio_check_params.py | 143 ---------------------------
>   1 file changed, 143 deletions(-)
>   delete mode 100644 tests/avocado/virtio_check_params.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


