Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C34C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADFu-0005tC-IF; Wed, 30 Apr 2025 15:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uADFr-0005s2-It
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:38:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uADFo-0005Od-Bz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:38:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301c4850194so263413a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746041878; x=1746646678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46CMMv13dD0wFfCACL3VvnbxJth6Z8s15blazSb5v24=;
 b=LDE1XqDR5t9V6TtH7m/q6tPeKpkzIh85BznyhgdqMxGNarS64wnh541cojpBSaxnn9
 mPEytFeNSsR10Mvn2N3W1JrYasti0XDfGfX0ESY+5EWjzsi6LW8KR9RQqxUDam4PYdtu
 ik+jbNgMK+uXN5Mmueuyg9dzya9N0Z8NzKNMEhaZlwA3zqYH7OqVKNehVmC34GTJBNws
 3tedZ3g+Yd5b9mXSO5QtVMwpSyppy3Lo4sIwn8o1HTUaO/GzEj1OEfQxkGIw8U4KOGXq
 1jH5VMZRhv8V1FPo05ew0AvwPEaoVkOnz4PgV6ybhjiwzHPDpx1g12MEN2ywjkOamukU
 eU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746041878; x=1746646678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46CMMv13dD0wFfCACL3VvnbxJth6Z8s15blazSb5v24=;
 b=TKcVWqUB4Tpiy/+7T9sUznHmMl4k1ls803tZU+SgTtiq4PyBH3r8Xoy80pknKSe4xW
 7lAmJMknJ6whp9tXB7Kp3NNZR5nudrlCTKpyMklCZHVMwgoWxbyKE7Mh1bvRj6jKsQix
 UPQ+0sU98f+bCG26zYELQ+6LcGZCLAGJAisiMSFZrE6KAZWK+XP42oyStAEo9rOqykif
 WQ7j8TGbY/r6I1SCbrkyXaFNHKLot3vh0TvwQeqi+TCIi7RqU9JTgXHgWmZBdyobin1P
 dbppQhixkMwL7vCPN4PIkH0mYmKXxNtk5r9DHWdkTMlYvNsoiryDHHZ6zuLsi2uiXFOu
 wsUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9M4tWHZZcIr20pJRPuZbSSxlg2VKTJ2s5n+hafC2QMbwdCHVdL6vVoskMdio6coudTmvEjFPeSxEJ@nongnu.org
X-Gm-Message-State: AOJu0Ywx5mqzqhb1XFFJBfVA7ldcc6uEzN13XUCPrSib9oekFVsGtonn
 1OLChoZwmlMD4XqBYMqOE0px1hqHgpuQaFJPSXwVxAtQe5as78lG1d8KT1ESg7o=
X-Gm-Gg: ASbGncuZHzbyTOqVCZ5YWUkAIPuG4n8h5hgHrWQB0OG9117gzYNf3nHZVUsLo8ZRcKp
 iJO7imihTc3sjmN1c8R4Z0qMbGeKtJJzV35Oix+YubHzQrWnTd7PmM42klefJZkdPCP6yxmL0eE
 /dTrYiRWVTfHiHz0VDlY/kOsWHUgGFWr72SCodT7IowrGhfLsMcq/ki9jIkILznM2+SePWL4Dxv
 lt/LrFvdVDGZY3blqOZ4MfJ+jjBIIevEdKPgHlGGy8xWGb1sMLcq5SlNuPzRy5l8ZeUE1kgev35
 ShMKsFMn+Ae5IbD1hYIb46qOt0sK0Al0KGJN0pWm5Qmew2XQumdFGodWeK0ZmxW+ovrwbDYX4Xt
 ozpApRyI=
X-Google-Smtp-Source: AGHT+IFSyb/O5R1D0FrH/3mqO+Zu6tZQP0SvzElaSlsbpqRHa9Obggj09oe2OF5Cj6givspeskY3Tg==
X-Received: by 2002:a17:90b:1f8b:b0:308:1ee5:4247 with SMTP id
 98e67ed59e1d1-30a4012eda4mr286125a91.32.1746041878229; 
 Wed, 30 Apr 2025 12:37:58 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a349fff13sm2258979a91.14.2025.04.30.12.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:37:57 -0700 (PDT)
Message-ID: <96559e9d-e610-433c-8ce6-3220e569fee4@linaro.org>
Date: Wed, 30 Apr 2025 12:37:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 1/2] accel/tcg: Fixed cross-page overflow for 32
 bit guest
To: ~percival_foss <foss@percivaleng.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "open list:S390" <qemu-s390x@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
References: <174595764300.3422.13156465553505851834-1@git.sr.ht>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <174595764300.3422.13156465553505851834-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/29/25 09:03, ~percival_foss wrote:
> From: Percival Foss <foss@percivaleng.com>
> 
> The bug being resolved is that the current code in mmu_lookup() assumes
> a valid 64-bit address space. If a guest has a 32-bit address space, a
> page translation that crosses beyond the last page in the address space
> will overflow out of the allocated guest virtual memory space in the
> QEMU application and cause it to crash. In this case the first page will
> be the last of the 32-bit address space (for example 0xFFFFF000 for 4K
> page sizes) and the second page will overflow to a page beyond the
> 32-bit address space (0x100000000 in the very same example). An invalid
> translation will be added to the cpu translation table from the second
> page. Thought the translation will be for page address 0x100000000,
> checks in other parts of the codebase actually enforce using only 32
> bits, and will match this translation. Part of the stored translation is
> the effective address, and another part is the addend to be used to
> offset into the QEMU process's virtual memory space. The addend will
> incorporate the 0x100000000 and offset into likely invalid virtual
> address space.
> 
> The fix in the diff checks if the target is 32 bits and wraps the second
> page address to the beginning of the memory space.
> 
> Signed off by: Percival Engineering <foss@percivaleng.com>
> ---
>   accel/tcg/cputlb.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fb22048876..457b3f8ec7 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1767,6 +1767,13 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           l->page[1].size = l->page[0].size - size0;
>           l->page[0].size = size0;
>   
> +        /* check for wrapping address space on page crossing if target is 32 bit */
> +        #if TARGET_LONG_BITS == 32
> +        if (l->page[1].addr >= (1UL << TARGET_LONG_BITS)) {
> +            l->page[1].addr %= (1UL << TARGET_LONG_BITS);
> +        }
> +        # endif

I agree something needs doing, but this isn't it.

This needs some sort of per-mmu mask, set when the cpu changes modes.  For instance, you 
test ppc32, but the same thing can happen with ppc64 when MSR[SF] is clear.

There are a fair number of other targets which can see the same issue, some more 
complicated than this.  For instance, s390x in 24-bit mode or RISC-V with the pointer 
masking extension.

This needs some sort of extension to CPUTLBDesc, and a new variation on 
tlb_flush_by_mmuidx in order for the target to clear the tlb while changing the mask 
whenever the target cpu changes modes.


r~

