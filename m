Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE55C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJP2-0004dA-2y; Tue, 21 Jan 2025 13:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJOz-0004cU-Ck
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:55:05 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taJOx-0006M0-3X
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:55:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863703258fso50460f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737485701; x=1738090501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84qcMu7dTP7eyW07/OA3ASU/rt7u1RkTQQ/DSgncH1A=;
 b=uU7CdxRhJriSTqtbqc6KRpx3p8ZJYZmZx1EheRekEZ8xsmiDqtxvDOtYfiGIjtQ5SQ
 mTCzNK8d24VaLxNhe2grRIL7l5jjdj8g5co4N3kHKpCRagVNFX3FX6hDLFNck6K6fato
 84CJeXJaD9wov07s1QDXnNn9pofMGM0fVETKfq+ontYQiXbVUFnjFpFDUaNUn+lM7I7D
 OHYho29PWBhHspo7ijE+qygcMQgHaxodVuou7u7nI1tt/b9A8qHZ825NbGxSwCrcbUiy
 SIv76Ji+rzlLnZ0J9SaKYzkHGVxLJuuTKFiZgTGyV/4xCMTJZFid9IWJu6nIR3PGrokb
 2btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485701; x=1738090501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84qcMu7dTP7eyW07/OA3ASU/rt7u1RkTQQ/DSgncH1A=;
 b=GXtHbk7SDewWrZB7B4nu5cs2alYYPVQWYvTlDtSZxIczHZBY+z14+6Fj7fw6d73Jus
 0a9dSDyevA+qHJ/PR5BEQshedxoWoE4xYOhHDsIC+q6AERuxqFv1X+pRHVRG1zGZolls
 6WahaqabgA0bLlcloUiBksbqCalJpICmTAXfiX2PJSv17K+F5JeuQ6H6wX2MpdQUdqES
 Smp7vj95Y85TMKCpXhTD1/Fc9d3PkZXtqEiigaenoJz7rrfh+DaoeqGXsQ8DS3ATJ6qN
 gu1KNGNiK92FY06ddYHAUfONyDQrqkAHItN4xcwNvWkegYpuOamvN5/yL4/elsi9sDON
 wlsw==
X-Gm-Message-State: AOJu0YyzaoHwChs291NgtMPyZPgo2+xXD9EoDzEeHyS8u/oYD6uiqWDl
 SsgaUYaeEaLrhRwbtKRuagnpeGhILvQVO47B96k6pxEZtpfjWY5cKhcld+xP6hQWpEJTLJv2k9Q
 k3gE=
X-Gm-Gg: ASbGncvdGO7IQ/rOTPFHor6pf28zO54Tyim14gajcW/UjkmZVuhDBrgT1GY8dHugvP2
 IxDWvpAZCW43OXvVeFnZSmdeyUXQjPV0J9h/B4iR7qoSwY1ItnjlkFTByAqix+htyVBUBA6wwPZ
 5RZVy6hFTZpa5UcFWBt1A3aOKySmNq/90VoP4kHDdqdTK2bycjBLl2abxPfRa2X8AJAGEFsYPjK
 wsnYGJcGnxHydhzy3GIRUBts1LIsFgpP58OHk9PqDAO1a52BbBaJyj9dJUMYMEVJyIVfGC5WYFH
 T7hWzg/gK7Dl6tYPlVZdK4zsAvc2NlQnmrshGg==
X-Google-Smtp-Source: AGHT+IHtfv3AgFRPA/Z4nGd/02LXDA5unPV1rqAH+s3uLxvX8l8my9NTuMs9OvgeIF19J9SlWPp1VA==
X-Received: by 2002:a5d:5f91:0:b0:386:4a16:dadb with SMTP id
 ffacd0b85a97d-38bec4fb615mr21269638f8f.11.1737485700983; 
 Tue, 21 Jan 2025 10:55:00 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046b0f5sm191676075e9.39.2025.01.21.10.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 10:55:00 -0800 (PST)
Message-ID: <844aeeb1-2f23-421b-bd11-18a98f733e1f@linaro.org>
Date: Tue, 21 Jan 2025 19:54:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/microblaze: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-11-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121114056.53949-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 21/1/25 12:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/gdbstub.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index 09d74e164d0..8b08ed5cb49 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -110,11 +110,10 @@ int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
>   
>   int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
> -    CPUClass *cc = CPU_GET_CLASS(cs);
>       CPUMBState *env = cpu_env(cs);
>       uint32_t tmp;
>   
> -    if (n > cc->gdb_num_core_regs) {
> +    if (n > cs->cc->gdb_num_core_regs) {
>           return 0;
>       }

Apparently gdb_write_register() deals with that, so we can remove.


