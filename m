Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D3FCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPDl-0004ft-HG; Fri, 08 May 2026 13:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPDi-0004fL-V3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:42:38 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPDh-000233-Ff
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:42:38 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dccda31d3eso642627a34.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778262156; x=1778866956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XLsyZqQ3xY6Rp69A7lxD04CA7DaRt6RfiC8l54oNnM=;
 b=J+x02hM4iXCD7MJmkTn5tZUjd+QSIcJKgQVbZ2111D3xmLKAxst6pMUq/aK1AX5bO8
 XPsl+qCqvM90u/sxIMcswFiCQSSa0Tiue/2KaA/l6v2wgFwNcGqtqGHGlvi2+i47XdZ6
 BjmNdLT5Z74/K5Vn5HBGAqN5MnIS1awcCr4h3acvLWKnlNXn/ycOu1wd9hucDQv7fBRg
 Vp/7eqnJf4xChBgt6FWu0zy0oUUOIZUkNtTQFGi0Sp+iC49F3G62WAU/PnidpDIrqiYb
 LYYNsBnRX9J8AB+Gd1ADFZcgkzOD45GRuxk26t8zb1EHH4As3F+TBZL4rnN4SICsc3oB
 wOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262156; x=1778866956;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XLsyZqQ3xY6Rp69A7lxD04CA7DaRt6RfiC8l54oNnM=;
 b=Ne9xmjsMQyNY2OnBUXqW/ArW5nU2OeM9KOgX4ofZWAbHntvmvfGavQE5iqgMWguSc8
 ybJZxoRUhNn1/4k3SI9b1BkZylfV1+zHgr0RiHnBitp+T/uSwnUdupkjNrjL4TZpelRg
 1+rw4gOBrKagp3k9jkdlS2W9TloPkXxOCPrmKL+c5yShMZymJcGChCsH5guS9OJFJWE2
 +cESZfNwvamckmBPWnUwD3HqDcU+uUVHYbvoBLzmRRwxJ/azjdEInyeBzSvfOm4rolPU
 Cvo/8y6ronrVFKhu2NyyBZ0NbQwK2tVr50G7Mk27WlqUYkjpAbmGekRsqImh75ihbko4
 5eEw==
X-Gm-Message-State: AOJu0YydUrKWMAh7w9Syf0UkkrxkqbzQy5qKWvbjZ2MLkkZfC9fnVqdn
 ZcphdHgsN+wKlx2mhaBh/4K5a3B1+jUR5I4yPTNBX3PoidDF/Uogts5XT2mhcGvyJndftBKuHiA
 7mzFy
X-Gm-Gg: AeBDiesdjHowqXAUPevCxJWh8gx7dfelaB61p02ZGi+gONjxHiVvlJX50VBUnfTkYjM
 mzb3Ll+OMOWg8fpjJw2PdUuNJ+X44GqdP7Z0oSYdMMC4sbCeN9xLuVg/GVKYoRy4P5PFwwryDzY
 j5RTBQ+iVyaHJFe0DnBvQOXCxeefVVcLKhqfUuDAbjfdNDVg2YJJ9aJMmgiBOH9zuTXEczZLmW3
 FHC/G2+SuDn45nZz/a8sNtpAemm6y0s3hr3+ZkpAUGFxl7hcVsYl8TBW6g55A399psjwfRW4xhB
 zQZoVJCrbiU93uk9ToaLHLMOmfuo4lu9w7CCPMVhl58X713F373Dm37o4qd5h1wz2BSnB4WyFu9
 BkNsfVn0IFGA5sGMFzVcCJI0wU90MLU5v+2YqobZ8hZVkFkuenJ8ye1Ht3E6ACQz0YLMraO16Ok
 pNQVeaXabyNfXdUQrQoP0NVsSQqvl+M0k7Ya+3UtjeA0YzU4lsDd7+rgKQ2ZBengLNeGNKvyfRY
 KWAetX8ww==
X-Received: by 2002:a05:6830:6734:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7e1df0c4d92mr8647404a34.18.1778262155749; 
 Fri, 08 May 2026 10:42:35 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d50611sm1520216a34.16.2026.05.08.10.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:42:35 -0700 (PDT)
Message-ID: <92d5a546-7404-4866-a676-d970ce8bb6a1@linaro.org>
Date: Fri, 8 May 2026 12:42:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/32] target/mips: add Octeon multiplier state
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-7-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-7-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
> Add per-thread Octeon multiplier state for the MPL and P limb banks used
> by the VMULU/VMM0/V3MULU instruction family.
> 
> Keep the storage in uint64_t arrays and migrate it as an Octeon-only
> subsection, so later instruction patches can update the architectural
> multiplier state without mixing state layout changes with decode support.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split the multiplier state out of the combined Octeon arithmetic and
>      memory instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/cpu.h            |  4 ++++
>   target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

