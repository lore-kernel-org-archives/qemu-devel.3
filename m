Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B459C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLHo-0002Wl-Ln; Tue, 04 Feb 2025 10:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLHn-0002QJ-6L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:56:27 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLHl-00026U-Kh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:56:26 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so5186164276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684584; x=1739289384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hpxzLRyuqBc58b/zbC0ov0qjtk3Jovv3tdauaDKO7nQ=;
 b=SH82uleubEN8bSG5upseMTUOkLwatMAmGedgXheogDlWhmVFakQL8ldEL3CID7xivo
 +n5nQoi2PmxRGtz2mTuqSZmO3o5FjoBQbEzhpzmHIoVzLlRKqABj25kHOjXrqSUJcUWC
 /szgJvzvDeWATYrfLvZWBCOY8KPgtQCa4wOKVYKz7DkNI48pajV3tvxwlFP58BoI1f+X
 f5aMwY5q+xzaAcAaLGOhcA6WyFpvatP0gauiLWsHmDVOUp/kg1TEMOv6QZGt/ykRvO2N
 0upIfWhXUR1BKBDJjF46gV4vIbimSugSJblRh7yb/hN3kgpix70NyWM+k4NTuB4tZa5g
 UU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684584; x=1739289384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hpxzLRyuqBc58b/zbC0ov0qjtk3Jovv3tdauaDKO7nQ=;
 b=RW5pqp1HBSuiPkwNo6ZQjSta1LbWiKBYl5L7ZZ7W8v1SyoRuFOWmjgmqQxkwz/MNIL
 WzUAR5DyQ83euJfG1x9zB78p4qLvnErshDF2MfWSiS6biU8x96QbKDvsSjYh20yUBCUJ
 5uTtadbzQZhgruhwC6j2Aq810v5XDRjxg1thRI/eVNM7bbhuJqEmLjibxaTwJUdotjY9
 k9Nl5FaX96V1zNpTLwUOhZUuhwKBIVLo5MmeEaED/NmUC48u+/jsHQ45SwklPc/PjWrZ
 nwEqIcCcFhADCvtoIM2asF2/LwuDuyoftPz63nU6SWiwc+XMIt2XTck0To5GDWsOyXR7
 q0pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHHUAWwcWPLVHCbyFgh/j7MCIjA0YR51U2d3KEHkKc9m8BiFhY1zJUokJvvlJBUO6u2rQv1WJMDBi3@nongnu.org
X-Gm-Message-State: AOJu0Yw94Q5mIZNql1HTYVfsS348quzgv1eDcPEviNw75nvq52cmKYtx
 m+XcFd+8MiGJKhGCGEO4gQmY+RuiKQ3tUSh/8tzIyPcZBeOswWUiKFeuLRQ3Wut9H9bkGjfuub2
 n0qCzOq43sr+Wvkr2+96fgQ8slzK/ayN7KRWfomtfwKhPWElQ
X-Gm-Gg: ASbGncsIZ1FVDhAZlONKPI+Bv6aSs1GSNEw80ydbBG0/BY+qC1BBNbJhreXQntdA0zb
 1Hgydmo3VnAkaXe6EF2LrPg49MWUwxkNxIQirPjDtUeksACx/aBnPsHVH673Qxdh9qkdS+PN2QA
 ==
X-Google-Smtp-Source: AGHT+IG6tLV242EUTUrJFcR7ah8uZRce6wATJHi+gjSrhBYx2cnnv+vKpJk6ry+wNfg5LrEeVrvEV1KWEjfSlCWx5TE=
X-Received: by 2002:a05:6902:2002:b0:e4c:bd70:854c with SMTP id
 3f1490d57ef6-e58a4bd7ee1mr19774218276.43.1738684584549; Tue, 04 Feb 2025
 07:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-12-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-12-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:56:12 +0000
X-Gm-Features: AWEUYZm1d9zBBHPsVJHVvZ1kKx08vFVvv4UPfp5O96t1VJfJpOhMC-0Y7T13n8s
Message-ID: <CAFEAcA-iPKuqWwaB3=mHmCFghiW5Y2HATKbCdRZhYk3ejmh1CA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] hw/misc: Rename npcm7xx_clk to npcm_clk
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> NPCM7XX and NPCM8XX have a different set of CLK registers. This
> commit changes the name of the clk files to be used by both
> NPCM7XX and NPCM8XX CLK modules.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

