Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42302F99C6D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtRv-0003VX-29; Fri, 17 Apr 2026 20:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtRt-0003VF-Jq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:22:13 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtRr-0008L1-W9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:22:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-356337f058aso833738a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471730; x=1777076530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6l5ZLN77d0bX+8Vtyttd5QpxpAk4w+0sShnDzrjTyo=;
 b=FaLE7OUpIJae5lmV80zHpV56vAvFlp/oKYIvK9y5We3uJp8hTDQo5o9w7ViBpko96C
 3fHTp0PW8l6Dqb8kMJKBKbH8vsZu4X1F+fOW260Ybz9ebIvPyGsoNWyjBthWM7C5R6MN
 JhZQo6zShz2pOdu54/BK1Rzyb6Gdrv8YjpR/O+g847fbXRl1j2gJZaeG6woQ1sCLUf22
 7QSToU+hG8OAhq3scS5Zx1xltA7Eg1CPug0x8oDa2LIga8cQhAQvCRzY+5VzUdWLtKsc
 pbrRjRcJfOUp+ENBsxQYzA1uJlWzxQdsgl5/rihly4+q7MGr6+MHLO5I5cBDY4I/EWKj
 fQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471730; x=1777076530;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6l5ZLN77d0bX+8Vtyttd5QpxpAk4w+0sShnDzrjTyo=;
 b=rKKyNduYnxr1QHad2L/vQPjQLwbwd7NZaSfEj2RnqyYZDfIhQrkWluqerK4mNbfW63
 Y6RAshF5po6NermlFtmaHzIkG6MAdoIm1OJqG9HIIs7ZfSCJd190FUXYA8L3cKAqmf4F
 kq7sX4zn91CDzdGx6Hl0mszisfhnzo+L7L5pxXKhaOvsI8lzNe0YQRpUIv5lgnFy7k3B
 lAz8w5moq34nDBVWSJUAGifKZTk7zl/UJwP4VwFE5M6rItBgqGWFTytCCx5C5E4TSaG6
 lnNTwLovFcVlghKw3W1K+LH+kYum9IdWfSjmwBhVnAGyiF4nXU6MHnoISebjJbI1USyP
 D+KA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gxFd+o+AYr6IBDpyNTFOIO+sMnpwd0g6mOUUqdeiowkERQ+UYFk6dwMT5Aa+OmfBERT1GlB/XNinC@nongnu.org
X-Gm-Message-State: AOJu0Yx0CMS0AZehmtNANL72hwU+pEVTYWjURO0pxnwkX06++YXm/JiA
 WyZywdnINcEWi186f4ZFijoK0cgSrwOLVmWC7AqHj/jRyodD6JhzNP9KTgyVcc2btpw=
X-Gm-Gg: AeBDievJYdqMIoOtr1nPWRpBQfmTOpC+Y2cdBYYnaQTRmEzlO2ppabscz8gTtkg764O
 BJT/aOfPPKtr1qbJUVV0UoMNBEnhtrs3pHZGJDeQtjV5AmHEMknuvFbZ7DslbpCcCN789m6f076
 YpWo7XuH56Brm9AundKPowYRXUf+0CPfdB3oMBF/wNNmSQB+NEBMHyubsUtD92h87n+02Akq0nm
 +kRWjOqZ8Lun/GeoSYdLerFkpdV5SGyNQVZ2IB7/CJzDcPQVt28X3CRAjWVqU0waF/6qF2viq/9
 OdV/su+uYJzNCfoUql1TnTsy2eG1O0ztiG9v+oCinSdFixw5y2C+YEec6hr7gN5jXnfZvove4Xr
 1Af3gnFisgSKBIq1bMEqcsKbwyNP6egjYCqu/eWkXaLt1H81qwNofJBGV2O7ScJjbI2agWmSpPR
 6z7Az+ujnHL/PRklYSg4lQtN9ukYJNrW/iQW5/12BLfrGKqTjUBECqMZmIGifORaoHl1Da5F3kl
 l+yMH13F0f5NH9lfqAlQfxmLW78+Zr49/u5n3qQlqLr0EKHb9i+7zg6QK0namSqeQ==
X-Received: by 2002:a17:90b:1dc7:b0:359:fdc0:4621 with SMTP id
 98e67ed59e1d1-36140404195mr4510546a91.11.1776471729898; 
 Fri, 17 Apr 2026 17:22:09 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614195a9f0sm3063716a91.9.2026.04.17.17.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:22:09 -0700 (PDT)
Message-ID: <665bc589-0f52-4911-ab5b-b25bf1c677ce@linaro.org>
Date: Sat, 18 Apr 2026 10:22:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260417042620.35329-1-philmd@linaro.org>
 <20260417042620.35329-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417042620.35329-2-philmd@linaro.org>
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

On 4/17/26 14:26, Philippe Mathieu-Daudé wrote:
> In preparation of using the MemOp content in the next commit
> (thus stopping ignoring it), pass it as MemOpIdx.
> 
> The helper prototype declaration always took a TCGv_i32 as
> last argument, correct that.
> 
> Rename the ignored 'mem_idx' argument on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/helper.h          | 4 ++--
>   target/mips/tcg/ldst_helper.c | 5 ++++-
>   target/mips/tcg/translate.c   | 7 ++++---
>   3 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

