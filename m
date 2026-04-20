Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A4F5A8C5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEw0g-00034C-Eq; Mon, 20 Apr 2026 17:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw0f-000341-Ba
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:18:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw0d-0006kO-RC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:18:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f1f6103afso1598985b3a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776719902; x=1777324702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ll7wFwLn+Q2JWftwZ3EFK08xagFge6He2NBz3sxr8Vk=;
 b=k5veHi9ZoAmcsq+DARF8eP5MbqtJGr9dl8nxwWixJ5OXnCAgAcUeZtiNkzSy8JmSdZ
 okE7HyRdciKytJvopGmU8IpF7nFtS6KLm4t2OK2kkhmflc9NEFkgBeKUHOW8AXwDhhOP
 0hhk3+m2Br1+Y13x53DO0SLGtTBoYQF/nHAAkfuBdJqOM1ya85G/XBxkdwN2hcG+QBIo
 m3fhEmgnd6mqukZewMc25v+kK6GOv/JDU92tJMl+aDTEGWvxKQBe8nRoATdvecYOB8Co
 7ZRQ5IplAek31pT5GX6lw/DDeZVQC/5fHRua2XrSlJwgoOOLE4SJiHFWNFCrVgkRpqXu
 E9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776719902; x=1777324702;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ll7wFwLn+Q2JWftwZ3EFK08xagFge6He2NBz3sxr8Vk=;
 b=Pph5aNOtJ+MXvvdiYgaSIdX7KdUyoNsqvOqECFBFL72HAI2Ho9yhEsbXtci7+QfI3x
 78LTRFIIejMKKxXzgFC6rHdv1vmVlqgEjIoLYA5QAw8/1ZjZFAURUVS2xZOji6dCPFCP
 65FeY9zBvGBL6ADG0C6CKHEq6Mxz8PQlflnp1BmncnS8hsFGjlxZZiI3KZtqT0OlVyua
 3t48lnmO9xDgvOi6o2zHn5tDfugmxGqJKYXoEX374tliXM6B4elmJIGoXN7GW49jNcDL
 PwH2+h2zYGGw+VW3kUaYcaZYPte8nmlJldpolXAADKHUzipRAyYki7CUedmbZuJMM5dG
 YB3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OXa1E5x2BBjRJMnon1FZ305Xu11oPB6ltffKsdiierMwJ6Gzszhp4BSszASs2E/CSZN+qShxHkNP3@nongnu.org
X-Gm-Message-State: AOJu0Yx0DzVwtncZIrxHMbQS3I1j2k53znBE0vpGknx4c9WICtz5VM6Y
 2Z0tf+mYWG+T2b0WdD506dPPA/gxJpEUOlFr/CejnnBgXQ3zUzZU5UYzWUcpuHrD+nw=
X-Gm-Gg: AeBDiet2TK6LSsbJf8wAr0m4btXfQGbl/g8NQjcO3eDhbUGjX2VBYKkJMJp/90CoEs6
 JM71T/L5eGiOc4K9lTSGcyAZ8qbh9ocz++1fqsrRoYMETM0IW0fBoihYGkUK1SnqA611CdY4njf
 DqAmMwub9JOBZOqLTbwTV6PkBsmN3eBMFwmfSmn3fzkhG6MforsFwfTxjYboakK/pLEScasp1aE
 +XJjc0I+Qx3/5WeRk+xH7WEKGdTxfNG3pcXTITLX3Z6VliKyclXpoZswnkr/OvEQ3N43J8w21XO
 uUuU1szpNI16/2B8nv3Kee8jxg2LsH9kCLEoQ2mFQtPFxIs/brq1FX15jkbtAfaPMVR19ROGy/6
 bB9pUsPmqyDrfFHbuqOfqFvJoaTo9HnwNFIU9UpItDXrY4llH9ymb+m05WbUuP2Xx0wcEydfgNG
 0OW0njQ5X1b8stWa2XVe/Kma2605puVpBCICAc3dAV2gj8SCaXSrut
X-Received: by 2002:a05:6a00:e08:b0:82f:5dc3:b376 with SMTP id
 d2e1a72fcca58-82f8c8fb888mr15470220b3a.25.1776719901896; 
 Mon, 20 Apr 2026 14:18:21 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ea09914sm11395533b3a.26.2026.04.20.14.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 14:18:21 -0700 (PDT)
Message-ID: <3d3eadbc-cb3a-48b6-95bf-e356c7e32600@linaro.org>
Date: Tue, 21 Apr 2026 07:18:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 Atomic LD/ST helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260417042620.35329-1-philmd@linaro.org>
 <20260417042620.35329-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417042620.35329-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/17/26 14:26, Philippe Mathieu-Daudé wrote:
> Have callers set MO_ALIGN in the MemOp bits.
> 
> Perform the access first, filling the TLB in the process.
> If the tlb cannot be filled, access is not permitted, and
> an exception is raised. Thus remove the now unnecessary
> do_raise_exception() call.
> 
> Since the TLB is filled, use probe_access() to get CP0_LLAddr.
> 
> Move env->CP0_LLAddr and env->lladdr assignments so we
> don't update them when an alignment fault occurs.
> 
> Since we have a handy MemOpIdx, replace the legacy
> cpu_ld*_mmuidx_ra() calls by cpu_ld*_mmu() equivalent.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 26 +++++++++++++++-----------
>   target/mips/tcg/translate.c   |  2 +-
>   2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

