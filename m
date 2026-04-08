Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17EC10F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYDH-0001qw-Ct; Wed, 08 Apr 2026 15:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAYCo-0001WJ-OM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wARn7-0002gU-E6
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775650431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dMCBNtxVArYttWyy7cP/2A+U1IRE/oIt+BGty3J210g=;
 b=dzDcA6ZP2LqXwkClJt6Fx49KwwfDbMKbx9bWAif7qVqeaRx0P133Yvu2eNJgfZyK3A7uXl
 Bxb86f1Q4xDRud8nOOK06guaxN82yWyjZmckMERo2mFSEYIo2ej1r+cwrJSxSIUTAD9waD
 nz/Ss6z5Da+Z5IuhqaPcv2msVZ8yOPI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-2qL6uBlsM0C1Im3PqM84XQ-1; Wed,
 08 Apr 2026 08:13:48 -0400
X-MC-Unique: 2qL6uBlsM0C1Im3PqM84XQ-1
X-Mimecast-MFC-AGG-ID: 2qL6uBlsM0C1Im3PqM84XQ_1775650427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83F491955DD2; Wed,  8 Apr 2026 12:13:24 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8195D1955F2B; Wed,  8 Apr 2026 12:13:22 +0000 (UTC)
Date: Wed, 8 Apr 2026 13:13:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC v4 5/5] chardev/socket: add AF_PACKET capture path
Message-ID: <adZGX5nA76feGRuV@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
 <20260407050818.2249570-6-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407050818.2249570-6-lulu@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 01:05:52PM +0800, Cindy Lu wrote:
