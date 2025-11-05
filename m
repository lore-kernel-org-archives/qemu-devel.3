Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCCECCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 16:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGg9A-0005K9-9h; Wed, 05 Nov 2025 11:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGg96-0005HT-VE
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:14:05 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGg8z-0002Tr-3w
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 11:14:04 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-641018845beso2147617a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762359234; x=1762964034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03+AmJlxOCFRkEOFhsMnY0jLpet+Toz/tZ+X5tsT4Ds=;
 b=EGeEkOkP3VjDgHHdGOq4T8g2/dIE9r0pu2OZ/8lCVw9MLVsAw6CSuoJmAg48FwXr0n
 CwtTYTuZUt/3scPpER/t8mHTpoBIvhajElIGyBCuNMUmGdRYzqJfWrQVyIbTLXX2ru54
 eXtAqTueSNHZJlLfrSwfqxThoeuqw2lEFAmr+8lKaKGDG1mxYs/NTg4AUmwqta5puxHx
 xn8Yod0Vg25CESUO4Mimof5/UlEqoJiuLOVnyMEKc+/twoXUFQK6M6UZ4HylQfPPmtti
 EB7VVpsTnlTb5AejZ/0FoL4ZNEA0kFTF6IGS43/GivNg9lTf36ZXrqcfBQJvMtGtErEU
 RIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762359234; x=1762964034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03+AmJlxOCFRkEOFhsMnY0jLpet+Toz/tZ+X5tsT4Ds=;
 b=X65XYYAgY9D9T5GV2XgKMfaAi9l9jxizzK9h/F6zrZwQmvZ2LI6yc9++RNcxga/8Mh
 OelOyzwsEX8yce8n+bbgL1wZYSEmSNo2+idcbVsZdJal5rIu4bgHxoQDnxgxn/P6eCB2
 cFqXVJFAXtz7BSL7FHycgCB139aJx30J5dOXj+osgnY4mPqfcihtSgJ45F944CScDFp/
 WgWyWwfBCFZP6VPLHk+shEOx5lYsg6i+78Hhl44q1h+rkE3AJ7v/9QcuC+nZPFRQtyq5
 v2Yt6o2WQQpRYiwCCz63oUx1Rbu/2na3OuXxFKNAanQrq81zgENSgolRryekDmoy0j0l
 nnIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyGDm186hBEtwB/kJBQz5zKS1p89w4mcQY79+xc60omp1HfSjKxjsoTOWDlYC5qEKc6RT2TnbUNj1H@nongnu.org
X-Gm-Message-State: AOJu0YzCFf1MqBY8GQYUzAEkQ8tcza3tuJ4w7h98sSjwLpnXdyZCtJug
 emtuJ9K+iyclhoJp+yuU3FKW4gixTaPeVheR6WGMr+jk0FxfF0WZkqYDF9Qy3xePsEA=
X-Gm-Gg: ASbGnctJNUxIpJjWjuLgYF/RttbxfiDxQnYjwUOgfL1KY9do0+0nw5jXwqwoxdnWXSw
 O8eJ3fwt/hVqjPiXzfj0N9qjJDPqbTGpkI2R5Tq20U8R/e0AJrPnUx3qzo+WkcL+ifGQdEtJSxw
 3BZq3B3iHM1nGIAz7ONeVtfGa/KwZvDo9/AjV0yEQE81gf5ZG2He4SBvmmkd6yOvokr/t/IEoOh
 5t2c/Gp2Bc/+blmg1spg/655SsypiW2cCyRzm9a9I8oUfAcd/MSvSKalDClY1U0fpZYAElksRpw
 JB7mT6ICwxsWGavFspG90oq+QB3ixI4KJLv03d8CCDFCZ3DeootSmk49HVzX9E+fuXQgfJjGepy
 /o5VZzUbyTQeLy12RUhEcySTbVs9YF7F5GDdXDdSl9p99c/YrNA37IAYHVTSkX9iwdMLZhZ2G7A
 j7or3wTs+2yENnDNTKYxNQDg3z
X-Google-Smtp-Source: AGHT+IHKnCmzhMsy1r+PVtWaCidRn4psiUsO14sfxU9ZgLExXUgf5k8aX+2yd6w/YC8zqcoY0GhnAQ==
X-Received: by 2002:a05:6402:5249:b0:63b:dc3e:f01c with SMTP id
 4fb4d7f45d1cf-641058b4ec7mr3590574a12.12.1762359234104; 
 Wed, 05 Nov 2025 08:13:54 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e68057e8sm5619505a12.13.2025.11.05.08.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 08:13:53 -0800 (PST)
Message-ID: <8176d000-92cb-4c10-ab75-3e2d4dee4c29@linaro.org>
Date: Wed, 5 Nov 2025 17:13:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] sd: Add RPMB emulation to eMMC model
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis
 <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

> This closes an old gap in system integration testing for the very
> complex ARM firmware stacks by adding fairly advanced Replay Protected
> Memory Block (RPMB) emulation to the eMMC device model. Key programming
> and message authentication are working, so is the write counter. Known
> users are happy with the result. What is missing, but not only for RPMB-
> related registers, is state persistence across QEMU restarts. This is OK
> at this stage for most test scenarios, though, and could still be added
> later on.


> Jan Kiszka (6):
>    hw/sd/sdcard: Fix size check for backing block image
>    hw/sd/sdcard: Allow user-instantiated eMMC
>    hw/sd/sdcard: Add basic support for RPMB partition
>    hw/sd/sdcard: Handle RPMB MAC field
>    scripts: Add helper script to generate eMMC block device images
>    docs: Add eMMC device model description

FTR:
Tested-by: Cédric Le Goater <clg@redhat.com>

and also for u-boot I got a late:
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

