Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469CAC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBsT-0003fN-LS; Fri, 24 Jul 2026 05:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBsR-0003eC-C9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:07:31 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBsP-0007vv-WE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:07:31 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-668005ba03cso123875d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784884049; cv=none;
 d=google.com; s=arc-20260327;
 b=osNwex37Rxu1xrvcXnaSN+TsYeXaji3xl3OftkqBY0+bq+oCTwSJ3YnUqfvdMJrWMs
 30FvDlb/Y3fsw3rjTnIHe+/U+zr2HtSYQ4d6l99ZY8GEgrHhyiwP76WgDx8QE2ifU5C5
 3qt3pp9YNuT2GYRr9D7mF+0aM+nLE1zAS3/zd0i6At2PkQL51NoGhUN3oH0PYtkXRUjp
 fgziJiPI/izpbXf/usHPqjmsYqtqc7zhtvQ7JYQ9mIroFg/lvT2qVq4JrKCGeU8LJrAT
 20JQ6QnudgypgsnQbxvhuZ2cV6eEMewWqj60CYBcvK6J7zv84sQOIy1yxDDKlbasIOSA
 JbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LauGjjERVGP66mSGFWM9+Sn5NLza1Y16yjeJN83goe0=;
 fh=ns1eua24zC30J2klOKMkH/VZ1UXy0fV6hkSq8hW1g9k=;
 b=QUeBIbjEx37Jjv9ysLvHEwzCzucgHJPDDscC1ez+VFf3tirWkMR3oZbqf5hAufxwc1
 kvua45wasN0ERdsbrTvNdIM2u/XXsfmQ35yyLxpskhjZTThhxxHvHSgzSNXDdhDgp6as
 rn/2GH0evlwfG3O5fGBkDMR+sBw42ppSS53eI06CFsTOCnKtVfe3d3tZU+QjZhldUneg
 3czIApVd5YC5BeXhZcYudgxJE22x5BsF/YuWc0Lw7eE7jWovGN/0NPJHRLnL2FzC6pAp
 8bpFs/10j67IVB4b/5vYVyRxC3Zsu96Vp7YFotZb49BYgF7MRAKpLkFJUSfCAnUeU4OU
 KIpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784884048; x=1785488848; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LauGjjERVGP66mSGFWM9+Sn5NLza1Y16yjeJN83goe0=;
 b=orT8QgeDLfS13qfTiDXMIVDUwljo2nQV+ghTgmeevdY6CltNdpYjM4YuyhrJ2JU8pf
 mH/JWXu1KU9SZF0QBF7U9tSsK8PiAUmD+wA4iFxRFqJcd4nP985v3x21j/3Fx7ADHjRw
 9M0fNGFpophW1lVxw+9YV6qClbzEjvL8NwvtjLNyjblo+Z0lefgdYSIOkWTOt6aGu7kB
 r53WD+YXq+Ym4TaD+tmp1HoLIThCPaKpnN6PPV1S2/CYtJzcILPtHwVwvZB53kdhwnXD
 QoTroZh8yGqpGEv7hrZvIKKKmlkjTVqEdrprNSKZ0xG2plGANUvtm/ldX3dXtfVkVN3T
 RqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784884048; x=1785488848;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LauGjjERVGP66mSGFWM9+Sn5NLza1Y16yjeJN83goe0=;
 b=po+j3YhwRf4CMmC2LfRnFy4sywGd4YBATHcV8OPMvd2++nvRu2ZFxKWV2UF4pSv2hc
 IttB/aJtyVuM+Uk1zxVxYzZKwDYS6Ak4AruI/UY6+GvKqYLxO5H29U0dCf/bxfLxEODI
 1wLapggWgk0/I18+pgB5/RonXNhPlPHjVOdyqYQhgFfWy28ytobGjOJMkePOzuGMgb23
 LnpTx4Yt5bWUDebWEZSvq75tT7wGY09RCo9G5ru5COIZwzTUPOv4dQM8fngAhefFEi68
 b+RpZsIJj/9joJHulYdTgvRtX8l9mkxv47/CfbD33SvOh2Pc3Ho9FxHhNFYhVJ4D+/iv
 1MnA==
X-Gm-Message-State: AOJu0YyWk6RGeph+uTy8Bj4lQzuy66qnrsiycjX//wTlF3Jk6gLdVfkd
 /ce7WEw7vKqAYPQrgkRh4W9TGZ+ETxT2MkPl36L31Pj+drVqtpofKG4PJkSgXDciPFruuTEWoMF
 fFYfs2nIE/C+RM8X/bJb3j2/KDKBZY/eyekTfkIxqFg==
X-Gm-Gg: AR+sD106AfRghkflwZSGJ9Ltkpjs0AoeCor1Z6Zmrpa9Q/U8FmgFOtQGijy4x8rYrWw
 GDB8GMHgUBG6WKrtlRO5MptfiZnjULe7P1VJLps4zpzVC7FE5JmiXHnJZSZh0CzmCw9Hj63krUe
 58Cmt+bin+XjAn1zMo2M3AaXFSwOA+lxJyp84a8IrC+VVL2D4FcTqfj11oRVyypfl+qzvDl56JA
 kocgrTbUWfxCfQF72MPRscxtq8XKBkzlw9D7ekGpTjpEV/TfHkrMK84cSnTc+Sk0UElMFMY6P54
 sCT1dGd0BU1QQZHYVgoAXr5ezeH4tWBvcWsra1pGcfUIVQ==
X-Received: by 2002:a05:690e:1343:b0:668:a57:2b0f with SMTP id
 956f58d0204a3-668a4d0a1c7mr1772200d50.45.1784884048573; Fri, 24 Jul 2026
 02:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-4-shentey@gmail.com>
In-Reply-To: <20260723070059.6332-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 10:07:16 +0100
X-Gm-Features: AUfX_mzkt9RqUaqW_FJqiWy5A4eCLGrbZlTnR38pLSe2zu3bcOYndffxmc1LA4U
Message-ID: <CAFEAcA9r2rYg0+FochoxMNeOtECPnMMaRCGq-imb6JDmGR4x=g@mail.gmail.com>
Subject: Re: [PATCH 3/9] hw/net/can/flexcan: Fix out-of-bounds access in
 flexcan_mx_rx()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 23 Jul 2026 at 08:01, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Require `last_not_free_to_receive_mbid >= 0` before indexing `mbs[]`.
> This prevents a possible `-1` array index and fixes Coverity CID
> 1662790.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/net/can/flexcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
> index 3a97edf7a4..dd92a38337 100644
> --- a/hw/net/can/flexcan.c
> +++ b/hw/net/can/flexcan.c
> @@ -1075,7 +1075,7 @@ static enum FlexcanRx flexcan_mb_rx(FlexcanState *s, const qemu_can_frame *buf)
>          }
>      }
>
> -    if (last_not_free_to_receive_mbid >= -1) {
> +    if (last_not_free_to_receive_mbid >= 0) {
>          if (last_not_free_to_receive_locked) {
>              /*
>               * copy to temporary mailbox (SMB)
> --
> 2.55.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

