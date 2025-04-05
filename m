Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CF5C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16BC-0005Nu-02; Sat, 05 Apr 2025 12:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16B9-0005BJ-9t
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:15:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16B7-0005ci-OH
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:15:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22622ddcc35so40582305ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869728; x=1744474528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2grh9XksUgiCyocAfskODT/dzWkQdOjvcbZkf7/dAo=;
 b=Ti02MhHTU2enebl80YkCsL31EMKY4CUe5WP8d27tAzEZCZp2VuhbkyCCUHRR6d1wKc
 iU5yaOS2d5hnxtZkY67JEuEPmCIkRoMKhGR/WhFc+Um6NvgRacwHhHdvv3HpUc174r+2
 Yy0oUgolnVok2Q9hKfTPBDi0smhA+7OPV2/DxR5fScCCqLUKXZgbbSoRKbrzeuz1MktV
 KoioEgoiX00peRhXTicX26Uf3pIlYNH26liAN9KH8szdd3MP2gp2nn1QqenjvaBQt4ib
 A0H8VvHicHm/C5rFTm72qUxWI2Lhb7TngxzA9sUVGvrFHIKeKf0xl59POU3Gen68Uhka
 MKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869728; x=1744474528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2grh9XksUgiCyocAfskODT/dzWkQdOjvcbZkf7/dAo=;
 b=BiVAqP3eQNmX3yJ++g0+i4UfekrjI4t4LFoa6QaxXn5p7NvYhHzuqWf3Go/o8mYJqv
 IP61AyUYpAPnHcmYQVmohea4bRDb7jJ7e9w9gpFh0x/zwHHdap2sgzTwVbi5Kq0iYc/R
 dtvdFGKduJshC7UOLWxu9QwpXypEe3HEl+pC3EKKPYlNrpstRSstAR7Ent50kiPUqSDN
 UvdWzlpC2AAylTi3ZiNlJmvnIiRsWw+/1Hz0dDB4thOo9ZpDjM9n3m4/ESF75TUql9/v
 I+tniaCkDVlZQHdnpYOLV9eSzszDgPU/+BCsKJ0N7g12PcgyQ/z2+LuFf6kNMlXDyrPP
 HQEA==
X-Gm-Message-State: AOJu0YzWvlg1lNYUBgU6IE4aumCDD9L3Zqvu0+p0y8rw6y//o/NKBLB+
 GseWXxZa6qGgsQtuMc/ssOs8HAzcniTEIXW5jal8HH1ySIPqC+hPVNsZ4bTWC9bJ0JTp8m59+hv
 A
X-Gm-Gg: ASbGncvyhsgzVwBtyfgsPNRPNxgcSM3c/ABUXIoSjPMNPmiJzyEat7yUaVagrL693/a
 7Rs+KaiwRaPyozkqhzq8+H6FTiDdvgbgrSfM2NAydYPPIgpOKb/2wnHv8/TrgGASeRxelSW/N0j
 up6Faj1UeKg5vpUpHnN0d1qOSnvf4iOESZkV3Xnxr/Jf3Jrb1D8JhA1xT719yjwwY/vQA8zKU2o
 IeV9PpR25ajLFvP57jVN8fG2oPCuPdgw/LDj2f1KMKX72iHPNkKoD5AKeVmsFqVpXTi/FcOB0yj
 TON9l2dkHGGTP/Fvwf+lLtEAQqce87LEWhbciPhOBGnqxx7+2a9I1D5ZV2Ba/ONA
X-Google-Smtp-Source: AGHT+IEvdiurYruuGJFPBZe1iH5hoTdkQU/vjTqpUlCiB5BGQ9z/0m7PwIdXzIDhb6atqfAJ8RSaSw==
X-Received: by 2002:a17:902:ebd1:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-22a9558948emr50800795ad.46.1743869728124; 
 Sat, 05 Apr 2025 09:15:28 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057cb5d6e0sm5806780a91.35.2025.04.05.09.15.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:15:27 -0700 (PDT)
Message-ID: <ad0c1a7c-6a40-49fa-a707-efaa0fa342b8@linaro.org>
Date: Sat, 5 Apr 2025 09:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 5/9] target/arm/mte: Reduce
 address_with_allocation_tag() scope
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> address_with_allocation_tag() is only used in mte_helper.c,
> move it there.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/internals.h      | 5 -----
>   target/arm/tcg/mte_helper.c | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

