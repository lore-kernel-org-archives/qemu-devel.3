Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D8EC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvoE-0007gE-Vc; Wed, 03 Jul 2024 04:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvo5-0007c1-Mg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:57:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvo4-0005cG-1s
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:57:41 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec595d0acbso63887391fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997057; x=1720601857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MudX4nfPVw/9SrxPbn/P79EDWfzvoY6Q7nVubap+Rz8=;
 b=CyhShQlc0WSEB3ieJrvtO7zXG47/Ge1LPNXT9sB6/uXqv9XMR/UhM5a8k41oa1NskL
 TTukeC0aZw+gc0j0DUrzNikH0jqVHeTvGLm+DNQt03b5Zzlu1xghJSK7xYEmYa/z5beB
 aRwUapqu/vaVCe0UfpvTCxheP7dO8/WFm14HvWun+nbwqLkzZPKm0iBZ6g4WZk9VKpgb
 3igz90AkF4quN1wWJCKxv/p4MJXOAsGwU8Vv0r+RSr9mR33xqcqqjZ4+zY6Tfdk/zRkz
 Xxje3Qc3O1ynsyP7tb/TYzOaq9jE1wsyy1A/tiA3UvTB7rlSi5G1qTwSorU2vzyrDS7l
 J7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997057; x=1720601857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MudX4nfPVw/9SrxPbn/P79EDWfzvoY6Q7nVubap+Rz8=;
 b=QSw4kSNRZ1AnFUWNj9SVmQ5GkGq4WiEzcOg/vAxhEkDEkSLNB/b/i5+KAL6zSBQ/uo
 Yg+wKpNRkY3vuCpKaoOl+aSb9IL2EK4IRucuL9oSL5RMCGuxoGR9hSC6NmQqEdVaruZI
 XVxVz4hRozQjxci4CrpWz2eJBU/lAFhiEUSsJgUiFKg9cH4MXX5YYEF8sQsr9nNlQcpE
 /EnGoOJZLPdGpg6MwisWAMCaJQXzkO5Pj63qGsGYVvpelbUpV5wZ+PYlsqhW3IM+BGfT
 zr2sIhY/CT4FpR1GchxxKmvouz08+jnZ+VBU9s+fpTAIQuPP+LlCitoWbsepiXiHBkXb
 g9vA==
X-Gm-Message-State: AOJu0Yw2Ly2JTACJW+lTFwECIheB+Pv6dXV+gQDmvWlH3Z8tZox/flgQ
 4xfMMx6JG8FF2PCf8e1dLyFovZ5y1Kejn5KcGce5hl1ZvwdypJPSvojdvXV3eDhrl/OjaUcGLXn
 G
X-Google-Smtp-Source: AGHT+IHDcYzUDeqZwyGBRH2sxZnyxYFjavd83RsKAbrCdWrl89XN3M8t2joAk3Kfxd4mT1TemOc0Fw==
X-Received: by 2002:a05:651c:2127:b0:2ee:594d:f54b with SMTP id
 38308e7fff4ca-2ee5e6f7781mr86181681fa.47.1719997055274; 
 Wed, 03 Jul 2024 01:57:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3cf90sm228039555e9.5.2024.07.03.01.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:57:34 -0700 (PDT)
Message-ID: <8c062034-e69b-4a73-b83b-0d9f8cc0c644@linaro.org>
Date: Wed, 3 Jul 2024 10:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v44 2/3] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Luc Michel <luc.michel@amd.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Yanan Wang <wangyanan55@huawei.com>
References: <20240703085148.66188-1-philmd@linaro.org>
 <20240703085148.66188-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703085148.66188-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 3/7/24 10:51, Philippe Mathieu-Daudé wrote:
> "General command" (GEN_CMD, CMD56) is described as:
> 
>    GEN_CMD is the same as the single block read or write
>    commands (CMD24 or CMD17). The difference is that [...]
>    the data block is not a memory payload data but has a
>    vendor specific format and meaning.
> 
> Thus this block must not be stored overwriting data block
> on underlying storage drive. Keep it in a dedicated
> 'vendor_data[]' array.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v43: Do not re-use VMSTATE_UNUSED_V (danpb)
> v44: Use subsection (Luc)
> ---
>   hw/sd/sd.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 808dc1cea6..000b923c73 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -153,6 +153,8 @@ struct SDState {
>       uint32_t data_offset;
>       size_t data_size;
>       uint8_t data[512];
> +    uint8_t vendor_data[512];
> +
>       qemu_irq readonly_cb;
>       qemu_irq inserted_cb;
>       QEMUTimer *ocr_power_timer;
> @@ -719,6 +721,7 @@ static void sd_reset(DeviceState *dev)
>       sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
>       sd->wp_group_bits = sect;
>       sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
> +    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
>       memset(sd->function_group, 0, sizeof(sd->function_group));
>       sd->erase_start = INVALID_ADDRESS;
>       sd->erase_end = INVALID_ADDRESS;
> @@ -793,6 +796,16 @@ static const VMStateDescription sd_ocr_vmstate = {
>       },
>   };
>   
> +static const VMStateDescription sd_vendordata_vmstate = {
> +    .name = "sd-card/vendor_data-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static int sd_vmstate_pre_load(void *opaque)
>   {
>       SDState *sd = opaque;
> @@ -840,6 +853,7 @@ static const VMStateDescription sd_vmstate = {
>       },
>       .subsections = (const VMStateDescription * const []) {
>           &sd_ocr_vmstate,
> +        &sd_vendordata_vmstate,
>           NULL
>       },
>   };

Sigh, forgot to squash:

-- >8 --
@@ -919,3 +918,0 @@ static void sd_blk_write(SDState *sd, uint64_t addr, 
uint32_t len)
-#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
-#define APP_WRITE_BLOCK(a, len)
-
---

> @@ -2187,9 +2201,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
>           break;
>   
>       case 56:  /* CMD56:  GEN_CMD */
> -        sd->data[sd->data_offset ++] = value;
> -        if (sd->data_offset >= sd->blk_len) {
> -            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
> +        sd->vendor_data[sd->data_offset++] = value;
> +        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>               sd->state = sd_transfer_state;
>           }
>           break;
> @@ -2261,12 +2274,11 @@ uint8_t sd_read_byte(SDState *sd)
>           break;
>   
>       case 56:  /* CMD56:  GEN_CMD */
> -        if (sd->data_offset == 0)
> -            APP_READ_BLOCK(sd->data_start, sd->blk_len);
> -        ret = sd->data[sd->data_offset ++];
> +        ret = sd->vendor_data[sd->data_offset++];
>   
> -        if (sd->data_offset >= sd->blk_len)
> +        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>               sd->state = sd_transfer_state;
> +        }
>           break;
>   
>       default:


