Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442EAE9A75A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zB0-0004Jy-KG; Tue, 24 Mar 2026 06:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4zAy-0004Jg-AN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:39:56 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4zAw-00080F-6G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:39:55 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so4635441d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774348790; cv=none;
 d=google.com; s=arc-20240605;
 b=ftdOVWxBh1ky77GMaagrPnTO35MzOSJoQBjnEvWp0dINQ3pWJkVqMX1SAy+K9nTx9z
 1SfbTYRQWn4KgwAinH60FVCVrsGF1QJ5j4QHLzgDimligphfCirbhB71izzb0v02JavD
 lDGE+CJ1PhXKsrRcLa3O+uCkNTz4RFOE8AsICgGS6/2vyI5gmIEpILb33m0SmdIqzhga
 LMVT+0JaBEaMr79hpmLZrArHgWwOnDPT06j9eJwl0CVCeiIyh/B2ZasQQt7go52Y0Cg4
 kpaINih4H9zgVIlQN5NHVlYuAgG7LCBP6cDR2CqGYfbVfeatKkab53GnlyCERDmJ1vED
 Jx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cew/+vmTaGE8VFgZmpz4wioo/nNxu9Z1P4xF4vN+kbY=;
 fh=PzbTjfSh5thByvES80y7/ymjUitiQ4VIxw4ZoPURAB0=;
 b=fxETBI3ub5Vx35fmaIiCyP82KOUErtJrxE7eo4Sb/9AvduWYopLXegwqe3dA3mKvcx
 d1SZyKQJ5lwTwJ+i9B+NJC7wp8Cji/4pYLfvfiIth+/FlmDTCfw8mAV1h40+VBj1tTvp
 37e1qgm2NEzYiCuQyiGQkHx23auE3R4sWtRlhQasNGeziZ6uPqDxF0mcqrilKtnojzfE
 /JdUEeeJDS/64NWFdxGQROh9FC48tNecadr44hVTHZ+UaZ0q68xKvJX+Y7f/0XoVpV9v
 oIURachHIH/pRelXrOUpASvD/LDhmioJynIbgFICmz//HphNccL3KM2DutpjYR4zZcpu
 BOJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774348790; x=1774953590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cew/+vmTaGE8VFgZmpz4wioo/nNxu9Z1P4xF4vN+kbY=;
 b=AMYosSrYsm6RYNz1QzLLQqirGGl2iFUOQEFuFtVlauaysS6yF/ENmUiWt0JlLWJPU7
 +YvBi9Il5uSccWJE4YI/Frj15Kg8GKufBrfNlpp6Gm5VlCNXdknVypI/fd3wdqzGkdc8
 4ElRsld2rWslrfjLEnfxWRpJWfZwsCMYH7Fvz9/Jqk6bB220IJqxUhkzYGUdy9X1PC5G
 er1JLiviOGb3+SI6p/GQ3vm0WZ8IHVP9OEVzKUFApB749jZ3CnYYdEVUMxl9y0HXhUkC
 y5bjGdnaJyKeOaAXM4wy7iNUceNaf+K3kQ7UdZkcCntX+qy6fQy9Mu/eYsbSwckXcR0E
 HBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774348790; x=1774953590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cew/+vmTaGE8VFgZmpz4wioo/nNxu9Z1P4xF4vN+kbY=;
 b=YCrEhD3zGzdvGF1VXtEDf9GXsXU7xOpzTobidv2Y++Q1yIooM6O7i9BIOuVAHqug00
 nrlZRQ75EPyYHnHR4AYfY+T7SlMNLcPmbWmvU11XWnSMGhksR5+9sVWcEYmb2iOpmNi5
 hjM9/ZnhWswXuxMiDLe1N9ieWUnDu5viS6TgYmGx1VZkrZ1ZN/nikG+I3rnLGRzKc5xQ
 NeXlCGa63VrYuy+SAwyGNbE9UbEGs/CKrXDB+oTfdJIUwKLFJGUs18ZETUKawO8Kkic8
 TOLJLANHhOd9yf5GioGp6C5F3BAPfSDk/DNbsA8Ts13gE3Um66q4DkeMQVBCnh2WsCR2
 UVkw==
