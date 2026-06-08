Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B6CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcIL-0006tz-Mv; Mon, 08 Jun 2026 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcIJ-0006l3-Ci
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:53:43 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcIF-0002Kz-8z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:53:41 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66049669d78so3834755d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934018; cv=none;
 d=google.com; s=arc-20240605;
 b=Yh0FXtRGHhGYh07Qd5inTqThGf2Bdm+E4OAJqldkBkPGs9fBdyKCJv69NAxAi1buvE
 BLQSbj8LSZkYzjKpO4DJ9uvfNRjKurX9rfqIi8zH5E6OAWBKPOQ+jMt+nmE9J3fXnSqZ
 eTA6IEjmdD+C2oBuriJQBzgjdhXI6SbKLXo1nNU53YG9EFC4/+niK3GTDkvjiYS9LCtK
 d3VY/Q3smTOzhEiNNpJ6ZbziDZJm/E5Nvzx8GWOKinR9a9UU/FFjLzLRNkL9M8os/vbn
 iFJs9B8nFapksdYvw6Qe7ainMJ1nUfdhlGmJIO1Rs2Rh2OlrCroTa67wnt5PZKHGFiih
 KqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
 fh=0rHSq3ueJB9m76HtRwk2RJEWDps4JZB4/EJOcuFp00U=;
 b=Mgt4JM7HBRjZuYd+KXip3u/zeuGMIY0DV6mz2LL656ZRblvT12etGKkf1QDhmBW27W
 EplTliqHcARI6daYqRnN3rDYT37uMCOiXnflHA+IvGiI/nDhO0itqP1rAjSxgykLs9e6
 b/FSPnEbYJl4SLDLHgNdmN6FlHvQ5MN6UxSM5lfZKFSBMl0iKGrBRdOO8SCvDG6/qPLd
 H+bivvioITtOatqHAJXYGBUdw2mzzm/Q/mLincmzixVlqO8kVD0JPmYFFyBxIjqn87s2
 gLgqgxkB2D352gp1BhnXf+sgU3sodz0U8fS10WnJbKiSsd5SOnSj8uPaa8Rec51LB+G9
 DcUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780934018; x=1781538818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
 b=GEWgf820YHsVr1wZryeifC1630n6h6ZeNcE2Z+JxYF2imoO4brzhcQ8/0PbrDsbXjc
 0Ogli8m3m0lQZFuS/LTJDABFKRN4NEJJPxCHe8zhmwKr+mKss0KKxI15RM+LYyZQkjvI
 TfUJiJPuK6j1WekJ6EzNE+qOF2tuOxXMCZL5NVwMErtpUlZh1Aiq0T7utuDcRKMO2ud9
 4X5/bcnweL6b380oY+JrA95O7ZCpAfmcA0Qxc9GzHLfhxKBO3A7UX1xlNDHZZfAAiEvP
 ifdQ9q2MaRPXy8Oa4WBIDIvoniQUaj3wDvn1EGl9Cehj3FXKU4neQsNuOAAJ/h02BtnP
 gk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934018; x=1781538818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cGL/9b07z0rUpS/xzmbUfcBuKWYi/7ZfhvMUt1pJ48A=;
 b=G7FG6QDkP2iyR3Zd5CZfCsKKUKxyPRuKBOoOCInH6vnprF53uHKuwOnTZppvPtE+yf
 6f5g4DWNMcXBE0b1YZFCQijMJukJ4E62tS/hHbvhfHG1L8+O4/Pyl2gX+QW+x7Ad8ES1
 WxQAATco4yFBYkdg5TYGnptrr8mNkD4S13EA8CrsMF2uLXa0cYyrxLGpkJXhJa7S/w+N
 Hzt+Yh2BTtt5lxPdZUwqbDDMZQtuvEKSl9RiJPCd9By/EG27HzdliiXJj0NMA7ITYRQ9
 Qg0S1KbsHetz1Qcy39T6vlFW2EEJ8GhB8DSop4EP2MMP7wdtiLUi/LHU0Q9fsUsQmyV1
 H/jA==
X-Gm-Message-State: AOJu0Yy8Pc7sDyCiOMGagz7Ki+aLVPJK8vrw9PekMsvtalNNj2d6oj1l
 24qvzVptIZoNOyYgmXBJctztANF5OS1XS0HUCYZhOGK+ZaTss6Oi5goWn4R6k/4QP2pWaggShnE
 4dEB4NtBED0EW349P7Unqab7sOd9RGYM7rh9KHp4QtA==
X-Gm-Gg: Acq92OFPaXmPNBxeSX/97RtL1DajxKcN7dnm08LnVMSpmDFHSsCcyNEkaGhc/rZosXH
 ylXjU1FOZ42trnX3nyB4m1zbwPOMPB8NI9HR4vJEGdEVys04KdZCAlASQepiyy/AQLhWHvbzC8L
 QwI7MkKnxGiHUpBEnMNXXcccpx/Ym6td8fiB+t/6q1XbpKTOIB2Ums9NeNGh5e/p5TehoO+28rj
 UojUH+UDYSXs3QKfD1gKjqPlWqrNoO3IoKdphom6Nng3yOKl+lrZ21cmU9izKTiI9bFBzL3NS/s
 pTZRHUCXQvXw28u6BxE6xcFLlW+HWfpNcDbVH5kcSjMbDLZu7SNXr7HH7SvRCkN2PmLhq5xXLW7
 ElTifEiZMC2Hz
X-Received: by 2002:a05:690e:144b:b0:65e:39d1:d9f4 with SMTP id
 956f58d0204a3-661073da66emr12684719d50.9.1780934017770; Mon, 08 Jun 2026
 08:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <20260529082948.363931-8-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:53:25 +0100
X-Gm-Features: AVVi8CcW8P0G698t2w9dMFbyNLX1pYu_ywbTj3TI5RGvV3Iym5GgMjKCA1KpA3g
Message-ID: <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now WFE can actually suspend on A-profile we also need to handle when
> its trapped. To do this we need to pass the instruction size so we can
> deal with the is_16bit syndrome encoding.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Doesn't this need to go earlier in the patchset? Otherwise there's
a point where WFE can go to sleep but doesn't honour the trap bit.

thanks
-- PMM

