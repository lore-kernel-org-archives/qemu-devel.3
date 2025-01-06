Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C9AE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 19:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUsTs-0003hP-2f; Mon, 06 Jan 2025 14:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUsTp-0003gf-N9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 14:09:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUsTo-0006ap-0c
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 14:09:37 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166360285dso215232095ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736190574; x=1736795374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GZ04ROe5zVucSnsi1pG1M6Y22Z5NwpHQGNla8TDV7+8=;
 b=FNVbSjJqeSV2H20IxhiUKQAXECUONIx1OP2rdlM7jChIe4597u9Ac9qJeHCKKjuQW1
 b2XJ1KaRmutTvwRPK52vycj79WvDvpjY4/s2W+dasLZPHLzQWylVZ3nGejj9tk41A31Y
 rW9AnfNbv4tEUaPCzspYGZpdf2/XUNXheHrwdhvJI6XJH07AEpoKyRCvY2YF6kabtcb2
 SZI5OoxD2wbc72tKTEYVbiUj1GiVywJgNQhtcqKC1GcVjwxyse3cNOuf7zDwotSJcNC1
 IY8ka908k9TdMmy2XTi7yE8KP4JokMxR+S+aIUlIy206GAkVX5JJ745NhzIC1JPs1m05
 wLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736190574; x=1736795374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GZ04ROe5zVucSnsi1pG1M6Y22Z5NwpHQGNla8TDV7+8=;
 b=n8QngKpX9bjwfspdS9HcMKLUHQl3dFcCIFoB0HTg/REeGLjJNsH8yFpQr7p5c1TngI
 G44EVjl84chCEBjWAuQUUOuJYUvjCTUKNTXNR1EA9jGmUV1Oi9Br3ACb+K/aT1Rlfcd1
 fqjEn4Bl1Ea+2k6xw8rf/Jg7mbKZbkMqWJWFjkUFFFmI+CXFWz6/Rl/PeCO1tDFcVSdk
 7sPj3z3Rv4jOgK367hTa3Mv8cIOpRDyd8rpIMQd4RvBLwtc52SDSIOIkzwzLXACm4Dvy
 +v21+MkQ6XJZ+qNk1l2D0Oh3GKAzKJ6a0FHkRAuAU/u3K4dVYqs0auG5jkDGuTnxzYsm
 i9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQj3zZoWZBUWU9rZwrU2ylhqoBBvyqcqvx4ExEl4+mW+Lj5nVXN5eD74oV4Zoi5KsM9o3m1VMIuajn@nongnu.org
X-Gm-Message-State: AOJu0YxWh0NhQ7mUkrIFWF1PGyBajhY1/qT5VyYL5we+YV794eOyQPKH
 V3anRF3sObRG/oKDMbb5USa3mDLBACfDD2YTaHILI5KpiivXmczF41OZO/dpaJ4=
X-Gm-Gg: ASbGnct9JA3zLAxvNHLtPOge8LWbnLN+m4j9b3EXgw4Qb2RXISYs8oWzQppeB4r/ag6
 /G9PGLFlxK5vczQO5p+FV5H+0vw8rHNQnmI2cRafI5SFD+PZrQNbDmvmzWWyHIiSJvnuFi9S7v9
 8K9Fo1+jGdU/s4GIrDWfuG0aSnA51FNJEX12s+OdD4BiN2P0gmCyniTwUaYnVa1uxwUSvVoMbp9
 VeXkZnNguU5N6AVxUXWto8gqXmYAGeptau2hwhPpapCQ2YUEkNDXaSsiLq6Dz/z4ZakcB9xWUAW
 KMNQh8yx6pjOkeWbrHgMw/p1k4FYCXighXE=
X-Google-Smtp-Source: AGHT+IEgZXNrKtmGOg7WvHkBxXw/X+uouxFtCvFiWpqGEZY51AeC0ACIx3ZWOZmOAUa1kBx+bF5nmA==
X-Received: by 2002:a05:6a00:4486:b0:727:d55e:4bee with SMTP id
 d2e1a72fcca58-72abdd4f493mr74546969b3a.1.1736190574054; 
 Mon, 06 Jan 2025 11:09:34 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:6edb:f473:a9df:d551:443b?
 ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72b5bde56f8sm11568513b3a.162.2025.01.06.11.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 11:09:33 -0800 (PST)
Message-ID: <57a210eb-1335-4ac9-a0ac-cb636189c19c@ventanamicro.com>
Date: Mon, 6 Jan 2025 16:09:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/arm/arm-powerctl: Restrict to ARM cores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Anton Johansson <anjo@rev.ng>
References: <20250106182343.35859-1-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250106182343.35859-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 1/6/25 3:23 PM, Philippe Mathieu-Daudé wrote:
> When running on a heterogeneous setup, the CPU_FOREACH()
> macro in arm_get_cpu_by_id() iterates on all vCPUs,
> regardless they are ARM or not. Check the CPU class type
> and skip the non-ARM instances.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/arm/arm-powerctl.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index 20c70c7d6bb..a080a6ab79f 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -36,9 +36,11 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
>       DPRINTF("cpu %" PRId64 "\n", id);
>   
>       CPU_FOREACH(cpu) {
> -        ARMCPU *armcpu = ARM_CPU(cpu);
> +        if (!object_class_dynamic_cast((ObjectClass *)cpu->cc, TYPE_ARM_CPU)) {
> +            continue;
> +        }
>   
> -        if (arm_cpu_mp_affinity(armcpu) == id) {
> +        if (arm_cpu_mp_affinity((ARMCPU *)cpu) == id) {
>               return cpu;
>           }
>       }


