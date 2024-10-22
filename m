Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F5D1CDC0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ApN-0002KN-QH; Tue, 22 Oct 2024 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3Ap5-0002Di-N0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:05:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3Ap3-0004es-SH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:05:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso6439806a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729587900; x=1730192700; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TbQs89ljDdLOUfAV2E4p8udzNo1fLOkrwMYdkZicPPY=;
 b=GS/KXOGEhnWYz7fJIN4KfOZUyy0G+hKwARddMzSleXpI1tOTUnebgWv8rm3B0l1xHj
 WUggSBLQPViBjcc6Gk7pcZDT2M3zka21eBWc0eyf0L4dmSXSloqQBdDm1aIbxFE6Dlov
 XbkbQGqchxprNng3dYBl6hw3xhiPSpoeJeWqsnjcxtN047HZspDj7dkwl26BXgWRL74L
 NgiuL7aRDJvLIkTqS0XEnYRGrubJ63TX3vg7U4oI9MLwb+64mCpA87/QwwYpI/g97zM+
 ++p/2pGhdVio7PXvS/rLgYDdSd0/MXvJ+9GVe34lqqGKnG8fTrRn6eIm8fSflJ2LhaQN
 Hs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587900; x=1730192700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TbQs89ljDdLOUfAV2E4p8udzNo1fLOkrwMYdkZicPPY=;
 b=fyBtLcaqzygDQHTBnZ86KvnpCtiBghBT0p6eCObDu55dxx3VurKbzjyYuy8YQ6397t
 v2CVjYKyOpHDsj2ZkKGP9xMmHlqtrWALNa4nLkkJ06tYFOD96eCIaHkn//5hSqygtWif
 RAiR3FJuN8209/flclyR3ue1X4+jjB3tbtfuC1C41GJdB4cre6GzL3wMsZp8IrupfZLk
 GE0J8nDoyfkvPcVm0tIkiDfnPquKS2SSuNWstLtUeR7a2ohNIcTxfJaRnF50L4Xiun6V
 4QL3gXziR+En7I2KRudZ4Q7aTLSAJRgt9T8trwL4xGiRCWLs6vLitcy9dZ8nOBVmS4Mg
 KO9w==
X-Gm-Message-State: AOJu0YynrBDXivzNPXHzDEEYI9HNqZraH8IAYdLsaA7Ywhsrw/bgUjUC
 3hxm8z/UGKX6kfyGF/5OHglZLwrl52wL325blWsp/u6yHr0+pHBBi6HNsTa4LAAvAhUiDfXCMSK
 /BUblbwTcZ8y5eWoJTx7mMGkw4Nb/NEBa6OJ58uP/gVXHyEYY
X-Google-Smtp-Source: AGHT+IGVGaVP9RcBRSGKOIZwTFpPbh1UDkIxHxZLhfxkCbEioQqbnQ4++ycGKXnC2HBVmodOhNqWJUXY7T4ArTSxtJ8=
X-Received: by 2002:a05:6402:3553:b0:5c9:62c3:e7f4 with SMTP id
 4fb4d7f45d1cf-5ca0ac625a7mr10692375a12.15.1729587900189; Tue, 22 Oct 2024
 02:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241022085359.186470-1-pbonzini@redhat.com>
In-Reply-To: <20241022085359.186470-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2024 10:04:49 +0100
Message-ID: <CAFEAcA9X5iBFMEw3dxsgBPZo7FBuNYp3dK5gf7v+cEyVa+pErA@mail.gmail.com>
Subject: Re: [PATCH] arm: Kconfig: disable stellaris if Rust is enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 22 Oct 2024 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The stellaris board requires the pl011-luminary variant of pl011,
> which is not supported by the Rust implementation.
>
> There are at least three possibilities: 1) implement the subclass
> (a bit harder in Rust since the language does not have subclasses)
> 2) change the ID to a property 3) split pl011-luminary to a separate
> Kconfig symbol and leave the subclass as C code.
>
> Just for the sake of starting the discussion, this RFC patch uses
> the big axe and disables stellaris.

Reasonable enough as a starter. For the longer term, we should
figure out how we want to handle this kind of "we have a common
base QOM class that implements almost all of the behaviour
and we subclass it to implement different minor variants"
in Rust, because we use it a fair amount in the existing C code.

-- PMM

