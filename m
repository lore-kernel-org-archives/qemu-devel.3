Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F36C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5rvK-0004AA-9J; Fri, 18 Apr 2025 16:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5rvE-00049U-N8
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:02:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5rvA-0002tj-Kt
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 16:02:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso19148935e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745006562; x=1745611362; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbiIE4HUHobA4uFW5hDHtP91hI/lPNZy5c3JrOyPln0=;
 b=VUwibsow+a7p84VHJNvya8Ru5ZJV2Gb09ScjBkmyU3druNvxgtuZqFC6TR1ypmR2wa
 KeYtvsYxtaXHrlonShVx4ppFrRj3vdefzjOSOdd/71gE+BG7MmseHDQw+LFpoBBNTNY4
 2dZW0204fLJWa/wKFODf24iI1R2eV0OhxdWpqqhqcpKIKc3tLZr+l6/guBiiiGcboax3
 ml18Dz6c1rD4OR3pdCrADmUADeeczNQ0WkmK6J3sosTD5Z8szXac4p3gEsSRkFEtbP5Y
 rkFfDKFQbTfV1BuCr9ppTkDvi0Fd2Y2ToBXP4WvqVz1hCL0o/uj9H/8VLX92F5Vg+n4q
 ia8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745006562; x=1745611362;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbiIE4HUHobA4uFW5hDHtP91hI/lPNZy5c3JrOyPln0=;
 b=exI8t7brq7nTh0tYJr6KllKZNgGLoWbz0QAfN5iZL0vjy5r6fqAk88/RcC74l0ImLX
 W/1VHrquWSXQE4zdEcOeh+hpJIaHRdGDmMgoAGE6EofzRrnf9VqxZAT8yTu7iUhLfz2X
 pzxbngqI0PICkWc6Eu+LluPHC9UD/yOcOsuxz6OK62OXrey+wOawyswZsQOG75YB+8CZ
 PhSkT8IjQeZrbLHDYlqsELlbtulWQhLFOm3kpU1ZOUDuYOm5ABpqhZdmFg/UwMNgp3Tl
 An3I7z8LbwZVq7O7SsebHr9LCiknar9VrMUvtmvqtGLe66I+uuqq+bQ+s789XmpnjjrO
 vhIA==
X-Gm-Message-State: AOJu0Yz3LEcoTNCk58lOI6mH1QDUm1PYrMz5Gv5xJP0CPRlMJlJ4BjqC
 TKAqea7ICt/fVMmrvpAxyezQHeohUuJ5kAwuUbhDqo0anYxUduZ5cTarkQ==
X-Gm-Gg: ASbGncugAGKpOoHPziu4pxz3s3MuBzFDUw+W5AuPvTwLsypZQPRzj+X6Axqa/m7erp+
 Cc/3kKTPdGJNt/lBa/27gtITTST0X9ZdO2NXfIdQ2fksnNCB2bQGv98uMAPHI1LnnGJ8nqWgQow
 AmILyGnAIIbZ/+Q5WQvKSXAt3I4AqSVrFpGd2NTR5BPdSFtV7PEbCViHN4+VOpFGbNaGMGybo0T
 O/03xl8NKWP+K0HUYCvPCBoATnehSQN0Qec2tnQAEID2fr+0t9KgNVA7QA299UrHd05a7mhk8dR
 0xE4tEDxiN8lfJe5DPfeWDboeUE7lsec9eoY8i199ywAHbcilY35wfcX9sn3/uSuWOZHS6zmFvV
 YA5Gu6/ral2hjOXNr
X-Google-Smtp-Source: AGHT+IH1dn8wAJXfH6kLw0k3pFDeoRl29g9wahuZD++Jnq8NQqtrjJVwQC5/O3wXMahBlno0/6e3MQ==
X-Received: by 2002:a05:600c:8508:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-4406aba4af7mr41460845e9.15.1745006561863; 
 Fri, 18 Apr 2025 13:02:41 -0700 (PDT)
