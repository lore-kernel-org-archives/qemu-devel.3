Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EDEC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvQS-0003ns-Ht; Fri, 01 Aug 2025 15:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtpo-00011Y-Ab
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:46:40 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtpf-0006wL-C6
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:46:18 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8e19112e8fso695887276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070373; x=1754675173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UD0LO+23yyCZI1j0IHQwoyedRb2kJvdh6gPR6Je0n80=;
 b=kMlFi9KxwRJ0gXRsyYB9AfD+x46nVHTaHx+DC40kA+7INskQrlAzEUllvqeIvCfe/R
 JXNSifWvLZeO8/IujTDgBriJTjBeG0hQ7/NhbvKVMlLNvFezuis66yqF99DsaG27eUKa
 m/WBvzLo4PbQ91POd2FRsQEIP2Bql7rGm+aKdvC3jTAWPykv9b105tdzJ25oCXzGreFH
 ZqaZwUkldnE8fzyOn6A3gcHge+PtxLuqEFeZOZIV4roYgLuWG9eHuQu6ku8Fn6MQh3pI
 nv6+S/lS+8U+Kci0bPMzOXQShd8U8JQ7oiAkell3MNL3QqwlnTlkfeSzPX6PcIgPyhLP
 YBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070373; x=1754675173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UD0LO+23yyCZI1j0IHQwoyedRb2kJvdh6gPR6Je0n80=;
 b=xTrfHwDbIR0OnkMXzJFUSuOly6D2UAQcT5CmUhsyzC+cdz3gdUcaAGmI8bBIKmZVLG
 6u3NEk0YqUB2ux+lslapPDrguPm4sXUCEbUSYjSWQM6bpJ4wli71zxqf0LRwfoSlQa6z
 4a8panv/KOdSg9zP6WHMzsezEHIluzv2PTfN97suli3rSTBVS15tI7C3c2OWI2cTdA8K
 vRwFP6Loe3NftqefHD5WY9tNE+mJxoLEXF0gCxeoBX4HmNT5m+RFKN/wVLlNf4v10u6C
 CAOGKo22MjLrYt5N4TldjMdGdygXvcwBqFHaZvTOtWF0UP8TI4b4IgU7fRofZJbzW21P
 rC2A==
X-Gm-Message-State: AOJu0YyZ7JM0v08HpG/xOnvQYF/FA4VSFeC+XqJb3R2woyUk87sFHFbp
 rOuulG7WGAmW4X7RaHZY7ofHKVPd545PFhHB5O9bJt61ECjUYLOjnE1NkWzEivJZbhzTtAFpSTq
 cP8HmtlRddwa8Aycep878PQsBcFTOIOnYSo2pwAX9BCmp40D78Co8
X-Gm-Gg: ASbGncvsIo0vYp/4zXmvqgml7a5uDG9DUn92NGYFgiZpZt2YkNyWMPz21Enm0b2Cp/f
 UL5O3eC+m2pGQYSEF6QIukrdE2bWheHRjhRZ6B2L7MIaTNAsw9tkxQ5nJEQm9LHtwLsM4Bzyyds
 SAoKH43P84tL7keMm416bXgibuWNbmVJHqsOThcoZi040Uzeu0KJ8fWYR/9w2rHWgyeel0RMLFC
 1adzOC028E6Mnvr+CI=
X-Google-Smtp-Source: AGHT+IFHEtWBOclo45PH3J5K16R2s5dzw3/5AISefed+x0So/SSsLkmewVBVpUWp/qDRusXNcfvXWpiFXPt1r72Me/0=
X-Received: by 2002:a05:690c:84:b0:70e:7882:ea97 with SMTP id
 00721157ae682-71b7ed3688cmr7882517b3.10.1754070373163; Fri, 01 Aug 2025
 10:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-43-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:46:01 +0100
X-Gm-Features: Ac12FXw4ARYDsqmkBmgOZbrh-bgn40K1W7lfI9jRKmj7ybqoDtVtjQWtl0VSDKU
Message-ID: <CAFEAcA8vYXNGUjhKYYNADQDxuiEP5WLGto3AEJr-7Y4O8ADhAQ@mail.gmail.com>
Subject: Re: [PATCH 42/89] linux-user/i386: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 30 Jul 2025 at 01:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                  | 31 +-------------------------
>  linux-user/i386/target_coredump.c.inc | 32 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 30 deletions(-)
>  create mode 100644 linux-user/i386/target_coredump.c.inc

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

