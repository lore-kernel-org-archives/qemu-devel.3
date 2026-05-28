Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F446CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb5m-0000Re-Gw; Thu, 28 May 2026 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSb5k-0000Mv-RJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:48:08 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSb5j-0002gm-D2
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:48:08 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7d1bcb92072so79292297b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779976086; cv=none;
 d=google.com; s=arc-20240605;
 b=FSjMYeek6GHuO3yChmEfyK9ZVd4X3WOYf4SvtWrmwt7mKEmSPEqWVbxuogicE9gNpw
 4WOIbNRW9TjULER12ZRbw2Pq0Cw8p4/oKWahAwXKF59F61Difl+4JqllOLjqzYt0C30B
 JSwt3g6sNb/QxsjeCaFynsvy01WGRtAFyvWPMjj4F1/7kWgj1BU4Y7gAUW2O+7g1+5Kb
 lTApe+Y3HQRS/qGhmi5yAziqszX5MQhNDWfWhqb1HXVOIWGKkqSL5xGIvbUO1Bp7IhDi
 PZRoVmRGkafc7J3xNmHKWRlnzjTOUk4MvIq8tg6CmyrrTfmpB4qjwYv62dGGSK/vBgx0
 RBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=25S7mPtTDqCSCc4SGEugjzYunSx5dQSHktsrAHYTncI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=DlAnf4B9IGQnaDzasOYF0c5xqrPFD41gNoTXH54325fHPtmTaO1QqLRLiwM+Yv6jxg
 kq9t/YHbU8GDtENvzkxJKS+VZHg2mWvMhgbQafcDjel4FKfNAQEh6LWfA8aiHnDD1gAL
 HDpHiGhMWXlfKpies6UPMSX7/jvvnPzxMFt/p9yRLG85DhFmHgpJHSL+PlSy8HISyErm
 FKB8HBU19eN84ltuns7vC/vJq4umiz8t0Ux2HYGKhbrIO8lqZL2Bcnt28NPh4ica4tgc
 B/4lxINPvB20UeCOClaTGOTg9FdNqEUrc3mwIsHD4xEmqAH8JdBdRjiR+AA6zZMAU170
 dyYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976086; x=1780580886; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=25S7mPtTDqCSCc4SGEugjzYunSx5dQSHktsrAHYTncI=;
 b=oVHL8uyHkiTv5G9vuQRASPOIiEqnejGgUsTN8/BTfeXJNLMm5uDR0VUmEB19gtf1ZY
 /ia2ns90dVkBNXkuGl9It+u5heZ8vnlxDCrcR2hn1CptXffXDMSQUE0boPu9ITqAjQZv
 Fs3nMhb4xHUzYFbv0QK3njIW5CEUH8mIaYflsdP6FWBOycnCA4xE9sC5r9y8pIv+V5Dt
 wfFPG7sPZnCRfBKf8EtlTWsaQ7eiifbZpnJsFXLe2xddMQzt5Jyz23gEObdooNFRPKZS
 15FGzRJUXSyOey0tOfgB5xxKBPY+601uF5iErcSCw/XyTp3tL9NoC1V+advwDSJkU8DI
 cKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976086; x=1780580886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25S7mPtTDqCSCc4SGEugjzYunSx5dQSHktsrAHYTncI=;
 b=pHL2+JYUVHONKHGMyUDs4uiHX2IUQWJmG2+B5aLAv9pSRmgZJDbHKT28LSb6vaMVve
 frnxpcQMZo8VowlDTV5JulRLFe7CkYpa5SaeNnbgw11CxG07TDqRlhIfvjZYNdnA4H3P
 RepHpqSNRg7tYByIOcswOfLETtlCMs+ZocziUAQp7w07+pqTe45DcL/zsLzuIfK97gsv
 dvh/XPXcVVIYnjUSND6YiaLHpQuq8/8l6Rki+5+LoKGlIBcXLEfTLtyPCSn7mArs4Qqc
 HyA7Vg750cyOeicHJ8aNZS4/unzGvQcr0b2od10t3S2IHIfi6PhH/Eaw1AzRSeH1WlMi
 Z8Ig==
X-Gm-Message-State: AOJu0YzrWAWuZenrA9+dz09zan5Ep5v4QqksGCAL4psVWW+6cexK7wNz
 6UVopfwmKhg2uR1jFhbA1uTN4IMrUNVlrCoKKiMcct9w/v+uOnYCH+AJ0XInpG0T9NgYOqwXumY
 x7LWG3hlh4TcbcO0iGI1pH9lMORPjYoFkJXfvpfQncw==
X-Gm-Gg: Acq92OGzLbyVYz32zf3jxtz3zt+AUdQ4zA1elYeaebiRclbySJlN0F29AK3Lrb1a2kB
 K1c04EX6ieL6H6SnSN3kYos1/1VEJ/6eHSWRZjZmLScGVhfKZA+ndzpiXZcvtwqjd8sStJCqYAh
 geuZmD8HG5N+3u0otiiharwwOXMdJa09o/ITH7GBTQA4O8OFKeYAUlCAJLACTyWp7Ph/G4mScGP
 jS8tWZwEcHhbSDEqFpLMYOnzr2ABkgfkUelA1CGx7oQkrCoHPr8i9QkCaFuEe9XxGlHK9JheWVl
 Bb0dEn7moyTUd/QhxN38mVXo89W+q/AIom9UE07I9S1to3sHcrxZxhqXOFRI4bejeHksLWL85Rf
 SpQgiZIAOqDhu
X-Received: by 2002:a05:690c:7202:b0:7d0:79f:339f with SMTP id
 00721157ae682-7d33a665524mr284688497b3.34.1779976085615; Thu, 28 May 2026
 06:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260518174750.660258-1-richard.henderson@linaro.org>
 <20260518174750.660258-5-richard.henderson@linaro.org>
In-Reply-To: <20260518174750.660258-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 14:47:53 +0100
X-Gm-Features: AVHnY4LnkpkFX-vhsYoBl2Wkixg_Xwuk0eVlTXlL6bTAcU-tiyNvz5LQh3TNCo0
Message-ID: <CAFEAcA8_drG1oxrPyuzJGuduPvThuZMGSzDNWtZDE8ThXL5ugw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] target/arm: Enable FEAT_CMPBR for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 18 May 2026 at 18:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 1 +
>  target/arm/tcg/cpu64.c        | 2 +-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

