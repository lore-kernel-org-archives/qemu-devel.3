Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E066DF5A8B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuv7-0002t3-US; Mon, 20 Apr 2026 16:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wEuv6-0002su-4n
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:08:36 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wEuv3-0003C7-U3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:08:35 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2de831d2b20so6713075eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776715712; cv=none;
 d=google.com; s=arc-20240605;
 b=PHQHIhEGbjHN+iNg72PnjlfW0Vu9pxRAc9CfnPW9nxbr36NF6RCS7zExWNzD1FidJF
 gBiLLcmzsnpeRB+/P+Hd3bsmMTiRLlLRcNfKoz2Oe47CiN1UMl0FqVccNARQsHHkyPvK
 w7aYDmpr9Rt/0jUuYqkcwj0lDrTyyhbLUd+gOeKPlPNC7yqsmdsIXsx7u8wLmw9F6jry
 zYh8u38iR8kI9I5pOFr3eBiIAGc5CquCiZM0j5JVwsSkq9+bJgoF0rK9uN9aynRvAmz3
 vlL/RhIx+YIT0RekLR3Kews/WOSuP6DBojBlayl5/scdqMP067d2maTfyaoaFvJgig7k
 9uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pHW+0FrHcpTvNLyUKAnpzyG56r0gxXGpLjGR5xO602M=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=Y37IpRNzHpvOlaW2gQqXwptfYAyjBpwhRpmmweP6U60/PIuHtAXod+ZHLWBoyqAfAl
 dVazyIDcmKEy0ETyxR1N175+CcJPJm99sMfLyaSvnLYAZIUo5nBSaUN92ssvPRmJQspK
 wVqtyeh6J1E4W/rbpVY1cHkZYfazFsxH4frheEqhtW8ejAOGF0Fi4EDEL7IdtNSYEkKb
 30079C7hJMs71UFLet35gdpQwb0FpEl+sFKjCHaydMowUSCIeLnMjxbLTAF60U+u2Rfo
 APOravfvbT+CEyz3NiIfq8/smfUZmEfXZVeFIrYp+Ppua3y2j7+PHp+MOJFe9gHbsmBM
 6YGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776715712; x=1777320512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHW+0FrHcpTvNLyUKAnpzyG56r0gxXGpLjGR5xO602M=;
 b=E3QSTvABCpa9kB1d3pm0UaNWG8zbk8MTtdluRQGkvJlgjv1Kq21Wwixn/62EfFisrR
 emZG3U3GWrZRI7v2LgQu+8z3rXRuUIQchAD5nxHX6ZR51lKab4ZtUZFBVZrK59kEXveR
 0LaTUSTt1wlGg4rpPixuotm2PamK7u9KjPEX88Ra5QGHyenyWU2xQEUJgv/gI8Y8AeIY
 w1MrkddMVm+YPxT4pMeHpsD6tPFcQZt5WgbidlCf5t8bpBXt12esLnu8gpWPgjClEEpY
 QQ38icLpzyaNyE4tWetshzb0OrjB1Kla56PxzRkCGARFGcJ6tMsZbnWnpSJUqBG16lbE
 wgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715712; x=1777320512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHW+0FrHcpTvNLyUKAnpzyG56r0gxXGpLjGR5xO602M=;
 b=d57TIEUcV2UqIS4ATuzoi2TMeJLPlH+oHFYTv6yYm1xUe1xT5z1FnUd0oZZ6JCIoDz
 3gOPhUUEquwZfU1wSFe6W1X9b4mzYhT88ROYk0/yb3t8YhzZU45UiIfJTZkF7H1WB+vn
 BME41FX+KpuFXQxJJouItTzUrkYh6J4kIcaAwDHtFCPYGl5DmAHO4UAvauvn14ofAvnZ
 hnb1eOelinLw4SAbK/7lpuo4nkRWLzmRZs6BspMq2PWcbRKKf6yXakrLZa/+tIEKTY3j
 rIUoCstw+DsfUTD5t1jZhJ9DJF+bGQ167MkyvuDs7QVAeutVFhZUzxxAF43ywsrLI4jY
 ssRA==
X-Gm-Message-State: AOJu0YxXXlrM59j16/shmqYNS2yV8H9jZDzzWGrzx5pBlB7FA2LGAC9z
 lec87gDuKvUhFqnmVQqsbICA7AwbJaQHIXmyRTrfnCg11eNYpUVn+SQDk/Fq63W0f20KcPbBoRJ
 TK3p6UG5oMnCaqO3+jqAWJW6HuLzmZtc=
X-Gm-Gg: AeBDiesb+ANLuxynCcUTb/y5MVbYnal9SkOVNf6qdxxGdbOtIdfCUDsAiUtn7CTwJfa
 B0qkCnbhgxdYfvZu6OJKHOF1zJXaRGTm8j6Q8PZGdJrwpxkSexEB6OKZ5bB7JfucCwlJ4gXyFLp
 hMO9+3f3Cepo8+ee5UHLNMAMwiReuo+Fk/IbsFQJIGiM0T2mdz9GNh9BYoKWjQWZH5l4p07BbSc
 ssxXgd52lmKqMWIzBGvsz8bTERG5xl8CpKDj9wQ78elIUj/hWvS9FH142wWvmXxyYJielPyMJNm
 4sUvUAeT2s6lXT9aT57K2PLQlv6R+Nni1JAhtfElxEvt9TXmjiE=
