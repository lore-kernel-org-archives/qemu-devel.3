Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A3BC5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtRo-0003qE-WC; Sat, 07 Jun 2025 09:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtRn-0003pm-CK
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:18:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtRl-00021g-PZ
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:18:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442ea341570so19571005e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749302331; x=1749907131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ePg38LiS5w3b2VlVxskKODQ6Zy9P66ZgWxbmNeO9Vg=;
 b=TKtJ5TPHrzCV2g7VgRTX40gJcYFc/tGo8MwB+663ndi+QRoQLcEqozj1Zco5lVp6pD
 sD7DK5z84aFElsnerXhFDoW3Dfq7xJuhQXUwAW8zrMxdfvHGX1+LfFT1/77ukRvqkf/q
 jPL9YW/yOkLFyTgogdZYUqoDJlw/HZHsSjET6e7rm86oS/cCmDIKrLelM8XjvXDEcqRP
 +ZS4mLcz0dEkYVPoNyUwoCjo0rn3D2E1RgrfmRgs8ksd6nCsBX+lAaWTKqcDd7JG6s3/
 L+IwZStnKK5xrvIb1Z1iK9VW8HrGGat5u0EzRIqe06cDMVQegDLCEmjDwugf9v9j8r5w
 WM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749302331; x=1749907131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ePg38LiS5w3b2VlVxskKODQ6Zy9P66ZgWxbmNeO9Vg=;
 b=b0SrfG+D3rlB/JgBs13I9eJVORb4tz2XGE7uFppnLzCwPGST2R57nGttP8mPvrewI4
 +fkwyU7pSqOTymV4OEOIlAsmtpgMLnaKZ0gjjiru+VpPiepJo9OXuBQEqeumXTD57zRM
 ZLOB4YACZ9jWoheoNd6sCURrGSZ4zGOa9CzHiUqkCXdZUZCkrs5GNedUdo6brP9kVXwN
 U9tG1F+P6jSVAArgL+0iuhUs+OLHmJBO8xeMJdlqpTheY/6qEnz+qx+qTBsCxN+s7XMh
 n78WjusmTlsNRTqqvGxIvq2sJYKBEcrOtDF+OKu8WbzIHeQUqw9LTA3ErqR9RBFEa/D7
 Y0ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh56ksiQduO1HnlUsRVdccA3vdo+x1IXOcIo3tHr9P8X02dfZNXh7KLTMAdw3VxeM+YjoaLRxz9BG/@nongnu.org
X-Gm-Message-State: AOJu0YxA2Bytr9H22pN2VrUWfCtahe9T25/XFGC+iOXNp7R3id//D7nk
 ZJXHCpICnTJTIvxj1d2XKjI94Cjr2AnfU7zY8ghW7iVMYgYkULgqDIDZWI/igpRhRCs=
X-Gm-Gg: ASbGncuRVppGjW1BoNyHTQEHOfoqHpG4msqApGbujGE/anggfMOwZb4aAGLSLIcYoCP
 8Al2MWixspNLCVCEzTjjdMjGCHlltITXsLtxFkdQoluBXjmzi2wZTJbOpSGexuyKfiypXK6Hq7W
 Z2VUEQyg0IXtHIVT4oBNX7GaMsdXMCkw7lD3bJAswmAGznoOvsiqji/PoyhKZ7IQKopxN7DRVx0
 Fse1i7euXdv0W9anIBg9hlGfiHEriR8LYZnNzvLCNeDLx3g0q9+0ysuKsGFluTYB2ersUnhcb+Q
 2cd38Zuvh2Y2qTivf9719QVneBaeJkd4/MNi9oZIx6qefMTIlQYBQFHBST0xttk3XKRuZTgrEhC
 aK2fhzX1gs/rA5kcOstewXL++yj8g68fAZx2M7Yg=
X-Google-Smtp-Source: AGHT+IGNN6Ih+Ld+th5hGG6NyeNEkpsr8sR3SMOyxYKNr1CrW4mw7ZjXMOf/F/Suenuon/r3iI1MYA==
X-Received: by 2002:a05:600c:6205:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-4520140c06dmr61967115e9.21.1749302331334; 
 Sat, 07 Jun 2025 06:18:51 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d50sm56653035e9.5.2025.06.07.06.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:18:50 -0700 (PDT)
Message-ID: <388434ee-1940-48bb-9b38-52efcf7a4a11@linaro.org>
Date: Sat, 7 Jun 2025 14:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a37..d55ce2c0f4e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2205,7 +2205,7 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
>           error_report("mach-virt: %s does not support providing "
>                        "Virtualization extensions to the guest CPU",
>                        current_accel_name());

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

