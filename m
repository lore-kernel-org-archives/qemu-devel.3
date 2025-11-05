Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383DACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 07:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGYKO-0008GC-Bm; Wed, 05 Nov 2025 02:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGYKI-0008FN-ND
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:53:06 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGYKG-0006DE-UV
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 02:53:06 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640f627d01dso2141089a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 23:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762329182; x=1762933982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wP7t0HPBmtYxh7RORMgZ73cRxVgwmNb+MJLpjsLJ9vA=;
 b=BeAMqteY5UoXEn2FP/tAP4+R4TzOZ8FLmpUElI8H5OkBNDTf0EwOhFhnKW85/8VP1A
 UMIpYydqXRj4vrgTlnZeL1s9a45yRFibuirsUv8glkUpqqlxh33Wu5hiEbA5deR6Wl6L
 bldosk6asOLllw/0KiYYWYGcBoiWFTZmp/t6b1LmK+r8bd5OHRtltg5wFu9kbppU4VZJ
 VCCcgsiNy5zsRt5n8IHIbpWt/4luWo59hR9E5lWlnC0Rwz7V8md/9bg/u8vkO50uQqtb
 ia7EzhmBiNPKTr/tH2GkhdHY05+P8kdDzWI0VQRi8QLHGZg1VlIAQcDoaAm6Ii4cyUwx
 MDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762329182; x=1762933982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wP7t0HPBmtYxh7RORMgZ73cRxVgwmNb+MJLpjsLJ9vA=;
 b=KLuaTCg23OkAouAyLAxHkuBOcZiYgjOobDN1dcm+HwHEjpLn1a1g83ssSf+UTY4jL7
 2dii2D79cJfxu0ZOdXMxANj+AbEutyUigtdPYwNziXjwex3CaCsMbIM8k1DFAgjv2T+I
 0ukWdVPU8tojkzYq66eexv9GQD7l5EeMTqMeG1BtfbzmefAxha2DKBw/gnw5w6AFUkek
 dGCyN0a+3kftCU51Nhhw614UFTq+0ZooGIkjZlwX0tcqYSXTalko8XHAr5EFRCFLhPM1
 4ei+zFwU39Cc7mALQnNkhhe4q4NkwP+1VhycGREYKvU1Q/GJXOQK2l4ZP5X9zG5GLoVs
 RMcg==
X-Gm-Message-State: AOJu0Yz2T3ky7rnNJIWRWceI+925IT67H3TVc3U4L/3g46Rs9MCKKmar
 yNHbnXay1AoTHlDLVxufAS96OEzoynVHLoBiCDuPE9QbA9F+NtmLgccIn/rtR5M6pz+xZ5ws3CE
 sbF5gZbs=
X-Gm-Gg: ASbGnctxoU3NcD/W16ZpK9kEO8ztu+JueYMT0T4s/lqLvtbiWqHDLoXAonYcZFGZaB9
 sJ9A1deDOvMlgAgih09b3LV+fUyxNmIodLdbPDPheCzD1OF/UaDwV9ZOciydyADicVLoqsw6/Ei
 O1cc/0EWBgD1baXhztrDifi9u6HYULOfeQKpXMwr84FP3mjshMAYrWwdQ5qLL29WZ3KJayM1nd5
 BriqcdIfo2F30bcI/foMtsKSkRxmt1vYvUmSDtpT4yolD9KR9w2x9WQ+TnkKFCff6dJxWKOc0Ip
 6wPERG0rKJOuUHD6RlCD4CjMxk7+mTbE0fK7QZU+8yaht/owt0rhLf8LW1YYodbLUM7fplu9fzO
 psVWYk9WEzRkr/O8D3c7DppgRdGvaG2NAvUQid4BIs2CbyTYggg44hexudBuwoe7MT01mLyjJLp
 nR6a/wCuP+oVNbhShMo6Q0sd5OGSo=
X-Google-Smtp-Source: AGHT+IHTyo138AomD2Cc5hXRLPvArHNgE/e7szjsJz9xdhPFe8YFcBsYkgq/v5I+/NNq7qxSdjsjDQ==
X-Received: by 2002:a17:907:9716:b0:b71:1420:334b with SMTP id
 a640c23a62f3a-b726515dc56mr200582966b.8.1762329182265; 
 Tue, 04 Nov 2025 23:53:02 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723db0fd12sm417531766b.32.2025.11.04.23.53.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 23:53:01 -0800 (PST)
Message-ID: <cfc8529c-592e-4382-80b9-de2b7e2bfa83@linaro.org>
Date: Wed, 5 Nov 2025 08:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] Staging patches
To: qemu-devel@nongnu.org
References: <20251103210625.3689448-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 11/3/25 22:05, Peter Xu wrote:
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/staging-pull-request
> 
> for you to fetch changes up to 7b842fe354c63feaffc63c850b28c3610a0c90d2:
> 
>    migration: Introduce POSTCOPY_DEVICE state (2025-11-03 16:04:10 -0500)
> 
> ----------------------------------------------------------------
> mem + migration pull for 10.2
> 
> - Fabiano's patch to fix snapshot crash by rejecting some caps
> - Marco's mapped-ram support on snapshot save/load
> - Steve's cpr maintainers entry update on retirement
> - Peter's coverity fixes
> - Chenyi's tdx fix on hugetlbfs regression
> - Peter's doc update on migrate resume flag
> - Peter's doc update on HMP set parameter for cpr-exec-command's char** parsing
> - Xiaoyao's guest-memfd fix for enabling shmem
> - Arun's fix on error_fatal regression for migration errors
> - Bin's fix on redundant error free for add block failures
> - Markus's cleanup around MigMode sets
> - Peter's two patches (out of loadvm threadify) to cleanup qio read peek process
> - Thomas's vmstate-static-checker update for possible deprecation of argparse use
> - Stefan's fix on windows deadlock by making unassigned MMIOs lockless

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

