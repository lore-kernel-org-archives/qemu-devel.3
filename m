Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB66C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXImd-0006rF-IM; Thu, 03 Jul 2025 08:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImb-0006qn-Tn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:17 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImU-0006g6-GG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:17 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e75668006b9so5438120276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544668; x=1752149468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e4HueuiGRGz+uUKEE/fAExt6DRnrRJyshFWLrez/8to=;
 b=Y3LXHJNQXUe6QjlnUNEu+O9c33MfJv5mBQ6LSSFibj2Rs90D2+N4nRF0mumB1LVssx
 9nj7VFq8ICe8rRkkmPYq1kPNgnWVw+DA6DaVwvrWuA4UnymKvip2HFX+qnvjoDU1vnT0
 r9tfZZOlBt1FxKg8QRxeTeTOXLWLV+Y1JjbX0pwKGHrQ42pDowA7UDPHSKqutpOarmIh
 Azb/UNa8/tuDf5kRwHjq6WSJkrQ02CUsKX7ivwMt3O18aZcSuV9O+0/rYpycJJpKVdQZ
 pzMJbD1B2b85U4lGsKW2UGKQNjOzVmTWLr+qSrYq+JhaAzGkcqVuwhvLWRLZQ/fC9xpb
 Hz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544668; x=1752149468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e4HueuiGRGz+uUKEE/fAExt6DRnrRJyshFWLrez/8to=;
 b=Em8tOQwYe6G/jL0fN2pnIME+6psXxxDd4FNY9fThsphfcLkWp9s2uuaFUyrkynqFoz
 oycu+oLpnzoIJmpwfYFxiBsTDLOOfrpFnkrpBztPtT2DSTR5EPS5TZ7eWJEt/1fBYZSU
 kBTa3wlIWVwOxgMg3X1ORqw0kU/mhZf6HGlXK7/V+upuBYE4cGdiiY9m5iENfpnqtirL
 3+MwNtMjlVh403VMctciaATkZzJ0vHSNULQSqZTwmH1pYqyqEbrR07kieOZI44+MuaA3
 AQGARAWefIzBOPwWmRR35JITmXV13QQB7sNNDiXA6i3eKM5P3G2/d9NiUgfWET8L1CXF
 zpag==
X-Gm-Message-State: AOJu0YyO84YrQ5oz6k/R18omt9ksyD49UR5r/fq3M+KYkWrkXwUCrEDO
 MnxugrPHxtNCbWp8DUWL+qn2TO8tNOGfm2oh2g2p8q3pdWhdNNpWyBawqfqDLzHOWiwSZfG8U3X
 fdITvt6y5LGyOqgldp5H8GZspY7pJdktdI+6Y0Y3Sb+mDxwD5xn23
X-Gm-Gg: ASbGncvzFjv6xBRWYaQ/32se6ikHlLws1TkxNiKnT16Qq3VLaP/pCsL2vJ3fbgp0WMw
 /2f64K6DqOoSRopCh306Q3e0KdcgRwSyhtr0DKJZVmL4Zi8DVyYtjl+VGbTBa32Tn3S5kWhVXJj
 Uqp6pl5I5NQ0QNGpMyG7GUj6dUYfSy4QUEn7+8SeNK511i
X-Google-Smtp-Source: AGHT+IFKfHCYIuttquXLjC7TRjFIXXni1k96dj38LH0OGzBlWsFEB6/RYyh5wsW/4Uw254ZQ8M0P9NZspwBhOteqnzs=
X-Received: by 2002:a05:690c:b03:b0:70e:143:b82f with SMTP id
 00721157ae682-7164d4a3a7bmr90330687b3.32.1751544667989; Thu, 03 Jul 2025
 05:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-67-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:10:56 +0100
X-Gm-Features: Ac12FXzG2HlWv-2fAayNlYagpqiTg8G9TSK45VdAfLbNvarVFuF6x8-ZeOGsBrk
Message-ID: <CAFEAcA-stX+Mzpi0XuLSNVDpS+YyArcuSv=o78nY9m1YtBH9ag@mail.gmail.com>
Subject: Re: [PATCH v3 66/97] target/arm: Enable PSEL for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This instruction is present in both SME(1) and SVE2.1 extensions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

