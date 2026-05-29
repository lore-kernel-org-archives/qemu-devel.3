Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7818DCD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqWv-0000Js-3U; Fri, 29 May 2026 02:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqWs-0000Iu-K8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:17:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqWq-0003dL-Gj
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:17:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso44781145e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 23:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780035427; x=1780640227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pjk8Lw2E5d3TU/t5HrOgXETIz7oSMHwYPw4UMXmpoqs=;
 b=KKGE9AEi34a5u7b35lG2xXjkpy1ljsdoBlBXHx7oxyKsdUNEWsNLV/zMQBclXoqNJG
 nBxMAyKWFavsnn/VHaadD3gqFCPWil1N05ZpVPGjF51xsMvdogmUaBvF3gJb72QtSYOQ
 Zwn0MRwr3uCMWVthqxBH76oO1QCeBLytn4pJnL2haQXbOMnIh/OiF9DAc7uNl/WBLsy6
 AhuXB1EB6PZ3YnSqe+2MXcfafIwjBqztAiMQ9lldacngFyDxtQA3hg18hLKAIq6x3Cxe
 8x3jrblEXFuQ9LS5RPUXicJ53+rGlABF5ZUnqLvma19WsoX43WHXd66M4H/BVm4boQLe
 g5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780035427; x=1780640227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pjk8Lw2E5d3TU/t5HrOgXETIz7oSMHwYPw4UMXmpoqs=;
 b=RVEMaJbCCG8uNZruIqVOUe2W9MXkcV1uGUEMOhenXgkzwn0yeoATtANi2dcX/nYbS0
 n3121RdXFs4E/QRpies/YeD0LsDimLsvuEeGtLrnrJ6grqLXQ3w21W8R0Cr7lnIJBF7j
 iiSGk+ZJKXjD6oXUb83Ha9SirkwY0ViXgX7zwvYBufAeOmZ68EgorLrXKFaeFA4CXsoS
 a7t35kT8zux1twNIolgu+fNoo8t+LuHqRkD6UglfEEaIuI8V/PPdeIOYboOcRvTF5bZs
 e6lvAtOQHlBqJhu5d7kH3jAVzto70kOPAUT+hG5MEpMO9b2nDGT/3lA4NcQETflFdUQv
 fKFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/wR9WaaQdbzI30E6DDEDrPyyj213FWhBryRXwLhW0UmAThsgPTBAYcSN2qTI+Zdx3bUNHqw8tDOAk@nongnu.org
X-Gm-Message-State: AOJu0YziLQqy7v9Zdld6nfwVxC0KpAcuA8wn6kmTb8vwAPo8r2hTfM0Z
 pdr6L61K6t872O7MKMk1tR6AXwy0vrW00Hl5EZVv1leSGhQuurgxzlxUIBHNPLkA+2o=
X-Gm-Gg: Acq92OHQErMimL8SCZuaENOv3XuFtZEQ/Vl8iMkoiiaRMs0vLpnPFxkwRJ3wJVuKkcx
 EWt9Jug4iGC/4Wym7hxRhQ40vsNHZdhkeZB1jxitY1CEjYLuLhN7mBwRHAV0j92b5/OiiY3sPrx
 qU2/b7dshCjs0BiJsaq4EnIJoklqi581qPbk9peVzJIo/0Afc3+2jdo6zDi6e2/DLBnoO1PgOA9
 yl02h/3jqMMkMghFxU0AUstyj37+HbvYOVMc3SJioPInWhoOD15OaFhAtUq782+fIrij0uFF9CU
 +NLCQuRwRdy7zGipyRRTtC7H12etshYFVVMQXWtm0/eBQ5EtN3HZ4Hm2y75pHU/Vjk6V0EVTA2R
 Bs1h1SkKaj+F1nQntGBgwKUNNQLw7MkBsMc7WWwuYnZJ3l/zAazvM1wgIiLqvvPyjdM9UqWYpUJ
 E6O3gZ/R/GroZjR3P8O/KGZfK+rIAYAltGNo2NivrlKzbAHhlt9x4lHV1Mq0+a4cJJBsTOq826F
 ie8
