Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17742C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgEJ-0004d5-GX; Thu, 13 Jun 2024 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgEH-0004cb-SS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:54:46 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHgEE-0008Bi-Ti
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:54:45 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6f1dc06298so91498966b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718268879; x=1718873679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSosgpSQsH3wF5+acrPONfzVPkjEd+Wi3xrEgOavQvA=;
 b=Ai8Tai6QVbpaP8TJd/gsvdr0QZsipOaxYi2jh9tdrjzS9Ky6OQyfr7BqDE9if11s3i
 zCpfzgZZN3QmztLNwJObP5azwLldoHZPXWil4Azs4mYxccq4+h83JLy695fE+71khOsi
 YU82a490kFoM+Jt67ywr70TgDwASt5B/H8SZjJysbv+h4CSOaNxEtRZtoaCuUJ1iBR6+
 DYHsP0wo1BUWIdUWDSfanNigaV9CqgSICvOiNNcB2+tPkAXBoI96k2v0FGB/gucAF6lP
 OOR40raasvfDzb5l8nKZ1/xxxTRnD3Vk4qeYjO215Fqzl5+tumRF4b2zJklAuiXi5dDE
 QSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718268879; x=1718873679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSosgpSQsH3wF5+acrPONfzVPkjEd+Wi3xrEgOavQvA=;
 b=D+8TY5G1WEubmeXYZsdaKLSc/EibPhuVMGLQKReWuQ0w0yyQrgrC0Gy5cf/gAihtwD
 CUbjFBpwhNWY6Mus0HY9Cbh7UJLWXiotZ54BfvhD6mKAKs6Fpk4X82/1Wo5l0/LzoDVY
 fsaUHaMGB7KA7GPtwBT9cxmmWfZIozaxDQUYP9jsAmrhmwD9AlqCnv521RMebnOGgmnp
 ylF4w8DwI4DBYMDjSwpMaQqoBoBbXmgumx25TRy7Yge4qcAuDzN1piJY2Y+z6I6vjmJ3
 QqZuM0XYsL3iSWAwiTWZilMZ5cci17VdMFgzCzvTZhCq18CdWa5Cy0pcVGLtb8vua6E0
 LhmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPfARe/4Oe6MkOp3oJMBHnu74yk5O9Pwju6IQQ3En/qkdRpEx6syMUEvJsajVYeoLZKghwRIbls7iWRVZRmtn7NFo/OY=
X-Gm-Message-State: AOJu0YzJIIf1sPWPLhDmdnfM1Uq2XI3T0yhH3M0DG/1m0tAMASyKyRKD
 xzVdiv6GNrB48llucirzaML4KztJf5CgGxPmYx9RYpMTlRdag4m7NrgbDwSGjC4=
X-Google-Smtp-Source: AGHT+IFSKrJ8w4FyvGIuF2YLGd5N2judWSHl/BPRtdMcekWFGCtPgkKSJ0KoLlp2so+7sZANrQJZ3g==
X-Received: by 2002:a17:906:6bc1:b0:a6f:3155:bb89 with SMTP id
 a640c23a62f3a-a6f47d5f3c8mr229050366b.70.1718268878803; 
 Thu, 13 Jun 2024 01:54:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da40a0sm50331866b.10.2024.06.13.01.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:54:38 -0700 (PDT)
Message-ID: <31ba8570-9009-4530-934d-3b73b07520d0@linaro.org>
Date: Thu, 13 Jun 2024 10:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] contrib/plugins: add ips plugin example for cost
 modeling
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-10-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240612153508.1532940-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 12/6/24 17:35, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> This plugin uses the new time control interface to make decisions
> about the state of time during the emulation. The algorithm is
> currently very simple. The user specifies an ips rate which applies

... IPS rate (Instructions Per Second) which ...

> per core. If the core runs ahead of its allocated execution time the
> plugin sleeps for a bit to let real time catch up. Either way time is
> updated for the emulation as a function of total executed instructions
> with some adjustments for cores that idle.
> 
> Examples
> --------
> 
> Slow down execution of /bin/true:
> $ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
> $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/4)) /bin/true
> real 4.000s
> 
> Boot a Linux kernel simulating a 250MHz cpu:
> $ /build/qemu-system-x86_64 -kernel /boot/vmlinuz-6.1.0-21-amd64 -append "console=ttyS0" -plugin ./build/contrib/plugins/libips.so,ips=$((250*1000*1000)) -smp 1 -m 512
> check time until kernel panic on serial0
> 
> Tested in system mode by booting a full debian system, and using:
> $ sysbench cpu run
> Performance decrease linearly with the given number of ips.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240530220610.1245424-7-pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/ips.c    | 164 +++++++++++++++++++++++++++++++++++++++
>   contrib/plugins/Makefile |   1 +
>   2 files changed, 165 insertions(+)
>   create mode 100644 contrib/plugins/ips.c
> 
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> new file mode 100644
> index 0000000000..db77729264
> --- /dev/null
> +++ b/contrib/plugins/ips.c
> @@ -0,0 +1,164 @@
> +/*
> + * ips rate limiting plugin.

The plugin names are really to packed to my taste (each time I look for
one I have to open most source files to figure out the correct one); so
please ease my life by using a more descriptive header at least:

      Instructions Per Second (IPS) rate limiting plugin.

Thanks.

> + * This plugin can be used to restrict the execution of a system to a
> + * particular number of Instructions Per Second (ips). This controls
> + * time as seen by the guest so while wall-clock time may be longer
> + * from the guests point of view time will pass at the normal rate.
> + *
> + * This uses the new plugin API which allows the plugin to control
> + * system time.
> + *
> + * Copyright (c) 2023 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */


