Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A365C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnpP-0003oV-2q; Fri, 02 Aug 2024 04:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnpN-0003gf-4z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:39:57 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZnpL-00087O-FX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:39:56 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f04150796so12763254e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722587993; x=1723192793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ7xUJvrmKrMh/3F5RjzVaCkWqdbCmNzQj5ZkpZSBCA=;
 b=yNY5GMR3xdBE0LI42H6IRros90ycUPbN0okEIbOJiHiCWFUtpJ4I8wdedoCEpPCBT1
 K2GeG8J9Ze6cTPJPuvba2eQDHR7qDafQtN1Whz3Ha23v/Ky5UIL+WQKY6N6oTNsYn/YT
 gdZzpMEL7vGYF6BOc7gLZ5LyN6QiwUIpkjVncR55GdOFwvjtz+aANrhsukg/OOBGuQby
 rmf3+0zU0unoXZE78Gpj3blnEL+TFqmGTuB+0TaEr4Yw9fuUmLcLZCA+5SeIYNo2CJCc
 pUSuH/szlGf3yFsn/0VVWaF4t0/Cu9GOvaJhyWnWQahFkmNyNlt+RXtspKfC5CzXezK0
 /kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587993; x=1723192793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZ7xUJvrmKrMh/3F5RjzVaCkWqdbCmNzQj5ZkpZSBCA=;
 b=roem1P8xILVGhgUUyt9qdLKJRAjHprS/+XuuTX2dsNepzrVZsivm7aCfH/nbS4LMxc
 x97GBsp8I/5JtUd3u0U8yra8ahDnWMXqCDZB+NUNZ0AUsaFLS9AXMyvVeXAcAH9TXNaW
 dbz7e9beR7AfvkE6mm81Lqwa+SrWjcm4ajJB23ga5PhppQFVIVKr6oF0entkuEj6f9Lz
 pO2NOvL/9e3OpG675xNKNROZwhUBF/iVL6eASwqvRG+c7n4cl3VXSOYbSQYHvOTy1Vac
 9FEiEiFRS6y3cJkz01VHftEd6987VMTZTw79XkOFkxG3s/cAbHU6ZPiAWHFRj1ayR6V+
 k62w==
X-Gm-Message-State: AOJu0YzQuLkXVvPn5DznE8pe9gQwUDoWCN5LPqzBAap5MER68q/uYnKl
 yu814icAQkeVBZOsaV10C26NVzd5eUCbzPaZBwXwQRYt9EtUmil8BWYPHa5rz2HNmx0FrtMxG5h
 taXxzAxs9loy69IDovxJxWLunk5I8+d35IevXjA==
X-Google-Smtp-Source: AGHT+IE5eIxpJoMApVzil0kXEonYex4eb+FUYY3xGgphqmYL6QaoqdMdTwKjK3mnnfGFUp2e1JQrepwpjAUuVcXOChg=
X-Received: by 2002:a05:6512:3ca4:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-530bb3a3306mr1822519e87.40.1722587992845; Fri, 02 Aug 2024
 01:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
 <20240801170131.3977807-3-peter.maydell@linaro.org>
 <okjnkgp7cfoa53ubbkeotfanyijak7x4avhlwa3ydfwzpo2qk4@7vni4uw4ihtc>
In-Reply-To: <okjnkgp7cfoa53ubbkeotfanyijak7x4avhlwa3ydfwzpo2qk4@7vni4uw4ihtc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2024 09:39:41 +0100
Message-ID: <CAFEAcA9mLPDUx3hntXEwJ=3dD6BQiSq5Q4GeQkhW9N_seCdHNg@mail.gmail.com>
Subject: Re: [PATCH 2/5] docs/interop/nbd.txt: Convert to rST
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Thu, 1 Aug 2024 at 19:39, Eric Blake <eblake@redhat.com> wrote:
>
> On Thu, Aug 01, 2024 at 06:01:28PM GMT, Peter Maydell wrote:
> > Convert nbd.txt to rST format.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  MAINTAINERS            |  2 +-
> >  docs/interop/index.rst |  1 +
> >  docs/interop/nbd.rst   | 89 ++++++++++++++++++++++++++++++++++++++++++
> >  docs/interop/nbd.txt   | 72 ----------------------------------
> >  4 files changed, 91 insertions(+), 73 deletions(-)
> >  create mode 100644 docs/interop/nbd.rst
> >  delete mode 100644 docs/interop/nbd.txt
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2a183fe960b..dd159053dbd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3869,7 +3869,7 @@ F: nbd/
> >  F: include/block/nbd*
> >  F: qemu-nbd.*
> >  F: blockdev-nbd.c
> > -F: docs/interop/nbd.txt
> > +F: docs/interop/nbd.rst
>
> Upstream NBD has a link to the nbd.txt page; I'll have to update that
> link to the new name.  Is it worth creating a git symlink so the old
> name remains a stable point to link to (even though it is no longer
> purely text)?

I'm not super enthusiastic about doing that -- we haven't created
symlinks for any of the other document conversions we've done.


> > +The second is related to exposing the source of various extents within
> > +the image, with a single metadata context named::
>
> I'm not an rst expert, so I'm assuming the difference between ending a
> line in : vs :: is intentional and affects the rendering; but as far
> as I can tell, the rendered result worked, so I don't see any problems
> with the patch.

Ending with double-colon is a shorthand for "display a single
colon, and then the following text is a literal block". It has
the same effect as if you used a single colon and then the
normal double-colon-on-its-own-line to mark the literal block.

Some sentence ending in a colon:

::
   This is a literal block, so it's monospaced

-- PMM

