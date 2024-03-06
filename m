Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB94C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtte-0007OK-9L; Wed, 06 Mar 2024 11:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhttb-0007O9-HB
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:13:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhttZ-0000CJ-UI
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:13:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412e92deb18so21286435e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709741608; x=1710346408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FdwjQz+9lAI07uHlSjq+LXx53u/8Xe8M+RVUi6EDcgI=;
 b=moe0P3uS/ULQQjpJSnELIY2rAzDdUt7qwNrU75Awy5aRHrryeL/+LUiSJt5RPZoIW5
 gsppbNz3GS24vgMTNgoWo+hRmVZ1ozcJwG95xVPWCPGNYyTFpKi0CQjGJVn0tQwlAE+V
 K1P92BLXECDz7l6cXa5o6N0fbQGsy6p1q3uips06dLddDnmNM7kupLte62eKGBkSKYw7
 ZMm/xPmOjzaRIjdx900VwpLcL+IOuFe5taRmETMoxly3fL4bta4uBZGRfOsdrtZ8kfr6
 1okvffknoZinRbu/zq+hSxCO0/2uRRTNH3ot0l8a91woXVppgm6vrKjZQ187W5P0K6vt
 PPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709741608; x=1710346408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FdwjQz+9lAI07uHlSjq+LXx53u/8Xe8M+RVUi6EDcgI=;
 b=e/D/Q8LQQkamo2/xy65flcyaENo82KBoDyUBLjvSRQYH3v75BTFkrIEdgrx/UFm4V+
 xfpDC0qDTvr6k0mxwh/l+ckM/A9acpY8VSHn4XBVAcNDOoJcUp0StuJEixqoSgFDsCgv
 bogRisFu+4vA3kwh9YY1bdIj6Xsdd/p+fUWKXzySQEMEl1E1HNDSIZotUPSoXVH8aP5j
 MaASnimehatTzs5VDHN17+Ua8tODgxLSfV5S4mgeYKOyu1v31Vqu1TGVwN5mGrbZs6b/
 C3yZY3V8C1ZpVeUa/y5X45Bx/VDAEGb2K9kplNroHpBsc1SdIubYO3itKgadHHLDZU3B
 tgmQ==
X-Gm-Message-State: AOJu0Yy0pFjgFljIS1dtVE97r2qg7m11wfA0vzHoe56oyuvtdik0gfDG
 ANqpGbyCPg7Nr+zAftG+iHguDC4tXzFU4pMnoeVjLhg24sSsaI5z9Bawys+ASKs=
X-Google-Smtp-Source: AGHT+IFazx68sypsjEzrxqLYGovBqjsPmXJw1qKWj9SLjwGyiwrgnf2UOVwemlQJCp9VaPQ2/6K9gA==
X-Received: by 2002:a05:600c:5116:b0:412:529c:356f with SMTP id
 o22-20020a05600c511600b00412529c356fmr11001085wms.28.1709741608215; 
 Wed, 06 Mar 2024 08:13:28 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 fk15-20020a05600c0ccf00b00412ff1acf05sm932589wmb.7.2024.03.06.08.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:13:27 -0800 (PST)
Message-ID: <74c18024-45fe-46fd-8ea9-8cd4384e0a46@linaro.org>
Date: Wed, 6 Mar 2024 17:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] docs/interop/firmware.json: Fix doc for
 FirmwareFlashMode
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
 <20240306-qapi-firmware-json-v1-2-619f7122a249@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306-qapi-firmware-json-v1-2-619f7122a249@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/3/24 11:31, Thomas Weißschuh wrote:
> The doc title did not match the actual definition.
> 

Fixes: 2720ceda05 ("docs: expand firmware descriptor to allow flash 
without NVRAM")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   docs/interop/firmware.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index a024f1b9bf3f..54a1fc6c1041 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -223,7 +223,7 @@
>   
>   
>   ##
> -# @FirmwareFlashType:
> +# @FirmwareFlashMode:
>   #
>   # Describes how the firmware build handles code versus variable
>   # persistence.
> 


