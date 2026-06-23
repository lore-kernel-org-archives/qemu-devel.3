Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5DACD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwuB-0000LR-LO; Tue, 23 Jun 2026 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwu9-0000Kp-Ar
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:54:49 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwu7-0007dn-6m
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:54:48 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6603d8697d2so5098248d50.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204885; cv=none;
 d=google.com; s=arc-20240605;
 b=O3UFw9uXcQSEhK5WM1LWkFCEngeTKkrXFaku+mgk3q709CkcWwC+PEqPHt6wF6A9Z1
 knlSvTQ/9usRmXtxA+jpYJQ/pcx5gSRRT6UsCx19O2aiYJFNbbDn8R6CqaRViqAEWPsV
 abP49299JKgtdKpq8z5nlyghfp3btJRPI3sL+1q+9UF6E6oS/c6jibv2OdJgNitkcliD
 mi+v4umv1N9y+4/Fap4BKZ6BRTtqNV8yritBvVvO8f3gOADuOHfCyVqaOwHh2jC1QBEJ
 nkvWkXonGWBINE0QBEtYreWbD7M3FNVtJmwtSDHZwDXvyaXDrY4+/BXuHNAypTtSUBnz
 l2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MMGIG6dX379ZuDL4rdKoglJZqWWqjGaqYzHKpXAIYac=;
 fh=NQqZtnaAYV7t1mhOfL1aUng32BmCPbILN5V4pwdJe9o=;
 b=F4GxcK5koMSfKaGhI2Bko3lO9twdt6oInpVy6i6A0s3wokRVCgP8sJ/80IYbXa9O+O
 KZEW8FwJqn+rryutSwi2xDM23Owhqi0wMCIK/oho5YzaggjDGIvQaTSuLzxMQiHQ676r
 yFuhqp0BuxY8qpNz/SO70p+1wJnd9or9mCPVMKYVdcqiFcLlN0fpLKMOeU3Rev8bgMpc
 nfIgmpLxxzLNWzroRVSsFEagWAIIp5SHei2cpX1Utd23vfrUdRv41+0P4gJEQCN4pJgy
 A8id0F/ShzzvAYRqOApsouxNTv1q98r8DLZGkKr2ExNuE5SNHWV6dGLixghHBqZtsss8
 TKHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204885; x=1782809685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MMGIG6dX379ZuDL4rdKoglJZqWWqjGaqYzHKpXAIYac=;
 b=JOOSYqSugKwszo4Sa08zgY3mFCJvdG4ECjKXmV7U/0TajfKRfwdH8OY8dOez8jhMx5
 NSnKyK5VIEAwCJkjAgalMmntIXLo3S2U+S7/9bCZoWefzVnC3KQK3FtyEXyIA7IHitaB
 GdngsMOUPi65X7rM/qsbGO6AIfVsHFBPEF2fYijqHO1U8r8xrdNG8wUGefDDz66wtT8s
 SBauMeIzxEHUXnI/bDqE//xsrsapuywYRWMyYw6QHSIeTL98hI8ayhF3Bp/UyNWCBAXX
 6ZHdMGPlWk/939BwcYaTY1enosvOgWYDFr1PbYYY+Kp7OKDpHnaKL7IBZVoJsBIn0b5U
 BbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204885; x=1782809685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMGIG6dX379ZuDL4rdKoglJZqWWqjGaqYzHKpXAIYac=;
 b=Al8q85+BPsyWJANbFUR57pbAUoZC9IhAykLSWVJhCTTW0M+tBm+6EEWTn+D6y4t+Z4
 pKZUje0bWN/54V3iwOrNgMoDTmpybYHJOUrLICgJ9a2+lDXxXXZezaknBIwWXyA9sk6y
 vtmhFzvHHy8uNdalOFc4304v3Dt4vnGEBrWc9KSoL6JXlPjut5A9M56Kqq5U+IJYlSzV
 gl+3MZyrqDVZNSgYkYH9ZlHfmlB/YD6f+EHYEYz8//zm8ZT9stKvEqICeaT/2sK/Ztp7
 JfT2vnJd85SErsGb3Km8HcgfFSndsk3qPbch3uURqjRkLKwhEJPR38Vc5I8sxhHWlmHf
 AH9A==
X-Gm-Message-State: AOJu0YwqUneTXfMKVPPOPUJ4+IeU/Uxhkd3EjA2HbQCPGOM1myFEARAh
 9D/eugTtEVKK4uHtbVoRZJlNs5I3bYRFzH6THKJnBC5QaHpKfIadJNRQ6kkg77ZIagpWBQOoPjP
 VgBqQ8UgP8+cmsBGfO88TZnkVviDKs0eY87wranqgQg==
X-Gm-Gg: AfdE7ckae50UTB/uksSRUr08HqCxHUTTpxhKwJw+Xk9eXxIj7FpRIi2lrJHpotV6RHf
 tm35LtgbUwP+kJKGoRUUS0x4f8k6873kmQ8Imwivchtdy/1xQXOLmawi+LR8CZ3FH2/IZBt/yTF
 D1vl2bnkhhJBlhCR8JVo7f/wNwaIGZRGXJJ7skxlqq8oqDu0xDYACRJ/u4Hq4RiKhITjcwX5o+z
 8ZJkductxp0SrPVey1Feo5DPyJBRs7teGDb7kmCND+cDtUyjtEWN2cZvB9VPkzjsF/EILkJpHoA
 +76GrW/ANcrDrM3swp+Engdi9B31hLSN9XbSCYB4H8QYvepa2jaJxwqB
X-Received: by 2002:a05:690e:1385:b0:662:b984:a5c0 with SMTP id
 956f58d0204a3-66312db9c21mr13724905d50.18.1782204885272; Tue, 23 Jun 2026
 01:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
In-Reply-To: <20260617235032.21491-3-mhjacobson@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 09:54:33 +0100
X-Gm-Features: AVVi8CfG4J0_cp4TCtln4bQiumXY6E6CRlVnEFGnfm4dlnpPXEx2VhFVGKQh8ms
Message-ID: <CAFEAcA86dxpB8Tj805e185yiFCp9eE_Y4MeHJAAwdGq+uYP3zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
To: Matt Jacobson <mhjacobson@me.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 18 Jun 2026 at 00:52, Matt Jacobson <mhjacobson@me.com> wrote:
>
> Add fifo32_peek(), which, like the other Fifo32 functions, ultimately just
> delegates to the Fifo8 code.
>
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>

> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
> +{
> +    uint8_t bytes[sizeof(uint32_t)];
> +    uint32_t ret = 0;
> +    int i;
> +
> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);

Oh, a trivial style nit since this needs respinning anyway:
we generally prefer[*] "sizeof(foo)" over "sizeof foo", which
also matches the other two uses in the file.

> +
> +    for (i = 0; i < sizeof(uint32_t); i++) {
> +        ret |= (uint32_t)bytes[i] << (i * 8);
> +    }

[*] empirically:
$ git grep 'sizeof ' |wc -l
295
$ git grep 'sizeof(' |wc -l
13591

thanks
-- PMM

