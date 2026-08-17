Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4A5C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzLW-0003wS-4k; Mon, 17 Aug 2026 11:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzL4-0003uf-BW
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:33:35 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzKy-0006kz-PL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:33:22 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-80c5cb9a888so35639487b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980799; cv=none;
 d=google.com; s=arc-20260327;
 b=Oga+YQlir9VF3qD4zED9CZVYR8yW8F5GXLZ7RoLe36ci3GvagQA7imVxSiO/msRlT9
 Xisi6U0xroXPFzWtGygHrU58U2is72ZkQlhuFrxQyXM/QucuLT4/gUwWGlDVifXzKhtL
 nBHPYpwVYeBHTPQqx9OKLU4h/lGNcsZOpV/GUCQKJBcnCmYO7f5ZIsmYUQJCiOYOhhUV
 HWhwq7KRhhZujRdOfgnfNHklFQZjzhq4sQLrAHLDrVRaVEbRAwbeVX9l3J2mtg9HS3KK
 DTcDlcYHwLbPsN7J9b2lHYr/7duP/fhQSRqXh5E4n9Imy9joV89jPE6y5kn9ySacjGzd
 ouSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NxH6oyYY+k5lJ15VPzhTEZOvl9bnMRPFJEcRFyU1beE=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=rHxwVN9B+uGrtaefz3wTnY3hY2EX2pEh6e11nhNsGe2hxs0HRxwUTFekRZ7F7cM+HL
 DeXMqMmAv70cxORDHLSlnm/FgrnkbkskyvaUl1ti+xHQti36jFSKhkcoTdnWdzwAz5Oa
 LXQkyuqF64Mg1VpDFy43ItrXpZqbwwLu5IvGGQ4IHGnqwjN/r4MzM847NxJ3gRyD2SBL
 In68xh1bizfwghAfN3iFHEwEhJ9V7BmOr/g9Fkr0H35sVfK1Q4zlJAlre8MeRVCAiQ72
 S4+n6BcvQPTvr+qDwtQzCKJit36Fydts2lY4dTovUwL2JsboMhreOEifeWdZDVJhVVcA
 6dww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786980799; x=1787585599; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NxH6oyYY+k5lJ15VPzhTEZOvl9bnMRPFJEcRFyU1beE=;
 b=hGuFA3ISU7lbhIF329rflqHeSyPJt0Jx2xeSXFSHPZDCfYCGMQw+SQTNnyrtc8BaF/
 sAiC8Exa5V0YcvpwnmHZ+JBqqjLHHY+sFaSHpbOff+opjY9s7XjzR9v6AObjszoFqbLf
 Nin5jfVlURuFXU0ihMEZBEZipbHeUciVwRSqzLyKgDiBPW8wuRO7C1cl72bvP9stEjMz
 mH5q7+VkTTy10FQFX5InFlR5diOuynOgPogppZHOTKzs8k7Zw+Nxf3Jr+KH0t7VboVag
 eI2l/kBdt8s4LxA/XcNDx7drIn31pGMVcPg+vHUxV99211a0I4vK5/fK7h0FRq1H9FlK
 SLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980799; x=1787585599;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NxH6oyYY+k5lJ15VPzhTEZOvl9bnMRPFJEcRFyU1beE=;
 b=HqLL9i0yl/mlrwoRHJZXaXt6Cnf9jec64G8y+RG0SMYtuoA2jhED24wHdBqccUzoin
 VGGlOGVBil/0vPriAJw9jJ6mXL06ZsqUu0gulMaIbnuksI6ptzGGEzNQt6pofz1qPvQK
 IOK0lC/WTJUc835hHKV6FgYmkQ7w9XRulheepccEP1GvVvVwGiZ9WQxthT2If8Jssg0G
 TJBfjuxahzGXoXleO4gIVtz0T/zO+bURyKc2f0eBI1Z7F9dppK9JX5YEZnIfJvNCs1I0
 BNHCR1rva1byVTf4cph7zIatKr+KC2RdVS7kynfCdQP4qJ9HB5T8dQyHF52UynR3kC7F
 18aQ==
X-Gm-Message-State: AOJu0YwsBgP1YVVHMFgV49vZhpEsoBYQ00d34lJV08xPmTBV4Kwml9FJ
 ztNCIwUJdbhlTQY/zd5fxE2tkSw6waDbxwHbaDLY1Ln88hGxjkQAl/q95EUthk50D710IsRRirz
 Ll9fZkN35w9Xqj5xpMnBJxdQrGV1xizDN7yeLXWjhEw==
X-Gm-Gg: AR+sD12dIHztjr+pLBk9BYrVCDoRTfe9VzVUTrcUuu+UNcA1WjEeEsfP1y3MPUu7o85
 3bqZ3s+vq27ETwm97sB7WyUCFIju8MjYHReTZgVmhYwhpKGX+d4El6xDhCanNkTApeFi415kELd
 hPughvQShPtRGDETd2paz81ktnuellUkaeCyn5wt7IJXiTKtaTlbYMO5MzgN9wjbp8JzubAHWYA
 hswWvPtLZ/fH3kv7TmtEVpiWJ4Y/EgFM9B63Ei6fPMnl/HakIWSUa6S/Uim2wB6Kpq63vWuXvke
 vr91Uqa/2iHaRDzVNc84ZKctmVmiEZGflGd8B/S+PVirwmjDH5IkcZq3ROY0FJHLOmggF18Zfim
 BTotOwKRDCETIE9d4sDpLo1gj2Sh0Tu9gRxIhcW8=
X-Received: by 2002:a05:690c:ec4:b0:81e:45a6:bd4c with SMTP id
 00721157ae682-8412dfcf07emr6011667b3.14.1786980799125; Mon, 17 Aug 2026
 08:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-5-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-5-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:33:07 +0100
X-Gm-Features: AcwNN1V7_g6oRvjhn1fOm_TzQMiHpKgfB4FTj40y1hIKox7Huo-cc7irdfJvNxI
Message-ID: <CAFEAcA_4jeeExEABxjp8gFYQi_d2T8nDVn5fBUXwCTFtE3p=vw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] hw/misc/iotkit-secctl.c: fix AHB secure read
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Fix AHB secure privilege to read AHB instead of APB.
>
> Fixes: b3717c23e1c0 ("hw/misc/iotkit-secctl: Add handling for PPCs")
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
> v1 -> v2
>         Noticed this bug in the secure read function
> ---
>  hw/misc/iotkit-secctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

As this is a bugfix I've applied it to target-arm.next.

thanks
-- PMM

