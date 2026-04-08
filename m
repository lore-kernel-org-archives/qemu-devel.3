Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C51710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYXz-00021h-2n; Wed, 08 Apr 2026 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAY7V-0007if-Pa
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wARgi-0001R8-8o
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775650034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0zipxTMFRRf9pxRki22nji35TS0J1pUw/OKrbIBsgQA=;
 b=Grr7xMyW9S41hvzLQdYFRp/K68clQWgS7GyCvfF2S0dymqv2soXITbkuJvRMFRaFU6am+i
 XGvHci+/QD+dZrbaZgXFDFTwS5arxGGn5SuldeKKSovmH0JwiGTBtmZoIPQPXnSWlWSpji
 iipitzUtc7f5slGjJLMyk+vN6bwWjx4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-yZlxBYgrPhianXDoxlMUkA-1; Wed,
 08 Apr 2026 08:07:13 -0400
X-MC-Unique: yZlxBYgrPhianXDoxlMUkA-1
X-Mimecast-MFC-AGG-ID: yZlxBYgrPhianXDoxlMUkA_1775650031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 198F7195606B; Wed,  8 Apr 2026 12:07:11 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 387371953944; Wed,  8 Apr 2026 12:07:09 +0000 (UTC)
Date: Wed, 8 Apr 2026 13:07:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC v4 4/5] chardev/socket: add AF_PACKET inject path
Message-ID: <adZE6g8mvCab_swz@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
 <20260407050818.2249570-5-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407050818.2249570-5-lulu@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 01:05:51PM +0800, Cindy Lu wrote:
