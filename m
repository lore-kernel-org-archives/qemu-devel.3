Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A38C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUUm-0001ch-0A; Fri, 06 Jun 2025 06:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNUUe-0001Zx-V9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:40:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNUUc-0004zH-4T
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:40:12 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1001799f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749206408; x=1749811208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjuzneYBT3pzLEqqh3cShBLyQHFI/d41YwCmmsnCiAs=;
 b=yXtWjxirJSh/7JIs0Li/p+Q5zcQ0/rzsBFebrPscXkVQb3khdlwEGbmpKLEcsWrlnG
 PkeLmyELop/KBBZ0s//5zqIk10hFuj9QZh34Gj+ReL9QZWWPW9kOL7SVfp/0sELRt25i
 oQUHwJ/9oVJWrdsO/AFoLc4GpqOhX9qus3KRvDDuHJO3TxrjOd/x7jwCQjxQkkSBxtM+
 H2kRu784WCigALFWUs/PNN5ymRBX2k4q0hHv9ypxztkmmNVErqAKyStedSZlV+Vf+AXr
 PFXmq7a3EU4H2BZJ7KAf2qr/cBPfmMxVJVcMK0PeseHpiqTunBxB8rRPBKkdR+s+T4kd
 ddWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749206408; x=1749811208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjuzneYBT3pzLEqqh3cShBLyQHFI/d41YwCmmsnCiAs=;
 b=VU3IXOrC0BEvoo9k0Sr0Hvzxr+L1TCubUn7GUa8AtkwARxiZ9N2AbVSdDJVulPSwSl
 GF7QSUfHj0/0ZmIlMpl1J3wZXIXkf9reE4f9qIQpFkZ74+DPS9zGT9TkU/muYiuGyzsk
 mvE/Mjxn2OD2sPQp7KskJ/8MF3S1Bb8VbM7rVDbLJBrmYzm4F9CtaD6PjLcgSy2fIrn9
 1yJdWpTQxHYl8joXFbO6HeKT/Elt6W6kLT1esatnx9zn/xddCVLPFNMArlguNctsfWDQ
 tofhKKeKhsKEaUpJLw5XKDMGbSLPoXybl8V2jqN9X5YeLqUYzTznZmk9AIwvmhj3yWYI
 S+bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYi5cUSoM2gikEjuQeHWPbOh/XmkCDNSZj7R4xecFLyK5GIhNNXBdW2iXGdKtHGVx7OeMw8zIHCdUs@nongnu.org
X-Gm-Message-State: AOJu0YwmJQQIrTs0OvcypNZBKezvChl8uK8rVVTTG3MUflhe0lsdqwZN
 n/cRNL3P+rTnW1n6tpfjOuqiZHmgHstLxBLjUjUmrNUKj6B6GSq8dwtqFdoIo9Z8TLo=
X-Gm-Gg: ASbGncshj4vt0SDSEPUIYl1gxfMAzvks+1cbGd7gdKj8poSjwAxF5NvRactqN3RrlOn
 N7S/Vn9rB6CZ71sfCcXPRUJyewPpEuLfWkwWrErTpBZxx/SgaYJvwzEOpCNFVkLzrFhcRA2P6RR
 me6KQkiV//9eYuiU7Ni8S9O+JpqLKFv9VRbTwaGo9olWyXizViKK0kxRmKpUxJ+kqhnk4VSAzGV
 cRaT/+oPFIYi6sHGOkv9Goxx5aqOqVqPkXfAt2IaxObnou5zWUYFc8eMGDGeJCkibP1SOH8bWfa
 wJbbNAdO8euLdvFU4/xvgdLI5k3sQCrc+R5tTiKr3zSCRCviAYKOxN8mcvVhhs4Amv77KP2DEaB
 ORW9ha+a5Bc2Ew+BlfXYoyLPYqche9g==
X-Google-Smtp-Source: AGHT+IH/7DLMDiF2AxhR06IE/NYzG7X3bqvmGkEEg6awj43leAK2MK2LCyvSHOjUNiz00iEsbNhKoA==
X-Received: by 2002:a05:6000:18a5:b0:3a4:f6f1:faef with SMTP id
 ffacd0b85a97d-3a53188e4acmr2542321f8f.32.1749206407927; 
 Fri, 06 Jun 2025 03:40:07 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e158428sm16729425e9.14.2025.06.06.03.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 03:40:07 -0700 (PDT)
Message-ID: <22f73acc-bc5e-4cf5-bbd9-c2c94bec9d33@linaro.org>
Date: Fri, 6 Jun 2025 12:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, armbru@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
 <20250606092406.229833-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250606092406.229833-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 6/6/25 11:24, Zhenzhong Duan wrote:
> SH_SERIAL is declared with OBJECT_DECLARE_SIMPLE_TYPE but defined with
> OBJECT_DEFINE_TYPE, SHSerialStateClass is also a dummy class which
> missed its parent.
> 
> Change to use OBJECT_DEFINE_SIMPLE_TYPE and remove SHSerialStateClass.
> 
> Closes: https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg00586.html
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/char/sh_serial.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 6abd80386f..8ccc2234ba 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -78,9 +78,7 @@ struct SHSerialState {
>       qemu_irq bri;
>   };
>   
> -typedef struct {} SHSerialStateClass;
> -
> -OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
> +OBJECT_DEFINE_SIMPLE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)

I'm surprised this is the first time we use OBJECT_DEFINE_SIMPLE_TYPE.

