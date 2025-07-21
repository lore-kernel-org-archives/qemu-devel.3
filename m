Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D1C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwy4-0002oV-3p; Mon, 21 Jul 2025 16:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1udwwH-0001LK-R6
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:16:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1udwwF-0000WP-V3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:16:45 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo7439300a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753129001; x=1753733801; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1hFrAOY/afLayIsqHlCuoTIyS4m9SJm/laR3v05IW8=;
 b=BtrqHIRvpcbTn9sQ6VB0VMBk+3MK0/Aid3sYvwBOHUuo8CETV7Lg26U9at7GROXKsw
 WKQbo8+fYsv7BwAFFy3afd9u3oJDZCG8AVhowakw/FHVZ8pPQQJngx9gakpPVPzM08cp
 NjJjvJo0YwqRKctwC4aEDoENxNhiFJIbzgPcGOaCRyDt9B6IhKNTbCrAhw4znjgROdDB
 W0U3D8cpsrhnMihrAF52392q0AZnjj7+6UYYxaePmf83GbfJOwINiAncbNE8nO80Cs3F
 +4lC0dwpWudhli0jF6a4zvmzeyZ980/NlBeKSHdrp2CXEHQI6uvp7a/6HzEF3frYNch3
 C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129001; x=1753733801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1hFrAOY/afLayIsqHlCuoTIyS4m9SJm/laR3v05IW8=;
 b=CJRlDs+qlF2dBqEyDLbJuK1afOPYo2PQXgr8zyEliaRYkUp4MyH/Qnv509iJ+85V4P
 3s7SE+ejWTLZ6/rtEyX0QRgI9hGsgMcSEU63HbWPBdlGGigeNMlTC8XrLUYGnB3dN4Ix
 PRTCPKZANeBPq9fqCj5xh9tKY5KRgC0LDGC/G9yJGIf/o2U6SUGMSQ5hm3OMOxWlZ9NI
 dTchBc9ApiQyC9sBfk9SCAY0y6fMekk8/ohRkakjqKpGR7gnGfTXmWnx4zWgE9ep+uhz
 1eXopl7okdpcau4vnVQNfAo5vb3yuG782uXzcCn5bh95SebtupYl2viZWiFt8Ssjnp3x
 yoEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW23RKw2EYnDYcTxha8PUovg+7WuxMWg16bkYpum7+aI3K1Lm/nzUK4a9gJC7ti/2G2L/YSgQYO6bgi@nongnu.org
X-Gm-Message-State: AOJu0Yz+6t6Fii64Km/KUKyFuL/heIwxQlyLH8fWV2X1ntdAWBPILSvT
 UUUPyRyS1oLIOFuNSDjsprNlGa4uFOoiMr6RJjW9p6zFikpo9Acqypzh93o9UnWatpN6l/Q+rII
 anTDVdMjSiPwvIfXlPIMzPbQOmEqH3Dg=
X-Gm-Gg: ASbGncua1NPh53fM+zXaOJW9MBAu6go0pN9wvQxmlvc619J6Qb++3E4c18F7gulF7uA
 OaN9+7oYLKwxryP+GjLwr+7dVW6Y/KsVQgcHfM4kpdpM5MNn7sQ78el09s5SNPfvba1u3DO/Nhv
 eukKRG32VLcDJoe4QdHjvxy+a2WbXHLsd2YDIhYpKrvq729oP4+VaNe1gjSMCy+bZYY+AD+A8iG
 H897A==
X-Google-Smtp-Source: AGHT+IGMcLuEDV08bq6NnW+gI87WuV/LuF6GR5BESOUb0zqsbno7/eKvkflJ2NAG+XwW7hTuGqMLUUmoYDFxUdm4cwk=
X-Received: by 2002:a05:6402:354a:b0:612:d8b3:a9e7 with SMTP id
 4fb4d7f45d1cf-612d8b3af64mr10689628a12.5.1753129000560; Mon, 21 Jul 2025
 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250721181051.61143-1-stefanha@redhat.com>
 <20250721181051.61143-2-stefanha@redhat.com>
 <aH6Ngt6dmk56uMEt@redhat.com>
In-Reply-To: <aH6Ngt6dmk56uMEt@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Jul 2025 16:16:28 -0400
X-Gm-Features: Ac12FXww2PnFwUlrCmI39lGQgf-CB9dJCfOYsDWTcAPYCclkSKUqG5oJswJ0_tI
Message-ID: <CAJSP0QUjGRoT6uz7CbVxGH2ySZ4L9J3uukZKN64kRBhhqoK6jQ@mail.gmail.com>
Subject: Re: [PULL 1/1] trace: log.py: human-readable timestamp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mads Ynddal <mads@ynddal.dk>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jul 21, 2025 at 3:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jul 21, 2025 at 02:10:51PM -0400, Stefan Hajnoczi wrote:
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >
> > So tired to parse all these timestamps, when need to compare them
> > with other logs.
> >
> > Use iso8601 format as in warn_report() (info_report(), error_report())
> > already used.
> >
> > Also, start line with date, to be similar with warn_report() as well.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Message-id: 20250626195514.366177-1-vsementsov@yandex-team.ru
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  scripts/tracetool/backend/log.py | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backe=
nd/log.py
> > index 17ba1cd90e..61118474b1 100644
> > --- a/scripts/tracetool/backend/log.py
> > +++ b/scripts/tracetool/backend/log.py
> > @@ -39,10 +39,15 @@ def generate_h(event, group):
> >          '        if (message_with_timestamp) {',
> >          '            struct timeval _now;',
> >          '            gettimeofday(&_now, NULL);',
> > +        '            time_t _seconds =3D _now.tv_sec;',
> > +        '            struct tm _tm;',
> > +        '            gmtime_r(&_seconds, &_tm);',
> >          '#line %(event_lineno)d "%(event_filename)s"',
> > -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n=
",',
> > -        '                     qemu_get_thread_id(),',
> > -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_use=
c',
> > +        '            qemu_log("%%04d-%%02d-%%02dT%%02d:%%02d:%%02d.%%0=
6ldZ'
> > +        ' (%%d) %(name)s " %(fmt)s "\\n",',
> > +        '                     _tm.tm_year + 1900, _tm.tm_mon + 1, _tm.=
tm_mday,',
> > +        '                     _tm.tm_hour, _tm.tm_min, _tm.tm_sec, _no=
w.tv_usec,',
> > +        '                     qemu_get_thread_id()',
> >          '                     %(argnames)s);',
>
> IMHO this is undesirable, as it bloats the QEMU binaries by another 1 MB
> as we have an excessive amount of code being inlined in every trace call
> location. I've co-incidentally just sent a patch that would fix the same
> problem based on a discussion last week about a bug caused by this log
> backend adding 'error-report.h' into all files:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04905.html
>
> >          '#line %(out_next_lineno)d "%(out_filename)s"',
> >          '        } else {',

There is also a format string portability issue that CI has just found:
https://gitlab.com/qemu-project/qemu/-/jobs/10761777777#L2294

This patch will need to be reworked.

Stefan

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>

