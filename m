Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D367BF99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEE6Z-00044g-MV; Sat, 18 Apr 2026 18:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEE6X-000444-Ni
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:25:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEE6V-0002ss-T7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:25:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so1104532f8f.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776551130; x=1777155930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zbcV9wQ0sMke8oFGxVdmawqkZi5scz9u6I+J7vEifXI=;
 b=PEO5HpLl6cvrUcVIk/auyWZQcZ5aSJmzJF6r9nkTFhRNox9RSeb22CNk7WpN0iB9ZM
 EQElIG2Plv63A7dqi230SbSO6OUQTQG2JAfexMxZBvf/NBFLPA29Yp7XwPEdrjNyVLWT
 VxJ6oQrZWvTx5SXb57M9+SC8tI27tYmhI0V4TYxQhZP+lzHldRhCvKy+EI4edvZJUePM
 Hwq7iJUUS44m9u672fXCo5pDTQeSH4asc6wHqXj/e2/3AvDomNVZvcrNcF6UuS92Aztk
 lceCWl5EcF5NxnOl/dpJDPgaf0OUPnHuRLzGxT5kJuamivLbh0H4GNp4WVHY/MJjWBDD
 KALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776551130; x=1777155930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zbcV9wQ0sMke8oFGxVdmawqkZi5scz9u6I+J7vEifXI=;
 b=sN/XPkZst7nE4/pK5WuGVhvDZoUZfvdMXYM/5eYf6vLvzaozzD0WNPWUBUk0oN01fI
 LPSuJTLfYZZKncxOq5ecYKnlGp0jKe/qJBr35kIXBUUDAwm/uJc4EMCGX92licABip+A
 lCRD9DKCKYcOnaTqNnu6xo8g+vahS1XW42m37v31TpMJTHZ1w278bC5Ylp08L+SFOB+8
 735AefjwkD8R/Eylx3bAH+wjsrPWSO+3vLsyZuXpikq180VGYtqBvkK2sDDo2yaH7Joz
 cAFcHqmLiWF9ekcN4osN+TRLAlJNUCKTMpH9Hq8KoYFWpVHX+/Mj+Eyfr+D8FleeW54i
 1H/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/saDpjFmtfbKLode2qN5T/iTgYB3At1PFPLjagS/4VFeboNqKHif8HU4GUB6Iyuo8AODibA1dFWZP4@nongnu.org
X-Gm-Message-State: AOJu0YzPQhsa63O7kJ67algD40N2vt1TUi7wz9hmzBFHx5jgU2SZp36/
 7HjSD5w6tQafXmHXU8uvdlsVyguE0eVhjYG7zI96tUq956Dnhc6oI8Rt5bSdhiy4aGU=
X-Gm-Gg: AeBDietHuES7mxrE68ulZPTysFOEkrDKSEUBqnO9eQ4E5LdkA54BPdUVO62q8fM6aJr
 ErhPBowuY1ZZhTaT8J5qmqKm5il26j9WeW1ExLdXSwMy/BBKGe8zice8rW4OPgV1nwba/qAOOrC
 C/Jr6mvxLVXQCtlxKNw5ISAQU7ykUQeHk4Lf0US0pZL9Lm6qkSwLLIU9zmn0AOJyFSfBpkEb4yM
 Te5+mWwmUpamrbeJnBDMohiFYbwwCUph4mdmUAdWHNCabP1HcJScmEH5LHBzNTa6QqhY5dtPp0I
 DRaKQ4aEw+GcsmqQSeG/y0Qh0B2KO5yWt3pQOpsaWJ6MooI+cpI4ywv+OhEb5NO1PX5rcm9QnK8
 LGd8VMui/daXxTnvqEgRsVRr1nfIuAkR36o9jF3xy5YT9suWxIfLgUSmBj5lsdHvoqQa9eBjYaT
 q+PUJ/S64Fe27OcpZ2TPfFV+w8FRFM8UzjLh9r6lkGIaNez7Sw90HwqQz4TGR2zed5uhjG0rGmP
 2rJ
X-Received: by 2002:a05:6000:2f81:b0:43e:a638:2507 with SMTP id
 ffacd0b85a97d-43fe3da64a6mr12004137f8f.8.1776551130094; 
 Sat, 18 Apr 2026 15:25:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm17109618f8f.25.2026.04.18.15.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:25:29 -0700 (PDT)
Message-ID: <5f593c69-e7b2-4df9-9a8f-342ba767c018@linaro.org>
Date: Sun, 19 Apr 2026 00:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hw/core: Implement new cpu_translate_for_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-15-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/4/26 19:31, Peter Maydell wrote:
> In cpu_memory_rw_debug() we need to do a virtual-to-physical address
> translation for debug access.  Currently we assume that the
> translation is valid for an entire guest page, but this may not be
> true if the target implements some protection regions that have
> sub-page granularity. (Currently the only such target is the Arm
> CPUs when using an MPU, as in R-profile and M-profile.)
> 
> For TCG's emulated accesses, we handle sub-page granularity by the
> CPU filling in the lg_page_size field of the CPUTLBEntryFull struct
> to tell us how large the region covered by the result is.  But we
> didn't extend this to the debug-access code path, with the result
> that debug accesses might incorrectly fail because they are looking
> at the mapping for the address rounded down to a page boundary.
> 
> Provide a cpu_translate_for_debug() function which reports to the
> caller not just the physical address and attributes of the
> translation but also the lg_page_size for which it is valid.  The
> fallback implementation calls cpu_get_phys_addr_attrs_debug() and
> assumes target-page-sized validity.
> 
> NB: the "return true on valid access, false on failure" follows
> the same convention as TCGCPUOps::tlb_fill_align() (though it
> is the opposite of what we use in some other places, e.g.
> in target/arm's get_phys_addr_* functions).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c             | 32 ++++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h            | 32 ++++++++++++++++++++++++++++++++
>   include/hw/core/sysemu-cpu-ops.h | 27 +++++++++++++++++++++++++--
>   3 files changed, 89 insertions(+), 2 deletions(-)


> +    /**
> +     * @translate_for_debug: Callback for translating a virtual address into
> +     * a physical address for debug purposes.
> +     * The implementation should fill in @result with the physical address,
> +     * transaction attributes, and log2 of the size of the aligned block of
> +     * memory that the translation is valid for.
> +     * This must be able to handle a non-page-aligned address, and will
> +     * return the physical address corresponding to that address.
> +     * The attributes must include the debug flag being set.
> +     * Returns false on translation failure; on success returns true and
> +     * fills in @result.
> +     *
> +     * This is the preferred method to implement for new CPUs.
> +     */
> +    bool (*translate_for_debug)(CPUState *cpu, vaddr addr,
> +                                TranslateForDebugResult *result);

Since this call shouldn't modify the internal CPU state, could
we use 'const CPUState *cpu'? Maybe not possible due to callees
still taking non-const. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


