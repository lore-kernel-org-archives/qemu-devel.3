Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878BDE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUUA-0003lt-ED; Wed, 11 Dec 2024 16:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLUU8-0003lO-Ud
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:43:08 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLUU7-0006rx-Bx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:43:08 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29ff039dab2so1362699fac.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 13:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733953386; x=1734558186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i7HLq+QKMLCY5XqsI2oZ1TklSnVA22KFqV6yEG10Fco=;
 b=eaGpG6s58clX1K7M6FLAgZH38ZOs82a5OBJ3NDQ0gLm0r7KVfPqUrBd39oVLkLFOEY
 jrDMkGgSlSDkxqcFX/UDjAYU1RgurmUSARQ74oUj4XBViUF0anxHEmzcQB119Xq7FiFb
 WDXLUXYXjHc34VcyXeMQsQBIX5T/ep8ONZGP8cLzPnU8LXsYrTdeWE3+v8oSJFiAluGk
 yiDp3aNHWf5XVR9X52M9LpSK5VuDSvbUuiWUGkPzfD8afDBS0aJP4djSCZqlzTo+GSaP
 4/eoHIbLZ1S71q7bWPqNMosdKbqTliDJpN8rbQeuCi+j8vbdLDvsYBjbHUfXNvenmwHy
 Lgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953386; x=1734558186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7HLq+QKMLCY5XqsI2oZ1TklSnVA22KFqV6yEG10Fco=;
 b=iPr39DHHgSl6V35vtbbAh/oVYN+/UHVz5yXm21soORO1PJaiPOXxCH97uLjgngV/gA
 JCstZvTYDT9o015tLC4ZuWAg7J9RiOIs7etCrefpWp81K7MrmjfWnPQla4w13AcVQVDi
 STtO/CqanhhyiFGbNH23mQGv3hfr1U88iXUcW4E6qUjg5hxPLmIu4LT32B3bxQahIjQP
 ezY6Rezm+WgkfcTfH+rs0+sOt2ueEQGWyb2EQ3u84X6h8g3yj3KV+D5UJH7NF83jjt5s
 ssIAOlkCmENM/Wzv1rVM890Mwiur3x/zdDW8fv80blyb6GCTcPn8HqCtEOC/zt1l0yko
 zPsw==
X-Gm-Message-State: AOJu0YwMt31MMHEhI2cpNRB85wX6lRU9x7jAVdu8rPv4ppdDMZ2elL9C
 jiVc9XjSfB3JtqbcZMI0ttjA7RTsFmCyE9AzbVDQhOMLSs4yHoPV9+p9REE7aPPNuBaalvpROng
 0qMpTuV4n
X-Gm-Gg: ASbGncvvak25Ed7auKsOT8Z1DBElMf3MzDNVRBuJqoE9/VqyRb6f1FTQhJ1ZKgk24N7
 /4RJDFYlDYTIA1p8k62lIutY760DISYUJtF/3Ds+BqfcibDxUv9NFw4N5Bdo7D+u+VKrgzrBkQJ
 LdE53DAvICUBOWC44QHeEV+AxSsqXYgAuNnkai3LMqvOJ7tcGeUdZa4t8EmQdO+ea4ZNEBsTocA
 jZZB25N6LMH6Hd19BAIyCb94aWt75l7G00sQ60U81iJx6QzBoJR4/d7KdYvB/DDXd0QHCwF/m6b
 JrHIofe5IXfLBxFYPiABV8im+CSGPvoO
X-Google-Smtp-Source: AGHT+IFTBrB86t4H381bZ2vjLdNTI8cUuvKfw4C3YlrINzldKZgcewF9Vh9tdKPlzZ52nIzDfWyv0A==
X-Received: by 2002:a05:6870:418e:b0:29e:2991:d953 with SMTP id
 586e51a60fabf-2a012c5ac54mr2590751fac.20.1733953385698; 
 Wed, 11 Dec 2024 13:43:05 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f569a64a1sm4088952fac.47.2024.12.11.13.43.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 13:43:05 -0800 (PST)
Message-ID: <b16c4644-04df-41d1-bc6e-f14d706ab4b7@linaro.org>
Date: Wed, 11 Dec 2024 15:43:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: fix the trap generation for conditional
 store
To: qemu-devel@nongnu.org
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-4-fkonrad@amd.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211211933.198792-4-fkonrad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 12/11/24 15:19, Frederic Konrad wrote:
> +    /*
> +     * A misaligned store trap should be triggered even if the store should
> +     * fail due to the reservation.
> +     */
> +    tcg_gen_andi_tl(tmp, src1, ~((uint64_t)0) << memop_alignment_bits(mop));

The constant is incorrect for testing the low bits.

> +    tcg_gen_brcond_tl(TCG_COND_EQ, tmp, src1, l3);

Best to make the fallthrough path be the common case, as we will optimize across the 
extended basic block.

Use test-style comparison:

     tcg_gen_brcondi_tl(TCG_COND_TSTNE, src1, memop_size(mop) - 1, l_misalign);



r~

