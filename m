Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF30DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwBK-0004Lu-Is; Mon, 03 Nov 2025 10:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFwBA-0004Kh-Le
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:09:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFwB2-0001EJ-OE
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:09:08 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475db4ad7e4so16901695e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762182536; x=1762787336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9hByJJJGkGOmPS+oVZXX3xIzAPldebvQnv9cNezO5vo=;
 b=hZFSoMmcEMMiE44/LlDEWIxFUw1fOvJPLrLqaF30bKlicgeBesPgmWkxzFhZcVrbsp
 oFGfY7P2DbeZTHYq/NmWLkdm1I0BEVo/2DvGxf1Q/vrMhiAUeFCtPO4wS5V3UFtcYzWR
 FBDl3jyASbp47ArMWYFG5dAYGKfixFAl/vv5anW6g/uZE9IqhMN9nqPqO7U/r0VJCrFe
 RJz9qTbauukEwd2lmqqmVxN6+KYt7HeA3Mt1aWp/NFPL9d4CLdaBGh1cFJirZb8M/dJC
 QGik8sPN7LjCzKG00Z4mZVL+0Mug3S8TJw5plVMf99t1+5bOpyuhZEJ+xLj++fYmtzEg
 29kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762182536; x=1762787336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hByJJJGkGOmPS+oVZXX3xIzAPldebvQnv9cNezO5vo=;
 b=LlBL7CHJLDs2m8vhwF5xiCDIr43X0fMi14Ed0MjLqzMf1EJy7oOE/ijbNMOCikFGA9
 Wa4U1BYwSCwEsnjtVxnwFv6ORc7wRcJRnC47/6mGScG+vDGYhtklYsej8txNQl2QD/uE
 eBSuu3UYG6Rs+MLNNAg4NdEgwRewfj27BlQCZNJWx/IwThZxTSoJofUhH5QcQC3Zef2X
 NY3WdwM3oWvLIcTEJJBFuJmvc522TZGrdhf5iHfAw/Z0fZXNt1nLlt7D+2kbPqN1fKkM
 8G7mBjsBbjmaJdrMJ/bHY5Fad8uJpWWUPlaARsOBG/WlIfzKBOUq/b4jngUF5HipOZ1h
 kbbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq2sQaHffcAv4OBk2sHsTV4cD+ajCgiaX6ld54m1sfG2kEc7H4MdyVxYGR+evlMm3bpAa3ebmww+w9@nongnu.org
X-Gm-Message-State: AOJu0Yzcr5+oK2T1hmonB4WtpiEjvG79UvDhzFfHxhnbzJ/bMHItuWZH
 iCrF0f3LLpzlxblpFqLeahu5sVKcqBqiFSWWy2TFt84Mi89xpv/w2yxupDgdFWhvJJaQSH1DfMw
 gAPO0pJr0XwBB
X-Gm-Gg: ASbGncsBqSJsq24Vd5xSwmjbXgaalSPfAkZQLRBhHzlxweal5/tDb6cFKcJ4ltDLPGf
 19XftbSC0dLzpVWpMck6b+ED645ejsBBkw7e4GlHQ118XQFPU1brmhCPDYEE+P1WmMXoEv9prUS
 5A1PAq1G60i13oG4NGv7RCr298w8wvy23RkYvneMNFCOoPwgb8O3hFuAj6n5dcKF1wNKeuGNtDF
 b6rPrKulCKrfDJG3/VlU5RxkYCDqe4QoUhS82mzA8e2ollgXUkcZWqNkPzLwyqq5xDVxfShKwEB
 V9Ee//Egx8cftRylHVi3Su7fyIKgMBqcA3R9j4K3KArXPokeP6saPWC9mkyuB1uUFfWUzQ5RbeD
 o0bziRLSOKzfPaj+o+7OE/85PORLlVY6FMlsZ5iKKIqZwaCP5k+u9NcLMeq7/o/QfHP2KgKoWtl
 +GM0ALN/7Lu6en9lJwx2lrztP7agXeIFvhfr1PbOSEtPX7kMP77UzSQJN4KmxDsSU=
