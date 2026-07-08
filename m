Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3226AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUX4-0006Ml-B3; Wed, 08 Jul 2026 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUX1-0006EG-G2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:49:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1whUX0-00042E-0v
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:49:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47de008b020so468835f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525788; cv=none;
 d=google.com; s=arc-20260327;
 b=axTim/C4mqmuV6OAt7H8IYPkikdbqUkOB9nRdKOJ6HVPd7aDXPLuuYlwg4C4XZslIx
 ml3JUHPQUIxdUZhEhwN2NsvXBjryWVk3IR/BvSR6uGiNWLxBzABrBahqlOKryQqPrN1U
 0jHdsW79Q8SHfb53gdpnsSBWQD/qpGpz6aRSVCzX3MjO0hqO+DuCZr0XpoPTiZ5Drp5D
 4nSxtiqGOlElGhdCZrPf8aJuJGNaccz8TZoFKFmDq8Kj2L+xOMYlcwC+7XKLoH4VV4GG
 pndCMPdMS3ExQoLpXOUkPWTx4gz7yVxMqKodqs5Ie1P+Miu3ZQVKuQ1tuUH1T9g+Ufp3
 4iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ks8sfeW0rVHmaUy0zC9BH8wSnlOUhz/l8SRZs+PMBzg=;
 fh=wxfdAIDHECabJT5SAtRCcSsAVMtdaF8Xdvou0DbUuWs=;
 b=jp1MICN2Y7YpPsYuDbWn2PMTcHY4XJ88PKyuydOE5ykCXd4s3a6MgP7Fd4ccDSbRRR
 axmfJLXalwGgUVLCIjWpk1igUzViFVekvUH11rkoyOIdPCjrDtuq/oYWlJSDiVHcq7Ro
 ub92b/Jo445CSImUiuKuMYwkDJoqaIdJYoded78ffo3m9hicMePVzyXudqnAnE7Za/yO
 ko5H0ICI9ieylPiq63VWga1FEGPMnd2/leV03P87gLVbe2iKqrrA8GKUWRj+2ObjiIi/
 1g2c5vKwa3U3M+Wwnydv8Jc3MI0OzxXlmnWTk4FDKq742FK214SG3+A5Ov1arSOHjVWK
 sVAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783525788; x=1784130588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ks8sfeW0rVHmaUy0zC9BH8wSnlOUhz/l8SRZs+PMBzg=;
 b=GZH4iN9ERyJpXNs72wlLY1AC2ZZEezoIDgffO7trGF5kcotXyfom3XZs91Y2GP7Yq9
 +o8+W3lj0qIStHNKaBwA8xkWDvk0EDhA3UKEg0Fawx3Cam+fy10qBEoNMkqJdWc1TcpF
 rq+77KeuLZKLqdt49ZqbpnA6t2lcDtMywJPosVn2SZmJ87sF0KuuVl4qTWjc1DL37q4H
 EiGtd8QAKlM0svJWEf26DY+6/FcSqV/1/uplhCTcrVkfhtSY6BUbay9GugQtGalWVTWf
 9eakbdC8Hcq9Ck0Zo4VcqQpWR846Q6nKnXv7/p9Pb6y+hqqMe9SMnbuF1ZAyzt1Tme65
 f1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525788; x=1784130588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ks8sfeW0rVHmaUy0zC9BH8wSnlOUhz/l8SRZs+PMBzg=;
 b=HIP8g+0/znkFXQ1AHuXzlLyxEuUA4Ya3D0HBub700yLjfnZInwqM8BwcGVMBcHPzX0
 PW1N9ownEQ7Lst79aoqdQf835rNzhA2TiFCoX29ZnFeq60xS4haqAeXaCDQpt3j32Dtz
 FyYbnGf1IZB/WijGaOc1jmzS4Bg7t7T2t1xHMU0XdRUcUd3e9HbO3T/z3hQp39nU5ae4
 bE5MqTfNbSmgKWeLjz78R6DRse/BCdfj7hBajehl3XHxNN1bexoNjDgDxazGhC6zTGNY
 ByLwoLau9sxXAwjLzZv/QUnda/pb/uhlJWRraoyZS6lHjOu1kV80K3jZdmuSsKqJkHLw
 jYnw==
X-Gm-Message-State: AOJu0YwWjhNhomJSRL5ylP0lsB75Ad4DnhIRBqM3K7bU98arD7MT4RnM
 EhCksQrNYX8JxKgh3S+fFfySztUN/PPuGZpBcp+5+61ofHx+SORc25TWgtMXyKV4ZdwkqI34b8J
 bzaFTzLyun/BMeyOwgW8SYx1h93r3LqA=
X-Gm-Gg: AfdE7cmZmWqqUN63G4Wqwn256Ij3H+Q/YbDxqtooGDMj1eQJQAEycu63gPbqzG/MJsd
 zB67lOolQqHBP1FW+SBdzOdZ8K3qtj34WgQYsIQG6L4ks7ZxnHaLqdsp2vfS6vypXdiU5LDiR9/
 htXJlHLZcNdn/1Za5+1QRdT0+23tmmqdru/UHSIrAELL8O5lqV+6bYjTPSWAR3RpF0tM+bImAuA
 RRxo7kZ6GG0M13dOuMLw2r6MzM0zi1Zpxx0H+OdZEcQdwakIVaJTBi/tD9ODrb0Lb5G/82El3BA
X-Received: by 2002:a05:6000:4025:b0:473:536b:5d1a with SMTP id
 ffacd0b85a97d-47df024a097mr4042991f8f.7.1783525788390; Wed, 08 Jul 2026
 08:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260627063208.33642-1-bin.meng@processmission.com>
In-Reply-To: <20260627063208.33642-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 8 Jul 2026 23:49:34 +0800
X-Gm-Features: AVVi8CdjG9rpeAMePP8uBpfBtTr70yAs1RvwTQpZqFAjRHEjrCDhVowJ-plYYo4
Message-ID: <CAEUhbmV_BfLT9_F9OPH8VvwCZ_8Th+swHu833E0sjYCkj-k_=w@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Update Nuvoton OpenBMC image guidance
To: Bin Meng <bin.meng@processmission.com>
Cc: qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x42c.google.com
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

On Sat, Jun 27, 2026 at 8:12=E2=80=AFPM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
> Describe the current OpenBMC target naming and release status for
> Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
> so point users at older 2.14.0 sources and explain how to find
> Jenkins MTD artifacts.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> ---
>
>  docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>

Ping?

