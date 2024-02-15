Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A2C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radIv-0007cP-7X; Thu, 15 Feb 2024 10:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radIt-0007aY-ML
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:05:35 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radIr-0002mU-W1
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:05:35 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d180d6bd32so12677831fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708009531; x=1708614331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tF9qU0lyK06ASs2k51+r+DszZJGFbKUOtiB+NcSe/cs=;
 b=idzy2y5ydn19ZjMPGwgYXFpxv8QOXdVvUgevC5xOFEJ4qdIlmubAPriQNNLY08j5Li
 D3KSO3+KqM/EmK0168S+ZbPWkfAg+7tA2TNsbjXUUQkDQnZcBhgAzx1Pu/qxHMJ+EkKB
 p/x6dvRePVjTXEIYDwwLj0i9zw8z7hpU5Jf41dh8hWebyZ9BEZUyqmErXtStS/MsPQG/
 t33JAMr1Q1c+lMDOLRmYLWBIdaRmgaYUQP9xcPPLdk6yFyqfoEzCxinD7Zlt+6M4GeTr
 nDQ32EaW7bvXcy6RHGxxNs51Ev29xVnTeFYt/b0L8auRhqtg2RLqTRyoPRNkovBlaV5k
 Thsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708009531; x=1708614331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tF9qU0lyK06ASs2k51+r+DszZJGFbKUOtiB+NcSe/cs=;
 b=EAxFzF8/mdy1Eruul7Vo2vHEV3RQoFM8IM9Bv9I+5f8CjhlJVYwDaHoImpuGHyU6jZ
 zv+vhg+vhnylBa3YEhG79Wfjr7CFicTJ0v4/CC3/6tTFslRMzgX+DddSsa3DGtsCcTTM
 ZSR1D9g3ZVnxZ8JxOW+X2l7ddKh4TBA4y5C0v4JajH6LXZGToy56ydJdcMqtina6EkFj
 XhsVMcVBj6I1Ts8J3yB31XOzR1MSKe7DtADKhxnlmqyrLwvrCrfD0ku4yTFCJ4acuzU/
 QoLRJhM/aMjvuKm6+ybzlPIGPfdVXNS7g0q1i70QufWVzPMewg3ttD1uBC8xgzQ+viXH
 dLAw==
X-Gm-Message-State: AOJu0YyaFhDA63Shn27JI0fFQAos4Q6M4klM7sxbGKppJsdafeOFVSEb
 E84UFP4X++AseykOWxPliOD/tYk1Kd8rgHuBH3O3fIgsQyafvbmN7KdKxGtW3pXwsOOfTeajBZL
 k8AA=
X-Google-Smtp-Source: AGHT+IGnElvjvP4Ex+VQ9OhyGXuqcKUjD2SMseAPxvbCP45gGM7T4X1Tan/jWgVWJ31DiAxVH3fKCA==
X-Received: by 2002:a2e:7803:0:b0:2d0:aae6:bf2e with SMTP id
 t3-20020a2e7803000000b002d0aae6bf2emr1567208ljc.34.1708009529254; 
 Thu, 15 Feb 2024 07:05:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c224100b00412260889d9sm1206601wmm.1.2024.02.15.07.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:05:28 -0800 (PST)
Message-ID: <1f5541dc-2441-46f3-8fb3-6eed295cc3cf@linaro.org>
Date: Thu, 15 Feb 2024 16:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] hw: Strengthen SysBus & QBus API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow
 <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240213130341.1793-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/2/24 14:03, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (12):
>    hw/ide/ich9: Use AHCIPCIState typedef
>    hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
>    hw/rx/rx62n: Only call qdev_get_gpio_in() when necessary
>    hw/i386/q35: Realize LPC PCI function before accessing it
>    hw/ppc/prep: Realize ISA bridge before accessing it
>    hw/misc/macio: Realize IDE controller before accessing it
>    hw/sh4/r2d: Realize IDE controller before accessing it
>    hw/sparc/sun4m: Realize DMA controller before accessing it
>    hw/sparc/leon3: Realize GRLIB IRQ controller before accessing it
>    hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
>    hw/sparc/leon3: Initialize GPIO before realizing CPU devices
>    hw/sparc64/cpu: Initialize GPIO before realizing CPU devices

Patches 2-8,12 queued.