X-Google-Smtp-Source: AGHT+IEQubqUgViXxZk2d3C6OLDvcU4ovSSpuVOMOMHnlXP4xwKBwKyeYAdYcvy6pGXL4cEHf6fstA==
X-Received: by 2002:a05:600c:4506:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-477308aac93mr105421115e9.20.1762182535632; 
 Mon, 03 Nov 2025 07:08:55 -0800 (PST)
Received: from [172.18.140.215] (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c374f84sm158928535e9.0.2025.11.03.07.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 07:08:55 -0800 (PST)
Message-ID: <66a62dd7-e4b7-407a-8402-8b9b5b08833e@linaro.org>
Date: Mon, 3 Nov 2025 16:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] hw/sd/sdcard: Add basic support for RPMB partition
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <091d69e0e15b951f6110938c8ebffc988204f52c.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <091d69e0e15b951f6110938c8ebffc988204f52c.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Jan,

On 17/10/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The Replay Protected Memory Block (RPMB) is available since eMMC 4.4
> which has been obsoleted by 4.41. Therefore lift the provided
> EXT_CSD_REV to 5 (4.41) and provide the basic logic to implement basic
> support for it. This allows to set the authentication key, read the
> write counter and authenticated perform data read and write requests.
> Those aren't actually authenticated yet, support for that will be added
> later.
> 
> The RPMB image needs to be added to backing block images after potential
> boot partitions and before the user data. It's size is controlled by
> the rpmb-partition-size property.
> 
> Also missing in this version (and actually not only for RPMB bits) is
> persistence of registers that are supposed to survive power cycles. Most
> prominent are the write counters or the authentication key. This feature
> can be added later, e.g. by append a state structure to the backing
> block image.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c             | 206 +++++++++++++++++++++++++++++++++++++++--
>   hw/sd/sdmmc-internal.h |  21 +++++
>   hw/sd/trace-events     |   2 +
>   3 files changed, 221 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 305ea251cb..918fe9f79f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -117,6 +117,20 @@ typedef struct SDProto {
>       } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
>   } SDProto;
>   

   #define RPMB_STUFF_LEN      196

> +#define RPMB_KEY_MAC_LEN    32
> +
> +typedef 

QEMU_PACKED (better safe than sorry).

