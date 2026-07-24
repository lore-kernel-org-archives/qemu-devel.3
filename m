Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4162C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBvW-0005Zt-G1; Fri, 24 Jul 2026 05:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBvU-0005Zb-VC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:10:40 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBvT-0008KC-EY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:10:40 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6688dfaed31so129707d50.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784884238; cv=none;
 d=google.com; s=arc-20260327;
 b=UCdXgwfx6ydcr902BSgjf05v0Wc7+6fgqadgqP2ThMnVCrqIrXvmKbqdCJf+0/qIR+
 gkYKTKwa7EzGMhEo+X5HDQhvLaWA21z/87gtxspY7nnMLqnKQ8qBvycXuGzenxjF4idD
 m9MgC/M9oPCU8Qlvswu4noHdGloHIcwWTukpEHsEgY/IK9cBYOYgSyye04qYT3hgBPZN
 PIx3ckIV/yKn0/DCbPn4Jml+IHN5MbxQvJmAfd1X17XxHGXT+77/DzKDFI+L/OL59Xbo
 xieH9j5xfKwWt8nfiUpfnaOrdD00dTdkrDDRyS3HNGHCzjFwla0gw1F4RWtVREXnm5Wk
 RIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=On2O1F3sQ948IDko2/GdnzXiQ0UGA1DV1bcFCmijfUI=;
 fh=R9au+h0lrdXDpR4FIVhVuStk4RhEvWBYySD5jMU6woc=;
 b=AFnTOryvZz0TY7h1gAHQ0yY+JSpxOeG59FCsPs8caF1jdOGHpCs6acv4x4JwqSqw7Q
 WlSrth7oQJcRNcg4EJ5B6kWvno3huI+AMAz2jeaNTxASjZdwphACbw/GL5EVdO2o2xNF
 4+0BbHbzGvJsdJxEERlnaR4wRzr+hJ+ry0NTh2IjCjBxmSWWx3zX+MdW3sdGjY3HhY7A
 FkJhKWaTOyfDrMjC32KwrOEBe1CIbJz2nPvTaNDf3MRsqT38JvOZVA73WidPX0eW+Y0Y
 Qi1fxSjRjuoRZxhVON38WN+VUGhjYfQ9UG0pP1tTA3UivuzYMjyM2dVYU3XN7UeHuaUZ
 sruQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784884238; x=1785489038; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=On2O1F3sQ948IDko2/GdnzXiQ0UGA1DV1bcFCmijfUI=;
 b=Krq/y+C3B9d4V7VRV/qVJywolkTBdWW5sLgDwWXYvwW3OiAcQBLfp9sb+YpbXLbrze
 J/c9ecb/g53vz1xT69a+6kX+0NADzaB/+hHmWS6556S29KsGgY/mdgFPuceWgKh0yQIQ
 +PjTdV/2bppaQbdFJ6ihLOK0jUg0g9xVM1/7utVW6enIjUC0r2m15r7BRuj7Qek6x6E9
 CA9ONWperg018gv/v2KX4DTh3d0jCrQ3Q+mrEfOaEs9qLyiaz4opK2sxQPn9utKuIBdw
 3Q/aItxTc9BpVbEe4+EzNNkpp/BnFKV216yS3UnyvyW6Se/3wTpi9tVTSANmWJdLudhF
 Dbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784884238; x=1785489038;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=On2O1F3sQ948IDko2/GdnzXiQ0UGA1DV1bcFCmijfUI=;
 b=rETI2Vbna55vxHBiimw6jS+h6+Vye0xOT9M16ir0+D0N32fbMhm8+AGxFlFBL/Xv8+
 uMcdf//y+SKUnCHtgDxfK4PKw60unpEVBgbFAJxMOxvpEu569y3mszb8pns3cTUpii86
 MXV9/1rFF9VbtCgESuBVzABf7GtI6QlcSPvN0eazn4TOUmqOYam+PHYFroLqKn34QFgv
 IdHnkJctEm4DnzEyxRhDI3ZaWFk2UxkTJ9Jm/sL8DL41+xbKssl/sp2i+hFKe5SoLkVf
 bhDES3oXHg1z6AzzQNQFLqnfdvL1uEvIGAEg/kmiMrCfcehg0vRXUQFgY1cbOgcQw391
 wbGQ==
X-Gm-Message-State: AOJu0Yy4P9aD87fBoF876vEhzV+aeFjSJCsruxcU0Y3hcQIOpeGcsjuw
 UCm0Dsn3BDynmqXjZ0+jLe+uSYnN4OaiQKwPWHA5fbjtlJxB7ii/Jym8Cyk40+fV1POT+WqlZn1
 C6Db6f519IDKVXJgTNug0UZiZbCNdcNynAMhISeSiFQ==
X-Gm-Gg: AR+sD12P7oCXRoTI5FUbUIE4CaQi8FXAnVtQsuXqYmfmTfbktSOrSzXonWlfLTX8gb6
 85IGE4/d4xoO1qx8SdfOLlXNS5j5IDjH2cARm+ilcBN+O7PCjukBWUhoWWQXON754xaSkgJXP2w
 xynsSoO6d16ytczHo7m54ScJTv1Sntcnsu1h3It2/zLX1NBopbkQocSUqKESY3D9pNBL/qtCiNx
 +L7YN0LPg215nsNu0RBH4lBa7oQoY2If3LD7NfE+CnHOHe3/sBVOSglqIDvQlBy0v3wBYhset2w
 s0hHUHW46Z0EwGedyUESGOiZqPfHlRHYIsNfl4ZFMtgIew==
X-Received: by 2002:a53:c04a:0:10b0:667:5960:a59d with SMTP id
 956f58d0204a3-668a4bb38f0mr1442916d50.6.1784884238177; Fri, 24 Jul 2026
 02:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-6-shentey@gmail.com>
In-Reply-To: <20260723070059.6332-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 10:10:23 +0100
X-Gm-Features: AUfX_mxAmoYT6jkZkCHTtuMF4Pj3nuAiE-gw5sodNphtkhgkW7mIdERt-UsWTXI
Message-ID: <CAFEAcA-O5CXjLm+er8R9OYUf0dNgRZHpjnnbG+sY86GyZ8t3-w@mail.gmail.com>
Subject: Re: [PATCH 5/9] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_read()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
> Calculate mailbox indices from the `mbs[]` array layout instead of the
> oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
> the valid array range and fixes Coverity CID 1662974.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/net/can/flexcan.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
> index 651904fa37..8d680f1832 100644
> --- a/hw/net/can/flexcan.c
> +++ b/hw/net/can/flexcan.c
> @@ -1239,14 +1239,12 @@ static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
>  static uint64_t flexcan_mem_read(void *opqaue, hwaddr addr, unsigned size)
>  {
>      FlexcanState *s = opqaue;
> +    const int mbid = (addr - offsetof(FlexcanRegs, mbs)) /
> +        sizeof(s->regs.mbs[0]);
>      uint32_t rv = s->regs_raw[addr >> 2];
>
> -    if (addr >= offsetof(FlexcanRegs, mb) &&
> -        addr < offsetof(FlexcanRegs, _reserved4)) {
> +    if (0 <= mbid && mbid < ARRAY_SIZE(s->regs.mbs)) {
>          /* reading from mailbox */
> -        hwaddr offset = addr - offsetof(FlexcanRegs, mb);
> -        int mbid = offset / sizeof(FlexcanRegsMessageBuffer);
> -
>          if (addr % 16 == 0 && s->locked_mbidx != mbid) {
>              /* reading control word locks the mailbox */
>              flexcan_mb_unlock(s);



Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

