Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1811CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6hg-0005MJ-MW; Wed, 29 Oct 2025 09:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6ha-0005Hu-LZ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:59:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6hR-00052I-VQ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:59:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so30572845e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761746329; x=1762351129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L9zlBbPAA9oBrM+tkItgC3zSorgHc7QzE47afNVIQf4=;
 b=C2Ok2+mMBjl51J3JMbgv9RMcsz5b16S3L19O1CL4cuJR2Cx3tGAE3hJ2ySpanEweMa
 6gpnlcJj2tV2MlR4PKLLfwpOD483mKUdzKyF57m54t9T/pcKmkFdBZimQTsSz0Eue7sM
 mPKH2aj1DTWrqspnQj6fzgLjQfx+p6Z0wWeE6wp0I/5l9hNUtfUctEJHuDS1S/L6nxmf
 3O8n0P19eNbvWhHHl9pZS/KFtM6FFVicz+BplPzFhaz9V6nhrmbQlrX+jqP9eK6pbqQj
 VYJVl5V1OCOgCQent+RWO8dRB4HFQErkFHKVLsvbFJY2EN+dYhaOIwikTQ8YliD1dn3k
 QIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761746329; x=1762351129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9zlBbPAA9oBrM+tkItgC3zSorgHc7QzE47afNVIQf4=;
 b=edZtHd8qw1puQrOAdcVe/X0iIYPsyL77+hBe0fSSm0Lsaoo/v9EBGlfzEiyrFWD+ZB
 RDkOaKe5EU4L9NiXn2i5cfcFkyZfFRdVBHgcsW1jpXkEvQK1Dzg7PwhbwBM3iQhEv/zT
 yafIWR+DKOvJsRuC9GbfU9Mm86AHCCKn3qpyuAGg7b9/SfjGUTJVDoGrgTBV23Ss0yUa
 GHc+cf7AuMHgRofNK5JyjSnYgYvGUklHcNsUhQ+a0iOeYX0CjEo3bGJDaNYKsdNwR89U
 pTr1si2qyL0VTHzEGo5tIugmaKWTPIM+1QD8J/m6ru6Sav2FogS3jkQOtRaoJiGfN6u3
 kcEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi5xp5Srzfs0vnoMpdoKjipV0fg76zTzByMhKDzbj72ZM/WfbEqkK05dp0VH0KaVrlN7j1waqqLUvx@nongnu.org
X-Gm-Message-State: AOJu0YzsRWa/z+Q+7hrML36hgPSzt5VbpyDMiR7Za4xZr/HoYTMx7rAa
 PyBY3qIX0n+cklnlck3zIgrN3X7/VLmxI+nCWD8aZuJDDLL7HfEASnj+j+rrOYqOZ1g=
X-Gm-Gg: ASbGncsVJ2tbfE2EfY856UT+yBelEyf9sG/KGtCXZOa4w+tKsw9MvJWFy0N0H8rRHYC
 8BMZjtXbmVbSA1GO2R37KUWBpaezo8nX+c/XJvrlih5swhv+HfCxyvheiIKOaaL0QCRSk1SGB8d
 8ucAi8nzAu5BD/vpikSVzks2TODIVs/Vo1ZMl6rDImOJtwSew28TGS1lgeAWMzeuoyJDlXiXFif
 x2aiKIyLlEJS7zO+8NIy8dD19BIFOlUSirw/uYa9MEQmI9ZhKkfxUXpg8uY/n8WSj9qk+4bzFer
 Ns8iDXc3Kk0nV5jyJiC4eqlLJtRBg0o2iz0Ful7oBmb/otqMjjf+go78wtCn790AzsbSubcMQKO
 bW7mCRg8p9+YDeNBGxHG58b3JApZ6nublj3+QxEwwDoOL4I5MLCtWeLh/i3nniHdvCC3ZH9vWFk
 Ukx64rTI9gG5PozubLY736Pyr4JMHj+D4IkHnQ9FvTktE=
X-Google-Smtp-Source: AGHT+IFjoN5C+uOanxun2tnqHZ1de5PEpv09uNvR16VTfmDRQbw3CaOgZUnXie/+se+gLFA9seykoA==
X-Received: by 2002:a05:600c:154c:b0:475:df91:ddf2 with SMTP id
 5b1f17b1804b1-4771e18a983mr30681075e9.17.1761746328681; 
 Wed, 29 Oct 2025 06:58:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196b27sm52895915e9.8.2025.10.29.06.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:58:48 -0700 (PDT)
Message-ID: <fd302b66-1430-454d-8f68-dde3a74b1caf@linaro.org>
Date: Wed, 29 Oct 2025 14:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/35] qdev: add qdev_find_default_bus()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This helper is used next by -audio code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/monitor/qdev.h |  3 +++
>   system/qdev-monitor.c  | 25 +++++++++++++++++++++----
>   2 files changed, 24 insertions(+), 4 deletions(-)


>   DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>                                           bool from_json, Error **errp)
>   {
> @@ -657,10 +676,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>               return NULL;
>           }
>       } else if (dc->bus_type != NULL) {
> -        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);

I don't understand why we use sysbus here, but this is pre-existing, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -        if (!bus || qbus_is_full(bus)) {
> -            error_setg(errp, "No '%s' bus found for device '%s'",
> -                       dc->bus_type, driver);
> +        bus = qdev_find_default_bus(dc, errp);
> +        if (!bus) {
>               return NULL;
>           }
>       }


