Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B3ECFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVbv-0003yy-3F; Mon, 24 Nov 2025 07:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVbt-0003fX-Tz
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:24:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVbs-0005Aa-De
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:24:01 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso2262733f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763987039; x=1764591839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zinTWrL8ZAAHhEEiZe9LYYVqgEUqufekn1GhfX31NXc=;
 b=hLVRZ4TGs6dTy31IKjbsrWHUvJbalYMJaSd1NL8/SrivN3qt3Pf8jpB6/a/ie6cw2J
 XRQdFjoqrDPSYJI9jj0ifi5gWKSPUrQN5yYm+NTYNsidv7jTciFSUHEkt9R2B2GFFKn+
 7pW9xFxMAEX5li8tLP8IMLWPi32MGMMCvrzLF/Yb4kceMJZ33oOeZ0mo6IM6B0h+Tffw
 XvelTWorOF1L+JJb09RcwNqFKHEUqYpxomyg/ZybSeuIB6la7bHseScSZCl7VUeA2yXy
 ZI+HoyyDw3m+EjC8RX124j6PFCLCULBSnk30Ei5iqdddpz7mHX+0Lw3zStwCcnMWKYz3
 5G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987039; x=1764591839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zinTWrL8ZAAHhEEiZe9LYYVqgEUqufekn1GhfX31NXc=;
 b=Pi6ZZtZcPajL3F1WCay5jTxu5m2Tj1cWs69dpW4l5jZOLHF4/YBQy69VJnzjsZesS1
 fyO1Av3ZUE4m+n64hZ6xF0WUXDYPWOOFEDmEIcfRqrfsBo37ZCMlIwEkgrI3b3vrT32s
 6x0RvAaoELs3d7Iatr0sCZKSkyejD9akseVJPr4wCwYngNlxaMKxRUeuI14dQ1yEL7te
 dGjX3GsDN5IUmnJ2BQ8rqxFxUM9iHjBed0nwgwC66m74N2lbQisNtzVGwjLvpDp1v3OD
 WnjyUI2NsWCaRJTvmmst+jvcgktWY+/TgYgl9oZ76BE2yuMOeSKS6olAxRZEDYvIQv29
 x5dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd18s4VBG8jdm7C5gmF1FFTdmqAvEKa794fpqXzNyWjBBKt7aI9T7S/pg0Os6tqv2PTqbvvZ2tu7Ul@nongnu.org
X-Gm-Message-State: AOJu0YyUVok8QOkk3QNirkH6eZxri2tVj7Q8DaCOQ1fhh4c4kdS2I2Sz
 p44xwVr0HLf0KQhIe3/gLjyyYF4TXO5+5IeWMZ9oSvS/h7FQgXMip9hfexO++iFcJEE=
X-Gm-Gg: ASbGnctopEOtrceY3E1PopuHBPt6EnVqGd1/7AQoKaSHVqARlrhROp7FtgEpXJ8Zg8G
 2ktWeu/8Dcdc5tFrSeSa/oDjebxwylynoZ7wSRE1lIPqqa/cTC+LzCWjhzzCMtXNSt/aJN1Mu3C
 Fz3OyQJEu9R4dEnEvTP4SIY+O2RnZIIwVhgg2tvwNg1CL7UT9HqQZCRFhGRucOkh50ztg2oFJtI
 OeRMlnuF0bbCT3jCSW2mcgxHV+3tEx/ZkDIW0z1x+MXJnV9vv6qCrOizQGHZS0HQaqeMja4lrn1
 3Nj+tZWj9SnOiRj8XBR/fLONHnZ3s8AKpPrFnQQkuh8sVuY0Kg3HY40LtEV1DSQ+ZeDhdaKaJpj
 3bpzVhkn85exv7DOWXNxn5K2/FMJ6hyaI/xOaq1/HX5ZeEvgGUR18PMSN+jd6jR5bf5bEf2Hi8V
 6EjUvxjbfDn4CnleIwZPiBXAkuKLHGvGLCq3IlePi+hWccQAr29ogppA==
X-Google-Smtp-Source: AGHT+IFP1Cj743zqo++MnarxA4ruIY6iw6bO3Ywlhf61Vgnrc0lsvAoxmlvpX4y7bRwndD9+Yydlrg==
X-Received: by 2002:a05:6000:230d:b0:429:c774:dbfc with SMTP id
 ffacd0b85a97d-42cc1cd9b39mr12539466f8f.12.1763987038634; 
 Mon, 24 Nov 2025 04:23:58 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm19847409f8f.7.2025.11.24.04.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:23:58 -0800 (PST)
Message-ID: <877d3bb4-5f76-4466-a3ac-3fe4c2460d7d@linaro.org>
Date: Mon, 24 Nov 2025 13:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
 LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
 <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251011081553.4065883-2-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/10/25 10:15, Daan De Meyer wrote:
> Preparation for adding support for zstd compressed efi zboot kernel
> images.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/arm/boot.c       | 2 +-
>   hw/core/loader.c    | 8 ++++----
>   hw/nvram/fw_cfg.c   | 2 +-
>   include/hw/loader.h | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


