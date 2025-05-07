Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C070EC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 17:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCiOo-0000oa-O5; Wed, 07 May 2025 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1uCiOn-0000oS-E4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:17:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1uCiOl-00026o-18
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:17:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a0b9625735so72554f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746638252; x=1747243052; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycHVh1v9zygLp88A2GJLR4hhK7btJXtpTXBpLwQXq2U=;
 b=Bp5J7K1BaPfYqtFePWT4dRV7GxYGc9A75ois56RltgneSh5UuvhkSTqgCTeuM+wKV+
 U3qv3BwEh63q0cs6DuC5Fl9g7w+TGT7MklPeswtTPCxn2dGqMLQmTiqRIM0BevAbK+Zr
 Mi4B+0HprK0FVXBVohur/fEsw3yfz482i3gsWSRF8j9lQK61Wc444N2A5u+oCQbdi/3o
 sTiBvuE22ob6g8dXZt1uOsZgYZIYnc/SjAOkuMJYG5Djk02Mq5XhrCjzaGPIlPcZzyaQ
 hwGKULQ6eO5p0qabtQHnBjcf7ZcLqPYHJp7x5UKquEejlouZ1419Icx3fBw9if7zIeUm
 qjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746638252; x=1747243052;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycHVh1v9zygLp88A2GJLR4hhK7btJXtpTXBpLwQXq2U=;
 b=s9YVKkJ/koZf0sxL/YBcU4IabfwvAcOl6F+O42d96MVzKawiTkEjPZTZQ6XDmYBt0S
 t7du+M4gZHDeLKvOZr2B5DOMQ9Zc57f2Mf/8So4/F5+uSUtOO6PUOUkMyG3XL0WxnVc4
 DzxZg0Wj1fYbtwZttjoy+nGU8DbQcC3mmRN81qIC6vGi5xPe1UzeU68g25vvNiylg8fB
 hzt1z0gJsKaczlDqH/K/UTPl9kYaQBRpkfuEx6I9XnvTS2unzcFC/zCcUuX8PkZNVrib
 By53G0ZmFB5K+upBYlB6fngkBBdXS486K8esCq7mLmufusGIVOBdqMx2r6+wQppj7c4+
 d4kA==
X-Gm-Message-State: AOJu0Yy9EABi3GbxV5UaKmWbT0DLK+t1batetnnK5a2VOXNPkr1TgAFZ
 GMyus6g15E2jiGqqowNWr0Q8/xeSjSSQAUwBafGYrnWlcqYSqv0F
X-Gm-Gg: ASbGnct7Q8d79aRfHtEA15/qkwnWrzJlrNCcXTERwBg9Wr3bnmc1mP6cCj4R6lnb1oH
 0Aco4aYmHmzT5nOehGSXkwR+wTy4xPJ3oelv79E4GovHNRZSXO58T9gV84VAgvL5FZB29TssbxR
 Ee/YdrKDRxVmUMgKYnxdUVe4hKZB6kxRkA1msGB33AHfetr84DL5FPQACK0WNEJdLJjveFh/R1W
 +uGDO+8Uk77NeRXEauag2qnI13IwT/DZF+Fe2QN9hxnl8Pfi3CuF8NzeCk4qo3S/QsWx1HL1CTk
 p/ybzXmUpks7/T4oa+KF3OQudaezobdYW9/mRlHszfoKi8IIbsgYmxY33zaW6x4SQS1nWdDlFVe
 ix3HpFRWaXllD5hJn
X-Google-Smtp-Source: AGHT+IEI3MMB88xKsPgLOBLYzu48+tLlCH92HfZDw/V7m4cTDFywHVdlTSI7hyLQGf9aRRkGCPhRbg==
X-Received: by 2002:a05:6000:3105:b0:3a0:839c:271f with SMTP id
 ffacd0b85a97d-3a0b4a1c872mr3665047f8f.47.1746638251864; 
 Wed, 07 May 2025 10:17:31 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7bb3sm17675402f8f.51.2025.05.07.10.17.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 May 2025 10:17:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v3 1/2] io: Increase unix socket buffers size on macOS
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <aBuMQSEm9f8JsdoQ@redhat.com>
Date: Wed, 7 May 2025 20:17:19 +0300
Cc: qemu-devel@nongnu.org, Richard Jones <rjones@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAF66BF6-176E-43A8-B097-85960D81ADCE@gmail.com>
References: <20250427165029.9072-1-nirsof@gmail.com>
 <20250427165029.9072-2-nirsof@gmail.com> <aBuMQSEm9f8JsdoQ@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42d.google.com
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



