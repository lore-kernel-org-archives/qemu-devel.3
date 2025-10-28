Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5609CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjrH-0001hF-5z; Tue, 28 Oct 2025 09:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjrG-0001h2-08
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:35:30 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjr7-0004dW-KM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:35:29 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-784826b775aso68329907b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761658517; x=1762263317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBUt2brYVxBMTM2R5AEdWSaIVChAThtEkPIrbbzKEhk=;
 b=yADtOtplw5OWqoRoBsGEiVozWGlxqFWCLQqjiWuc1W+7QEDLXNCZn7+k7Nw8FGPK1C
 IAq9E7F9zDFz5jLbrYqEg3GND5Hui2e3hCaYWR+wuHmB1Fi7qd5394cu6PzM658j/5t1
 n5iC9L4di1WbdywT4R0FPGINHwQFLnPdStMLp8NWoA+iQ3en2NauFxntgkPkKzspgHb2
 jyaipGFenD3y0RgpsYJNwiDNaP8reXethDgZct5WSDRAk1jX7APUgVsmEgGxu41qPGW6
 wIOv8lQtsQJIcrEjDTqj/7N44Z++yMUlWKedST+5lGe1Rxit4MYaKXUKhDOlBQpa2f98
 8vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658517; x=1762263317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBUt2brYVxBMTM2R5AEdWSaIVChAThtEkPIrbbzKEhk=;
 b=Wm9f/88kck+WbVW+xGJTPd754h0L1K9xsF0sXeQQPVXjHbxQ0aivUWBiCj0OiSVtn8
 TDlwDPDpXlqBaMmMpsveJiHgfzf2Q4utql36XfWs70xbOuylZrlTmHde4OZYxHioLo2v
 64rLGwm97LwHR+YUAuRi7Fk+c65Rf3g6d06MXDTJNiUC6zY8kW1aMEv9IDQU0OzYKGYa
 PCT9unPBHURdaSlonmJRraU19RSyYXNNuPcWS42xt9GUi5KjJDMQvmEl9P0l6f3qy6Pj
 uESOUFZEUX186TbYs9Z6MBC3d/8328HqrxXO8lqaCRjjB+HaT7mCgaIyQRCXdHLdOTDz
 if1w==
X-Gm-Message-State: AOJu0YyWXlsZwhJYnsX6Xwj+FudFiFbx3Ow/JRg//X7RIjVKdNCRDs9A
 EUFcpl6+TyoqpT2woXWO9AUXBXFBTB7CFRj12zfyPn8Bm6XpeFTWC1m202RkZyGnvhEMFHjFZfN
 iNe0Ge7bu8mntGUoAJyM3FgiEHYicKX3CVrBQW+d8yw==
X-Gm-Gg: ASbGncuulB6oxQKa+N4Jqdnwy/WpYMrEFX+UWEb2ME2IaLDEHpwqr9JeHCpyIY85xMh
 fajqFHM1rxJ7/ki6ZUR7PDgsIBy33TOOmgXaQDoj0LzHM+FSCBB7jgMUABT/2NjtapLWikd0ABk
 xS8QJqsDxU5RAWxvlCkSt7fpORZCrU0bTF29XxhCSbqz6SPh3IWiuhm8GA4iLnHbGY/YGPdhQKq
 21RW2fEDgdNoXTgLGqZEqep/LcQ/zt/0YXzkP6Wu9t3rGbmCH64RgALmJzI8w==
X-Google-Smtp-Source: AGHT+IHZuuO8UNw5lNBI69ELo+rP5eurxDZrGoQVYZM3+swGnZcMjvTFkNKB0GwXXxEPRN0l75Gax2bjw0XW0jVwspY=
X-Received: by 2002:a05:690c:4909:b0:783:71ee:897f with SMTP id
 00721157ae682-78617e3e0fdmr37152487b3.3.1761658516592; Tue, 28 Oct 2025
 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250626074529.1384114-1-clg@redhat.com>
 <20250626074529.1384114-10-clg@redhat.com>
 <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
In-Reply-To: <CAFEAcA9+EyeWE0QSUhgd7+i3din8J76jnhTuDB7i9hu3x-urOg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 13:35:05 +0000
X-Gm-Features: AWmQ_bnRfhUHLmdZvaJV0k5nSQamdJZwpWQptU5C7L3tIkR91b6Shcw-r6_yxww
Message-ID: <CAFEAcA88jVL4Qwb4MEzdcqeXDjob1NZ3-k_ZtwPCgG+9U6fkNA@mail.gmail.com>
Subject: Re: [PULL 09/25] vfio-user: implement message receive infrastructure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 John Levon <john.levon@nutanix.com>, John Johnson <john.g.johnson@oracle.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 10 Jul 2025 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 26 Jun 2025 at 08:47, C=C3=A9dric Le Goater <clg@redhat.com> wrot=
e:
> >
> > From: John Levon <john.levon@nutanix.com>
> >
> > Add the basic implementation for receiving vfio-user messages from the
> > control socket.
> >
>
> Hi; Coverity suggests there are some issues with this code
> (CID 1611807, 1611808, 1611809):

