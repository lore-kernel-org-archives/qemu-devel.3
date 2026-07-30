Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C85C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpNi2-0001Dh-QZ; Thu, 30 Jul 2026 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpNi0-0001Cz-Ma
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:09:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpNhz-0002Fu-1p
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:09:48 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-80dc4a68e4aso25237427b3.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785406186; cv=none;
 d=google.com; s=arc-20260327;
 b=Ql+Gej/DhB7iU77N7x/qT5OyxJ5+5orD+nDq+CfQcEhBVB+8zRsqdWhVlvCNWO98jE
 sWnIGN+SndQ6ZS7jTfHUOOqgyZJl+nAgiDNzSohPEPp5lAh3ioX58y4RnFHUmsfHHjag
 f9aFadE/mP0AKsv5q944WL5bXim80OxeU8bRF6jd62tOJzXNEMtAYIlglGUSlcYGETY7
 /Gq9JYi3aHTD2hxnoNjHsy5NYmm1xMX1LoO6XNsHj94C7tu05WrW2Dh0DFaBbCN81SXI
 apb/42dN/zpvZ90YZ/DWiHJSi0OzRs8xEm+bvWjp+N0eq0XtvoEKihiEE9ZQUV6yS0xw
 p0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rNY/v4zEMAQ+AJ7jnoA8DzRZo7RsKMsnd03BwGq9OtY=;
 fh=mVArEPsypA/bvqhGlg7JkTr9flwi5BnMwi4Vd02ZVR4=;
 b=rrzMkhW5/F9OpkXR0B/+J0yrd4PV0g6N999NGmv5d1fE7DB/APr0mY3IgVKMAzMORb
 uC/SZvwx47exVrhlMHzPnPP+RNQOHsexAuKLFcJb6mP4Vkd1nUc2hh115Tr34ARkFNqh
 8duqZUV+LI/bVoY0O+1ZuPHsBdhcvHuTClgKPx8Y+d88oyk1QYlDOkEiws41dssM2rfr
 ZVQPfonhY0/nUaCKE7UX6vsRkH/ROrHzwI89StI3LQvHHbCO7XY60Bo4e3oSTMt/wr2S
 j2WIQoAlkbdgm7w+ilhORmYRVMKXuZyH1afPIr8gw0mr6/Aqc5h/luU4DKcMFSgDPJlk
 WAOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785406185; x=1786010985; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rNY/v4zEMAQ+AJ7jnoA8DzRZo7RsKMsnd03BwGq9OtY=;
 b=SoeGKp1YFHfzh4hGLtEr8kXXhdS+CdQjJqTtdLTYidqEFk2crP0uAcNCxETIDjLYw+
 zBRIbRqoKEl5zMjCCnPqKZTBqQkJUgC8VLYhCQ/zICQd/IuSPq2R4Qvz7B687K0GQ5nV
 BEpZ7jw4CO4oSx/ETSzM2aQw2R2AMzfVyVQxhg4ZNvUTrvJKIZj9taiaA99B6snf28I7
 CwrH9gaM5d6mSVs3RiaW4/mogeKEov+nxsJRx8HzLnU1TJ1qKHPCrnV7EavMjQ2e+VdM
 JwKpekVjQuGZ3TcF7kdi9WBOLXsiQBgYDM+q42JZVgDYeUhkM+wXe/NYS2iSxwzh9Ejw
 F2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785406185; x=1786010985;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rNY/v4zEMAQ+AJ7jnoA8DzRZo7RsKMsnd03BwGq9OtY=;
 b=iUCZjt8nqiyjFZQdLEen+UQs7SGOw9rwLOrnYjlKcR81uwFEu2Ev7W9Mi54wF1crTO
 65T/EfGmuT7IVILbe5K7c+qoQ7qT9xDJia6mOkV42tzM8rqBxq8WX5OVZxZ3MY96oLV6
 u5weA48YDURuEwkXFpxDFqYcg5A4O1pf8+d+ZGG2m3KeftTpRtlGPQwYYqDg/VF6mvSv
 zajsQ4eKR9Dftsi961wUeNfOliQxXxTSaJsOC/BNOX5pGikBe9ZjK5helEQYp4nmpA06
 wYzurwQds4LNuc/HEJ1gRvaJkkTYA/2KL++9MVWVgnGvblLatqUUeK8HrM6WnKqAu/uY
 2cjA==
X-Gm-Message-State: AOJu0Yx3bPht5GYInDyaTMuUR+Rh5HHbSjheKgOu50sYlApPwgHuRPhU
 PE7A04yI5U4g4a31aV2OD4C/I6L010RbfJVHjrVEwbBOURyZoBqVRFjErPv96PVmFF5gl6jzJwb
 4mohuGwGri9fba0xcn8E+raXNVSwjo7jowwYdYUtfJqBBQehR5A4w
