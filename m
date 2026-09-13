Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5960FC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 03:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5bEZ-0000xn-Af; Sat, 12 Sep 2026 23:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bEY-0000xW-4Z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:50:26 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5bEW-0002OG-LB
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:50:25 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1063772a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 20:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789271423; x=1789876223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hk0rmQA4S8Tz52CHnUhIhJv6vrx46CLqt4n+9o4hG5E=;
 b=BW+9taPvLLHMjocNIRwBGKyeTP8v4gZ3bSIDgdFHAWhO0YefAieZBh/hAxopRLm0U+
 arFOSBAV/mNr2fb7qoJj6Ex0QDlTkkQ0uZ0ENFWseeD77n31RYCujkLtNvJ6wUIkmgkr
 xx/dzAedNqAAzOd12bIIHZTwy6ZfMPSpP5idt0VTYcIe4b0QjGgnAGwvPrDkbJoprNpr
 80z54veagyDbJGw76wVb0H2xvEsKlhEuuM6cuaZ17d8gatqpDspbeXTHkf56Gf7+0Y5R
 E+lEdWW42lZOsvPLwm/+XMkEtm5qNMCp0PWBo6FUjD4sTh+9YSKvxtjmKchyGgHlz/Q8
 3sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789271423; x=1789876223;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hk0rmQA4S8Tz52CHnUhIhJv6vrx46CLqt4n+9o4hG5E=;
 b=JAgbWlWAJEhJmniKJhF6+5M9trExvHeZAhEgJKU56sZv24vZw3Vdayyalx3iGQOK8Y
 K4um0YHdpEcRUO6rH/ZQZmU+CPEL3FqHVEmQKDeubf+6eO4AAF2m5X7GMUX2iCOUpLpV
 b+8HPcVaPK2OJRiaZR0G+Co12VnnnA14l0oWzXgp1iI3C0QyhvCKZaivtkFnzw+LT0zE
 k3OoXsH/aDYFVsgBkJFT7cAqQfsetz7JuVm+6Ig/9epoUpv/q57XrU/bscbF2JCDV2Rb
 /5tdiUMwbH+koTTr0ieFGvkPJRTqE8VOey7wklwIjjLgqrqVGaxVQc4CBJFPA4HUjTdy
 BamA==
X-Forwarded-Encrypted: i=1;
 AKwUvBybaNR9B0AEHaDFGNgN3H9XbuMTOOid/cm2kxR481biOnuJwQwFbgCwRuQzIy/7SYDsLnyDKgbGAScx@nongnu.org
X-Gm-Message-State: AFuF++llqdB+/9doTpvN/pnUerNPbImhsy/1v2YDDhbBwNvv4k+1EXoM
 iVDaV9qMq1FsDLa3AWlSTNBBe7V0DnAHlprWVKAdILR0j78SAehX9yC45VckH4nHtLc=
X-Gm-Gg: AYBFou3bPvbxNkoQmVY8lP66oPc+qraBCwMqSdVYevo3xA648x7WjPTAZM7hXzgSzFB
 GKO9leAGkaoq28C+b0UFCS3HmHBxzv5FeQeB94XKtjS3fPX7NCALry3xZvrv7WINGzb1azOJ705
 1i21qfdWZpDmf+htjOP2wkSGjhypjuD9Mev53Gcj1ouPHJ77IuBf+WcwxxS9+7rhmJEDWvpXtHj
 sTAPgpe0ctK8r830No6+qb732IrIduudGrCbZ4f5p8VZL/v7UxdQ8gPDYAcPbmi7EE5tAov/yxB
 3vz8Z4LaZOIGyjC2MDPQhRiyFRyoANXVxY7SdZ+EDGxEP3ecVhKyouSl3UjfhRoUXdI7zk4fT+7
 aXz2RbOtF2JH58kqBzKEviEpEF2DbsSZ8R5igM+REigELP38LVpDSIsQOb/OXSc9lVaq0ptyt/b
 d3ASInNeu5MzuIVJe8jviseqPTvSsZAdOPfPL0An8Is2hk13mDlpfseKUpcVBY5WJMjbuT+HhTH
 r0YFX9BO+bwwdS7Th/nKoOWXdrtCqaKah0R2tJzh5JT5U5PhiIhG7YC0ObuxQ==
X-Received: by 2002:a17:90a:ec8c:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-39d9bbe4910mr22492663a91.5.1789271422987; 
 Sat, 12 Sep 2026 20:50:22 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm30505266c88.12.2026.09.12.20.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 20:50:22 -0700 (PDT)
Message-ID: <9d27a935-305a-4623-96cc-93d09173b8db@linaro.org>
Date: Sat, 12 Sep 2026 17:50:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] accel/tcg: Add do_interrupt() wrapper for
 targets to manage BQL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> Add TCGCPUOps::do_interrupt() as a wrapper that targets can
> implement to control BQL locking independently. The existing
> do_interrupt_locked() callback remains for BQL-held contexts.
> This allows each target to decide when to acquire the BQL.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h | 14 ++++++++++++++
>   accel/tcg/cpu-exec.c        | 12 ++++++++----
>   2 files changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

