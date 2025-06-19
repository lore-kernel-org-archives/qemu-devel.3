Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7B3C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM9e-0003j9-Rk; Thu, 19 Jun 2025 16:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9c-0003cR-BO
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9a-00061X-TE
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so7006505e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365993; x=1750970793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KI6CrA4oK+w2mHcC0b0ookgeee7MFBYt0zd5kwiI8W8=;
 b=IoDpbq9Rq7eb7v1sQKv2M0xMbQb55Pooycw0esjlqMmL6P9KMGq2wPdON0mZVqaDbW
 hEK97YLvZA5YCUniN6SD0AzZrR+3w7wNFMJoDm/AHZuWkHg2bPP9p913Vow58/3wCags
 OI1NKzPj3Ek/y9umUEdnmxC+XGQL6rAuQ8+VY8rY0y+tS/VFsR7EvF93oyD5tt1BhI36
 eL0Nc+UqAr+VD3x4Fyz2j7TI2yDHB3/8TZdjpJHbyB+Wh53238WPLh1NLMSUbpmPI1sy
 8lVXSm08iv8/HNtIVm4qF7i1Slof/vwY+dkyHgPySMQNTerPKr6CWJB7tTX2tKsNvbMM
 0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365993; x=1750970793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KI6CrA4oK+w2mHcC0b0ookgeee7MFBYt0zd5kwiI8W8=;
 b=UIrDXFOAQzCpTvzXDvPDYkAZuOx/mTxEZMaNKo8Y0rtfGGT5fR/FyuLRNMY6Pd/ElN
 ZwOxpJ7aTZS6ocn2lXpP5jEhf/unFIwx+LoSXMIEFVT+rJGDR9AMl8nG/6+Zkuv+Kxj3
 yG6ZYrxbDRRtdw3avg2LxuI3GtQu6xzYzWtKr9xazp1YaEX9cUOzhjwanuDJrOmMVC96
 I3uvYOjepUX2Zm5eaZ32pnPLNaN5GZUYhApxo29wFilZRIk/V6EXGyZgfZogh32Q2J08
 PLn81UXfok+LDgekjcbUXzr+2SOEY0JFE5BVVdTGpiv5nnkn/PALMWok+gbMbGcvHxgM
 vmJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfRKmwfXEg+Vbk7HCFnh2cPtz8NeJY0GN0JCph3IWgK/NQrVVggWSKCYztXPzcGs4h0Vw3HgsyWxJ@nongnu.org
X-Gm-Message-State: AOJu0Yz6xoP1XKk/PBkDQGFout1exCjPWUlOqYv+6/W6a8fvC+/Mq9VH
 hSnIWf8MYsQiGaihsOyyW+eEgwXD2EVXFjvCqxSJYslB47is5kByCRKEpuIqMQ4RXzk=
X-Gm-Gg: ASbGncsSdxIHicaOlNBO1WeG/rAK7ursH6bepEUXdsShK6TzJyCakwZgeNKykOyQpTh
 oQ7XFiCvdXd9GFkt/+G6xz6sC5iZpWZxHuKZJxvSXEYHlbJJZ6Ot8gUvemQcWQHMtA/tksN6nOQ
 10Ey6I+ZbuA/D+LxLfieDanEEcQp4p0Ze3mLhYAFtARkAnzPsrcR9uZ4DIvevFcZu0L9k/FpYVj
 PQp+jDyslDpdwCpBqA2KG5GQ5r7rLsY2d+1v6BHfMm/7kZ84wF2Njs8E+56Cx3n0GkzUyV5g5kF
 weKdf59AtCRhCiFPnZ5xxRYXrOWYPX2U/WwlVsVwBSGsfxlUSVYf9pkxngQ0nCU5fazYV+ucW31
 cl3+/GCRyY7ehmqbRahLZp3QRU9yUwQ==
X-Google-Smtp-Source: AGHT+IFVBbS2HJ4I+MT6tNlfkb9dJZ1sfJK7YiMvPrZO1GIzglM178lcGcmgGe+tcPC8C9sZbJkNuw==
X-Received: by 2002:a05:6000:3ca:b0:3a4:fa6a:9189 with SMTP id
 ffacd0b85a97d-3a6d1322bb1mr293249f8f.31.1750365993312; 
 Thu, 19 Jun 2025 13:46:33 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e9844a9sm39396025e9.12.2025.06.19.13.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:46:32 -0700 (PDT)
Message-ID: <8c04870a-8ae4-4e02-af92-c487feb98dfe@linaro.org>
Date: Thu, 19 Jun 2025 22:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/i386/pc_piix.c: remove nvdimm initialisation
 from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-6-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-6-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> NVDIMMs cannot be used by PCs from a pre-PCI era.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