X-Gm-Message-State: AOJu0YyBVIdldvTAgRw7dRHqA11CCGHz7qgZjbAFWgegWM0urZKq18ss
 gKB9Dh5U7B/Iq6a4q1h05P079XY/geyD5p/k1FWVkAzJGK5IdeVmWbs0mg3EAzuXtGc6XNfuHiI
 MuJLp2kgDFYjhH/gzo8e0mgRgVtgILxN/tzx4wujjjwga8j3j1uQUxoQ=
X-Gm-Gg: ATEYQzzZK5l4k7XVnb78RROHagcLjYZgGClfbhJxtwMbHqoVdx2A0sZwFdni1xIMPc2
 efUW2kUNrIPVU+Y1wlr1BAXscd2tdlzCJMdK1f0uCiCdkfphJDCZMEM+HHylruku5z3gxS+Hh90
 yLyC/ubwfDt58eV8j3IMZer7wmbYsRDxcru0V3YKdOComOdmSj+vZMnK+1bHCRSA9yP3BHbFrk3
 IFvUtEsk3mPIJGG1aLd8LBeNck8fPOP615vplg0FGU0u+Hl/kNZdgaJ9W+J2wcqkSD6O9F5Z4q/
 OHKqIuUSOfAbxIQ6qYU8L5A74sVD6ky1F5xSBB3/jl00q1jr0hvnK8Ip/e6zYyNBQkQ=
X-Received: by 2002:a05:690c:4b8a:b0:79a:c2a1:92dc with SMTP id
 00721157ae682-79ac2a197aamr31244707b3.29.1774348790327; Tue, 24 Mar 2026
 03:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
 <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
 <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
 <a38b768a-3a80-47de-8a03-11faf2b85526@linaro.org>
 <CAFEAcA9dCKF0H=MkNmOmxnfyJV+SeHk_tObL558MJ-w3w8aQSg@mail.gmail.com>
 <dedd88a2-cdc0-4f0c-bbf5-69751b9cd827@linaro.org>
In-Reply-To: <dedd88a2-cdc0-4f0c-bbf5-69751b9cd827@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 10:39:38 +0000
X-Gm-Features: AaiRm53vil19QVXokcdKKcyCDoFxF0lruCsaWL6KcoGm9puj-bWOS7BlJWd6zks
Message-ID: <CAFEAcA90VH+Y24KArRgzQc-jeSRUDhpWuj9jz49sdcra6mGvBw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Fri, 20 Mar 2026 at 15:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/20/26 22:23, Peter Maydell wrote:
> > On Fri, 20 Mar 2026 at 01:15, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >> On 3/19/26 22:27, Peter Maydell wrote:
> >>> I also note that for the data structure I am fixing, we never do
> >>> an xsave/xrestore on it -- it is purely junk unused padding.
> >>> The real xsave/xrestore info is elsewhere, in the dynamic part
> >>> of the signal frame.
> >>
> >> That is an excellent point.  The structure you're fixing is never really used.
> >>
> >> It's only use at present is to be included in the ia32 sigframe structure, and is only
> >> used for padding.  As an unintended side effect, the alignment of X86LegacyXSaveArea is
> >> inherited by sigframe.
> >>
> >> Perhaps we should simply have
> >>
> >> -    struct target_fpstate_32 fpstate_unused;
> >> +    char fpstate_unused[sizeof(struct target_fregs_state) +
> >> +                        sizeof(X86LegacyXSaveArea)];
> >
> > I did consider something like that; from the commit message:
> >
> > # Replace the use of X86LegacyXSaveArea with a set of fields that match
> > # the kernel _fpstate_32 struct, and assert that the length is correct.
> > # We could equally have used
> > #    uint8_t legacy_area[512];
> > # but following the kernel is probably less confusing overall.
> >
> > Either way works, so I guess I don't care very strongly.
>
> Ok then,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; I've applied this to target-arm.next, unless anybody
would prefer to take it some other route.

-- PMM

