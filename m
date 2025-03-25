Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20498C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEW-0001Xc-OV; Mon, 24 Mar 2025 21:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEN-0001VV-1h
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEL-0007Pc-7y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so25109095ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866644; x=1743471444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mX3gK8Zy2a7nauIbIaPx5xo47qhh45K6Zu5BdhOcuBU=;
 b=CA3wtZbN3qimhDo3e2CHpeglZovfdVYNDWIo8Vu5sKuPoWxnMrKCt3Wh326w1aBt4M
 l03fdchQfeUKY7NblSM4xuBhZOc9g5c1eCNo4Yb6vVyYZqNjUARGRGsSAvM/K1OypB0Y
 nbLlVExVtNpHkuUgQm6E/S7gdv0z1ri+AKDI3tpNf6kcDal1QhPU/LhzkEFN3HusmL9C
 bGDoLrcwamcAUo7CKccETWwbUzGym1ghcg3tVoBeilolkZtQoI4cVSiKyC2Nc4CWRK8U
 aVLv4DGB2puKgpU83/emapmFdI84gR5TbsJhvKjHTP7Wmq0XaA70l4NWNNv7kxo/GJGp
 DKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866644; x=1743471444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mX3gK8Zy2a7nauIbIaPx5xo47qhh45K6Zu5BdhOcuBU=;
 b=bCApi/V5BFtGut7jBujgzkj+qj0Q8jt2aUsmGxdTXhEETdwC/8QpSKkPhA06lUHBBz
 vVo2p4OyM897U10MZA5DL52MmIpv8B4Nrx0S0C+/ATSd6NPRCnxd4yCAfaxeBQd6BWIx
 dmZukIToALIo08o72/TnWToP9yFNOvAAZAqqtjkZD5Zl2d2wxQm7fhV1IRzyiXjQD9NM
 tMckf/HAwaF4RLnvMfnPKfsW6dTCdkgBP1QSm7QCdK7laqd/V52SXQywk2J7yZh1xAlZ
 IyCeCvWTp8x6uBxhghuCrTnb9bz4oYdKQS0nEzuWnsG8NhPxJyQG+CTi44dEGyIMmLCz
 60jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7GuHSwBElotTzxH6xR+VJ94o7uE9Rk1+019ZSIcq2eZeiqRUQ1LSO8dtQlomTK6ilr+eLQRTGxx7/@nongnu.org
X-Gm-Message-State: AOJu0Yz+1ySGucWW00ssQl0paYsTqCi2qWldj5CQmWJZjxfUW2dTc3Pi
 4n7VtlnQuwzGeWkRMokQGR9Ukuwz12dL/ZfHM2caekKvBo0fvzXkFZOBeD/YW2o=
X-Gm-Gg: ASbGncuOc5P+5w0BmnbCpmnJRY4U1mQgqsu+UmooOeGLeCYM3kXIF9e3MeFVE1JYpL0
 TLhJfRJeoEPVOmdKm7MZhG2yKx10+FEy0cJkbs5KY3ya1ZN2NtcWuqVUcbXgN3l3JbFpqi4r01Z
 oka55rNXg4sSUuEKdETzwX1zEFh8WUh9hoGCbDEawt2JZgFDdllSb03fI+5cbpQ6KYm5podZhrJ
 7X+Jh34jDM98Hc3bVW0QlIinTMNA+6hUOTExr1CYoSSVLnRUCuXYOh6A4////Rsfa1S3uaxxYp3
 XdlgtQILbXpT5W5U+GzWShfHzXiNJWpUVsGulILWyS/KITNLY5+e6yfdpw==
X-Google-Smtp-Source: AGHT+IE5TDv7sjtYB2NJahlNkgyDifJsJg5j9OZ404zRUy+m7T2aBOhVxI9oZPsl23iDehf+Sc8e2w==
X-Received: by 2002:a05:6a00:14d4:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-7390599e405mr18267355b3a.6.1742866643732; 
 Mon, 24 Mar 2025 18:37:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:23 -0700 (PDT)
Message-ID: <c1b15d50-4fae-4930-afda-a8f1b3b55915@linaro.org>
Date: Mon, 24 Mar 2025 18:19:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/avr: Implement CPUState.memory_rw_debug
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Prepare for offset_io being non-zero when accessing from gdb.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 080f6f30d3..e4011004b4 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -68,6 +68,35 @@ static void avr_restore_state_to_opc(CPUState *cs,
>       cpu_env(cs)->pc_w = data[0];
>   }
>   
> +static int avr_memory_rw_debug(CPUState *cpu, vaddr addr,
> +                               uint8_t *buf, size_t len, bool is_write)
> +{
> +    if (addr < OFFSET_DATA) {
> +        size_t len_code;
> +        int ret;
> +
> +        if (addr + len <= OFFSET_DATA) {
> +            return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
> +        }
> +
> +        len_code = addr + len - OFFSET_DATA;
> +        ret = cpu_memory_rw_debug(cpu, addr, buf, len_code, is_write);
> +        if (ret != 0) {
> +            return ret;
> +        }
> +        addr = OFFSET_DATA;
> +        len -= len_code;
> +    }
> +
> +    /*
> +     * Data is biased such that SRAM begins at TARGET_PAGE_SIZE,
> +     * and I/O is immediately prior.  This leave a hole between
> +     * OFFSET_DATA and the relative start of the address space.
> +     */
> +    addr += env_archcpu(cpu_env(cpu))->offset_io;
> +    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
> +}
> +
>   static void avr_cpu_reset_hold(Object *obj, ResetType type)
>   {
>       CPUState *cs = CPU(obj);
> @@ -262,6 +291,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
>       cc->gdb_write_register = avr_cpu_gdb_write_register;
>       cc->gdb_adjust_breakpoint = avr_cpu_gdb_adjust_breakpoint;
>       cc->gdb_core_xml_file = "avr-cpu.xml";
> +    cc->memory_rw_debug = avr_memory_rw_debug;
>       cc->tcg_ops = &avr_tcg_ops;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


