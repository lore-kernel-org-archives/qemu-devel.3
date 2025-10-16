Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E98FCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N1w-0002Hu-J8; Thu, 16 Oct 2025 08:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9N0y-0000vK-Mc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:23:30 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9N0j-0000dD-6F
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:23:25 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-633c1b740c5so728713d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617386; x=1761222186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2C+0wEFz4rwq6y2h5JGMTivrxHAjZFvVlCHfttp9nns=;
 b=kegkQT2gJd7b6qJE+ElbZSqim0i/uEevnghfJ3pwfeZlrsFRzOkXXNiBwZ/no/2eY2
 g5kHEO1ACM1Cm4p3oTjEzkn7K4nb8pFrLW4N3/5Rq6JJdyeB0GuRsPLoLDOi5vDoEB9E
 r6NIuOTjDRmAnt1yswiPMuLQ9q/Wwo01whPjYRXsFFhohAgQ3fccR3AYjxctb/wHA+Fn
 PyaTOC6imUgEbozvOpcCvdtNRIQvqOXwYBCP1gpl10pEwOQQMsRpt5diLnZqoPnVpM30
 A0/MdeLsFnVImgbSXvxKkKzqoQlvbMX4RNbznuBLgip/nvbppVoxrYva/OVcbLh8z7Vy
 V/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617386; x=1761222186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2C+0wEFz4rwq6y2h5JGMTivrxHAjZFvVlCHfttp9nns=;
 b=VdXDoo+6cSpHKn9+ILALiAqe4kxht69Dd4F1azMA02R7g9vwuBIhgVJJ5Wr/xhvUVm
 MTBX+v/3vouhwKXCSSmraWwt0hALyzFnohzlL4nZ35HykNW9OYOF/t+h3f2rNCat+V9I
 EO1YCFC5kdgaUwY/JF6LmW95lDwID330WZGhBjtYijieDysQ1725gviMrCYaoxY/+cqe
 J02RBxgho90DFgwleKz37Lry8mQQqvCQkxOkZ5W9I+bxQkv4OhWmh9y8kLxA7AxGP+Jo
 4/T3ohQS/VS+zMUmSkIc+AiD/zdGhfpRFEIfwz/yTwL+CPu4hE6iF9cEcTFp1VDwbbLl
 tJ8Q==
X-Gm-Message-State: AOJu0Yx+XISZlaVlEgCGJOwLO5O3Ie4IOGWUdT1m7vqpbdWxgRXFpmtE
 71+/0dVJzie6B4D4CyfCSYqWHaUg92a2NvCeJZ+92SGASXKuYbohzWphJKNwxNZBrqWqBv+Saz6
 8cq0hBmx/hdP9GwOCv/vpLp1qxa9V3O7ufivYJleQxw==
X-Gm-Gg: ASbGncsZv5wUE/TG6YViQ++fQS4fk5KaUjy14/9ffmMbdhkBxME9gkwt9B2/vba8Qvl
 SqLXtIni8LMc3s/F/4ERoWb89nmvBT0C4Imn3QZYFdmi65BnQSI0yXkfydWWAvJ58GCUcB+jloo
 9LeCxqXaSlgVW3Vcq8GU65uulQGQgQ67pI7AZYyaS4bjrlpMx+p4dCv4YRGMV1ltVzPrgy5T97D
 alo3bBpuNA2Hlre66ocgl0AapVhjsY+XsxHubUppVBtv+9WWCk1pR6q3jZjdFrmrJaXAfVMkKvo
X-Google-Smtp-Source: AGHT+IEwHF/GiXpZNqHBRR9xTxHtPNUxgldoL2RqzeCqOq0dsseWOmLfdGygDlEe56B7fOhMCmUNQ60vq8VMrSBVOzU=
X-Received: by 2002:a05:690e:14c5:b0:63c:e930:e37 with SMTP id
 956f58d0204a3-63e1604f30amr39006d50.0.1760617386581; Thu, 16 Oct 2025
 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <4b686af261024bad91bf079a098976de@huawei.com>
In-Reply-To: <4b686af261024bad91bf079a098976de@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 13:22:54 +0100
X-Gm-Features: AS18NWDfwEe5i76U4GBkkONd_DMLp09zKNqd_bkq6OHHw8UQjDF2NiQzQMO5RYE
Message-ID: <CAFEAcA-CdCSD36azVc=7EVKn2jgXggOa8Rt-Gvnqnyebwbx6eg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 16 Oct 2025 at 13:17, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> > From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> > devel-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Peter
> > Maydell
> > Sent: Tuesday, October 14, 2025 11:25 AM
> > To: qemu-devel@nongnu.org
> > Cc: Salil Mehta <salil.mehta@opnsrc.net>; Marc Zyngier <maz@kernel.org>
> > Subject: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
> > kernel in cpuif reset
> >
> > Currently in arm_gicv3_icc_reset() we read the kernel's value of
> > ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly works, but
> > we're actually breaking an assumption the kernel makes that userspace only
> > accesses the in-kernel GIC data when the VM is totally paused, which may
> > not be the case if a single vCPU is being reset.  The effect is that it's possible
> > that the read attempt returns EBUSY.
> >
> > Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1 once in
> > device realize. This brings ICC_CTLR_EL1 into line with the other cpuif
> > registers, where we assume we know what the kernel is resetting them to
> > and just update QEMU's data structures in arm_gicv3_icc_reset().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I've only tested this fairly lightly, but it seems to work.
> > Salil, does this fix the EBUSY issues you were seeing ?
>
>
> Would you be absorbing this in your tree now or should I make it part
> of the RFC V7 ?
>
> Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Salil Mehta <salil.mehta@huawei.com>

Thanks for the testing. I'll pull it into target-arm.next since
it does fix a potential issue with the current codebase.

-- PMM

