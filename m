Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F185BCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLx9-0005nq-4d; Mon, 27 Oct 2025 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLv8-0004X3-L1
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:01:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLv3-0000Pf-Nm
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:01:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-427060bc0f5so2510969f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761566506; x=1762171306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PLGcLctG7Za4dYWV4ICZwURdQTbZRIsw0zDlM3v5vho=;
 b=A1ZlwAIEa5BMe4OC8bUqtL0jrxVxEGl4t3Se5PaH0l3tcgwj77S3QeRReRVCnj7j08
 IinDPFf8XHPDe23OtbQwe1Nv3oT0RHT3zQTGCu0tv934RaIV7IJ66tCl+qwMSrFt5XIv
 64+0hTur3yzjdRSfVZOocP6EgRmgsaamtn2K8PQzZmQhGwY46YlRdA+6xu8GWBbwO7gf
 c+7LCSubcoAkk7KKib44xQuG6kRq4hoRhKNmEkhicRQAe6s4enZQipHET3CCWtdyVHmx
 W/F6h6ZQ4vcGyd3boA4ETLv3K63bUk27R6h+kuGIs6tjCSDV33YMM7GS2lcLnZgjOueP
 FtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761566506; x=1762171306;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PLGcLctG7Za4dYWV4ICZwURdQTbZRIsw0zDlM3v5vho=;
 b=jKrrmc387T0GhDTWDmK2TMyfhVyoR0D3EQCGnM+V0FjRg89sncRZw6D3TtwUQa9+Tc
 mPFrIlL/T+y9SgYU0vmIoE6oVLfs22rhM0YGg4nurwcmh8qL2PANV+Ek+wX8Btqg4r/c
 NK8dY6BEj8FbFnjHhKH5AHbyTAi6HZ8D1vty9+5bYIDWgIX86HAuL6uOzNkOXPI/RhRa
 Qm/xTZSCcow51f/VrdaubK3f3xDm+CE5W75xDEyHAkcr/5BZnPftejGXhSfDDHDFL9Gh
 vZ0xB1dIQ+gmXl8WFqOfkTT0EhMgaZi83qfwlDMXtnVk6HGwqjOw/NqoDZ66GsVLZyAJ
 4z+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiC9kVhz1kaHfmxer2FgTt1ptb2lLQAiNNKmJlltDK/Gu/cIEhZhRjTH7zBnJD9o8paNGPv92I+nU9@nongnu.org
X-Gm-Message-State: AOJu0YxSfrB1uGQ5FRbIUbp1+RYI7h2ejsCR/kdYUWEMXqMk7rz3/FdI
 sqg41Wl+NWBN9I0Li8zJJqr1qPSbwEmIyqAR3aqwX4mWRW0CHLC8Re2opR0IlJvbit2KyamniRh
 rgOs+KkA=
X-Gm-Gg: ASbGncsBV5sMqe7JKAjoQj5Hxp2viVzY9odK7k4s+DDnO4qU7u91TW+EUj3Ltl8AO7X
 ktQXv1MoyOY5+YtPZdM7ehSyRKDetUAtP6Wh5aZVYUjPlsE2TNcU6yLtQaTCH+pN/K2Wzal8Ync
 J7SlZ9CN+/ojaKtorXL/zBKOhjZVIqosJAODZnz2Zexk9V5bHzdd6Y+vIy2EKgeKMDs6tulC/12
 TyIyRSZEXtqrI64JtYpfvj6xazpMcTmbQteo5DahV0HAENJUR9nPAHSnIp+0rS43Ir4nA/8K+Bz
 Yx6+QaYFcppaLHlHLj+CKGEsy/9WHCBCeL8L3wUOAQAw52V9wI5P9hEL816uxngg44Ux2ZAfbQQ
 i2U241Yqpte7ZKcPshVqupu39r+u/mpKThqPEdyk4gErkD1CJHex4LPi5t7/bGi2WG1er4qbCN6
 KPX2dBRQdsal64XZxEt+mZAdDu2IdrwqlalR1i1U4zDkH2HgaG4jIHPIhtXkzchDao
X-Google-Smtp-Source: AGHT+IFA5lQdG3wEcpUVDcxHr0YznpdNBH1fOJhn4oLYLiZia3GVWBWl7OHntj9GSjgdsqgHj61wLA==
X-Received: by 2002:a05:6000:2282:b0:3e5:394d:10bb with SMTP id
 ffacd0b85a97d-4299072c109mr8362370f8f.41.1761566505883; 
 Mon, 27 Oct 2025 05:01:45 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm13766651f8f.25.2025.10.27.05.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:01:45 -0700 (PDT)
Message-ID: <85355b5e-6c8d-440d-8a82-5bae8228f078@linaro.org>
Date: Mon, 27 Oct 2025 13:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20251027112803.54564-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027112803.54564-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 27/10/25 12:28, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> skipIfMissingCommands is not used here, remove the import to silence
> a pylint warning for this file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/riscv64/test_sifive_u.py | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


