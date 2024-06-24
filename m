Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A26C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 07:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLeQM-0000lN-4t; Mon, 24 Jun 2024 03:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLeQK-0000ku-KE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 03:47:36 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLeQI-0004Ix-On
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 03:47:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso230615066b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719215252; x=1719820052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uh4vqugCBeroJ5ykHMfQ5koUVYO6qEyzm4RswB/7L4M=;
 b=xXJAZ4EiW6G4TtBaDu4AtAEG+PDK6DDVnSRO5HTX9OoaE98p108b3+jpaQMWB6/n91
 4Bkij/JRBGYmSCnBrMwqTMvuZp/8UGi9yeAOrKl+3eaXfSPj2oa9xWOmuWU/6/G4pgNs
 R4EZI4zePPI/89yLidHLjsssBCxTirFR9NLOar7/+wxdRilc/dXpkCwRymIF9WJRDIYu
 vYBSCVbjefvZ0TJHIlxGvQLzNEDedw27tJRctqcctX6Lniy20iI07G+E+MpEhgiA5Zy3
 tRmFz1fU71g+varLU2OSJawWJfmA54AlGPDP0ikUuzGCw6NV8/KEMm1H7qs/x6fpRdwO
 3Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719215252; x=1719820052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uh4vqugCBeroJ5ykHMfQ5koUVYO6qEyzm4RswB/7L4M=;
 b=wKAkRb8Xfg62ZJ9sxNh/V/l/0BWOuOFHVk08IxzuZBCeH0WaozzJ2h/2ErK3KwF0RW
 VbUCkH79L4bbXyCEy3LzyPyiT4eJmx97nF2rK//o7Z554HmOJ7vU6f16qc+yXoOStLvc
 03T7OJ+Zde42g2BOYBrxgjsj9Y6bCknN0txFr3GuGG6jq1ojLnXysyvouQr4LjHMB//g
 fS/OpmSDkcrlOYHJfTlIafdZ4ZZaqqBgY1nPtkT2FR+DtZGcfnrFZ58AMrqSosc5GTab
 VrlQFCRKfhqijmlwnNGgV1HOzBH4tJ2o/mGqUse6xcs4EuEiY4yWwXkGLYjY0b3d6zpN
 8wLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUW5+dYL8TXvTe3ZLYczoolrjFK9h/vJlVOcz/xcLpUNNPtFil8SGYuvmsKoeN3O/W6VwP8nFoZESHeqRU7OWpQKmuPcE=
X-Gm-Message-State: AOJu0YwUCrIfOkLYbEDW6OmWXQis2qz7Jpr8j7cqYi3dxa3YDtb9Ekt6
 vbtHRIG/ssFNfiTUMd/2KXe0yqNHq5gxsEKWlQdGgTDzRXgK1sBcrxuXonE/t/4=
X-Google-Smtp-Source: AGHT+IEKHzZVcCmfSleOVj/zvPH/wxxC6QSq7rLf9oB5fInYHKHL0tcCSJqEE5JvY1BqXvrXDXNNkQ==
X-Received: by 2002:a17:907:8dc6:b0:a6f:e25d:f6a4 with SMTP id
 a640c23a62f3a-a7245c642e5mr246506466b.76.1719215252284; 
 Mon, 24 Jun 2024 00:47:32 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724ba9fa48sm142014866b.151.2024.06.24.00.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 00:47:31 -0700 (PDT)
Message-ID: <bdb11f59-43e5-4715-adfe-1a1a4d7bdf1f@linaro.org>
Date: Mon, 24 Jun 2024 09:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] target/arm: Make some MTE helpers widely available
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
 <20240624053046.221802-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624053046.221802-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Gustavo,

On 24/6/24 07:30, Gustavo Romero wrote:
> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
> available to other subsystems.

Again, you can make them available externally by removing the
static scope. I'm not keen anymore on inline function definitions,
please justify why you need them. Inline functions often requiere
more headers to be pulled in, and behind the preprocessing overhead,
it makes header maintenance more painful.

> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 54 +++------------------------
>   target/arm/tcg/mte_helper.h | 74 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 79 insertions(+), 49 deletions(-)
>   create mode 100644 target/arm/tcg/mte_helper.h


> diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
> new file mode 100644
> index 0000000000..6a82ff3403
> --- /dev/null
> +++ b/target/arm/tcg/mte_helper.h
> @@ -0,0 +1,74 @@
> +/*
> + * ARM MemTag operation helpers.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef TARGET_ARM_MTE_H
> +#define TARGET_ARM_MTE_H
> +
> +/**
> + * allocation_tag_mem_probe:
> + * @env: the cpu environment
> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
> + * @ptr: the virtual address for which to look up tag memory
> + * @ptr_access: the access to use for the virtual address
> + * @ptr_size: the number of bytes in the normal memory access
> + * @tag_access: the access to use for the tag memory
> + * @probe: true to merely probe, never taking an exception
> + * @ra: the return address for exception handling
> + *
> + * Our tag memory is formatted as a sequence of little-endian nibbles.
> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
> + * for the higher addr.
> + *
> + * Here, resolve the physical address from the virtual address, and return
> + * a pointer to the corresponding tag byte.
> + *
> + * If there is no tag storage corresponding to @ptr, return NULL.
> + *
> + * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
> + * three options:
> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
> + *     accessible, and do not take watchpoint traps. The calling code must
> + *     handle those cases in the right priority compared to MTE traps.
> + * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
> + *     that the page is going to be accessible. We will take watchpoint traps.
> + * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
> + *     traps and watchpoint traps.
> + * (probe = true, ra != 0 is invalid and will assert.)
> + */
> +uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
> +                                  uint64_t ptr, MMUAccessType ptr_access,
> +                                  int ptr_size, MMUAccessType tag_access,
> +                                  bool probe, uintptr_t ra);

Missing "exec/mmu-access-type.h" header.

> +
> +/**
> + * load_tag1 - Load 1 tag (nibble) from byte
> + * @ptr: The tagged address
> + * @mem: The tag address (packed, 2 tags in byte)
> + */
> +static inline int load_tag1(uint64_t ptr, uint8_t *mem)
> +{
> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
> +    return extract32(*mem, ofs, 4);
> +}
> +
> +/**
> + * store_tag1 - Store 1 tag (nibble) into byte
> + * @ptr: The tagged address
> + * @mem: The tag address (packed, 2 tags in byte)
> + * @tag: The tag to be stored in the nibble
> + *
> + * For use in a non-parallel context, store to the given nibble.
> + */
> +static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
> +{
> +    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
> +    *mem = deposit32(*mem, ofs, 4, tag);

If you want them inlined, then this is also missing the "qemu/bitops.h"
header.

> +}
> +
> +#endif /* TARGET_ARM_MTE_H */


