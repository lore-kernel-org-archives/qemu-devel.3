Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC301C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 17:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmG2v-0007Gl-KQ; Sun, 23 Feb 2025 12:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmG2s-0007G6-Ls
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 12:45:39 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmG2r-0000FP-8k
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 12:45:38 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc042c9290so5736273a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740332733; x=1740937533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=saX4+z4iFzWou3T41jS4D/dGrd9kq2mQbs80HOa+FN0=;
 b=vh/Om8DJxdmbrz4OiqWpwpFbylkOpD99iPBCd57AgyfsQiuj+c8JH3CLK0de7vv8mw
 2Hpu8BK/Vuu37AXHXEVxFWC29DpCaz/9NMPspDx0+ngeL8OWq2BmUR+et7Xyw1+/s0P5
 axFV4dHfkAF4xwOpbECoEV+Fvp4HraqlwZFJQLTfEOekz8X196qZpdDSy21/4VRG8tdi
 Q+Z+y8r8V/pgLWFRwsqgj/8Dm6m1MhLfp8F6aOtvRPX9aZlRZuS9m6lrUum0uvpYQ9U8
 Jq2/WmwHAjuDQTpbFa5VmLNYKjdHD0VeEFUUTcMwbe2qJuyD+MiTrnXx05vzb15yKZpI
 CZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740332733; x=1740937533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=saX4+z4iFzWou3T41jS4D/dGrd9kq2mQbs80HOa+FN0=;
 b=j60UwgG/MuxvJiIRnchO1cLW4Z6EBQGQlpc36oKH+aFZNTo3kEW26Fie5e66AIXfpz
 0F34J1Tu9EFrawUcqPax1aLtTX6tBj5SPPh2DS18uZPNBzmfrWdLkqYnNxvmwKksvv4j
 Rf5ubzIziFrKxluTFTqISbOulrT36mIdtJZVhBFFo9Qht3W53eXTvsX7tkf5bVYbV+Ir
 ugg05d3wMM96Y5TeDXOKbc/rvVuIvuoRmojPDWVdX5S2BhoOGIGl8vOcODR/n5xyC1lY
 AXOmqOnbb8l7vaQikuxCcofhuE4puXIRydEwt1gaaN6WFB7wwTB4hXLT7a91LUMlOfAl
 1ZxA==
X-Gm-Message-State: AOJu0Ywm1ihNZJNY+b/9iQVfYOUcORTYMEKmHrhGVjRuZJmpXeI0WuTG
 smm1lgOFWD3ZVAQd0ATjp9vujkj1Isv/MnYB4bEbfueuIyyPegeeFokwcwOe38OWzJPzjUr6HWS
 I
X-Gm-Gg: ASbGncsB5cqGSedDVDnqkv1axDRCuI15bwX5vH8MexGfCT/TkUP/YVE+jcbquGDVyrS
 tzKouBHa7fT/GmcflhcJJkmQWeSSQxbz5j61HhlNObnENoLJXhQBaTFhC4+D45yfNrnExzmJMIK
 PKZPLmpOJqNCXmr6SeL3b0yMq8S0XMjz2K3VutaUe6tPya03JfluiI5k10o4YjH0YQOJgAaYXDX
 XQnw2lLgUj3ZhawWmTVA7xYwlOl42dxrnafoSTUJj3pqNVCjffsv42zyKukWbym4JQoN9JKK0zL
 dTGtkh7hpinH+BlIXDOQuKjbp4fAk4vyHrUTXZBYwN8pDNaBgumznkHjsnZVUe1BBFqFLu1su2h
 VRV1beLg=
X-Google-Smtp-Source: AGHT+IFrVfwkUfw1J8+FMsDLoDLfsWynfHLP1Xmh2cxyfn+VAKP4TgnA+Zy5KY30wzaSXlQPZFc8HQ==
X-Received: by 2002:a17:90b:2d87:b0:2ee:b2fe:eeeb with SMTP id
 98e67ed59e1d1-2fce7af3ebamr14953479a91.22.1740332733413; 
 Sun, 23 Feb 2025 09:45:33 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb0606aasm4875384a91.28.2025.02.23.09.45.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 09:45:32 -0800 (PST)
Message-ID: <55ec65da-9027-4ba3-bf89-85cc134e30aa@linaro.org>
Date: Sun, 23 Feb 2025 09:45:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/char/pl011: Simplify a bit pl011_can_receive()
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/20/25 01:28, Philippe Mathieu-Daudé wrote:
> Introduce 'fifo_depth' and 'fifo_available' local variables
> to better express the 'r' variable use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/pl011.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 12a2d4bc7bd..5bb83c54216 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -486,7 +486,9 @@ static void pl011_write(void *opaque, hwaddr offset,
>   static int pl011_can_receive(void *opaque)
>   {
>       PL011State *s = (PL011State *)opaque;
> -    int r;
> +    unsigned fifo_depth = pl011_get_fifo_depth(s);
> +    unsigned fifo_available = fifo_depth - s->read_count;
> +    int r = fifo_available ? 1 : 0;

This is begging for a bool, though.  Both in the local and the return type.


r~

