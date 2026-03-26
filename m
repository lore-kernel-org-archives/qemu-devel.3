Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0079F10A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nOd-0005xo-FH; Thu, 26 Mar 2026 12:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nOb-0005xA-5g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:17:21 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nOZ-00071e-S8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:17:20 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79a8e873ca1so28141727b3.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774541838; cv=none;
 d=google.com; s=arc-20240605;
 b=FWKGYn5gKxzrL9ysbc1Avx8i6k6Odbu4Pqkbwzg6JoVicvO4/XawIvRv0xi7hnzMSZ
 milN10OlNuSCvObP01oYLqpteIv8QVnGznCqfDqFGS6jhn7tirnDzS82t8Agu/fZmBIa
 QYADb0UZOERlt5PmyWAEMHtKQV5oHLkQ5/ngL4WqakW3wZLx7NEjfs6Vfu2iii4uggvO
 3rFboUTCest/pRVANnhTUDFY2tcKX0qPT+OsBz7tYdSdRYUVjSl5tGGbtQwowe4vFLLy
 NGk56C7aWGgVSPyJ7xXuEkB9sTkCil1OoxDeIwyUNegQ7+c7H8HVIIH5SpKbWVIi8tCT
 oweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3tMhUhfnl/WH/2AfjvQKV7wgpthehiretJp4lub2C1Q=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=MZfcC+oWmeIG2iAmEp4itdpJrZxCJdoQestFStwXHc2ThZ36GAb445svwFolr8Nlp4
 f5lFaoNMlR4ETQTjChjfzQoRw7DNjFXM7eugNcCA6GGvDdJ0T28Fa/WLElSriDLkCkfV
 oMhp4eQ71zacSuFeGy63asV/amTUG7zih7zXUrpwxNl4wfNc0tD8D32+umVrrL1W+9AE
 q+bLaxCKDjB/EEzkhObvKxhx9HKmI+jwJykhgSwArrGQTPPuGrQqd6K3tDlsRDLiMzr9
 bm+oAi0QvV6PCU4MCTFcbCH81wu8WMbIvBk3mU0AKqe4ASX/2uXvDvuB2tdHn5M9v2vf
 FsUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774541838; x=1775146638; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3tMhUhfnl/WH/2AfjvQKV7wgpthehiretJp4lub2C1Q=;
 b=HilD2NQpDheQW1GRFBQmNiXhaS13CUzpe3qU4/t1iWovHTuosrXg3BIuGqB7SA2F3P
 xGo3AWiyNmyKRob8pZIbYM/L5Y6cJ4nk0rT9vgNzDI4g5uuvMN9XCqT0GkN/lbRYcokT
 BGPnwWh+xxK/F552OySQxZYRIZ3MD5ADizKBAF4aDKac5tk7eieHPtOBX8sH9Ys+H10o
 N/wZCG1mwj5VvHSLOFbggCPYplSjuZHOQASwAX16gP78uZAO64naeRUJsEnEp22ddzqT
 kZo/AyxgFrk8UvUDGQR3CfWxWbf4XLvbyGDVPMl0zvxw4+PnK05QO+9oYAHosQMQlk7R
 QJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774541838; x=1775146638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tMhUhfnl/WH/2AfjvQKV7wgpthehiretJp4lub2C1Q=;
 b=qwsCxT+izENc6ApOYmjAlzBqo36dric+JA8cX7i8CFxtsgBnyjJLLugfUOkPuTFeAX
 5mR+D3rFJaKdxPMUDj8xFeVgfJkSFHbDg8pLhhGvgbvu6FVNXq9fqdE2sHqvVdHBhpzQ
 AXd2vgmJ66k85Z0Gi7UBSBEVlSNZIuld9wKpLwmOJTff/eju+KUdhpGRWAyjwj/dgCGX
 uBQrczF7UL79gcW/mJmPIqsrlZWFtgHzRyvQLCP4Jfv3zWps40w4X6Ve67QdHS1rszHv
 /sgZDewJ/Zexis2XtW6/xf4s/GBlXWaMAT6lTDlkHhB3Yxhtdn2c0ZqD/X9AsG/vI83R
 cYhg==
X-Gm-Message-State: AOJu0Yy9frHqxA+l+F2joX3/rC/AblMaR3ObX7gOJBScMjuViys5saX5
 L22UPzh3EePeb1NW1o8o1S79I9zWFiJa/+EQqEktd2vq7ZrR3LFDHpfNDNkvCSYee0INUajex2J
 enBCOYwlryyE+YuVaVjJAVS/i/rW6ZXxszQ8TOjXFww==
X-Gm-Gg: ATEYQzwpX9DkH7lSBvz0u7XGZJ4rGkf5l0UPuvNLIbHpQoLKGmTjyj+f871RifeYxYL
 oOEEGQRsOkVnsif6WoZEqSTUaHLupQWjsecvrXfCBF4Dtgm4NMaw1Ce9S0C321UhpZFdH5Vd2Zv
 cClMlqd05u8cVN3VAa8uVS4vzsDFhD6L8nWCTA/jGk50jvHctMKxhKLtfJd2v0EFOZqilSR2SVh
 pCiMR7PqJyM4revGiLfgGNBOtNSJ6ST8Xcd6gIedDr46H8jFrZOiEljMvJdF3W/7Bo9rHpEQ6sF
 GLpawSGi6+mkkkuVunIFhjJIC91aLFULlcSE0earP6HWaWbO+E8+aoQeF9RnnTcSBXQ=
X-Received: by 2002:a05:690e:bc4:b0:64e:70de:b09f with SMTP id
 956f58d0204a3-64fee2eb82fmr1974772d50.33.1774541837471; Thu, 26 Mar 2026
 09:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-6-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-6-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:17:05 +0000
X-Gm-Features: AQROBzBP4UCHLG-ZseY30-UsT38_hZEn9FaGcZcxZ8U_FlBCDWYBwmrKeaD6x1k
Message-ID: <CAFEAcA8+qpP=TfSY3oa_2jpH2vD+ot7UxSnVWJCqUVshOCZbNA@mail.gmail.com>
Subject: Re: [PATCH 5/7] Remove unused sys/param.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  util/path.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/util/path.c b/util/path.c
> index 72a255890e..e1565894d2 100644
> --- a/util/path.c
> +++ b/util/path.c
> @@ -4,7 +4,6 @@
>     The assumption is that this area does not change.
>  */
>  #include "qemu/osdep.h"
> -#include <sys/param.h>
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
>  #include "qemu/thread.h"

We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
basically completely rewrote the path handling); I think that
was likely why we wanted param.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

