Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90077CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIgm-00088c-Q9; Fri, 08 May 2026 06:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIgk-00087R-Fy
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:44:10 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIgj-0003VA-0G
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:44:10 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651c366f7efso1920551d50.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778237048; cv=none;
 d=google.com; s=arc-20240605;
 b=AoC2ImY6IEEcrWzS0DMhR+nKTRxB5OCx5A+t+h2JoxXAolKeIgnjv1spdDP83kl8Jh
 BObotsLuLtsFE/yl+vgPlLCvWPmfeB6amBfg8kkzwGeZK8bw8UescqvURJlMQLd4WN5B
 z4be4kpDq8mLftT/35v2GLg9ewCmHgtUJJQkzyFSfvuMXMH9LpOnRvlLYl8yfFesrJ2q
 VkuedDG3RZDfCi1ncLwSFD+EUIUaNDbksEs/Gblap174UfrBZXgWydklik3qhCHMmCyU
 OU84YOCzdZUoKHmwj7kEqx+Eq0gAfVNG4/b+zOrdPYfvBziZbRb9K5WVpGG8fegNPjxp
 vLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jGWKNNaY2he1+OAk8UU5BKpsejykVMLHr9b1dDxVq3k=;
 fh=prLES3L5uNBSjub+BAWAqJlsD1FH8T+rF5e8GIvqDkM=;
 b=Bll4hvRmS8pKEeSq6dLVKvZlwzF0liteRvxz2UP0SP9HeZ0LaN0LoH10R4SJ25DVyn
 PIm72xC8/8j6hj5S4vSYLkTSgcE8UQr945Z82PDh8bICeLya9XEcslO+IklYKpncRmDt
 t41ZvY09wnhKfFiQ3aL+2Cy4W4toW3NdrzBTTJNC3ZG38eooFpGbLgFI212Jzuqv6H6e
 JVG9usvIz9k2Tn9FQISr26v5ZUJO3lVJfO3fN6KP9U6E1wQsnVTuTMCtWE9vPGdoXE9Q
 EyMk3MbUhGKA6vxN+CYTByPSclOQvpuCRKsu79qUf3MubUqZsffaAad7m9FHBILgH3x2
 adfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237048; x=1778841848; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGWKNNaY2he1+OAk8UU5BKpsejykVMLHr9b1dDxVq3k=;
 b=BjgUp73HgUqMwKJkAVA5ZBc+3aZJRjcn8FzvDWXLeDCdbIjvaVBhWrRlR0mMeltAli
 awIqwwqI8KTLvyaII0XBUoWD11TQgPIF4F0N145pQMOmOwkKMLVXfbcqPP/WaXWl74DZ
 4lvndjBDdXVt6aQPI7/whePnTiN60N+IkgzB299cLXs4j7Co0mId+MpZ/8J5G7lwkzbQ
 3HFca8YWj4C53xZ/3wEX0giBhXR+/HPLKldLoitNrEguxtXFwJ2vXX5G+jBaz10rTLmM
 HiBq0w/boBMAtcXw9wKnOen0Zb7HB5b/7d270C36Zexz2mjlURDOFEwuVPh2Bc6l1DwU
 6QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237048; x=1778841848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGWKNNaY2he1+OAk8UU5BKpsejykVMLHr9b1dDxVq3k=;
 b=D26iy1YauP5PI8AxOvFVKo62V70KWhgGF/wIWQrwS8g+wfjQrsGCrUG7ulYdI1emHN
 STVEHb3bX5H3yL0dX0gfKqOCw/beMfzXUOU6kxzU6l1CU06Q4PVgSdbfhtddAd8lBcmd
 bGmBFhgmHQNbg56rw+Ns/BSLmbuEQpcFM7GkBbmi5+nbJDMvpD2dybmDvO4XzMsblqaO
 4egTSSBcTr+LoOUDsPgROdgoXc9HHwu48GBfG1S+F3FaGiS+51fX8y9zFsGfZbhossb5
 ZmgITJJWHbvS9rJp063nx4NmE0qC8LQOwyrbtYi3lAO29HQH9XS+BsSnAre69F8ziVSL
 Da0g==
X-Gm-Message-State: AOJu0Yx0/2LM0BioTQZUPFBxaVzMmaa1nShMLAe1ZUFUvT/ePNDL9C1g
 3bazb8ZHK0uahWKdJfRoxqidlV0OUg1rbt5hfl27Vx+Z7ORyz591quRrXsC9U0Li07Crw4F023E
 1fREoGjepzUGH0CIXRiMLL6zYfEl1xKgTQb0KAJ0znA==
X-Gm-Gg: Acq92OGTrWam/U35qEbJLYZio9KJ06X82GV0M5dfyceX3Sdort5t137ahRNeh45tcIA
 c4KeGggFTEibjjpnF/TyimWdx8BJ8I6eSHgy52zqGgJ9EKMjn8wVCeUeHAw4PyITnf9Nl+xfTQ7
 foDk2Pog/HdczpBt/og9vKAgMT036EMqBZ5/hArjdHJmtO6x9xvXcMJgfD/6Zzpa4uxO3knMIri
 xzcHNNKWcHlnnG9U4DPQIxKb6EZh3WSxDlVDE5VPJx1y6kRHwqTl/YtWxobow3AtHxfa4dURuh1
 oKJInVOO5WKji/9wCx0JYmCCsWXN0rtXYl/a8demFaxa403qQbJHTkDf7oXjYjCzhjc=
X-Received: by 2002:a05:690e:d54:b0:65c:bfe:80ed with SMTP id
 956f58d0204a3-65c79929d84mr11445585d50.27.1778237047627; Fri, 08 May 2026
 03:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <CAFEAcA_Q-ad3r6kV_7tUJA0maTntWELOMDYgL4aDh1AQ_p2_fw@mail.gmail.com>
 <af28e_ZXCJt4BSwu@lent>
In-Reply-To: <af28e_ZXCJt4BSwu@lent>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 11:43:55 +0100
X-Gm-Features: AVHnY4KpO3rWA4TbtgRL2M_i4A_jghUUGcrdNp320ghBdsM0ztioGvN5lF-IFlY
Message-ID: <CAFEAcA904wgCAwsG_vJvo5d2dyoXLVAbJf0cJr=Je=HH=GjFWQ@mail.gmail.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com, 
 clg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 8 May 2026 at 11:35, John Levon <john.levon@nutanix.com> wrote:
>
> On Fri, May 08, 2026 at 11:31:13AM +0100, Peter Maydell wrote:
>
> > On Fri, 8 May 2026 at 11:27, John Levon <john.levon@nutanix.com> wrote:
> > >
> > > This subsystem is no longer seeing any development, and the primary
> > > contact listed as maintainer has confirmed they're dropping support of
> > > it altogether.
> > >
> > > Signed-off-by: John Levon <john.levon@nutanix.com>
> > > ---
> > >  MAINTAINERS | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > If there's no longer interest in it, can/should we list it as deprecated
> > in docs/about/deprecated.rst, so that we can remove it once the
> > deprecation period has passed ?
>
> Can you suggest what section this should go under? A new one maybe?

Yeah, we don't have any existing obviously relevant section, so
I would create a new one "System emulator features" (with the same
"-----------" heading level and just above the existing
"System emulator CPUs" section).

-- PMM

