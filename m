Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6BFC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2f9-0008Ba-BW; Mon, 03 Mar 2025 05:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2f3-000892-20
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:04:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2f1-0002m6-Fm
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:04:32 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso5039758f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740996261; x=1741601061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5xci5jkvGoBu00Xu5PYLiB6b9yJDooqphwzmPuqKxw=;
 b=Ndpn8FMUBOqa01SYYno7XGHZR5HWELwCIcRW63zDd17NFpqlz/FvqUrSgTXNGL2Mf1
 iD1Y7iwBTh0NoWqJlC6aquwwkzCwiuwRtFdwWHHBdBMYeIf7Xy2x+LKYJxQNeQP3Qo7V
 UGKPelQXgub82QE5GLr4BWOpdZ70lwLDPOzfdCfqr7a0Y7aBW6tXCFavQAxPp9EeKVh4
 5uLihWkZQ4/WrzjSnSc7RH+J6ST3jpGiaG1OJbV7JRTQkREaUFmVjOzuv5JJKZLz9w05
 0PZWDcQKhXQlKuM4cxOCQnzZFDm7cSYfHlb7FYXllFozZ+ZeVDxaCFz810+IvtVEmnbx
 16Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996261; x=1741601061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5xci5jkvGoBu00Xu5PYLiB6b9yJDooqphwzmPuqKxw=;
 b=sG+P7g83Jhs1l33GmxsQoSSAVnebk/2oDoubg+S55jh+N79p6FxzCfYQAgtM2qQ95/
 CFExPZrVsg77pObu71XrMK5qrzvnQpj4sQmHq+GPNblnm5Y8mYZPcqvLHAm2Y5OH9SCD
 lO2hN2Bpu9nf7ZijDqn4KU99/q3czbI6xOTwNwTWvOqvxS9h1u02aRx05j0T++aEmvgv
 xWdPEly1AMp2ENqXsz6F5FKjyOUHN6TSpP+Weh6FaTIzY2ts5nYiUSSmJb9oEPsMwjaY
 KOlOvLRYuVgWrUocywW99Tx59qiF6p2ric/EXPH3WhkIwk6btZVzlPfflz7SQrqUFmVl
 NI5A==
X-Gm-Message-State: AOJu0Yz1rcN4a28uW5MZ97BNGFQgAny+Lf0+DiVrxFC7Gs5x1bH84f6Y
 thxQM4wE1RtwkOHA0jr96kTuulFiT1zX4PSZ9Bg29T9oZQfPuvvPoZOwdhYNfjQ=
X-Gm-Gg: ASbGnctP8GC8UTmi8Jr21sZoUxhPfG38puAJkOdYADYjE+8QqpL219OqQYVgd5HZzRd
 TCUawswiEB1n+/tySRDkx3mP23PpPrvL8eYMc6VjfzAHLqmPYspc6eVomqIl1HPrpp8yFwRyPh1
 v2r4we+gbBF88wQ1wUgfJuhF7WJF019av2rKzTK9bHEWmSDYYXiLzlZ3Xi/3cykLNUanfd/xHEm
 iiLcEZ1Nk8ffxVxK6Dg1FgW9MJeyzkp84hfbBTH9Fadfz5s1NBnhLNbXE33YgkW7Eyd3h9q9zjP
 D9FUDqjXq9jnue6piwsoCvadtBBPGDpSiBgoEowZXH/l/wDU4KJHDPZ1T+L4QTfiB6Nq5m58mpA
 HWtYpju6Ymqq4
X-Google-Smtp-Source: AGHT+IGCYgYOmJhhbVT7jU5lZWOrQH108rQzhmL8DtR4YGcNGej4J0nftIJRPOZTRyj/SHJhC4aHjw==
X-Received: by 2002:a5d:5f84:0:b0:390:e9e0:5cb3 with SMTP id
 ffacd0b85a97d-390ec7cd28amr12517735f8f.12.1740996260819; 
 Mon, 03 Mar 2025 02:04:20 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484486bsm14070386f8f.65.2025.03.03.02.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:04:20 -0800 (PST)
Message-ID: <95ddeebf-bb6e-428f-80d0-cbcf14d80df1@linaro.org>
Date: Mon, 3 Mar 2025 11:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: sifive_uart: Free fifo on unrealize
To: Alistair Francis <alistair23@gmail.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, chigot@adacore.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250303023120.157221-1-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303023120.157221-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/3/25 03:31, Alistair Francis wrote:
> We previously allocate the fifo on reset and never free it, which means
> we are leaking memory.
> 
> Instead let's allocate on realize and free on unrealize.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/char/sifive_uart.c | 44 +++++++++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


