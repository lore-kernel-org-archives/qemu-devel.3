Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A86FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 07:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHzVf-00088D-JZ; Wed, 29 Apr 2026 03:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHzVc-00086u-6y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 03:39:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHzVa-0005b1-Ga
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 03:38:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso7035490f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777448336; x=1778053136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tn4563GEryK2fgjkRMFSfzY80RGaQO5e7SL6sxz0APw=;
 b=lxYNOhgdd9L1zSr8QTpR2XmvZ5CdsKpnighmujyWvOSelcgPbEreDhU79INf20yKyN
 BHmPbVbTmtdiiqxaBgFY8YciKU6SZYijNmLyIICBBJqNXEEP5NO6AnrDnyU8HSC2A+9p
 pqzCGhj9uQQwQmR4hOxDz7vUZiM9Pxs+/YwAhsT0KyPkF0WTxKsJcAdlK2Q/bZ0HCVA3
 243+d6n7zE/CyHkBQemWE/LVJ9ntXgaV9EEVyXZTMX2k0V+Fjlj4H0jLthUFSKV3j5C8
 fCssOTJQQioz4zpbIRDlyYXNjoYOphBAZJF0riL1uzdYBejEsagdld3402YC9R0tBY6Z
 eKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777448336; x=1778053136;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tn4563GEryK2fgjkRMFSfzY80RGaQO5e7SL6sxz0APw=;
 b=H9FdkVhqqqIiEBkZz9dj3jnx56EueitVjYkjzcWZBKLL8SSFXSN3s0l+xGGQT17R1S
 maE5IbQuXDghWgmu4amDNjwZ9ADPPZK3kRXn+ItHZkZuRCYBYaSkPC9R22Sqnr515s/N
 LIEyxREQEE/wbb5uAwi/5IFWn9Tat6cx/O+jlle8c/CiBtxA4EksSDlinxeq0aXpp7hl
 yZTMc1WTaS20GA/CvdvyLiqGiNujJl8cxgwj4v3A+dDzCEymlmewKnVxPqQ7KvubYIEj
 UaIVOpIV6exfZXNDJ5jpvVuq6hM4aYVx8Fz7ZkKs83o2HMK65JItXBkfVKNLT57sFqSq
 AMBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XXBYA6EbTn02NOOh/G8gf5fNH8tChQR0VD72Er41VDCzt3yZ9ljY8pX/SJS0Ta6apc0TWDTiHfzMV@nongnu.org
X-Gm-Message-State: AOJu0YzEdY2uj/lwZ6ropYmY2yjYBy3isR7yXMIDNFsmtlov3nPosoZ4
 yZFCZHR8kkTURAuXEGTWfQpCpX1V+x9+jKwAVjjTXWvDz0PgXdc5mhWIfulHuQru6YI=
X-Gm-Gg: AeBDiesFjlufHLu8+sVFt8NwiRiSXM7Q35xpI4QBDgpIPPxBSNgclw+ISiphcSJt3CF
 dadTwotOQq63EfRXRaCt/tqODdIwbRrCJYP+eBi6dMkZi3BOTrWBpag/9JqU7k9UI5Z/OCK9U7a
 lNwMiIixdg/SQx3+i6M9kedq88dfsk5nXheLt8g84wm6ujZvdctmf7as01BZ1uj+XK49TwpT5ts
 d699EGQQ4o2gOvleHp7VdE6dPuTBtLfVJL0bbXzBZzDpnH4y4XhxDIYoJgQ4uR2pIPTZ3KodMeu
 MpvElXWa5GHs91u7EepkTsHF4O3tFn+vmGkpSCazIpEpBoRh6QBRMe+SYbnBB3Z5aEiaDKRk0tS
 l7bGIAUxHFuJgaPL553mBlpoS0zLCvpCbAVd2nT3ZfDlIn94QfyWkUpDjigcWjQVOlOqPfEMkSd
 xIEzC1Vo6Vn6aiz5IqlbVfNzu7te6qxAi7s/iG+yyQfu8aBLZTCW+dB//x8GJh+LZmAOR9jDzYm
 0CR
X-Received: by 2002:a05:6000:310b:b0:43f:ea91:63ff with SMTP id
 ffacd0b85a97d-4464761c07fmr11504671f8f.10.1777448336273; 
 Wed, 29 Apr 2026 00:38:56 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5afesm3359370f8f.30.2026.04.29.00.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 00:38:55 -0700 (PDT)
Message-ID: <22ce7f65-39ee-45cb-a021-ac275d036f38@linaro.org>
Date: Wed, 29 Apr 2026 09:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/npcm7xx_fiu: Specify .impl for
 npcm7xx_fiu_flash_ops
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260428093339.2087081-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/4/26 11:33, Peter Maydell wrote:
> Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
> means that it gets the default of "implements 1, 2 and 4 byte aligned
> accesses".  This is more constrained than the device permits in its
> .valid substruct, and also narrower than the functions are written to
> handle.
> 
> Add a .impl substruct matching the .valid substruct; this means that
> all guest accesses are handled directly by the read and write
> functions, and are never synthesized by the memory subsystem
> performing multiple accesses to the device (which would not behave
> correctly, as these read and write fucntions have side effects).

Typo "functions".

> 
> Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ssi/npcm7xx_fiu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> index 02707de350..2d5bed005a 100644
> --- a/hw/ssi/npcm7xx_fiu.c
> +++ b/hw/ssi/npcm7xx_fiu.c
> @@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
>       .read = npcm7xx_fiu_flash_read,
>       .write = npcm7xx_fiu_flash_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,

IMO this device should be adapted to have byte granularity ops handlers,
thus .max_access_size = 1.

> +        .unaligned = true,
> +    },
>       .valid = {
>           .min_access_size = 1,
>           .max_access_size = 8,


