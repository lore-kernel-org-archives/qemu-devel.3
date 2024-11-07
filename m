Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA72D5AE7D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zVS-0005eX-Lh; Thu, 07 Nov 2024 05:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zVQ-0005eL-JS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:12:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zVO-0007bL-Pb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:12:48 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so416958f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730974364; x=1731579164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQmBzeslQ13u6vN1WK2um467iEWUJ/0NpItO4PWDvO4=;
 b=pufz7ARkXVxBWwE1K2rkTSd5MTJlf5IrTAj1gaGr/hKMwtiz7taICsuGUWTegJe61B
 PJAxb3FA8l9t2QZJy5Va2Q9grTnHph3MfAmjSZhyRZC4k/QFprQdp32XedvBk4PV0Mof
 om1LeqzTNd26xwbKUb3gRvNaQ/E8vQPoXrWHJgEUt9dHagGGUjXHMS04jGJe11r0fy/u
 qaQ0NCwHrcL/Noy+HSofiBYIDsA5Z2dFi6xLh5YjUncvaCHpwWN6ETwmh+un0JP4Woia
 9HXWHCIs6yBhfd/KRPrxXDcp10z7cTW0/pz6Cg2Ti6iFhbXUmhRgUvprIrUsV0MfM1zt
 /efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730974364; x=1731579164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQmBzeslQ13u6vN1WK2um467iEWUJ/0NpItO4PWDvO4=;
 b=aeAf/A1jhNvpA2G+dlme7Gz53QDs3htx61T63ThPdI02YHw1Y2z97q72X4H+Y4/Xw0
 Jh7QpYnqwA67X2kDT4KRiALKoqOyNpQRpYAx2AXobmE1CWGPpEnE2yZXR163ZyaaiH1w
 uTZfKgkB/FQlL81MbMm/KKCHSzTt1q25LxzhDW3spkYQ3emRLh1oJg6WK+PYn31rGy5i
 riSm49WCRKroqHUtb+GG0Rk6Nw27dQz7eFIrfO8D8jy22jMlSYzSR2XgTZonSb+32auW
 Ph0E/VpETlz55Dkjs+42w/VeSzBFmbBk+eaeoOxo58CCWb99q9AoEskI4wnjJIO3f+Nc
 ATXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKjG9Z2i/LTOT+De//YaZaMYmgAAm0ljwJffDI6arF/4ne2PFLyWUOOf87OZ0FVZYzbuxnFhl2xBQ@nongnu.org
X-Gm-Message-State: AOJu0YxrOZyCDy9d31IddAbD7xvlL1bPx9e8EWG/GjgkIp5j0dVO6aRT
 sxAxD/KXXBvjBROcbNlCras0PHJHEP0jl8oLWwvGovSSsLUoGH/vhSkrtjkQ3ZY=
X-Google-Smtp-Source: AGHT+IEwcbC3rYveD/laxOP9bMk/1J6/WBraMqEmsynWLlsITs4l35EDXw3gHxOdR+lPzDvKRRolWA==
X-Received: by 2002:a5d:47a7:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-381ef6e917fmr612007f8f.14.1730974364532; 
 Thu, 07 Nov 2024 02:12:44 -0800 (PST)
Received: from [172.16.23.118] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04ceasm1271149f8f.102.2024.11.07.02.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:12:44 -0800 (PST)
Message-ID: <c07c55ec-45e9-49d0-aff5-5a1a40a4a0f2@linaro.org>
Date: Thu, 7 Nov 2024 10:12:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/intc/xilinx_intc: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/xilinx_intc.c                    | 61 +++++++++++++++++++-----
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   3 files changed, 50 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

