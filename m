Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF01AC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15tL-00017T-VO; Sat, 05 Apr 2025 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15tK-000170-DP
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:57:06 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15tI-0003OD-RT
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:57:06 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af5085f7861so1933432a12.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868623; x=1744473423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sRHyz++rdfDOZOlIizWkYFJ7u6j1o1tm9FKcxWDlp8M=;
 b=RB+cRjiOrODfa6M3w56bJLayVecsjHFlyEloDTh4LsiE3HcD3YUsjibimFpH6+ZnJS
 Gbm57DAjayrCJUbhMJUOEvd1XxG96dhwZgOWrmDyBIz2puaMx7Dfxy3snpw0YjwAXHp/
 nIpD6wlftoh4JKNPYXfh7E4AJR2uEX5jfwOAOaRcubZcaRHYtnt9qS8ebyX/LP+/brxg
 hg2cgE/1fbq1zKjeqfoTH1LTnir6Ez8FwTxQ7oi0dDQrdWfyAJHbRqA0z+6MyjNZbMQQ
 alPNWXL2Rzy4HeofTxQ28IkpX9BmvK5ugYnA6wNnkmLOoW+7LQrUSt/TQqc+SmM92a6r
 ofaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868623; x=1744473423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRHyz++rdfDOZOlIizWkYFJ7u6j1o1tm9FKcxWDlp8M=;
 b=ChxAuQhnNZulWfmxht0U3dc/v/hCVpG2HCtPBwlq1eVJUrpPBwWhBuTt9Y2MOPwbwe
 UN+q3qGv0R3AH3b0cKcJZh6n9E9uhtM65yOdVjtcf0JCLvQmmK07xabUx3GMh+oYiLIl
 KAvJi2ZJxRQNbqaRF7/UnRIRZkgEjhE5RHs99tB2YL776Ip1NNAdgkE0vXheynh6zRmK
 8J19gWQUDP6qeFEE6rtGp7d6WzYpgmRUAhO5KHfnTc7EFztdWz/wHOZ6a+ROO06dancz
 UYis13UrwGBXnV2VJ4YLdPfnLmFK2RxXe4cIzfUpvLXgaKRW0IHgpy1Y25LZCox+fRYf
 xogw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gc/dMiPu+dKcEKr2PuAIn2Ug8q0/Jas2429JdWLHMD/5MlizsEClygCjtIezxSkhOONkb6iQNH3q@nongnu.org
X-Gm-Message-State: AOJu0Yxzb4ENiQErrOPBiPXvDbPR5R8bU1g3HV2qgPWKRB+/yHSbYsH3
 XkD32VfQaMkZu6IqF15P8JNuQEEOelsZ30GcpfT5x/UufmKxfU62Xa01mX7IUTjWsVIe9+QQZyz
 Y
X-Gm-Gg: ASbGncuHhrVGnbqVdGqGb4/DKDlBy0met0Z5ohaYOycKmWzSRkfY0YwiV5r6EzWLW9b
 7Cu/ykRpK0WL8P28w9Mgi5zjOiKR7S/9QCcGe2amWcDFnBaPsUfe6hIMgTJ78k93u0hV0BNvPds
 KdGJlZ8LteU7phuhaubOu6lPq8uuheUI9E1SMQyOB3MOqqU7YWOEqeRXdRX2ozVPeg6R5rJr5nS
 WtWM/hyfLvPIJUS27XFFIGlyGijynpwsXfO90jIZhy2jTCDSn3D02SP2e8Bz0AVQJGFG4H4obGg
 38Ku9JiEsKd2kaj9ii0NuKXq/aTXEon6TUkkhERXOt3bJ8HRH45tPg9ETLT6qLb5
X-Google-Smtp-Source: AGHT+IGg+U9FtxUqt9h/w2xhPxOCdkt0YPAD7D1gqR8jgX+t6oKkq9PqoWsYKuJ2E77Ppgv5/vCGQQ==
X-Received: by 2002:a17:902:e890:b0:21f:4c8b:c514 with SMTP id
 d9443c01a7336-22a8a0b389bmr96671745ad.45.1743868623087; 
 Sat, 05 Apr 2025 08:57:03 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea09c8sm5544819b3a.101.2025.04.05.08.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 08:57:02 -0700 (PDT)
Message-ID: <f7d4a7a3-1e63-45ee-9556-8b155b34a05d@linaro.org>
Date: Sat, 5 Apr 2025 08:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/2] tcg: Introduce and use
 target_has_precise_smc() runtime helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250404235624.67816-1-philmd@linaro.org>
 <20250404235624.67816-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404235624.67816-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/4/25 16:56, Philippe Mathieu-Daudé wrote:
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index d479f53ae02..ae12ad2d867 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1057,10 +1057,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
>        * Without precise smc semantics, or when outside of a TB,
>        * we can skip to invalidate.
>        */
> -#ifndef TARGET_HAS_PRECISE_SMC
> -    pc = 0;
> -#endif
> -    if (!pc) {
> +    if (!target_has_precise_smc() || !pc) {
>           tb_invalidate_phys_page(addr);
>           return false;
>       }

For the record, in my v2 I reverse these tests, since !pc is simpler.

> @@ -1109,10 +1106,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>   {
>       TranslationBlock *tb;
>       PageForEachNext n;
> -#ifdef TARGET_HAS_PRECISE_SMC
>       bool current_tb_modified = false;
> -    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
> -#endif /* TARGET_HAS_PRECISE_SMC */
> +    TranslationBlock *current_tb = (target_has_precise_smc() && retaddr)
> +                                   ? tcg_tb_lookup(retaddr) : NULL;
>   
>       /* Range may not cross a page. */
>       tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
> @@ -1134,8 +1130,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>               tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
>           }
>           if (!(tb_last < start || tb_start > last)) {
> -#ifdef TARGET_HAS_PRECISE_SMC
> -            if (current_tb == tb &&
> +            if (target_has_precise_smc() && current_tb == tb &&
>                   (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {

For the record, we can eliminate the target_has_precise_smc() test here, because we've set 
current_tb == NULL, and thus the current_tb == tb test always fails ...

> @@ -1157,15 +1151,13 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>           tlb_unprotect_code(start);
>       }
>   
> -#ifdef TARGET_HAS_PRECISE_SMC
> -    if (current_tb_modified) {
> +    if (target_has_precise_smc() && current_tb_modified) {

... which in turn means that current_tb_modified is never set.

Thus only the one runtime test at the top of the function suffices.


r~

