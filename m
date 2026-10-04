Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOtL-0001jl-Sd; Sun, 04 Oct 2026 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOtD-0001hS-NG
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:41 -0400
Received: from mail-yx2-x2b.google.com ([2607:f8b0:4864:41::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOtC-0001GL-5T
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:16:39 -0400
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8ac8e048735so4923037b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130597; cv=none;
 d=google.com; s=arc-20260327;
 b=EZw8i2m3rux5rDVeD9l7WyZn1daD7fBncr1jxam+BKFywepAfq8qC9RHcSlP5DNDSs
 GqWiu2yrT6ugR1r1qxYcvcaxm9UpXaQJIsQ+jxbUrXjXVj+6sDs9vq8BCCUBNTI1Y4Cm
 d2UET5cq0bVMb0YIDxdOlaMMJESpL+/8X6aXXIm3PtdhPsO7tYmo/FJlsASFIxCSYjYx
 2skWdNqxijIX6l/FeLnRMVTML91l/mGEbwreh7BZ9I0VG76F5CoSrBiYTf3g9kqi3WRn
 SC4Dkjyva0/ko09SmNfn89bLs069ld7nYA749tChEoOMfynIsx/fOh6KODlOgh1JyIYX
 h9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7pTRaYFCGoLLVjBYPjkax3oP+NOXk5DiyxUnr3yvE6Y=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=aAhgQqBkKHDEoEauIIAiTqcg0nNMq7NyGho6pjAU/v8J6VquagW4Dor+WzjlyWtmZY
 vFE+uBbF1SzK3Nc2O+6RiKWIuTajm3myiIRHaze3StWTs3DIFVpa6Q2JIMBHak5F7/8f
 4ZJbtLcUSe9c8YaOH9O9FAm83ClXRipwI1/wOUbHOt7f1RI3BiPGPgx2NTxP/qRPC8S4
 aAxJYCKHyK/KWZbUFWuvpRzp2iskedHXQWf/wTUa5s3vMgK5WwW/BQm3Mg1CEnIsTXFf
 YoiWuVhUbxIJ0KM47HpG0Ih1IgT2d+FkrCZ2dUUR49vWL6+Sjp8vmiqicqZavnS5jG0l
 SG/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130597; x=1791735397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7pTRaYFCGoLLVjBYPjkax3oP+NOXk5DiyxUnr3yvE6Y=;
 b=Tu3Yd5NNAmIf1bXk29y6AUBrFQA3qqhQYfjWzulmnhnroVo9/RzkHwAp9K/ASugQIc
 TByqDlxe30svKlnjKQHd0U732wB0od+ntM6dhTu4Tl/svSs1u+p56BkeeAaPHjE4KJrf
 Q7rGgaclTa61v2+5lwJ3+/B7e+sTHuhIIp6lus4Y45QSoJYTaYYVRqyBujPkTrL1UtzL
 HtQVpko5+cFGMYEyJ0sk4cCCGesCMsmwOQzpMPHHWSahILn+qMtmq11hq+bzaosYibIw
 pgq+6+cxQ4mDO3xDmZdPKRzLGtXpL7BbbJJ8/3wNQQSK1vZU1KKF7M2Ypn1h+t+wnJKp
 R5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130597; x=1791735397;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7pTRaYFCGoLLVjBYPjkax3oP+NOXk5DiyxUnr3yvE6Y=;
 b=cNHTQh0dntvF6qio5rSRbBG3HTpt/QpNeGoFbMaTz1Lau9l79qeDsOTmPD4ZZeZQhj
 aCnGk5iT/p+PLuEq4doSKv/HEJgiC+d5xwWohmlUCl3H1urqWnRxu+UyP/e0JmEJ7Sic
 vQmrjeS2SXLgzExsQxYkxb75BQDIivXg6t9+pSoCa6DeLfEPZdprLvaef1SbykUcLY6s
 kXYze82AGSx+55NhWexbXtgpcOmmUL2ZPegZjLHZ6babn1+NAD8ZJUqlyIgTU7EGleLu
 vACp7a3SzW4JWesKFRJmptXPghFwHECMQHSPIObTh+DS31wKIvivsZwCfYSzEJZK/lFH
 /s/A==
X-Gm-Message-State: AFq9FYIpNGu0h5p82ciZjSRUjo1o32vLt9KmtSoMlL9jqakXF6fHgdpp
 bCnoqwn9mtMcsYTeEr3YBstLz8nBKU6r9erYHLztNg45njVfibU2VetRkGfU+NE7KE04p5sZIn1
 lkqVF8PUTmaE14asCqP5F5yn6gDqPvn4=
X-Gm-Gg: AYBFou0neVvrJrqyGe7A4frcbikE4gVFZVs+2/CwOGDkSchBxccGfIBAthCfs5UCDKj
 e0ObX+aYJpSi/P4D9mLfj082OGO73PF1Tk69KmWepltPe+aELlharuvvUA5uXFpwrS1/WjBEAz6
 RFLT8wRHrNfdoDRAM40d6LYceWKWKPQNPJVbbojiN7ihLCb2PuLpjCRODBEPVEuq1Ek6k74WAiB
 3DGg4jtDJwIdznZDSdlphcmMpGqBf2Izd7aCxvZp8w0nwYmqb3jWWAAH7gB3hO0D3ABEArAVaVo
 fbEehcvC/AxrwSSFMrMA+8EVNkjIwIpppPHugZQBoo3XFMb0OZnPXJUXN10QWybJj3Cz3LVFd5e
 iRMXgkaxxcXTAv41SU5NgiOVVMwc=
X-Received: by 2002:a05:690c:c4f1:b0:8a1:eaa2:36d7 with SMTP id
 00721157ae682-8ae392af4aamr28246977b3.18.1791130597006; Sun, 04 Oct 2026
 09:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-16-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-16-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:16:23 +0800
X-Gm-Features: AclHuK8G93NgDcIqaZBrUCs4Wbt_SNeLVwmkNqXxsLrT1l5Iv6GhyteW0kGpn1Y
Message-ID: <CAEUhbmX7Fz2GQAAwK1buoiyw6dRyqwNqL1S7m5KWZpxROhTsXg@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:33=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx7.h | 5 ++---
>  hw/arm/fsl-imx7.c         | 5 +----
>  hw/arm/mcimx7d-sabre.c    | 2 +-
>  3 files changed, 4 insertions(+), 8 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