Received: from smtpclient.apple (89-138-169-5.bb.netvision.net.il.
 [89.138.169.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa49313asm3623762f8f.75.2025.04.18.13.02.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Apr 2025 13:02:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] io: Set unix socket buffers on macOS
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <20250418142436.6121-1-nirsof@gmail.com>
Date: Fri, 18 Apr 2025 23:02:30 +0300
Cc: Daniel Berrange <berrange@redhat.com>, Richard Jones <rjones@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFC11CAB-35FE-40F0-893F-DCA70BD364A4@gmail.com>
References: <20250418142436.6121-1-nirsof@gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x331.google.com
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

This should be changed also on the client side.

The libnbd part is here:
https://gitlab.com/nbdkit/libnbd/-/merge_requests/21

We may want to change also the nbd client code used in qemu-img. I can =
look at this later.


> On 18 Apr 2025, at 17:24, Nir Soffer <nirsof@gmail.com> wrote:
>=20
> Testing with qemu-nbd shows that computing a hash of an image via
> qemu-nbd is 5-7 times faster with this change.
>=20
> Tested with 2 qemu-nbd processes:
>=20
>    $ ./qemu-nbd-after -r -t -e 0 -f raw -k /tmp/after.sock =
/var/tmp/bench/data-10g.img &
>    $ ./qemu-nbd-before -r -t -e 0 -f raw -k /tmp/before.sock =
/var/tmp/bench/data-10g.img &
>=20
> With nbdcopy, using 4 NBD connections:
>=20
>    $ hyperfine -w 3 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:"
>                     "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/after.sock' null:"
>    Benchmark 1: ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:
>      Time (mean =C2=B1 =CF=83):      8.670 s =C2=B1  0.025 s    [User: =
5.670 s, System: 7.113 s]
>      Range (min =E2=80=A6 max):    8.620 s =E2=80=A6  8.703 s    10 =
runs
>=20
>    Benchmark 2: ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/after.sock' null:
>      Time (mean =C2=B1 =CF=83):      1.839 s =C2=B1  0.008 s    [User: =
4.651 s, System: 1.882 s]
>      Range (min =E2=80=A6 max):    1.830 s =E2=80=A6  1.853 s    10 =
runs
>=20
>    Summary
>      ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/after.sock' null: =
ran
>        4.72 =C2=B1 0.02 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:
>=20
> With blksum, using one NBD connection:
>=20
>    $ hyperfine -w 3 "blksum 'nbd+unix:///?socket=3D/tmp/before.sock'" =
\
>                     "blksum 'nbd+unix:///?socket=3D/tmp/after.sock'"
>    Benchmark 1: blksum 'nbd+unix:///?socket=3D/tmp/before.sock'
>      Time (mean =C2=B1 =CF=83):     13.606 s =C2=B1  0.081 s    [User: =
5.799 s, System: 6.231 s]
>      Range (min =E2=80=A6 max):   13.516 s =E2=80=A6 13.785 s    10 =
runs
>=20
>    Benchmark 2: blksum 'nbd+unix:///?socket=3D/tmp/after.sock'
>      Time (mean =C2=B1 =CF=83):      1.946 s =C2=B1  0.017 s    [User: =
4.541 s, System: 1.481 s]
>      Range (min =E2=80=A6 max):    1.912 s =E2=80=A6  1.979 s    10 =
runs
>=20
>    Summary
>      blksum 'nbd+unix:///?socket=3D/tmp/after.sock' ran
>        6.99 =C2=B1 0.07 times faster than blksum =
'nbd+unix:///?socket=3D/tmp/before.sock'
>=20
> This will improve other usage of unix domain sockets on macOS, I =
tested
> only qemu-nbd.
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
> io/channel-socket.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..b858659764 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>     }
> #endif /* WIN32 */
>=20
> +#if __APPLE__
> +    /* On macOS we need to tune unix domain socket buffer for best =
performance.
> +     * Apple recommends sizing the receive buffer at 4 times the size =
of the
> +     * send buffer.
> +     */
> +    if (cioc->localAddr.ss_family =3D=3D AF_UNIX) {
> +        const int sndbuf_size =3D 1024 * 1024;
> +        const int rcvbuf_size =3D 4 * sndbuf_size;
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, =
sizeof(sndbuf_size));
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, =
sizeof(rcvbuf_size));
> +    }
> +#endif /* __APPLE__ */
> +
>     qio_channel_set_feature(QIO_CHANNEL(cioc),
>                             QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
>=20
> --=20
> 2.39.5 (Apple Git-154)
>=20


