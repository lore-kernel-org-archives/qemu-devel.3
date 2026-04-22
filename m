Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A348F94CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFOWk-0001nJ-Qr; Tue, 21 Apr 2026 23:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOWX-0001n8-9X
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:45:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFOWV-0005NX-J8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:45:12 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c795eacbeb0so2028085a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776829506; x=1777434306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TtODQkpVZBngwaRM7V4NBhxwq7HswxHY/LfMv31gYFw=;
 b=jiUhmtYH8cbPblxxNbelZEKay8xmdMQp2grFZqVGfCbQ8w39RQBgdLCshkUp273cZd
 oi5vRm2sc0xof/zMJ29Ero31iywUOWOytRcWYuMeiXw6ZAzOOoaRTOZYAB0jSyTszVOj
 yO1YE2cnVq9bd9gdL6UuK5qPIvkPCIj1pf/7DwbzPKXc5Me+jLFYANFSqn+1LibbUaqW
 mCsxwSm6XppYS4kAbpnMrG3ox5+/msGQ6/GBU5yXD5zfyA3dZoGYOUPyOxr6ziwVI80q
 oTQRQkMXvh+IJTLh4UTMcgHiVc2dQ0y7sPg8y8QkKxSAlaCkXuFbCm0JGI6nIPaNgKCA
 RxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776829506; x=1777434306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtODQkpVZBngwaRM7V4NBhxwq7HswxHY/LfMv31gYFw=;
 b=ZiDtbgOcoS83aXXkIaDxsjenpz+ckjS1tolRke9pKd/PiL/FNFfMW+BFx613DjWBaO
 1CPaVMWtNgvQ4O+XAwgIJzfl4NY8O/Q8eXKwstONZOkTefYuGD/yPlU5Znr1DQjSw/uy
 zoq279J9t8y+O7eaO3QwBDwJjmgcvL3hhchG+ZmYzqnuzlipCT/9hQNnj1ufya1GZFJq
 9MpKEebCJRc4xPzpxkwwOjicjZLsmfpKzdBY7M6L2DxKI4GGA8HB99TjW+cWIQKsFD/M
 81/54nUIFvn5aDUD3Nme0r1PNxaTADFGhNsuGhBi8dZdBpbpWe+jAQM7ccd//Qj6Likw
 VTqw==
X-Gm-Message-State: AOJu0YxIfmblh8o6U2LkJZcVjrLXzQtt27EDUR1RLM64RvKupuzKkQMW
 FSY88Wi4FTVuB/mFrmWPJhQOir4P1HlfhQNuh6i5iaJycJP40dXl93ROUVQTeK57DH14J0kbWVA
 /xVq15sY=
X-Gm-Gg: AeBDietPWXshJC6YhDiTawGh1Y86la1XFKVg9HmeW01X2+Pp5R6BgO9B1D2UESeuJYa
 sf3a1RE6yUmYLfb4yKPW+a5G2kxhUmI1BofT0BdLa9P6NDgUzG3ohFSUgwK/O5a11yz8J2Sj1Rw
 edxtrCcKHKbzw+03uPQKRIqQIQ8t8ZzOqVlFV7CNdPapVcYHraPbBxWlTng9hWxhY7CHYVMhInm
 P2bQYdb0Onl4lg/pvr7+PFF+wPoMWyeyLGC7ee2fChQQP7XnHtzTLEFv4TH+O83scxpvym8PqUY
 24Lr/oAYfkIZ+EZQTOtNYEPK20eX4YjC79i0LBI416KBaUJNZPzt1Marn0JVx2DDr2KctzqdYs3
 zlJOOxhTP5t87NE/oddNcoxbOTROdWmtQ9a+wlzg+28JG2GTIcQeU16L6nXltdOXjngCDRZbCVv
 V+IN/U+qG9mD1VcDRMyWkvEisdCGy5An5rZ+509ZONrCYrLwoRPa8=
X-Received: by 2002:a05:6a21:9995:b0:39c:235:c5d7 with SMTP id
 adf61e73a8af0-3a08d8e6010mr23937544637.39.1776829506027; 
 Tue, 21 Apr 2026 20:45:06 -0700 (PDT)
Received: from [10.72.56.227] ([144.130.154.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f9db0esm11180464a12.10.2026.04.21.20.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 20:45:05 -0700 (PDT)
Message-ID: <60c9860f-3b0b-4f39-b6b5-fb042994767d@linaro.org>
Date: Wed, 22 Apr 2026 13:43:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] target/mips: add Octeon arithmetic and memory
 instructions
To: qemu-devel@nongnu.org
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-5-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-5-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> Octeon CPUs define additional integer, memory, and multiply operations
> beyond the base MIPS64 ISA. Add the missing decode and helper support
> for the remaining regular Octeon instructions used by existing user-mode
> workloads.
> 
> This covers the indexed load forms, cache block zero operations, the
> Octeon multiply family, population count handling, and related
> arithmetic and atomic memory operations in the translator and helper
> layer.
> 
> Add a TCG smoke test that exercises the arithmetic, compare, population
> count, and multiplier instructions introduced here.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> 
> ---
> 
> Changes v1 -> v2:
> 
>    - Fold the initial Octeon arithmetic and multiplier smoke test into
>      this patch.
> 
>    - Keep SAA/SAAD atomics naturally aligned for Octeon L2 transactions.
> 
>    - Split pre-existing BADDU/DMUL and SEQ/SNE translator changes into
>      preliminary patches.  (suggested by Philippe Mathieu-Daudé)
> 
>    - Store Octeon multiplier state in uint64_t arrays instead of
>      target_ulong scalar fields.  (suggested by Philippe Mathieu-Daudé)
> 
>    - Keep Octeon68XX CPU feature exposure out of this patch.  (suggested
>      by Philippe Mathieu-Daudé)

This really needs to be split per instruction, and one just for adding the new register state.

> +static void octeon_add_limb(uint64_t *sum, int limb_count,
> +                            uint64_t value, int limb)
> +{
> +    while (limb < limb_count) {
> +        uint64_t old = sum[limb];
> +
> +        sum[limb] += value;
> +        if (sum[limb] >= old) {
> +            break;
> +        }
> +        value = 1;
> +        limb++;
> +    }
> +}

You may get better out of the compiler with uadd64_overflow().


r~