> Add the AF_PACKET capture read path for socket chardevs. When opened
> with af-packet-mode=capture, the read side drains raw frames with
> recvfrom(), keeps only PACKET_OUTGOING traffic, and feeds the result
> through the normal chardev frontend interface.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  chardev/char-socket.c | 133 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 131 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 45d06fda8f..76a51a853d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -107,9 +107,17 @@ static void tcp_chr_accept(QIONetListener *listener,
>  
>  static int tcp_chr_read_poll(void *opaque);
>  static void tcp_chr_disconnect_locked(Chardev *chr);
> +static void tcp_chr_deliver_af_packet(Chardev *chr);
>  
>  #define TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE 65536
>  
> +static bool
> +tcp_chr_uses_af_packet_capture(SocketChardev *s)
> +{
> +    return s->is_af_packet && s->af_packet_mode_set &&
> +           s->af_packet_mode == CHARDEV_SOCKET_AF_PACKET_MODE_CAPTURE;
> +}
> +
>  static bool tcp_chr_uses_af_packet_inject(SocketChardev *s)
>  {
>      return s->is_af_packet &&
> @@ -300,6 +308,9 @@ static int tcp_chr_read_poll(void *opaque)
>          return 0;
>      }
>      s->max_size = qemu_chr_be_can_write(chr);
> +    if (tcp_chr_uses_af_packet_capture(s) && s->af_packet_buf_len) {
> +        tcp_chr_deliver_af_packet(chr);
> +    }
>      return s->max_size;
>  }
>  
> @@ -500,6 +511,98 @@ static void tcp_chr_reset_af_packet_send(SocketChardev *s)
>      s->af_packet_send_len_bytes = 0;
>  }
>  
> +/* Push buffered AF_PACKET capture data into the chardev frontend. */
> +static void
> +tcp_chr_deliver_af_packet(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +
> +    while (s->max_size > 0 && s->af_packet_buf_offset < s->af_packet_buf_len) {
> +        size_t remaining = s->af_packet_buf_len - s->af_packet_buf_offset;
> +        size_t chunk = MIN((size_t)s->max_size, remaining);
> +
> +        qemu_chr_be_write(chr, s->af_packet_buf + s->af_packet_buf_offset,
> +                          (int)chunk);
> +        s->af_packet_buf_offset += chunk;
> +        s->max_size = qemu_chr_be_can_write(chr);
> +    }
> +
> +    if (s->af_packet_buf_offset == s->af_packet_buf_len) {
> +        tcp_chr_reset_af_packet_buf(s);
> +    }
> +}
> +
> +/* Copy buffered AF_PACKET capture data into a synchronous read buffer. */
> +static int tcp_chr_copy_af_packet_buf(SocketChardev *s, uint8_t *buf,
> +                                      int len) {
> +    size_t remaining = s->af_packet_buf_len - s->af_packet_buf_offset;
> +    size_t copied = MIN((size_t)len, remaining);
> +
> +    memcpy(buf, s->af_packet_buf + s->af_packet_buf_offset, copied);
> +    s->af_packet_buf_offset += copied;
> +
> +    if (s->af_packet_buf_offset == s->af_packet_buf_len) {
> +        tcp_chr_reset_af_packet_buf(s);
> +    }
> +
> +    return (int)copied;
> +}
> +
> +static ssize_t
> +tcp_chr_capture_af_packet(Chardev *chr)
> +{
> +#ifdef CONFIG_LINUX
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +    struct sockaddr_ll sll;
> +    socklen_t sll_len;
> +    ssize_t size;
> +    uint32_t len;
> +
> +    if (!tcp_chr_uses_af_packet_capture(s)) {
> +        errno = EIO;
> +        return -1;
> +    }
> +
> +    if (s->af_packet_buf_size <
> +        sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE) {
> +        s->af_packet_buf =
> +            g_realloc(s->af_packet_buf,
> +                      sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE);
> +        s->af_packet_buf_size =
> +            sizeof(len) + TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE;
> +    }
> +
> +    for (;;) {
> +        sll_len = sizeof(sll);
> +        do {
> +            size = recvfrom(s->sioc->fd, s->af_packet_buf + sizeof(len),
> +                            TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE, 0,
> +                            (struct sockaddr *)&sll, &sll_len);
> +        } while (size < 0 && errno == EINTR);
> +
> +        if (size <= 0) {
> +            if (size < 0 && errno != EAGAIN && errno != EWOULDBLOCK) {
> +                trace_chr_socket_recv_err(chr, chr->label, g_strerror(errno));
> +            }
> +            return size;
> +        }
> +
> +        if (sll.sll_pkttype != PACKET_OUTGOING) {
> +            continue;
> +        }
> +
> +        len = htonl(size);
> +        memcpy(s->af_packet_buf, &len, sizeof(len));
> +        s->af_packet_buf_len = sizeof(len) + size;
> +        s->af_packet_buf_offset = 0;
> +        return (ssize_t)s->af_packet_buf_len;
> +    }
> +#else
> +    errno = EPROTONOSUPPORT;
> +    return -1;
> +#endif
> +}
> +
>  static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
> @@ -682,6 +785,22 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
>      if (len > s->max_size) {
>          len = s->max_size;
>      }
> +    if (tcp_chr_uses_af_packet_capture(s)) {
> +        tcp_chr_deliver_af_packet(chr);
> +        if (s->max_size <= 0 || s->af_packet_buf_len) {
> +            return TRUE;
> +        }
> +
> +        size = tcp_chr_capture_af_packet(chr);
> +        if (size == 0 || (size == -1 && errno != EAGAIN)) {
> +            tcp_chr_disconnect(chr);
> +        } else if (size > 0) {
> +            tcp_chr_deliver_af_packet(chr);
> +        }
> +
> +        return TRUE;
> +    }
> +
>      size = tcp_chr_recv(chr, (void *)buf, len);
>      if (size == 0 || (size == -1 && errno != EAGAIN)) {
>          /* connection closed */
> @@ -715,6 +834,10 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
>      int saved_errno;
>      Error *local_err = NULL;
>  
> +    if (tcp_chr_uses_af_packet_capture(s) && s->af_packet_buf_len) {
> +        return tcp_chr_copy_af_packet_buf(s, (uint8_t *)buf, len);
> +    }
> +
>      if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
>          return 0;
>      }
> @@ -723,7 +846,14 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
>          error_report_err(local_err);
>          return -1;
>      }
> -    size = tcp_chr_recv(chr, (void *) buf, len);
> +    if (tcp_chr_uses_af_packet_capture(s)) {
> +        size = tcp_chr_capture_af_packet(chr);
> +        if (size > 0) {
> +            size = tcp_chr_copy_af_packet_buf(s, (uint8_t *)buf, len);
> +        }
> +    } else {
> +        size = tcp_chr_recv(chr, (void *)buf, len);
> +    }


Similarly to the send side, I don't really think we should have this
packet re-assembly logic in the chardev code. We should just be
calling the normal qio_channel_read APIs and let the netfilter code
re-assemble packets it gets from the chardev. Mostly it seems we
would use TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE instead of CHR_READ_BUF_LEN
in the existing code paths.

>      saved_errno = errno;
>      if (s->state != TCP_CHARDEV_STATE_DISCONNECTED) {
>          if (!qio_channel_set_blocking(s->ioc, false, &local_err)) {
> @@ -1448,7 +1578,6 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
>      return false;
>  }
>  
> -
>  static int qmp_chardev_open_socket_server(Chardev *chr,
>                                            bool is_telnet,
>                                            bool is_waitconnect,
> -- 
> 2.52.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


