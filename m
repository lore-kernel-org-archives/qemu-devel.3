Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE52C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 00:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYDRK-0003fW-Rm; Wed, 15 Jan 2025 19:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYDRJ-0003dl-Gb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:08:49 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYDRH-0001x2-HQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 19:08:49 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so720142a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 16:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736986125; x=1737590925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zwVrcxS1ovCsuHRW/q9XhvBXJxtjoziHugVqGqMrcCA=;
 b=Qt0mP1U5Xfqup1owsOnhYNZ+vuUeF69Cbqk5KUQLzWNTHW3zxLGCGO0z1MwKdd5jD2
 KbUbm8f2+JxnwiPialLShQufyukJyNVRsDbLe+bVQ73dz4Ld+1ISFi2nUOG6jcT1F8b9
 6oP6iF2YTaYC/5gUmN8AG7zyRECD5TTFwbiPftfYGFPj5ovjkA6Ra8F5knvw34Ovitae
 UHhe6BsngUl26WDBkx/xp+/mO0BWL82hws9DGUuBBlWWBjldWqSwie8thi3BeS/F5V/3
 hcSPvchZpKH/mgMxr4mDCZxreh8aO6YACzcgoUHkfjprTJeWo/nhBxgXQSq7cUSbo+/H
 l5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736986125; x=1737590925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwVrcxS1ovCsuHRW/q9XhvBXJxtjoziHugVqGqMrcCA=;
 b=tVrtKYRePx/XMTTn6lFpmu02bsQWWBNVBQ5UowkUGuhOAAo2l9bqKnCfZOuSz+5pw7
 /4Z8hWCaCrC9yp004QocjouELjzsYeZl5hwxkYPhmtimcn5wu12oxblIwLHqhItmlbOG
 fwjjicoIyoalR3rq4tgRjOsl4At+kxG5CviPF9LW72q4yt/bw3MjMIJoQDp1h0iK1OV5
 kAfylqIMBxUb8Y9wcKyCqQKNyRM4ItQjnfijKbylpGvOM07mSEO4yejTdhMUR96fHH9K
 W+18RUr5+7CwGjpjXviLtf9xTQHGLHFgApzeIIGBiOTS82hHMLmMCgwXIKJASCDDUfE4
 5SFw==
X-Gm-Message-State: AOJu0YwuvAbB+W13R21zuIXGimcz0YbrpjNo1rXQIj9aa69OPh4o3FL2
 uddByyzky5NqCmxsQK9feXynucdUFqDteQlb6BbaIbAEVBXsUtM7SERWmISrkI5L9wxBb074U2B
 p
X-Gm-Gg: ASbGnct9vH9+DwdVS3EFFwuqoCwDH2FTEl2qng0oXODiIeAqp2UWEM2wknjtwWoq5wI
 aJmFocCQ21YoFGjj2jLlfSz9xlA6XLp4MhUBg7xqdcQ8dk1oMPugDFEyg1QEZHHCcTq9L+d2C2i
 qWXpYfVhPTd/qAfnhzP0yP1+b8ywpAP8XkE567Pl+gVgd3WTV24JXn5Wg8OTkSORq00muKz2Iga
 5vG+itjavH4eqVxu5EOE57gnC6ABbfoqOMgByhJuT+n+tIFxv1AlWfe88Fzm17kNG8SxDCJ7X6H
 5qAZ9dWCcuD4+Fh+HYmIXhU=
X-Google-Smtp-Source: AGHT+IEHFy3vLZLdlIWmrfthPeZjaDRQ8UHt9AfQ44hHrl1WJtE/pg9UNZThtmP9ZbnU0ePYspbEIg==
X-Received: by 2002:a17:90b:2c84:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2f548f17351mr40850162a91.5.1736986125573; 
 Wed, 15 Jan 2025 16:08:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c2bb332sm2166614a91.36.2025.01.15.16.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 16:08:45 -0800 (PST)
Message-ID: <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
Date: Wed, 15 Jan 2025 16:08:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250115232022.27332-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 1/15/25 15:20, Ilya Leoshkevich wrote:
> Currently single-insn TBs created from I/O memory are not added to
> region_trees. Therefore, when they generate exceptions, they are not
> handled by cpu_restore_state_from_tb(). For x86 this is not a problem,
> because x86_restore_state_to_opc() only restores pc and cc, which are
> already correct. However, on several other architectures,
> restore_state_to_opc() restores more registers, and guests can notice
> incorrect values.
> 
> Fix by always calling tcg_tb_insert(). This may increase the size of
> region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
> fills up, so it will not grow uncontrollably.
> 
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

This needs something else.  The reason why they're not insertted is that they're not valid 
for a second execution.  We need to not find them in the search tree.


r~

>   accel/tcg/translate-all.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 453eb20ec95..6333302813e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>           tb_reset_jump(tb, 1);
>       }
>   
> +    /*
> +     * Insert TB into the corresponding region tree before publishing it
> +     * through QHT. Otherwise rewinding happened in the TB might fail to
> +     * lookup itself using host PC.
> +     */
> +    tcg_tb_insert(tb);
> +
>       /*
>        * If the TB is not associated with a physical RAM page then it must be
>        * a temporary one-insn TB, and we have nothing left to do. Return early
> -     * before attempting to link to other TBs or add to the lookup table.
> +     * before attempting to link to other TBs.
>        */
>       if (tb_page_addr0(tb) == -1) {
>           assert_no_pages_locked();
>           return tb;
>       }
>   
> -    /*
> -     * Insert TB into the corresponding region tree before publishing it
> -     * through QHT. Otherwise rewinding happened in the TB might fail to
> -     * lookup itself using host PC.
> -     */
> -    tcg_tb_insert(tb);
> -
>       /*
>        * No explicit memory barrier is required -- tb_link_page() makes the
>        * TB visible in a consistent state.


