Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EED0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 12:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7D1a-00055y-Pz; Tue, 22 Apr 2025 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u7D1P-00053t-Qh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:46:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u7D1N-0006nH-F7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 08:46:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso37627345e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745325996; x=1745930796; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iQTGN+TteLuOp/1D7V3HaTlGv65WEvjjkUwwWo/he4=;
 b=jIB25pumejEFUN/3QZMiKWfXTAUn/yxNDVchjtxYRvAKvcqBndDeRs2SrZwiig4lUS
 rM1IZE0onlVIKYPZ9b/sbFx12AMOOLakOeDwwVH6pFcHH5Txfh+1wSJgPWjMezqFEycl
 5+pjS5AWsMg56P855p+8Af+M4RkfYGhskHCAhUto3a9NlmUbQa5HP/GX5lkrJE4pnEEV
 5X8W8sifmrCbm4Edw8TGO6VuaDfrjx7oOVzTa9Fl8HErZX/BTlfMLU2zrrOHlTydw2+Z
 dNk56tldysM3t1ioeMkzP/385ppSH02rH7SDj++yZr9Iky7DBX1dveV3MpTJrYklGciU
 QFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745325996; x=1745930796;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iQTGN+TteLuOp/1D7V3HaTlGv65WEvjjkUwwWo/he4=;
 b=jYcmt28V3TZ57F7KeMyGDqo6F7cNiuqOfYQJm4ZdkqF84p3FpMVSEYeSeZXng3bOPS
 ltJBGugTNVac7WDF1jQgPt9DjxJMz6mqncMLxpZnMiGA3Wlh43mLwfMTq8nAr1JDhcmY
 CqwQ23haJ1u5XGkaukWcjSm9rZM+NRqzO8R9PfhS7qz06eF+JrhURx/syDCFpzyTB4c8
 +lBhX/KqSsf1SvECW3GXpuohKZ9jZnW9YIwHettVl7AWkpVnxlCEnZsuotdVgz/j0jqF
 yrDeQ7hTngycObW2DcqAF4EEFiyQwPhWqSzt7IYe0QJAqaGnkzLif+9swDL00C81eFXV
 CDfg==
X-Gm-Message-State: AOJu0YwjHVsH4yPRJxq3GJhBaquWqFSs2gVetWa2Rrt/W1Bgkqv6Ikua
 gKyj/FIdsE4/Zp9v4mNS5dPlD6kU4aXB3V2I8oULFsG4dIMtpLlCbRYtGQ==
X-Gm-Gg: ASbGnctNq/Yfbgv2fHzEnk0vynSNMNTGCx9JV6FtOSW6IztzIJhbbQiTyKnleACAlaQ
 /Sf05Sng1s2w692lb7ApECbeISXjRwhk/qBWEux9hxPj7uUsG79oaH+/Y6pAe8SYc/Cwv2zcEN8
 YWMep2UY/C9YvOccFxrCAwlCB/9VHUBKCJPcfFJxHjp5yR9q24WXozvYb0BE3iiq1Su41f4FtI2
 sKZtC7aq+5wy6Y2Gq/Cxdy9ln4UtKfqQyA2X93E0MGoJJLUMmXk55GpoIOCYdt/kW+PrLLFtO0w
 zAgC9OSNSQ4xIfsmeoZtlsO1ktp940a1khEjZsqt8RbQJxO+vrrjhTBCov9RqfAS4uIvH2Xa9Ml
 +LkwPcMirf4YN+aGOilgTE2WwXGg=
X-Google-Smtp-Source: AGHT+IFfBVHX/WOCLOxRadNbCWEp2PNKN8lpAgtznb/kSOuwc+G1uZ+8UPiUq/Gx3LE/uhqFftu8aQ==
X-Received: by 2002:a05:600c:3154:b0:43d:36c:f24 with SMTP id
 5b1f17b1804b1-4406ab97d6amr128094885e9.13.1745325995620; 
 Tue, 22 Apr 2025 05:46:35 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5accddsm171424685e9.9.2025.04.22.05.46.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:46:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] io: Increase unix socket buffers size on macOS
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <aAdylVf7RZVaTee3@redhat.com>
Date: Tue, 22 Apr 2025 15:46:22 +0300
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Jones <rjones@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFA461B8-2D2A-4B73-B2C5-535083A50124@gmail.com>
References: <20250419231218.67636-1-nirsof@gmail.com>
 <aAdylVf7RZVaTee3@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32a.google.com
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


