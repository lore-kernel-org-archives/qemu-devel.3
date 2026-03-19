Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7887A1091900
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HNE-0008UA-KX; Thu, 19 Mar 2026 13:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HND-0008U1-Ff
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:41:31 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HNB-0008Ph-PM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:41:31 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c9707fc11so1033166d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 10:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773942088; cv=none;
 d=google.com; s=arc-20240605;
 b=EHPU+hkHGX1t5mgmbMsIcG6jmfOCoJCllfYwKPSUeDagx7euBfBrN7Ep/oyAy1ApgI
 x0B71wt4sbKxLvNhrty6xKt2Zw3/pOIl8K7D+zw02rv7dglsxG/zA/7Iy6/TbBfMu/nf
 jqRr9L3PXVgOhQCVaw9849GxTDGVgtKzvafjQ/K/PmCZ8lh4rqx/7U8BPaHQufzGyud0
 O6cSU5IifNWrzMpsLvRrE6dZ3WIBFanHIdnWUwc7kzwLlvUxFbBl/e1d/MeCBrTUviNa
 9E1fWV1p1QD638l2fnITo92deAPeMrepAr5DQtYyHvWO6d+74WZeBBxuLbKNscbd5bDV
 nFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WKaACPQsl5AHC9/3yfX3aq6ksbv8J5wba/nVwvxfz1g=;
 fh=7g8R6cEJaVMV/1BX4UiN0GJ7QdXpS1kB7s61x593jpg=;
 b=SkxlThEHmAMTSix0g2LA7Z72E2YPf/LkJShDZDfZbAu4h4mClcBqX/rtNXPK6HDb1I
 jOf2xZ41dkM7B6NNrR86fghGp/p5Ot8FQHZkq3qQaRaYk3B4AnteMoy00pRGo/b4tXN2
 /lcTCABkWfdMgi9FUIBSiBaqr+co8OwEiiteJ0cNTvgGjDAwH3K9eFD/Ig/mKCyaXbXq
 sPCpCpkSfHgG+7j33vHaAyy887xifhLG94Ab9ZPwgXYMNTOBAoFVERmkaZWtuAikiMRz
 b7DmfBNSxjHH/gUJh0tt89XAUOXxWYiu0DYxZN6GaXa+pdfd8yUjYLjsI/7IR8c8MKLl
 lyZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773942088; x=1774546888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKaACPQsl5AHC9/3yfX3aq6ksbv8J5wba/nVwvxfz1g=;
 b=vwizhuGnrNTWW6OD/7bp2wYXJq+ebq/xxx9Vat/ih/bmv6oPITRBAkizAPov6ltsir
 Ph5jSQV5qJRt8u0MPMUtQm21ldkMihPR0IHInC0QjTzN/urgiMSVRdU8OIi3693ugdEc
 PWRXzGjE7YL4SY2e4KhXF1E9kDNJpRUc/D4hBb1Ajyxqjo3gE15HZdwXqsp7aSmyiqZz
 AgSbqprOU/3wHJgDm1XGMzIPsuXLVKyNE0mqn/DcSo8AEZkyduDRcvD04NZxpoTxOrPu
 t9VF8e8jSF8Te1/YlmjN5F3+oAzESTQ64v/KPjNsGo13W9/laTv5S41dGTPJuVj7PVto
 TBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773942088; x=1774546888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKaACPQsl5AHC9/3yfX3aq6ksbv8J5wba/nVwvxfz1g=;
 b=c/MzqPhgjpor/Tl1Z6xO3MR9zcJ+x1duY81WrJL8ofJdF+8CDovoEcSXGNriklcStQ
 87Kg70zj+A+7CUBNftHFDPB6scPAun6SYILFZ3B8Mp0Ajzg0Tuabp4R9+VORIAiGLE5l
 kOFL8pWzx6uBlKjPblBh2PJmB/5x9GzqXNhuNTSzKaoG2gwAeoaBfZEbKw/5xUmeAqlD
 PvKWOVKvxx8PAp5R22TuNqLpo6JKgHYc3gX2mNR3idAmFriwhFMDqad/mBvvzyNjmkRU
 Owpzm7u755t8q9jkWKDG+m3p61i2I40oDxkZF7/rOQCGcnkVtLbP/t6Xt8YEvutKnLF+
 8FGw==
X-Gm-Message-State: AOJu0YwDRAJ1A74sGtDMp1HwHVqaQX3fXCF9SaIRWpFHfibAMX0BwK18
 y4JZAcGJpypJLGtB3URdebchP9ZyKRt/PjKqz9iCMjXyZQoCrnmlhmG71u1XSIfz0DDOrIubnJN
 H+UizcH1AfLcmG876Pomiwn6Pc4qpl6TwfShSJ2m0Rw==
X-Gm-Gg: ATEYQzwDz35QY/tUcuAuF7vBgs3vOaJlFCZWvHWoQ66Ia+jlcN4XuFNMUUjP+pVWRbb
 QPztNf5LftaekVy4jo4frc8U9mkbXIm1opa2HMHGXJaAygo3fdfhVb42mbKmToqqQm/OgCNAgfm
 Y7IJ0FrcQmL3rulV20xl/RQLv8o9+oeA+Lw1+O+AWxyVhn0wbBp8DWdUb99mOddzC/7i6CfDwLr
 pph1qVoov8eiG7N3QuLu3CDZcy6VryH5pwtUusQY5VG7h57VX65DxRoShuUdRIUHh3A0R3szsUx
 xVvWwiBug06irc+i4gsRe4YOakyq1/vWXABsXC7NLNqmY68EOtXoOUg2dt15AvGfqtQ=
X-Received: by 2002:a05:690e:d45:b0:64e:a229:2147 with SMTP id
 956f58d0204a3-64eaa87510dmr352639d50.71.1773942088497; Thu, 19 Mar 2026
 10:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260310055530.8893-1-thuth@redhat.com>
 <20260310055530.8893-4-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-4-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 17:41:17 +0000
X-Gm-Features: AaiRm53pN7httHkeWpNcK_WZvZEPpL9rjEr9vhdLVwkci2GBY27ABZ7PNk8Am3s
Message-ID: <CAFEAcA_84LiDD-aMsQrXipWa2ski1uzt_HeL_1SeFYRZMxuH7g@mail.gmail.com>
Subject: Re: [PULL 03/25] tests/functional/ppc/test_40: Fix the URL of the
 NetBSD-7.1.2-prep.iso asset
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 10 Mar 2026 at 05:55, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We now need a slightly different URL to be able to download this asset.
>
> Suggested-by: Reinoud Zandijk <reinoud@NetBSD.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20260212143843.287090-1-thuth@redhat.com>
> ---
>  tests/functional/ppc/test_40p.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/functional/ppc/test_40p.py b/tests/functional/ppc/test_40p.py
> index 614972a7eb3..ed272147f6e 100755
> --- a/tests/functional/ppc/test_40p.py
> +++ b/tests/functional/ppc/test_40p.py
> @@ -27,7 +27,7 @@ class IbmPrep40pMachine(QemuSystemTest):
>          'f86236e9d01b3f0dd0f5d3b8d5bbd40c68e78b4db560a108358f5ad58e636619')
>      ASSET_NETBSD71 = Asset(
>          ('https://archive.netbsd.org/pub/NetBSD-archive/'
> -         'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso'),
> +         'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso?key=NetBSD'),
>          'cc7cb290b06aaa839362deb7bd9f417ac5015557db24088508330f76c3f825ec')

My local machine has been sat downloading this file very very
slowly for the last half an hour. Is there somewhere that
we can get the asset from that manages faster downloads?

thanks
-- PMM

