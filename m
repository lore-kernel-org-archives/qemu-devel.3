Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69727CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEdg-0003Xj-J5; Thu, 15 Oct 2026 02:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEdf-0003Sp-5e
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:27 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEdd-0004Hj-Bt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:26 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6cfed5dd071so3604617eaf.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792044504; x=1792649304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qknbPR8kd9tRguy7MnC2M2qVXqvTZhkIcPYWL2ROYwc=;
 b=mHbYpKyD8yeVhUCPofmR7D1/cHgpAwKhZnjWeBlp//BMUkcHSfIRuatQKeetOOh95D
 oelE/tMlSYBz3SjUUtHXV263aQd2Hmk7+Ly03lrw/KFmvf/75/HzkHnC/vRZrGhDLg2E
 ryr3axX6MdDNUAClhQ7CLzXg7E8Vy1/QLwXIQWUTtM9FZiP4R/aNgHlem1B4bCZADc3M
 PhRVs83wEIBweJnQJk1M/0yplqzK4yxeGRBnSgAqRcDMSkW4a3DKWBwV8CPiah7HIo9Z
 X/AwUjARwSgid8yqPH/DD7yJQk+RPZwrPnxgcE+TJvDMO4tRVE1/6JB9RtkaTnZbFuU7
 3i0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044504; x=1792649304;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qknbPR8kd9tRguy7MnC2M2qVXqvTZhkIcPYWL2ROYwc=;
 b=SXLmSO04P+1mg19FpcT7M7VydbEERu6iCy01ycFgFG/+IFLDB56IzlvOwdLlqsfG4w
 JwUYsmWdQinz/oJywgEv6DmOBzgfigRxGzIRwek5fs3SRJwtFjixzidLkA3LwkIfSW4O
 TSefFdz8SalMKR0JI7YGAo/X5IEgNaYoxoBqCuNqjE8whW0zo5JBjHmYmryld6LXFhMO
 0nGTFQFrxYUKlwy7iomr5HMgo4RPUcJ3+ys8tA5FziAr8rJ0oT+CF3sCz6nm+Rv2LtoT
 4eRpeTAjDThvpkHgsSxPJ2Yx6C6XVSZea67jW3SGSNVu19polHBjvwdZ3m1jgtDjGWba
 WOGw==
X-Gm-Message-State: AFq9FYLDHZreE/EjgH/t4I2LN+T/boqCyQELYo0yl2R5ofm7i+cchxs0
 6ePXn3LjW/Ex4fmpJZCaiEv5m2oVCpKvLXpiDy/NdnE6D4XSSyVdaYW7rZn8/n6IpekQwydtt9M
 YUDDaFX0=
X-Gm-Gg: AYBFou2DenuESiDNQRt2bvyC6cjRniXJmLQCtRXt/1xnd58fp/2QS9pf59r6LDNqZir
 NM69NcePQM2NV1hjNfzpXZgQvorTssx2IKVXWR/FJH6AmLS8uQ+UAtE6c4FZq23QVBiHtcb/ByQ
 NYEhFgUl1j8vZwCa4TlDGjx+2PJLtWtfPuSBbO/tS9BAxZRZgfg5nA7OKq0nz2m5/wLCqlsXsYj
 JtkjrCje0w0O+wJbj/1UjTZyOCgb40bxQxcPyRhDLSmttCuT5RDYuQgRtGlrtGbFJ6gyKR4NMRU
 C3qMwJls7qDkuYITrtd2P0DOMJaDWh6FdQ1i7JjTWG8F65SLgRQ7FSmRjJVKBboLPLZbUgh8x2T
 z42ryy3m4zQRRLuNYknSjclv83MVFvFBYhnHTpDyTZRV86nzzL0oWUaW6ZtcJ/KFni0M8+cTD1m
 XArJ5PzePLo5+F1kJfdSm/UKHryfOPTWnESmE3rYh6TpUnpe/yPs/Etyf+JnSVmAWNpsZ0TqLTi
 PIm4wzTyDGuKgrHpYSVzKqB1s5Y2/zvohRpo6FYRq7rH0Vr
X-Received: by 2002:a05:6820:1a0f:b0:6df:428f:f17d with SMTP id
 006d021491bc7-6ef0e9e3183mr12631872eaf.15.1792044503868; 
 Wed, 14 Oct 2026 23:08:23 -0700 (PDT)
Received: from [10.86.151.227] ([172.59.192.11])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f634860481sm8995084eaf.13.2026.10.14.23.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:08:23 -0700 (PDT)
Message-ID: <3cf4014b-12ce-4252-a593-0f230b45619f@linaro.org>
Date: Thu, 15 Oct 2026 08:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/52] tests/tcg/riscv64: Add Zvabd extension tests
To: qemu-devel@nongnu.org, alistair23@gmail.com, liumingliang.dev@bytedance.com
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
 <20261014033907.3332383-14-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261014033907.3332383-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/14/26 05:38, alistair23@gmail.com wrote:
> From: Mingliang Liu<liumingliang.dev@bytedance.com>
> 
> Add a RV64 TCG test covering the masked and unmasked vector-vector
> and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.
> 
> Assemblers do not yet support the version 0.9 instruction mnemonics,
> so the instruction encodings are hardcoded for the time being.
> 
> GNU binutils 2.47 supports the incompatible version 0.7 instruction
> encodings. Therefore, this test must not be built with that version,
> even after it is converted to use instruction mnemonics.
> 
> Reviewed-by: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> Co-Author: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza<daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Mingliang Liu<liumingliang.dev@bytedance.com>
> Message-ID:<20260907152301.1701394-4-liumingliang.dev@bytedance.com>
> Signed-off-by: Alistair Francis<alistair.francis@wdc.com>
> ---
>   tests/tcg/riscv64/Makefile.softmmu-target |   9 +
>   tests/tcg/riscv64/test-zvabd.S            | 659 ++++++++++++++++++++++
>   2 files changed, 668 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-zvabd.S

tests/tcg/riscv64/Makefile.softmmu-target no longer exists.
This should be rewritten to update tests/tcg/riscv64/meson.build.


r~

