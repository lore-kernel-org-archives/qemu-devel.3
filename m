Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91D2C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 23:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVgPy-0004iA-95; Thu, 01 Feb 2024 18:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVgPx-0004hr-1Q
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:24:25 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVgPt-00021b-Oi
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:24:24 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3702cb6537so7915466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1706829858; x=1707434658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBlTQ/xeGkSdYVv+N7YgZMF3hd5Py1MvxtlztLBJhR8=;
 b=KhKH19srnpsclgz6Lar85CfPWvipVQJf7NrJ6UWzORNrqsXsTsTBWq25snmiA0SPP9
 HMucQOIYvUZUxUfmcIt5s/F8/j2qfuqOMNsPN/GL878AA8BO69apKKdGRWgCazq+mssv
 vTtVbu/TyJiAULplN9uhDq+dTU99uCGvinIJW3i8heiCo1BHapK73rbWVbzIl2vdX1q7
 IWfc1F5Xm6vDhcmIIqwzG3eAAwzY1nelRWRgt2NgZLtun/Lz+5wg+ue8G5wAxHOq99uW
 6zxx/7XkiXrWw4Jp3xF95MrLE6RFXh9RRLQ2vA8AsShVTcQ+2ZaKngjndiYOQlxDV2Lx
 Drqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706829858; x=1707434658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBlTQ/xeGkSdYVv+N7YgZMF3hd5Py1MvxtlztLBJhR8=;
 b=IxGGDZfmuSHauES9rPffp6wk1vTMaIuRVO+SJsK8YZbQ6wWF2eK7oDscZ+GeO9NVr2
 7cz8I1H4ChrAbn6hZOf9aLY6blRdsn1BCub3YX2eCxI0LklLWh7ybD262lcGo4B+FR1l
 v0p5HZBT/Eu3xnTazSVa7ofeLcMBJ8/tpztUBH8+kWBfmA/Xc0OoIQz0MnCzJkSGtBAS
 5OAF0KCian7Oq3qHXnlSD6AXLxu+c0s+VgVWiUxRJ1kGcF0HrjQ6edgGc4eCE/5iI8Ig
 IH4UpfZbuOdeZZPg/DM949v2Jayj6acsXIWOhhuMliYc2RLgvZudQcUzbCsgK3Z1+ymJ
 5vzA==
X-Gm-Message-State: AOJu0YxDFg76tLlWoVxX+lt75vZrXtkLhLy8pQpIMjDXRqkM8j0ASbMW
 curnccRMR4jUllXOPmlMcAc1tgH3O7T80mH6HHTCc3uPIoXoldQg1vly7GJPymV8SmAA2ELAZZp
 bZxsWbGn7t4VoQiLi4eBVFS4wPQajx07AWdiYEw==
X-Google-Smtp-Source: AGHT+IHlS9/hU4binBqPgEJGQWpv7LmaVeI6APixpFjFyO2rWiyqKOUks6ZyP0AKziQK/JXuJIb285NN9XkvZesSLNI=
X-Received: by 2002:a17:906:2455:b0:a35:9ebd:f6b with SMTP id
 a21-20020a170906245500b00a359ebd0f6bmr2565695ejb.58.1706829857793; Thu, 01
 Feb 2024 15:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-4-hao.xiang@bytedance.com> <ZbsqmZj-eHlSkXVY@x1n>
In-Reply-To: <ZbsqmZj-eHlSkXVY@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 1 Feb 2024 15:24:06 -0800
Message-ID: <CAAYibXjQUo2+2M0p1=+JimS4288_G-zjoRq92MbQsuvA3Hn+qw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 03/20] multifd: Zero pages transmission
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 9:22=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 04, 2024 at 12:44:35AM +0000, Hao Xiang wrote:
> > From: Juan Quintela <quintela@redhat.com>
> >
> > This implements the zero page dection and handling.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  migration/multifd.h |  5 +++++
> >  2 files changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 5a1f50c7e8..756673029d 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> >  #include "qemu/rcu.h"
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> > @@ -279,6 +280,12 @@ static void multifd_send_fill_packet(MultiFDSendPa=
rams *p)
> >
> >          packet->offset[i] =3D cpu_to_be64(temp);
> >      }
> > +    for (i =3D 0; i < p->zero_num; i++) {
> > +        /* there are architectures where ram_addr_t is 32 bit */
> > +        uint64_t temp =3D p->zero[i];
> > +
> > +        packet->offset[p->normal_num + i] =3D cpu_to_be64(temp);
> > +    }
> >  }
>
> I think changes like this needs to be moved into the previous patch.  I g=
ot
> quite confused when reading previous one and only understood what happens
> until now.  Fabiano, if you're going to pick these ones out and post
> separately, please also consider.  Perhaps squashing them together?
>

Discussed with Fabiano on a separate thread here
https://lore.kernel.org/all/CAAYibXi=3DWB5wfvLFM0b=3Dd9oJf66Lb7FTGoNzzZ-tvK=
4RbBXxDw@mail.gmail.com/

I am moving the original multifd zero page checking changes into a
seperate patchset. There is some necessary refactoring work on the top
of the original series. I will send that out this week.
> --
> Peter Xu
>