X-Received: by 2002:a05:600c:41c5:b0:490:482c:437e with SMTP id
 5b1f17b1804b1-4909c0beb44mr13638155e9.23.1780035426509; 
 Thu, 28 May 2026 23:17:06 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0e8c1bsm9276675e9.3.2026.05.28.23.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 23:17:05 -0700 (PDT)
Message-ID: <4b1e3557-246f-4218-b14c-b4191f899aff@linaro.org>
Date: Fri, 29 May 2026 08:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i3c: rename DW-I3C queue capacity fields from
 _bytes to _words
Content-Language: en-US
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, clg@kaod.org,
 jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260529014034.864722-3-jithu.joseph@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529014034.864722-3-jithu.joseph@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Hi,

On 29/5/26 03:40, Jithu Joseph wrote:
> The cmd/resp, tx/rx, and IBI queue capacity values are passed straight
> to fifo32_create(), which interprets its capacity argument as a 32-bit
> word count.  The fields and device properties were therefore misnamed.
> 
> Rename the three struct fields and matching device-property strings:
> 
>    cmd_resp_queue_capacity_bytes  -> cmd_resp_queue_capacity_words
>    tx_rx_queue_capacity_bytes     -> tx_rx_queue_capacity_words
>    ibi_queue_capacity_bytes       -> ibi_queue_capacity_words
> 
> Defaults are unchanged (0x10 / 0x40 / 0x10) -- they were being
> interpreted correctly by fifo32_create all along, just under a
> misleading label.  No behavioral change.
> 
> aspeed_i3c.c only sets "device-id" on its child DWI3C objects and
> nothing else references these properties in the tree, so no external
> callers need updating.  vmstate_dw_i3c migrates only the regs[] array,
> not cfg.*, so there are no migration-compat concerns either.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
> ---
>   include/hw/i3c/dw-i3c.h |  6 +++---
>   hw/i3c/dw-i3c.c         | 24 ++++++++++++------------
>   2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
> index d26f60580f02..391470207c43 100644
> --- a/include/hw/i3c/dw-i3c.h
> +++ b/include/hw/i3c/dw-i3c.h
> @@ -181,9 +181,9 @@ struct DWI3C {
>   
>       struct {
>           uint8_t id;
> -        uint8_t cmd_resp_queue_capacity_bytes;
> -        uint16_t tx_rx_queue_capacity_bytes;
> -        uint8_t ibi_queue_capacity_bytes;
> +        uint8_t cmd_resp_queue_capacity_words;
> +        uint16_t tx_rx_queue_capacity_words;
> +        uint8_t ibi_queue_capacity_words;
>           uint8_t num_addressable_devices;
>           uint16_t dev_addr_table_pointer;
>           uint16_t dev_addr_table_depth;
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index e1bcf083210b..4ea80e8352c6 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1806,14 +1806,14 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
>                             DW_I3C_NR_REGS << 2);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>   
> -    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);
> -    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
> -    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
> -    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
> -    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);
> +    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_words);
> +    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_words);
> +    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_words);
> +    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_words);
> +    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_words);
>       /* Arbitrarily large enough to not be an issue. */
>       fifo8_create(&s->ibi_data.ibi_intermediate_queue,
> -                 s->cfg.ibi_queue_capacity_bytes * 8);
> +                 s->cfg.ibi_queue_capacity_words * 8);
>   
>       s->bus = i3c_init_bus(DEVICE(s), name);
>       I3CBusClass *bc = I3C_BUS_GET_CLASS(s->bus);
> @@ -1824,12 +1824,12 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
>   
>   static const Property dw_i3c_properties[] = {
>       DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
> -    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
> -                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
> -    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
> -                      cfg.tx_rx_queue_capacity_bytes, 0x40),
> -    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,
> -                      cfg.ibi_queue_capacity_bytes, 0x10),
> +    DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
> +                      cfg.cmd_resp_queue_capacity_words, 0x10),
> +    DEFINE_PROP_UINT16("tx-rx-queue-capacity-words", DWI3C,
> +                      cfg.tx_rx_queue_capacity_words, 0x40),
> +    DEFINE_PROP_UINT8("ibi-queue-capacity-words", DWI3C,
> +                      cfg.ibi_queue_capacity_words, 0x10),

Properties are user exposed, should we keep deprecated aliases?

>       DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
>                         cfg.num_addressable_devices, 8),
>       DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,


