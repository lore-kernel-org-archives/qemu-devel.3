Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkdV-0007PU-FJ; Thu, 09 Jul 2026 05:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkdU-0007PE-0k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:01:36 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkdS-0001HF-1E
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:01:35 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so312759666b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 02:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783587691; cv=none;
 d=google.com; s=arc-20260327;
 b=kxxQU8AA5Vhh/9luWZLYujnGI5eV6Tju59rSv/8wS7Qd2n050vyLLfEWsHzeMOm1ya
 ZwlSozZR4FkxnEw0h+7C9pOQUlOjBZrrYwEivUDymMfKgWTyw+JFf3pMRAEK1hTaol2w
 2js7iqEAD0yAelO0V2aOlJvkijqsmhViW2YbfTfs4+/IfkS5KQ2pzXKdLk70QNxbSPI3
 03dQpb5ukI2nZqgR4cKSwqiUeoaMnWYs6j5SrcCpVLm/U4QdX3b6R60fk009kC/207Ag
 ZzND/U+XbTiQVzDjQ4+dNlZ27GcsT7bktETozoHD2cvPdOcG5DlW9efd1YuFqM5doIn2
 xhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nkojNtlm1Bi4H7UpSXZCT4S+N+I6WU3cJii6/g4vQ40=;
 fh=WYZv+RFsrAIfj1zlwKe5+05ouc6abPBDzlDOtJ5Wv18=;
 b=HygR7lQ3mkfsmknYtlRkDUKixzxQIevQzTBAZs3MtMc/IbzCLIfCVsjrlW/M3cGGyx
 Y8ODmC47efjA7pXYa3PPYijmulhGCA2JJ3QACapKnAxza1D8nyP06ND/B1sBIGtmba/9
 d4oZr8jcCIs0UXM/lyQENi8v5GzqVBW35X1eNk3S893aSF3qjHaPlRUNn/L95iuMitC/
 McbK3kPMJcsQDLbxxkL6IIw4ybSkMUS/ObSfRC7IeXz0p85aG3U5aMKrPOTvms2cPQqA
 oQUdWmgCKw9PIZPI+eJcHE8tJ2WGDeERknBz8hoBpfxuaHrtLKuQeI0L8AgW1KqdhHk5
 tvHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783587691; x=1784192491; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nkojNtlm1Bi4H7UpSXZCT4S+N+I6WU3cJii6/g4vQ40=;
 b=hYmlIFlUaIjwmFjfZLHmyGThszYARMdcVXyUEF2CIxeN8x2FDI+rHkoefNgDe0rLsM
 xeZuzwzIdlBkbLK1/pA8tVMlq+qwXxyKFef30742ObH4RaC2Ne/8yhW+phML0odnWERT
 5sTQXegXuDbnpkcpgAV5RfDx6ZC1IvfIY3mug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783587691; x=1784192491;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nkojNtlm1Bi4H7UpSXZCT4S+N+I6WU3cJii6/g4vQ40=;
 b=BlM9qNW3vSI76MUnoyRld3D0nkdAC5H9L8439ocIJyvJGbkCmB1yRgIt3aHgO9H79g
 qDqnYjmasw5DZ+t0Ggyk2i6Wsw8anhHdPS7D8Hi+3juQsggYzFjhgzNnYowQLTpSIPdp
 w3namrAHt4lmVC+SRnuaE9bGcEBKSF26tzFBPAnQGXlOgqZK53YQgDGkxes7FdU43CMu
 8xMYR3XUlfd53KM0+NQV+vnIySimNEE07TJWmYmYn8jcBf/f1jtMjA3iSSjmD/gaAKI+
 cGER+7O3/Fs/f+ZRL4dbwRHPL8fuijzQ3z0Mr8lW71xbAvvN2A0QhodHkmdJLg7pboI/
 jJqg==
X-Gm-Message-State: AOJu0YwobrL9G4vaJvtLRH+jVbfnnisG4FdR3R/BZPaQ3t5gZ5aQqMlL
 BjjvLSNaeIjRVBb1lhEAjjHDTFpp0oj+PlW12KeiilTOwRSs77TJLLW1ZKWYJPtB1U1Yi+8vVoT
 gs+X+FpGUG/MMDW82iE0LD/W3sixucM0vpX6uRFgsQw==