> On 22 Apr 2025, at 13:42, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Sun, Apr 20, 2025 at 02:12:18AM +0300, Nir Soffer wrote:
>> On macOS we need to increase unix socket buffers size on the client =
and
>> server to get good performance. We set the socket buffers on macOS =
after
>> connecting or accepting a client connection.
>>=20
>> Testing with qemu-nbd shows that reading an image with qemu-img =
convert
>> from qemu-nbd is *11.4 times faster* and qemu-img cpu usage is *8.3 =
times
>> lower*.
>>=20
>> | qemu-img | qemu-nbd | time   | user   | system |
>> |----------|----------|--------|--------|--------|
>> | before   | before   | 12.957 |  2.643 |  5.777 |
>> | after    | before   | 12.803 |  2.632 |  5.742 |
>> | before   | after    |  1.139 |  0.074 |  0.905 |
>> | after    | after    |  1.179 |  0.077 |  0.931 |
>>=20
>> For testing buffers size I built qemu-nbd and qemu-img with send =
buffer
>> size from 64k to 2m. In this test 256k send buffer and 1m receive =
buffer
>> are optimal.
>>=20
>> | send buffer | recv buffer | time   | user   | system |
>> |-------------|-------------|--------|--------|--------|
>> |         64k |        256k |  2.233 |  0.290 |  1.408 |
>> |        128k |        512k |  1.189 |  0.103 |  0.841 |
>> |        256k |       1024k |  1.121 |  0.085 |  0.813 |
>> |        512k |       2048k |  1.172 |  0.081 |  0.953 |
>> |       1024k |       4096k |  1.160 |  0.072 |  0.907 |
>> |       2048k |       8192k |  1.309 |  0.056 |  0.960 |
>>=20
>> Using null-co driver is useful to focus on the read part, but in the
>> real world we do something with the read data. I tested real world =
usage
>> with nbdcopy and blksum.
>>=20
>> I tested computing a hash of the image using nbdcopy, using 4 NBD
>> connections and 256k request size. In this test 1m send buffer size =
and
>> 4m receive buffer size are optimal.
>>=20
>> | send buffer | recv buffer | time   | user   | system |
>> |-------------|-------------|--------|--------|--------|
>> |         64k |        256k |  2.832 |  4.866 |  2.550 |
>> |        128k |        512k |  2.429 |  4.762 |  2.037 |
>> |        256k |       1024k |  2.158 |  4.724 |  1.813 |
>> |        512k |       2048k |  1.777 |  4.632 |  1.790 |
>> |       1024k |       4096k |  1.657 |  4.466 |  1.812 |
>> |       2048k |       8192k |  1.782 |  4.570 |  1.912 |
>>=20
>> I tested creating a hash of the image with blksum, using one NBD
>> connection and 256k read size. In this test 2m send buffer and 8m
>> receive buffer are optimal.
>>=20
>> | send buffer | recv buffer | time   | user   | system |
>> |-------------|-------------|--------|--------|--------|
>> |         64k |        256k |  4.233 |  5.242 |  2.632 |
>> |        128k |        512k |  3.329 |  4.915 |  2.015 |
>> |        256k |       1024k |  2.071 |  4.647 |  1.474 |
>> |        512k |       2048k |  1.980 |  4.554 |  1.432 |
>> |       1024k |       4096k |  2.058 |  4.553 |  1.497 |
>> |       2048k |       8192k |  1.972 |  4.539 |  1.497 |
>>=20
>> In the real world tests larger buffers are optimal, so I picked send
>> buffer of 1m and receive buffer of 4m.
>=20
> IIUC all your test scenarios have recv buffer x4 size of send buffer.
>=20
> Do you have any link / reference for the idea that we should be using
> this x4 size multiplier ? This feels rather peculiar as a rule.

The x4 factor came from this:
=
https://developer.apple.com/documentation/virtualization/vzfilehandlenetwo=
rkdeviceattachment/maximumtransmissionunit?language=3Dobjc

> The client side of the associated datagram socket must be properly =
configured
> with the appropriate values for SO_SNDBUF, and SO_RCVBUF. Set these =
using the
> setsockopt(_:_:_:_:_:) system call. The system expects the value of =
SO_RCVBUF
> to be at least double the value of SO_SNDBUF, and for optimal =
performance, the
> recommended value of SO_RCVBUF is four times the value of SO_SNDBUF.

This advice is wrong since with unix datagram socket the send buffer is =
not used
for buffering. It only determines the maximum datagram that can be sent. =
This is
not documented in macOS, but documented in FreeBSD manual. I tested this =
for=20
Vmnet-helper, using 65k send buffer (largest packet size when using =
offloading)
and 4m receive buffer.

This configuration (1m send buffer, 4m receive buffer) is used in many =
projects
using the virtiaulization framework (lima, vfkit, softnet). This is why =
I started
with this configuration. But these projects use it for unix datagram =
socket and=20
the advice may not be relevant to unix stream socket.=20

This is what we have in macOS manuals about the values:

getsockopt(2)

     SO_SNDBUF and SO_RCVBUF are options to adjust the normal buffer =
sizes
     allocated for output and input buffers, respectively.  The buffer =
size
     may be increased for high-volume connections, or may be decreased =
to
     limit the possible backlog of incoming data.  The system places an
     absolute limit on these values.

>=20
> Can you show test result grid matrix for the incrementing these
> send/recv buffers independently ?
>=20

Sure, I think testing with the same value and with default value for =
receive buffer
will show if this make a difference for read.

Note that I tested only read - in this case the client send small nbd =
read command
(~32 bytes) and receives nbd structured reply with 2m of payload (2m + =
~32 bytes).
Changing the client send and receive buffer shows very little change, so =
it is likly
that only the send buffer on the server side matter in this case. We =
need to test
also write to nbd. =20



