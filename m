Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BB3CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPWr-0007wk-Ek; Fri, 08 May 2026 14:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPWc-0007vo-Bm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:02:15 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPWa-0007bh-1z
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:02:09 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-42c08cbae4cso1791282fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778263325; x=1778868125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sPV5LurRThcxobEvvPLqQAd+BjMvc6hU6O50RmKt6vM=;
 b=YHqr8f0yzytoADWgArccUIz4w/r6l/Hk3q+4YtuYZFBr2Go+yuVh6q47Q0AfzDsBiD
 F6ukW9bl5vUD8RSoEBc4TWtB1/m6J5HU5i/SXySiVAzIuoRjCyKl5wSV6KM9hdKiVBiw
 xR1kRS4eGO8jkwzM82DAlwQ5gEjt293RRz2HC/0K63yENrecRxPkWa5Gm6V+LTYIHeGi
 c+0T1rcC+IprAy+J3XvOgcrvRIUhH16c8JFL/Qpq3KWmx0+8DsPX0C5GhBk8sVfIgrc+
 w23qGyZrfY368L2TciHE/DtW5aPZ7k1RCV/lqay86Q3bGMfkaVsm/kdWsMQrscYiEfEb
 yxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263325; x=1778868125;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sPV5LurRThcxobEvvPLqQAd+BjMvc6hU6O50RmKt6vM=;
 b=EwkXUYiFwU7zzvlNFGSOWi4TASHM8cjM4/o0/PCxW+DxtN+G3pwXQeUuH/tlHNH64O
 r0KL7pzv8xBm+8qH+YRM1zFEUp3WU5ikmgp5wvZWHltynI7WXtlzpwzFz44Z2HzrBlX1
 bQ8ahNVaXHepUTSoGi2WPr5srzcnj3W2CTd3imxvPEF/n0PuKiF7qn5VUejdmwYOaAY2
 Ypf2o9Q93mRlB5UbTZqK+isUjfRle7wgLH8ek54aGHkhF5HMHWdSp96i6MAMmsQro5Ke
 xm5RXrKyliQhCHy3HDEiWFzW0YFGjjZFdRrdwgq8rErOiiVnlkQFmQS92xdqPBO2vfKj
 dQsg==
X-Gm-Message-State: AOJu0Yzmake0F+A97a+7koHtKZK31c/MjtlChcP7s6408QFfirgRvkQl
 48NQV/zkPPkQTWzOcr5bKFCmOAMyfpwuRFFOAqfmldxbj42ym8XwDGY6LbBO42QUBSf13KOrleN
 0NTTA
X-Gm-Gg: Acq92OEAWj4odT00zOUdkKDvTGEju23tnONIUQcChnW6cee7ZWUE2sclD8ooF1dEhzJ
 nsYD5EjbSq89A5ztz9BXpiPXSUiOtYEzAgjOl2X71j1P50vFmwzoKhmjNpmfzbHC2SS2Z+WYhKN
 FrzoARu6k8mzJek9FMEOY5qzYGdEOOiqROkNCmLlnMoJkmFl293LzBTbmNxRWqveN+yi1s1AhQG
 V3BoqohH3gCNMcNoWtm4SYPv2pF2w0fzI65dhYkw85+EDNMC91rMEqVuX0s+T+ce5eyY913jGGH
 9a4ImTsUOEgKgwhv02yqdEIaOZGw7gPCvuLAurtBMKTEjGyHvovbGB7Dm2HyiyzNtjlVZDLljoy
 TNGpeks6+uQKeZFhJbtJV6wJyVZ859pa4fFU9QE/vbxSpNpi/1P6AlRthiuJUTtfh1b5XCeWpOh
 0nHjPe1ODrpBqwCfRe3GR4d86tkARwNNTuaNkk2VjyiGRD9qEkirfH3NNikHGXyjV29VvJanHhC
 GbS/PEB8Q==
X-Received: by 2002:a05:6870:d209:b0:42f:f1e8:7703 with SMTP id
 586e51a60fabf-434f7276815mr8808007fac.34.1778263324565; 
 Fri, 08 May 2026 11:02:04 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43556bbebe6sm2265150fac.0.2026.05.08.11.02.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:02:04 -0700 (PDT)
Message-ID: <360a26b7-7591-401d-a6b5-21e1f4f2f597@linaro.org>
Date: Fri, 8 May 2026 13:02:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/32] target/mips: add Octeon SAA instruction
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-11-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-11-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> SAA atomically adds rt to the naturally aligned 32-bit word at base and
> discards the old memory value.
> 
> Implement it with TCG atomic_fetch_add_i32 using Octeon L2 transaction
> alignment semantics.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAA out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)

According to binutils, saa and saad are octeon+ instructions.
Which makes sense, because they aren't in my octeon docs.


r~

