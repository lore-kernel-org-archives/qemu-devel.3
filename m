Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0F1E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt6ei-0002VP-A1; Thu, 19 Feb 2026 11:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt6ef-0002Ts-MU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:13:29 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt6ec-0002it-CX
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:13:28 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad019bb5eso996449d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771517604; cv=none;
 d=google.com; s=arc-20240605;
 b=L2W+I5q39eBLGQapyyC7SWTugJITLNNgE2c+T+lUZsjMMhWslSFYO+NxNo3rF/Qub6
 6FzVXOUmVQ2lEXxlCFI/hIxIheykRs2vGzAByA8lVjHJ7nSmqoPa/NZ3RTq22u47X3Z3
 aqPZIulF1Fn2Pn5nC3xkcZbDdxbBzSIuNc9sslsVbC24cACzFA8AaJjOIbx0yYjghF3A
 lwDGGpE0qmpFxdeC1tmiAEFGkruizFZR608xqXZJXbWvG5v5Y9kIAhQ+a8hjq2GkUXtQ
 qnWszGj6z6iSitbT842wMVXStHZMsDXMWJJd44YUBs6jpZ9VUMWnXO0uuO7BSoFSQWFq
 0rIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K+UFSnYNwT/zNUPoy2Outt3woBrkyvqJ1rDrXb7lsAk=;
 fh=R1r6CB1EzLFG6qA9Lv/lbb8sJBtnz4v/fkKb0onHZ3o=;
 b=a795Qhy+O1w7G70cA9LYnadNouMgfSXygl2UT77NlWMfyRazvW7dU6X0+yJ6NZwkC+
 ZL7HHyfVqPC9iCQQwblPYtBPkP6tiz/oV5ScvdQKVMwq10Q5MN5ZVdWel7fFbrjthe2r
 GJ7wD/4GQruxdbJf+kFkp4t4d8G4pY6ScHiLr+nGZO+Y9fzn9GyFxnzXm4xYEXIZ8zfO
 K6ZSolUXFwd/VSHrZLbQX0i4SacnYk69BhRMcAqEm8hekb95CuX8SOxVeu1/k5BMQqMV
 OU6cHZUaE0Z8nidaPFSfMwdswiiBjnr+UQikVJTLS9wcvopFDDp3bYMS4vCmMHBt6pTN
 pTNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771517604; x=1772122404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K+UFSnYNwT/zNUPoy2Outt3woBrkyvqJ1rDrXb7lsAk=;
 b=J3AKpj4QuH5eacTW4X+GmdD0+NrRU4PWyjrybKf5vWoW0hq442XD3xAWqmsPstYupc
 E9I6o/p8H/lOo8hgYdR9FTwju8AwTCk2+4aGobwzFCud1SUaZeHXMsHejdaPyImF6RIM
 Yho8HE/82dXslzek4y7APAlYfO0kB959dyHKmOdzSoHxNzLMGWTNWU6Xi0MRC85z/QQ9
 jxBtJiHuXjGsM2MeDdgHzGGPElnJpuZYX+27a0daTUtjoQMpLkOMMFQ0RfHCxlOEz4gb
 hdx1HCOVmeASY4z5QWAXngc329uWnUoV/fWYb7ShqtMWxHWOyFLMsnvXnjz2j0B2d6/v
 EAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771517604; x=1772122404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+UFSnYNwT/zNUPoy2Outt3woBrkyvqJ1rDrXb7lsAk=;
 b=NILarYn/ZCbPx9fT1xe4YbKM7ednsYrOryX8IPezh5Bte+aJTWolCx/R4PUO9dOPjU
 0++WY8BdNx0pGgpCbvZ8mvQrzBX9qixRtlDq27QjPNYPV8+3AUr0LyD5dSM2KhuZpRaS
 5Jojq8sxatO1ZVVjSNh5w0d97mnGSYReOhJpVCdziV6mnNBPktYMsyHbcB7nbUMsQ2sM
 15o+FkeQQ1qhhQ2ZECFcp55RkkTBkhTmFG31xHztWO4EZTM5deo7amAC6TqZp9qgfBhj
 I5oJahYI9L6tLXS1qP04Gla17xDTAm3e0uBXO0U/oBXlX8sQXcIqx7jbZeSPG6xIzlKN
 n7kA==
X-Gm-Message-State: AOJu0YypeAzXaDhhAdikkngTR6FQpBD+D0FEcKq8i4yJRk2qEvSXiuUZ
 PxLJEzIqD9f8Uwm+hnDZjZ+qCe2lHs8zye+sp6di56+TCelWNIYEH4Yw7bLStH59eBN30EIK/W9
 UtLJ+V0fLH6CLTArUvfhXRcbp9g9vyGVINwNR9v7rIg==
X-Gm-Gg: AZuq6aJD8DFl869g8knZhyuJn4pIOJWxh4YgYaAhp3XbzmpdtxGtFryntgnYH0/t+dl
 bIvwdZHLJKfofY2UMRzlZ7RX3G1WNo8aSGW9v/KIPMul74bL7v677e0VATcGYc54i2TClEa5qOY
 Tz3348BZUNr4IqSJVWJPzZarqOVUpIuv0Zhr0e1IsgzPZ0svPnlMNlO4cbnQDGQCApQXOm+GYan
 190MLFhANkLqNvXFMFqORQwwwIOAHVVvV8y6B4LNL+ZlZT043LZEAnu+ysdhtwT5oIXyvrMkjR0
 0/arvFBv0nmJdgu0i/Q8WsP8omaM/3xiX/7oVH2cQl2ndEREXsDI5rh5iDNAh/St51Q=
X-Received: by 2002:a05:690e:d58:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64c198c72e3mr15015999d50.30.1771517604517; Thu, 19 Feb 2026
 08:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20260219140228.407513-1-gustavo.romero@linaro.org>
 <CAFEAcA_GdkVJbgGm2j8v15PM2ijKF2hYBAUKZ2_W=g6XasFvCA@mail.gmail.com>
 <00bed3eb-579b-4153-9bc1-07347a5d0792@linaro.org>
In-Reply-To: <00bed3eb-579b-4153-9bc1-07347a5d0792@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 16:13:13 +0000
X-Gm-Features: AZwV_QgxFBD5NXHqpvafDTVt9cEI0lcuhAL5f2aqKe0Vxu6S1acjGO5YzOwgts0
Message-ID: <CAFEAcA-3BOhHZo_mD0Re5dpGpQ2=dydtSN5SxSKwywbVdhNarg@mail.gmail.com>
Subject: Re: [PATCH] target/arm/ptw: Clean up unused ARMMMUIdx
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 19 Feb 2026 at 15:16, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi Peter!
>
> On 2/19/26 11:13, Peter Maydell wrote:
> > On Thu, 19 Feb 2026 at 14:02, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >>
> >> get_phys_addr_disabled() is called from only one function,
> >> get_phys_addr_nogpc(), and from two locations within it.
> >>
> >> The first call to get_phys_addr_disabled() occurs when mmu_idx is one of
> >> the following: ARMMMUIdx_Phys_S, ARMMMUIdx_Phys_NS, ARMMMUIdx_Phys_Root,
> >> or ARMMMUIdx_Phys_Realm. So, handling ARMMMUIdx_Stage2 or
> >> ARMMMUIdx_Stage2_S is not required in get_phys_addr_disabled() for this
> >> case.
> >>
> >> The second call to get_phys_addr_disabled(), with mmu_idx ==
> >> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S), only would occur if
> >> regime_translation_disabled() returns
> >> true for these mmu indexes. However, mmu_idx == ARMMMUIdx_Stage2 (or
> >> ARMMMUIdx_Stage2_S) can only occur if get_phys_addr_twostage() was
> >> called, since it's the only place where ptw->in_mmu_idx is set to
> >> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S) and that only happens if
> >> regime_translation_disabled() returns false.
> >
> > This is true, but only because we never call get_phys_addr_for_at()
> > with an mmu_idx argument of Stage2, right?
>
> Correct, and that's a case that will never exist too afaics.

Well, it doesn't exist currently (because the architecture doesn't
define AT operations that do stage-2-only lookups). But two extra case
labels in one function seems like a fairly small price for "the
get_phys_addr_for_at() function will work correctly if you ask it to
do a stage-2 translation", if we ever need it in future (given that
it's a function ptw.c exposes to the rest of the code).

Also, removing these lines means that if we ever do get here then
we'll drop into the definitely-wrong stage1 handling default case.

-- PMM

