Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F9BC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5v9s-0006eo-76; Sun, 13 Sep 2026 21:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5v9o-0006e7-MC
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:06:52 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5v9k-0005v9-Hm
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:06:51 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2568377a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 18:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789348006; x=1789952806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ULQuvrUe0mB90Wv3baK1ormQXrZY06F06Pd2Qx32e7A=;
 b=vHqUsooRE412y7jR5rj5+fsUvdQZJ3rxOyRmbBfJvpTDKeludqYnhY8/ToLintvgZH
 rkHzYdcpU9kpeZhnEhw+8ALZHIwuk4kws8FUWHXa8wsLV72U3eV4c76nYk4/v2r9hzzc
 MEQ/pBj6zp9H9BHyH49XxC6uO5ilSQs9VKDob37BGLheb2aBmvnIAqckFseehHz4LHuH
 h32H86niIzcraCQgpx2k7qLpBrW/b8qE+pn12wBO25ip3XICVEQcnggrWHsQxZyzZ3CP
 vpFmCeJ0aWVFw/2a4jwqlvDAEMTJoayU1cyQsphbU/Du6UAcSgG1C0W9mouL8EZi33op
 qg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789348006; x=1789952806;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULQuvrUe0mB90Wv3baK1ormQXrZY06F06Pd2Qx32e7A=;
 b=Ez0/j29tP7Fj2cvVaZDlKN9PpIA81qW6bgh84oxDnz8W/IquLNDipEj1oqXFk5cbxV
 uCYgjrfhxBxIbU+631HuxXmagTeEWwoKvj4pFo38INI3hAU19O8T7Hoz8mpbT5BrhMdk
 Mz30XI3i1aV1jO0aUrYv3jIMFBVImhl/POiDW4VlxOc7E6WojqaQBro9ne2T9Nj/G6Un
 KQ2qxNhUro9gZoCgdwdQ/mbqJTXhLwUGs0QtPA41Px/eKjdSKdTh5YUzzCU8CCQwsRYt
 U8zP4DVGTYnyaeRdNCcIDr64b/xLQPF70rMhPpAY/PuU+5djavtpPRsCFiE0UBkrtRuC
 salA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjy4sdcxruaoy6ecNuQaEQvzJIytdaPeE8EQ5gBh1Uzoos0JSaQpRRN5BGnbD4v9KXo5kR9CzfTcPv@nongnu.org
X-Gm-Message-State: AFuF++kG2Z10f5IKABmNPLbbDVWvwBI8+36Q2Ab7XOGQJVKBA/u+A8WD
 wdO7vdnb2Y9fbz/fpYlVNCsCNMaW/KKDC9hYYv/tyDRIiRtkr0fYI0vWryRiHP3vrrk=
X-Gm-Gg: AYBFou0SSHqBvSSfkZnzzaT1UfxyHb0pyM31IF0RbSx7BWCz6/1ENF1E6c0XWzenMTN
 3i8NK1jYXConU2Tit/zUvhc9Qc+MNBMPvNh/mvBHSZtwdronrkzdAUX3+CL3w8KwNLSUSGBiq81
 NMeZY/4v8QQaGYtPiJrxZPMXeMkHLqveWBht/Xc2X0FQq0fh7gYtcSYpSB/hI0+66ZqByzdAY5n
 UgtUzabRfW8OOWgVp3DAYID7oFmCL33JJwV8NTh0LWEX0xE9Y8zMdieRZAEbP8yrqulIqpWYn1c
 AMdzh/3j0kMZ1zeJcjc+QRWOtT+MrT/D4FZthVhYfnM6L4IMmzwlZg7+U0FKHkhp5QroVPNZGAL
 B4R0oUO3eJ6k3JqX1u+j0za2mUa8lpEurLJv+r3roffLpsfZdBS4Mf9wDm9/fdb1Jn8OOP6yqNS
 mXgLqyFtWRpd+gkGx6pa4AZwrDPSZ/67ABotZNpfqGlPlNXwfsWR0UhJ6/E/bEVtlkaxGbHEpK1
 IN4kMvw6HhXyjG+encSdfLeQK9cQzW5W8N5PRZtIkxy15Ijy9KOA9ZkxRQylQ==
X-Received: by 2002:a17:90b:17d0:b0:39d:c3bb:98e7 with SMTP id
 98e67ed59e1d1-39debfa60f6mr896155a91.6.1789348006493; 
 Sun, 13 Sep 2026 18:06:46 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8f1f7sm19691111c88.11.2026.09.13.18.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 18:06:46 -0700 (PDT)
Message-ID: <9b1ff139-7fd5-4678-bc3b-c472faa6b32e@linaro.org>
Date: Sun, 13 Sep 2026 15:06:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 9/4/26 08:43, Trevor Gamblin wrote:
> sfence.vma unconditionally called helper_tlb_flush(), regardless of the
> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
> next access. Create a page-level counterpart to helper_tlb_flush()
> called helper_tlb_flush_page(), and use it whenever rs1 != 0, falling
> back to the existing full flush for rs1 == 0. This makes RISC-V
> behaviour more similar to ARM's equivalent (tlbi_aa64_vae1_write), which
> already does tlb_flush_page_by_mmuidx() instead of a full flush.
> 
> Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
> than get_gpr(), so that the address being passed matches the current
> addr_xl width regardless of '-cpu' input. Otherwise, the raw register
> value can carry garbage above that width and never match the address the
> TLB entry was actually filled under, so the flush silently misses and a
> stale mapping survives.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   target/riscv/helper.h                              | 1 +
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>   target/riscv/tcg/op_helper.c                       | 6 ++++++
>   3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

