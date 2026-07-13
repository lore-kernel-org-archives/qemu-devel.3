Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF7C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDEH-0001KW-Tq; Mon, 13 Jul 2026 05:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDEF-0001KD-QG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:45:36 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDEE-0003RC-2Z
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:45:35 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-667f29dc8a4so594284d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783935932; cv=none;
 d=google.com; s=arc-20260327;
 b=H8vg0y9pBEbWQY9M+TLqeTBEHkjL6XDf272bhnIuxjaYTU6AAtNX9kytE8zh2Vso7V
 hinUB4KGhwbLmyRrVrJy3ldmjWl6gxmzV676v6+gRrkF3gW+se5DGpAa9xGsobldF/Qy
 y33EJ10kEU30Skg63XnZN1Fb3vuNpVNLnnBou/iuYTWojqeNDySu0/d0FgdYoI24sPEB
 ur+oUTAw8isOB95PU9wVMyMbDGsT3haBKHfcxFFMbHQbcDq3J5+xIw0BjAhM4BQ4p4JF
 Da5t06Do6Ni0IZLVJCCtQT8VjoFcyFKH6XnvdpD3g/wU5nWxOo2DxKXc9MgJdMYEmN9a
 7iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JthaUCckQgCMr9uXBaUB+OpK2U9tcXLXBYXNR6iKG0k=;
 fh=bMrxbIIdcP3dNETLFknNoaH4segOK4xPdkiRZAq3Dng=;
 b=UceJtBOyGEphKEYmMVGRqIq6lNoEVeA19JS4snhLGnJLjJIUvpACLgltEMWiU6VCbR
 Ls6or5pjmeCYgfQD6Y27jz92WQ/s5lrnNHXQOpNLIE0WSbkHpz4r+TkjsZu+8L/KhhSK
 JgQpMVhxMIFtfXQh9BQz4+RiHv58Rl4OL0MNaWF2aPrnMBg/tw3yFustC9ZvFmhJd7lL
 3Wmc/yu5hoiOTyuZLWZDqBnIYexi7mzxxublQz+9erZUx/zC6nv5IxPnlbbi9GOsJxXH
 yL9ia+D20MreLJYsf6LdwEKvAy32OniW9akl9Up4qVyobtMr0eKZjOalMeExKdojy/46
 efCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783935932; x=1784540732; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JthaUCckQgCMr9uXBaUB+OpK2U9tcXLXBYXNR6iKG0k=;
 b=g0kJjjfq68zLlx8iLToSJ56Oth7b+9/u8A0nxC9GeHvapwBkTvSaMrpyiPsyBuOxwo
 TolwZtCqa6U3XD2H/qtvNgAqn3ehHNjRh/+61U0y9IZxMfxGhTzep2D9ugrgD50TtIg2
 /HdAdedtWEzYKHp02vj4pBZazMzVgalwimiM6yzwlGzLID+jZ7ztZdpzwORLjiE754mN
 ufh8Y1Usj4SmMGpvsNM907tV5aw8dUMfJqksTRscU8SPBI25aQxUlS0xlrfG7UBVC/ma
 2ByM02/j3cXzWiR+yPnxdclSlW5EyJGZkFLNxxvQ1mDTicifMqYgroU1CT0mS8Ifip7I
 nNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783935932; x=1784540732;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JthaUCckQgCMr9uXBaUB+OpK2U9tcXLXBYXNR6iKG0k=;
 b=Z0/yCFuyoyMa885InPJ0+MGbAq9uBPVVzeGE747PUtf5zVv3mB+5+EwafHHhM876Ul
 Qzik70Zj+CsPOmH6r3om3Dz+FliOMZz3gVpoSWEssC+o/NqZTRqOrg5a80ztBU7+nxen
 VXjYfurx7QuTIQkAJKNpCwtd6gw1uq0XNgjedLv87ZXqGJUaUah7wVCCYU4RfJ1PyRdP
 Yd1V2BXrmxzlUw2+iDMxnZUH9wssOSjAdyqPEj0s1XxR2+KEDo8OBaRnNCCYcQ+RLgN4
 /GvkKiQoJNjUXtwLHCQzG2DcdQ+bB2Lp9wLapn1fnWsOOfMLOOaftZtaxsfP57m91xrm
 V+Ig==
