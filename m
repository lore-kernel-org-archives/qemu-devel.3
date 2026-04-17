Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE50CF43695
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhyQ-0005dM-V5; Fri, 17 Apr 2026 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDhyK-0005ZP-3A
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:06:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDhyI-0006k5-9L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:06:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso6513815e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776427612; x=1777032412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hCdyTlCSQ+qsdrb4C2omNNEWgL5VkAyB7DrklKSduxs=;
 b=PGjTFkcp60suNTfkehUdL0HTnkjxXVyiexr6Gz/nk6f7OBFZ6QR9oPo65mgKuHb8UO
 6XZM6LtmgjYPOf4j4W1DgnVAFrFVs3WMI2xqixqimOwLIkheJLlb24p/SYCliUr8Cu8U
 sm3VFMe9QYJAUQ9adA0quY7WwkCbhXyuIJ9MUI8WqKANmYY4gghvz1ouKy+LuiwIMXEi
 acNTa2t9C8GwifSdolRYIY17Taqei0m4TINh+gvSn79i9BzlIAlkcXuhyIg4MtRvgnEN
 GbxZGDeseMIdz346WEewC1eTc8NpI2jCW6C+5u3Cr1oIW6Mx++ZagTdwJpkRUsAg6J3+
 e7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427612; x=1777032412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCdyTlCSQ+qsdrb4C2omNNEWgL5VkAyB7DrklKSduxs=;
 b=fXuqHxVjY9rETRKm/Ws2FrrpJFz650Uwm+3B5R+kTuoYrqyVLzRkQDj1viYw3+G/Zn
 TzNXiiO6HuVMcLN4lw8+zT6pkplw4emRD08vsQNPE/HaVRu7C2zp/+pjecV1rOOCs4Ks
 Cjnk9j2O2lAsclxm0nDL7u5T8t4WRE3tYbl+JEzRGQJL0bI7UO3yeHdNRGmDQXhturnD
 sfgnlT33oCnTuPFNquvR1xg+EkMlMRRqi7ho5nO8LV9zmYAHDJjn+/0SGMKrRNX9BUDt
 viZX6Y7PXWH2p4g52b7jkcdMS09Emro20FSq8FgQYqxl/39X9vj61HGvzy/wiPx3Yshx
 zwUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F0596pkFJxAmMrsM+MDAOrQwqnzTdZFQ4zi1ylS5uyO/abc7R9ISBS45KRNFPw4M+lIdc9FU07zo2@nongnu.org
X-Gm-Message-State: AOJu0YzXafVz1JjbILDLcmT5qovryWhu1+JKf1NlTx1P2zSp2uMuf9T2
 U9s4P/vief9R1JO/QltJb976KBXGZC3yWah6rjQkeVqQXlI01/zfqh0QKFCf85FAI20=
X-Gm-Gg: AeBDievI6xZDnxYrbH8TB4Fe6pWeFL90QWufjXri6/ArwvOjRRbs/2Dqvo6GZWgQYWQ
 71FE/xrnFJZmdabnEtg5SUTdehAfA4sHxMhg4R1/BbMPT3c3NhO3lo/vyNuPDWzbVjfwTcsPc1I
 ZwiUE+S8tF0UxOnT+CRoRngIDBFG5VCZB1vm1LCP70jLX65Yrpd5ShDrMSn8YPMRfWCJ/r9iedJ
 Xh8BpCB2BAnNHguJntSH7RTJWfc/e0CsvkuJqHZZCQoKMv+50KPXFT0LYB06MC38la2YoHtc2fQ
 H2Co9Xffj915bGtthYQ5LKgMNSD570f3ICg3olB+s2irLe0fCztpp/Y/CJEUEBmQaIDa0iFDBlG
 mUesf1zXD8/ojRQ3+IECqTISXTXA6Piw2hUsyh2y+OwZLctAMAOgX7gCcglXqSQiY3Pe+oyBigs
 3y1drP7inE5SgSpV8vAVEE6+vLjWcbqEvY6ngCz6jCS7ITM1VH7rb4pV7HWIMz9BEWeUr7sVy9w
 4/n
X-Received: by 2002:a05:600c:e40b:b0:487:1fbf:e0bb with SMTP id
 5b1f17b1804b1-488fb73d78amr29191125e9.6.1776427612389; 
 Fri, 17 Apr 2026 05:06:52 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78cddcsm20918655e9.4.2026.04.17.05.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 05:06:51 -0700 (PDT)
Message-ID: <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
Date: Fri, 17 Apr 2026 14:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] hw/sd/sdcard: Add erase-blocks-as-zero option.
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/4/26 11:51, Christian Speich wrote:
> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> them is wrong.
> 
> This patch does two things.
> 
> First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
> correctly reflect the content of erased blocks. We also increase the
> Product Revision (REV in CID) to indicate to the guest that
> DATA_STAT_AFTER_ERASE is now reliable.
> 
> Secondly, we introduce a erase-blocks-as-zero option, which allows the
> user to choose if erased blocks should contain 0xFF or 0x00. The default
> is still 0xFF to remain compatible with current users.

I'll update as:

   Secondly, we introduce a erase-blocks-as-zero option, which allows the
   user to choose if erased blocks should contain 0xFF or 0x00. While
   previous QEMU versions keep using the 'erase as 0xFF' pattern, the new
   default becomes the more efficient 'erase as 0x00'.

Does it look OK to you?

> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/core/machine.c |  5 +++++
>   hw/sd/sd.c        | 15 +++++++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e956693208d77fea6af5853ed4904234..54e4c05c96e3cf35ab2e702ee81fba36457cadd7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,11 @@
>   #include "hw/acpi/generic_event_device.h"
>   #include "qemu/audio.h"
>   
> +GlobalProperty hw_compat_11_0[] = {
> +    { "sdmmc-common", "erase-blocks-as-zero", "false" },
> +};
> +const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> +
>   GlobalProperty hw_compat_10_2[] = {
>       { "scsi-block", "migrate-pr", "off" },
>       { "isa-cirrus-vga", "global-vmstate", "true" },
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b27fed2e563e5971dd32787498eb8abed9ffe9be..0f997ed8cc80e38645101cb8f47c86f1c30d5a25 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c

> @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
>   
>   static const Property sdmmc_common_properties[] = {
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
> +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
> +                     true),
>   };

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


