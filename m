Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7271B1061B04
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Dho-0003O5-33; Mon, 30 Mar 2026 10:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DhT-0003FB-JO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:34:46 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DhS-00030d-1u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:34:43 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501c4857b2so2457328d50.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774881281; cv=none;
 d=google.com; s=arc-20240605;
 b=E37wKNIaU2xPY5H9wvnJSjtRHOienVK4FXNI7zFMV5sSKuvwqw61IY9mlD6eOJo1TQ
 +fMzGiFQQiZbEYjn7jHjUH8a0vPgUp0kebeWOQODr47PUW/zi5gkgyaIQ/LZ7RhiIrBD
 5HG0L2vBHSDNZHYVsr01iZvg6k7lMralYUaaN/QjKjxuOJRVz36et8XMXaoyyzF3wer6
 iBAJ7QHrblAXhLBg3SGwO/zFwOEg2e9/JvLClcERt9yHxzHOcu/Vl3vICxd7bx5dhsTx
 oZ4Da+d23UVgoU9lkkurfzBe5Dl41iyOm2jVAoLLH/bWozOutmuPmbt+dvGIyej2okXs
 6fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xfIDoX2tZ9PCNuGnIeBtnGzuBkj4vnFxxssiPbLK1E8=;
 fh=CZjf/0TmGsa/91dn48nuRVDsmUAt8GsaJAgBMx0EW+8=;
 b=huKuuhvTXvgbI5LqFk7k8tZvgzfCs0zlaTEr0PuSDO/8PGTDHdSCSL+pAF7WJNRJPy
 R9H4PlOyb/o76du4zkGzxvPp+NEDyv94156907sy6EnG6F+aKkS9pv47FV1CWMHUSDSA
 jxNtfe/SxA6z7lVCxDNdquC30oZBwkcsl9MwM9xkpvZgC9oW1O/WxHAgtwJYAweS1yuM
 4C+CYCbq86aIsS/ASTa/KrSZtY0v1YOJtLNAgjzTiP/xByDE5yPuSZ72VInNx2dOFU1z
 fHJQR51FDgbuEMFJtZvH0jAqNhRO7NkZIJ14FMXUqrqb3mXgsJAEk3nh7+uCPDJQzm4o
 vRGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881281; x=1775486081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfIDoX2tZ9PCNuGnIeBtnGzuBkj4vnFxxssiPbLK1E8=;
 b=UJ+7hHcZpP16BbV3dH2JT4oN01nreUShiXKBqME3FIXsLB83hOKJUiXduWcIKGK0Yr
 usuUxCH9RpcxjBdBidtAAqZOufDPlCYKzuFn1iDu47EM/+Jyp1twC3CsAxJOtaiBAozB
 u6WrT8t6u854U5qZkebDDImhOUdvx8kNgS2+HlLb6DHuECHXmErZa2SmRtpm265ADAqn
 TaeVv9/IGfhD+XaPPwZrafO3EW7/1VJyOAKT4qsDlL75lo+OBOtdzGT1i5H091ngCdMG
 wMX1Xs6rzFv/Po1eXFv5AdczHEJ7aXEshyIt70/g8PCgzQJY1gapuaaSrZ9KiZtSKk/T
 ROAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881281; x=1775486081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xfIDoX2tZ9PCNuGnIeBtnGzuBkj4vnFxxssiPbLK1E8=;
 b=P8AREldG+CXC92xJN3MDqw5WXE+3dugKZIJ5okySJn1l0bw14+5ukmIYAlDYo/vVu/
 X9lWXPprOilpVbYl17Rywl8afUq3UyADSHbHnxoa/PGyuXJPMYJB7Cr0cqghbMqngtxQ
 xgAGKpRriM/9C6dasBqy5nwidHuFPhVix8XebjHUXghPSrmDlNaDs38hrhdbu4bNXu9b
 /ZRLrszYpl1BJDl9TaUB6S1Y0P6D0IAE7isAGHcUH/XSUMxJussNfsk8YbA7bJN1bkVb
 eQkvxlpx6zIUQYdEHWzsRETNYS1sQkNVYeM/xkZOaa2oqk0NHUrtw+jVVPYZ3D4vbvNM
 9STA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzLCe6WgtOAa/q5Is+8YH73f8OPmO/09Czgg9qQ8ppkJcVlQ4aXgIYycmOQjXKOtHzc2zkqStGOtz@nongnu.org
X-Gm-Message-State: AOJu0YymkJHeFC6/5kn3spMjWUGaRx6P6TKd5ZcBio6yP169l67imJk7
 eAdZ9VjWQRgdmbpuI6IaX5XVMqs/sgGxcykxof/APFpIFImYVLPek1L+aadvCHfEv+hJi1JNsKO
 bDAuNHhDC3QFbD//pfHsRBZ7VDGxQ9kWTFfOSuYhEHw==
X-Gm-Gg: ATEYQzxvK2PRGvj5ZRc9frMoWT51jvmCoOMgXsM04BU4dcuuygYFC7Zt0Y4Xzi5TNri
 LZCqr2b6tQYrDzhr29KJQM4OLxqVJQ1OrNrFloGRI2/P2YsDwaYa1EL8g5ny0PNq/zYEmJAS6Xu
 dr090YhKN7Msw3gN8+74jFOovwY07mTX2+PczWrRrXrNegSLWFec2SikWhCjOTde2aDMB9pQqLo
 +cmcrVIlDc3xaEjuPRvsTUxYimNg03Vxt/xH9nkzL30l+L2e6KX18MK9p275ndOxKaQ1VTgCgWW
 64TB307GFPvtauyUcL8VyPP+TkMYgCqBaiYgvD2UiQHOvg4G3Bwfg9iNQd+FyUizLKE=
X-Received: by 2002:a53:d24d:0:b0:64c:eb9d:d331 with SMTP id
 956f58d0204a3-64ff741cf72mr8610250d50.64.1774881280746; Mon, 30 Mar 2026
 07:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260330114853.638753-1-clg@redhat.com>
In-Reply-To: <20260330114853.638753-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 15:34:29 +0100
X-Gm-Features: AQROBzB2rErDTJ2EHX6NmNGHuRSDgC9XuaCmnizFDUZ232MsUyzOVO_5wSPJrVU
Message-ID: <CAFEAcA_sBu+A3hv-aFCtEa5uRBHzfkhwhW0m1VHDqiR711u_Vw@mail.gmail.com>
Subject: Re: [PULL 0/2] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 30 Mar 2026 at 12:50, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe0=
20:
>
>   Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu i=
nto staging (2026-03-27 18:41:05 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260330
>
> for you to fetch changes up to 9160305d92d2750e6ca3ada8f048305c9290f03c:
>
>   net/ftgmac100: preserve full VLAN TCI in TX tag insertion (2026-03-30 0=
7:36:25 +0200)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Complete lost interrupts fix in the Aspeed I2C model
> * Fix a vlan tag insertion issue in the ftgmac100 model
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

