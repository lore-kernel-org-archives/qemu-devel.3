Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA54FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkeC-0005Lx-8I; Fri, 01 May 2026 05:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkeB-0005Lp-0G
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:58:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIke9-0001g7-Dh
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:58:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so828041b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629536; x=1778234336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xDPxsq8N119yy/eNYgu4mP+B+isAwha07XK+pAm6YiQ=;
 b=wK8ETEYuLD5rm5JFGhi+Hg4eFbFPBWSpiOrA13IYBT4/kieG0Rylt4Gi0w5Qew0VfL
 rZ2DoSArGgukg3u81WrQ1Lkftaen0dx+3iCACaKoabc4IJ07nL1IofAJ8avohCSrijNi
 ue+3emd/bQiG7jMTASvFulcdBLn6rK6fN9R9xSWWAY8Dk/WFMQYleBKo+Q4J7H2zHx5y
 4kAYyPefber9XK5jVWDU8cU3Dx8PHcPNJOs0iRMb3LB5SqwcHguLGlcy9Sv+aIsQ2ZbK
 m+aYY/iZd9wTGLdnlOkMugdYOcrzvcqxvIS1nwcgBG9r+vL+ET4bN++CJEg7G12eXMRK
 ndIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629536; x=1778234336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDPxsq8N119yy/eNYgu4mP+B+isAwha07XK+pAm6YiQ=;
 b=HbFqlgaoYN9rPfc+Kre2eWsa7XKQEQoi8sZGMJKIksQstSLdWpkC6nQyfSIWC/2Hbr
 f92IUHXfnkbKv+QxvSVOphhmBiqtDliyyFBnZPyvgwpGc09mKFnvlrQ02ZSqXGSZ05qU
 4XIkkfeTKKqPKfoua4dwxTvWJ/h/pypUDyhrjaXsf7zIQcFBCwQlTnwGTJ/hrmY5XM2X
 55p4HMiijTiXI0c5LggByILeL/Ns+VqzoE8k6UB+VWOhZRY+3lbfZqYmbi+iU8hDumEx
 3LF3BwVMD+bFRpDw121MU/ycBmZAprdgAdJvwChFrh6l5VccNs6jlRJc/tRNqH51y93T
 8CpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80SA305u6vmFNMSFhNiSFYSqiJnVKi3yUu1ArRVs5lYHCU1YFZoJFFrsZvd2eZ/m6Tzhz3cnYjqAnE@nongnu.org
X-Gm-Message-State: AOJu0YxItnhn65WIh9UyZp3fS+8JuaAsMdcEtJDDi/CMCLqUmB75VyRL
 i1wpjyKFMMewsLkjoAcxQSGxsr8fmnMIF8f1EgMRz59BJ8M3hkPftbLDe2RF0gqpHQf3iGRY48j
 AwMqBAuY=
X-Gm-Gg: AeBDiesVLtDxJW19KIVP3QjoYbpq8+mMpoVRY79hz+QN6blETt6MnyE04Oh21egAw+P
 CvHMpI1TVstS9Os8rb9u+/C8QYa6EvlIak8/0Wm7cTDCWLxqVwamKPWnn4vrKdbSMs/rA6mnPlM
 dFWZnvxUfJoVE0Otov+YrV8gd641yolUCQFzDIDpj2WiUZGFkxi/4241CTudtWLplPl1TF7hch2
 YwKLC6dYOq1Dgd5/QqNdSJQkLTG64P1Eiqi3459OwveA4mHtw6RQfhgrlEioNuqhz1ewR2wIIrt
 HjL72tInuCornFeXimQSdQsY8127RI0Gck/BpL9oP0DJr5UunKfqihNYCT2CuWkIjUHyRBwl4AU
 ec5yrXgP4NAOCaZuLnlU0xWaJsZhNiTu8w4QpjQNwZfyHQAmbMZ8aSPPPYEHk0+YuDnLIPnApmU
 Mh/JoWG79qqgJbCUzWuZYUEJkk56qsJP5dD/9tAaQhfgyTShBYNqE3
X-Received: by 2002:a05:6a00:1f14:b0:82f:4a53:a95b with SMTP id
 d2e1a72fcca58-834fe233ebcmr6976808b3a.37.1777629535441; 
 Fri, 01 May 2026 02:58:55 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b863eesm1953555b3a.60.2026.05.01.02.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:58:55 -0700 (PDT)
Message-ID: <f917f568-db2e-49c3-bb82-3e7a2392251d@linaro.org>
Date: Fri, 1 May 2026 19:58:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/25] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/30/26 19:38, Peter Maydell wrote:
> Currently cpu_memory_rw_debug() assumes page-granularity for translations,
> and it works in a loop where each iteration translates for the vaddr
> rounded down to a page boundary and then copies up to the end of the
> page boundary.
> 
> Rewrite it to use the new cpu_translate_for_debug(): we no longer want
> to round down the input address, and the boundary we copy up to is now
> determined by the lg_page_size it returns rather than being assumed
> to be page-sized.
> 
> This, together with the implementation of translate_for_debug for
> Arm targets, fixes the bug where semihosting would incorrectly
> fail to access parameter blocks that were in memory where the
> start of the 4K region they were in was inaccessible due to MPU
> region settings, even if the parameter block itself was readable.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3292
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Message-id:20260417173105.1648172-18-peter.maydell@linaro.org
> ---
>   system/physmem.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

