Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECFECCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJsd-0006Xj-VC; Tue, 04 Nov 2025 11:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGJsa-0006XB-1q
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:27:33 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGJsX-0003DY-2B
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:27:31 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-641018845beso279228a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762273645; x=1762878445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q5+RvtzfvIDb0dCMClbrxoxj+Eed//5VsmbEYWjKSMs=;
 b=UVz9dchADdtn/KF1IwWRaR39CqI2xaVUoKVEROpCcacqWxduCdjl4Qzy15qutrQq2E
 rkQEILFDGWROs17jA+/Dff/E4IT5wzey4DMBOL2LvtKwFD08I24/O6dGIF3wft0nW5uy
 XEDEz74rcjqaB62um3P5QS6aYJwQnhve57CYbVqh+vtJ8iwvPRkWppu87oO0X99cJDgM
 +lGePxPOZIbXGLAWnagGDusoQUokh4uL1GNeVD6xl6+yJ7DnTdSvXxnOqpdYHwoUN9uJ
 pPU9DUm/ubNsXHULmjlZRkpGBbx0Y8BGkQ9d2HxEoroLL3ZCTC6V0TqhcD3tYl8iZyyN
 3Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273645; x=1762878445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5+RvtzfvIDb0dCMClbrxoxj+Eed//5VsmbEYWjKSMs=;
 b=nDgMieRUhkVmEz1nuDgZJ3MhhQ3xY7k7S3fS1yrHNM1AKMkRJldIutXrlA7up5mXc4
 ciXdLucm5AkMms1r4mt4PycOViPCaULex3T/8nXUDYnIqHGcYGoylH4RrsL/pYkKWXrC
 d9zDHSL+os8etcoJ628mZA2B0tz4JPgIq7uMXA0uYrCFcp8t69cXNIl7DeTWPuQOpsHI
 XKPXY5Wi0i0Uoy+2jJGvK4Ah6XFR1SUAdRSgjAiJzUapF6bK+GGcyJFumLX7+W09gE5O
 dXGgsjcK3y73ovr1Sr26XfUvGf7NWwXCT+vNU4goCOSEI83LAxE+Jjif1sM7YaFTg66Q
 ONrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSFXDslUCwHxEkwkqNxm7G9bptuq0nMqs0cprQ3F4aJyB0bSoItEymsT+fdmo4P7z4c+zdC/Hsi8hJ@nongnu.org
X-Gm-Message-State: AOJu0YyLxaLSXIFDPSzV23avjBoftrEPazxEPPna8mpmsoWOf2eGx+x1
 HzvGLZV7SMIxczS3boghPb1kvGGWevlGSDiFWcR46qZlhHPoDvhdoiTLwiBQO9kHylx4FgCdW6V
 yLjtwlq2H8g==
X-Gm-Gg: ASbGncvm8gNb7yftpTNRtBb46WIUNYFqW43dm1a48Z728APOZoDdtoUH9HGhd9rcppG
 CDtJE5BQj7wnczI8ILuOENqjYzVitNflo4RiFcfnnPDEkaq8SZN1TszAx78mugE5DTs764SxbVM
 4v/j1KdPfjm177DjPVti2I/M8vIyVeb1D7BBBkzKTlhNeZ507XEl+vzmGdeYaHZPgAIe137TCK9
 QpFrz5AQc1el5COMR6jK+InULAJo4Glb5sZv0SrSzQDrfD1taMoZ9rcQhrRL4mrBteL9UcIETJe
 skg72tq/fEhqKEKEv5dHXWSG+h8atqjff2sJbgRq3G2wbVXX1+HhiGja1AaBL7XvpT6xGal3LTp
 OlJ1cABlzu4AP8a8YLxs9IiPalZb+lJ+evBmaa9/nu7y/I4V29VxIFKDmvINW9hgcMvSskQPOR0
 gX8M4WdEYXuBtKz+Wb3kBxXqC2Cckdlw==
X-Google-Smtp-Source: AGHT+IF8X8l7gHWGoGlZi+I81Igl+gOq7dngl8ZzMW8iy/+M72GKWKb6wprtWHtXmZdOjw2tTdha3A==
X-Received: by 2002:a17:906:fe4d:b0:b3f:3570:3405 with SMTP id
 a640c23a62f3a-b70704b3554mr1551408966b.34.1762273642045; 
 Tue, 04 Nov 2025 08:27:22 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e0703sm249316666b.39.2025.11.04.08.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:27:21 -0800 (PST)
Message-ID: <8884e7f9-eff4-4bbd-be5e-9d6d2012ff6c@linaro.org>
Date: Tue, 4 Nov 2025 17:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 5/6] scripts: Add helper script to generate eMMC
 block device images
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
 <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 4/11/25 15:45, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v6.1:
>   - address BSD shell portability issue of stat -c
> 
>   scripts/mkemmc.sh | 219 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 219 insertions(+)
>   create mode 100755 scripts/mkemmc.sh


> +echo "Creating eMMC image"
> +
> +truncate -s 0 "$outimg"
> +pos=0
> +
> +if [ "$bootsz" -gt 0 ]; then
> +    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
> +    blocks=$(( bootsz / (128 * 1024) ))
> +    check_truncation "$bootimg1" "$bootsz"
> +    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        status=none
> +    check_truncation "$bootimg2" "$bootsz"
> +    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        seek=$blocks status=none
> +    pos=$((2 * bootsz))
> +fi
> +
> +if [ "$rpmbsz" -gt 0 ]; then
> +    echo "  RPMB partition:           $((rpmbsz / 1024))K"
> +    blocks=$(( rpmbsz / (128 * 1024) ))
> +    check_truncation "$rpmbimg" "$rpmbsz"
> +    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        seek=$(( pos / (128 * 1024) )) status=none
> +    pos=$((pos + rpmbsz))
> +fi

Still:

$ dash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
Invalid value '2MB' specified for /dev/zero image size.
scripts/mkemmc.sh: 170: [: Illegal number:
Creating eMMC image
   Boot partition 1 and 2:   128K each
scripts/mkemmc.sh: 192: [: Illegal number:
   User data:                4 bytes

$ bash scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
Invalid value '2MB' specified for /dev/zero image size.
scripts/mkemmc.sh: line 170: [: : integer expression expected
Creating eMMC image
   Boot partition 1 and 2:   128K each
scripts/mkemmc.sh: line 192: [: : integer expression expected
   User data:                4 bytes

But now the file is generated :)

We'll fix on top.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +if [ "$usersz" -lt 1024 ]; then
> +    echo "  User data:                $usersz bytes"
> +elif [ "$usersz" -lt $((1024 * 1024)) ]; then
> +    echo "  User data:                $(( (usersz + 1023) / 1024 ))K ($usersz)"
> +elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
> +    echo "  User data:                $(( (usersz + 1048575) / 1048576))M ($usersz)"
> +else
> +    echo "  User data:                $(( (usersz + 1073741823) / 1073741824))G ($usersz)"
> +fi
> +check_truncation "$userimg" "$usersz"
> +dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
> +    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
> +pos=$((pos + usersz))
> +truncate -s $pos "$outimg"
> +
> +echo ""
> +echo "Instantiate by appending to the qemu command line:"
> +echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
> +echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"


