Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA5BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv3d-0004qD-K5; Fri, 01 Aug 2025 15:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtWR-0004Iz-5v
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:26:23 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtWP-0003Rw-Gh
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:26:22 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71b5381f21aso18981557b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069180; x=1754673980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WBOluxqtIeAR9iUPJt24C5rVKLitN5/udl8EaWbppB4=;
 b=nnTLzgUoHXW4xTX/R3cuAmPgS4SpDDjf9SL5gX2RY6GsSEHyZNKZZZ2lziTgr4prp8
 jyy3fALd+g16uup+Lkzao3B8YsN93dXMmv3RH90svjdY/DYDEfdITKxPbfScUyFG5r3R
 HlMjxLxP+AdG7xiPVTpRZXXxS7IzpkYvwwxruXuswGRjgEUET49rTuJshjLohl0oXO/B
 Zp/6Ga9EXUl68h159ixXqcu4o69HSCHQTS4q8CxA5DgmfPGN5I0tWmIk4+hF753bT82/
 JbULOKL2wLsTvedkuQB0QSaSMKQeNasMZMKo1HSW4zV9L7NyS+Fp8GaDmkGfTR1vM63n
 ZpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069180; x=1754673980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WBOluxqtIeAR9iUPJt24C5rVKLitN5/udl8EaWbppB4=;
 b=NDjsRmX7PG48OQF27nxTZSVQVNVARvAM2Lk5JxNsAOkDXfZte50e5uwaHFeFymC5O5
 p+/WukD7Yd5UZZL5qGHOw1dXDMsu16VyfnTQP02lH7dVZaBX+LvKLDqBhXdokLZuOHhj
 oFlQ5Ij0m2Oxfp4iyXK52i2/Qo1Ga6ZcdFPoRfAoTFaTaR5P+wvzfMF8uUh9IpjWp4GT
 kcm+LGwqUsZDfHFMv5XWpPEUQQVzRHgHvFNNnxRAYMIszsCgMgs9DgqyTeZ/hv7uEU1q
 XVrCteqp0AYdhhccojTvBKlZ0zBm00X3eOl6YMXzOW0fLOgIzdyWhkRZ5dM2X78/Y/xN
 N8FQ==
X-Gm-Message-State: AOJu0YzLzrA5fpCzrKccr4Ew4Twj23+icSfdx6OIpzcV7Vw2vAOwQ/N9
 4nRizEyAtc8w1sXPB280PXmS1Q5QTsahEmlpl65nTbdonwLcYLiir9cVXrKN4Po1N0AQ25n+qQk
 SNlt4TOMZNNaXGX8fSFvX7BzUsBbozXCaGd3CchB/pA==
X-Gm-Gg: ASbGnctyAW+txcVkAKLb2NeTCo5we2Pps4bPqAwFnkcbjUS4aCA2LQcj6OPNCEEpXPA
 ygmIQP6XsXMsF8yEcYxpda2mjCfLDcgUG1KB32CgOBY5W9I7FwnCDlVwcYqDvysZ9i1uuqBC1P9
 hKGt0FhnltJ4pHnyWXitQTr3NVy39DmGl6MrZYvTfZHEJ1yUmUqFyrWjAF15gCLF8vhgq+xdoGr
 PHZj+n9
X-Google-Smtp-Source: AGHT+IEf27sCWm3VJ0KzUis2fTMOGeimGgUy9zn7hG5yGZeUHbshH0Iu1AkFu+cdAraNwyOwj5rkE7bpFLYgUlRWJs4=
X-Received: by 2002:a05:690c:3109:b0:71a:1607:e487 with SMTP id
 00721157ae682-71b7f84852emr3922927b3.25.1754069179941; Fri, 01 Aug 2025
 10:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-28-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:26:08 +0100
X-Gm-Features: Ac12FXwgH4lAhvfgvf04piDIEIsz5TR1b0E0XWI5EdHesAKm1h8XfaTAi2vcDsc
Message-ID: <CAFEAcA_32++XHF+0LJiMVp70V0wD=d+3O2GzvsX7Rk2_SDnGOQ@mail.gmail.com>
Subject: Re: [PATCH 27/89] linux-user/ppc: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

