Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE5CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbaXE-00027t-HZ; Mon, 22 Jun 2026 05:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wbaX0-00026A-Ia
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 05:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wbaWs-0005gE-Mw
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 05:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782118876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ks8YaxAhZntV2SyGiPyq2+7OH3iYT/0pqHmPytF6J1s=;
 b=Q2nKNf4Bv0tNc7n4zhSIeVx8/V7mah2CpVCjXudEYr+FXxt1aaAdmf76ITrC5PrnLPThdE
 jrGIoY/Ct9KZC4fKJbUPAo/y3B7mFr5Y+dqlKMQVY/wh0iDnbXYxu7WHoapzep9IpDpwWI
 k/R2CTT1QkOt5l3RvM3llBGzPqtxUKM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-RT4mm2a0PJuW4Po9DEbvgw-1; Mon, 22 Jun 2026 05:01:14 -0400
X-MC-Unique: RT4mm2a0PJuW4Po9DEbvgw-1
X-Mimecast-MFC-AGG-ID: RT4mm2a0PJuW4Po9DEbvgw_1782118873
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dbe3bd27d8so78203726d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 02:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782118873; cv=none;
 d=google.com; s=arc-20240605;
 b=j8By42Pkg/Nih9rpjqlNP2I1G/8biLsIX08BDaUzk5E+VLNfXREQhr9qjN3UpJyoDr
 RHPzfuLPfCFg3gJjGWENQPzmFH6a/E4zEVLJJet2h/noOnGUbwei3PPFu6P6jaqXT5kA
 xcx+/MTn11GrKzovxnLxXvg3hgw4KXNWDfAUHmTFkau/PNxCM1DK9mZQxV75cRZ4MhaS
 Sp2sIMdjwzMa3n2QB2yvNlXouUSP0xw0QfQaM/D9CuexHFfTjPQg4wgoS2VW41xF43IK
 X4CrJX7wC9wKsGhpfd31HiniczRryqS+6Jm5g9GJSQZLFwFETahAZc3Bfe2BWeikICyJ
 kCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ks8YaxAhZntV2SyGiPyq2+7OH3iYT/0pqHmPytF6J1s=;
 fh=4gsGMJvv74SxDF4GRX2co7LD4pvMv7KcqSMFinEHD28=;
 b=ArdFPfP3qA85K/rW2nlqnCDWdXsDKHG5D80OKT6M97Bcp8kYXJp9rwpvNYTN0DnwEH
 X1iG/nh2HLtZCl5rdrSG4sPvelPWWc5xDxT5RmjD1IjNrdAhtrFUK5n7dQzhVVw1rTid
 wu02/jxBCj8wGVQw/0eqizOozy/Lat8KpnDniMfjdbrUZvqtRv9G138xPabwSwu+L7RS
 Lofjpd6VgEVyhw2rp9hEWfPCcZ/LSKcIye5bWV1lrulZ2x8sY6DIzJfpBjQQaGkIHJFe
 5VXcwl6UvoYbfFt73uKYnbs3gUlBRdM3quq/hpNBZz8IKPKCp9JM7CkLZRxOLJXsM+sx
 Fjqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782118873; x=1782723673; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ks8YaxAhZntV2SyGiPyq2+7OH3iYT/0pqHmPytF6J1s=;
 b=ZBGNUo1Qbs36VWMcKncuUJ52DnW/898s4FTKMl9iF8URsD4a9LQGbBB76czgoKsxwe
 PtDhPtpnNae+lrDiOGzXgkTn7NegebVQ4BMSPo7kIFY5PqBygO2nfwhfnYyr4mQCTCQt
 1zZRECrfQRj36Mcb1hgU3ljcIgCRLvMxTq5TC7NivHY7lNw/TBBaKMkGCuapN/fJyzRm
 EiRIZhz0PtjeekGDOrZv7FqHnBGYoUQSE2lwSxUICQLZu7upXGeD7jt04P9bGCr8mG9i
 QGQYS3TN0RUzu21K9k5roKtgGO3tZ2b0SrlVO1c+jCwWZv+TwFXAOmvxcaF9xxuaLYkd
 SyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782118873; x=1782723673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks8YaxAhZntV2SyGiPyq2+7OH3iYT/0pqHmPytF6J1s=;
 b=kzxkX5/EnLTLJp+xJ0o93V5pG1knb+Kj2QuEOg9cUBoKTZvpJKnwd9Q8MPi+TOcf6Y
 Al4n8fF6k7TdhEmelemhqs4yBK51Jmn9Oz6IlR9HtXGcSfGkBqdrQsSbZ+YN7ujEwMik
 1gCDGCpOr+oojqJEoP0F8Fx5YggNYyKcpJcQ1dB/MDz6XazjFOy0ngCFdbXCgPORiZcv
 Mazb0Gp7hlRxcyUSbwj/mlpKG7EoJ0wn0uvuyeZc4YMcx0mAxzQn9NXP0eu4D2Wb+RZ8
 9808EGZrQggk+gDtydIfVAeua4eD+MfgjbJfS5eGX1nSyTYMKO6mpMdkWB5DHFB2XtuA
 4HqQ==
