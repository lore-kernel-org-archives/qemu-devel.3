Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E141FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 10:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7B5S-0002Lt-SW; Tue, 22 Apr 2025 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7B5Q-0002LL-Sk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 06:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7B5M-00020O-NM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 06:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745318559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8HmyEUkva3SA6YY14SC0fhvTGRIrLQvLkkZHXsO3Iy0=;
 b=XXU8BT8/BQDvjKI70LBEzNPSVEMJafa0FJi65xurxfqlJtBGj0B8V1TSpmsR/GvfcnXcNk
 X5SjJ4DO1wSE1/MUM57O04mdIEVCD20O8NCWW6xO83V6low5ROBJMLt+qG11nq6qdVe1UY
 nwMwsCLJSxhIArO5esbu8TN/EI0UQ3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-sYu34K-dP7Ca0taI30bHhw-1; Tue,
 22 Apr 2025 06:42:36 -0400
X-MC-Unique: sYu34K-dP7Ca0taI30bHhw-1
X-Mimecast-MFC-AGG-ID: sYu34K-dP7Ca0taI30bHhw_1745318555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9EC819560AF; Tue, 22 Apr 2025 10:42:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5A201800378; Tue, 22 Apr 2025 10:42:32 +0000 (UTC)
Date: Tue, 22 Apr 2025 11:42:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Jones <rjones@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] io: Increase unix socket buffers size on macOS
Message-ID: <aAdylVf7RZVaTee3@redhat.com>
References: <20250419231218.67636-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250419231218.67636-1-nirsof@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Apr 20, 2025 at 02:12:18AM +0300, Nir Soffer wrote:
> On macOS we need to increase unix socket buffers size on the client and
> server to get good performance. We set the socket buffers on macOS after
> connecting or accepting a client connection.
> 
> Testing with qemu-nbd shows that reading an image with qemu-img convert
> from qemu-nbd is *11.4 times faster* and qemu-img cpu usage is *8.3 times
> lower*.
> 
> | qemu-img | qemu-nbd | time   | user   | system |
> |----------|----------|--------|--------|--------|
> | before   | before   | 12.957 |  2.643 |  5.777 |
> | after    | before   | 12.803 |  2.632 |  5.742 |
> | before   | after    |  1.139 |  0.074 |  0.905 |
> | after    | after    |  1.179 |  0.077 |  0.931 |
> 
> For testing buffers size I built qemu-nbd and qemu-img with send buffer
> size from 64k to 2m. In this test 256k send buffer and 1m receive buffer
> are optimal.
> 
> | send buffer | recv buffer | time   | user   | system |
> |-------------|-------------|--------|--------|--------|
> |         64k |        256k |  2.233 |  0.290 |  1.408 |
> |        128k |        512k |  1.189 |  0.103 |  0.841 |
> |        256k |       1024k |  1.121 |  0.085 |  0.813 |
> |        512k |       2048k |  1.172 |  0.081 |  0.953 |
> |       1024k |       4096k |  1.160 |  0.072 |  0.907 |
> |       2048k |       8192k |  1.309 |  0.056 |  0.960 |
> 
> Using null-co driver is useful to focus on the read part, but in the
> real world we do something with the read data. I tested real world usage
> with nbdcopy and blksum.
> 
> I tested computing a hash of the image using nbdcopy, using 4 NBD
> connections and 256k request size. In this test 1m send buffer size and
> 4m receive buffer size are optimal.
> 
> | send buffer | recv buffer | time   | user   | system |
> |-------------|-------------|--------|--------|--------|
> |         64k |        256k |  2.832 |  4.866 |  2.550 |
> |        128k |        512k |  2.429 |  4.762 |  2.037 |
> |        256k |       1024k |  2.158 |  4.724 |  1.813 |
> |        512k |       2048k |  1.777 |  4.632 |  1.790 |
> |       1024k |       4096k |  1.657 |  4.466 |  1.812 |
> |       2048k |       8192k |  1.782 |  4.570 |  1.912 |
> 
> I tested creating a hash of the image with blksum, using one NBD
> connection and 256k read size. In this test 2m send buffer and 8m
> receive buffer are optimal.
> 
> | send buffer | recv buffer | time   | user   | system |
> |-------------|-------------|--------|--------|--------|
> |         64k |        256k |  4.233 |  5.242 |  2.632 |
> |        128k |        512k |  3.329 |  4.915 |  2.015 |
> |        256k |       1024k |  2.071 |  4.647 |  1.474 |
> |        512k |       2048k |  1.980 |  4.554 |  1.432 |
> |       1024k |       4096k |  2.058 |  4.553 |  1.497 |
> |       2048k |       8192k |  1.972 |  4.539 |  1.497 |
> 
> In the real world tests larger buffers are optimal, so I picked send
> buffer of 1m and receive buffer of 4m.

IIUC all your test scenarios have recv buffer x4 size of send buffer.

Do you have any link / reference for the idea that we should be using
this x4 size multiplier ? This feels rather peculiar as a rule.

Can you show test result grid matrix for the incrementing these
send/recv buffers independently ?

> 
> This will improve other usage of unix domain sockets on macOS. I tested
> only reading from qemu-nbd.
> 
> The same change for libnbd:
> https://gitlab.com/nbdkit/libnbd/-/merge_requests/21
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  io/channel-socket.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> Changes since v1:
> - Add UNIX_SOCKET_*_BUFFER_SIZE macros (Philippe)
> - Handle both server and client sockets
> - Add qio_channel_socket_set_buffers() helper to cleaner code
> - Add tests results for qemu-img convert
> - Add tests results for different buffer sizes
> - Link to same change in libnbd
> 
> v1 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg03081.html
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..635c5c973d 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -21,6 +21,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qemu/module.h"
> +#include "qemu/units.h"
>  #include "io/channel-socket.h"
>  #include "io/channel-util.h"
>  #include "io/channel-watch.h"
> @@ -37,6 +38,33 @@
>  
>  #define SOCKET_MAX_FDS 16
>  
> +/*
> + * Apple recommends sizing the receive buffer at 4 times the size of the send
> + * buffer. Testing shows that 1m send buffer and 4 MiB receive buffer gives
> + * best throuput and lowest cpu usage.
> + */
> +#ifdef __APPLE__
> +#define UNIX_SOCKET_SEND_BUFFER_SIZE (1 * MiB)
> +#define UNIX_SOCKET_RECV_BUFFER_SIZE (4 * UNIX_SOCKET_SEND_BUFFER_SIZE)
> +#endif /* __APPLE__ */
> +
> +static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
> +{
> +#ifdef __APPLE__
> +    if (ioc->localAddr.ss_family == AF_UNIX) {
> +        int value;
> +
> +        /* This is a performance optimization; don't fail on errors. */
> +
> +        value = UNIX_SOCKET_SEND_BUFFER_SIZE;
> +        setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &value, sizeof(value));
> +
> +        value = UNIX_SOCKET_RECV_BUFFER_SIZE;
> +        setsockopt(ioc->fd, SOL_SOCKET, SO_RCVBUF, &value, sizeof(value));
> +    }
> +#endif /* __APPLE__ */
> +}
> +
>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -174,6 +202,8 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>      }
>  #endif
>  
> +    qio_channel_socket_set_buffers(ioc);
> +
>      qio_channel_set_feature(QIO_CHANNEL(ioc),
>                              QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
>  
> @@ -410,6 +440,8 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>      }
>  #endif /* WIN32 */
>  
> +    qio_channel_socket_set_buffers(cioc);
> +
>      qio_channel_set_feature(QIO_CHANNEL(cioc),
>                              QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


