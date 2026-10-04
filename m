Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8ACA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP1G-0000s1-AI; Sun, 04 Oct 2026 12:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP1C-0000rQ-OF
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:24:54 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP18-0001wc-HT
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:24:53 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab445ac183so7874597b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131089; cv=none;
 d=google.com; s=arc-20260327;
 b=mB30gJNx5hzER5ZSM8GJrHdxwEseFY3I9Htk38H8qLGsvbQ7nqij2FU1JDhRJTdzmc
 mVXNBB7XoWP/+XOkH58bKshrIX4jTHHBGwPMI6r+lcV5sblidD3vQEDxveCvauAC6rEj
 mpF1oKMpITnU1eeRj3eiV/gzR812DW/9V6EhZyQ4Oy3M/2/jG6KguUhvEy7ALctyRdXM
 fgPj1zeLPD9J5DPKk3TSMqZYh/Tjs1npy4mCQ1OwOSGShKJ6kvapb3FEkYuDDMBNespa
 sSyrP+TvLABDtPMVI1rVoffrR/JnNLHNkXbl4wQ6heEDbW6T6TeZQGwexUfZGarg+Tka
 63RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5qtLr5uEt+yONvlhg8U5jZU5Nlv06KQIEhK+R8A01vo=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=IpDLpaf6gbqjHX8c+aT+imQzf1OKrz1z4+TCMcBxExR06dnHC1n4nUx3UPar8i/FfH
 kPGqMmZplcFV9ytikIUTwcdQ5UEQV9Lxq1Xl6ZH7RjYH9aHskdgblQpjQGig2frJkNS7
 kMhIBmZFodpgtVn28Zrm/CQnv1wSDd1ZYZG/MoCZK4Lc5kNdZmkmmdzysZriF000swc+
 JJVUcEkjJtKsA2jusqZgzw6oNEKQ6bJw8JKrFkJfpv2bBshvsiDBdoJc8WYdi5XdRQJ9
 USMXOBDrOJpFT9kT/vycRYcEiAx3JGkYcQg800zkI0u1xbTeM2u5LazVcPa1D1MEidjt
 BRBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131089; x=1791735889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5qtLr5uEt+yONvlhg8U5jZU5Nlv06KQIEhK+R8A01vo=;
 b=GurPvcSaPIUbBKrKiri6C3s0kcoQFPUEuJpg+hs8RQYfnaKgN6SjamXlhVCx1VXpxe
 wBoc1K8Xdjb56CQ198EepwFQzTp2FvBuqKz9uqiZlQu9agW6bHOgpRf+K/JPR+pI8AaQ
 5BuugE2l024WxyhcIRFN4h9RB9kq1ZkVsnrnfO/PJA87LDlrqXAlMo4oVvpNwhb8Ev59
 N/Hp3xZNlV5Xl2NfabA7Il3AfzAopBHtgUvndXyagOaIbvjGUrFC2fYmvx0ruCvU9bn9
 sRKA7BmbzzWB61jsABSmZ8q9ZcielsBZ3rpr/E0+rvK5bkUhAYPpYqQqWc0XICytOQvT
 nlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131089; x=1791735889;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5qtLr5uEt+yONvlhg8U5jZU5Nlv06KQIEhK+R8A01vo=;
 b=qBe9eX5Ad6ieCj41tX5S36uLygsrT0ZegjfhgAABc96prUV+JHSaqYukv3UF0nyNRu
 iD1wmsxdCeMSVCzihZrPyPQCxWCz2GT+j5EWJV473Yk2tM65y25rOxix4XJvxF50zBZx
 w+U/4UxD60xvmESFaEalVSP4uwqDH1nYMUXDNvhpDKHmaP8gfRwL/hRaf1pmTj9kK1Xj
 sI+9hRYHBI+k6zOKl9DLp5xPpcZoVZg8gBm72bBzx35MRvWx2T1xl8ehO/o5p1egKCX8
 4dvAc2cB1ZprsDQ2elpUf99npQBnU+j6osnkM4PJcie4jsw55MvqtZX3xR9JO00kchJ7
 2n8Q==
X-Gm-Message-State: AFq9FYJ427pNg6ohu/54cLMqi+z9enIai8r1MrdJkZL1tk1aY6NDkdSb
 HAGN5r6+akc79qlpglbcWCPPG/CZgqDbjoIJ6O+uh+A1z0mufIF/KxkP2+LHeAAUKEaZi+25g2t
 TdA+9XVfcPdLxUvRE540p5TNhPn0GjkI=
X-Gm-Gg: AYBFou15kSh8Jf7Asqp66gCYrVZitgYH4Ah+OHYgHbwGKbNOaHSP0nD9yQyylU5447M
 n8nBuaXfbPWjiRSRw+g3k5sn+We2+yRJf4g+VnI+GlT0xaIGFVbvTx6P1MOAU8GKmT5RjZgYVVh
 7m2Ch08wpPLeZ0hRXLNGCDUwdaQhbp1KofoxexlzEWUlBD0PUoJ1O1PDfRyMROYiI+pEFibT1Tx
 w8epQaOg/6dHRkaI2jIqkzhr/yQwWREpnnl4YOyAHTV75JVvoA64vMC2LzlgbIzTA2JVLK3Eq95
 oRasNkq5AZvFEMu6vrE18EEz6k6E4SyV5iUgyZ/sz6ozSY1H+hLddNh3+NaaR4ZFXIQLCFmJkZH
 Isi+At5g02FXFDjo=
X-Received: by 2002:a05:690c:9d:b0:8a5:208a:d928 with SMTP id
 00721157ae682-8ae3a3f388cmr43829427b3.42.1791131089424; Sun, 04 Oct 2026
 09:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-28-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-28-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:24:37 +0800
X-Gm-Features: AclHuK-tvpn-tHCeiRrCSbV1QlgkAFT2KT3_FfexU42uRFGFtODZugxpnA-wioo
Message-ID: <CAEUhbmVHsK9nD-hGTfzkrQKwGAM5Mp-75FV9tM3RCrGePw_=-A@mail.gmail.com>
Subject: Re: [PATCH v2 27/30] Kconfig: Extract config IMX_SPI from config IMX
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_SPI to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig     | 5 +++++
>  hw/misc/Kconfig    | 1 -
>  hw/ssi/Kconfig     | 4 ++++
>  hw/ssi/meson.build | 2 +-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