> struct {
> +    uint8_t stuff_bytes[196];
> +    uint8_t key_mac[RPMB_KEY_MAC_LEN];
> +    uint8_t data[256];
> +    uint8_t nonce[16];
> +    uint32_t write_counter;
> +    uint16_t address;
> +    uint16_t block_count;
> +    uint16_t result;
> +    uint16_t req_resp;
> +} RPMBDataFrame;
> +
>   struct SDState {
>       DeviceState parent_obj;
>   
> @@ -140,6 +154,7 @@ struct SDState {
>   
>       uint8_t spec_version;
>       uint64_t boot_part_size;
> +    uint64_t rpmb_part_size;
>       BlockBackend *blk;
>       uint8_t boot_config;
>   
> @@ -172,6 +187,10 @@ struct SDState {
>       uint32_t data_offset;
>       size_t data_size;
>       uint8_t data[512];
> +    RPMBDataFrame rpmb_result;
> +    uint32_t rpmb_write_counter;
> +    uint8_t rpmb_key[32];
> +    uint8_t rpmb_key_set;

Matter of style:

        struct {
            uint32_t write_counter;
            uint8_t key[RPMB_KEY_MAC_LEN];
            uint8_t key_set;
            RPMBDataFrame result;
        } rpmb;

>       QEMUTimer *ocr_power_timer;
>       uint8_t dat_lines;
>       bool cmd_line;
> @@ -506,7 +525,9 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
>       sd->ext_csd[205] = 0x46; /* Min read perf for 4bit@26Mhz */
>       sd->ext_csd[EXT_CSD_CARD_TYPE] = 0b11;
>       sd->ext_csd[EXT_CSD_STRUCTURE] = 2;
> -    sd->ext_csd[EXT_CSD_REV] = 3;
> +    sd->ext_csd[EXT_CSD_REV] = 5;
> +    sd->ext_csd[EXT_CSD_RPMB_MULT] = sd->rpmb_part_size / (128 * KiB);
> +    sd->ext_csd[EXT_CSD_PARTITION_SUPPORT] = 0b111;
>   
>       /* Mode segment (RW) */
>       sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
> @@ -834,7 +855,8 @@ static uint32_t sd_blk_len(SDState *sd)
>   /*
>    * This requires a disk image that has two boot partitions inserted at the
>    * beginning of it, followed by an RPMB partition. The size of the boot
> - * partitions is the "boot-partition-size" property.
> + * partitions is the "boot-partition-size" property, the one of the RPMB
> + * partition is 'rpmb-partition-size'.
>    */
>   static uint32_t sd_part_offset(SDState *sd)
>   {
> @@ -848,11 +870,13 @@ static uint32_t sd_part_offset(SDState *sd)
>                                    & EXT_CSD_PART_CONFIG_ACC_MASK;
>       switch (partition_access) {
>       case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
> -        return sd->boot_part_size * 2;
> +        return sd->boot_part_size * 2 + sd->rpmb_part_size;
>       case EXT_CSD_PART_CONFIG_ACC_BOOT1:
>           return 0;
>       case EXT_CSD_PART_CONFIG_ACC_BOOT2:
>           return sd->boot_part_size * 1;
> +    case EXT_CSD_PART_CONFIG_ACC_RPMB:
> +        return sd->boot_part_size * 2;
>       default:
>            g_assert_not_reached();
>       }
> @@ -891,7 +915,7 @@ static void sd_reset(DeviceState *dev)
>       }
>       size = sect << HWBLOCK_SHIFT;
>       if (sd_is_emmc(sd)) {
> -        size -= sd->boot_part_size * 2;
> +        size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
>       }
>   
>       sect = sd_addr_to_wpnum(size) + 1;
> @@ -979,6 +1003,34 @@ static const VMStateDescription sd_ocr_vmstate = {
>       },
>   };
>   
> +static bool vmstate_needed_for_rpmb(void *opaque)
> +{
> +    SDState *sd = opaque;
> +
> +    return sd->rpmb_part_size > 0;
> +}
> +
> +static const VMStateDescription emmc_rpmb_vmstate = {
> +    .name = "sd-card/ext_csd_modes-state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_needed_for_rpmb,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState, RPMB_KEY_MAC_LEN),
> +        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, 256),
> +        VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
> +        VMSTATE_UINT32(rpmb_result.write_counter, SDState),
> +        VMSTATE_UINT16(rpmb_result.address, SDState),
> +        VMSTATE_UINT16(rpmb_result.block_count, SDState),
> +        VMSTATE_UINT16(rpmb_result.result, SDState),
> +        VMSTATE_UINT16(rpmb_result.req_resp, SDState),
> +        VMSTATE_UINT32(rpmb_write_counter, SDState),
> +        VMSTATE_UINT8_ARRAY(rpmb_key, SDState, 32),
> +        VMSTATE_UINT8(rpmb_key_set, SDState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static bool vmstate_needed_for_emmc(void *opaque)
>   {
>       SDState *sd = opaque;
> @@ -1045,6 +1097,7 @@ static const VMStateDescription sd_vmstate = {
>       .subsections = (const VMStateDescription * const []) {
>           &sd_ocr_vmstate,
>           &emmc_extcsd_vmstate,
> +        &emmc_rpmb_vmstate,
>           NULL
>       },
>   };
> @@ -1067,6 +1120,105 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>       }
>   }
>   
> +static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
> +{
> +    uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
> +    uint16_t result = be16_to_cpu(sd->rpmb_result.result);
> +    unsigned int curr_block = 0;
> +
> +    if ((result & ~RPMB_RESULT_COUTER_EXPIRED) == RPMB_RESULT_OK &&
> +        resp == RPMB_RESP(RPMB_REQ_AUTH_DATA_READ)) {
> +        curr_block = be16_to_cpu(sd->rpmb_result.address);
> +        if (sd->rpmb_result.block_count == 0) {
> +            sd->rpmb_result.block_count = cpu_to_be16(sd->multi_blk_cnt);
> +        } else {
> +            curr_block += be16_to_cpu(sd->rpmb_result.block_count) -
> +                sd->multi_blk_cnt;
> +        }
> +        addr = curr_block * 256 + sd_part_offset(sd);
> +        if (blk_pread(sd->blk, addr, 256, sd->rpmb_result.data, 0) < 0) {

Would be nice to re-use sd_blk_read(), but I notice we want to read the
frame data to then copy the whole message into sd->data.

> +            fprintf(stderr, "sd_blk_read: read error on host side\n");

Although a pre-existing pattern in this file, no new fprintf(stderr)
please. Better use the Error* API, otherwise error_report().

               error_report("sd_blk_read: read error on host side");

> +            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
> +                (result & RPMB_RESULT_COUTER_EXPIRED));
> +        }
> +    }
> +    memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
> +
> +    trace_sdcard_rpmb_read_block(resp, curr_block,
> +                                 be16_to_cpu(sd->rpmb_result.result));
> +}
> +
> +static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
> +{
> +    RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
> +    uint16_t req = be16_to_cpu(frame->req_resp);
> +
> +    if (req == RPMB_REQ_READ_RESULT) {
> +        /* just return the current result register */
> +        goto exit;
> +    }
> +    memset(&sd->rpmb_result, 0, sizeof(sd->rpmb_result));
> +    memcpy(sd->rpmb_result.nonce, frame->nonce, sizeof(sd->rpmb_result.nonce));
> +    sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_OK);
> +    sd->rpmb_result.req_resp = cpu_to_be16(RPMB_RESP(req));
> +
> +    if (!sd->rpmb_key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
> +        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
> +        goto exit;
> +    }
> +
> +    switch (req) {
> +    case RPMB_REQ_PROGRAM_AUTH_KEY:
> +        if (sd->rpmb_key_set) {
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +            break;
> +        }
> +        memcpy(sd->rpmb_key, frame->key_mac, sizeof(sd->rpmb_key));
> +        sd->rpmb_key_set = 1;
> +        break;
> +    case RPMB_REQ_READ_WRITE_COUNTER:
> +        sd->rpmb_result.write_counter = cpu_to_be32(sd->rpmb_write_counter);
> +        break;
> +    case RPMB_REQ_AUTH_DATA_WRITE:
> +        /* We only support single-block writes so far */
> +        if (sd->multi_blk_cnt != 1) {
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> +            break;
> +        }
> +        if (sd->rpmb_write_counter == 0xffffffff) {
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +            break;
> +        }
> +        if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
> +            break;
> +        }
> +        sd->rpmb_result.address = frame->address;
> +        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
> +        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
> +            fprintf(stderr, "sd_blk_write: write error on host side\n");

                error_report("sd_blk_write: write error on host side");

> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
> +        } else {
> +            sd->rpmb_write_counter++;
> +        }
> +        sd->rpmb_result.write_counter = cpu_to_be32(sd->rpmb_write_counter);
> +        break;
> +    case RPMB_REQ_AUTH_DATA_READ:
> +        sd->rpmb_result.address = frame->address;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "RPMB request %d not implemented\n", req);
> +        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
> +        break;
> +    }
> +exit:
> +    if (sd->rpmb_write_counter == 0xffffffff) {
> +        sd->rpmb_result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
> +    }
> +    trace_sdcard_rpmb_write_block(req, be16_to_cpu(sd->rpmb_result.result));
> +}
> +
>   static void sd_erase(SDState *sd)
>   {
>       uint64_t erase_start = sd->erase_start;
> @@ -1180,6 +1332,19 @@ static void emmc_function_switch(SDState *sd, uint32_t arg)
>           break;
>       }
>   
> +    if (index == EXT_CSD_PART_CONFIG) {
> +        uint8_t part = b & EXT_CSD_PART_CONFIG_ACC_MASK;
> +
> +        if (((part == EXT_CSD_PART_CONFIG_ACC_BOOT1 ||
> +              part == EXT_CSD_PART_CONFIG_ACC_BOOT2) && !sd->boot_part_size) ||
> +            (part == EXT_CSD_PART_CONFIG_ACC_RPMB && !sd->rpmb_part_size)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "MMC switching to illegal partition\n");
> +            sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
> +            return;
> +        }
> +    }
> +
>       trace_sdcard_ext_csd_update(index, sd->ext_csd[index], b);
>       sd->ext_csd[index] = b;
>   }
> @@ -2378,6 +2543,7 @@ static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>   
>   static void sd_write_byte(SDState *sd, uint8_t value)
>   {
> +    unsigned int partition_access;
>       int i;
>   
>       if (!sd->blk || !blk_is_inserted(sd->blk)) {
> @@ -2427,7 +2593,13 @@ static void sd_write_byte(SDState *sd, uint8_t value)
>           if (sd->data_offset >= sd->blk_len) {
>               /* TODO: Check CRC before committing */
>               sd->state = sd_programming_state;
> -            sd_blk_write(sd, sd->data_start, sd->data_offset);
> +            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
> +                    & EXT_CSD_PART_CONFIG_ACC_MASK;
> +            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +                emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
> +            } else {
> +                sd_blk_write(sd, sd->data_start, sd->data_offset);
> +            }
>               sd->blk_written++;
>               sd->data_start += sd->blk_len;
>               sd->data_offset = 0;
> @@ -2510,6 +2682,7 @@ static uint8_t sd_read_byte(SDState *sd)
>   {
>       /* TODO: Append CRCs */
>       const uint8_t dummy_byte = 0x00;
> +    unsigned int partition_access;
>       uint8_t ret;
>       uint32_t io_len;
>   
> @@ -2553,7 +2726,13 @@ static uint8_t sd_read_byte(SDState *sd)
>                                     sd->data_start, io_len)) {
>                   return dummy_byte;
>               }
> -            sd_blk_read(sd, sd->data_start, io_len);
> +            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
> +                    & EXT_CSD_PART_CONFIG_ACC_MASK;
> +            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> +                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
> +            } else {
> +                sd_blk_read(sd, sd->data_start, io_len);
> +            }
>           }
>           ret = sd->data[sd->data_offset ++];
>   
> @@ -2805,7 +2984,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>           blk_size = blk_getlength(sd->blk);
>       }
>       if (blk_size >= 0) {
> -        blk_size -= sd->boot_part_size * 2;
> +        blk_size -= sd->boot_part_size * 2 + sd->rpmb_part_size;
>           if (blk_size > SDSC_MAX_CAPACITY) {
>               if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) != 0) {
>                   int64_t blk_size_aligned =
> @@ -2844,13 +3023,23 @@ static void sd_realize(DeviceState *dev, Error **errp)
>                             "The boot partition size must be multiples of 128K"
>                             "and not larger than 32640K.\n");
>       }
> +    if (sd->rpmb_part_size % (128 * KiB) ||
> +        sd->rpmb_part_size > 128 * 128 * KiB) {
> +        char *size_str = size_to_str(sd->boot_part_size);
> +
> +        error_setg(errp, "Invalid RPMB partition size: %s", size_str);
> +        g_free(size_str);
> +        error_append_hint(errp,
> +                          "The RPMB partition size must be multiples of 128K"
> +                          "and not larger than 16384K.\n");
> +    }
>   }
>   
>   static void emmc_realize(DeviceState *dev, Error **errp)
>   {
>       SDState *sd = SDMMC_COMMON(dev);
>   
> -    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.3 */
> +    sd->spec_version = SD_PHY_SPECv3_01_VERS; /* Actually v4.5 */
>   
>       sd_realize(dev, errp);
>   }
> @@ -2867,6 +3056,7 @@ static const Property sd_properties[] = {
>   static const Property emmc_properties[] = {
>       DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
>       DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
> +    DEFINE_PROP_UINT64("rpmb-partition-size", SDState, rpmb_part_size, 0),
>   };
>   
>   static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index ce6bc4e6ec..c4a9aa8edf 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -118,9 +118,30 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, SDMMC_COMMON, TYPE_SDMMC_COMMON)
>   #define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
>   #define EXT_CSD_PART_CONFIG_ACC_BOOT1           (0x1)
>   #define EXT_CSD_PART_CONFIG_ACC_BOOT2           (0x2)
> +#define EXT_CSD_PART_CONFIG_ACC_RPMB            (0x3)
>   
>   #define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
>   #define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
>   #define EXT_CSD_PART_CONFIG_EN_USER             (0x7 << 3)
>   
> +#define RPMB_REQ_PROGRAM_AUTH_KEY       (1)
> +#define RPMB_REQ_READ_WRITE_COUNTER     (2)
> +#define RPMB_REQ_AUTH_DATA_WRITE        (3)
> +#define RPMB_REQ_AUTH_DATA_READ         (4)
> +#define RPMB_REQ_READ_RESULT            (5)
> +#define RPMB_REQ_AUTH_CONFIG_WRITE      (6)
> +#define RPMB_REQ_AUTH_CONFIG_READ       (7)
> +
> +#define RPMB_RESP(__req__)              ((__req__) << 8)
> +
> +#define RPMB_RESULT_OK                  (0)
> +#define RPMB_RESULT_GENERAL_FAILURE     (1)
> +#define RPMB_RESULT_AUTH_FAILURE        (2)
> +#define RPMB_RESULT_COUNTER_FAILURE     (3)
> +#define RPMB_RESULT_ADDRESS_FAILURE     (4)
> +#define RPMB_RESULT_WRITE_FAILURE       (5)
> +#define RPMB_RESULT_READ_FAILURE        (6)
> +#define RPMB_RESULT_NO_AUTH_KEY         (7)

