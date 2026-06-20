Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A094CDB46B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 12:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waur8-0007vx-Fc; Sat, 20 Jun 2026 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waur5-0007qJ-00
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 08:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waur2-0007OV-Mb
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 08:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781958679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKJsWSJELZSkcoJI3rMC2XU05OQP7tuK2he377bXzK8=;
 b=WTcN9/QjRS9WUnaI6yUVg4N2Spdrt6StOJuUpDyPzrlXq93Qv45IXubkOVXUUNeOnNN+gf
 27fmByM9pDViSGHWh8FcgSSB9JO5BPMSewLb2a8oLTFCs2m3YDy0x0DbqldFukCWjZdyWj
 BOnvs/ixgDn3kTQnfBZA4t96RoLYQUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-xDLwchr7P72WJAMHtuyp1Q-1; Sat,
 20 Jun 2026 08:31:18 -0400
X-MC-Unique: xDLwchr7P72WJAMHtuyp1Q-1
X-Mimecast-MFC-AGG-ID: xDLwchr7P72WJAMHtuyp1Q_1781958677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFBCE195608F; Sat, 20 Jun 2026 12:31:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 637161800361; Sat, 20 Jun 2026 12:31:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
From: marcandre.lureau@redhat.com
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Denis V . Lunev" <den@virtuozzo.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
Date: Sat, 20 Jun 2026 16:31:03 +0400
Message-Id: <178195866301.3446841.14568446062958352149.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=14161;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iq/CmQ9LDSdIpM0HKKbdURzZXICI7cxKo5fr9k+cOts=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqNogJkrI8/n8A08qgPyvxJ/g7yAVX537ZuJf6Q
 3QQg1TRC5mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajaICQAKCRDa6OEJdZac
 5TJyEACUjVNv4tBGVHUH7oVzyscoG3erJ9SQJ4iO5UffMfxYAeG+D2nWf0iC9MlshkJdTvdtOGU
 SJRv0dHXNpbGQVnvugo84sQrsr6evgzuVet0nexnSRN5DEMJsebJwCovATRf6/IuCjF7CiysVXq
 sxUJMBJtED8LOEqr0cXo6ae0U/SuM+y+r2JCsWCWc5Cl8c0/DVTf84pUnSsAk7kR9rqtwAmugLy
 eGBQpYKapHp5perihQLSvwCRcD0LpVmzUqIRbXaT0qw2bWOAriSh6WTbl4OWDZVra/29UWCfAsz
 xYGXZ4iKUQt6mmqrsC/o9tTtRz1bsx7dT1LArBy6ErqNeVi7I5kYk5oGkSQ6cC5r2Yowl+CyQop
 LdKkwIaPcYJytKiJybW8QrR8JowXM7oq4kZH151yZZHh371hlymcToVMJmghhm63bX/xQpN0oFh
 OTjIHc3re71oT4SGHB9Gu3M9BJTB+AiL00SD6XNTTb5NfFX/45xmaRsW9WJbtrZh3Poye4pnPJL
 LzAF27jv3/MhlvJzZ37hOn3nlPmC/c3h1lobnPsk+TGUGMbLtl/LrWZOvYir5pM040QIFiEjm6l
 ofET2A976CtWHcVW0SQM61NM3zEviNhJC4Tcd6QVysPg4AV2hT9EPLT4IytwP6HlkBkvI0dJNyZ
 Rm11hCH+6c7Roww==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> Add vsock-listen channel mode to the Windows guest agent.
