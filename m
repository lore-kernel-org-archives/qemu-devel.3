Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813FB1125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N2r-0002y5-M3; Wed, 11 Mar 2026 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0N2o-0002ru-QB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:08:26 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0N2n-0002CB-1q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:08:26 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64cb577e79cso158829d50.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248903; cv=none;
 d=google.com; s=arc-20240605;
 b=HkDt662+f45d7RhFXa5wI8Ja/tvCfSs+m5gv6R45Ns/Kik9SMsI9S/4E/ct+L6r8We
 Tcp0thSTreaq/KLwblAViaRLOHrFdubO8WA0HY6RwprIZwpJelFJKEFjqfWAGW8J2rHy
 XysR0AowDM4Qg1GoRXGjalmyOaaDOIOwkR8USDzMNw4TWdMZ06ivTNOKmPbKbEDWctKz
 DayKLNad3Qcemjxq9oMVEAjmgYhZ3YW6yj8W7Be9ARuB73R/Cl3N22YMeUfWm14OaQmV
 2VaF+E9cPvXLKatJ67QjGyNnlgFdwY8gsmYxILKqEQR07acRexZijg/inJ19I6Vs4k8w
 wv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oQ1ZQmTD+aQlp7Z0NCEYxNdfEv3Jy3pEAuTnQeKwK34=;
 fh=8P8o1aKh6b2os3imNd8LrVmPd/mKSJWYFv88dmU9Ir0=;
 b=XcNrlaASjvPmV9L2MwBA1WNKRo2aLVCbjYH6STuynt16axMcGCOfqn4q7SdMu7JZPH
 J4yR4qXS4BvnWV98fAVNcthpeDYBG4s0yxEtXYrMgGFFLOeV1Q3jVEKqby5EL8R3mJVx
 hrXXRglX3zEctF+76Yqacf/UO9uyMp+HIvgs5z+1z0xcWuAq6TvU722rL0Uc3C26VhQS
 ApFk3A4Y1TiO+KY71IfSFNgbTjmu2FNtrEXMm53xok4GlnF1Yrrtz+l3CBb6zjjDUJSH
 Kbyc9px+14eJ9+8fQjiZ1et3by6aFuDNZPV2khiPwcoL8eiOJ95NjRD02fGMRC+XL75/
 PePw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248903; x=1773853703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQ1ZQmTD+aQlp7Z0NCEYxNdfEv3Jy3pEAuTnQeKwK34=;
 b=Kb6tAi2hbKUv2I2QBxhlvPCueFBrrXoNqdEnAMDpnBS2wrB2Z9EweL6eGKSxhGA4lV
 SeMvSKO7fDwsxc/DSXexU3GJpIKdXOLaiib40DaZy24LVfIhrFYgvE5nRRfnLiT7WC8z
 MRb3+ZqSMuG+JVUCvbSndwCEX0I+CidB7XmlYkyDGLpkwZMmS5hX8tse1A8KFNv4Y3s9
 kaSPQ1ceU5h/AIux8G7Y6K/DjJsRIuD38DZojgfjlHPS7X6drGbrNrzP+NbDdQeE4pK7
 MWCKqhZl0Rh45eUokKRcXesxJbhOldCLR9Gz8kcgFeOK3nlMXyBR6KHMEC+VDJ2Z8IAV
 vTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248903; x=1773853703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQ1ZQmTD+aQlp7Z0NCEYxNdfEv3Jy3pEAuTnQeKwK34=;
 b=IlUlSeiNe06maHgI4Zb+9zZrzCq/PjEbC7eor0qlPCsmbVEC98CYBa69lZkMDPQFf4
 v45gUZfugzdE1ch4GKQ98GBqBoig8NnTyl8+Ehbg60l+sQrlqeQfy30Opfiiyq6UCkyv
 BZakQ8w1bwVJd+W9HaXHhRN5BRCNporLG1K76nYccxMWuAZuZl2zftJP/6p+okh6Yxjb
 BoLfvkH9frbitNTiz8vZFt6xJ1ScKcs1q4+AGBecLQE7AyLizvP4h3zzQ5zhMysoTHP+
 wbM7oAvare0aTf8/dYuGRyoVW4yy9yEq/LGPf9uzzs2lUN/BWtSDY7641qse51Ug1Yr/
 a4LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq5zEMkApwPFkPIOZCqaBZWr6J7Eu8FngablsD01IrmmY6rE65bjnGc9+grEQTemx1XU4M6w1DGAh2@nongnu.org