> Add the AF_PACKET inject write path for socket chardevs. When a socket
> backend is opened with af-packet-mode=inject, tcp_chr_write() no longer
> sends the redirector stream framing through QIOChannel. Instead it
> parses the existing 4-byte length header, accumulates one complete
> packet, and frame on the AF_PACKET fd.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  chardev/char-socket.c | 148 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index c710fdb497..45d06fda8f 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -108,11 +108,159 @@ static void tcp_chr_accept(QIONetListener *listener,
>  static int tcp_chr_read_poll(void *opaque);
>  static void tcp_chr_disconnect_locked(Chardev *chr);
>  
> +#define TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE 65536
> +
> +static bool tcp_chr_uses_af_packet_inject(SocketChardev *s)
> +{
> +    return s->is_af_packet &&
> +           s->af_packet_mode_set &&
> +           s->af_packet_mode == CHARDEV_SOCKET_AF_PACKET_MODE_INJECT;
> +}
> +
> +static ssize_t tcp_chr_send_af_packet(SocketChardev *s,
> +                                      const uint8_t *buf,
> +                                      size_t len)
> +{
> +#ifdef CONFIG_LINUX
> +    struct iovec iov = {
> +        .iov_base = (void *)buf,
> +        .iov_len = len,
> +    };
> +    struct msghdr msg = {
> +        .msg_iov = &iov,
> +        .msg_iovlen = 1,
> +    };
> +    ssize_t ret;
> +
> +    if (!s->sioc || s->sioc->localAddr.ss_family != AF_PACKET) {
> +        errno = ENOTSOCK;
> +        return -1;
> +    }
> +
> +    do {
> +        ret = sendmsg(s->sioc->fd, &msg, 0);
> +    } while (ret < 0 && errno == EINTR);
> +
> +    return ret;
> +#else
> +    errno = EPROTONOSUPPORT;
> +    return -1;
> +#endif
> +}
> +
> +static bool tcp_chr_af_packet_prepare_send(SocketChardev *s, uint32_t frame_len)
> +{
> +    if (frame_len > TCP_CHARDEV_AF_PACKET_MAX_FRAME_SIZE) {
> +        errno = EMSGSIZE;
> +        return false;
> +    }
> +
> +    if (frame_len == 0) {
> +        s->af_packet_send_len = 0;
> +        s->af_packet_send_offset = 0;
> +        s->af_packet_send_len_bytes = 0;
> +        return true;
> +    }
> +
> +    if (s->af_packet_send_buf_size < frame_len) {
> +        s->af_packet_send_buf = g_realloc(s->af_packet_send_buf, frame_len);
> +        s->af_packet_send_buf_size = frame_len;
> +    }
> +
> +    s->af_packet_send_len = frame_len;
> +    s->af_packet_send_offset = 0;
> +    s->af_packet_send_len_bytes = sizeof(s->af_packet_send_len_buf);
> +    return true;
> +}
> +
> +static int tcp_chr_inject_af_packet(Chardev *chr,
> +                                    SocketChardev *s,
> +                                    const uint8_t *buf,
> +                                    int len)
> +{
> +    size_t offset = 0;
> +    uint32_t frame_len_be;
> +
> +    while (offset < len) {
> +        size_t copy;
> +
> +        if (s->af_packet_send_len_bytes < sizeof(s->af_packet_send_len_buf)) {
> +            copy = MIN(sizeof(s->af_packet_send_len_buf) -
> +                       s->af_packet_send_len_bytes,
> +                       (size_t)len - offset);
> +            memcpy(s->af_packet_send_len_buf + s->af_packet_send_len_bytes,
> +                   buf + offset, copy);
> +            s->af_packet_send_len_bytes += copy;
> +            offset += copy;
> +
> +            if (s->af_packet_send_len_bytes <
> +                sizeof(s->af_packet_send_len_buf)) {
> +                continue;
> +            }
> +
> +            memcpy(&frame_len_be, s->af_packet_send_len_buf,
> +                   sizeof(frame_len_be));
> +            if (!tcp_chr_af_packet_prepare_send(s, ntohl(frame_len_be))) {
> +                return -1;
> +            }
> +            if (s->af_packet_send_len == 0) {
> +                continue;
> +            }
> +        }
> +
> +        copy = MIN(s->af_packet_send_len - s->af_packet_send_offset,
> +                   (size_t)len - offset);
> +        memcpy(s->af_packet_send_buf + s->af_packet_send_offset,
> +               buf + offset, copy);
> +        s->af_packet_send_offset += copy;
> +        offset += copy;
> +
> +        if (s->af_packet_send_offset == s->af_packet_send_len) {
> +            ssize_t ret;
> +
> +            ret = tcp_chr_send_af_packet(s, s->af_packet_send_buf,
> +                                         s->af_packet_send_len);
> +
> +            if (ret < 0) {
> +                if (errno == EAGAIN || errno == EWOULDBLOCK) {
> +                    return -1;
> +                }
> +                if (tcp_chr_read_poll(chr) <= 0) {
> +                    trace_chr_socket_poll_err(chr, chr->label);
> +                    tcp_chr_disconnect_locked(chr);
> +                }
> +                return -1;
> +            }
> +
> +            if (ret != (ssize_t)s->af_packet_send_len) {
> +                if (ret >= 0) {
> +                    errno = EIO;
> +                }
> +                if (tcp_chr_read_poll(chr) <= 0) {
> +                    trace_chr_socket_poll_err(chr, chr->label);
> +                    tcp_chr_disconnect_locked(chr);
> +                }
> +                return -1;
> +            }
> +
> +            s->af_packet_send_len = 0;
> +            s->af_packet_send_offset = 0;
> +            s->af_packet_send_len_bytes = 0;
> +        }
> +    }
> +
> +    return len;
> +}
> +
>  /* Called with chr_write_lock held.  */
>  static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
>  
> +    if (tcp_chr_uses_af_packet_inject(s)) {
> +        return tcp_chr_inject_af_packet(chr, s, buf, len);
> +    }
> +

This code is pretty unpleasant, completely bypassing all of the
normal I/O path in the chardev, and completely ignoring the
QIOChannel too, just poking the socket directly.  Essentially
this shares nothing in common with the socket chardev functionality.

If we do want to have AF_PACKET support in the socket chardev then
IMHO all this buffer parsing code needs to be in the netfilter
layer instead.  The chardev should just accept a single packet
buffer at a time, such that it can directly pass it on to the
normal qio_channel_write API which will call sendmsg.

>      if (s->state == TCP_CHARDEV_STATE_CONNECTED) {
>          int ret =  io_channel_send_full(s->ioc, buf, len,
>                                          s->write_msgfds,
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