X-Gm-Message-State: AOJu0YzpZj7mAMLVXj60LUTscLpkRPYuqmRaB6ZgG5EfRAX+GN5HNfv8
 0QPnnGseM6gplDsjpDnOErZi6R/7upbNS6pxG+dkJiQtkYTwWyLITUZhu0YBq3rZf83VfCFDoA8
 EtAzTiu/VKHvzKcVl52RxdmGXniRERNVMyY8ELhfqqv1uIfi72xeJ
X-Gm-Gg: AfdE7clP6TuPlDSE0+cFwFyrrmDHcdPb+EdT3j6qwtd4GJU1ct1rreOLKG6raoyk5h4
 v3RRn9/N9ur33jrKv2efrz6YPeTXtDaGOz9pzRvIZ+9Hy7asBVTsApnp7n69Ux8aFmtHbYUrjwi
 iNJXplm4Dv9l26JL3AhEm7G67YwMNnVjDU8pGQmXoOhpux+X+VHwuBRA2pLTvX2iBr88UCFiqRv
 6rYQsVLZWXYnyDxpKgLole0Oddf8dIRin9w8h64+Mbmc7OftQJJ6iwG/AaHxwcZW8SGXRGiNpf+
 oVA98w+CV5vvSGYXgsclZNDRwzZkH9pOGVNZkxGwiz9ovFKj2MLVFgQr
X-Received: by 2002:a05:690e:11c3:b0:667:f9ed:9766 with SMTP id
 956f58d0204a3-667f9ed9dadmr720360d50.108.1783935932447; Mon, 13 Jul 2026
 02:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
 <dd2048ff-9521-7f3d-313d-be2b2ff9c278@eik.bme.hu>
 <CAFEAcA83Un_7=YLHXgwUfK=kyW4LP0dptDAWZRHadsOydN8vrA@mail.gmail.com>
In-Reply-To: <CAFEAcA83Un_7=YLHXgwUfK=kyW4LP0dptDAWZRHadsOydN8vrA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:45:20 +0100
X-Gm-Features: AVVi8CfLE8s6_CPGxX-toUKovYMhgPmR6kjg01vBL2l255YrmQtAx8IkZOEEPL0
Message-ID: <CAFEAcA9HWn7VkhyV4PuuRJ=zon8qazObAfVtTpu-paYPzJnfoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/sm501: Fix various error-checks
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
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

On Fri, 10 Jul 2026 at 09:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 9 Jul 2026 at 21:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >
> > On Tue, 7 Jul 2026, Peter Maydell wrote:
> > > This set of patches fixes three bugs discovered recently in the sm501
> > > device. They're all of the form "guest can misprogram registers in a
> > > way that defeats the bounds-checks on the 2D graphics ops".
> > >
> > > thanks
> > > -- PMM
> > >
> > > Peter Maydell (3):
> > >  hw/display/sm501: Catch bad coordinates for RTL operations
> > >  hw/display/sm501: Avoid overflow problems in bounds check calculations
> > >  hw/display/sm501: Don't allow guest to set ram size larger than it is
> > >
> > > hw/display/sm501.c | 64 +++++++++++++++++++++++++++++++++++++++-------
> > > 1 file changed, 55 insertions(+), 9 deletions(-)
> >
> > Thank you for fixing these.
> >
> > Series:
> > Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> >
> > I think patch 2 should have:
> > "Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3584" instead
> > of work_items/3920.
>
> Yes, thanks for that catch and for the testing; I cut and pasted
> the wrong URL there.

As I'm putting together a target-arm pullreq, I'll take these
patches through that, unless somebody from the ppc side would
prefer to take them via another route.

-- PMM

