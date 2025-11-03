Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB44CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwKE-0000Ki-Bg; Mon, 03 Nov 2025 10:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFwK4-0000FH-IM
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:18:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFwK0-0004yG-4o
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:18:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so24396655e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762183089; x=1762787889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BramkN4PF30fkjmnEwQADGgOeh2jVB6j0PXaGvZs9kU=;
 b=URozNBwcY/lgIVgUUusmW5j+hmMxLM5+OUBw1QVdOqKUg9+bZJzbD4GAsviu+FnAr2
 IQz0HCo17noMFUzx2Nc5hqiuvoaE4eZNE6zGDDanHZjciW6lPRD/dwk/gD78gaCa/9op
 JWjdmzsmNoMCGeT/iHkCmczCAY8kfIP4OZ18EkImRIxhc6H6amd2f//XlTs5636SnoMN
 Qjt9S7zub6y5XBJJTY8XvHYalSa3EtoRKHLUoc8YZjtq0kEy+QrYEWdxU7HpsPYLIyv6
 VfKm1vGTBuNa+84E/KAYtjmRNLd9G9DFxYv/g/bX/AV0miihTBELHZGw3eRxCaCm6Lzm
 6ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762183089; x=1762787889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BramkN4PF30fkjmnEwQADGgOeh2jVB6j0PXaGvZs9kU=;
 b=M3caiHVuLY16dgSIIncVLy3kT/cmUEW5f9yivN4s4WIjUnv+KmirXOvU83DMd2aYe7
 jUe6O2NpYMIHynv3kOY1gAQ+b8//CZtzufeIISCwGLmz0WXxY18DRllzLivCC4UFGIfG
 U6pNFBdZE7ylaKyhhkuPrxWAJHHPt29kMxqrl5qF/+3rKdKr2g7QuNOyrjmhNmgRSnJi
 oFUnAev8MBmGVCxMytnxwoRQkkGmYa8NA5tHLL+3Zd6F0hGJombYzMJYzGP0VI/7oARx
 fcDBAoAVKM8VOAVzQ4LN6x/uAYKcVg6ROa029PhQg8Qdn4GmRg/REcVrVpxIswuOJyN6
 /otQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUN8XtjgpgZjItsAtwxoJrKkRclSopv7ofOqZzAvIodADAI0qdVaK+AmGtIDZSurucbnQI5zXyT5CT@nongnu.org
X-Gm-Message-State: AOJu0Yxx40xuhp7Rs6oNWP7XGwtcodlqUJjFBpe1n/UOwd8b7QNhujeF
 V1mmTNTJvMc8U5O+EmgfoNErMl2gj/XzH/bp6RUqvr6GVbQWtJbp4WLiFVZjC8uMy1Y=
X-Gm-Gg: ASbGncuDlQVRaH/XdOrJVSapREvWrAMLduaVPzuJefchugByaalW06IqRdxjccHTO8J
 HUCXGKlq45OwYkKkViHC0prX5pAD/ttJ/uVY9ZDxzqoDVmXPT2cffcrDh3RyPLiGDmmrsd/2Fvy
 1RNpog7/AB0h4Lny8lN1171p6wBeWnPxXbaxS/vZuREhZcEtaXYUVqh0Sw/R5o3hJxb5AK7SiIY
 BuqeAI9RvGFUgmVcmd+ftl/w2A58SRsyYhCNGz2zUPvL5Hop4RVxjrvC8cSDkviI3860eQrI/RF
 vklAusF/RqAfse3k/LMp9NlFa9whyy730GOO8us0HabFkaqlFC/E4gqwYEpXVNmHpfm533n/JiF
 /zPn7mcSJwGBqTWHl46wFGahpZA8DJMEO3kuSk9ZtmVZvKmoQetxmZ22lI9uFfNlWPaAkg3Bw5E
 uy+QXOad2im4CWDBgSKOsUzbnu7C9oYSdw+WyNfNsT/2ruNi7CfXk2
X-Google-Smtp-Source: AGHT+IHDXj0M+lXUZ0ksai1T0LgirG3UvEk0B6M+Z3kpZGc8bNyQpf7lqiTy48yzEX/pZdpE6xPsaw==
X-Received: by 2002:a05:600c:1da8:b0:477:3fcf:3651 with SMTP id
 5b1f17b1804b1-4773fcf3b20mr62316805e9.39.1762183089281; 
 Mon, 03 Nov 2025 07:18:09 -0800 (PST)