> On 7 May 2025, at 19:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>=20
> On Sun, Apr 27, 2025 at 07:50:28PM +0300, Nir Soffer wrote:
>> On macOS we need to increase unix stream socket buffers size on the
>> client and server to get good performance. We set socket buffers on
>> macOS after connecting or accepting a client connection.  For unix
>> datagram socket we need different configuration that can be done =
later.
>>=20
>> Testing shows that setting socket receive buffer size (SO_RCVBUF) has =
no
>> effect on performance, so we set only the send buffer size =
(SO_SNDBUF).
>> It seems to work like Linux but not documented.
>>=20
>> Testing shows that optimal buffer size is 512k to 4 MiB, depending on
>> the test case. The difference is very small, so I chose 2 MiB.
>>=20
>> I tested reading from qemu-nbd and writing to qemu-nbd with qemu-img =
and
>> computing a blkhash with nbdcopy and blksum.
>>=20
>> To focus on NBD communication and get less noisy results, I tested
>> reading and writing to null-co driver. I added a read-pattern option =
to
>> the null-co driver to return data full of 0xff:
>>=20
>>    NULL=3D"json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '10g', 'read-pattern': -1}}"
>>=20
>> For testing buffer size I added an environment variable for setting =
the
>> socket buffer size.
>>=20
>> Read from qemu-nbd via qemu-img convert. In this test buffer size of =
2m
>> is optimal (12.6 times faster).
>>=20
>>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
>>    qemu-img convert -f raw -O raw -W -n =
"nbd+unix:///?socket=3D/tmp/nbd.sock" "$NULL"
>>=20
>> | buffer size | time    | user    | system  |
>> |-------------|---------|---------|---------|
>> |     default |  13.361 |   2.653 |   5.702 |
>> |       65536 |   2.283 |   0.204 |   1.318 |
>> |      131072 |   1.673 |   0.062 |   1.008 |
>> |      262144 |   1.592 |   0.053 |   0.952 |
>> |      524288 |   1.496 |   0.049 |   0.887 |
>> |     1048576 |   1.234 |   0.047 |   0.738 |
>> |     2097152 |   1.060 |   0.080 |   0.602 |
>> |     4194304 |   1.061 |   0.076 |   0.604 |
>>=20
>> Write to qemu-nbd with qemu-img convert. In this test buffer size of =
2m
>> is optimal (9.2 times faster).
>>=20
>>    qemu-nbd -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
>>    qemu-img convert -f raw -O raw -W -n "$NULL" =
"nbd+unix:///?socket=3D/tmp/nbd.sock"
>>=20
>> | buffer size | time    | user    | system  |
>> |-------------|---------|---------|---------|
>> |     default |   8.063 |   2.522 |   4.184 |
>> |       65536 |   1.472 |   0.430 |   0.867 |
>> |      131072 |   1.071 |   0.297 |   0.654 |
>> |      262144 |   1.012 |   0.239 |   0.587 |
>> |      524288 |   0.970 |   0.201 |   0.514 |
>> |     1048576 |   0.895 |   0.184 |   0.454 |
>> |     2097152 |   0.877 |   0.174 |   0.440 |
>> |     4194304 |   0.944 |   0.231 |   0.535 |
>>=20
>> Compute a blkhash with nbdcopy, using 4 NBD connections and 256k =
request
>> size. In this test buffer size of 4m is optimal (5.1 times faster).
>>=20
>>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
>>    nbdcopy --blkhash "nbd+unix:///?socket=3D/tmp/nbd.sock" null:
>>=20
>> | buffer size | time    | user    | system  |
>> |-------------|---------|---------|---------|
>> |     default |   8.624 |   5.727 |   6.507 |
>> |       65536 |   2.563 |   4.760 |   2.498 |
>> |      131072 |   1.903 |   4.559 |   2.093 |
>> |      262144 |   1.759 |   4.513 |   1.935 |
>> |      524288 |   1.729 |   4.489 |   1.924 |
>> |     1048576 |   1.696 |   4.479 |   1.884 |
>> |     2097152 |   1.710 |   4.480 |   1.763 |
>> |     4194304 |   1.687 |   4.479 |   1.712 |
>>=20
>> Compute a blkhash with blksum, using 1 NBD connection and 256k read
>> size. In this test buffer size of 512k is optimal (10.3 times =
faster).
>>=20
>>    qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock "$NULL" &
>>    blksum "nbd+unix:///?socket=3D/tmp/nbd.sock"
>>=20
>> | buffer size | time    | user    | system  |
>> |-------------|---------|---------|---------|
>> |     default |  13.085 |   5.664 |   6.461 |
>> |       65536 |   3.299 |   5.106 |   2.515 |
>> |      131072 |   2.396 |   4.989 |   2.069 |
>> |      262144 |   1.607 |   4.724 |   1.555 |
>> |      524288 |   1.271 |   4.528 |   1.224 |
>> |     1048576 |   1.294 |   4.565 |   1.333 |
>> |     2097152 |   1.299 |   4.569 |   1.344 |
>> |     4194304 |   1.291 |   4.559 |   1.327 |
>>=20
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>> io/channel-socket.c | 32 ++++++++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>>=20
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..06901ab694 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -21,6 +21,7 @@
>> #include "qapi/error.h"
>> #include "qapi/qapi-visit-sockets.h"
>> #include "qemu/module.h"
>> +#include "qemu/units.h"
>> #include "io/channel-socket.h"
>> #include "io/channel-util.h"
>> #include "io/channel-watch.h"
>> @@ -37,6 +38,33 @@
>>=20
>> #define SOCKET_MAX_FDS 16
>>=20
>> +/*
>> + * Testing shows that 2m send buffer gives best throuput and lowest =
cpu usage.
>> + * Changing the receive buffer size has no effect on performance.
>> + */
>> +#ifdef __APPLE__
>> +#define UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE (2 * MiB)
>> +#endif /* __APPLE__ */
>> +
>> +static void qio_channel_socket_set_buffers(QIOChannelSocket *ioc)
>> +{
>> +    if (ioc->localAddr.ss_family =3D=3D AF_UNIX) {
>> +        int type;
>> +        socklen_t type_len =3D sizeof(type);
>> +
>> +        if (getsockopt(ioc->fd, SOL_SOCKET, SO_TYPE, &type, =
&type_len) =3D=3D -1) {
>> +            return;
>> +        }
>> +
>> +#ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
>> +        if (type =3D=3D SOCK_STREAM) {
>> +            const int value =3D UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
>> +            setsockopt(ioc->fd, SOL_SOCKET, SO_SNDBUF, &value, =
sizeof(value));
>> +        }
>> +#endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
>> +    }
>> +}
>=20
> While I'm not doubting your benchmark results, I'm a little uneasy =
about
> setting this unconditionally for *all* UNIX sockets QEMU creates. The
> benchmarks show NBD benefits from this, but I'm not convinced that all
> the other scenarios QEMU creates UNIX sockets for justify it.
>=20
> On Linux, whatever value you set with SO_SNDBUF appears to get doubled
> internally by the kernel.
>=20
> IOW, this is adding 4 MB fixed overhead for every UNIX socket that
> QEMU creates. It doesn't take many UNIX sockets in QEMU for that to
> become a significant amount of extra memory overhead on a host.
>=20
> I'm thinking we might be better with a helper
>=20
>  qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc, size_t =
size)
>=20
> that we call from the NBD code, to limit the impact. Also I think this
> helper ought not to filter on AF_UNIX - the caller can see the socket
> type via qio_channel_socket_get_local_address if it does not already
> have a record of the address, and selectively set the buffer size.

So you suggest to move also UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE to nbd?

If we use this only for nbd this is fine, but once we add another caller =
we will
to duplicate the code selecting the right size for the OS. But I guess =
we can=20
reconsider this when have this problem.

>=20
>=20
>> +
>> SocketAddress *
>> qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>                                      Error **errp)
>> @@ -174,6 +202,8 @@ int =
qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>     }
>> #endif
>>=20
>> +    qio_channel_socket_set_buffers(ioc);
>> +
>>     qio_channel_set_feature(QIO_CHANNEL(ioc),
>>                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
>>=20
>> @@ -410,6 +440,8 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>>     }
>> #endif /* WIN32 */
>>=20
>> +    qio_channel_socket_set_buffers(cioc);
>> +
>>     qio_channel_set_feature(QIO_CHANNEL(cioc),
>>                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
>>=20
>> --=20
>> 2.39.5 (Apple Git-154)
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange:|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com:|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange:|



