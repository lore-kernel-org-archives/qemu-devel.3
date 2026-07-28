Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D48C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofRi-0008R1-I8; Tue, 28 Jul 2026 06:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wofRg-0008Pi-Vl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:54:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wofRf-0001ZN-53
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:54:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so153481166b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785236037; cv=none;
 d=google.com; s=arc-20260327;
 b=Oj3lKMES2WzfSWCiiVfgJae+T+0q0XMjJeQIxSaO3Sjof6kN9LC+L8YJR2YcA3722z
 AzjRJvYzTnHGKGOnyr6UrTmJlw+X1FlIa0sXmp79Ovi14N38U0RhVfF51JHMsjSup3D+
 SycbYKb6w8rI/m+N1cQVwxTeg8G6e3TbCsa28NfwxfpeHFVFkf8imWXqZyC6/dST5mHf
 MPFqTmoCOW7q40HM84gDd6xrUGRz0Vwc3riYOp+arcFdPmLIWa53z2NMHp5eRqPzHkEX
 3HthL29I2ao350y2rHW4FHnTLK14FKmQbaCL5FWQb060C7JME4BlVpokdDEb35FyeJGa
 yCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CB264p/AqqELwUasp4UlJr7Ar3fLjUbzIFbSsqhWT8Y=;
 fh=7eAwecYj/Uvlsf4omIcrRH5txg5yMwJdWSev9+zlqx8=;
 b=WqsqdtboGjYpo6NGIsmENYgNSAlq4+GPz0JMJhFovhcja/HO03VQmUvPzBZ0nctHlq
 rtJO8U3nWqt722R5vbnVzFp5zg58WRYYDixSiz0LmswZtfcIG0fplpLhfWEPh/eqN/Wv
 xC/V4bM9FY5sJ6UwOZApWNM6sFOPkIDpul//8fApwheQoZWNErbi5FUaMIOqrwu3DSF3
 ZEtOKJJ+Yb0eh32lnt6lQCBm0yUAJuRpQytxAPvPSFPSdsCq6P3q5rPpN70T36aYoFlx
 OesZT5GLPkYas4ffKYP98IoeNnPaj4W6C8nJWoV1lSF65ACWDgtKeAoWvPlkxNvBtyxC
 I5Dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785236037; x=1785840837; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CB264p/AqqELwUasp4UlJr7Ar3fLjUbzIFbSsqhWT8Y=;
 b=YcopCZcUjRkNrRtFUDMR+nM7GVFfiOU+fPkK4JPKa7hbYgmhr0pqrKXOo+P1gSSMRD
 D2BXysRHmZMvN9vtcTrBA2Q/dc0imh4ryvshJkWSy2lBpzmeSzTL26d8ZdMLDe1tAQb9
 yXejimArFBqySEk+75kMShhCe4EFdbdDiDASs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785236037; x=1785840837;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CB264p/AqqELwUasp4UlJr7Ar3fLjUbzIFbSsqhWT8Y=;
 b=a1DMWW+9OIK6mp3m8IOh9AGTdxyckwjbV1ECEd5Ijl96tGLIt/UFu1KDCUGT6+uLGy
 tpTxaXudqccvgb1WIu06sztM+mlfquC8Cvvh++6w+AqLAL3dApu2Slz3rb1z15X+hui3
 ch6axXgOwdEfmP75bK4PBTJ+DfsEWxK7w6KOlkGupHstx3d9eEaIeP80Hc/DK/vjNiio
 u+OthvrBzoYKJU5MAAhJaLAor3z8zlE2kG7rZlbWJdZYMfeQPvXh/mJX2Os86iGpvhbh
 JmnPE2YZ4E18fL6ha8Eo23ZKWDrQTtXh1qVO4abXCBDboDy/oo1xrEzrKwKLKOp+4HHu
 3klA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpu5Mb9zjAr2LtCbwZx68fyE+OR73vXNUsCfonfvAG+7HLdzuVXURAr+mURf2fRYbXPfdyLYu6nG6zV@nongnu.org
X-Gm-Message-State: AOJu0YwAYN8aJe+4V3oAeJuoYJvqyqL+U0/kZMZoQFuLOa+y6uwoeFLi
 SMAcNqsjhH9cSq61cIHQoCdC5YV9C2sKHBO45eMYC04pLw0x3GbNVO+xYVmKa2XYz0w+Fe6GdGH
 CX//3/WTsxxcZAxIqwIO3ETPhSAseBAJ2/kXRG/sKQg==
