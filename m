Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFA8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIay-0001lm-Cu; Tue, 04 Nov 2025 10:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIaw-0001lU-LP
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:05:14 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIau-0004C2-PW
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:05:14 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b50206773adso1148928166b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268711; x=1762873511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sl777uYVEWKySVAIrZR/hONQAZlkX0Tfj/hEVztDknE=;
 b=rcA/P3jrBRtXTHMzfngF3DZgZ47K/Y5qcN6SjViWcl+lJaOgOPKvn55wnl+IfIrq0h
 y13HrmieGGn1yShkZAlz70pd0hwgALpBzEjdFKhbyUZOefXP/ZVLVGrf4QUmLLiMnbgG
 HlPuBtYfGz+3Awj56c1o5agGdgEEvw8MJMuGA1U4qyuxDNExz2kJMjK16pnHyQIpmaug
 bKSpiqZtQto9a6Tx/F4INjmT/qPi2LlmkIBZIDzhF+ZkdBOnJNOyRdq+04fb/G+FV8Zi
 frjAXQi4Z+sxJxZYtYCNbfGoqSRcWbeJptryt/acg9Mpo6OmXHsCaCu3yXSUKkCvVrbY
 d+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268711; x=1762873511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sl777uYVEWKySVAIrZR/hONQAZlkX0Tfj/hEVztDknE=;
 b=Re51Jzb38tx+GDvYFFGyjBL+/eZSwHI8rsrtOCzApUiSIVixJxc5tPbK03di14VMJW
 vNh7NyWquVYUxnbCLCn/7FaP9aYgfw0RxrbTFYFKfnDQKyEC+Efut3Lq4G093gnaznKx
 8aGU1SqJBim9RdoSxNIDEAf+caMNp9Rn35iNSRvahuHwmuHxAX+D24g/zjXSvoDLkOgK
 4WdmAQULjX0KB7fYhukZiXpzQd5+sphcOTU0u1ExXS1taH2ktTZmtFNAau0KMXAug6MV
 1MhWmlJIEr9tAULnMCZ3+B7URiTT+lMvzmLqbz+pSJvX+8pkNVagXo1xHI209x7cWsA+
 ftAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc329SZSoEriAhCeNs/TmWvU67JSTYmQVtjHZXXefN8hUY3X8lw1sHX/wKskDy6qRT1Bwxf/qN2Wdo@nongnu.org
X-Gm-Message-State: AOJu0YxU6m36n3VJ+8R+V19uaj+6DZCgGyckRsnhsWyMAAdP0ro7SWZb
 tNtv36TEurhpISk7IF1ldUyY86YqzRfD55NmV0YOdEXRVvtZ8eaIje3QpaEVhIvNyPQ=
X-Gm-Gg: ASbGncuyfQqPdZbAS1gzo3fn4ubDYoYba5CHLSMRIh6mDY/HH533W5yM6sHN4y1pXrI
 JhnePfgyp6W4qJjyXb3Zk8gR6u78E4fRzy10OplQjUEBZgwQzVMFcli5jToT1krQuJauJXFVVdl
 iDVtw2fWIZotIkv2FbQQH+GCjiEUWhn5FYUB8HGMcXkFgEjb5EQHHAfBKkUjekpWd4piJQcHGoW
 fZieWkNQPXJ6IdgI/CeqyhW1ThD9rR0HzAeBjBalsfV13Y81ZzqXbHU+cBBeQpMBEtCWFKiokse
 igTSrfbQdWGdOZNPGRIhdzFv303Gm+zVEORRbrXiLNwuJ+Pf3F/Vvy7QRvW5rO7MCg42II6BXyd
 JwRAJBl1z78m/WdXBODEstYxebETVdOgBLhrUzIJyIDZC5J+Lm+8mN1es4sZdKTw5O3pmyxuhpH
 8ZseQrFxdPMMSI7kGIee0=
X-Google-Smtp-Source: AGHT+IHAO2n0aFUBv23vGnRpwgWMTcQrOYBvTDzdIY9WZ4ixPruT+dkFVp59o7nDUYH4XgtpaOTmmQ==
X-Received: by 2002:a17:907:9688:b0:b46:57fd:8443 with SMTP id
 a640c23a62f3a-b7216e509c0mr374455066b.24.1762268710715; 
 Tue, 04 Nov 2025 07:05:10 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa038e0sm237924966b.54.2025.11.04.07.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:05:10 -0800 (PST)
Message-ID: <a7a6f1ec-e5a3-4028-ab91-47b816a2e7e1@linaro.org>
Date: Tue, 4 Nov 2025 16:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] hw/sd/sdcard: Fix size check for backing block
 image
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 4/11/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Alignment rules apply the the individual partitions (user, boot, later
> on also RPMB) and depend both on the size of the image and the type of
> the device. Up to and including 2GB, the power-of-2 rule applies to the
> user data area. For larger images, multiples of 512 sectors must be used
> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
> and also detect if the image is too small to even hold the boot
> partitions.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Alexander Bulekov <alxndr@bu.edu>
> ---
>   hw/sd/sd.c | 69 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 48 insertions(+), 21 deletions(-)

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


