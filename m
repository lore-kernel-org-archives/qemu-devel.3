Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B30C369C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 20:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5sLD-00042y-8u; Fri, 18 Apr 2025 16:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5sL8-00042L-By
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:29:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5sL4-0006At-BB
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:29:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so2319944f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745008167; x=1745612967; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubwsCtkPYLKDsGlXUwhhogNwcOVwa5QICejAAh9J/Q4=;
 b=A6/EwhHUlRxij/FSzAPPoTsPGcCJg49OR7OPs4UP5Bgyck5PHKtRKrWEr7j7ezVmDF
 i/WAoZOlEmqFF5/6k8H8hLFjEVEz2bOUZkfZ+6dyhSszN0HhFg/G3sfTvfG38IJRbgXi
 vDWnfgog27feJ3t74x3Yc0pMsXXLSLucEXP9SVn/fG9J0YLDmv54aUusISd0jOMDqMz7
 8+mnhu3xFBwq242/CQtZKwgN8EsiyKZaFVH+b0SaqfoVuDp6lt5B0QkfLkRmBDbQpH67
 tDWRs1EGyq1C/iKSIXEFZgq+31tzkmrhf6EoP9i8rvQIL7D2t1Osw8UYHVKsgZMq7RRA
 K29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745008167; x=1745612967;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubwsCtkPYLKDsGlXUwhhogNwcOVwa5QICejAAh9J/Q4=;
 b=Pi7DBNWjfaX4+hp9JWiy/giuXcrMYNn31HtiS1IL2aNv8I6OruKp/CEwCxqLPyHQfC
 yn0Sv1tSl3wMMQQsNGdr1ehxadUjqEqcDjT3rTbN2+3L/kZxYYH72AJBAADoWwUnUZ2h
 Hi9ICKTX686BXuw032DQ9PK6GBYuT3wuRVBvO8QcCljCv5OubeTx/WzvHCFPwXj/xE0R
 v982QTux5AzCnVPo7RLUzrEKgamvSetTUsFgjTUjddYEGfFZtihfXsgMv+P73/+iLWoo
 k0/GggLHYGmGrlas4RfJAodlFcvw7ctlOYMiiUDzRfdTlYIfaGF3XM+iBrVRhUWpJPZe
 4B9w==
X-Gm-Message-State: AOJu0Yyywhn5INxOVP0U1ECsrP+9DRE9oday4ZzJh80e5YPBu0Isd+DZ
 jELZt/1elrs/egJUoe0F+pq2wQFq6wUMFkaK4Alrh0zm6Nvx8k75
X-Gm-Gg: ASbGncu674+3t7z/ycrnmfg95RDVUMimzX/PD5r8y3GhtWMkji0tZFioV6GoGdNnWRw
 jNeWksbCCP0/AHEloiwSn2infU2K9eIfmxpkjW3/L82DN84uBS9RXvK8u8ms0Xzlk2YA5WlCG2N
 kL068Uph1VcuK26TX5pBZb26BXl0TKa9veglnW6pb2w66Q1yef1LSu6mprI5iBpEQjsY6TJR6NG
 67p0ld/MSlNjPWlWfLm92yTpaWQar+3lZfRO7VCZTpbr2ag8Znaq9dHEZk+gebY6jaSEIwofUo9
 5AIzLKb6zxqPJmTtTpTFCghwZAmIfXvNobfhQNksw0Ypy6H6bvBdk0c28rFfDzaHqOtA7HWCa8t
 n5dcPXgphjPZOEva7
X-Google-Smtp-Source: AGHT+IHdSByFWr6UhyAdIqjIlWvcPoY6ZCogpGogqZbrjdK6f5KhDGCjDb1iPNT9SvJIWrWaVyaG6w==
X-Received: by 2002:a05:6000:4021:b0:390:f9f9:3e9c with SMTP id
 ffacd0b85a97d-39efba5dd7emr3027102f8f.25.1745008166758; 
 Fri, 18 Apr 2025 13:29:26 -0700 (PDT)
