Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5FBC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woI5y-0007Oy-9D; Mon, 27 Jul 2026 05:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woI5v-0007OS-VJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:58:00 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woI5u-0005hM-6t
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:57:59 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66804667af2so1771821d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785146276; cv=none;
 d=google.com; s=arc-20260327;
 b=Mte7Xf4+FshJTA/XdRO+LLzLaGfwubrK4MU4x50FBkWfKXypAf5tYFtUhXvBJsA1jg
 58b9cyG/2Zh2LreWyoXYZa56N8bK5zI49Uqu4LtEOkI3ZktjsW5sy+StlD0V0FLs/Fxm
 IeBlQWeLY0U3UkBEVpHypPWh4ULgsGndUm7zc/oFCLYtCYWQf7QO1zzTJ8x48JAJp1u9
 s6PDLv7zzKatGEjTPyKmPIUiHm2+QpK1YeIR2yk8oAzVk8F0B5pvjSXMdp86CWCe+4Pu
 hSrhVdar/mc1iRvvQMCGeWBYsBh23rbUnkVVR5aJncFv6t8+mYLJ0tNzdvP16nugyE46
 /uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rADByToRfCJRBNorNgUKQmQtIhFvp2y25lBhfZHPZmw=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=Ju9wpDjIz0jEJ5T06kCBzoAocUr1y7eT+jy/SWtPYkOavLHshu3BVIAUuOT0IqP6ur
 YFVtufzsHSKzC4pytvDmtHV+J3DtK/OslN791hLs9Z6l/0OG+C5GbrtYjJFsqqAT74Py
 ub1uPb634kifB5w5LSVNjrqY5VjV5mi5qpg3t70tr1dVINyRAWp1qbPbUvo76JXxVD8+
 o6Dhc1obDZC0iXxAiCjea9ubDgq+//ewSWyZs3jSqoikUIK7G+mGccqhrGPKmMMdkuKU
 QiJXC6jo3RwRis1NW4QU8DcLMlNNnNW5TQfP3mTH6mw+EvwAi7/xH8lu4/pUPOvpys4F
 cHfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785146276; x=1785751076; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rADByToRfCJRBNorNgUKQmQtIhFvp2y25lBhfZHPZmw=;
 b=WXdUvNYsj40ApWm6FcLtAs5gLKX7E8KP4z16NMVUQviGTijYkNE6iCkxmtrdUZUAZ8
 kHChwrAFilObI3PsrKp/RIxfMAexVZ7XIM2P2tBqVFKeSLosfHMECvDIZpbCHF6Jhtyl
 bT6xv7Au6VXHfJHlS7OonNKKYfY4m5DqucWPvFewSS5TtGcOHic5JBz+IKsXE953KuPn
 K2+xQTBFaqtxp6zeXk/sdtO74JK6ySYADp3Mh75XsA0JkD9nipgQVtdqi29TYaCA23Xd
 Hb8xKP5C839x0GW+dtT6lbOqCLqr19MqvBVI/LOwDYEE5LjA6M9se65Q+C6MZ3SqvqwV
 8KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146276; x=1785751076;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rADByToRfCJRBNorNgUKQmQtIhFvp2y25lBhfZHPZmw=;
 b=Ri4Pyc39pA+PT98zZqMNcYJaSARc02QmedH5K7fhNuRCicA6DYZrZmXNbT9vSRsPmF
 NPz98BeBY61AQOGsCLUYrMshtF3mu+dsZ/zqb+PX7rSE0JqWm8HP3DcGZymUnxXvEvt6
 v2H1itA9XqhI8DBm/7lqNpZHCRDoVPIerkSxykgkacNFkhXVGXMZhlRY2djUAPr5BYyx
 LrSq6xJX+OEAH/b7pb6DO3vij1psxyUqj+kVHVyxYnk7ja5c5snIn3CFnakQ12QGT9W9
 +V1/2ME3VbPbyqd6M3JFQfzra1Hkx4iO+qx+Un+X1mSNPu7BSKTR4FOzoCQuQ24SeSZR
 GOJw==
X-Gm-Message-State: AOJu0YxkTd/swWHqCvB3oJS1axB818M1nXsZWkHGxDVPTQjCKfT/hySC
 QCOUDwOPDyQj+dZic0lk0n8if9buQeaNSuPl6dpNdR4yfRuw3YhBxo4ZApqzG354gTGWKZs+sQK
 s+ThKQ/CDqoRlYpvXp6O8IGSZxeAMi7y6ndSo82rdfg==
X-Gm-Gg: AR+sD11MyABGKQ3/ZVsU0jsNZYYxKFlLhQKHud+kmG9EjnWSNENi54y5zjv7Smys9nb
 zC4Th/CH06CXqGEJ3LgJvr78kbSQFaChJQwVaIeUSeKjrm6NsNO1OZsVpCcxGPcTgPXTbRpEneF
 e/q8JpDz7qd+SwoYLr3FZMVfEVTYkcBGp9tf7F1mphiXSRYrWoPNpZVEE5ueCyQF06ra9puTLFz
 0EPEaSseOJpQ6tWtAwHXE8sTk+s3KyGpmPUsFKO6NFOeY6Tut/9SkqIzaNnW2q1wRm/mgdRmzDy
 aeUNi25uSwahnMNFkrvBhlsPlFLCsUBasTrvTULpH//bQd+I2LDuCxwZ
X-Received: by 2002:a05:690e:4383:b0:667:b234:d5f4 with SMTP id
 956f58d0204a3-668c7ab5949mr1078440d50.66.1785146275903; Mon, 27 Jul 2026
 02:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260724160943.52509-1-simonxhy0404@gmail.com>
In-Reply-To: <20260724160943.52509-1-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:57:44 +0100
X-Gm-Features: AUfX_mxGDRTQrSvi2zX91N-yKkiOp_k2P_0k-CJfwu7c8vXh2A3KTuowsbgDoa8
Message-ID: <CAFEAcA-SwN3dE1vrmAP+rdEs0U815D4xz93MdC4JUBm-GaxouQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/misc/mps2-scc.c: fix scc_partno and cfg7 write
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 24 Jul 2026 at 17:09, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Split commit from v1 into 2 as they are unrelated.
>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
>
> Simon Xu (2):
>   hw/misc/mps2-scc.c: fix cfg7 write
>   hw/misc/mps2-scc.c: fix scc_partno field width
>
>  hw/misc/mps2-scc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

