Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA4F428E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6qa-0002SM-9o; Wed, 15 Apr 2026 16:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6qX-0002PJ-49
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:28:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6qV-0006dG-KA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:28:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso58061975e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284902; x=1776889702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lYP3LpjdWdcmqEdQaJ3hEaYO67ejQhMf+OP5WIUzSVs=;
 b=RsQ6nnIe5BTg34FeQqMGCnseSdihvxC5n9l53TBQyMfFsSSqz81yiy2xMX9qq1S8l5
 j9UjMwHncZcSvfp3UwmJj8sqDZCcj4jG19Nf1IcGeitqV0CfTylDvB44z7w3Kt1c5JQr
 RjpAftQC7Gy4iCbJvAz2dAG/UVZPGgzeSTNT5BnjZ++MJYuC5PwOtzY5+/kkrP9p3DhI
 QV56b2p1MXJrvGwVERVVIWdEtjZ9OriOnLd/Liz8ZIlNbRP7qJo/wwyaut0RyW5BeKcJ
 lYGUx901ftaVnWPGocII3jVZ92cTXusn/ve0b+jxKFUGLIZ/qPwe02+HCrauvf6iXN9T
 aJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284902; x=1776889702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYP3LpjdWdcmqEdQaJ3hEaYO67ejQhMf+OP5WIUzSVs=;
 b=mD0S4XRm/gaY5VQHgxuHQ6akZ9Q3tcuoR4+upNc+7Rinzo6eXqKrDyIz1NSg8aVqJJ
 1CUicNsAnsDiiLJvcV9rfj+5QV9/IvnDuZkwaWhaCwiqEx5u03nBvLNE1hrbsKcwbH8s
 SBYD5Oy2+iCaZWNevbVvN0K79pYvkJeaDBJ53siycLR1D9mYCjyis6Z2PYTpxmy+aDn7
 H2SLkTNaPMVnAgXTDuvjVj3if93t2m9ihhOv7xYdR+0v4BjgObJE9cDWxx6c/UvcvhWa
 Yxcslb222Nlp8HVD9frFI/SZhxx2IcdL+kHa4V7jE+1g+T5kzX/17ME1azi9g/NUU/ZT
 q1xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LKZx/y1dEMsrrvoTfPPolJXHCu0cgXFgNvh932wCNrLHBiOYMnIrD4FyrJnM7OYNY9l3IWHV9v2AM@nongnu.org
X-Gm-Message-State: AOJu0YzRDYP3BN27TMy2LPEul973YhBD6xjW0SBgnXHt+rHaFRRtm210
 daAcxgh1tu1nENTikwvVUJRmcnqMPa7ZkVT1zMUTz4pu3tFcWmVU8jtEhV6cU3Fyuto=
X-Gm-Gg: AeBDiev3iXKkPyewnh/BkLzIeh22fCC4gWyn5bQ6nNWBrkOeMeBD3ffhDT0jmUYcge2
 5pyAEaUFr/gv+t+mQfFCBZ3CiR5cLW59DEwXsveorWeiGGVZfI3YLIUkvGxuV/INA8Y5+WKutZL
 NAGdWHnohF+tHcAUzATuOm0coVZcvOBCny1qNJbC704k0Suz4TIbFJdgNaQdWSt6AL6QWUmIZxb
 OlTiO4mkYw38eBvNlCGgkaSEc/RMzD/vc09v78hzOn0PmHa4XE997RrtgcmGyPpqUTBIy7R4A1h
 kc0dKpZZ7PsfssW9a3Oqz+qkg014OD1q3orbrEjIl2rkWFUhQ4RF4Ixk2xMayzBgVo0R2w/K3rg
 dZHo4hwFC4YpFEMsRq9hRguZM/NcNxRIurtbGnTGSBgSgpE1/JTtAn2XqRY0ltdAAimNAD4pfxy
 OL95sXJYoUmE+6LiKY/mf7sCBsyLLBEpE34HtgiO8xomukDwo7jPCJm1E/lD5oPlATXMRGfTCyZ
 t8n
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id
 5b1f17b1804b1-488d685fcf7mr225830335e9.22.1776284901737; 
 Wed, 15 Apr 2026 13:28:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f093d7fdsm41915425e9.2.2026.04.15.13.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 13:28:19 -0700 (PDT)
Message-ID: <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
Date: Wed, 15 Apr 2026 22:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Jan,

On 15/4/26 07:46, Jan Kiszka wrote:
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
> ---
>   hw/sd/sd.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Do you mind mentioning it in docs/system/devices/emmc.rst?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

