Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F9A1062891
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Iqu-00083O-Oi; Wed, 11 Mar 2026 08:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Iqc-00081w-K3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:39:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IqY-0005bZ-JF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:39:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so43569085e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773232767; x=1773837567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MGwir+2/9M7PLlyMokXQXiUfuz3+IzmwX0x5IxVlSYY=;
 b=MLDSkiDnTCiizbrJOhnd5i5QRz6e10457L+Pbf4NVeisHYYmvEX2iNl70HnS44stJA
 vqFsdIZ/pgql+A7IirslGOIBAWFxoMU9u+Yc2h7pgVANlSDOH7rDjag94sMntv2CTodw
 LfM+vxMVjWuxpPUyBnte2MV94M0arPlCyGNayikTscuC+qUkl6F5IVIpGGD1xSoJmpKx
 kVg3AAJN16SLpT3N11dn/0h/xilkPaymoW8UxXLfwFl8OQ9gHPRadBL+0bu7Yg7m8EcW
 f7jejEd2kgemeGGFZVKa4ZfZ4LvK5DE78nPGZp3v1a5pCPXy6OU3golLb526R6GQoo59
 2A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773232767; x=1773837567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGwir+2/9M7PLlyMokXQXiUfuz3+IzmwX0x5IxVlSYY=;
 b=mTAgSwupZ8HkEdzQvxkWZWTiFB/cK+XAK6xn4iMOZe5EjWj8Cn1I0sdyixUSnFImwt
 SIk5CGE+BLYThxYgosLAuF1xnqI05BfB8l2PUeC0z824V3/eLoLgXR++XoUYCYTjfHd+
 mjzojrbRhaBq691AA/utHgDOL5Jacm0l9NRGGSDJ0ZBIaPr2VEWy+mQXZQJVwDMBHGMF
 egyfSQwVPOCXI9/SHkEZMhHWTEfY8dREjsTOTYOapoe3ghZhzvIW/f2VLitP/fBtmOp/
 hIKlW3aDq4xKQaf8l46xgxy3BKeQ4RTBBtDbsUUKI0nl5ykjB4SOySYLfT3QKhfhOdcQ
 YbLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZUeZziQZ63FsFXyDUDMKavvqGlyyFp7pbpihKm31VSocC4Z/McggUjvtCro+nM4+O6950yMqApc81@nongnu.org
X-Gm-Message-State: AOJu0YzfrNWccq9HyOTLEDhW8J6Mwf+a3W5QHbr7DMUr9YlbefE4N8R6
 1gAC0P9wdaAlMZ5TehltlavbuPahtrQpkXGJ9Zxrgkol1xfNYNIs9nt2TQraZvtcgKi+91zq5DS
 dMnc8xbE=
X-Gm-Gg: ATEYQzwToOBOkcxUStFegiHJkMZME09rrW6cwxqhV/IvXtHsrc2ZiBOfZ/qvmZHFI6k
 rSdxYMkKdnHtctJTI1jgPqfrNvHtRcipz0JOSx/nQ4B6WSsBPU46fSL8Mt/iThHVBJGVruzuyHs
 TAz/Bux+k649ytEU+Ehe/rz6kI4UtuBD5pCOBWTalFaDRQJ/d6u/hMjfX4LuhUFUzQX+4uFOK9Y
 dlhpO6AGBJC2F2Ju97Sk/AXNFiA9qH580IzGx6cytXH1/b7va7GJ+ZoeKm87y9OVXIhY8P6q1Im
 WjjLcPsM0IMmRPZZvQ/GuickMhoFDsOJf92FW992elymg99FSFURF7JaYsMHz8uzXcbs9mIKZ+/
 Gd5Cy4UHbcq4ibBNc3tTyrlNOGUVxmPKiIbPoV2PTh1Qrl+8GRdVrik677yswUJc/QRK1xEvu7f
 +5QPAks32Bp99MkT2F3CUTMUVPPRe7hFqKzZgE0+TZVHtoICJ/+xNHpdtlOFD30g/sVA==
X-Received: by 2002:a05:600c:3104:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4854b10d0e1mr41098345e9.28.1773232767084; 
 Wed, 11 Mar 2026 05:39:27 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ad1e4esm153429435e9.8.2026.03.11.05.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:39:25 -0700 (PDT)
Message-ID: <58d35a81-bb2e-4421-952c-bac2fe8c3b85@linaro.org>
Date: Wed, 11 Mar 2026 13:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] hw/alpha: Expose RAM to typhoon via QOM property
 link
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-10-4375b00a85ff@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260310-qomify-alpha-v1-10-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/3/26 23:31, Yodel Eldar wrote:
> Currently, the board (Clipper/DP264) passes machine->ram to the
> chipset (Typhoon) as an arg to typhoon_init(), where it is
> added as a subregion of system memory. This commit, instead adds
> a ram pointer in TyphoonState, defines it as a Property, and sets
> a link to it from the machine, thus removing the ram parameter.
> 
> Note: Moving the ram subregion mapping into machine code was
> considered but decided against so as to preserve the Typhoon's
> historical role in mapping the address space.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/alpha_sys.h |  5 +++--
>   hw/alpha/dp264.c     |  8 +++++---
>   hw/alpha/typhoon.c   | 14 +++++++++++---
>   3 files changed, 19 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

