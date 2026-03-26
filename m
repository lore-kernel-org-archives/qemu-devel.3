Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139FB109E52F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 00:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5YPe-0001O0-Gb; Wed, 25 Mar 2026 20:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YPZ-0001Ju-PA
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:17:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YPV-0005xQ-T5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:17:20 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so2748895ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774484236; x=1775089036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RD0z5PZuGq804YWvx82KQBuFuBwcdRP1LzxZeuxY8hc=;
 b=LAbFKLad7P3L1Mj5Ricvf3EXnZnQs1bZr8PULojn6E5VXxwKiRB89PPz01DDUM203z
 hX11U/Id+9dP6vHVWRAzvk3JZB7IiVAD/eNRy7FndC+5xr3twhQ3y//cmS4FcehDciNf
 Vs/TaZ5NOBw+oNuQCXbUai0cz2FdIsuMhwhHx0OkxGJ4B7fBCiWaE/p0k5H4UPEQL2hJ
 jhlbaoCY7C1qQMHWujkAoSnkmb0BwSEJLLWOm+XZaS6ZwgduVeC2sTZOx+CnOImM0h7W
 0FwKpPOq1KDO83TBc8vowR7fTrFMcsDNaleoHfnkCQac7u9FBpmvlrLIDjYRCbCtICkF
 1zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774484236; x=1775089036;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RD0z5PZuGq804YWvx82KQBuFuBwcdRP1LzxZeuxY8hc=;
 b=XLbHZxsc8G8A8WFg/1X5Sa+mRO1bCOMOH0gwfL1EgifmLBTs7Wft6pFpqoN5N35A5O
 XfuOH/HJ9pSFEny+rFJlDhVyOmz6KdyhCPhqVdKlyuSTvRLIY5j/vGzsIzNkBHbm7E8g
 MKZtkqz+2kgFdxRivwScr64Gk8sf2gdAlckuUsbPqWJrAAXzsdoFHRGAy5j2PmWeZF0U
 acJV6UHlrtWictzl7r2rOCKTofURJg1Uf9yLcxZBBp6Bb77y4AeZFuevyi+EmaFxFZHH
 0Ogo4sHEFgGRp5LhACUliqJeGV+VoS0wJFTTjctiABt9eujktm9SRgLfJ4Ermd3LyNbT
 ocTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdahhuPcB2rDl7Kfcy/9o3MLqEvn3SRKofvFudiP2x2QJ9nP6ccxYQhRSsEbh6OFhcVr5S4Ax7Izin@nongnu.org
X-Gm-Message-State: AOJu0YyOy06slvHdP0gVx+K9lj0c8VWNxN984BLiJzVYl2XYHgyOeDPj
 jQTedrqh7p6d50+tkDOtRrXPIY1fx97dZOAnPypLZ/yJClGyNr1n3kszoSOCd2ZCJM0=
X-Gm-Gg: ATEYQzzVM3dI2FDQ+PkXLgFNImYwK6EF5kxGdoTvSSV7fAT6uEmMgR49GuRC6h9FNXP
 4Mlu+cDv7OeJuTMZtiK4HXKWOCWbpjf7beAJZGE1fSXPxbEMYZahH3U00BKvFW6APHEKXcKCpfY
 BWzM99UeBj2IV6IpX4LOxPQo4vldm0xxth+YNyGhX7eMSNio1BcRgbOj7JjPRe3oL3G67vbp/bk
 V9gg6qFrSCv6E+eiolWBez4hFycZYwd+/D+V/ZjmQi/i5nZxQA8nmoQ9tmcGvtmL5rJCHf9/i/g
 5HEsj2/5nQUb8Ke46+OFqWNbLgwnqOar08mDB0GVGg+KfC9pCoTpoQk4EImft6mrputAeVWJ4wv
 KsmK5zpkJhPAOGuJ+YR8sMFWk3HCZNKxXThLXAEeUy9YasSIZHMjtcZyW0+0wprXWtRV8PsxusN
 9QcqNZ0F4dODgb85oeOMrrqhbSf1EuhV44Z8T8et6cJA==
X-Received: by 2002:a17:903:2281:b0:2b0:5795:9eb1 with SMTP id
 d9443c01a7336-2b0b084558amr60457265ad.0.1774484235803; 
 Wed, 25 Mar 2026 17:17:15 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm10600245ad.43.2026.03.25.17.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 17:17:15 -0700 (PDT)
Message-ID: <baa6e258-b8e5-4f65-9c41-5ff28d6237e9@linaro.org>
Date: Thu, 26 Mar 2026 10:17:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] hw/alpha/dp264: Use rom_add_blob_fixed() for initrd
 params
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-4-4375b00a85ff@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260310-qomify-alpha-v1-4-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/11/26 08:31, Yodel Eldar wrote:
> Replace address_space_stq_le() invocations with rom_add_blob_fixed().
> This will prove helpful when the Clipper becomes resettable, because
> the params will be reloaded without the initrd file.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/dp264.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 87af919895..f036d72268 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -183,6 +183,7 @@ static void clipper_init(MachineState *machine)
>           if (initrd_filename) {
>               hwaddr initrd_base;
>               int64_t initrd_size;
> +            uint64_t initrd_info[2];
>   
>               initrd_size = get_image_size(initrd_filename, NULL);
>               if (initrd_size < 0) {
> @@ -204,11 +205,11 @@ static void clipper_init(MachineState *machine)
>               load_image_targphys(initrd_filename, initrd_base,
>                                   ram_size - initrd_base, NULL);
>   
> -            address_space_stq_le(&address_space_memory, param_offset + 0x100,
> -                                 initrd_base + 0xfffffc0000000000ULL,
> -                                 MEMTXATTRS_UNSPECIFIED, NULL);
> -            address_space_stq_le(&address_space_memory, param_offset + 0x108,
> -                                 initrd_size, MEMTXATTRS_UNSPECIFIED, NULL);
> +            stq_le_p(&initrd_info[0], initrd_base + 0xfffffc0000000000ULL);
> +            stq_le_p(&initrd_info[1], initrd_size);

You don't need stq_*_p, as initrd_info will never be misaligned.
Use

     initrd_info[0] = cpu_to_le64(initrd_base + 0xfffffc0000000000ULL);

etc


r~

