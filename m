Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521F0ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 23:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snoB3-0000z0-U4; Mon, 09 Sep 2024 19:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snoB2-0000tv-Lk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:52:12 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snoB1-0000Ly-2F
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 19:52:12 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2da4ea59658so3551117a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725925929; x=1726530729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZZyj24CUMwAGgKSbxXKNAL/vs4NarX/SCpPls+aUzY=;
 b=a4ZYnG8b+Zx2JVT0VshTtTwnqhHc9PDX/Rv1E9oVck28rgPYOOCWXaUOe5pyeDNsuO
 CueEOQrBJDNDnG1ewj8ETksxqPYBqDLYUcLF6saH9m3eAQZKt0wVmDyioZE9xedW7vAM
 2K+5tzUHODSDE6bHqna7MzJvB2QM6JKjFWauMm0FMqdiXgMrZoK8qv5W3LVl21PuG5aB
 542AZcQTC+TwIflYycmwywSIyeo6Zlq34amBvY0qJqMcp4MOnWyOFjkM6UXwJq/QCOHv
 h4Lz4dp8L9KXttgwix74Lgi3wE8ihVqt0qCntzpbjyOBs92KAnCPn7eTBzXO1OqKDuqq
 pSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725925929; x=1726530729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZZyj24CUMwAGgKSbxXKNAL/vs4NarX/SCpPls+aUzY=;
 b=AsNkNxJ0h1JFcon21Zcw0nJAb04zatyD3g3KAzWtwEDOxF1BFgsbWFFT3PQT/ztvtR
 vU/r54TbZUfU2pVrolZ1UjjrcFw45nM6/hOPgqAUEqGfAknPVrHazXRfuvs4ABEpEdRQ
 a3K0L3z8pSGQ3Sep5B6P5uWvJ8TGqLEAsl02UBk2vD/W5WcY+fXEmc8oUOZz0rbv9nVU
 LoeO9iukz3wpZGrpeWQO5EKoGEs/1M3Py4xwjOb93WT9LS80BZnZfK56ReKQ71eCFulF
 MOXsi3tIpqBodAteYdu8y1f2x+Bw0mZUjUtXQBQx7FrcM4L7bIOmEfqserObVES7hrl0
 AKtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYuWshgWSXWbetcKEaB08Qhah9SbbAR41HHkFfgP7XmrdSch1MYjnqfqrsuic/KJzCNf6TIuVtr4Lg@nongnu.org
X-Gm-Message-State: AOJu0Yxq6I2UCYbaJbeHpnfsQSdFy+1BfIK5cSymfXv01cMLNzdnX8/M
 K2QgPojxEzVDXZDlCHHeMr/0PhuPvEpRVY9wJYZQYcUDIojjpOiRXpeYF23GFUA=
X-Google-Smtp-Source: AGHT+IHqCiU5zYQ04j8sqyjuBmhdqCPs09hnUInO2lEZ091JIl48SJwF69U217dg0mN4vVr/NSQLBQ==
X-Received: by 2002:a17:90b:4c4a:b0:2d3:bc5f:715f with SMTP id
 98e67ed59e1d1-2dad4df9581mr15488573a91.10.1725925929373; 
 Mon, 09 Sep 2024 16:52:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc12a1d9sm7167953a91.54.2024.09.09.16.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 16:52:09 -0700 (PDT)
Message-ID: <c799fefa-8e7a-42f5-9a91-c56ea45f6d18@linaro.org>
Date: Mon, 9 Sep 2024 16:52:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10 3/4] target/s390x: Use deposit to set ilen in
 save_link_info
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240605215739.4758-7-richard.henderson@linaro.org>
 <20240909231910.14428-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240909231910.14428-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 9/9/24 16:19, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240605215739.4758-7-richard.henderson@linaro.org>
> [PMD: Split patch, part 3/4]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 53ec817e29..bfb7662329 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1429,17 +1429,19 @@ static void save_link_info(DisasContext *s, DisasOps *o)
>       t1 = tcg_temp_new_i64();
>       t2 = tcg_temp_new_i64();
>   
> -    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
> -
>       /* Shift program mask into place, garbage outside of [27:24]. */
>       tcg_gen_shri_i64(t1, psw_mask, 16);
>       /* Deposit pc to replace garbage bits below program mask. */
>       gen_psw_addr_disp(s, t2, s->ilen);
>       tcg_gen_deposit_i64(o->out, t1, t2, 0, 24);
> -    tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
>       tcg_gen_extu_i32_i64(t2, cc_op);
>       tcg_gen_shli_i64(t2, t2, 28);
>       tcg_gen_or_i64(o->out, o->out, t2);
> +
> +    /* Install ilen. */
> +    tcg_gen_ori_i64(t1, t1, (s->ilen / 2) << 30);

This is incorrect, as bits [63:28] of t1 are still garbage.

> +
> +    tcg_gen_deposit_i64(o->out, o->out, t1, 0, 32);

You've fixed the missing high bits of out, though.

r~

>   }
>   
>   static DisasJumpType op_bal(DisasContext *s, DisasOps *o)


