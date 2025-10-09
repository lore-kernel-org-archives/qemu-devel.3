Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D129BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lY9-0005Iy-Jo; Thu, 09 Oct 2025 03:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lY6-0005Gy-JY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lY1-0005Wd-SS
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uu7qRmbK+md35BhY3v2x9x/Lfhahdy4NEukKKu1ho/0=;
 b=eS3Lha8QAn+My5XRfNbQVZxTHccVFdM/eH39oqUi8PG1keqIJDmvbZkIzYv10iW/hKA6ib
 Hir8dpem3JhQyuS3BLt3Gl4CHGhUbucYU5P14NFfBG+XTK4dcPbv2c61p9xIATniToQuy3
 OIOuxHsjtAMq28p8RleJdMDmF/H2KuE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-v3ccITqQMT-zanXCHa8_YA-1; Thu, 09 Oct 2025 03:58:43 -0400
X-MC-Unique: v3ccITqQMT-zanXCHa8_YA-1
X-Mimecast-MFC-AGG-ID: v3ccITqQMT-zanXCHa8_YA_1759996722
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3ef2dd66so4534175e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996722; x=1760601522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uu7qRmbK+md35BhY3v2x9x/Lfhahdy4NEukKKu1ho/0=;
 b=AOzO8jRTA6za5FYUp3Fsq+q0t2XL9m/G9bvOvTBzO/st6j3A2eUnuI/5IhbMY384rn
 neBGnDlykE8Y7ZeEFGmG1sJZ3irZCGEDqssL1nc2yTVwbq/edWvqShrH7wWbnOFSDTZ7
 WyRjjkKkclIwYX9js+Ji/rE8/YR905tOwlZzWOB0OML70isvWjDl2GCmz3mJFfrDIN2N
 bzg9hgpTy2WjI7ChFY/1cSzZJcNJJGtkDrQd6TTUrVyTSOLQvLd6r0bf5GiW+3o2CXV7
 AzbNac/D+oN5uq+t48h7+Ec/K3ou5DiSxHf+06oYhbu4ApGVn71aN0IxJPgAou4V3iU4
 z1gA==
X-Gm-Message-State: AOJu0YxJpLF55ySJ4BaDKZC7R02VbwVGgBnr95mtZQeRkpYW1EGYuSJc
 eAm5CfXTxXhe+kg0XYveUIC7sbprgc26kmJetoVtB7ikFkxMR+yAs8lO0yfVR+uWff+UuiJX4A6
 ouEK9t14LHUNmHJoo86j6nb6WZ9tnYgMDlXp6vnCLuqKT6Wuonzt/DVgzix2EgX/2XnUyb8116Q
 YQzMxguDXNALriGR3cmrosAfuY2JUWG08=
X-Gm-Gg: ASbGnct/5OForIdz1eVM8JLWLoSoEfCY2wlhPFqfCI+Ptg65UZDqkNaPRIUMfLExNOY
 6W7R0ePKLhRrTQfztwQYlTQm6WF2JhwkRrZiSOIn5Hid1ImSVGiBPgOqvpmQOEx6R5cPJ7rxspD
 oRkCcGzBPuZCRkacsWOCFd/2Nho58aEtoJpqwgXGb+SlMcb2yCzuLuVusxyF2EYdnQYZRpvVO2M
 9nIH82tDBgqC2zy6UbR5YTMhOHdIQ==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa9ec796bmr46933985e9.16.1759996722378; 
 Thu, 09 Oct 2025 00:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR1GlHDJbfR+5wEajCOj/lmPCSsNZbIXeJKfsnl74VysO6/bxzsvSta71HrWm3/5dxbubX4JR11N34mhtqVSA=
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa9ec796bmr46933765e9.16.1759996722016; Thu, 09 Oct 2025
 00:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
 <20251008175811.GB181748@fedora>
In-Reply-To: <20251008175811.GB181748@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Oct 2025 09:58:28 +0200
X-Gm-Features: AS18NWAb0NV7vJoHQURU90zPIptwX1KL3UFWrIcpdXxu7ZFid3prlA_P0TcT4wc
Message-ID: <CABgObfYUa=8hp7sHm7STQMD6t5yJtdDPZ_corm++RRSm8v2=PA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 8, 2025 at 7:58=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Wed, Oct 08, 2025 at 08:35:41AM +0200, Paolo Bonzini wrote:
> > Sort imports automatically, to keep the coding style more uniform.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  python/tests/tracetool-isort.sh      | 4 ++++
> >  scripts/tracetool.py                 | 5 ++---
> >  scripts/tracetool/backend/dtrace.py  | 1 -
> >  scripts/tracetool/backend/ftrace.py  | 3 +--
> >  scripts/tracetool/backend/log.py     | 3 +--
> >  scripts/tracetool/backend/simple.py  | 1 -
> >  scripts/tracetool/backend/syslog.py  | 3 +--
> >  scripts/tracetool/backend/ust.py     | 1 -
> >  scripts/tracetool/format/d.py        | 2 +-
> >  scripts/tracetool/format/log_stap.py | 1 -
> >  scripts/tracetool/format/stap.py     | 1 -
> >  11 files changed, 10 insertions(+), 15 deletions(-)
> >  create mode 100755 python/tests/tracetool-isort.sh
> >
> > diff --git a/python/tests/tracetool-isort.sh b/python/tests/tracetool-i=
sort.sh
> > new file mode 100755
> > index 00000000000..b23f3d48448
> > --- /dev/null
> > +++ b/python/tests/tracetool-isort.sh
> > @@ -0,0 +1,4 @@
> > +#!/bin/sh -e
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +python3 -m isort --sp . -c ../scripts/tracetool/
>
> I wonder why python/tests/isort.sh doesn't already cover this with its
> `python3 -m isort -c scripts/` line?

Because that one is for python/scripts. Not sure why John placed
mkvenv.py and venv.py in python/scripts, but the potential for
confusion is real.

> Also, why the --settings-path (--sp) option that python/tests/isort.sh
> doesn't use?

I honestly copied it from python/tests/qapi-isort.sh. I think it's
because python/scripts/ is a subdirectory of where python/setup.cfg
lives, but scripts/ is not.

> It would be great to have just 1 script that runs isort on all Python
> code in QEMU.

Yes, there's lots of room for cleanup there.

Paolo


