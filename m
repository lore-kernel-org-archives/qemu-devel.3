Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C0C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd68x-0000nR-PC; Fri, 26 Jun 2026 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd68Z-0000eL-4V
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:58:28 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd68X-0000hJ-B2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:58:26 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664ae993e4bso97019d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478704; cv=none;
 d=google.com; s=arc-20260327;
 b=JsmetSYm7N4da6Hf/eQa0PTEVdBoYR/bCMAYAZ4hM9M2i8EiiR761hETcM1if7VV20
 KcT4ONzXh4jyBku0j+OAojRmn01wcrBnqzvNqJHCwpUn2dJascGyY1owUvtlbrVbDvg0
 DOsSqiDDiTFFBreqTH408oxZ8xht+c4QNp8FDL8L1khGnulWQqCSBENV6JR1mqYAdaaQ
 I2tvXw5Iu7E1ob3Y/T5LEctrAlBlGR9fT+9eSFNyEPWxjY35dX6K8ic2R1K1fsRmPrWG
 VvzXD3KkpfN2/uswz+EgwArwlNSl/I5j8yZAyOpOnPK6qZU/yeLjTB3jiLTxiTv4acck
 mKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZUFdXqvx45jgjQB0+hREhu4yBJOmSAjKNEzXrEbWSOrQXw7ogSwtvaq8muLaemzRn9
 x09B3nqUu4ZSKIxISKUIjITCtqBqJ5oa33O8Vt5ak625kT2SW4OOsOKpyc35zeA2Os80
 +KaOlYcDpjeeu90AvcfrUAoMEpc7fxY9ji16b5OOwVrhmOqpnsucytdBu+FGaOHdP9sP
 1Hxm3D0halDYjwPPfgCC6mz5GALs92aAvSO7XZ+1eIeQzB8tvu8ySICpwSDmOMzTMcAC
 95i6a1ugwhAkMXhGjNyGlcNyoB4jgYA6adoCCq/d9TCXCdQ4Q/Rq4Qvi0gO1qA62bs+A
 L0xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478704; x=1783083504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=pai82z0qrtwFOrpCwxWyCgcCcn0QkPULp3Ha5+hoIbz3+HMpLYY3v2qMyH/TgbaI8W
 iZQzLIYHTUv4S6f3B7kJIKaNThf4rmU4eokL5Hei+UwDpPsQhGYPwMsNtnYemZnoH3sW
 W+uttUuUxkd7rCSDxnDNsKa5myMBUjLlcaqQ5hh6nu+sxieQ4tRPSEM3vdBGDwVOj7lX
 WQeAR9Rlxw79MZ24cdw41Cyq+N2KkQqBvdS6VCwtaeOMdzE6bo6LYGhWZBeoxdQwUgNf
 qHvHea4fFqhitYXhluC2pbnqcAvwdBRCWcmBF7l5Oi6w91tTX7jcHEj/3gwWyv6US1zt
 Uw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478704; x=1783083504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VwcliHq8xl464nnWTtg3JJJwkYrSrQwNu9NWItGi6w=;
 b=AAEhyHcQZFTAKQ7rRxn2eDQ3kbelIokH94YdkXil066uNRlvPtsJVkA3XBNjqQGX33
 FqzdtqIuhD9Gvn1jsEOuEBXh6t7t4p6C9dTBDNnqegYSUdCZAvapBe53b4W4e+k5JBzR
 rDI1KcGivoVfzvIMxgUKojKzW0NdCwg+akAHsjcYp/hkzVHejA7PqgivrSCL5DNGmONs
 IImyXS9wWkBEM1xP34NuqDkre/x6wRzv43N1BNS4jzH32BvTLQS/fKdNTORyM+6HZE9b
 5kcmZ3pJc0PsDmX2H8fwnTTbZVVKdL/BHOQmTPoXzLGBX2RYL50JpPZBXUH4OmhQRHw+
 aN9w==
X-Gm-Message-State: AOJu0YyF74eb7bCBLs+h5rF0u2GGwJxjpzk5GsmdyqCuAEtFiYwFTLmN
 wNbqOjgQVxqSJVdQN3YSg1rRFSDOPDCkhxbzg/HTWOBS9yC+0jOV39c+MrS1QV0sRh2yIwWGhtX
 57xo9LvKsO860VqdqxGqtgpOOm4fWzfWKkK1Ks7kWSA==
X-Gm-Gg: AfdE7clVGPHL7FtnjU2DroGR2AUnD5uD+pVSdd7vogy4SfUouF7Z9yd/9wdgKd/ILpz
 JlBcGNFIoCaYm/XGtgBLqT0n11kkwvSCTDQKjaN94RMH+wCXhW5eXeII3i5nUAnJk02yi6SuUXB
 Wl045wyuW2kN2aJLxH98AHraaBc/4Esz+N9BjdzX4mxetnbNT0HN7KNQ34SSGS+0u3lXoVEidpd
 Ol/gEunSLu6FIa4DQbApg4M2nwSglh9WugwwABij/Lfp6yXxEqt3ulBrRMQ2FvY7BwbvILc//fK
 w7J7AkEjyhoomNmOYPH0BXg8Z+oCVfIAasMHkdxj9PZyJbBSygxxiKC6
X-Received: by 2002:a05:690e:b41:b0:65e:3d3a:de1f with SMTP id
 956f58d0204a3-6635564cafamr13063010d50.26.1782478703928; Fri, 26 Jun 2026
 05:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-6-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:58:12 +0100
X-Gm-Features: AVVi8CdUu-sLfl1QJSF6_wUFzbAnZ6KEGwb81dgtDCHUXCmOFMcHRgTQiIAY-s4
Message-ID: <CAFEAcA94EZ=KV1baWUH3Q1SGhM0fcXfyB8zU5V6kkr7k3Kd9Jg@mail.gmail.com>
Subject: Re: [PATCH 05/15] target/arm: Implement BFMOP4 (widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

