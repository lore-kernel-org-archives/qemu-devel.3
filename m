Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E214DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtrO-0008WP-CI; Tue, 12 May 2026 16:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtrM-0008Vg-BJ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:37:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMtrK-0003lw-J0
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:37:44 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so9796187a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618261; x=1779223061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNooBu2uLzHGRSyl3yaS7h3ls1Lf3Lo4dhL2l5frUCk=;
 b=rS63YdtBDHhR8AyWPDzCJROTAdHkY462LuJjgS1rcQxHlmLhNROZgp3Spzm5IKVv35
 PJ08Pn1YXNw24h0EUejHdEG8R+50xNsil2znvgTZwKHSUAMSrdbcHCMI4t54i70fhn5v
 0RwdmBImLJZJx4ta3aOIT75nxntkTrSBRdavdKNsLr9knU5y2PPwEatIxlvp4FAJ448a
 ZEZqVp4pMM8IMm40u2MVv/s+ywK5BLIwXMgQHCaB/rLfO2vT6pUpy5Tyijg0SPLACTLR
 cuSyLfJl96oFWOzJuKSuFmfT0JvHgyQN3ARvEAwAj1imw3Mr09kiuqjDDFdCRafCuhvi
 Vz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618261; x=1779223061;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNooBu2uLzHGRSyl3yaS7h3ls1Lf3Lo4dhL2l5frUCk=;
 b=qcsFPSnae0VReym46qgrKEW6UwyhshY92fosCYp+TAjHfXzeW9FVapbD8gY2OfvYhR
 axoidc31sQhc4PJWcvTUInJnYIxi02IuhuL1EdURuW4MZSBtSnwLVJsI6hPj0vpx588L
 kmOjyB1Z7RTjexB/cs/FfgR0BPTzNjjVI6DF4VeOXQakdlLlgjnud24ZX46Uc1wJ8Wan
 CUhwPiYUpo0cLzWnAus09SMFKE0x0DcZjjdKtZebtrmt3aCVn8b7uxB4Q2F/E/yJAEYy
 uznz+beitKkPADZ+LodDu8BlsVK1iY2ucSVuMWpeB5RMX7MLvx+vkm9jBH7Owf+Tklf2
 JWcQ==
X-Gm-Message-State: AOJu0YzJ766xHAN58i6R87tdqHHoSINFDtkJIpuOZk8RhwNaQCo/SU5a
 nHJdk4wlfERDBx9Fv7INaiA7Wtk3og9F2VeToEF3z1qmjsDxw/AlNbuyDCyeFb+FFxT78pjyfa+
 R8CIYtlQ=
X-Gm-Gg: Acq92OFh+iERylgW/XlROxkVYaO1xP8m+sDf9uxN/h3tqYJvxy/psTEZyovBuiuqACJ
 ZXzhCfIs1jiyl/cdOMSxVuyJD02iFx9wFdwjaLKmYlwx0UYTozx2c9hZzlvhA4+//yBMUcMJjuY
 ozVcPVt/EPpEhJKkMzfhDuRBbR3f2Hay7WrCYuUP0kSDDGOMXJbPcVbGKq5OaaDcZUsdttiNBCG
 a5pRH4wZwkKEQkDsqC6Z8UjUdxnI/sxvOCIRy+TWAq+Q+xWdqvrfzAGnRduE1QON5Zfs2+azgN8
 5DAqSPr029a0y1jsqYezJ9nA6xPqQvBjaRp4rGE+EmmGxFqPZkTjK8i3znsurPtUxWjhZZTDsv2
 he53c9Ks3tNSQGlv7rg9q5QjjOOl9G3+MSfQm4dDii03xoVwiiGG6oPVKjob6XyvGY8TQaYny6r
 sgkaQ+z0MvAak0PNx1eTat61oL2RoC1j8nxXN0Z7qdTVSonsYnB1zhSMp3oFEY/zXR1g==
