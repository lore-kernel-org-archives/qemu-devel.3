Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880A5C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJXI-0004i8-S8; Fri, 24 Jul 2026 13:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJXG-0004cY-NB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:11 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJXE-0002A8-5Q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso491005a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784913486; x=1785518286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0OT7gvTsKKePvoiLo9S/ET4fW74xx4vkf8qOKtyMcaM=;
 b=ZrdGXOrjnuy6fYb0m4eICvf7d7aJPPSkKl2BBSJTInMGDgxc6tD4HpmAICPNDcoRzJ
 HczkDnnqE/6esgZ6fZ7rUTEpSgUq8pttN52GRik72KqBSQwfsCRcAKbf1PkozPE+Fip9
 lUtvqdTpKaC8RMMRMfKvXFXXO1D7am35J2dM5TvyxpatEDN6s9W+/kuXJPax34uYkdIJ
 W6NzHQ/2/1NfHu5SUbetddOB9yMO6vrf96rrOHqW6T1CXf1/HJxEy5+D1l/0oTw9cG/u
 omFeUFM2DR1b5FEBWuEbDXjYR7CIUgm6IW34ZJYVOxi4NrFk7xnr4TZayapkEm0lWDWX
 0GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913486; x=1785518286;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0OT7gvTsKKePvoiLo9S/ET4fW74xx4vkf8qOKtyMcaM=;
 b=VW6sxKtbLivjsPRLQzgt4t17t6s+mDFAggxlvjFRJtCLWN+Ykfjx6ybNBZra5mY64T
 GsoAJ3rHjTsBEpZo3qZlmNOWvnjiPZzYokp3FqAdHJdMy17P4rNn/0CvU/zzbXkz3OlC
 kC+GWKXLmEM9EQPTZBtj3snqcWWQETVMcMnc2qcQaLwc7Dp/Seq+t0N5InSf7E0bEsIV
 OlwmB8crLC2jljXJ3CRXQuwmYRQJ869uB/96+hXZbMYuf4b8X+iNYsbadqwoxc4UYiXt
 hKucatrsLjuDZKH21ygfAEoSiI2VbXQ6goaL9lqfWmqY+pDR2TxDrxv+6oVgUoXm3hn9
 2jbg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4eYz5iIQQO2dVNEIytLCRfnfxGndqFMU/6feFUmhNQjWtghmU+i/LhvpN8meznaQcaHTkAlseJb5M@nongnu.org
X-Gm-Message-State: AOJu0YyuFhD1UzLsdcMSO7PizL6FPKcQXRRecuQeQgjYfLgSSt3s2Rhb
 EBL3Lm135g5Ob/lboVycpLv47L0Bn9w82LTAXTg2YwGhbLzcUtAFbsGqnKCmSZGDBXI=
X-Gm-Gg: AR+sD12EqicFpzFCNJcxiuRhNuN22cbdaleNS8ssl/yRbNVx0Tzv3EBKuh4uZXH+ppM
 xOdVAOnRZ6dvMqz2uaWYVqkoDF7v4TZq8XpkVOivGv4M3sVbsZf1ueyLMthsmUIN435PFzW0+dq
 FrbG+M/rw3FZkaRfQyEXTbcK8o/nf26eoBwir+ODZaLO8o9+VsMUgtl5RMBfNBoxejKI7ohH60O
 JzJon9rYmoOY3KndB4+w3/hY6phqU7sW3hi6TiPq8IY75F9LldpOHBUyFFq5bPhOh9SbfP9NTLL
 Fiw+zRANbNfTrwg2hmYGf4gPa43fHNYavWxOraBZomZzYmaiB3XbvkGM1uGsxdFaeUhtwKL1gLr
 5dpsI7PMo8dRuIFyxnItewD9Ms1CoPk8TdA2G43i0gcgBPdGF4aeFLFgX66p8EflLP/eihsOh3u
 mByRDje/rvOGFuwOsxVsTCIDddDX4iK6VylDByKGWppw==
X-Received: by 2002:a17:90a:fc43:b0:38e:7aa3:df25 with SMTP id
 98e67ed59e1d1-38ec6ad9f1dmr7426037a91.43.1784913486317; 
 Fri, 24 Jul 2026 10:18:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f21759950sm287666a91.0.2026.07.24.10.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 10:18:05 -0700 (PDT)
Message-ID: <5b24bc8d-d6fb-443d-b54f-da6f4ef71c5f@linaro.org>
Date: Fri, 24 Jul 2026 10:18:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Fix DR/D INT64_MIN / -1 host crash
To: Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20260714190351.337923-1-iii@linux.ibm.com>
 <20260714190351.337923-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260714190351.337923-2-iii@linux.ibm.com>
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

On 7/14/26 12:02, Ilya Leoshkevich wrote:
> helper_divs32() divides the 64-bit dividend by the 32-bit divisor as a 64-bit
> host operation, guarding only against a zero divisor. INT64_MIN / -1 therefore
> overflows the host division before the representability check runs; on hosts
> that trap this, QEMU is killed with SIGFPE instead of raising the
> fixed-point-divide exception the guest expects:
> 
>      qemu-s390x: QEMU internal SIGFPE {code=INTDIV, addr=...}
> 
> helper_divs64() already guards the same case; add the missing check to
> helper_divs32().
> 
> Reported-by: Christian Borntraeger<borntraeger@linux.ibm.com>
> Fixes: b4e2bd3563af ("target-s390: Send signals for divide")
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/int_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

