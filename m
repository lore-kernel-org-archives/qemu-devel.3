Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38688F433C7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFNZ-00014e-RE; Thu, 16 Apr 2026 01:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1wDFNU-00013y-Dp
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:35:02 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilias.apalodimas@linaro.org>)
 id 1wDFNQ-0004mc-PU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:34:59 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79db5e18ac6so2368417b3.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776317691; cv=none;
 d=google.com; s=arc-20240605;
 b=Bwb2P2JZMHjeMdvm9OelPTn1Z5H8mwCt58+pchoqUPsWg8cAo3HWz8MQ6UR2i7CqMx
 nsyI0ikz7kwTv+BE1aA1QK9Iy4xZFKSjlUcuAma9c12cd+YoXDwws+oIXXsT8namLDVz
 sMBxoy7ly9/Nq3PLyIQDwdhk9thb2R8nBWIv7hP4s9HMtXzuK1EfxhUt/B76v8yTLlp4
 NwmSjaOVNS9b2S+MHHXW/c8UU8UrEK/hGyqoeneTYjjvg3dbzVI3hHu7N2nFhxjeqYZ0
 ra1Bgg8La3X7zh0IKW7xouSfp+h+Rl0AQZ0MXFWknPA5jk/K0OtznilA3+SEAGXG3x2l
 cnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ExzvDa+TdHIPATaHqeUymt4V//79es+dfrTSQ9aYYGg=;
 fh=7UGIPE6lkGdU6fsPnBkfWzWTYRnchdV/MD6UOa7TNvM=;
 b=A7MGPpx2DPdxmN08Pnxm8TvicjpAd4LMupyIiSHOLgzZbjcSSxQLfXAg6ml4Dq8K+P
 3zV1Q5Ncokgum9s2eIzs78yb/KqYH0hmK051kjkHxhH5NPu3mAxHYDC/+OqdOEdlx/aY
 KJfX4VcNMRZB0IBAskzTtigJesucQ2hf6cdUd/OszIisnzEh8QjyEckGGKz1CDGyc8JG
 jkmLpgQQnxfkydvmrVjB6i0WVmLuYzQLRBCiV93iV44THi9FxEbUrhk6aMqd5Yz8LzjI
 WHzsoN4lP5/VoTatsJZG8ruRlvA/33t1SiMEMI6o6bZRV5fYC+yqlgWDCTy8+nrKsEcq
 SHpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776317691; x=1776922491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ExzvDa+TdHIPATaHqeUymt4V//79es+dfrTSQ9aYYGg=;
 b=S8C8BXmWkEhrY5muoBKCaxH/VuwlsSbf3BZ1UXmIc41qVsDTkOVdtp+/tgXuMib67g
 3VY6y+2NVG6oe93NN3btSJCjA6np0nBwpA0gdguvgPay0RUW6QG1CpOEV+E/b1/IxJyI
 IdeCU6lazG+REDoDYqcyyVY4itpmKtkLfcW/UNNPUCRjXL9UbcjEtv4JMKwXqWZ2C7y8
 v3JgeioAM+Sx3zQvgzJxJXLD5fSqLGA3pQpnvN21EbSZhPx6evmz1maZb5HU5nX1KQPD
 y+y6aAaEtOPtsfduWp7AXOm9+ET56UuRoormKs+TMEH+UcrP3XiRCGQ1JXJj3jBbMB01
 7ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776317691; x=1776922491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExzvDa+TdHIPATaHqeUymt4V//79es+dfrTSQ9aYYGg=;
 b=TJhyeexzUK6oxhwXKPKFtoGuh7NSJc0/Ey0NplyEs9OhuGfRoQDEcXrjilOLV2vtXm
 q0iswL4MbSZ7gKzXxGtwaezpOMczUc5o9l2K/zGuyM+iym6VHAonk51gQ1AdDbRAjogx
 LujzRMNCLS/9B4bSSSUgBuQVCAqqhUC5URl27kJLTjXjJ1yRwv/mKrZmuiwZbx2LVs2h
 ic85PjZTZczkNNn7t8XLd/OIs6B10/3rUjxORn7mIYepizgY/cSki9RG2wnEbCMypRLD
 NTN4xwqzwgrPYrLky49ddCw4Mn9F2ZVg4ZaLPYOB1zFF5NI9opQn4/mWxAQooB4XadqW
 VERQ==
X-Gm-Message-State: AOJu0Yx7WazpuVnRiQiGiOLzUPlTWNGcDQqhLyRDzmhUA+pJk1TOR6iH
 BtWqK6KHM9GTlRG9aIjfP+quqU4R1pzdNtBTifKmBVQ5o9JRO3MEObireLjVJwhXXMdpQaaQjSE
 4umSLzVDXM+tbLhkps+wgdXlVgb4XIe7I2Vc+lPDHAw==
