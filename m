Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A151C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6ry-0003Af-M2; Thu, 05 Jun 2025 05:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN6rl-00036G-Nu
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:26:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN6rj-0003FP-K2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:26:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a5096158dcso610469f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749115586; x=1749720386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pracb5qXlBkFu3b5DbhIEZ21YPoA0bxcZgfKbvcNdtQ=;
 b=hlNQV6KZU3nDn1RsRU6bqV/A85T6nI3GfktOiTNnVE8mM9b9PhjiiVI+P7Y0LdsMtc
 vnMXTGBYg5g6/zAhok6Loo4RZlUcntBM1H/jq5x9k9yC+ALbLPskpL1hMh2Uk33/pTrn
 mPAhY1ArsShT/VQhVIquU3XS0jzpMAiDQb8cBpgWXJ1eoIeIhvam4qTFrRAKcLJotA7f
 O2S05aEuRSNXKDnism6EjFs5ksHBX2qVxoqubjaANVe48iyAR9+I9ozaAhs1xrXRnK5M
 PjEtLaRmn1IMINdBeZXvG9fuSJY3qc7MJ74Qly1Bdix3l2XiJQ/CYcj4hX53884bHldS
 wTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749115586; x=1749720386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pracb5qXlBkFu3b5DbhIEZ21YPoA0bxcZgfKbvcNdtQ=;
 b=QoC8GnOEaCitOXcVRAvUhzWGTGoZh3CHOBQS4b8/6pOlJ4vkogXMclmWAXdREY02f3
 /a/kbrBm7y6u8OrJku4c5mrGmNLk9kTJAlTHOI/w8hCZN3qxk3UABSmVugiXPefY8fuW
 AWmVv7mri7thkhZsYjdSYf91dXi4mkgt7OUQn2zmBrvuc5IXKpXxTZJv6JPD3g0/5V2b
 Nc12StfH3OIRfeMn3uSNdyZ5lxsQSj6upFuNItTpBa0FpmYw170WKyNgN61MfVlrIj6D
 wcRw0uo7Tm0EwgYaubtWs8Zv5YE4a8avwMk4KtHgR3Ne6TFz85COv+wnJe/DDSJ6u6t6
 IoHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5EZk0szXZrfVXlPq0EP1joFT3sXCxh3kLxf+joMEFDXLZ12Jn6aXxqowlZX9h75xyY6wEm/8PeQ1@nongnu.org
X-Gm-Message-State: AOJu0YwUVuMbgjmJRO8MhkT1ILGxGnX8ahuE7sbfic2fGrpsUAeHCDun
 +2c1jzW4NRjjL8iGOEuqaj1yBxILKqVUnSG8WKA2zWppFki1x4/2vUKw9occkT0bYBAThV8Esjb
 vM2rBTfI=
X-Gm-Gg: ASbGnct6aLn5D7dzCsvbh//UZ9QZFdjCvAgxzeNNI/CeOpHElZsjFhDE5FeIJ6c9Kp7
 U1ZRBpgcLkN3bl4Qal6q9oPx2kh6yLwcnfaDBm4ZqbUJ+JU8nhIJddRnZ0vC4W9kZ7Lf3TnG/aG
 7Jpy5L/LsKKWj9jeY48yV1XDGLpbY/6Q3Cs9P1yk2cGlNbcoot79mKlOsv4Lz8b7qtzzKTr5ZoL
 k+qYa5nYZw0lITF+G56jwkGIErL+leXwx4LLIkd6v9PogWxoZizcPuO2R4qK9fiWXA3oYzReZKX
 ibX8rg74ntCr+gtL2SyPocVngOI3w6/LdEKk7Rb4tp8FwKvmdWCVTNfpNDuZ5cewnFuLiy4sGGN
 pnotbnAXQsta+Q0DllRhnXwfmDsHmuA==
X-Google-Smtp-Source: AGHT+IG3AF0Pep3vWPVa77ctNAZKYiXLcEOtaiIkYUGkRx3lfmxIEK1IaQLEiaTJJLrlixxZf0grBA==
X-Received: by 2002:a05:6000:2089:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3a51d9249aemr4978428f8f.2.1749115585669; 
 Thu, 05 Jun 2025 02:26:25 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb177afcsm12576965e9.9.2025.06.05.02.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:26:25 -0700 (PDT)
Message-ID: <0b6b429a-a3bc-4707-9e94-67d9fe8cc363@linaro.org>
Date: Thu, 5 Jun 2025 11:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: use qemu_chr_fe_write_all() in
 SBI_EXT_DBCN_CONSOLE_WRITE_BYTE
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250605090012.1268809-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605090012.1268809-1-dbarboza@ventanamicro.com>
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

On 5/6/25 11:00, Daniel Henrique Barboza wrote:
> The SBI spec states, for console write byte:
> 
> "This is a blocking SBI call and it will only return after writing the
> specified byte to the debug console. It will also return, with
> SBI_ERR_FAILED, if there are I/O errors."
> 
> Being a blocker call will either succeed writing the byte or error out,
> it's feasible to use the blocking qemu_chr_fe_write_all() instead of
> qemu_chr_fe_write(). This is also how SBI_EXT_DBCN_CONSOLE_WRITE is
> implemented, so we're also being more consistent.
> 
> Last but not the least, we will duck possible changes in
> qemu_chr_fe_write() where ret = 0 will have a 'zero byte written'
> semantic [1] - something that we're not ready to deal in this current
> state.
> 
> [1] https://lore.kernel.org/qemu-devel/ CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thank you very much Daniel!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


