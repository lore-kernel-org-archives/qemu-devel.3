Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B1CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYX8-00022o-G6; Fri, 22 May 2026 18:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYX3-00022S-SP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:39:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYX2-0003D0-ET
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:39:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso6432637b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779489590; x=1780094390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYObwEGuwjFu6HWXLH6zCd+BUf+/exQmWJ0x6uFP+3E=;
 b=PiQ1xb50/ByLCrklZwC1DvXHJ0yTYckZ7nfzofr/oSXqcaa/CBkPBItb48Z8KPnpkQ
 ad6+L2lwi6Df3bQ09g8PzlGK6YxUGdZkN0rg1fuYx7+HHJynCEEUpz15RJn2C7fIZuw7
 86Kz08Kio6dKU/T1cqQ6j0dN9GBreYukBj6RYrZ/QPkfW8nhI0KNo4XkW9riuWepFjaQ
 YlhH+dmJtN4Wn3vWDSN74ifqcMVScl/ep0kpit4uk9JFK8C8zUnQGQykkzgIwZXk5pA2
 LzQYYIFE+srTtxIpwjRfInbjV1qgLdsxTDwbQn4rNOnVmEHtxblExrwv3/eorwx2FRHo
 LgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489590; x=1780094390;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYObwEGuwjFu6HWXLH6zCd+BUf+/exQmWJ0x6uFP+3E=;
 b=IDwwGIljIOISj9SHTr3u0x8M7NpyKiFUsjr9EwEWXNgBR2FUJu5k5ho/x8ZPHzqEF0
 AiSiLvlahGifuzuyE0FNEUGfXiQUUKgHaewfWm2po3VnnXYueHrRPlveItLfg3Nz6NG7
 vL0KCSiHT1B1hzLSdHED/XqZulltldl7/VHBcA0K+GEemUgyMMh/NT05Oc+kv3a38o10
 7SXnlxKEpmiNGLNDcso81mxdmJm+IMexrlaEVfvZa01n04WRkK9MJ7QIXw0GHpI7rbKf
 yKqQXJaz/td9vO5674R8eklqTSy6p2TY5isAuqrBnDucY/wiit/OvOsiyiEPIIBNCPay
 28sw==
X-Gm-Message-State: AOJu0YzqO0T95I3Ct1uiCDJGdF1JzudsisiCdcgaDvzHJh0zTAN79eFs
 BQcLH9aPm+hxilGPPlZC4ys8DJWFHmMAS3EkILInxtGnvG+Y3NJCQztDttgJIZW47b37ULbtv7Z
 liYs8
X-Gm-Gg: Acq92OF7bAPyWyr8J0orM8MohHLszDaLI7yWXndHjyZRFz9cGoy7NTKVpSyj0QNsHWG
 hK+OeGd6F4/w53kVvNpGSSkUJQz6jL6g788oI2JPQiTJ9fcsUK015CEJVeubAP558OoEhN2vred
 FOtFibh05pt+8ylMEtP4biONIxpf5BrkG0mXAGxTi+KSG3ZwgJkhqTJdIuhbzrhxdmwjrw/Ydp4
 BWysqgwdvPsBJgPIZ5/14wYozJdBJwqt/SeJwDrEHg5TpuYcV2m9Gx7V15/PestG0bkQMYhOC/v
 RXitY7QSwwAx5Ae9GthK+tFZq+yvHmrGNh93yQ++VddR8saVjS57AcRi+CX2LDeZ8XbhpM6+V8Z
 IE7TEOJcHcya9liezj0iBrluyTw1vM1ochqJtvDSifIzIfcc0W87QSzeI4vJdeNgWkOr9P+kRXI
 BBFhTzWB8zkh5PYbJc11HBeLO9bpYnFzE9BYbkkHJV
X-Received: by 2002:a05:6a00:438b:b0:837:db4e:a35d with SMTP id
 d2e1a72fcca58-8415f32f292mr5584103b3a.23.1779489589921; 
 Fri, 22 May 2026 15:39:49 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164aca86asm2811945b3a.7.2026.05.22.15.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:39:49 -0700 (PDT)
Message-ID: <435a5b39-48ee-4b74-86a3-86d5f00ea169@linaro.org>
Date: Fri, 22 May 2026 15:39:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] hw/riscv: Add macros and globals for simplifying
 machine definitions
To: qemu-devel@nongnu.org
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-2-d1123ea63d9c@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-2-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/20/26 06:12, Anton Johansson via qemu development wrote:
> +extern InterfaceInfo riscv32_machine_interfaces[];
> +extern InterfaceInfo riscv64_machine_interfaces[];
> +extern InterfaceInfo riscv32_64_machine_interfaces[];

const.

> +InterfaceInfo riscv32_machine_interfaces[] = {
> +    { TYPE_TARGET_RISCV32_MACHINE },
> +    { }
> +};
> +
> +InterfaceInfo riscv64_machine_interfaces[] = {
> +    { TYPE_TARGET_RISCV64_MACHINE },
> +    { }
> +};
> +
> +InterfaceInfo riscv32_64_machine_interfaces[] = {
> +    { TYPE_TARGET_RISCV32_MACHINE },
> +    { TYPE_TARGET_RISCV64_MACHINE },
> +    { }
> +};

const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

