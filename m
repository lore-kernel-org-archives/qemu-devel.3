Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DFDC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrSQ-0006Cg-9A; Fri, 01 Aug 2025 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr99-00025A-KD
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:54:15 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr98-0007YX-2H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:54:11 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8fd38cb2abso1704278276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060049; x=1754664849; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5cOHIY9VsJgw6KWkkGlhqorrKxGGrMGwkwp1ykvbuI8=;
 b=tooXRnxktMfgoG1QMd7ouDZC16oDkLuWVH0uhtovNl+Hpb6vYyfpFAGhYGdoQkXua+
 /78xdSSfjck1YY9aEh0IajX5UijZByZ0bo5/ZyIEPk7CgJhYwfKlhqMAjpY+TpGAgcvv
 4jI8wZTWM1UBpVm0NJEuXq/jLZWabmsSvR6whJfggHnXmpJTgDhX3Z0K5+QMb2fZhs+n
 EDTMeSvLjPNFto7LUUlaY3/k6AuUmVT4vJekMFqWNWkcEIqJGgTOHjcmfGr65GjstsxN
 QvhXDWS1gnIN0IOYqXsELDfvXnnSRuNYO1G+1MmNTjqgwuWDljzy2Zzb8Y9QZu3zStUs
 Yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060049; x=1754664849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cOHIY9VsJgw6KWkkGlhqorrKxGGrMGwkwp1ykvbuI8=;
 b=oKdCFZhFSqNJ942++ZqAoHTmf1NPwb1Wgo7D4+AphESgyZQOplkkM26zUAWWf0rXw9
 TOtlZkqR3zzhunNnHNeVV2uUkO6SzV1Gb0+Bfzi0WSCf1UkiLHBkw8Jvpe5EalQ2kCbN
 RkVuseZOjrY+jwmVTBW0xyjCItmWY6edD8nKraiTcPhsPCNhUqI5aH2rCbpPab+F64vx
 1DlonuL1jPBeVpf3fW5ayOXh3CPO/zkwOsx9tqVwVmkEOTF3KSVgHU+1zg9JTpBQIJRA
 PKThNNoNWrcPGAHX6xfJetV2h6EZebAemzcRoPU8X/PSkjcIvMiTFQIOp6ACHF+GYZP/
 cyXg==
X-Gm-Message-State: AOJu0Ywi0aOVh3xSepeoOGaqL/UNX+iHETxUaRwZE3RI4SgwnvhiSV6K
 eCQT8nXfBtsJ3drwj+Zs1iB73TUEJORXBiuqvnUY+4XGrg2CzYBPWz9HAgzBuMkc2YKZdNQh6oa
 +7VU9moQc+hbHzNa5yryTZLaLYVW7V/nSzUKVVtCtvHQnvjSIGQiw
X-Gm-Gg: ASbGnctO+sj0NF2PaNbEvSUU2Z4zh5mDuKQSvtnDO/J2+HE9Mm3V+OKnij/oP/s4PsY
 RpElFZ9amAInz+rep64gsFI3YFiZKe3SLC174xC6N2yBHfwkzV/xGcNCQ+GRYqy5KY2lJ/yUVR6
 0jeLsFpt8rj0adNdoiydkm7XWMFSpph2FD1pezCFkE6XAePlSKmXh/Rvaz4vpEcOV+t5Kfn2wYE
 z4lW6bf
X-Google-Smtp-Source: AGHT+IFf9aOBVJILlqZuBOzHf8NlS2IkDGSNo+U35tmZPJhRJf1jc13znx+q1fstky+TklTcqCrhQpzQJyM6WMfYGs0=
X-Received: by 2002:a05:690c:6ac8:b0:71a:3437:af45 with SMTP id
 00721157ae682-71a4665ac7dmr149383207b3.25.1754060048793; Fri, 01 Aug 2025
 07:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-5-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:53:57 +0100
X-Gm-Features: Ac12FXwuCcOMgFPQkOzUEcJ7Gewl-CC0w6d5PyuLEIcF6mpJlS5l0u3BDMroMLI
Message-ID: <CAFEAcA8kcZ0DNH8UsGNGtmhs12EuDSs8sxQjar7ibc62gDGfxg@mail.gmail.com>
Subject: Re: [PATCH 04/89] linux-user: Move get_elf_hwcap to sparc/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 30 Jul 2025 at 01:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h        |  3 ++-
>  linux-user/elfload.c       | 30 +-----------------------------
>  linux-user/sparc/elfload.c | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 30 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