X-Received: by 2002:a05:6402:a0cb:b0:669:cc03:334a with SMTP id
 4fb4d7f45d1cf-68255afa7cdmr162498a12.11.1778618260609; 
 Tue, 12 May 2026 13:37:40 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67f74af9ec6sm4219852a12.29.2026.05.12.13.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 13:37:39 -0700 (PDT)
Message-ID: <b1910325-bfd7-4f4c-a288-fb40f597ccc0@linaro.org>
Date: Tue, 12 May 2026 22:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/41] hw/sd/sd: Allow multi-byte read/write for generic
 paths
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-7-philmd@linaro.org>
Cc: Christian Speich <c.speich@avm.de>
In-Reply-To: <20260512062142.67998-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 12/5/26 08:21, Philippe Mathieu-Daudé wrote:
> From: Christian Speich <c.speich@avm.de>
> 
> Paths that use sd_generic_write/read_data can now write/read multiple
> bytes with one call.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20260417-sdcard-performance-b4-v4-2-119e66be10c2@avm.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 62 ++++++++++++++++++++++++++++++------------------------
>   1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c0b89735f69..b49b83b96e8 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1610,7 +1610,7 @@ static sd_rsp_type_t sd_cmd_optional(SDState *sd, SDRequest req)
>       return sd_illegal;
>   }
>   
> -/* Configure fields for following sd_generic_write_byte() calls */
> +/* Configure fields for following sd_generic_write_data() calls */
>   static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
>                                                uint64_t start, size_t size)
>   {
> @@ -1625,7 +1625,7 @@ static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
>       return sd_r1;
>   }
>   
> -/* Configure fields for following sd_generic_read_byte() calls */
> +/* Configure fields for following sd_generic_read_data() calls */
>   static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>                                              uint64_t start,
>                                              const void *data, size_t size)
> @@ -2615,11 +2615,15 @@ send_response:
>   }
>   
>   /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
> -static bool sd_generic_write_byte(SDState *sd, uint8_t value)
> +static bool sd_generic_write_data(SDState *sd, const void *buf, size_t *len)
>   {
> -    sd->data[sd->data_offset] = value;
> +    size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
>   
> -    if (++sd->data_offset >= sd->data_size) {
> +    memcpy(sd->data, buf, to_write);

Always writing beginning of buffer.

> +    sd->data_offset += to_write;
> +    *len = to_write;
> +
> +    if (sd->data_offset >= sd->data_size) {
>           sd->state = sd_transfer_state;
>           return true;
>       }
> @@ -2627,11 +2631,15 @@ static bool sd_generic_write_byte(SDState *sd, uint8_t value)
>   }
>   
>   /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
> -static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
> +static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
>   {
> -    *value = sd->data[sd->data_offset];
> +    size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
>   
> -    if (++sd->data_offset >= sd->data_size) {
> +    memcpy(buf, sd->data, to_read);

Always reading beginning of buffer.

> +    sd->data_offset += to_read;
> +    *len = to_read;
> +
> +    if (sd->data_offset >= sd->data_size) {
>           sd->state = sd_transfer_state;
>           return true;
>       }

Squashing:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b49b83b96e8..11f6b91576a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2619,7 +2619,7 @@ static bool sd_generic_write_data(SDState *sd, 
const void *buf, size_t *len)
  {
      size_t to_write = MIN(sd->data_size - sd->data_offset, *len);

-    memcpy(sd->data, buf, to_write);
+    memcpy(&sd->data[sd->data_offset], buf, to_write);
      sd->data_offset += to_write;
      *len = to_write;

@@ -2635,7 +2635,7 @@ static bool sd_generic_read_data(SDState *sd, void 
*buf, size_t *len)
  {
      size_t to_read = MIN(sd->data_size - sd->data_offset, *len);

-    memcpy(buf, sd->data, to_read);
+    memcpy(buf, &sd->data[sd->data_offset], to_read);
      sd->data_offset += to_read;
      *len = to_read;

---