X-Gm-Message-State: AOJu0YyJGvx9UUYAm4q9omMJErcww+chKY7o+zX9t1QcTG+ZP2/Sn3YD
 0qVIVrvFA5YibLPZMxCdDPYcdKu/dgXiMYc/Qq03BV4NtRJ6UMEx35BDyj/8GTEWTs/h1sKySZI
 9w/3Y823z/p+MiYwQkOM+I6qbzI2lqA6PWTmhgr1b18QsXK21SV2f7UYmamEeWcKL42KvoiO83Y
 Bg5F7kfSAN6y4FIUiaWcEZQcRULmq4QsU=
X-Gm-Gg: AfdE7ck4CKAh/nbalDln6EeZnzTk+WLj+qa3AnFtMroEjDMX2lObTjls190mgCtiupq
 L2RfDydpsZlPWBfKid3QtsW4ShfYNuF9ZioY9u6xVM5zr6ik7R/iJ5AyLtYEfNSf+heJaV5PuUF
 PrVJmG1DOI18KQcHIQqIudAs0q/JfD499M3iNco7vl4rybDDyB+vrYri1Oc1SQKCI8VxVe+Q==
X-Received: by 2002:a05:6214:62a:b0:8e1:6c6e:9612 with SMTP id
 6a1803df08f44-8e16c7ddf9amr80893836d6.22.1782118873297; 
 Mon, 22 Jun 2026 02:01:13 -0700 (PDT)
X-Received: by 2002:a05:6214:62a:b0:8e1:6c6e:9612 with SMTP id
 6a1803df08f44-8e16c7ddf9amr80891546d6.22.1782118869226; Mon, 22 Jun 2026
 02:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
In-Reply-To: <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 22 Jun 2026 12:00:57 +0300
X-Gm-Features: AVVi8CcrJS7gW0iTYxuVjWxakIRNO1G8Nspat79Bwjjq6V_6LRfSFL2N1azzNt8
Message-ID: <CAPMcbCphbipUTQm5d+A3hPJMLXVo3jBVxxzCii8axjTyQtBGSQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Denis V . Lunev" <den@virtuozzo.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Content-Type: multipart/alternative; boundary="00000000000025ec2a0654d3e269"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000025ec2a0654d3e269
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Polina,

First of all, thanks for your patches.

Before reviewing this patch, I want to ask: why is it needed?

I understand the patch "qemu-sockets: Enable AF_VSOCK on Windows",
but AF_VSOCK has the same behavior on Linux and Windows.
I expected that we could totally reuse the POSIX part, so just move it to
common with
some defines like:
```
#ifdef G_OS_WIN32
        in_ch =3D g_io_channel_win32_new_fd(in_fd);
#else
        in_ch =3D g_io_channel_unix_new(in_fd);
#endif
```

We tested our driver with SSH over VSOCK, and standard Linux SSH works
well.
So, what is the difference in this case that you add win32-specific code
for VSOCK?

Best Regards,
Kostiantyn Kostiuk.


On Fri, Jun 19, 2026 at 9:03=E2=80=AFPM Polina Vishneva <
polina.vishneva@virtuozzo.com> wrote:

> Add vsock-listen channel mode to the Windows guest agent.
>
> The listen/accept path uses the standard QEMU socket helpers
> (socket_parse(), socket_listen(), qemu_accept()) and plugs the resulting
> SOCKET into the GMainLoop via g_io_channel_win32_new_socket().
>
> Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> ---
>  docs/interop/qemu-ga.rst |   4 +
>  qga/channel-win32.c      | 257 ++++++++++++++++++++++++++++++++-------
>  qga/main.c               |   6 +
>  3 files changed, 222 insertions(+), 45 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index d16cc1b9f0..9c415fc8f8 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -59,6 +59,10 @@ Options
>    Transport method: one of ``unix-listen``, ``virtio-serial``, or
>    ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default)=
.
>
> +  .. note::
> +     On Windows, ``vsock-listen`` requires the viosock driver from
> +     kvm-guest-drivers-windows recent enough to include commit
> ``687c776``.
> +
>  .. option:: -p, --path=3DPATH
>
>    Device/socket path (the default for virtio-serial is
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index 2bd6fc1538..257576815a 100644
> --- a/qga/channel-win32.c
> +++ b/qga/channel-win32.c
> @@ -1,6 +1,8 @@
>  #include "qemu/osdep.h"
>  #include <windows.h>
>  #include <io.h>
> +#include "qapi/error.h"
> +#include "qemu/sockets.h"
>  #include "guest-agent-core.h"
>  #include "channel-common.h"
>
> @@ -17,6 +19,9 @@ typedef struct GAChannelReadState {
>  struct GAChannel {
>      GAChannelCommon common;
>
> +    int listen_fd;
> +    int client_fd;
> +
>      HANDLE handle;
>      GAChannelReadState rstate;
>      GIOCondition pending_events; /* TODO: use GAWatch.pollfd.revents */
> @@ -198,7 +203,116 @@ static GSource *ga_channel_create_watch(GAChannel *=
c)
>      return source;
>  }
>
> -GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize
> *count)
> +/*
> + * Socket mode: GIOChannel-based listen/accept/client helpers
> + */
> +
> +static gboolean ga_channel_socket_client_event(GIOChannel *channel,
> +                                               GIOCondition condition,
> +                                               gpointer data);
> +static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,
> +                                                GIOCondition condition,
> +                                                gpointer data);
> +
> +static void ga_channel_socket_listen_add(GAChannel *c, bool create)
> +{
> +    if (create) {
> +        c->common.listen_channel =3D
> +            g_io_channel_win32_new_socket(_get_osfhandle(c->listen_fd));
> +        g_assert(c->common.listen_channel);
> +    }
> +    g_io_add_watch(c->common.listen_channel, G_IO_IN,
> +                   ga_channel_socket_listen_accept, c);
> +}
> +
> +static gboolean ga_channel_socket_client_close(GAChannel *c)
> +{
> +    /* Free the CRT fd wrapper while the SOCKET is still valid. */
> +    if (c->client_fd >=3D 0) {
> +        qemu_close_socket_osfhandle(c->client_fd);
> +        c->client_fd =3D -1;
> +    }
> +    ga_channel_common_client_close(&c->common);
> +    if (c->common.listen_channel) {
> +        ga_channel_socket_listen_add(c, false);
> +    }
> +    return false;
> +}
> +
> +static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,
> +                                                GIOCondition condition,
> +                                                gpointer data)
> +{
> +    GAChannel *c =3D data;
> +    int client_fd;
> +    GIOChannel *client_ch;
> +    bool accepted =3D false;
> +
> +    client_fd =3D qemu_accept(c->listen_fd, NULL, NULL);
> +    if (client_fd < 0) {
> +        g_warning("error accepting connection: %s", strerror(errno));
> +        goto out;
> +    }
> +
> +    /*
> +     * g_io_channel_win32_new_socket() makes the socket nonblocking via
> +     * WSAEventSelect.
> +     */
> +    client_ch =3D g_io_channel_win32_new_socket(_get_osfhandle(client_fd=
));
> +    g_assert(client_ch);
> +
> +    if (ga_channel_common_client_add(&c->common, client_ch,
> +                                     ga_channel_socket_client_event, c))=
 {
> +        g_warning("error setting up connection");
> +        /*
> +         * Release the CRT fd wrapper while its SOCKET is still open -
> only
> +         * then qemu_close_socket_osfhandle() can detach the fd and let
> the
> +         * channel teardown perform the single closesocket().
> +         */
> +        qemu_close_socket_osfhandle(client_fd);
> +        ga_channel_common_gio_destroy(client_ch);
> +        goto out;
> +    }
> +    c->client_fd =3D client_fd;
> +    accepted =3D true;
> +
> +out:
> +    /* only accept 1 connection at a time */
> +    return !accepted;
> +}
> +
> +static gboolean ga_channel_socket_client_event(GIOChannel *channel,
> +                                               GIOCondition condition,
> +                                               gpointer data)
> +{
> +    GAChannel *c =3D data;
> +
> +    g_assert(c);
> +    if (!c->common.event_cb(condition, c->common.user_data)) {
> +        return ga_channel_socket_client_close(c);
> +    }
> +    /*
> +     * A peer that sends data and disconnects at once is never reported:
> +     * GLib turns the coalesced FD_READ|FD_CLOSE into a plain G_IO_IN,
> +     * and Winsock records FD_CLOSE only once, so no later event follows=
.
> +     * Peek after each event to detect the disconnect.
> +     */
> +    if (c->client_fd >=3D 0) {
> +        char peek;
> +        ssize_t r =3D recv(c->client_fd, &peek, 1, MSG_PEEK);
> +        if (r =3D=3D 0 || (r < 0 && errno !=3D EAGAIN)) {
> +            return ga_channel_socket_client_close(c);
> +        }
> +    }
> +    return true;
> +}
> +
> +/*
> + * Handle mode: overlapped I/O read/write
> + */
> +
> +static GIOStatus ga_channel_handle_read(GAChannel *c, char *buf, size_t
> size,
> +                                        gsize *count)
>  {
>      GAChannelReadState *rs =3D &c->rstate;
>      GIOStatus status;
> @@ -221,8 +335,8 @@ GIOStatus ga_channel_read(GAChannel *c, char *buf,
> size_t size, gsize *count)
>      return status;
>  }
>
> -static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t
> size,
> -                                  size_t *count)
> +static GIOStatus ga_channel_handle_write(GAChannel *c, const char *buf,
> +                                         size_t size, size_t *count)
>  {
>      GIOStatus status;
>      OVERLAPPED ov =3D {0};
> @@ -262,13 +376,25 @@ static GIOStatus ga_channel_write(GAChannel *c,
> const char *buf, size_t size,
>      return status;
>  }
>
> +GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize
> *count)
> +{
> +    if (c->common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {
> +        return ga_channel_common_read(&c->common, buf, size, count);
> +    }
> +    return ga_channel_handle_read(c, buf, size, count);
> +}
> +
>  GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t siz=
e)
>  {
>      GIOStatus status =3D G_IO_STATUS_NORMAL;
>      size_t count =3D 0;
>
> +    if (c->common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {
> +        return ga_channel_common_write_all(&c->common, buf, size);
> +    }
> +
>      while (size) {
> -        status =3D ga_channel_write(c, buf, size, &count);
> +        status =3D ga_channel_handle_write(c, buf, size, &count);
>          if (status =3D=3D G_IO_STATUS_NORMAL) {
>              size -=3D count;
>              buf +=3D count;
> @@ -276,86 +402,127 @@ GIOStatus ga_channel_write_all(GAChannel *c, const
> char *buf, size_t size)
>              break;
>          }
>      }
> -
>      return status;
>  }
>
>  static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
> -                                const gchar *path)
> +                                const gchar *path, Error **errp)
>  {
>      COMMTIMEOUTS comTimeOut =3D {0};
>      gchar newpath[MAXPATHLEN] =3D {0};
>      comTimeOut.ReadIntervalTimeout =3D 1;
>
> -    if (method !=3D GA_CHANNEL_VIRTIO_SERIAL && method !=3D
> GA_CHANNEL_ISA_SERIAL) {
> -        g_critical("unsupported communication method");
> -        return false;
> -    }
> +    c->common.method =3D method;
>
> -    if (method =3D=3D GA_CHANNEL_ISA_SERIAL) {
> -        snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
> -    } else {
> -        g_strlcpy(newpath, path, sizeof(newpath));
> -    }
> +    switch (method) {
> +    case GA_CHANNEL_VIRTIO_SERIAL:
> +    case GA_CHANNEL_ISA_SERIAL:
> +        if (method =3D=3D GA_CHANNEL_ISA_SERIAL) {
> +            snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
> +        } else {
> +            g_strlcpy(newpath, path, sizeof(newpath));
> +        }
>
> -    c->handle =3D CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, N=
ULL,
> -                           OPEN_EXISTING,
> -                           FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED=
,
> NULL);
> -    if (c->handle =3D=3D INVALID_HANDLE_VALUE) {
> -        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> -        g_critical("error opening path %s: %s", newpath, emsg);
> -        return false;
> +        c->handle =3D CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, =
0,
> NULL,
> +                               OPEN_EXISTING,
> +                               FILE_FLAG_NO_BUFFERING |
> FILE_FLAG_OVERLAPPED,
> +                               NULL);
> +        if (c->handle =3D=3D INVALID_HANDLE_VALUE) {
> +            g_autofree gchar *emsg =3D
> g_win32_error_message(GetLastError());
> +            error_setg(errp, "error opening path %s: %s", newpath, emsg)=
;
> +            c->handle =3D NULL;
> +            return false;
> +        }
> +
> +        if (method =3D=3D GA_CHANNEL_ISA_SERIAL
> +                && !SetCommTimeouts(c->handle, &comTimeOut)) {
> +            g_autofree gchar *emsg =3D
> g_win32_error_message(GetLastError());
> +            error_setg(errp, "error setting timeout for com port: %s",
> emsg);
> +            CloseHandle(c->handle);
> +            c->handle =3D NULL;
> +            return false;
> +        }
> +        return true;
> +
> +#ifdef CONFIG_AF_VSOCK
> +    case GA_CHANNEL_VSOCK_LISTEN: {
> +        int fd =3D ga_channel_common_vsock_listen(path, errp);
> +        if (fd < 0) {
> +            return false;
> +        }
> +
> +        c->listen_fd =3D fd;
> +        ga_channel_socket_listen_add(c, true);
> +        return true;
>      }
> +#endif
>
> -    if (method =3D=3D GA_CHANNEL_ISA_SERIAL
> -            && !SetCommTimeouts(c->handle, &comTimeOut)) {
> -        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;
> -        g_critical("error setting timeout for com port: %s", emsg);
> -        CloseHandle(c->handle);
> +    default:
> +        error_setg(errp, "unsupported communication method");
>          return false;
>      }
> -
> -    return true;
>  }
>
>  GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
>                            int listen_fd, GAChannelCallback cb, gpointer
> opaque)
>  {
> +    Error *err =3D NULL;
>      GAChannel *c =3D g_new0(GAChannel, 1);
> -    SECURITY_ATTRIBUTES sec_attrs;
>
> -    if (!ga_channel_open(c, method, path)) {
> -        g_critical("error opening channel");
> -        g_free(c);
> +    /* listen_fd is for systemd socket activation; not applicable on
> Windows. */
> +    (void)listen_fd;
> +    c->listen_fd =3D -1;
> +    c->client_fd =3D -1;
> +    c->common.event_cb =3D cb;
> +    c->common.user_data =3D opaque;
> +
> +    if (!ga_channel_open(c, method, path, &err)) {
> +        g_critical("%s", error_get_pretty(err));
> +        error_free(err);
> +        ga_channel_free(c);
>          return NULL;
>      }
>
> -    c->common.event_cb =3D cb;
> -    c->common.user_data =3D opaque;
> +    if (c->common.method !=3D GA_CHANNEL_VSOCK_LISTEN) {
> +        SECURITY_ATTRIBUTES sec_attrs;
> +
> +        sec_attrs.nLength =3D sizeof(SECURITY_ATTRIBUTES);
> +        sec_attrs.lpSecurityDescriptor =3D NULL;
> +        sec_attrs.bInheritHandle =3D false;
>
> -    sec_attrs.nLength =3D sizeof(SECURITY_ATTRIBUTES);
> -    sec_attrs.lpSecurityDescriptor =3D NULL;
> -    sec_attrs.bInheritHandle =3D false;
> +        c->rstate.buf_size =3D QGA_READ_COUNT_DEFAULT;
> +        c->rstate.buf =3D g_malloc(QGA_READ_COUNT_DEFAULT);
> +        c->rstate.ov.hEvent =3D CreateEvent(&sec_attrs, FALSE, FALSE, NU=
LL);
>
> -    c->rstate.buf_size =3D QGA_READ_COUNT_DEFAULT;
> -    c->rstate.buf =3D g_malloc(QGA_READ_COUNT_DEFAULT);
> -    c->rstate.ov.hEvent =3D CreateEvent(&sec_attrs, FALSE, FALSE, NULL);
> +        c->source =3D ga_channel_create_watch(c);
> +        g_source_attach(c->source, NULL);
> +    }
>
> -    c->source =3D ga_channel_create_watch(c);
> -    g_source_attach(c->source, NULL);
>      return c;
>  }
>
>  void ga_channel_free(GAChannel *c)
>  {
> +    if (c->common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {
> +        /* Free the CRT fd wrappers before the GIOChannels close the
> SOCKETs. */
> +        if (c->listen_fd >=3D 0) {
> +            qemu_close_socket_osfhandle(c->listen_fd);
> +        }
> +        if (c->client_fd >=3D 0) {
> +            qemu_close_socket_osfhandle(c->client_fd);
> +        }
> +        ga_channel_common_free(&c->common);
> +        g_free(c);
> +        return;
> +    }
> +
> +    /* Handle mode */
>      if (c->source) {
>          g_source_destroy(c->source);
>      }
>      if (c->rstate.ov.hEvent) {
>          CloseHandle(c->rstate.ov.hEvent);
>      }
> -
> -    ga_channel_common_free(&c->common);
>      g_free(c->rstate.buf);
>      g_free(c);
>  }
> diff --git a/qga/main.c b/qga/main.c
> index fd19c7037d..35068ac7bb 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1675,6 +1675,12 @@ int main(int argc, char **argv)
>
>      config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
>
> +    /* Required for Windows, harmless otherwise. */
> +    if (socket_init() < 0) {
> +        g_critical("failed to initialize sockets");
> +        goto end;
> +    }
> +
>      qemu_init_exec_dir(argv[0]);
>      qga_qmp_init_marshal(&ga_commands);
>
> --
> 2.54.0
>
>
>

--00000000000025ec2a0654d3e269
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Polina,</div><div><br></div><div><span class=
=3D"Asgive ng" style=3D"border-style:none;background:none">First of all,</s=
pan> thanks for your patches.=C2=A0</div><div><br></div><div>Before reviewi=
ng this patch, I want to ask: why is it needed? <br><br>I understand the pa=
tch &quot;qemu-sockets: Enable AF_VSOCK on <span class=3D"Q6ibn ng" style=
=3D"border-style:none;background:none">Windows&quot;,</span>=C2=A0</div><di=
v>but AF_VSOCK has the same behavior on Linux and Windows.=C2=A0<div>I expe=
cted that we could totally reuse the POSIX part, so <span class=3D"gmail-As=
give gmail-ng" style=3D"border-style:none;background:none">just</span> move=
 it to common with=C2=A0</div><div>some defines like: <br>```<br>#ifdef G_O=
S_WIN32<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_ch =3D g_io_channel_win32_new_fd(=
in_fd);<br>#else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_ch =3D g_io_channel_unix=
_new(in_fd);<br>#endif</div><div>```</div><div><br></div></div><div>We test=
ed our driver with SSH over VSOCK, and standard Linux SSH works well.=C2=A0=
<br>So, what is the difference in this case <span class=3D"Asgive ng" style=
=3D"border-style:none;background:none">that you</span> add <span class=3D"Q=
6ibn ng" style=3D"border-style:none;background:none">win32</span>-specific =
code for VSOCK?</div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Rega=
rds,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 1=
9, 2026 at 9:03=E2=80=AFPM Polina Vishneva &lt;<a href=3D"mailto:polina.vis=
hneva@virtuozzo.com" target=3D"_blank">polina.vishneva@virtuozzo.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add vso=
ck-listen channel mode to the Windows guest agent.<br>
<br>
The listen/accept path uses the standard QEMU socket helpers<br>
(socket_parse(), socket_listen(), qemu_accept()) and plugs the resulting<br=
>
SOCKET into the GMainLoop via g_io_channel_win32_new_socket().<br>
<br>
Signed-off-by: Polina Vishneva &lt;<a href=3D"mailto:polina.vishneva@virtuo=
zzo.com" target=3D"_blank">polina.vishneva@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qemu-ga.rst |=C2=A0 =C2=A04 +<br>
=C2=A0qga/channel-win32.c=C2=A0 =C2=A0 =C2=A0 | 257 +++++++++++++++++++++++=
+++++++++-------<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A06 +<br>
=C2=A03 files changed, 222 insertions(+), 45 deletions(-)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index d16cc1b9f0..9c415fc8f8 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -59,6 +59,10 @@ Options<br>
=C2=A0 =C2=A0Transport method: one of ``unix-listen``, ``virtio-serial``, o=
r<br>
=C2=A0 =C2=A0``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the =
default).<br>
<br>
+=C2=A0 .. note::<br>
+=C2=A0 =C2=A0 =C2=A0On Windows, ``vsock-listen`` requires the viosock driv=
er from<br>
+=C2=A0 =C2=A0 =C2=A0kvm-guest-drivers-windows recent enough to include com=
mit ``687c776``.<br>
+<br>
=C2=A0.. option:: -p, --path=3DPATH<br>
<br>
=C2=A0 =C2=A0Device/socket path (the default for virtio-serial is<br>
diff --git a/qga/channel-win32.c b/qga/channel-win32.c<br>
index 2bd6fc1538..257576815a 100644<br>
--- a/qga/channel-win32.c<br>
+++ b/qga/channel-win32.c<br>
@@ -1,6 +1,8 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &lt;windows.h&gt;<br>
=C2=A0#include &lt;io.h&gt;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/sockets.h&quot;<br>
=C2=A0#include &quot;guest-agent-core.h&quot;<br>
=C2=A0#include &quot;channel-common.h&quot;<br>
<br>
@@ -17,6 +19,9 @@ typedef struct GAChannelReadState {<br>
=C2=A0struct GAChannel {<br>
=C2=A0 =C2=A0 =C2=A0GAChannelCommon common;<br>
<br>
+=C2=A0 =C2=A0 int listen_fd;<br>
+=C2=A0 =C2=A0 int client_fd;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0HANDLE handle;<br>
=C2=A0 =C2=A0 =C2=A0GAChannelReadState rstate;<br>
=C2=A0 =C2=A0 =C2=A0GIOCondition pending_events; /* TODO: use GAWatch.pollf=
d.revents */<br>
@@ -198,7 +203,116 @@ static GSource *ga_channel_create_watch(GAChannel *c)=
<br>
=C2=A0 =C2=A0 =C2=A0return source;<br>
=C2=A0}<br>
<br>
-GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *cou=
nt)<br>
+/*<br>
+ * Socket mode: GIOChannel-based listen/accept/client helpers<br>
+ */<br>
+<br>
+static gboolean ga_channel_socket_client_event(GIOChannel *channel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GIOCondition condition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gpointer data);<br>
+static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 GIOCondition condition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 gpointer data);<br>
+<br>
+static void ga_channel_socket_listen_add(GAChannel *c, bool create)<br>
+{<br>
+=C2=A0 =C2=A0 if (create) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;common.listen_channel =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_io_channel_win32_new_socket(_g=
et_osfhandle(c-&gt;listen_fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(c-&gt;common.listen_channel);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_io_add_watch(c-&gt;common.listen_channel, G_IO_IN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_ch=
annel_socket_listen_accept, c);<br>
+}<br>
+<br>
+static gboolean ga_channel_socket_client_close(GAChannel *c)<br>
+{<br>
+=C2=A0 =C2=A0 /* Free the CRT fd wrapper while the SOCKET is still valid. =
*/<br>
+=C2=A0 =C2=A0 if (c-&gt;client_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_close_socket_osfhandle(c-&gt;client_fd);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;client_fd =3D -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ga_channel_common_client_close(&amp;c-&gt;common);<br>
+=C2=A0 =C2=A0 if (c-&gt;common.listen_channel) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_channel_socket_listen_add(c, false);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+static gboolean ga_channel_socket_listen_accept(GIOChannel *channel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 GIOCondition condition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 gpointer data)<br>
+{<br>
+=C2=A0 =C2=A0 GAChannel *c =3D data;<br>
+=C2=A0 =C2=A0 int client_fd;<br>
+=C2=A0 =C2=A0 GIOChannel *client_ch;<br>
+=C2=A0 =C2=A0 bool accepted =3D false;<br>
+<br>
+=C2=A0 =C2=A0 client_fd =3D qemu_accept(c-&gt;listen_fd, NULL, NULL);<br>
+=C2=A0 =C2=A0 if (client_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_warning(&quot;error accepting connection: %s=
&quot;, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* g_io_channel_win32_new_socket() makes the socket non=
blocking via<br>
+=C2=A0 =C2=A0 =C2=A0* WSAEventSelect.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 client_ch =3D g_io_channel_win32_new_socket(_get_osfhandle(c=
lient_fd));<br>
+=C2=A0 =C2=A0 g_assert(client_ch);<br>
+<br>
+=C2=A0 =C2=A0 if (ga_channel_common_client_add(&amp;c-&gt;common, client_c=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_channel_socke=
t_client_event, c)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_warning(&quot;error setting up connection&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Release the CRT fd wrapper while its S=
OCKET is still open - only<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* then qemu_close_socket_osfhandle() can=
 detach the fd and let the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* channel teardown perform the single cl=
osesocket().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_close_socket_osfhandle(client_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_channel_common_gio_destroy(client_ch);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 c-&gt;client_fd =3D client_fd;<br>
+=C2=A0 =C2=A0 accepted =3D true;<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 /* only accept 1 connection at a time */<br>
+=C2=A0 =C2=A0 return !accepted;<br>
+}<br>
+<br>
+static gboolean ga_channel_socket_client_event(GIOChannel *channel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0GIOCondition condition,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gpointer data)<br>
+{<br>
+=C2=A0 =C2=A0 GAChannel *c =3D data;<br>
+<br>
+=C2=A0 =C2=A0 g_assert(c);<br>
+=C2=A0 =C2=A0 if (!c-&gt;common.event_cb(condition, c-&gt;common.user_data=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ga_channel_socket_client_close(c);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* A peer that sends data and disconnects at once is ne=
ver reported:<br>
+=C2=A0 =C2=A0 =C2=A0* GLib turns the coalesced FD_READ|FD_CLOSE into a pla=
in G_IO_IN,<br>
+=C2=A0 =C2=A0 =C2=A0* and Winsock records FD_CLOSE only once, so no later =
event follows.<br>
+=C2=A0 =C2=A0 =C2=A0* Peek after each event to detect the disconnect.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (c-&gt;client_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char peek;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t r =3D recv(c-&gt;client_fd, &amp;peek,=
 1, MSG_PEEK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r =3D=3D 0 || (r &lt; 0 &amp;&amp; errno !=
=3D EAGAIN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ga_channel_socket_client_=
close(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ * Handle mode: overlapped I/O read/write<br>
+ */<br>
+<br>
+static GIOStatus ga_channel_handle_read(GAChannel *c, char *buf, size_t si=
ze,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gsize *c=
ount)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GAChannelReadState *rs =3D &amp;c-&gt;rstate;<br>
=C2=A0 =C2=A0 =C2=A0GIOStatus status;<br>
@@ -221,8 +335,8 @@ GIOStatus ga_channel_read(GAChannel *c, char *buf, size=
_t size, gsize *count)<br>
=C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0}<br>
<br>
-static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t si=
ze,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t *count)<br>
+static GIOStatus ga_channel_handle_write(GAChannel *c, const char *buf,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0si=
ze_t size, size_t *count)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GIOStatus status;<br>
=C2=A0 =C2=A0 =C2=A0OVERLAPPED ov =3D {0};<br>
@@ -262,13 +376,25 @@ static GIOStatus ga_channel_write(GAChannel *c, const=
 char *buf, size_t size,<br>
=C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0}<br>
<br>
+GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *cou=
nt)<br>
+{<br>
+=C2=A0 =C2=A0 if (c-&gt;common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ga_channel_common_read(&amp;c-&gt;commo=
n, buf, size, count);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ga_channel_handle_read(c, buf, size, count);<br>
+}<br>
+<br>
=C2=A0GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t =
size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GIOStatus status =3D G_IO_STATUS_NORMAL;<br>
=C2=A0 =C2=A0 =C2=A0size_t count =3D 0;<br>
<br>
+=C2=A0 =C2=A0 if (c-&gt;common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ga_channel_common_write_all(&amp;c-&gt;=
common, buf, size);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0while (size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ga_channel_write(c, buf, size, &amp=
;count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ga_channel_handle_write(c, buf, siz=
e, &amp;count);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status =3D=3D G_IO_STATUS_NORMAL) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf +=3D count;<br>
@@ -276,86 +402,127 @@ GIOStatus ga_channel_write_all(GAChannel *c, const c=
har *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0}<br>
<br>
=C2=A0static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const gchar *path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const gchar *path, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COMMTIMEOUTS comTimeOut =3D {0};<br>
=C2=A0 =C2=A0 =C2=A0gchar newpath[MAXPATHLEN] =3D {0};<br>
=C2=A0 =C2=A0 =C2=A0comTimeOut.ReadIntervalTimeout =3D 1;<br>
<br>
-=C2=A0 =C2=A0 if (method !=3D GA_CHANNEL_VIRTIO_SERIAL &amp;&amp; method !=
=3D GA_CHANNEL_ISA_SERIAL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;unsupported communication met=
hod&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 c-&gt;common.method =3D method;<br>
<br>
-=C2=A0 =C2=A0 if (method =3D=3D GA_CHANNEL_ISA_SERIAL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(newpath, sizeof(newpath), &quot;\\\\.=
\\%s&quot;, path);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strlcpy(newpath, path, sizeof(newpath));<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 switch (method) {<br>
+=C2=A0 =C2=A0 case GA_CHANNEL_VIRTIO_SERIAL:<br>
+=C2=A0 =C2=A0 case GA_CHANNEL_ISA_SERIAL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (method =3D=3D GA_CHANNEL_ISA_SERIAL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(newpath, sizeof(newpath=
), &quot;\\\\.\\%s&quot;, path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strlcpy(newpath, path, sizeof(=
newpath));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 c-&gt;handle =3D CreateFile(newpath, GENERIC_READ | GENERIC_=
WRITE, 0, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0OPEN_EXISTING,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL=
);<br>
-=C2=A0 =C2=A0 if (c-&gt;handle =3D=3D INVALID_HANDLE_VALUE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree gchar *emsg =3D g_win32_error_messa=
ge(GetLastError());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;error opening path %s: %s&quo=
t;, newpath, emsg);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;handle =3D CreateFile(newpath, GENERIC_R=
EAD | GENERIC_WRITE, 0, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPEN_EXISTING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_FLAG_NO_BUFFERING | FILE_FLAG_OV=
ERLAPPED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;handle =3D=3D INVALID_HANDLE_VALUE) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree gchar *emsg =3D g_win=
32_error_message(GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;error ope=
ning path %s: %s&quot;, newpath, emsg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;handle =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (method =3D=3D GA_CHANNEL_ISA_SERIAL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !SetCom=
mTimeouts(c-&gt;handle, &amp;comTimeOut)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree gchar *emsg =3D g_win=
32_error_message(GetLastError());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;error set=
ting timeout for com port: %s&quot;, emsg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(c-&gt;handle);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;handle =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+<br>
+#ifdef CONFIG_AF_VSOCK<br>
+=C2=A0 =C2=A0 case GA_CHANNEL_VSOCK_LISTEN: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd =3D ga_channel_common_vsock_listen(path=
, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;listen_fd =3D fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_channel_socket_listen_add(c, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
<br>
-=C2=A0 =C2=A0 if (method =3D=3D GA_CHANNEL_ISA_SERIAL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !SetCommTimeouts(c-&g=
t;handle, &amp;comTimeOut)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree gchar *emsg =3D g_win32_error_messa=
ge(GetLastError());<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;error setting timeout for com=
 port: %s&quot;, emsg);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(c-&gt;handle);<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unsupported communicati=
on method&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int listen_fd, GAChannelCallback cb, gpointer opaqu=
e)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0GAChannel *c =3D g_new0(GAChannel, 1);<br>
-=C2=A0 =C2=A0 SECURITY_ATTRIBUTES sec_attrs;<br>
<br>
-=C2=A0 =C2=A0 if (!ga_channel_open(c, method, path)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;error opening channel&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(c);<br>
+=C2=A0 =C2=A0 /* listen_fd is for systemd socket activation; not applicabl=
e on Windows. */<br>
+=C2=A0 =C2=A0 (void)listen_fd;<br>
+=C2=A0 =C2=A0 c-&gt;listen_fd =3D -1;<br>
+=C2=A0 =C2=A0 c-&gt;client_fd =3D -1;<br>
+=C2=A0 =C2=A0 c-&gt;common.event_cb =3D cb;<br>
+=C2=A0 =C2=A0 c-&gt;common.user_data =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 if (!ga_channel_open(c, method, path, &amp;err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;%s&quot;, error_get_pretty(er=
r));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_channel_free(c);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 c-&gt;common.event_cb =3D cb;<br>
-=C2=A0 =C2=A0 c-&gt;common.user_data =3D opaque;<br>
+=C2=A0 =C2=A0 if (c-&gt;common.method !=3D GA_CHANNEL_VSOCK_LISTEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SECURITY_ATTRIBUTES sec_attrs;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sec_attrs.nLength =3D sizeof(SECURITY_ATTRIBUT=
ES);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sec_attrs.lpSecurityDescriptor =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sec_attrs.bInheritHandle =3D false;<br>
<br>
-=C2=A0 =C2=A0 sec_attrs.nLength =3D sizeof(SECURITY_ATTRIBUTES);<br>
-=C2=A0 =C2=A0 sec_attrs.lpSecurityDescriptor =3D NULL;<br>
-=C2=A0 =C2=A0 sec_attrs.bInheritHandle =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;rstate.buf_size =3D QGA_READ_COUNT_DEFAU=
LT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;rstate.buf =3D g_malloc(QGA_READ_COUNT_D=
EFAULT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;rstate.ov.hEvent =3D CreateEvent(&amp;se=
c_attrs, FALSE, FALSE, NULL);<br>
<br>
-=C2=A0 =C2=A0 c-&gt;rstate.buf_size =3D QGA_READ_COUNT_DEFAULT;<br>
-=C2=A0 =C2=A0 c-&gt;rstate.buf =3D g_malloc(QGA_READ_COUNT_DEFAULT);<br>
-=C2=A0 =C2=A0 c-&gt;rstate.ov.hEvent =3D CreateEvent(&amp;sec_attrs, FALSE=
, FALSE, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;source =3D ga_channel_create_watch(c);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_attach(c-&gt;source, NULL);<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 c-&gt;source =3D ga_channel_create_watch(c);<br>
-=C2=A0 =C2=A0 g_source_attach(c-&gt;source, NULL);<br>
=C2=A0 =C2=A0 =C2=A0return c;<br>
=C2=A0}<br>
<br>
=C2=A0void ga_channel_free(GAChannel *c)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 if (c-&gt;common.method =3D=3D GA_CHANNEL_VSOCK_LISTEN) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Free the CRT fd wrappers before the GIOChan=
nels close the SOCKETs. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;listen_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_close_socket_osfhandle(c-&g=
t;listen_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;client_fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_close_socket_osfhandle(c-&g=
t;client_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_channel_common_free(&amp;c-&gt;common);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Handle mode */<br>
=C2=A0 =C2=A0 =C2=A0if (c-&gt;source) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_source_destroy(c-&gt;source);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (c-&gt;rstate.ov.hEvent) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(c-&gt;rstate.ov.hEvent);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 ga_channel_common_free(&amp;c-&gt;common);<br>
=C2=A0 =C2=A0 =C2=A0g_free(c-&gt;rstate.buf);<br>
=C2=A0 =C2=A0 =C2=A0g_free(c);<br>
=C2=A0}<br>
diff --git a/qga/main.c b/qga/main.c<br>
index fd19c7037d..35068ac7bb 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1675,6 +1675,12 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0config-&gt;log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVE=
L_CRITICAL;<br>
<br>
+=C2=A0 =C2=A0 /* Required for Windows, harmless otherwise. */<br>
+=C2=A0 =C2=A0 if (socket_init() &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;failed to initialize sockets&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qemu_init_exec_dir(argv[0]);<br>
=C2=A0 =C2=A0 =C2=A0qga_qmp_init_marshal(&amp;ga_commands);<br>
<br>
-- <br>
2.54.0<br>
<br>
<br>
</blockquote></div>

--00000000000025ec2a0654d3e269--