X-Received: by 2002:a05:7300:b58a:b0:2d4:62f0:b2d4 with SMTP id
 5a478bee46e88-2e4786461b4mr8759310eec.13.1776715711818; Mon, 20 Apr 2026
 13:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-49-231416f76dc3@redhat.com>
 <ad98_6fvkOYJwcLM@redhat.com>
In-Reply-To: <ad98_6fvkOYJwcLM@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Apr 2026 00:08:20 +0400
X-Gm-Features: AQROBzBW6ogOcs7sALr2DzUZ6COAlGRA7yPgbJSsZo52aFYM5UT2TG_APLtwcJc
Message-ID: <CAJ+F1CLi_=jkVdgp9GGNaXLTbRQYWDz44FEiVJv8vo+xgrnf7A@mail.gmail.com>
Subject: Re: [PATCH v2 49/67] ui/vnc: add vnc_cleanup()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Apr 15, 2026 at 3:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Apr 10, 2026 at 11:19:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Add a function to tear down VNC displays, call it when leaving QEMU.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/ui/console.h |  1 +
> >  system/runstate.c    |  5 +++++
> >  ui/vnc.c             | 24 ++++++++++++++++++++++++
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 1794f1a2cf0..b3aaf3ff12b 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -455,6 +455,7 @@ void vnc_parse(const char *str);
> >  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
> >  bool vnc_display_reload_certs(const char *id,  Error **errp);
> >  bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
> > +void vnc_cleanup(void);
> >
> >  /* input.c */
> >  int index_from_key(const char *key, size_t key_length);
> > diff --git a/system/runstate.c b/system/runstate.c
> > index 770253b467b..0e1cb3b4e67 100644
> > --- a/system/runstate.c
> > +++ b/system/runstate.c
> > @@ -61,6 +61,8 @@
> >  #include "system/confidential-guest-support.h"
> >  #include "system/system.h"
> >  #include "system/tpm.h"
> > +#include "ui/console.h"
> > +
> >  #include "trace.h"
> >
> >  static NotifierList exit_notifiers =3D
> > @@ -1044,5 +1046,8 @@ void qemu_cleanup(int status)
> >      monitor_cleanup();
> >      qemu_chr_cleanup();
> >      user_creatable_cleanup();
> > +#ifdef CONFIG_VNC
> > +    vnc_cleanup();
> > +#endif
> >      /* TODO: unref root container, check all devices are ok */
> >  }
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 4d5b36a6fa8..c26b581f3ef 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -4354,6 +4354,30 @@ int vnc_init_func(void *opaque, QemuOpts *opts, =
Error **errp)
> >      return vnc_display_new(id, errp) !=3D NULL ? 0 : -1;
> >  }
> >
> > +void vnc_cleanup(void)
> > +{
> > +    VncDisplay *vd, *vd_next;
> > +    VncState *vs;
> > +
> > +    QTAILQ_FOREACH(vd, &vnc_displays, next) {
> > +        if (vd->listener) {
> > +            qio_net_listener_disconnect(vd->listener);
> > +        }
> > +        if (vd->wslistener) {
> > +            qio_net_listener_disconnect(vd->wslistener);
> > +        }
> > +        QTAILQ_FOREACH(vs, &vd->clients, next) {
> > +            vnc_disconnect_start(vs);
> > +        }
> > +    }
>
> Upto this point, I feel like there is conceptual overlap with
> what I'd expect vnc_display_close to be doing, except that its
> current impl does not kill off the clients - it doesn't need
> to as it is currently only called in a startup path where
> (IIUC) we can assume no clients are present.
>
> IOW, could we have this look more like
>
>   QTAILQ_FOREACH(vd, &vnc_displays, next) {
>     vnc_display_close(vd);
>   }
>
> pushing the vnc_disconnect_start into vnc_display_close.

Calling vnc_display_close() before all the clients are gone seems
riskier, as some of the VncDisplay states are reset. But since
vnc_client_io() is removed (ioc_tag), this looks quite safe to me.
(hopefully vnc servers will run out of QEMU process after this series
;)

>
> > +    QTAILQ_FOREACH_SAFE(vd, &vnc_displays, next, vd_next) {
> > +        while (!QTAILQ_EMPTY(&vd->clients)) {
> > +            main_loop_wait(false);
> > +        }
>
> Could we push this loop into  vnc_display_free, on the assumption
> that a call to vnc_display_close be made a documented pre-condition ?

Or we call close() there? seems appropriate too then. double-close
should be idempotent.


>
> > +        vnc_display_free(vd);
> > +    }
> > +}
> > +
> >  static void vnc_register_config(void)
> >  {
> >      qemu_add_opts(&qemu_vnc_opts);
> >
> > --
> > 2.53.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

