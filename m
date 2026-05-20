Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6AACD5BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf8e-0006hO-GF; Wed, 20 May 2026 07:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf8Z-0006Wt-4X
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:56 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf8V-00059i-T7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:53 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-38ea6a5a0b3so39029691fa.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276650; x=1779881450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47pAj8Q5dT/4zHx/2aO2emq23ClpwG7za6Rnn7DWYxI=;
 b=u1DkoxUiwWdzIBGpE6yqRDvABNn/AEVCWskEffsV/oc+871VHRXOHf5K1hr+FbzxGE
 TLbBrmMUPPUEna0ixoWhUXhU1FPd5FH19AAKaNh4uSqGMiZYRz2oh+egvbNtkh9QFR5L
 x2LITz/e42YbiTjJdbbn3NCgH6PeeJJdQH9g+Fy4Ff2JIbuoPvCCvqlkAU7Uw9VXhrmE
 +fUysFmQh1arFP1C3XG8CHzkHd85eM35MEscxNChva+ShjMypZ62LCBqB6sUW0LQsLmM
 Abb8EP0Dr/AW4n7Pzk4JV6zXyYml7+JsSBGKKR0uerpHWVvchqO0TmVTcd6qHttACjpW
 c25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276650; x=1779881450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47pAj8Q5dT/4zHx/2aO2emq23ClpwG7za6Rnn7DWYxI=;
 b=ASMuStyAaU4ZaTdxJhnXOI5ZOo9sICAH5RyuljbG6bxLRJsFDCmJFv/Fd6GncxMqDj
 LO8StVOIwR7MeEvT0ilDAi9yOZ1Nx6bcjpf+3Y5ZeBK9LT3dkAiyqpBmR9BHNXQpr5yj
 NKCsx573B5sT4hb+T0XnpcevDDK6cGP4zAxyDYlWhstTx9Z5RBayRjqbjoPfvR7gcMjz
 3XIgHsnRdm4RgY9Wjyvd2nLO63VMIgUJzQESBOUnuYGgb7FzasnMm+Z2Iib5e7klWZVA
 E8228hKpUJe+6xlQePGq+zUfqog2Riml1Ri0wuRmhMmZHoAO67NZFzu5T78nSa2W8jOl
 JKOw==
X-Gm-Message-State: AOJu0YyNyUDBIg86P5gPgoCSfYpOyGLJ978pfZw22WOZ1Bl2S42dfYjI
 qFY1gSpgShIheQzi1HNvxhlYanoRNeLp+kru226600E/DH+P8ISHKU/M/PR5Kq8CtvC4X1IYu0i
 QVWu8IBI=
X-Gm-Gg: Acq92OGfFD5Hus/ziB00lujJ1TgickaektQ6Kfdoqr7hL7/M9hFIoBgpYJ/FJ5E4VmM
 I+1rw1gzATWlha1BIXXlMTovLQ2jWODvVjXUjZszx0qJze3Tms4WL+jhRiwnoihG9/3FI/tKf8C
 ylnGHnpHgtO8fcJHMOtLJkNdE5EX7/G6MUV2kadZPfTounwqtO4bQByP//ju7+TJ3NrsOfK8RH7
 nUNFeMmb1iYn1LGu9pk7GQVfGDfK9Eey5PnkUCoiXo5uyU1zsIdVpMoB+v5wsNzek0tN0THjFDd
 3ZaF/oA0uhiYCG/DxY7z+X6rAYwEB1y47JY/NZqbSsc006CWCW8I9uv6T7xISJ4axJRBdDiVpds
 jUgiGO/n4EIgVwyAKRmiTe+9kONDFU80YbDF0yJ7Rk+EGDeesPV7m46TgCZtyizPGFO1LO+9KaD
 pomLFYpN/QWb7kbES4PLe26sT6Bnp6racwGgJWO9AMAQ3QhWZWkSSSMqyxuLhhers7H6bfzwc=
X-Received: by 2002:a05:600c:1d0d:b0:48f:da34:ec4e with SMTP id
 5b1f17b1804b1-48fe632343dmr336946955e9.19.1779272678362; 
 Wed, 20 May 2026 03:24:38 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c90b27sm403746425e9.8.2026.05.20.03.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:24:37 -0700 (PDT)
Message-ID: <eb4de3cc-8eb1-4abb-8eba-6ac90c74b676@linaro.org>
Date: Wed, 20 May 2026 12:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/24] target/mips: add Octeon SAAD instruction
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-15-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 20/5/26 12:17, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> SAAD is the doubleword form of SAA: it atomically adds rt to the
> naturally aligned 64-bit doubleword at base and discards the old memory
> value.
> 
> Route it through the common SAA/SAAD translator so the MemOp selects the
> aligned doubleword transaction size.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

