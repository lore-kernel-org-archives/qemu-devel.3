Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C60CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNBx-0001tO-3G; Tue, 02 Dec 2025 05:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNBu-0001qT-6R
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:01:02 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQNBs-0003Pr-RI
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:01:01 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-640c857ce02so4770656d50.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764669657; x=1765274457; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mKfnrdubD+3aWGIMw1TQgaMqIjKjNRHhJyadp8VkiZQ=;
 b=E5cKHa3eDU39lRRpL5ba0wGHI22whzpGc+Qr7C2ce5hdHRWdE6RqmVsUl0nX0MbyKx
 IqHT/4qbquaKvheLmjpB6II9l3Z2Nr83DTyk+upRIyOTvbEQTgOgSE6YBC67NdurtPgA
 /NxSzpxp5dOa8orZG3v/3iyZcPtVPtoLs28hkwlzf5kLx8/VLQrA/svVkpHcMzZJQUTU
 PcO6HBpBxiMhvYkvzpCpCP5bP7GOpAUGUTn+XCTiVVsE64v60Oup8uGlcOK4ZJbphD0v
 jlkWiaR8YwGPmFqJazYWLE8nCktIc7cmQBRhiVlPW5JAFXHGPPkGEpqs7kF1uzm86JHd
 qJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764669657; x=1765274457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKfnrdubD+3aWGIMw1TQgaMqIjKjNRHhJyadp8VkiZQ=;
 b=vomauEShPkGb1wyttt4u+zgvJPkQnOwH/b1fGLg9QU1e6qzNV1yo9r2lKMMfKgdA8E
 3mTg08Jl2jqqeK/x6TbeuGOjTVd1fOVVpWC/V4g0ZNymKtMHWIJMD3D7zvBsEgr5IeUE
 FYmToV5dckfpN8tBek7gRnE6ddEHSeAwRSvAg7zVvJ7FplfqYPMmhk996HSfdi1pHcGS
 2lhnVrhyUCzwJVUrR+QiEq6/yLPDEN2RL9SQ0mq0h94ps07xlXepjkrKHSyK55N591Se
 e43axAFmC3vOnZoUTaIuMvclOvzC4BMz+Rf7zeWJGiW8iSSI0x4YlwOYyAeSRnpgyHN0
 4HOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9sBFoFl7ThczNj54N7dOCrvEyb/RBJZ4+UD41rghWjNyvsFhNBUivtbBjFZjnw/ckH6Vgb/MBsdTD@nongnu.org
X-Gm-Message-State: AOJu0Yzfwjj4Ycjvf3Ar8rdcHKAU29hPYiKkwqb1FNndhnS1bk79L+xo
 KF0Z0ORcd1cVRspt3xmmFi/HMQnYf0avN1dop+boNj/VDGuR2qJ8f5HBC30xhRZmJ5JvjjVm/6c
 9RWonJ0zgdGehZWAVILCPvnMUpbIWDLeueuySwXItLA==
X-Gm-Gg: ASbGncuG+4KRDatHfzPJMgDjHDF56neUYRkYTTEOxBJE8ZWW0Ea9jDMLPxpJHYgxUSp
 Vdd2YewOxjQKBIMIN/Wv/TCmETehakLBhZBO+bpCDE5VjjwYs6BIuC/RL1iOThOF5uiSGicYdUi
 nR1y6ZEuLxmVCfcwaM7fztfC8xSMx/keV27O6b1LQwxCdq9VVdr9cL3CmWpvagS/WtM7X8l0xwB
 oSFR2oWHdTrEjwNFeGlFglUtasMDGtOoxRRkV7zdg1QCZ/lEKs+xAOcVaCMhUegm0NJxU/s
X-Google-Smtp-Source: AGHT+IE7C5hUU6dftA4/yPcXA1SwoOCG0n0kIJDwKwJlsRsajlKV7L9jjIHgSIY/kmX77VXclRmXNc26P9Jxm8S+vE8=
X-Received: by 2002:a05:690c:6f10:b0:787:d46e:c567 with SMTP id
 00721157ae682-78a8b5424dfmr380241697b3.59.1764669657385; Tue, 02 Dec 2025
 02:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20251128162306.13701-1-osama.abdelkader@gmail.com>
In-Reply-To: <20251128162306.13701-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 10:00:45 +0000
X-Gm-Features: AWmQ_bnH_1Q8ACUybd_2vCPzKb9cMC8-aX2zV6GMF81QWCP_4wmjE2bq94gaNcA
Message-ID: <CAFEAcA__=TnXrcprp464uw6VNZKLcSBKYP0oj1T2e33Jysk18w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/raspi: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 28 Nov 2025 at 16:23, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> hw/arm/boot.h is included twice
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  hw/arm/raspi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 81d2fa1b67..bc723dd7d6 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -24,7 +24,6 @@
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/arm/boot.h"
>  #include "hw/arm/machines-qom.h"
>  #include "qom/object.h"
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

