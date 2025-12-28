Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF02E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 17:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZuBO-00055J-Ih; Sun, 28 Dec 2025 12:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuB9-00053r-Kq
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:03:43 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuB7-0008DV-GB
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:03:38 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-787eb2d8663so106432477b3.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766941416; x=1767546216; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9+YsXflcSjwD3SKZXI7ejyNJK9FtblWoLLFVOe8TsYc=;
 b=cY5mIsqorwTlkRFVm88iK8rt8iXmT7jSQhRihSCZmB4tK+6tsA4A+dVlwHDP7urN5N
 Qev7CSqAM/uy7NBy64hK7FQhr9W9VO8dUjL7ZtPVgSedk3GGf+D1Hp+GuHkYy3ajfi4s
 WLuJEpfAKSHzM12T3EHY7LwxX1ltkyXN1x/SjJ/iyHViyCuhiiJL9dlWriLN/VLANVEg
 FSR/co0FaJNZFvVOrA2v9/8XkrcnmxfY4X4S79W9+bvRe9g9VvMdEee8Mv8R87IzHlzh
 q+seanv1nZMKx1HxZkauP9g+cOsDGeicwdcMGh6huNgDCIs6l/xkVRAksyLq8eoJQiW7
 WanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766941416; x=1767546216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+YsXflcSjwD3SKZXI7ejyNJK9FtblWoLLFVOe8TsYc=;
 b=p/bn/Ig+4dY3vlfWgVKGpWoJhu6JXCofRIJlDbRalJZ1jPljojifZ54pJ40A+SV6Aw
 rAJI2ujf8qZY0WTeXpsns1CGoWQQ7hk4ZFDDCgFNOn191uVEKU/QYSwakcRCE3M9+BG4
 yQZL3fvKIUqsIWoXNSC+cRgjTFtVND0T4qKpG4xncEYHh49Wkwtxr4Ql1I2C7eWGeMH6
 HwfzO6r5BR3BmReNlrCKQnznI8TtajeiIgNE2nBByR3JqaT56un/zD8ZcqiLxt/PQot7
 jSsYlU+vABAZgUzNk1bZESsrax/AklBA5ezi7+mJG41LXSMmyOjK+gEafGHEiymHRgjF
 GVhQ==
X-Gm-Message-State: AOJu0Yy0sMeN0zpvIrGWoGzCLOFai7/yeCykTR2e4WZDgb1G7T5lnslB
 RjL964HL8H0netqIspLsxwzYmXBk/Uma0MlNSuid58KkxsQrP4o9l2SPMHwIary1E6z8EO/hG/1
 GAscpimvc2mPoqpZNXw4n+aW8Zlmf13v4X4Owz9beUA==
X-Gm-Gg: AY/fxX6mPb/FGZ9n4xFbnB+jzQP3FX+g8XWtoMRvSmYc59IzTOyUa/uEIdsbb/7/Wwd
 HLEID98StgRVFdBvZGi7pSg8gJ1qbhamKjdsCcUzKEgp1z88Kx8xUPI25NDaC6PSqKvbMxhVgzz
 SzIOSglc5HACdFMBq5f7sPPkXWwkbjseFuuGc6EJMdqYamBkC4QWIp9WrcxghuGD5YaaD1hceyh
 t26IiQ55kTJUCGlwxr+yDaMAwep53SZhV2CtAf10CeAIJ0mvANG3athu95tgEndJEZh/DfA776/
 MtxCK/Ya1Y07vH/Vf6XhZAE=
X-Google-Smtp-Source: AGHT+IGUTOK9B7a+/UkumJvyu1R55econhf51fmn+jqSCBWb20zEcAp/qgpL18ip/tcWCKF/qheMdK4k6iXtR/VBaPI=
X-Received: by 2002:a05:690c:398:b0:787:d09e:88fa with SMTP id
 00721157ae682-78fa5b1669fmr262930207b3.21.1766941415611; Sun, 28 Dec 2025
 09:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20251221062734.100559-1-AlanoSong@163.com>
In-Reply-To: <20251221062734.100559-1-AlanoSong@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Dec 2025 17:03:24 +0000
X-Gm-Features: AQt7F2qaqX7Zr1kiFSwoey8H5mSVjDMJ3cNFVwTAxTlteDYxSoFDeFGloUT8tZk
Message-ID: <CAFEAcA8Sx4Sq24ntjWZWORF+eGyXOPhiHVm=K1cnLHd8E7TNPw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/allwinner: Add missing state data
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, cminyard@mvista.com, strahinjapjankovic@gmail.com
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

On Sun, 21 Dec 2025 at 06:27, <AlanoSong@163.com> wrote:
>
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>  hw/i2c/allwinner-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
> index fe887e1c6a..728b7e622f 100644
> --- a/hw/i2c/allwinner-i2c.c
> +++ b/hw/i2c/allwinner-i2c.c
> @@ -419,10 +419,12 @@ static const VMStateDescription allwinner_i2c_vmstate = {
>          VMSTATE_UINT8(xaddr, AWI2CState),
>          VMSTATE_UINT8(data, AWI2CState),
>          VMSTATE_UINT8(cntr, AWI2CState),
> +        VMSTATE_UINT8(stat, AWI2CState),
>          VMSTATE_UINT8(ccr, AWI2CState),
>          VMSTATE_UINT8(srst, AWI2CState),
>          VMSTATE_UINT8(efr, AWI2CState),
>          VMSTATE_UINT8(lcr, AWI2CState),
> +        VMSTATE_BOOL(irq_clear_inverted, AWI2CState),
>          VMSTATE_END_OF_LIST()
>      }

It isn't valid to add new vmstate fields without changing the
vmstate version number, because this breaks migration compatibility.

For a board like the allwinner ones where we don't need to retain
migration compatibility across versions, it is good enough to
increase the version and minimum-version number when making the
change. You won't be able to load/restore the state data across
the change, but it will fail with a reasonable error message.

The commit message should note the compatibility break and which
machine types it applies to.

Speaking of commit messages, it would also be useful here to say:
 * what is the (user-visible) problem this is fixing
 * which commit the problem was introduced in
 * whether it is worth back-porting this to stable releases

thanks
-- PMM

