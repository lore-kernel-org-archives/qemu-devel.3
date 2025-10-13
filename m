Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD65CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LEm-0001ga-OH; Mon, 13 Oct 2025 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v8LEB-0001bB-Hg
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:16:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v8LE9-0003ft-71
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:16:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-33082aed31dso4582422a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760372203; x=1760977003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1h9y3HDxUmHFS2mF6HQqQXRyWO1u0/MIY4NUaHZnCg=;
 b=jPCJfdYK6RPJ6X73AOOZ4Jh6fvEP/ekhDqrf4uHjIV6+byJxkMHVgFCipV3gIWzReV
 TqPi2ZPu5FJ8hkN+zWodNeYmd76w+LnSW0iKwQcHL7Es986rMdg9kWvIh1UGnlLbqmHT
 bRWNmQy09ieIIdqsNGxHBWWN0VY/nj09rhgSpam8rK4P/YZkfVAybU0DOHDIe2P5X6tX
 +V8tlNT2r5nmDdSN+dI+ak199YS3rY1moiNl9DHdFb2tuLiwcVKGeqo97vo7lrGJ/Y4J
 6tN66zcKb0bs1kXAT1UlBp8hcBE345MerppiaxHGDwwNNdBk+ij0OiIoGJ5HwCQo5VB7
 TaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760372203; x=1760977003;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1h9y3HDxUmHFS2mF6HQqQXRyWO1u0/MIY4NUaHZnCg=;
 b=MubtlhtVDmbJ1NwKmldaMmO9hexmBHT0iK2dNBndtDzjxa7oDTR6HoqX1r4kFJMQWx
 +XineSLHFi3+1UOhJpia7qkS4tjeusaIRLncZpDFY8j5e75m3ksxHvn0KMAHIJv8LpPW
 4UL80a1ftn0LxKDusRDLO9geGDohdqPa2n9/hjqiXy81nllMo+d0TrM+Gr2HJtaI/OwI
 pLONTYfhEZaTj6oGhtICGRp5Y30DkMmHVk1mujgFgAAcl6rvFALfo3ovibo+vlB5nif7
 7NbLjqXzvHKVqVGjJiiDEZTiSikvde30f/b0A0AGUpi3ZDUaHWoj3g4Ybdz8JH+Aj3+r
 v0JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU375OJhtaAFh4pAVqCHWVVhCh3g50/Et2aojuvX+HxyY6hpOth5GfTJqgZg5orGY2dl0HarMCC37+9@nongnu.org
X-Gm-Message-State: AOJu0Ywf0xCZ+PZzwTfkTzeS/Sdf70cAU0S6+F5+l1i/u+koCFV6+T2z
 2y/dhS2S79LB9JM45nyNpyBlOT4xOWMF1YASNzudmoV+MSBTXw8GzmA7TCPXLVOrVvg=
X-Gm-Gg: ASbGncs7Ngx/FbMXCD8osZFaByc8rKyySa85420YFPmeEpmJStGqj/HuYAVnU+MaAZ8
 rrINOzlqIVTNyh/ipYGEJIYs0T1VxOegdEfW9p9ROdvnglchM/6YbNl+K4sbeTjSB0wbfg9Q6Z9
 hF+9hbOeBwIhMQvDQgPSCSp5iiuu8dpazFDh0j7hFRR6lOjiOwFVNyUkSQ0tSc9/yPhiHt5db2H
 OqULEiabdrDorqFKEXZgqqxyUiugPELmignDg3qqnVnePi+2iGYPn9QVkHvzvLgnc8jWyDPVGLn
 x/6impNRW5qmvdhUw1wvHhj0LgPbFpP2ZC0RPjprNsZ7W+zeSHBdJGA70bEaVBW+kI7PyUJ5l3N
 D9Ha5Qt8OW0TD5KFeWCnNtvaaZtuZ1vCC4NsEOSqRXZAwmGEP1+zUBz9kmKqccdO33tE=
X-Google-Smtp-Source: AGHT+IH2lh2hUbejzzXB6Rjn0/EqHlwSFpvG3oimksxs2N16AQWIGFd9fouz9uVnTqL79B+ADtXOnw==
X-Received: by 2002:a17:90b:3947:b0:31e:c95a:cef8 with SMTP id
 98e67ed59e1d1-33b5139a259mr26967181a91.32.1760372203580; 
 Mon, 13 Oct 2025 09:16:43 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626e8f80sm12599059a91.22.2025.10.13.09.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 09:16:43 -0700 (PDT)
Message-ID: <6dc5ac5b-32a1-46bd-81a0-a3c1db63127d@ventanamicro.com>
Date: Mon, 13 Oct 2025 13:16:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
To: Zejun Zhao <jelly.zhao.42@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
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



On 10/13/25 10:32 AM, Zejun Zhao wrote:
> Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
> mode since it's the only supported SATP mode.
> 
> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/sifive_u.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index d69f942cfb..3e1ed209ca 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>               if (is_32_bit) {
>                   qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
>               } else {
> -                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> +                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv39");
>               }
>               riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
>           } else {