X-Gm-Gg: AfdE7cnwPi9fSHt/cp3pQmzd4qhy9StgInRZbyR1lvrwiQGeP9wWUMATfk+Sm3ozCGP
 pUV8fKQ8XETyol3Jkfu+MMxMKMtPCL3Vk77r/KR3roJtbMfAv+FOOdduyQZ6W0gKqiQuGwZSSo6
 3eBFzT0Q+SxRw9QDDX1mG4jVukOom9eI/+D4+MLf/EQ7cdWPh7YmsCrgf/CWxeIDQLpVj89a8Ig
 pQBtgsY7Ws3VzqwwPopOVmXVtyx6/SrNGKCU9rMNciYcfra0xZEIcDH5+b6hB6wee1a1LAWBaGx
 hGbIAK6FW4gDpsAD+U+W1kQfngl/
X-Received: by 2002:a17:906:f582:b0:c15:cfb4:6a6 with SMTP id
 a640c23a62f3a-c15cfb43d84mr263315666b.30.1783587690231; Thu, 09 Jul 2026
 02:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260709084728.92862-1-alexander@mihalicyn.com>
 <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
 <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
 <CAFEAcA_gZmVZr5ixHgf9EmPHb2kBgOdenF=3JTNEzs71v+gM=w@mail.gmail.com>
In-Reply-To: <CAFEAcA_gZmVZr5ixHgf9EmPHb2kBgOdenF=3JTNEzs71v+gM=w@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 9 Jul 2026 11:01:18 +0200
X-Gm-Features: AUfX_mw1NM0mEHYgns6tMA0VsTN3yJeqUXvqe0kgVIPRM8ZFymP9yFfNJEmRlqc
Message-ID: <CAJqdLrp6oi2dycW-m=zBWnaQ3nTy7cYtxUY_drEnYkoWgvGpSw@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x629.google.com
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

Am Do., 9. Juli 2026 um 10:58 Uhr schrieb Peter Maydell
<peter.maydell@linaro.org>:
>
> On Thu, 9 Jul 2026 at 09:53, Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Do., 9. Juli 2026 um 10:51 Uhr schrieb Peter Maydell
> > <peter.maydell@linaro.org>:
> > >
> > > On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
> > > <alexander@mihalicyn.com> wrote:
> > > >
> > > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > >
> > > > Let's use GPtrArray to build a list of blocker features and then
> > > > g_strjoinv() to build a final comma-delimited string.
> > > >
> > > > While previous approach was technically correct, it is fragile
> > > > (because we need to take care of static buffer size choice) and
> > > > Coverity dislikes it too.
> > > >
> > > > Note, that we use g_ptr_array_new() to allocate array which means
> > > > that GDestroyNotify callback is not set, so we can pass pointers to
> > > > a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
> > > > any problems as there won't be any attempt to free that memory.
> > > >
> > > > Resolves: Coverity CID 1663673
> > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > > ---
>
> > > > @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> > > >              }
> > > >
> > > >              if (namespaces_num > 1) {
> > > > -                nvme_add_blocker_feature(blocker_features,
> > > > -                                         "Namespace Attachment");
> > > > +                g_ptr_array_add(blocker_features,
> > > > +                                         (gpointer) "Namespace Attachment");
> > >
> >
> > Hi Peter,
> >
> > > Is the cast here because we're dropping the const property of the
> > > literal string?
> >
> > yep.
>
> Mmm. Unfortunate but unavoidable I guess.
>
> The glib docs recommend using "void *" instead of "gpointer" in
> new code: https://docs.gtk.org/glib/types.html#gpointer
> but either way

ah, I didn't know that. My first intention was to use "void *", but
then I searched over QEMU codebase
and found a few gpointer casts in exact use-case (with g_ptr_array_add).

I can correct this and resend if you want ;)

>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> -- PMM