X-Gm-Message-State: AOJu0YyvV2dId5r6qbCSeRPvtZmauW8PN9XJVshb+JE1lmfIKG3Y/vRP
 lYk80YOi/c9wv6wW5eUDC/dkRsus2CQs1IttblOi0K55PiLD8RsowtFc0Xvlv7mdCMxZ4J9CXT7
 sM58CrlLqmdJ7lIVOh1ufJVf5mJBqIF7ec7YGLma9mw==
X-Gm-Gg: ATEYQzxTshfRjVhoH1vTktEMXqcMoJJll5rNSNukIy86usIk+hCsv//GYi7Ic0yVz76
 WiXYjvJkJ6cScxjG+z4miK3FtoTkeQ6MHdAPs7n2Uc+KNgIE0Mj7TNuHMoSsfSUDzsyy+/VSCko
 +LhaJWk1lusI1v2L0TTWf8iUXE5ETU8LYaKAy5ujL8w5WatYysj7Rk1YEuDqg6aGjTqrH5ni3Ru
 9/hVGu77fb0bmaDyQp3kePQlfHtIShRwzU50yZPBh61PvlK06/fLrmQTSGhw4RMXu8SwMKKo/jV
 sjZuuGgEXMktxS/hNFLJ4ATh7WY/jkPT1sqgvOV8u7AIYIUXAZtgvEm/6a/6eFp9jBk=
X-Received: by 2002:a05:690e:144d:b0:64a:e142:a097 with SMTP id
 956f58d0204a3-64d656f7018mr3257779d50.24.1773248903342; Wed, 11 Mar 2026
 10:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-42-peter.maydell@linaro.org>
 <20260311165151.00004669@huawei.com>
In-Reply-To: <20260311165151.00004669@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 17:08:11 +0000
X-Gm-Features: AaiRm53foUcrHGH73x4RHe2nJMuFFsFE8-8eJqoxcq15DCycxkunh_KpQayP2U0
Message-ID: <CAFEAcA9UOGk3WZG3Dx5NmEAd4DUY0o+hnPo0+F5MGeMTcAyS1w@mail.gmail.com>
Subject: Re: [PATCH 41/65] target/arm: GICv5 cpuif: Calculate the highest
 priority PPI
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 16:51, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:01:48 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > When the state of PPIs changes, recalculate the highest priority PPI.
> > In subsequent commits we will use this cached value to provide the
> > HPPI info to the guest, decide whether to signal IRQ or FIQ, handle
> > interrupt acknowldge from the guest, and so on.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Other than struggling with the reference, LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> > +/*
> > + * We keep track of candidate highest possible pending interrupts
> > + * using this struct.
> > + *
> > + * Unlike GICv3, we don't need a separate NMI bool, because for
> > + * GICv5 superpriority is signaled by @prio == 0.
> > + *
> > + * In this struct the intid includes the interrupt type in bits [31:29]
> > + * (i.e. it is in the form defined by R_TJPHS).
> Not sure it matters, but the particular GIC v5 spec I'm looking doesn't
> seem to have a R_TJPHS (I happen to have EAC0)

Hmm. It's in the EAC0 download from
https://developer.arm.com/documentation/aes0070/latest/
in section 2.4, on page 32, second rule from the bottom.

thanks
-- PMM

