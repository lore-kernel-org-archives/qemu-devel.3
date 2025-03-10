Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F04C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgx8-0005LP-NY; Mon, 10 Mar 2025 13:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwa-0004wb-Tq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:29:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgwX-0003Q7-TH
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:29:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2240b4de12bso76515635ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627772; x=1742232572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SxSSsMF1RrqZqfbPB9TdMsitfz2Dexfy89dDpPHHAZ8=;
 b=TQN5pab8YxT2gdYfNnzFywDKOjhsAB5phrcLsN88pEYnX196lbU6eF6gW834bQ/hmt
 i+OGd6+wu1NArzeb3osFX2NyNZgZQMrbiPss6O79ezaHgor1f8SROtLHBXe8fMx97eaK
 g0hlxnR9+kGsn+XcVN+A8tJRE1SyEGg7EN/M8S6ndjDiqM+lej8Wxb/gsOamthlpDV9Q
 IAg/3YmNG5TO7nICUS0np+G7gqiwfkwjT/oGuv5bqpD326dt5bG1HIlIbzSsVjPUdr/e
 uRA3UVrObUX5bVHULToj450Lxz/vLuJ4P0fRckzt2+y/nMOR2sSIEzaz/tWJdOoPryF6
 za/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627772; x=1742232572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxSSsMF1RrqZqfbPB9TdMsitfz2Dexfy89dDpPHHAZ8=;
 b=PJ7sGiCwWfS4mS981CS1rFNErex4dlTR/7+VWiLpo8nsIrbngkM7T/EQbp5+IiI+CQ
 rUvt95UAKVCDxxJ6pfb/a9Uan6RZewuOKgdOGeyTtcVF/WBnBOPnca0mF85DR/WOgZKE
 KdHiMDKg7HOLUPlrrqAX/vQ7l65dQyZ3JL2H07X7yDh+J2kkNQGlXf3GuG5tvyOhonZz
 TAj1S6reN5fpxa7pbbKOgvALvztvqKE0X21CAjue1c1TFb9X7lJbdM3U14EOqpcCbj+H
 Iz08dwuTJWFKRYVv5IkS00OaofTW5FNolqyG6oZcF4LJyLPDPhF1eAxEtjkDkrwDV+VL
 rtzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Ppl0pkj3Za+qq5Pn46E+bQqZpSX5zxQJ7+DyVjS/KXGyPS59m+2E8mNergaqVELXncxFvBqWXgiS@nongnu.org
X-Gm-Message-State: AOJu0Yxav8Siv+cutgQ8gbxQLe95jWOrOC9J6grAt9Kf2XfzM6tyk7x5
 a8rLp/1CzU5DjeHXykoDyhFblIeH2UhczrDuF0ocaVDT7PA+I48YVqfc++/NsHBvbcsqppcqfTI
 V
X-Gm-Gg: ASbGncvImyTukF4dRg2XwxgFEx9HjbnZfqp95rQnZC/fstvrfOODFahLPP3PcxM2zFq
 o+UHwxNl/DbArlFHrg4ub5hgU4q5kUcZ3rT42hvb8gVSm4sUe84Z+QhYXgDr8F8Z/pumPk9wYQX
 zji7BX3Us6HK8NQEIpnUlvxCumvdL5yn8Z1rTBUqnPfyrpr6zjwGLxFUQ9BGye42K+SpkmLmSkm
 xIl9VyLPMgORXngnsh/SoaGHRNpUuB8a37XtKZNXA9Kb6dtjuOBM5oVfasal49lW97uMxCMcG1i
 +ZYOhxjIL9kmWbEpG6HtRMm3b5QUcR+PRELF7xEbQYADzqe1BJYcDw7DYBWSIo4DogzuYAER6V2
 XnxNJd+Sq
X-Google-Smtp-Source: AGHT+IGQ9heAsXh6bcZJHX+z8w6gxt8cwbImD60AdUJdTLBQH6nfJKEFEmUbmmNrDxCEnUrqutVCPg==
X-Received: by 2002:a17:903:230d:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-2242887b4abmr234416565ad.11.1741627772086; 
 Mon, 10 Mar 2025 10:29:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f773sm81102425ad.117.2025.03.10.10.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:29:31 -0700 (PDT)
Message-ID: <64152892-eb66-41cd-9d1c-5e1b6180b8cd@linaro.org>
Date: Mon, 10 Mar 2025 10:29:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] exec/memory-internal: remove dependency on cpu.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory-internal.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
> index 100c1237ac2..b729f3b25ad 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -20,8 +20,6 @@
>   #ifndef MEMORY_INTERNAL_H
>   #define MEMORY_INTERNAL_H
>   
> -#include "cpu.h"
> -
>   #ifndef CONFIG_USER_ONLY
>   static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
>   {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