> +#define RPMB_RESULT_COUTER_EXPIRED      (0x80)
> +
>   #endif

If you are OK, I'd like to squash:

-- >8 --diff --git a/hw/sd/sd.c b/hw/sd/sd.c
diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index c4a9aa8edf6..c115f472efe 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -144,2 +144,3 @@ DECLARE_OBJ_CHECKERS(SDState, SDCardClass, 
SDMMC_COMMON, TYPE_SDMMC_COMMON)
  #define RPMB_RESULT_NO_AUTH_KEY         (7)
+
  #define RPMB_RESULT_COUTER_EXPIRED      (0x80)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f8883860fb1..ac8f6b94746 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -119,8 +119,10 @@ typedef struct SDProto {

+#define RPMB_STUFF_LEN      196
  #define RPMB_KEY_MAC_LEN    32
+#define RPMB_DATA_LEN       256     /* one RPMB block is half a sector */

-typedef struct {
-    uint8_t stuff_bytes[196];
+typedef struct QEMU_PACKED {
+    uint8_t stuff_bytes[RPMB_STUFF_LEN];
      uint8_t key_mac[RPMB_KEY_MAC_LEN];
-    uint8_t data[256];
+    uint8_t data[RPMB_DATA_LEN];
      uint8_t nonce[16];
@@ -133,2 +135,5 @@ typedef struct {

+QEMU_BUILD_BUG_MSG(sizeof(RPMBDataFrame) != 512,
+                   "invalid RPMBDataFrame size");
+
  struct SDState {
@@ -191,3 +196,3 @@ struct SDState {
      uint32_t rpmb_write_counter;
-    uint8_t rpmb_key[32];
+    uint8_t rpmb_key[RPMB_KEY_MAC_LEN];
      uint8_t rpmb_key_set;
@@ -1019,3 +1024,3 @@ static const VMStateDescription emmc_rpmb_vmstate = {
          VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState, 
RPMB_KEY_MAC_LEN),
-        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, 256),
+        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, RPMB_DATA_LEN),
          VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
@@ -1137,5 +1142,6 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
          }
-        addr = curr_block * 256 + sd_part_offset(sd);
-        if (blk_pread(sd->blk, addr, 256, sd->rpmb_result.data, 0) < 0) {
-            fprintf(stderr, "sd_blk_read: read error on host side\n");
+        addr = curr_block * RPMB_DATA_LEN + sd_part_offset(sd);
+        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
+                      sd->rpmb_result.data, 0) < 0) {
+            error_report("sd_blk_read: read error on host side");
              memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
@@ -1197,5 +1203,5 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
          sd->rpmb_result.address = frame->address;
-        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
-        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
-            fprintf(stderr, "sd_blk_write: write error on host side\n");
+        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN + 
sd_part_offset(sd);
+        if (blk_pwrite(sd->blk, addr, RPMB_DATA_LEN, frame->data, 0) < 0) {
+            error_report("sd_blk_write: write error on host side");
              sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
@@ -3027,3 +3033,3 @@ static void sd_realize(DeviceState *dev, Error **errp)
      }
-    if (sd->rpmb_part_size % (128 * KiB) ||
+    if (!QEMU_IS_ALIGNED(sd->rpmb_part_size, 128 * KiB) ||
          sd->rpmb_part_size > 128 * 128 * KiB) {
---

And on top, if you don't mind (but can do that later):

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ac8f6b94746..71f396cb4d6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -195,4 +195,6 @@ struct SDState {
-    RPMBDataFrame rpmb_result;
-    uint32_t rpmb_write_counter;
-    uint8_t rpmb_key[RPMB_KEY_MAC_LEN];
-    uint8_t rpmb_key_set;
+    struct {
+        uint32_t write_counter;
+        uint8_t key[RPMB_KEY_MAC_LEN];
+        uint8_t key_set;
+        RPMBDataFrame result;
+    } rpmb;
@@ -1024,11 +1026,11 @@ static const VMStateDescription 
emmc_rpmb_vmstate = {
-        VMSTATE_UINT8_ARRAY(rpmb_result.key_mac, SDState, 
RPMB_KEY_MAC_LEN),
-        VMSTATE_UINT8_ARRAY(rpmb_result.data, SDState, RPMB_DATA_LEN),
-        VMSTATE_UINT8_ARRAY(rpmb_result.nonce, SDState, 16),
-        VMSTATE_UINT32(rpmb_result.write_counter, SDState),
-        VMSTATE_UINT16(rpmb_result.address, SDState),
-        VMSTATE_UINT16(rpmb_result.block_count, SDState),
-        VMSTATE_UINT16(rpmb_result.result, SDState),
-        VMSTATE_UINT16(rpmb_result.req_resp, SDState),
-        VMSTATE_UINT32(rpmb_write_counter, SDState),
-        VMSTATE_UINT8_ARRAY(rpmb_key, SDState, 32),
-        VMSTATE_UINT8(rpmb_key_set, SDState),
+        VMSTATE_UINT8_ARRAY(rpmb.result.key_mac, SDState, 
RPMB_KEY_MAC_LEN),
+        VMSTATE_UINT8_ARRAY(rpmb.result.data, SDState, RPMB_DATA_LEN),
+        VMSTATE_UINT8_ARRAY(rpmb.result.nonce, SDState, 16),
+        VMSTATE_UINT32(rpmb.result.write_counter, SDState),
+        VMSTATE_UINT16(rpmb.result.address, SDState),
+        VMSTATE_UINT16(rpmb.result.block_count, SDState),
+        VMSTATE_UINT16(rpmb.result.result, SDState),
+        VMSTATE_UINT16(rpmb.result.req_resp, SDState),
+        VMSTATE_UINT32(rpmb.write_counter, SDState),
+        VMSTATE_UINT8_ARRAY(rpmb.key, SDState, 32),
+        VMSTATE_UINT8(rpmb.key_set, SDState),
@@ -1130,2 +1132,2 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
-    uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
-    uint16_t result = be16_to_cpu(sd->rpmb_result.result);
+    uint16_t resp = be16_to_cpu(sd->rpmb.result.req_resp);
+    uint16_t result = be16_to_cpu(sd->rpmb.result.result);
@@ -1136,3 +1138,3 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
-        curr_block = be16_to_cpu(sd->rpmb_result.address);
-        if (sd->rpmb_result.block_count == 0) {
-            sd->rpmb_result.block_count = cpu_to_be16(sd->multi_blk_cnt);
+        curr_block = be16_to_cpu(sd->rpmb.result.address);
+        if (sd->rpmb.result.block_count == 0) {
+            sd->rpmb.result.block_count = cpu_to_be16(sd->multi_blk_cnt);
@@ -1140 +1142 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t 
addr, uint32_t len)
-            curr_block += be16_to_cpu(sd->rpmb_result.block_count) -
+            curr_block += be16_to_cpu(sd->rpmb.result.block_count) -
@@ -1144,2 +1146 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t 
addr, uint32_t len)
-        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN,
-                      sd->rpmb_result.data, 0) < 0) {
+        if (blk_pread(sd->blk, addr, RPMB_DATA_LEN, 
sd->rpmb.result.data, 0) < 0) {
@@ -1147,2 +1148,2 @@ static void emmc_rpmb_blk_read(SDState *sd, 
uint64_t addr, uint32_t len)
-            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
-            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
+            memset(sd->rpmb.result.data, 0, sizeof(sd->rpmb.result.data));
+            sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
@@ -1152 +1153 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t 
addr, uint32_t len)
-    memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
+    memcpy(sd->data, &sd->rpmb.result, sizeof(sd->rpmb.result));
@@ -1155 +1156 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t 
addr, uint32_t len)
-                                 be16_to_cpu(sd->rpmb_result.result));
+                                 be16_to_cpu(sd->rpmb.result.result));
@@ -1167,4 +1168,4 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-    memset(&sd->rpmb_result, 0, sizeof(sd->rpmb_result));
-    memcpy(sd->rpmb_result.nonce, frame->nonce, 
sizeof(sd->rpmb_result.nonce));
-    sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_OK);
-    sd->rpmb_result.req_resp = cpu_to_be16(RPMB_RESP(req));
+    memset(&sd->rpmb.result, 0, sizeof(sd->rpmb.result));
+    memcpy(sd->rpmb.result.nonce, frame->nonce, 
sizeof(sd->rpmb.result.nonce));
+    sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_OK);
+    sd->rpmb.result.req_resp = cpu_to_be16(RPMB_RESP(req));
@@ -1172,2 +1173,2 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-    if (!sd->rpmb_key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
-        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
+    if (!sd->rpmb.key_set && req != RPMB_REQ_PROGRAM_AUTH_KEY) {
+        sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_NO_AUTH_KEY);
@@ -1179,2 +1180,2 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-        if (sd->rpmb_key_set) {
-            sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+        if (sd->rpmb.key_set) {
+            sd->rpmb.result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
@@ -1183,2 +1184,2 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-        memcpy(sd->rpmb_key, frame->key_mac, sizeof(sd->rpmb_key));
-        sd->rpmb_key_set = 1;
+        memcpy(sd->rpmb.key, frame->key_mac, sizeof(sd->rpmb.key));
+        sd->rpmb.key_set = 1;
@@ -1187 +1188 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-        sd->rpmb_result.write_counter = 
cpu_to_be32(sd->rpmb_write_counter);
+        sd->rpmb.result.write_counter = 
cpu_to_be32(sd->rpmb.write_counter);
@@ -1192 +1193 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-            sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
+            sd->rpmb.result.result = 
cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
@@ -1195,2 +1196,2 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-        if (sd->rpmb_write_counter == 0xffffffff) {
-            sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+        if (sd->rpmb.write_counter == 0xffffffff) {
+            sd->rpmb.result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
@@ -1199,2 +1200,2 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-        if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
-            sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
+        if (be32_to_cpu(frame->write_counter) != sd->rpmb.write_counter) {
+            sd->rpmb.result.result = 
cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
@@ -1203,3 +1204,3 @@ static void emmc_rpmb_blk_write(SDState *sd, 
uint64_t addr, uint32_t len)
-        sd->rpmb_result.address = frame->address;
-        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN + 
sd_part_offset(sd);
-        if (blk_pwrite(sd->blk, addr, RPMB_DATA_LEN, frame->data, 0) < 0) {
+        sd->rpmb.result.address = frame->address;
+        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
+        if (blk_pwrite(sd->blk, addr, 256, frame->data, 0) < 0) {
@@ -1207 +1208 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-            sd->rpmb_result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
+            sd->rpmb.result.result = 
cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
@@ -1209 +1210 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-            sd->rpmb_write_counter++;
+            sd->rpmb.write_counter++;
@@ -1211 +1212 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-        sd->rpmb_result.write_counter = 
cpu_to_be32(sd->rpmb_write_counter);
+        sd->rpmb.result.write_counter = 
cpu_to_be32(sd->rpmb.write_counter);
@@ -1214 +1215 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-        sd->rpmb_result.address = frame->address;
+        sd->rpmb.result.address = frame->address;
@@ -1218 +1219 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)
-        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
+        sd->rpmb.result.result = cpu_to_be16(RPMB_RESULT_GENERAL_FAILURE);
@@ -1222,2 +1223,2 @@ exit:
-    if (sd->rpmb_write_counter == 0xffffffff) {
-        sd->rpmb_result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
+    if (sd->rpmb.write_counter == 0xffffffff) {
+        sd->rpmb.result.result |= cpu_to_be16(RPMB_RESULT_COUTER_EXPIRED);
@@ -1225 +1226 @@ exit:
-    trace_sdcard_rpmb_write_block(req, 
be16_to_cpu(sd->rpmb_result.result));
+    trace_sdcard_rpmb_write_block(req, 
be16_to_cpu(sd->rpmb.result.result));
---

Regards,

Phil.

