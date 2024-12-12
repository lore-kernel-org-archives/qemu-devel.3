Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D67E7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 00:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWdi-0003Gl-1W; Wed, 11 Dec 2024 19:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWdg-0003GF-9Z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:01:08 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWdd-0002yF-IH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:01:08 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f2d8a1d217so13513eaf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961664; x=1734566464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFmKzDQC9Q1eVnjpUWHdAZRkqcA1HIwlGW/yL4lX2pU=;
 b=kcdj9CO3UVjJNgb8HCQuE6Xenkqq+GbwMAIt4wSfGwDaWqLw2N3oRKPcyy++5XAs9T
 zU9TcLnGnoTeOGvgEeZhmVMQqffp0doMJ/1sX4J4F8+JlDQ5BH9C+oSBt9zlPEvO8I6h
 nfBK4XOnY38Zxsyo76OCjHU+BAD9clRmUAGxLG0lZbXoEiGE4jTaSoNvy0Z1zMJTc321
 yDuBFNz/OSiU9duX0NCDj4wgOy6ClGxYJbIUMRTe2BbkDpQHCqO9i3HdSSnI9X/CeFOz
 zSPOYz/eQXA5JqEI70kcftLfjQO7oi3sxZtowJlDSwhXI0ehBtfsZ8Cpft1NMQx6GoOO
 JbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961664; x=1734566464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFmKzDQC9Q1eVnjpUWHdAZRkqcA1HIwlGW/yL4lX2pU=;
 b=Q85um7c3iuJ5VKXsoo+zP1rgYKbvmTbP7zgK55SuRAxi9Os6rFQAhZOcW6cc41sYJ1
 jcnmmRkZNNPZJfcs/jVvAA3e3GKkP72PO43aMDRPvdCtEmf9G2AW4q4N6tAdnpEJRLxZ
 ljCKSGpGujQWTRc+bwFVQWj1WHaDZWiEQ9R0XyxEHcxDu23a5hz7b7lE+fpWuVdkdW8q
 5YkxN+1/6G5UJvULdFyYBu4kPUPXnZU76ddmZ83Xm0dorFq7TxqCvMSgQnSNxA+QRmp9
 Qx3TRpayBZa9VLvEVTC3eKywvOyTeii3SfYbbzRSRSRWFquYTuGxs7r6VAZFQiAAqYuw
 R9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs8QtTv5UQGQ6W4ajBIFVXb3kAmgMLJ/s3/H/sBrAY6i+INEcfRTiKPXuprzz+hIOYWZAZtuHi8HIM@nongnu.org
X-Gm-Message-State: AOJu0YyNqPdFE0LcbV/LKw9xq7HMFcgZQolqT0TJl+96og1BEfZbKlgy
 GXAbyYHa4BPerPZeDVfVHASvaON+v/LHoZ0XkZMzog2xnZqiDVNbAbF/NgB5qBs=
X-Gm-Gg: ASbGncsNznQ2OnkpWRGPHuyYTquiCz8dh2jMBOj4Bcx5vJsS8NGUwfCdP9+h/3YQDSV
 OLXO1q6/zf/77SD6GgeEhtfx9bXmvp0+kzWevwma6/e71zXeofAUIpFEyDjRFL5jgAKXmSICwng
 Wt7jdVCKZuO/LfMl3+v/2K9LOgzcQaq7exULabNbvi9BvpVqVuFRc2Dtztj8vMlnUwIxk/fv9D1
 OE6YtaYiN/HJ61Bfwj6gwO6a8heSj6f8XBRXi3lIRUFcAaf2x5EW3wwzG1+jxw0cmWLU7fIeSSk
 oLPrKdd27+NgxigElhx5GTIQGq28kCvY
X-Google-Smtp-Source: AGHT+IFIadzvU3yj3jp6Wgu5sc9PgaHGJjQ/iehWfmT/1mQokNgBH8KaLi+2XuiPP4nGjMxVNVuAPg==
X-Received: by 2002:a05:6871:7a3:b0:29e:777f:a1f with SMTP id
 586e51a60fabf-2a012b4f753mr2714926fac.3.1733961662168; 
 Wed, 11 Dec 2024 16:01:02 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a003ddc6bbsm1022049fac.6.2024.12.11.16.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 16:01:01 -0800 (PST)
Message-ID: <bb002f33-8cb0-4318-8338-8ef0b2d84c23@linaro.org>
Date: Wed, 11 Dec 2024 18:00:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] hw/ppc: Include missing 'exec/tswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> Some files indirectly get "exec/tswap.h" declarations via
> "exec/cpu-all.h". Include it directly to be able to remove
> the former from the latter, otherwise we get:
> 
>    hw/ppc/virtex_ml507.c:123:19: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      123 |     env->gpr[6] = tswap32(EPAPR_MAGIC);
>          |                   ^
>    hw/ppc/sam460ex.c:238:23: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      238 |         env->gpr[6] = tswap32(EPAPR_MAGIC);
>          |                       ^
>    hw/ppc/spapr.c:1617:13: error: call to undeclared function 'tswap64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     1617 |             DIRTY_HPTE(HPTE(spapr->htab, i));
>          |             ^
>    hw/ppc/spapr.c:1406:55: note: expanded from macro 'DIRTY_HPTE'
>     1406 | #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
>          |                                                       ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I suspect that, like Arm, all of these could be big-endian.
AFAIK all ppc reset into BE; the OS has to flip the bit to get into LE mode.
But I am less sure of this than I was for Arm.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

