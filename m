Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8FBC9EC93
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIlC-0002eD-Gx; Mon, 12 Jan 2026 09:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIjm-0001Rm-5O
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:17:44 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIjk-0004C2-GT
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:17:41 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc174ada4so59889667b3.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768227459; x=1768832259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=reLixoQNXSvOf3kpvkUs9YMlVO2PhgqAdnopCWLR6ws=;
 b=CPnnJb5qd+c4gipykLL4CXsDm/Cbhp+xdAlEDdBaQeKBEg5xQLdLYfUCLk/uKFaaTX
 9d2Av8yAwVFAJVdBz5kognnOKV00RAGOG9Mn1AMGNSDTnX/EM8o7g9LVKUnZ3FkzoaWU
 eldpAbNR4Gnu9QyoC2/9fZ6LgKxmW24punzFMBg7a2ZUsKk74S0gaLeQxd+nPBXr0U4C
 xyjlJlOXxMTFZZ0mcFjIcXQnSxxT5+rP/KSKjHHEqC6fss8+Wq9+9hr4Ait4miPSkOdK
 5moksVD2ubGHgTrtmNT2dKc3dGFdD+mTub0BAKHc+ij5z1TCEpaIb+quX4IelhWEeZFI
 jFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768227459; x=1768832259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reLixoQNXSvOf3kpvkUs9YMlVO2PhgqAdnopCWLR6ws=;
 b=ZOpHJjSe9o425gOqbHlbBDhicoyoyDNMPvpN3tzzAwqa0OUp33hAkLnG/CXiSUp1dA
 T+zu1tx7DGqFzt+pRrq7c2B1+PxD1zpsNegeHJFSRvF6/g2Gd1jFQeB4rM3LVEd+lHZu
 uR9GipEWFK0+auhX1h6JQFZD9RlLL1b+FXbmo7Dn+CIZBPs/LZekrSzcU58UtGAdmDkf
 U2ioOS2BAjbwWMDNubGj/92pYcZV0PwS3RPCChzgMPqpPPzii4zPlklLA2yf11uCyQXT
 yXOXYgTiiZuNgo60ekQ8KYcQ/Em+/QGML5PKvt8Fs/RFqhpQX+WMhgJl0fGG99NZJ6Pl
 Cm2Q==
X-Gm-Message-State: AOJu0YyGtYAOgYU14AOU3cGI9eCaUjsBeL7DTV14qyF7dxXTnjjn4ujA
 o/pPniZIoriA2IoLedD069Plpp1baZbMlqg/8OKLjbgiC6dO7hJuJCYKNwRxB+2BpEloreinMWH
 hl9GASsuj0QUyubAkj2QoRJaVFOuNqroMo6Vna4626bh6hHBb0bY9
X-Gm-Gg: AY/fxX4AzBuoemCjEvMGpdsAXjXAw1uidblkull3/1Gxkwmfx9lncGSUa14caovfhGy
 yZEaC/9qhFv3UVYHJnlDX9O7EzSEN/1HqdKO32kIhm6ssKL/a8zVmLFp+zcGvH79Y18U1aIaOQn
 jKpHHrLcxHlZqS4Bws1KY5fg14nXTHJAqYi54FPWs9jQk7AB14jKnL2qUA8KbkUBlCQwp1MoKo7
 UvoHH40HM4Tm0apfLDOldYTFmus6d6sPwGdN86JVnzqNxBZEfZvsE2Nb47CWOXgC61ds/HNS4RR
 fAPlaVgIoTR0HmaJG+rKq3I=
X-Google-Smtp-Source: AGHT+IFXDsh4Jixt7X1mrgNx6BZxIY2voGrEOpAza/cVtfNjYkfnrin8gntvGbL8vHT5rC98blRDYsTo+EZxqklQUgU=
X-Received: by 2002:a05:690e:1654:b0:646:5127:b539 with SMTP id
 956f58d0204a3-64716c6982bmr12143838d50.73.1768227459331; Mon, 12 Jan 2026
 06:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
In-Reply-To: <20251217-cmsdk-uart-disabled-warning2-v1-1-847de48840bc@trainwit.ch>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:17:26 +0000
X-Gm-Features: AZwV_Qj1Y_pC9Vb4mWd2EUME0C_0PEHT2bk7a5F82YcpaIcr_Dlf4zzxGtNYgWI
Message-ID: <CAFEAcA-QdF3n805jDi4aJUbGu-nvqYrra4sz2XiSUEf21NwQEQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to
 disabled uart
To: julia <midnight@trainwit.ch>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 17 Dec 2025 at 07:10, julia <midnight@trainwit.ch> wrote:
>
> I don't want to admit how many hours I spent trying to figure out why
> nothing was being printed (as the enable-ing code hadn't yet run,
> even thought it existed).
>
> Signed-off-by: julia <midnight@trainwit.ch>

Applied to target-arm.next, thanks.

-- PMM