Hi; it looks like 1611807 and 1611808 (the resource leaks)
are still present in this code in current git; would somebody
like to have a look at this?

> > +/*
> > + * Receive and process one incoming message.
> > + *
> > + * For replies, find matching outgoing request and wake any waiters.
> > + * For requests, queue in incoming list and run request BH.
> > + */
> > +static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
> > +{
>
>
> > +    /*
> > +     * For replies, find the matching pending request.
> > +     * For requests, reap incoming FDs.
> > +     */
> > +    if (isreply) {
> > +        QTAILQ_FOREACH(msg, &proxy->pending, next) {
> > +            if (hdr.id =3D=3D msg->id) {
> > +                break;
> > +            }
> > +        }
> > +        if (msg =3D=3D NULL) {
> > +            error_setg(errp, "unexpected reply");
> > +            goto err;
> > +        }
> > +        QTAILQ_REMOVE(&proxy->pending, msg, next);
> > +
> > +        /*
> > +         * Process any received FDs
> > +         */
> > +        if (numfds !=3D 0) {
> > +            if (msg->fds =3D=3D NULL || msg->fds->recv_fds < numfds) {
> > +                error_setg(errp, "unexpected FDs");
> > +                goto err;
> > +            }
> > +            msg->fds->recv_fds =3D numfds;
> > +            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> > +        }
> > +    } else {
> > +        if (numfds !=3D 0) {
> > +            reqfds =3D vfio_user_getfds(numfds);
> > +            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
> > +        } else {
> > +            reqfds =3D NULL;
> > +        }
>
> Here we allocate memory into reqfds...
>
> > +    }
> > +
> > +    /*
> > +     * Put the whole message into a single buffer.
> > +     */
> > +    if (isreply) {
> > +        if (hdr.size > msg->rsize) {
> > +            error_setg(errp, "reply larger than recv buffer");
> > +            goto err;
> > +        }
> > +        *msg->hdr =3D hdr;
> > +        data =3D (char *)msg->hdr + sizeof(hdr);
> > +    } else {
> > +        buf =3D g_malloc0(hdr.size);
> > +        memcpy(buf, &hdr, sizeof(hdr));
> > +        data =3D buf + sizeof(hdr);
> > +        msg =3D vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
> > +        msg->type =3D VFIO_MSG_REQ;
>
> ...and here we allocate memory into msg...
>
> > +    }
> > +
> > +    /*
> > +     * Read rest of message.
> > +     */
> > +    msgleft =3D hdr.size - sizeof(hdr);
> > +    while (msgleft > 0) {
> > +        ret =3D qio_channel_read(proxy->ioc, data, msgleft, errp);
> > +
> > +        /* prepare to complete read on next iternation */
> > +        if (ret =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> > +            proxy->part_recv =3D msg;
> > +            proxy->recv_left =3D msgleft;
> > +            return ret;
> > +        }
> > +
> > +        if (ret <=3D 0) {
> > +            goto fatal;
> > +        }
>
> ...but here we may take an error-exit codepath to the 'fatal'
> label...
>
> > +        trace_vfio_user_recv_read(hdr.id, ret);
> > +
> > +        msgleft -=3D ret;
> > +        data +=3D ret;
> > +    }
> > +
> > +    vfio_user_process(proxy, msg, isreply);
> > +    return 0;
> > +
> > +    /*
> > +     * fatal means the other side closed or we don't trust the stream
> > +     * err means this message is corrupt
> > +     */
> > +fatal:
> > +    vfio_user_shutdown(proxy);
> > +    proxy->state =3D VFIO_PROXY_ERROR;
> > +
> > +    /* set error if server side closed */
> > +    if (ret =3D=3D 0) {
> > +        error_setg(errp, "server closed socket");
> > +    }
> > +
> > +err:
> > +    for (i =3D 0; i < numfds; i++) {
> > +        close(fdp[i]);
> > +    }
> > +    if (isreply && msg !=3D NULL) {
> > +        /* force an error to keep sending thread from hanging */
> > +        vfio_user_set_error(msg->hdr, EINVAL);
> > +        msg->complete =3D true;
> > +        qemu_cond_signal(&msg->cv);
> > +    }
> > +    return -1;
>
> ...and in this error handling codepath we don't do anything
> to free either msg or reqfds.

thanks
-- PMM

