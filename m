Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE9E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJSl-0006kc-0k; Thu, 05 Dec 2024 16:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJSi-0006jp-Kl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:32:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJSf-0006Ss-CO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:32:39 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e075255fso1073129f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733434356; x=1734039156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNloKU2y0Z2Pt56YkmfjPbGjy1q//hmeUSbRO3BZN/k=;
 b=KrVL20hWLf4jHfYdUt74P3fd35iliTUtLBe6QMsR4M35g2Mx7MIdyEpxA/3TF5OnS8
 GsRJmQDFs3svvgWdcSnGxhDFyqvSFWNnqLDHhee5QR4gZjr/Thatldg4W/B9I9kmjEhH
 oQWnPo0j0x0Rd3pxolZjl3BE9E6PTLgUD9Mt8z48dhyCK0GQqHAuqFhvdY/xFfd1vS0c
 0N7gMqjrlnFhLcahhbbbflVTIpzdujBD+tQWc2IptQPH5OW0XCcODr4/t2JWpI2r8syl
 QEz2qjsRB3io7sYBfxPQFQQAbuRQ/kuZIe4UPcNxmmSdDckPkLhlTpuacFyH+z3/eGbM
 NUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434356; x=1734039156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNloKU2y0Z2Pt56YkmfjPbGjy1q//hmeUSbRO3BZN/k=;
 b=SB0yAcAIMGBecjx0TrkAfoiomzAZyx0VXmKp11Be+4tEA9GnqKcrJJXdTHaFtKU/s/
 73QzoSbsMXuM7PRFz0YUxkoTmd0UTEypnsAh2+ihFchQr2ejt0qUePjcxWjRvH0iIBA7
 HCHpySIrYwifOnzF4lwvbZoBGAVbUudIHfHqMIwkgxq6FuBQyjrMFQFekLELsakfCqty
 9NH4SI2TEVrrw4VnxNeE0Q9BDea+wScT31/Q7GCXik9rNCa7bk8LmwAw6eq5XRdVuNPV
 TnPH//horhT2pc6HUvMPghbADzSGZvwuxoXVFYZbNJZeHKLIEXueYAZ1Ww1d+2eDjyjq
 sa7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIl9lGVhSaQ8Wh59edYZzGLbm2ADPjunTy0xqG5gi5wKnUkBAhbqQB7g7b6nUAR1XVOEbseI1xZ15o@nongnu.org
X-Gm-Message-State: AOJu0YwzJSORXlGKB+0T/o9+q9y7rhsE0GRaGRzTSztbFo5fHUwd9hBh
 LfqNCafs4cPw7yMIwS5jNvQ4QrvwTkZcigZbCrYMyxqZxQTRAuGnZNDfzBZg4Us=
X-Gm-Gg: ASbGncvCC5Z8mqwNaGTxL7x5P6O+IgEBFLVP0K8CblNIFXMel168mpnV7GiqSzGJ+kq
 5Lhk4b7JJFsUMQwWFqux+jojUZTxjgPbTeyIqMtMFToJbSmvcRUbaTuKNHWarzTxhqaPruSCZPQ
 umFx/KE9Zutc7cz7T12K1fSfe0UQLQEI/GAg0FkalP9cYOOPYApzjiCQLw8IH915g0G7qvB9+98
 pUPZosnWKS7G33Awvm81OEFMRIQPkWtGT18+OxFZoFvtPsos+5udMBpwjrOQsM35pFzH47/hN+u
 7KR5B4KmWHr/HHp1sg==
X-Google-Smtp-Source: AGHT+IHIp3Id09IDvgw7T4qb4DGImRzHVxowhnlYlEzFCS4RfFstp9pspojXdzkjrqYIyZCF7oCoSw==
X-Received: by 2002:a05:6000:1787:b0:385:f7d2:7e55 with SMTP id
 ffacd0b85a97d-3862b355a26mr458528f8f.19.1733434355631; 
 Thu, 05 Dec 2024 13:32:35 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59cea5sm2915970f8f.35.2024.12.05.13.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:32:34 -0800 (PST)
Message-ID: <7a9f495b-7aea-4b7b-8bd5-e1e7db34b6be@linaro.org>
Date: Thu, 5 Dec 2024 22:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net: cadence_gem: feat: add logic for the DISABLE_MASK
 bit in type2_compare_x_word_1
To: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, edgar.iglesias@gmail.com,
 alistair@alistair23.me, jasowang@redhat.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Andrew,

On 18/11/24 12:48, Andrew.Yuan wrote:
> From: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> 
> As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide,
> if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
> mask_value in type2_compare_x_word_0 is used as an additional 2 byte Compare Value
> 
> Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> ---
>   hw/net/cadence_gem.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 526739887c..7ec5dbaa9c 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>   
>           /* Compare A, B, C */
>           for (j = 0; j < 3; j++) {
> -            uint32_t cr0, cr1, mask, compare;
> -            uint16_t rx_cmp;
> +            uint32_t cr0, cr1, mask, compare, disable_mask;
> +            uint32_t rx_cmp;
>               int offset;
>               int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
>                                      R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
> @@ -946,9 +946,24 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>                   break;
>               }
>   
> -            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> -            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
> -            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
> +            disable_mask =
> +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
> +            if (disable_mask) {
> +                /*
> +                 * If disable_mask is set,
> +                 * mask_value is used as an additional 2 byte Compare Value.
> +                 * To simple, set mask = 0xFFFFFFFF, if disable_maks is set.

Typo "disable_mask".

> +                 */
> +                rx_cmp = rxbuf_ptr[offset + 3] << 8 | rxbuf_ptr[offset + 2] |\
> +                         rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];

                    rx_cmp = ldl_be_p(rxbuf_ptr[offset]);

> +                mask = 0xFFFFFFFF;
> +                compare = cr0;
> +            } else {
> +                rx_cmp = rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];

                    rx_cmp = lduw_be_p(rxbuf_ptr[offset]);

> +                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
> +                compare =
> +                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
> +            }
>   
>               if ((rx_cmp & mask) == (compare & mask)) {
>                   matched = true;


