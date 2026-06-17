Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE96ACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtg1-0005VC-51; Wed, 17 Jun 2026 13:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtfw-0005Tr-Lc
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtfv-0003IU-7c
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso6234439a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781715817; x=1782320617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gtGpUAuMszsmFeQ1P6XDM9kuPwzXMxMuKC2Hg7K7eGU=;
 b=eOeIhUY5nY+oukwFKD7QlDs4jYtYfr6UE/RoId2arjapNHQVvoLeVUIGlTth7NPGbS
 pSPaI9wy3XCrWdW748SeLcyJOIlboo0SbfhmnQGUwAD0AOw2LqXxnoH2WaUVgydcUAql
 uy9zs1J6qTEMgvpFOTFCXUNXhmkI/11YEMJ3QkYUE5HscGM/GjVKW4COgawKlpVFbJfp
 X9xSIckuh3cpBRTsAKwswZc8CPfu8B+5JMK48MXGKpOwXkmuqiQd8FSx+3OXYOoKjipz
 aD3UtfqzypWjRicxa35/brNCdUxdVHRzUWkdfJNZd48St20xzZiB6i0+IEQ6Sf2KhFO6
 iZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781715817; x=1782320617;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gtGpUAuMszsmFeQ1P6XDM9kuPwzXMxMuKC2Hg7K7eGU=;
 b=sfc2uAMncdcdu5Az4zTHofqwFX+PpdKbDhJEF7yU4utPWZlgD0pVhuASxgGf+P2AF0
 Iwec8rd3HSh5DOcqawEMKOXZR/oiH6TSqAP4fPoKaN31lxuyfIvAvyW1s4R+wRUXQmHw
 QZcTxGh66NvOwiR/HckzG6G8XD3t5LZGnB/mbIBtInoHhKlnMm8zVH2ZuOpDtZv3577S
 WdoUm3WBKSq6efh6gejGiqc+t50BkIi9Ulqzan+xQnyvJpPtchf3hHgM7auy1AokwfxT
 8tYH5iabcTgABTgvusnUfX7/ObW93ConVJivLiVmjVe6j6UfDPVv0qJUOYeS0CvSz8+6
 3vTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/A+FkwhHh7nHNnz0Vet0yNqkF3xthFn0FKVoxsM1BJXJ0xSZ4lfSEQoVvvggSfHAisKyhjqEbkUiGC@nongnu.org
X-Gm-Message-State: AOJu0YxZhgYFgQ0ovfYHfi+c3My8L/172cz2OtBHG3HQUdF6xJZFk6bU
 f6hU6EWvIrdpQU8WAET2BRdLFgCyglpBO15W1vud8cjzCJGfVX3FP+LDJp/Lt964BDLgC14LflA
 lA6Ut
X-Gm-Gg: AfdE7cmJec+vuOoG8fih/HL5h+qe3rqd+0yMfKTDIh3EWtso526i6Jr2ZOs59YXafCr
 gph5PT1E3optmT4h1ihVM7cAx2zhtdXk8fHF3hWYk341XbhXdnyjzHpclTJlF2sxPOXfTkMlvoJ
 Z/Z25wc4pdtKmJYRubrlg31vVcaGp72JxV41RdtKR1dC9/U6DuzYTPsxucGxdJWHDNjBQKI/lhv
 HFfzY9ycNJZFLCzgyg6o+OMaSzGvCW8YapIVUbHBKqALAfe46r4nW+CHXtkeaMkABFRjR4kIX4z
 dyDkaIKlsiMopueQ0wx/uxOcAvVxwlKqEWOZnofltY8Cv6whkEA5STaM5mVwsMWHt1PrCTRK5Ka
 YrjsSjp/0R1CKtlrll8Em7y43CrPbDA8W2rkKePRJZl3mGMjcgEdTSi3CUK0SS8jbkQqQm1tjAV
 dIN5COqZqBI3Bt0g/EzFYfxKIzMxeK6HBdO9cKFBsZhIXbLjt44kZIewlwOg==
X-Received: by 2002:a17:90b:3cc6:b0:377:23bb:9b88 with SMTP id
 98e67ed59e1d1-37c9e9c8d85mr3995425a91.12.1781715816961; 
 Wed, 17 Jun 2026 10:03:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37cd2ce2229sm893237a91.1.2026.06.17.10.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:03:36 -0700 (PDT)
Message-ID: <380d4f58-be63-4bca-894f-676421f9f499@linaro.org>
Date: Wed, 17 Jun 2026 10:03:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] exec/cpu-common.h: Include missing 'qemu/thread.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
 <20260617160426.64461-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617160426.64461-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 6/17/26 09:04, Philippe Mathieu-Daudé wrote:
> Unfortunately we need to include "qemu/thread.h" -- which is
> currently indirectly pulled in -- to get the QemuMutex type
> definition:
> 
>    extern QemuMutex qemu_cpu_list_lock;
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 74337d84640..8cddd32ca8b 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -8,6 +8,7 @@
>   #ifndef CPU_COMMON_H
>   #define CPU_COMMON_H
>   
> +#include "qemu/thread.h"
>   #include "exec/vaddr.h"
>   #include "hw/core/cpu.h"
>   #include "tcg/debug-assert.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