Received: from smtpclient.apple (89-138-169-5.bb.netvision.net.il.
 [89.138.169.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa421c79sm3664604f8f.1.2025.04.18.13.29.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Apr 2025 13:29:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] io: Set unix socket buffers on macOS
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <6g5oovn3afxsczxmejpr4bsiwvwkwvh7jntmiydtbxn3wizt7y@6ulr3j3s7h6s>
Date: Fri, 18 Apr 2025 23:29:14 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>, Richard Jones <rjones@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E94D4B29-1DD8-4C66-9F7C-807BA0BBE789@gmail.com>
References: <20250418142436.6121-1-nirsof@gmail.com>
 <6g5oovn3afxsczxmejpr4bsiwvwkwvh7jntmiydtbxn3wizt7y@6ulr3j3s7h6s>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42c.google.com
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


> On 18 Apr 2025, at 21:55, Eric Blake <eblake@redhat.com> wrote:
>=20
> On Fri, Apr 18, 2025 at 05:24:36PM +0300, Nir Soffer wrote:
>> Testing with qemu-nbd shows that computing a hash of an image via
>> qemu-nbd is 5-7 times faster with this change.
>>=20
>=20
>> +++ b/io/channel-socket.c
>> @@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>>     }
>> #endif /* WIN32 */
>>=20
>> +#if __APPLE__
>> +    /* On macOS we need to tune unix domain socket buffer for best =
performance.
>> +     * Apple recommends sizing the receive buffer at 4 times the =
size of the
>> +     * send buffer.
>> +     */
>> +    if (cioc->localAddr.ss_family =3D=3D AF_UNIX) {
>> +        const int sndbuf_size =3D 1024 * 1024;
>> +        const int rcvbuf_size =3D 4 * sndbuf_size;
>> +        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, =
sizeof(sndbuf_size));
>> +        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, =
sizeof(rcvbuf_size));
>> +    }
>> +#endif /* __APPLE__ */
>=20
> Why does this have to be limited?  On linux, 'man 7 unix' documents
> that SO_SNDBUF is honored (SO_RCVBUF is silently ignored but accepted
> for compatibility).  On the other hand, 'man 7 socket' states that it
> defaults to the value in /proc/sys/net/core/wmem_default (212992 on my
> machine) and cannot exceed the value in /proc/sys/net/core/wmem_max
> without CAP_NET_ADMIN privileges (also 212992 on my machine).
>=20
> Of course, Linux and MacOS are different kernels, so your effort to
> set it to 1M may actually be working on Apple rather than being
> silently cut back to the enforced maximum.

Testing shows values up to 2m send buffer, 8m receive buffer shows the =
values changes the performance, so they are not silently clipped.

> And the fact that raising
> it at all makes a difference merely says that unlike Linux (where the
> default appears to already be as large as possible), Apple is set up
> to default to a smaller buffer (more fragmentation requires more
> time), and bumping to the larger value improves performance.  But can
> you use getsockopt() prior to your setsockopt() to see what value
> Apple was defaulting to, and then again afterwards to see whether it
> actually got as large as you suggested?

Sure, tested with:

diff --git a/io/channel-socket.c b/io/channel-socket.c
index b858659764..9600a076be 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -418,8 +418,21 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
     if (cioc->localAddr.ss_family =3D=3D AF_UNIX) {
         const int sndbuf_size =3D 1024 * 1024;
         const int rcvbuf_size =3D 4 * sndbuf_size;
+        int value;
+        socklen_t value_size =3D sizeof(value);
+
+        getsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &value, =
&value_size);
+        fprintf(stderr, "before: send buffer size: %d\n", value);
+        getsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &value, =
&value_size);
+        fprintf(stderr, "before: recv buffer size: %d\n", value);
+
         setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, =
sizeof(sndbuf_size));
         setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, =
sizeof(rcvbuf_size));
+
+        getsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &value, =
&value_size);
+        fprintf(stderr, "after: send buffer size: %d\n", value);
+        getsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &value, =
&value_size);
+        fprintf(stderr, "after: recv buffer size: %d\n", value);
     }
 #endif /* __APPLE__ */
=20
With 1m send buffer:

% ./qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock ~/bench/data-10g.img
before: send buffer size: 8192
before: recv buffer size: 8192
after: send buffer size: 1048576
after: recv buffer size: 4194304

With 2m send buffer:

% ./qemu-nbd -r -t -e 0 -f raw -k /tmp/nbd.sock ~/bench/data-10g.img
before: send buffer size: 8192
before: recv buffer size: 8192
after: send buffer size: 2097152
after: recv buffer size: 8388608