> 
> The listen/accept path uses the standard QEMU socket helpers
> (socket_parse(), socket_listen(), qemu_accept()) and plugs the resulting
> SOCKET into the GMainLoop via g_io_channel_win32_new_socket().
> 
> Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> Message-ID: <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index d16cc1b9f07..9c415fc8f87 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -59,6 +59,10 @@ Options
>    Transport method: one of ``unix-listen``, ``virtio-serial``, or
>    ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default).
>  
> +  .. note::
> +     On Windows, ``vsock-listen`` requires the viosock driver from
> +     kvm-guest-drivers-windows recent enough to include commit ``687c776``.
> +
>  .. option:: -p, --path=PATH
>  
>    Device/socket path (the default for virtio-serial is
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index 2bd6fc15387..257576815ae 100644
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
> @@ -198,7 +203,116 @@ static GSource *ga_channel_create_watch(GAChannel *c)
>      return source;
>  }
>  
> -GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
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
> +        c->common.listen_channel =
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
> +    if (c->client_fd >= 0) {
> +        qemu_close_socket_osfhandle(c->client_fd);
> +        c->client_fd = -1;
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
> +    GAChannel *c = data;
> +    int client_fd;
> +    GIOChannel *client_ch;
> +    bool accepted = false;
> +
> +    client_fd = qemu_accept(c->listen_fd, NULL, NULL);
> +    if (client_fd < 0) {
> +        g_warning("error accepting connection: %s", strerror(errno));
> +        goto out;
> +    }
> +
> +    /*
> +     * g_io_channel_win32_new_socket() makes the socket nonblocking via
> +     * WSAEventSelect.
> +     */
> +    client_ch = g_io_channel_win32_new_socket(_get_osfhandle(client_fd));
> +    g_assert(client_ch);
> +
> +    if (ga_channel_common_client_add(&c->common, client_ch,
> +                                     ga_channel_socket_client_event, c)) {
> +        g_warning("error setting up connection");
> +        /*
> +         * Release the CRT fd wrapper while its SOCKET is still open - only
> +         * then qemu_close_socket_osfhandle() can detach the fd and let the
> +         * channel teardown perform the single closesocket().
> +         */
> +        qemu_close_socket_osfhandle(client_fd);
> +        ga_channel_common_gio_destroy(client_ch);
> +        goto out;
> +    }
> +    c->client_fd = client_fd;
> +    accepted = true;
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
> +    GAChannel *c = data;
> +
> +    g_assert(c);
> +    if (!c->common.event_cb(condition, c->common.user_data)) {
> +        return ga_channel_socket_client_close(c);
> +    }
> +    /*
> +     * A peer that sends data and disconnects at once is never reported:
> +     * GLib turns the coalesced FD_READ|FD_CLOSE into a plain G_IO_IN,
> +     * and Winsock records FD_CLOSE only once, so no later event follows.
> +     * Peek after each event to detect the disconnect.
> +     */
> +    if (c->client_fd >= 0) {
> +        char peek;
> +        ssize_t r = recv(c->client_fd, &peek, 1, MSG_PEEK);
> +        if (r == 0 || (r < 0 && errno != EAGAIN)) {
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
> +static GIOStatus ga_channel_handle_read(GAChannel *c, char *buf, size_t size,
> +                                        gsize *count)
>  {
>      GAChannelReadState *rs = &c->rstate;
>      GIOStatus status;
> @@ -221,8 +335,8 @@ GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
>      return status;
>  }
>  
> -static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t size,
> -                                  size_t *count)
> +static GIOStatus ga_channel_handle_write(GAChannel *c, const char *buf,
> +                                         size_t size, size_t *count)
>  {
>      GIOStatus status;
>      OVERLAPPED ov = {0};
> @@ -262,13 +376,25 @@ static GIOStatus ga_channel_write(GAChannel *c, const char *buf, size_t size,
>      return status;
>  }
>  
> +GIOStatus ga_channel_read(GAChannel *c, char *buf, size_t size, gsize *count)
> +{
> +    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
> +        return ga_channel_common_read(&c->common, buf, size, count);
> +    }
> +    return ga_channel_handle_read(c, buf, size, count);
> +}
> +
>  GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t size)
>  {
>      GIOStatus status = G_IO_STATUS_NORMAL;
>      size_t count = 0;
>  
> +    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
> +        return ga_channel_common_write_all(&c->common, buf, size);
> +    }
> +
>      while (size) {
> -        status = ga_channel_write(c, buf, size, &count);
> +        status = ga_channel_handle_write(c, buf, size, &count);
>          if (status == G_IO_STATUS_NORMAL) {
>              size -= count;
>              buf += count;
> @@ -276,86 +402,127 @@ GIOStatus ga_channel_write_all(GAChannel *c, const char *buf, size_t size)
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
>      COMMTIMEOUTS comTimeOut = {0};
>      gchar newpath[MAXPATHLEN] = {0};
>      comTimeOut.ReadIntervalTimeout = 1;
>  
> -    if (method != GA_CHANNEL_VIRTIO_SERIAL && method != GA_CHANNEL_ISA_SERIAL) {
> -        g_critical("unsupported communication method");
> -        return false;
> -    }
> +    c->common.method = method;
>  
> -    if (method == GA_CHANNEL_ISA_SERIAL) {
> -        snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
> -    } else {
> -        g_strlcpy(newpath, path, sizeof(newpath));
> -    }
> +    switch (method) {
> +    case GA_CHANNEL_VIRTIO_SERIAL:
> +    case GA_CHANNEL_ISA_SERIAL:
> +        if (method == GA_CHANNEL_ISA_SERIAL) {
> +            snprintf(newpath, sizeof(newpath), "\\\\.\\%s", path);
> +        } else {
> +            g_strlcpy(newpath, path, sizeof(newpath));
> +        }
>  
> -    c->handle = CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, NULL,
> -                           OPEN_EXISTING,
> -                           FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL);
> -    if (c->handle == INVALID_HANDLE_VALUE) {
> -        g_autofree gchar *emsg = g_win32_error_message(GetLastError());
> -        g_critical("error opening path %s: %s", newpath, emsg);
> -        return false;
> +        c->handle = CreateFile(newpath, GENERIC_READ | GENERIC_WRITE, 0, NULL,
> +                               OPEN_EXISTING,
> +                               FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED,
> +                               NULL);
> +        if (c->handle == INVALID_HANDLE_VALUE) {
> +            g_autofree gchar *emsg = g_win32_error_message(GetLastError());
> +            error_setg(errp, "error opening path %s: %s", newpath, emsg);
> +            c->handle = NULL;
> +            return false;
> +        }
> +
> +        if (method == GA_CHANNEL_ISA_SERIAL
> +                && !SetCommTimeouts(c->handle, &comTimeOut)) {
> +            g_autofree gchar *emsg = g_win32_error_message(GetLastError());
> +            error_setg(errp, "error setting timeout for com port: %s", emsg);
> +            CloseHandle(c->handle);
> +            c->handle = NULL;
> +            return false;
> +        }
> +        return true;
> +
> +#ifdef CONFIG_AF_VSOCK
> +    case GA_CHANNEL_VSOCK_LISTEN: {
> +        int fd = ga_channel_common_vsock_listen(path, errp);
> +        if (fd < 0) {
> +            return false;
> +        }
> +
> +        c->listen_fd = fd;
> +        ga_channel_socket_listen_add(c, true);
> +        return true;
>      }
> +#endif
>  
> -    if (method == GA_CHANNEL_ISA_SERIAL
> -            && !SetCommTimeouts(c->handle, &comTimeOut)) {
> -        g_autofree gchar *emsg = g_win32_error_message(GetLastError());
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
>                            int listen_fd, GAChannelCallback cb, gpointer opaque)
>  {
> +    Error *err = NULL;
>      GAChannel *c = g_new0(GAChannel, 1);
> -    SECURITY_ATTRIBUTES sec_attrs;
>  
> -    if (!ga_channel_open(c, method, path)) {
> -        g_critical("error opening channel");
> -        g_free(c);
> +    /* listen_fd is for systemd socket activation; not applicable on Windows. */
> +    (void)listen_fd;
> +    c->listen_fd = -1;
> +    c->client_fd = -1;
> +    c->common.event_cb = cb;
> +    c->common.user_data = opaque;
> +
> +    if (!ga_channel_open(c, method, path, &err)) {
> +        g_critical("%s", error_get_pretty(err));
> +        error_free(err);
> +        ga_channel_free(c);
>          return NULL;
>      }
>  
> -    c->common.event_cb = cb;
> -    c->common.user_data = opaque;
> +    if (c->common.method != GA_CHANNEL_VSOCK_LISTEN) {
> +        SECURITY_ATTRIBUTES sec_attrs;
> +
> +        sec_attrs.nLength = sizeof(SECURITY_ATTRIBUTES);
> +        sec_attrs.lpSecurityDescriptor = NULL;
> +        sec_attrs.bInheritHandle = false;
>  
> -    sec_attrs.nLength = sizeof(SECURITY_ATTRIBUTES);
> -    sec_attrs.lpSecurityDescriptor = NULL;
> -    sec_attrs.bInheritHandle = false;
> +        c->rstate.buf_size = QGA_READ_COUNT_DEFAULT;
> +        c->rstate.buf = g_malloc(QGA_READ_COUNT_DEFAULT);
> +        c->rstate.ov.hEvent = CreateEvent(&sec_attrs, FALSE, FALSE, NULL);
>  
> -    c->rstate.buf_size = QGA_READ_COUNT_DEFAULT;
> -    c->rstate.buf = g_malloc(QGA_READ_COUNT_DEFAULT);
> -    c->rstate.ov.hEvent = CreateEvent(&sec_attrs, FALSE, FALSE, NULL);
> +        c->source = ga_channel_create_watch(c);
> +        g_source_attach(c->source, NULL);
> +    }
>  
> -    c->source = ga_channel_create_watch(c);
> -    g_source_attach(c->source, NULL);
>      return c;
>  }
>  
>  void ga_channel_free(GAChannel *c)
>  {
> +    if (c->common.method == GA_CHANNEL_VSOCK_LISTEN) {
> +        /* Free the CRT fd wrappers before the GIOChannels close the SOCKETs. */
> +        if (c->listen_fd >= 0) {
> +            qemu_close_socket_osfhandle(c->listen_fd);
> +        }
> +        if (c->client_fd >= 0) {
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

We should keep this call on the common path, imho.

The qemu-ga code isn't easy to follow, there is clearly room for improvements.
You may not want to do it with this series though. I'll leave that to you & the
maintainer.

I think the cleanup handlers should be made idempotent, so they can be called in
multiple paths.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