X-Gm-Gg: AR+sD11xx+rAGB2frcN0nyB9IgKCsprARICuvTQW1+S9WcBxvEKqme0YwA5uxHr1vMF
 AElErMiAIMT8tXL/uEvQWIGQDs6B1HYi5zdwxtlA6hyMfVca1M6Y6y3OYhmvseYvUTYlkv8oXTV
 B7tTSeHlbCrXJJddV7PJOb4cyoH+sYRUmmtZvqWojoFWU7z7a2yD9bCOVueGy9YkraW8/vZXwdf
 7jXue/bxutHAitM4A9mkTLBzNPlwx2IvyUuHXclMb+ynpwdNe4LXwUOBOhtL3MYa7QjvhbrWMw0
 ezvoxe1uJ8bFwQFR8g==
X-Received: by 2002:a17:906:eece:b0:c16:8eb:d8ac with SMTP id
 a640c23a62f3a-c1f71e3dcb0mr109730166b.23.1785236036691; Tue, 28 Jul 2026
 03:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260709084728.92862-1-alexander@mihalicyn.com>
 <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
 <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
 <CAFEAcA_gZmVZr5ixHgf9EmPHb2kBgOdenF=3JTNEzs71v+gM=w@mail.gmail.com>
 <CAJqdLrp6oi2dycW-m=zBWnaQ3nTy7cYtxUY_drEnYkoWgvGpSw@mail.gmail.com>
 <amhdtSJyGh39zq5x@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <amhdtSJyGh39zq5x@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 28 Jul 2026 12:53:44 +0200
X-Gm-Features: AUfX_mz1ByC7L68KlrY4IJ62716E-RoYaKVEPbShOFrF6fRpcpqbPuEHdIhX9Ik
Message-ID: <CAJqdLrqxOVLvGWMEhwCzAgKhA5ELu5vxTmBzz1BSAN-pgDe+Hw@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
To: Klaus Jensen <its@irrelevant.dk>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62e.google.com
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

Am Di., 28. Juli 2026 um 09:43 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Jul  9 11:01, Alexander Mikhalitsyn wrote:
> > Am Do., 9. Juli 2026 um 10:58 Uhr schrieb Peter Maydell
> > <peter.maydell@linaro.org>:
> > >
> > > On Thu, 9 Jul 2026 at 09:53, Alexander Mikhalitsyn
> > > <alexander@mihalicyn.com> wrote:
> > > >
> > > > Am Do., 9. Juli 2026 um 10:51 Uhr schrieb Peter Maydell
> > > > <peter.maydell@linaro.org>:
> > > > >
> > > > > On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
> > > > > <alexander@mihalicyn.com> wrote:
> > > > > >
> > > > > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > > > >
> > > > > > Let's use GPtrArray to build a list of blocker features and then
> > > > > > g_strjoinv() to build a final comma-delimited string.
> > > > > >
> > > > > > While previous approach was technically correct, it is fragile
> > > > > > (because we need to take care of static buffer size choice) and
> > > > > > Coverity dislikes it too.
> > > > > >
> > > > > > Note, that we use g_ptr_array_new() to allocate array which means
> > > > > > that GDestroyNotify callback is not set, so we can pass pointers to
> > > > > > a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
> > > > > > any problems as there won't be any attempt to free that memory.
> > > > > >
> > > > > > Resolves: Coverity CID 1663673
> > > > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > > > > ---
> > >
> > > > > > @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> > > > > >              }
> > > > > >
> > > > > >              if (namespaces_num > 1) {
> > > > > > -                nvme_add_blocker_feature(blocker_features,
> > > > > > -                                         "Namespace Attachment");
> > > > > > +                g_ptr_array_add(blocker_features,
> > > > > > +                                         (gpointer) "Namespace Attachment");
> > > > >
> > > >
> > > > Hi Peter,
> > > >
> > > > > Is the cast here because we're dropping the const property of the
> > > > > literal string?
> > > >
> > > > yep.
> > >
> > > Mmm. Unfortunate but unavoidable I guess.
> > >
> > > The glib docs recommend using "void *" instead of "gpointer" in
> > > new code: https://docs.gtk.org/glib/types.html#gpointer
> > > but either way
> >
> > ah, I didn't know that. My first intention was to use "void *", but
> > then I searched over QEMU codebase
> > and found a few gpointer casts in exact use-case (with g_ptr_array_add).
> >
> > I can correct this and resend if you want ;)
> >
> > >
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > >
> > > -- PMM
> >
>
> Thanks,
>
> Added to nvme.next with the gpointer cast changed to void *.

Thank you, Klaus ;-)

>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