Received: from [172.18.140.215] (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c9416f82sm15350212f8f.6.2025.11.03.07.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 07:18:08 -0800 (PST)
Message-ID: <40ccc01c-0ad0-499b-b2e2-4b5bbcce957d@linaro.org>
Date: Mon, 3 Nov 2025 16:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] hw/sd/sdcard: Handle RPMB MAC field
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <30efd95ad5fc54b6afac9d6a0d260c174a6718d2.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <30efd95ad5fc54b6afac9d6a0d260c174a6718d2.1760702638.git.jan.kiszka@siemens.com>
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
> Implement correct setting of the MAC field when passing RPMB frames back
> to the guest. Also check the MAC on authenticated write requests.
> 
> This depends on HMAC support for QCRYPTO_HASH_ALGO_SHA256 which is
> always available via glib - assert this, just to be safe.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 918fe9f79f..759e284ac0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -51,6 +51,7 @@
>   #include "qemu/module.h"
>   #include "sdmmc-internal.h"
>   #include "trace.h"
> +#include "crypto/hmac.h"
>   
>   //#define DEBUG_SD 1
>   
> @@ -118,6 +119,7 @@ typedef struct SDProto {
>   } SDProto;
>   
>   #define RPMB_KEY_MAC_LEN    32
> +#define RPMB_HASH_LEN       284
>   
>   typedef struct {
>       uint8_t stuff_bytes[196];
> @@ -1120,6 +1122,66 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>       }
>   }
>   
> +static bool rpmb_calc_hmac(SDState *sd, RPMBDataFrame *frame,

const frame.

> +                           unsigned int num_blocks, uint8_t *mac)
> +{
> +    size_t mac_len = RPMB_KEY_MAC_LEN;
> +    bool success = true;
> +    Error *err = NULL;
> +    QCryptoHmac *hmac;

Preferably:

        g_autoptr(QCryptoHmac) hmac = NULL;

> +    uint64_t addr;

Maybe better named 'offset'.

> +
> +    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, sd->rpmb_key,
> +                            RPMB_KEY_MAC_LEN, &err);
> +    if (!hmac) {
> +        error_report_err(err);
> +        return false;
> +    }
> +
> +    /*
> +     * This implies a read request because we only support single-block write
> +     * requests so far.
> +     */
> +    if (num_blocks > 1) {
> +        /*
> +         * Unfortunately, the underlying crypto libraries do not allow us to
> +         * migrate an active QCryptoHmac state. Therefore, we have to calculate
> +         * the HMAC in one run. To avoid buffering a complete read sequence in
> +         * SDState, reconstruct all frames except for the last one.
> +         */
> +        char *buf = (char *)sd->data;
Why not plain 'void *'? Ah, qcrypto_hmac_bytes() takes a 'char *', 
odd... [Update, now about to be fixed:
https://lore.kernel.org/qemu-devel/20251103133727.423041-4-berrange@redhat.com/]

Better safe than sorry:

            assert(RPMB_HASH_LEN <= sizeof(sd->data));

> +        memcpy(buf, frame->data, RPMB_HASH_LEN);

Nitpicking, no need to fill the block we'll overwrite:

            memcpy(&buf[256], &frame->data[256], RPMB_HASH_LEN - 256);

> +        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
Personally I prefer the ld/st API, and I'd rather see it used
consistently within hw/sd/. So (matter of taste):

            block_index = ldw_be_p(&frame->address);
            block_offset = block_index * 256 + sd_part_offset(sd);

> +        do {
> +            if (blk_pread(sd->blk, addr, 256, buf, 0) < 0) {
> +                fprintf(stderr, "sd_blk_read: read error on host side\n");

Although a pre-existing pattern in this file, no new fprintf(stderr)
please. Better use the Error* API, otherwise error_report().

> +                success = false;
> +                break;
> +            }
> +            if (qcrypto_hmac_bytes(hmac, buf, RPMB_HASH_LEN, NULL, NULL,> +                                   &err) < 0) {
> +                error_report_err(err);
> +                success = false;
> +                break;
> +            }
> +            addr += 256;
> +        } while (--num_blocks > 1);
> +    }
> +
> +    if (success &&
> +        qcrypto_hmac_bytes(hmac, (const char*)frame->data, RPMB_HASH_LEN, &mac,
> +                           &mac_len, &err) < 0) {
> +        error_report_err(err);

Ideally Error* should to be propagated to upper layers.

Here SDCardClass::read_byte() and SDCardClass::write_byte()
don't expect failure, so OK -- maybe they should ... --.

> +        success = false;
> +    }
> +    assert(!success || mac_len == RPMB_KEY_MAC_LEN);
> +
> +    qcrypto_hmac_free(hmac);
> +
> +    return success;
> +}
> +
>   static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>   {
>       uint16_t resp = be16_to_cpu(sd->rpmb_result.req_resp);
> @@ -1142,6 +1204,17 @@ static void emmc_rpmb_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>               sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_READ_FAILURE |
>                   (result & RPMB_RESULT_COUTER_EXPIRED));
>           }
> +        if (sd->multi_blk_cnt == 1 &&
> +            !rpmb_calc_hmac(sd, &sd->rpmb_result,
> +                            be16_to_cpu(sd->rpmb_result.block_count),
> +                            sd->rpmb_result.key_mac)) {
> +            memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
> +        }
> +    } else if (!rpmb_calc_hmac(sd, &sd->rpmb_result, 1,
> +                               sd->rpmb_result.key_mac)) {
> +        memset(sd->rpmb_result.data, 0, sizeof(sd->rpmb_result.data));
> +        sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
>       }
>       memcpy(sd->data, &sd->rpmb_result, sizeof(sd->rpmb_result));
>   
> @@ -1153,6 +1226,7 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>   {
>       RPMBDataFrame *frame = (RPMBDataFrame *)sd->data;
>       uint16_t req = be16_to_cpu(frame->req_resp);
> +    uint8_t mac[RPMB_KEY_MAC_LEN];
>   
>       if (req == RPMB_REQ_READ_RESULT) {
>           /* just return the current result register */
> @@ -1190,6 +1264,11 @@ static void emmc_rpmb_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>               sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_WRITE_FAILURE);
>               break;
>           }
> +        if (!rpmb_calc_hmac(sd, frame, 1, mac) ||
> +            memcmp(frame->key_mac, mac, RPMB_KEY_MAC_LEN) != 0) {
> +            sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_AUTH_FAILURE);
> +            break;
> +        }
>           if (be32_to_cpu(frame->write_counter) != sd->rpmb_write_counter) {
>               sd->rpmb_result.result = cpu_to_be16(RPMB_RESULT_COUNTER_FAILURE);
>               break;
> @@ -3115,6 +3194,8 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       SDCardClass *sc = SDMMC_COMMON_CLASS(klass);
>   
> +    assert(qcrypto_hmac_supports(QCRYPTO_HASH_ALGO_SHA256));
> +
>       dc->desc = "eMMC";
>       dc->realize = emmc_realize;
>       device_class_set_props(dc, emmc_properties);
I'd like to squash on this patch:
-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f2260796db8..6e4eeeda157 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1129,3 +1129,3 @@ static void sd_blk_write(SDState *sd, uint64_t 
addr, uint32_t len)

-static bool rpmb_calc_hmac(SDState *sd, RPMBDataFrame *frame,
+static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
                             unsigned int num_blocks, uint8_t *mac)
@@ -1133,5 +1133,5 @@ static bool rpmb_calc_hmac(SDState *sd, 
RPMBDataFrame *frame,
      size_t mac_len = RPMB_KEY_MAC_LEN;
+    g_autoptr(QCryptoHmac) hmac = NULL;
      bool success = true;
      Error *err = NULL;
-    QCryptoHmac *hmac;
      uint64_t addr;
@@ -1156,9 +1156,12 @@ static bool rpmb_calc_hmac(SDState *sd, 
RPMBDataFrame *frame,
           */
-        char *buf = (char *)sd->data;
+        void *buf = sd->data;

-        memcpy(buf, frame->data, RPMB_HASH_LEN);
-        addr = be16_to_cpu(frame->address) * 256 + sd_part_offset(sd);
+        assert(RPMB_HASH_LEN <= sizeof(sd->data));
+        memcpy(&buf[RPMB_DATA_LEN], &frame->data[RPMB_DATA_LEN],
+               RPMB_HASH_LEN - RPMB_DATA_LEN);
+
+        addr = be16_to_cpu(frame->address) * RPMB_DATA_LEN + 
sd_part_offset(sd);
          do {
-            if (blk_pread(sd->blk, addr, 256, buf, 0) < 0) {
-                fprintf(stderr, "sd_blk_read: read error on host side\n");
+            if (blk_pread(sd->blk, addr, RPMB_DATA_LEN, buf, 0) < 0) {
+                error_report("sd_blk_read: read error on host side");
                  success = false;
@@ -1172,3 +1175,3 @@ static bool rpmb_calc_hmac(SDState *sd, 
RPMBDataFrame *frame,
              }
-            addr += 256;
+            addr += RPMB_DATA_LEN;
          } while (--num_blocks > 1);
@@ -1177,3 +1180,3 @@ static bool rpmb_calc_hmac(SDState *sd, 
RPMBDataFrame *frame,
      if (success &&
-        qcrypto_hmac_bytes(hmac, (const char*)frame->data, 
RPMB_HASH_LEN, &mac,
+        qcrypto_hmac_bytes(hmac, frame->data, RPMB_HASH_LEN, &mac,
                             &mac_len, &err) < 0) {
@@ -1184,4 +1187,2 @@ static bool rpmb_calc_hmac(SDState *sd, 
RPMBDataFrame *frame,

-    qcrypto_hmac_free(hmac);
-
      return success;
---

Regards,

Phil.

