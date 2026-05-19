Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB74CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSy4-0003hl-OZ; Tue, 19 May 2026 18:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSxx-0003gw-N1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:31:09 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSxt-0004lU-LD
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:31:09 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-369576666d5so1902786a91.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779229863; x=1779834663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpnf+i9vF2/H8nzj7HU9v0Ca7RU+dHJ9aJ9In2U2m+s=;
 b=E38BUDqwzUhHS1gruAkNEjXi9tdaT+/YrXY7SrFZbrtt0m5oejcLCdhfMEeICf9p+N
 GbtlQDgAtxExtZ+0zf+TaCEr0LpDqjLpQHJmO39xxolO2/lAI/uYv1Eq4Lxh+C1J3PLO
 vFhbe3vsN5echC0aFGfFPGHOWN3ylLHYQATBeaQu9LpmpbJJzs88fB4rw1lYYtuXDPC4
 dEouRNbw7PGruYNsCgXsL74hJ6YDkCdHi4U8mB9LmeLHaet0cgtpkjy5OKeFDJBmX0WY
 HfCx0rFdDhXMEdH6rVrEzEVEKDhbTzqPqRaiJebiGBO5BKKn4ir3USamWtF42y0tNmBd
 tmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229863; x=1779834663;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpnf+i9vF2/H8nzj7HU9v0Ca7RU+dHJ9aJ9In2U2m+s=;
 b=oBfcuxWSWp+H0/VUaARbi5iPnRpnJtf+Xoe5CsYHGGp1pcIXt4DnbILEngKf5uPoo6
 Yt4LZKaQCJVS4Kj/taP/1/ocaS7e4TcnOnVH8cpKXWtxREepM6pprEabSk2iwAXfPC6X
 mhPW7mtcjwcdhbEHHOmbwjvdZ4x1kgm/XCm3lQrKMS1n5BYQSg6TqxkIwOJ4MqGYxkq7
 wKKzLv4MK7V/0aH2riO9XZyMRpuTiiSAgMCHbnrIlazXxFD6b8CkrfqS6AMiVrsKVmsu
 56O6oBH/FqK6JjBV3mbFx83iJcVN3FweW43AI+7JIEN/7GFfqzBHDednj4Wk9jhN79pT
 YODQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yvUAUwgXsp38/wrNXm+wM6x9QYVGyra2meu7mIMSlBNbEzfWMWPNKNbIYKf/+AXlDYauMB5NJE4fB@nongnu.org
X-Gm-Message-State: AOJu0YzGXBktFyQehPqGOfRKU6jTYefQtAM+6JBbPS1gkrYo7SH+mlzD
 zeJEnzkt8oimGYQjgQeRsS8l/BucXWzakNboJ9AYWl1u/9YC5/opAkHNnVRIuFauNq3r45fgCln
 NUOLuOts=
X-Gm-Gg: Acq92OFEesDbSPjfVilzSNhrknovbqq6pH15zonrjoOqYe1hK2SAfJzF62X/Mbjncr1
 5XgIXy3FlvZXjyWwO1r+DdhNn0BiRL7GqUAjG0GklFfFZY5KKgjC5XFZiIcOYKsu5qwYfLUMgi4
 V35PGPqb6KIa3/zv5TqQygDsI5rlwFOawiKBUeZ47U2lncn1IYBRVH1e0A74KRCxjCtNdECaNND
 1gxMxbS8O/hmGhdwLen5f0hAO6tkLwFUvxsV57gIcDR5vhSEK9AO+cnVofsLpogokrOEx+Epb04
 2w57iynT6YVCCKA/Ckf2TsRTahN95WrbDCT3mim69vglVSaCU/46MTxZsVOGUt0WkaQMoTj/VG9
 THbWOuX9yUYFylJO7ri21M8qiW9ZowBc//swTNo6nMkCOhCXoCfK8rPATKkWBANqCtiijTq6Rxp
 r6LqYFzQivk7fzmwv2RyRQOSlRJzMJpTr2tacgZR4DqbwSXco=
X-Received: by 2002:a17:90b:4c49:b0:369:bddb:79bd with SMTP id
 98e67ed59e1d1-369bddb8547mr10216124a91.25.1779229863347; 
 Tue, 19 May 2026 15:31:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb08d06csm17743703a12.14.2026.05.19.15.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:31:03 -0700 (PDT)
Message-ID: <25bc66c2-c19d-415c-a213-225cc2ebea9e@linaro.org>
Date: Tue, 19 May 2026 15:31:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/tcg: Explicitly check for 64-bit
 z/Architecture
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519171240.97420-5-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/19/26 10:12, Philippe Mathieu-Daudé wrote:
> We do not support the 32-bit ESA/390 target, only the
> 64-bit z/Architecture.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/tcg/multiarch/nop_func.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_func.h
> index f714d210000..26d3a76eb62 100644
> --- a/tests/tcg/multiarch/nop_func.h
> +++ b/tests/tcg/multiarch/nop_func.h
> @@ -15,7 +15,7 @@ static const char nop_func[] = {
>       0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
>   #elif defined(__riscv)
>       0x67, 0x80, 0x00, 0x00,     /* ret */
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>       0x07, 0xfe,                 /* br %r14 */
>   #elif defined(__i386__) || defined(__x86_64__)
>       0xc3,                       /* ret */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