X-Gm-Gg: AR+sD11DiP/EAwROnypfnbgyWOeegdcE3iT9uG3UVkjOfZf+zE+Koz8RrDWGtXI7I3E
 ehCogt9Yr8LNA5JLJiyQ82scjj8IgGyq30YuPw/5kthf/nlavqOXZP/eGv0aOr6oPrYKquoSmVW
 +9p/i1ACTj9h8c8cyhWSKEzj8m/dCkcKdmjFvvNVxpalCzpTgqgPfUuwCse2vPVYLxDbEHj4eze
 fPlgtd7eIBGN7Txa75tgy/r/3Xg+MAtc4SIoUAeSMqcLUyOYERPibm30TLu4pO6qdJI8NEeXF+K
 L0h4/vZrnS5kckJTvlWyVcwOS2cvNdveg7U46I6CGKEeoPUgkJKulMKQUkIljK+VsQjubWSmGtP
 evb8+Puir0lXoW0XbnDe+7DekcVrj
X-Received: by 2002:a05:690c:6a0b:b0:81e:6cd1:5313 with SMTP id
 00721157ae682-81fb89b8128mr13477867b3.20.1785406185437; Thu, 30 Jul 2026
 03:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260630104249.2533126-1-peter.maydell@linaro.org>
 <CAFEAcA8J6-QbqAT-=kfEx2mAvkMucGJiyWC0_zMmVeSrmQw9Jw@mail.gmail.com>
In-Reply-To: <CAFEAcA8J6-QbqAT-=kfEx2mAvkMucGJiyWC0_zMmVeSrmQw9Jw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 11:09:33 +0100
X-Gm-Features: AUfX_mwmp-dOKvxqhsXBXQ36uzcpsfAGcPuG90rX4-MllnJD8NkQHRL_n9tZV34
Message-ID: <CAFEAcA_cGNhZ5JB3-13YXhptYknwiwERQDOS6RMfH17voorgeQ@mail.gmail.com>
Subject: Re: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

Ping^2 ?

thanks
-- PMM

On Mon, 20 Jul 2026 at 09:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping -- would anybody on the qemu-block side like to review this?
>
> thanks
> -- PMM
>
> On Tue, 30 Jun 2026 at 11:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > In ide_set_sector() if we're using CHS addressing the way we update
> > the drive state involves dividing by (s->heads * s->sectors).  These
> > values can be set by the guest using the INITIALIZE DRIVE PARAMETERS
> > command, which means that s->sectors can be 0.  (s->heads can't be 0
> > because the command passes a heads-1 value.) INITIALIZE DRIVE
> > PARAMETERS is specified to not check the input values for validity;
> > instead no error is posted until some other command makes an illegal
> > access. So we have to cope with a 0 divisor here.
> >
> > Special-case s->sectors being zero.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2399
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > We don't seem to ever actually check that the guest's read/write ops
> > are within the CHS limits it sets with INITIALIZE DRIVE PARAMETERS --
> > ide_sect_range_ok() only checks against the underlying block device
> > geometry.  Maybe we should?  Then a zero-sectors misconfig would
> > result in our reporting the error on the read/write as the spec
> > suggests we should.  This patch fixes the division-by-zero, at least,
> > though.
> > ---
> >  hw/ide/core.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index f78b00220b..b030531534 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -646,13 +646,27 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
> >          }
> >      } else {
> >          /* CHS */
> > -        cyl = sector_num / (s->heads * s->sectors);
> > -        r = sector_num % (s->heads * s->sectors);
> > -        s->hcyl = cyl >> 8;
> > -        s->lcyl = cyl;
> > -        s->select = (s->select & ~(ATA_DEV_HS)) |
> > -            ((r / s->sectors) & (ATA_DEV_HS));
> > -        s->sector = (r % s->sectors) + 1;
> > +        if (s->sectors == 0) {
> > +            /*
> > +             * s->sectors is under guest control via INITIALIZE DRIVE
> > +             * PARAMETERS and can be 0; this is an error but can't
> > +             * be reported at INITIALIZE DRIVE PARAMETERS time so we
> > +             * have to cope with the bad value here.
> > +             * (s->heads is always at least 1.)
> > +             */
> > +            s->hcyl = 0;
> > +            s->lcyl = 0;
> > +            s->select = s->select & ~(ATA_DEV_HS);
> > +            s->sector = 1;
> > +        } else {
> > +            cyl = sector_num / (s->heads * s->sectors);
> > +            r = sector_num % (s->heads * s->sectors);
> > +            s->hcyl = cyl >> 8;
> > +            s->lcyl = cyl;
> > +            s->select = (s->select & ~(ATA_DEV_HS)) |
> > +                ((r / s->sectors) & (ATA_DEV_HS));
> > +            s->sector = (r % s->sectors) + 1;
> > +        }
> >      }
> >  }

