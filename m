Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79CFF428E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6uN-0005oh-1f; Wed, 15 Apr 2026 16:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6uB-0005io-IQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:32:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6u9-0004gI-OV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:32:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso118674825e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776285127; x=1776889927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=51eo0uHbeoTspXPKqvdXrtHhn6IyF/D2c8Jdej6F49M=;
 b=wevpdzcJfG5Z4aaPIagPnyiUpsSC8BwdbIsUfEFjboxgbeonh8RwOHUPeIs95XztWf
 mwivW6fnPXokcacZ/5OCfluqa+2WJWCwSK7lE7vxr5F1If+8FJFdpRNYUIovV9d3DqB7
 qfWDDZzv3OHpaWOBScOMUbku00VFp1b6ja2zT5T+56IlDXmcl40D5PHZUHEcC5ecXPwZ
 NnGg8mabWAhj2e515QpC7RK9QYGaCuvGrYKJ02aBz9550Z9UPgcl6ew5bTOXDw4dSGzp
 uw55wLd6//WqHhPZyDyl3KAAetNxSVvUaqcljUmMHQRwt95xRx73aumxKMSrU1w5dZwb
 sFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776285127; x=1776889927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51eo0uHbeoTspXPKqvdXrtHhn6IyF/D2c8Jdej6F49M=;
 b=dZDmeBVi1ifItIPt1q2zYsyy9bvU/7cG+Kx8mILXRF85qNehC1fDOsCNv+2xVOYRPI
 mn9KeuaojfBuI2AeCHZkrjrSghnSGM5jjn+mI0IUnzfPdjVczV+ife+nc8YO1ZPUfTXv
 mblvA1wf2MDHP/lHYYM76u96S+NQYcVMaDiHMjXdXsD9EH2HXuSMfSzimLG3t8yZv5st
 t7lF8763WFH5czXK1bU/7+CjN52y9T0B/zsPsPlo5AYhjBrx2ZCKE0IM6IoQ9hcUzig5
 twXjITd67QpxALd6btBaz1uv9jl87pUtxI2eSjOW3rdmVzbN+FE8O6EC9s4rRFXuxbtN
 kP/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ltKVrhgthqX+iboBSNfjGLDtWZuOklUsZRvAxOQoO2p8gx5tOw9MVm3TmndArN0jpIWgneprft83e@nongnu.org
X-Gm-Message-State: AOJu0Yw2PwqfnKVsuDDziPsJWtKAgblaHbOl4aWQYGiqitVFkL7tNKVI
 j4sSw6xg66rwPig9rKXMNlX9DEGEFQKhG2x9wtOmhAUL9HICLj0x6W+KWr+sr6sen5I=
X-Gm-Gg: AeBDievD+n8b0AGad0S/6CksJndROl9bLwp/dEIhSyDoFY+YgkEcQQMQELdkEePklFv
 HGEmTv3r0IA58htVeR8oYLMzijjSw95nQpj1XgzkKthglPEBRTv0xxeOtV4lfVmrfSB9lAwkLJA
 MloORMVoUnd9QdnBwRg5JCvKlcFu/Pov2ZWbJLbOo4jqTn78dEwNPKMVmRAX7rIajlS7gymOI8L
 uKAu5tFsO6TiL+naxGREDlJJfEy93qswBq5c5vLwa0MHt/99RVfpmR0kuRO5ol7K8xA6ueUy0Dx
 ATtEZE7nu6F6UVPZJkb9TE/2Irt/NfpO29PJ30SVgZb7HbE0EQxd2Jy74AsQNYjJN9YdwahS/q8
 BzscYsee6oyj9OI1qsTEr1NokyC0Gsk0ubOM3QKbnrSX3jG+nCm18tQZU5TdgurlN0RJNgP0Isz
 JcLRorzHcL5U2b77raeKnsgmSuk9ka53yvsK8NB5oNZzb5sMboaG4hjtfUwsQVSyR9Vw==
X-Received: by 2002:a05:600c:3149:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-488d684319emr318681255e9.14.1776285127356; 
 Wed, 15 Apr 2026 13:32:07 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e050sm266699575e9.5.2026.04.15.13.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 13:32:06 -0700 (PDT)
Message-ID: <a081957f-4d23-4aab-ba5c-e0ed2cb75c6c@linaro.org>
Date: Wed, 15 Apr 2026 22:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sd: Small improvements around RPMB emulation
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1776231967.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

(Cc'ing Jerome to his new email)

On 15/4/26 07:46, Jan Kiszka wrote:
> Besides a cosmetic fix for the emmc disk image generation script, this
> adds a property to the emmc model that allows to preset the
> authentication key. And that enables to build OPTEE without key writing
> support, bringing the related firmware much closer to real setups.
> 
> An alternative to this option would have been persisting additional
> state such as the key or the write counter on the disk image as well.
> This is still an option for the future, e.g. to model also write
> protection groups or other persistent states. As this requires another
> format extension of the eMMC disk image, I want for this much simpler
> and less invasive approach.
> 
> Jan
> 
> Jan Kiszka (2):
>    scripts: mkemmc.sh: Fix output pollution on missing images
>    hw/sd/sdcard: Add support for pre-setting the authentication key
> 
>   hw/sd/sd.c        | 23 +++++++++++++++++++++++
>   scripts/mkemmc.sh |  4 ++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 


