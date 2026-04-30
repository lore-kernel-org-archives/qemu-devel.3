Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D71AFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJvO-0000c3-8o; Thu, 30 Apr 2026 01:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJvM-0000bE-RD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:26:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJvJ-0007Tm-2y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:26:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so331576f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777526811; x=1778131611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YG6Xk6T1R7UKHPCPn96bKnQlgFcjVxcvVzUsJEDJ1R0=;
 b=cyquXFXJsB005nRILmCy1zhq2AkedNCVyu7UYWVNMmL73daWxNsYKYS3are8PkBpgJ
 6tzv3TTfkFaoMD7H1AKIH9mU7FQbXdLFC4+K2L0kahBqsRUAfdq00ZHhLQxuowPaDIVV
 Fnwvj6ncRhxUHQFjBiAt4LJB7CI7vU0JvVijCo6PcZzymRSctklAjd8waAVBX2hBoUzP
 I9SsWJ+Pje7y2J0ExOMnCG0Xa4XkGLC1ol+XL8dAZjMn7doy3uTyubvZJMm66ZM0yx2C
 EJp0ATDVHSe4fHtPJlSsi9EZeqUh5Y0rkOfQjksM0o2RGrW3z/gmRY5vqLe2hMFzenkp
 uvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526811; x=1778131611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YG6Xk6T1R7UKHPCPn96bKnQlgFcjVxcvVzUsJEDJ1R0=;
 b=cfIVRBXxFC+UEzApJmfeFo7fjSY8te+A+T0t0itb2HIze4FWCCDI6FOP2DAk0U657j
 1R0nJfjLKeK4AahHUvCY4bYQjdXVK5zjjZoy2Y7RoWKlHcz5jxhnciSH0KI+xIasnWKe
 DZUIoeAmvIFqqIUYOYP06N9dqoUr4MTrEEQkO9UTEG1BU4aPZO51sWUVF6yr6KW2Yg8/
 7fK+6LLKm5KX8BHX9ufjkYUapBZrPcZ8xzYR3tJGs0rZc9ZGOx5lvwWybWn/LkGaz6j0
 agRQ0PI46jTuG1JLatlR/XI8sh1cZsAnmkKePO/995Mnf44Fhki/jSzb6rhjFQ8CCIPa
 nI+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lOX6PGgQDW4DWjnTPb/vZOAAY7E5h4xP3Z61ZySlbXj/rBSgt1dJEXUNn3Z5lfgAe+fbJH148cwZV@nongnu.org
X-Gm-Message-State: AOJu0YyiumI5l+egOdWHRjYwzoxE3pCn+YGPOW+IvZGcizS4iFaq78p8
 5irWWVs4mvfs/Th9cJvqDH7kdrQ8ms7hY4Nr6pd+cQ/A2V7EuQ/Nu4sTl1ZVcPsd4Vg=
X-Gm-Gg: AeBDietKam33EQ3bU//Z4imHcYHsJcV15Vjc5K5bdyorFwssKwKU4mv9lLBbxb0CtZq
 8K6HjDEhFObD4wlr3z/k4SYWEhXwEu3njztle89JKVRNutu8oUTeMm9o4dyEIVRG/AIMc59karR
 ojhqIReWaC7eNQjjv4xI3Fh9yUT6Y/8QTuyVe7Evzmc6LSMF55JhcwSCyJu+yjrun3QDkAb9hk6
 MMmxfAhdZC5+3cepzyl7UoAyc1O/kbTebECernQmXdjFbSducn2EDL8sMALO64PRBWICwOo/fcg
 0xu83j9WD7gNGDjkBYaOyZGTISnSXNIc7P02LvuKupdK7vcTjgDA5SyCIULeAsHiod8AFCaSWkL
 +CKVWR+ZJU+UNUPCp8sJrwQXwK/JsknfK6DyRCsq9W3OOWhEzOIPYbvZdObNaFIA4XZ/qecafzB
 3/n3NTM0diza+yV2sgnEEEPdkCKXm86smYDdz+VoKojfAj4ek2LEBtw2rDCyGa07qWN0e8ImEHL
 nKT
X-Received: by 2002:a05:6000:290d:b0:43b:5231:e94a with SMTP id
 ffacd0b85a97d-4493ec61b1dmr1875026f8f.30.1777526811385; 
 Wed, 29 Apr 2026 22:26:51 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e60b0sm10201138f8f.31.2026.04.29.22.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:26:50 -0700 (PDT)
Message-ID: <f86ad894-0976-47fe-beba-0f7714edaa67@linaro.org>
Date: Thu, 30 Apr 2026 07:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Remove spike as default machine
Content-Language: en-US
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-2-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430052218.771358-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 30/4/26 07:22, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In QEMU 10.0 we deprecated the default spike machine, let's finally
> remove spike as the default and require users to specify the machine.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   docs/about/deprecated.rst | 19 -------------------
>   hw/riscv/spike.c          |  1 -
>   2 files changed, 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