X-Gm-Gg: AeBDievIVoHXR2wPykOoSTtdi//Vss2DTY7i/oVUtsRz8qZS+a855+4trWgReqH/vCn
 DgKs0jRnFJ6UbPk/YSnVkIDQ/lvduc6onVXs0mnvIlZE6u6jQlcqYm2mD3Y5ExlaXO/N1l1Pin7
 NzjBadCOoGBR2S+KHeKxpoG3UTx1PsSUHKZnBWeamzzVSl+v+mF9sc8ka76K/PGSlWVrWSFI6xB
 Pl84a2KDXjkCPClFVhiHppY1koKo335NPS+U2WEJzfye474DHzyh7m7nz7+ZJQh6TIbLnr9rwZi
 RPhN8z41ETjNS9OcbBTD/tkw3c1bG+ORzGlHB+qTNbpZjP+5Zwn63Uvgs0BvJhYYmA2VzFei2WY
 PTA6n1qHN662I3fc14GcsazCfa0BnDwegeHVLGNJ2sYp7wh9fqCvp5QBEc7GtgyJKlQkrwrGY1/
 NZ0f6AAW5lmJXs/aBNYaRhnWaqXkGOxY3iBPy705tOmgpd2rxMAcKy0llSxvmKVkSSEcQmNURGs
 Ue90J6V6/r2j5+OrpUb0dhkxN9uT9kxFD4aRde3yEenMCaKV+FM6A65zxXfSVhEJ/1s+IEDC0R0
 b0WywDob7/b718VLhfJaQTSZTwd2fx999taz5S03e2Yb
X-Received: by 2002:a05:690e:419a:b0:650:1d24:2adc with SMTP id
 956f58d0204a3-652f654b5f4mr1460837d50.42.1776317691464; Wed, 15 Apr 2026
 22:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
In-Reply-To: <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 08:34:15 +0300
X-Gm-Features: AQROBzCZ9qkUJNdFd-Vyeo9GWs80LjHQyX3n1l4cDVbFRN4tXHykBUOntWrPWso
Message-ID: <CAC_iWj+VFo67zaRjE93aUwn7jp2A=_WMCsMOicH_7Z8uPKjj+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=ilias.apalodimas@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 15 Apr 2026 at 08:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> In contrast to real eMMCs, we are not (yet) persisting the full state
> of the device. This particularly includes the authentication key used
> for RPMB access, complicating testing of firmware images which do not
> support initial provisioning of the key.
>
> One way to address this would be, e.g., extending the eMMC disk image
> with a special sector to store further state. A simpler approach is used
> here: Add another device property that allows to specify the
> authentication key, bringing up the eMMC as if the key has already been
> provisioned before.
>
> This is how to tell qemu to use the OP-TEE test key:
>
> -device emmc,[...],auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>
> Or use this for machine-configured eMMCs:
>
> -global emmc.auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  hw/sd/sd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 37f6e0702b..13ea54df38 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -205,6 +205,7 @@ struct SDState {
>      QEMUTimer *ocr_power_timer;
>      uint8_t dat_lines;
>      bool cmd_line;
> +    char *preset_auth_key;
>  };
>
>  static void sd_realize(DeviceState *dev, Error **errp);
> @@ -3132,6 +3133,27 @@ static void sd_realize(DeviceState *dev, Error **errp)
>                            "The RPMB partition size must be multiples of 128K"
>                            "and not larger than 16384K.\n");
>      }
> +    if (sd_is_emmc(sd) && sd->preset_auth_key) {
> +        if (strlen(sd->preset_auth_key) != 64) {
> +            error_setg(errp,
> +                       "Authentication key must be 32 bytes long, "
> +                       "encoded hexadecimally");
> +            return;
> +        }
> +
> +        char *pos = sd->preset_auth_key;
> +        unsigned int n;
> +        for (n = 0; n < RPMB_KEY_MAC_LEN; n++, pos += 2) {
> +            int chrs;
> +            if (sscanf(pos, "%02hhx%n", &sd->rpmb.key[n], &chrs) != 1 ||
> +                chrs != 2) {
> +                error_setg(errp,
> +                           "Authentication key contains invalid characters");
> +                return;
> +            }
> +        }
> +        sd->rpmb.key_set = 1;
> +    }
>  }
>
>  static void emmc_realize(DeviceState *dev, Error **errp)
> @@ -3156,6 +3178,7 @@ static const Property emmc_properties[] = {
>      DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
>      DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
>      DEFINE_PROP_UINT64("rpmb-partition-size", SDState, rpmb_part_size, 0),
> +    DEFINE_PROP_STRING("auth-key", SDState, preset_auth_key),
>  };
>
>  static void sdmmc_common_class_init(ObjectClass *klass, const void *data)
> --
> 2.47.3
>

