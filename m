Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8AAC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vHU-00030A-OL; Mon, 06 May 2024 06:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s3vHP-0002xw-LJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:09:09 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s3vHJ-00086H-DM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:09:06 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59b097b202so228429366b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714990135; x=1715594935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1DL2p9VPXsM5PHDrzeL/vKvwcqg+MyeXTVFoF/578Y=;
 b=Jzp7uNDBJpBwKUaSYkzD5II2i1a0xVGe4ZTsSO0Zmn58TPstBQVTdi/2S2xfQZ9tFr
 V3E4Vn1N7vTkR4og7UEmSaO74HFiv5h1BOYh1s7nztp+8vFT68GWu2Ty57rzp3lFaosP
 4bQwvTrIbXoxIkmo7SgWYeYGTlOI4wVn8bT1K+7qyJERrewAgm60H3ItagcVstoeQtbs
 Nhvhfe142Skd42bFEgQ333nmlMN2mZ5fRYOfCw9YEWErpQlQ6EJgIOXY3dbEQV22Jagq
 OlH/6GMi3IjSKiIuXmbDaEIRunwMXTQOVCWshXRWGD0R9gK/gj/jiM2PsRslKtt7sUld
 kFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714990135; x=1715594935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1DL2p9VPXsM5PHDrzeL/vKvwcqg+MyeXTVFoF/578Y=;
 b=lfHhHoy4JlDACxRiCOVFpW1D4+86h+GSHwgvLFwAiAGUiy+mu+cscJVfLnZtRraIrt
 8NtquWYDBfOYFDO8oMT7kXGUZvCu4w3GCsDe4RGYOjFd3TfbcIQtVPASSTPb/jlG3avD
 Vt3qauFl+2JYDRybY0WZx/+JS3rzJtVecfNQ3bXpC0UASWZxS2or2/IMbNfc25RD/voa
 ZhRKtbGVTx1chRfZlGFaH0dsAcLt/EnYc8ln3rr8UyC4fQxtFw0VsQCY2gWkq99rMhW6
 AMDPz1giP/oO7zxsDclvvjw8d4pNdN0SDERpRwYyfT2S7qw1t1a3OWVwNFOT+DwqyRCP
 +hZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXplq+Vy4Ym8ypCoWwLbCPJjuPS6CLu5HSYlL3Su/IGrRZkRJ80ZXlYRLEXMJ7yevxb5mCIkUiIEjRFn1vQomx2z1JnIJc=
X-Gm-Message-State: AOJu0YxpfCzNyYN5jtZuZKTIXusQPkiyTdcQnIYMSm2QHjmMB1OcU4fW
 6f+QRGIlsAqxsd7Ep05Pmfsi2CaohnnFq+Vb4X+/Pb2r23zk+h25ZifVoZs/VAsnht9wuVrXRut
 WeQXSb7AYm9wJAfkXCbq7xA+vG2D/40JaJJmxdA==
X-Google-Smtp-Source: AGHT+IFHrGUjy9PJ4hNv6l9eTJT3nwCwrZSn/F+0JLy5tDvVyHNFyd27XuxecgUGjHhG/MJPSrzhQq1dV/EczHAlFvY=
X-Received: by 2002:a50:9b56:0:b0:572:a7ec:1a5f with SMTP id
 a22-20020a509b56000000b00572a7ec1a5fmr6574455edj.24.1714990134992; Mon, 06
 May 2024 03:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com>
 <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
 <ZjT1sPh5OaByQmAB@x1n>
In-Reply-To: <ZjT1sPh5OaByQmAB@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 6 May 2024 12:08:43 +0200
Message-ID: <CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>,
 Yu Zhang <yu.zhang@ionos.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::634;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Peter, hi Daniel,

On Fri, May 3, 2024 at 4:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, May 03, 2024 at 08:40:03AM +0200, Jinpu Wang wrote:
> > I had a brief check in the rsocket changelog, there seems some
> > improvement over time,
> >  might be worth revisiting this. due to socket abstraction, we can't
> > use some feature like
> >  ODP, it won't be a small and easy task.
>
> It'll be good to know whether Dan's suggestion would work first, without
> rewritting everything yet so far.  Not sure whether some perf test could
> help with the rsocket APIs even without QEMU's involvements (or looking f=
or
> test data supporting / invalidate such conversions).
>
I did a quick test with iperf on 100 G environment and 40 G
environment, in summary rsocket works pretty well.

iperf tests between 2 hosts with 40 G (IB),
first  a few test with different num. of threads on top of ipoib
interface, later with preload rsocket on top of same ipoib interface.

jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  3] local 10.43.3.146 port 55602 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0001 sec  2.85 GBytes  2.44 Gbits/sec
jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 2
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  4] local 10.43.3.146 port 39640 connected with 10.43.3.145 port 52000
[  3] local 10.43.3.146 port 39626 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0012 sec  2.85 GBytes  2.45 Gbits/sec
[  4] 0.0000-10.0026 sec  2.86 GBytes  2.45 Gbits/sec
[SUM] 0.0000-10.0026 sec  5.71 GBytes  4.90 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.281/0.300/0.318/0.318 ms (tot/err) =3D 2/0
jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 4
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  4] local 10.43.3.146 port 46956 connected with 10.43.3.145 port 52000
[  6] local 10.43.3.146 port 46978 connected with 10.43.3.145 port 52000
[  3] local 10.43.3.146 port 46944 connected with 10.43.3.145 port 52000
[  5] local 10.43.3.146 port 46962 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0017 sec  2.85 GBytes  2.45 Gbits/sec
[  4] 0.0000-10.0015 sec  2.85 GBytes  2.45 Gbits/sec
[  5] 0.0000-10.0026 sec  2.85 GBytes  2.45 Gbits/sec
[  6] 0.0000-10.0005 sec  2.85 GBytes  2.45 Gbits/sec
[SUM] 0.0000-10.0005 sec  11.4 GBytes  9.80 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.274/0.312/0.360/0.212 ms (tot/err) =3D 4/0
jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 8
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  7] local 10.43.3.146 port 35062 connected with 10.43.3.145 port 52000
[  6] local 10.43.3.146 port 35058 connected with 10.43.3.145 port 52000
[  8] local 10.43.3.146 port 35066 connected with 10.43.3.145 port 52000
[  9] local 10.43.3.146 port 35074 connected with 10.43.3.145 port 52000
[  3] local 10.43.3.146 port 35038 connected with 10.43.3.145 port 52000
[ 12] local 10.43.3.146 port 35088 connected with 10.43.3.145 port 52000
[  5] local 10.43.3.146 port 35048 connected with 10.43.3.145 port 52000
[  4] local 10.43.3.146 port 35050 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  4] 0.0000-10.0005 sec  2.85 GBytes  2.44 Gbits/sec
[  8] 0.0000-10.0011 sec  2.85 GBytes  2.45 Gbits/sec
[  5] 0.0000-10.0000 sec  2.85 GBytes  2.45 Gbits/sec
[ 12] 0.0000-10.0021 sec  2.85 GBytes  2.44 Gbits/sec
[  3] 0.0000-10.0003 sec  2.85 GBytes  2.44 Gbits/sec
[  7] 0.0000-10.0065 sec  2.50 GBytes  2.14 Gbits/sec
[  9] 0.0000-10.0077 sec  2.52 GBytes  2.16 Gbits/sec
[  6] 0.0000-10.0003 sec  2.85 GBytes  2.44 Gbits/sec
[SUM] 0.0000-10.0003 sec  22.1 GBytes  19.0 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.096/0.226/0.339/0.109 ms (tot/err) =3D 8/0
jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 16
[  3] local 10.43.3.146 port 49540 connected with 10.43.3.145 port 52000
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  6] local 10.43.3.146 port 49554 connected with 10.43.3.145 port 52000
[  8] local 10.43.3.146 port 49584 connected with 10.43.3.145 port 52000
[  5] local 10.43.3.146 port 49552 connected with 10.43.3.145 port 52000
[ 20] local 10.43.3.146 port 49626 connected with 10.43.3.145 port 52000
[  4] local 10.43.3.146 port 49606 connected with 10.43.3.145 port 52000
[  9] local 10.43.3.146 port 49596 connected with 10.43.3.145 port 52000
[ 10] local 10.43.3.146 port 49604 connected with 10.43.3.145 port 52000
[ 26] local 10.43.3.146 port 49678 connected with 10.43.3.145 port 52000
[  7] local 10.43.3.146 port 49556 connected with 10.43.3.145 port 52000
[ 25] local 10.43.3.146 port 49662 connected with 10.43.3.145 port 52000
[ 22] local 10.43.3.146 port 49636 connected with 10.43.3.145 port 52000
[ 11] local 10.43.3.146 port 49612 connected with 10.43.3.145 port 52000
[ 13] local 10.43.3.146 port 49618 connected with 10.43.3.145 port 52000
[ 23] local 10.43.3.146 port 49646 connected with 10.43.3.145 port 52000
[ 15] local 10.43.3.146 port 49688 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[ 11] 0.0000-10.0024 sec  2.28 GBytes  1.95 Gbits/sec
[ 23] 0.0000-10.0022 sec  2.28 GBytes  1.95 Gbits/sec
[ 20] 0.0000-10.0010 sec  2.28 GBytes  1.95 Gbits/sec
[  8] 0.0000-10.0032 sec  2.28 GBytes  1.95 Gbits/sec
[ 26] 0.0000-10.0038 sec  2.28 GBytes  1.95 Gbits/sec
[ 10] 0.0000-10.0002 sec  2.28 GBytes  1.95 Gbits/sec
[  7] 0.0000-10.0033 sec  2.28 GBytes  1.95 Gbits/sec
[ 15] 0.0000-10.0015 sec  2.27 GBytes  1.95 Gbits/sec
[  4] 0.0000-10.0028 sec  2.28 GBytes  1.95 Gbits/sec
[  6] 0.0000-10.0012 sec  2.28 GBytes  1.96 Gbits/sec
[ 13] 0.0000-10.0030 sec  2.28 GBytes  1.95 Gbits/sec
[ 25] 0.0000-10.0051 sec  2.28 GBytes  1.95 Gbits/sec
[  5] 0.0000-10.0001 sec  2.28 GBytes  1.96 Gbits/sec
[  9] 0.0000-10.0017 sec  2.28 GBytes  1.95 Gbits/sec
[ 22] 0.0000-10.0008 sec  2.27 GBytes  1.95 Gbits/sec
[  3] 0.0000-10.0033 sec  2.28 GBytes  1.95 Gbits/sec
[SUM] 0.0000-10.0034 sec  36.4 GBytes  31.3 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.105/0.217/0.401/0.093 ms (tot/err) =3D 16/0
jwang@ps401a-914.nst:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.3.145 -P 16
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.3.146 port 48902 connected with 10.43.3.145 port 52000
[  5] local 10.43.3.146 port 52777 connected with 10.43.3.145 port 52000
[  9] local 10.43.3.146 port 42911 connected with 10.43.3.145 port 52000
[ 11] local 10.43.3.146 port 56354 connected with 10.43.3.145 port 52000
[ 15] local 10.43.3.146 port 43325 connected with 10.43.3.145 port 52000
[  6] local 10.43.3.146 port 37041 connected with 10.43.3.145 port 52000
[  7] local 10.43.3.146 port 58828 connected with 10.43.3.145 port 52000
[ 17] local 10.43.3.146 port 48858 connected with 10.43.3.145 port 52000
[ 13] local 10.43.3.146 port 49256 connected with 10.43.3.145 port 52000
[ 16] local 10.43.3.146 port 35652 connected with 10.43.3.145 port 52000
[  8] local 10.43.3.146 port 48567 connected with 10.43.3.145 port 52000
[ 18] local 10.43.3.146 port 47394 connected with 10.43.3.145 port 52000
[ 19] local 10.43.3.146 port 48065 connected with 10.43.3.145 port 52000
[ 10] local 10.43.3.146 port 39788 connected with 10.43.3.145 port 52000
[  4] local 10.43.3.146 port 46818 connected with 10.43.3.145 port 52000
[ 14] local 10.43.3.146 port 57174 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[ 14] 0.0000-10.0002 sec  2.30 GBytes  1.98 Gbits/sec
[  6] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
[  5] 0.0000-10.0002 sec  2.31 GBytes  1.98 Gbits/sec
[  8] 0.0000-10.0001 sec  2.31 GBytes  1.98 Gbits/sec
[ 11] 0.0000-10.0003 sec  2.31 GBytes  1.98 Gbits/sec
[ 18] 0.0000-10.0003 sec  2.31 GBytes  1.98 Gbits/sec
[  3] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
[  4] 0.0000-10.0005 sec  2.30 GBytes  1.98 Gbits/sec
[ 17] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
[ 15] 0.0000-10.0005 sec  2.31 GBytes  1.98 Gbits/sec
[ 19] 0.0000-10.0001 sec  2.30 GBytes  1.98 Gbits/sec
[  7] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
[ 13] 0.0000-10.0005 sec  2.31 GBytes  1.98 Gbits/sec
[ 10] 0.0000-10.0003 sec  2.30 GBytes  1.98 Gbits/sec
[  9] 0.0000-10.0000 sec  2.31 GBytes  1.98 Gbits/sec
[ 16] 0.0000-10.0002 sec  2.31 GBytes  1.98 Gbits/sec
[SUM] 0.0000-10.0003 sec  36.9 GBytes  31.7 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
88.398/101.706/114.726/24.755 ms (tot/err) =3D 16/0
jwang@ps401a-914.nst:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.3.145 -P 1
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.3.146 port 49168 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  34.3 GBytes  29.5 Gbits/sec
jwang@ps401a-914.nst:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.3.145 -P 2
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.3.146 port 42096 connected with 10.43.3.145 port 52000
[  4] local 10.43.3.146 port 58667 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  4] 0.0000-10.0001 sec  18.4 GBytes  15.8 Gbits/sec
[  3] 0.0000-10.0000 sec  18.5 GBytes  15.9 Gbits/sec
[SUM] 0.0000-10.0001 sec  36.9 GBytes  31.7 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
38.155/38.997/39.839/39.839 ms (tot/err) =3D 2/0
jwang@ps401a-914.nst:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.3.145 -P 4
------------------------------------------------------------
Client connecting to 10.43.3.145, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.3.146 port 36100 connected with 10.43.3.145 port 52000
[  5] local 10.43.3.146 port 55108 connected with 10.43.3.145 port 52000
[  6] local 10.43.3.146 port 41039 connected with 10.43.3.145 port 52000
[  7] local 10.43.3.146 port 34868 connected with 10.43.3.145 port 52000
[ ID] Interval       Transfer     Bandwidth
[  7] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
[  5] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
[  3] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
[  6] 0.0000-10.0001 sec  9.22 GBytes  7.92 Gbits/sec
[SUM] 0.0000-10.0001 sec  36.9 GBytes  31.7 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
51.401/53.644/56.015/30.487 ms (tot/err) =3D 4/0

You can see with rsocket it reaches ~ 30 Gb/s with single stream,
while ipoib only 2.5 Gb/s (12 X), ipoib scales with more threads until
 ~ 32 Gb/s, which is the link limit.

With 100 G env, rsocket also out perform ipoib, see below:


jwang@ps404a-59.stg:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.48.58
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.48.59 port 40588 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  80.7 GBytes  69.4 Gbits/sec
jwang@ps404a-59.stg:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.48.58 -P 2
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 10.43.48.59 port 41813 connected with 10.43.48.58 port 52000
[  5] local 10.43.48.59 port 60638 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  5] 0.0000-10.0000 sec  48.9 GBytes  42.0 Gbits/sec
[  3] 0.0000-10.0000 sec  49.8 GBytes  42.8 Gbits/sec
[SUM] 0.0000-10.0000 sec  98.7 GBytes  84.8 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
6.962/7.764/8.567/8.567 ms (tot/err) =3D 2/0
jwang@ps404a-59.stg:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.48.58 -P 4
[  6] local 10.43.48.59 port 58086 connected with 10.43.48.58 port 52000
[  3] local 10.43.48.59 port 49335 connected with 10.43.48.58 port 52000
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  4] local 10.43.48.59 port 44593 connected with 10.43.48.58 port 52000
[  5] local 10.43.48.59 port 60464 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  5] 0.0000-10.0000 sec  28.0 GBytes  24.0 Gbits/sec
[  4] 0.0000-10.0000 sec  28.0 GBytes  24.0 Gbits/sec
[  3] 0.0000-10.0000 sec  28.0 GBytes  24.1 Gbits/sec
[  6] 0.0000-10.0000 sec  28.0 GBytes  24.1 Gbits/sec
[SUM] 0.0000-10.0001 sec   112 GBytes  96.3 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
7.344/9.619/12.199/5.271 ms (tot/err) =3D 4/0
jwang@ps404a-59.stg:~$
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
52000 -c 10.43.48.58 -P 8
[  3] local 10.43.48.59 port 43020 connected with 10.43.48.58 port 52000
[  7] local 10.43.48.59 port 59720 connected with 10.43.48.58 port 52000
[  4] local 10.43.48.59 port 52547 connected with 10.43.48.58 port 52000
[  8] local 10.43.48.59 port 41712 connected with 10.43.48.58 port 52000
[ 10] local 10.43.48.59 port 53126 connected with 10.43.48.58 port 52000
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  6] local 10.43.48.59 port 60311 connected with 10.43.48.58 port 52000
[  5] local 10.43.48.59 port 44103 connected with 10.43.48.58 port 52000
[  9] local 10.43.48.59 port 49007 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  9] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
[  8] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
[  4] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
[  6] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
[ 10] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
[  7] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
[  5] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
[  3] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
[SUM] 0.0000-10.0001 sec   112 GBytes  96.3 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
6.942/12.361/18.109/4.872 ms (tot/err) =3D 8/0
jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 8
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  4] local 10.43.48.59 port 58176 connected with 10.43.48.58 port 52000
[  5] local 10.43.48.59 port 58180 connected with 10.43.48.58 port 52000
[  3] local 10.43.48.59 port 58178 connected with 10.43.48.58 port 52000
[ 10] local 10.43.48.59 port 58226 connected with 10.43.48.58 port 52000
[ 11] local 10.43.48.59 port 58228 connected with 10.43.48.58 port 52000
[  9] local 10.43.48.59 port 58212 connected with 10.43.48.58 port 52000
[  7] local 10.43.48.59 port 58194 connected with 10.43.48.58 port 52000
[  8] local 10.43.48.59 port 58198 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  9] 0.0000-10.0005 sec  15.8 GBytes  13.5 Gbits/sec
[  4] 0.0000-10.0002 sec  15.8 GBytes  13.6 Gbits/sec
[  3] 0.0000-10.0000 sec  15.8 GBytes  13.6 Gbits/sec
[  5] 0.0000-10.0002 sec  15.8 GBytes  13.6 Gbits/sec
[  8] 0.0000-10.0005 sec  7.89 GBytes  6.78 Gbits/sec
[ 10] 0.0000-10.0000 sec  15.8 GBytes  13.6 Gbits/sec
[ 11] 0.0000-10.0014 sec  7.94 GBytes  6.82 Gbits/sec
[  7] 0.0000-10.0009 sec  15.8 GBytes  13.6 Gbits/sec
[SUM] 0.0000-10.0009 sec   111 GBytes  95.1 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.234/0.325/0.406/0.155 ms (tot/err) =3D 8/0
jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 4
[  3] local 10.43.48.59 port 42548 connected with 10.43.48.58 port 52000
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  4] local 10.43.48.59 port 42558 connected with 10.43.48.58 port 52000
[  5] local 10.43.48.59 port 42560 connected with 10.43.48.58 port 52000
[  6] local 10.43.48.59 port 42562 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  6] 0.0000-10.0000 sec  27.8 GBytes  23.9 Gbits/sec
[  5] 0.0000-10.0001 sec  27.3 GBytes  23.5 Gbits/sec
[  3] 0.0000-10.0001 sec  27.8 GBytes  23.9 Gbits/sec
[  4] 0.0000-10.0001 sec  27.8 GBytes  23.9 Gbits/sec
[SUM] 0.0000-10.0001 sec   111 GBytes  95.1 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.295/0.340/0.390/0.201 ms (tot/err) =3D 4/0
jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 2
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  4] local 10.43.48.59 port 44194 connected with 10.43.48.58 port 52000
[  3] local 10.43.48.59 port 44186 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  48.3 GBytes  41.5 Gbits/sec
[  4] 0.0000-10.0000 sec  41.3 GBytes  35.5 Gbits/sec
[SUM] 0.0000-10.0000 sec  89.7 GBytes  77.0 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.227/0.233/0.240/0.240 ms (tot/err) =3D 2/0
jwang@ps404a-59.stg:~$ pbkvm list
 VM  State  PID  Cores  Mem  VNC  Migration
--------------------------------------------

Total: 0 VMs, Running: 0
jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 1
------------------------------------------------------------
Client connecting to 10.43.48.58, TCP port 52000
TCP window size:  165 KByte (default)
------------------------------------------------------------
[  3] local 10.43.48.59 port 40364 connected with 10.43.48.58 port 52000
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  51.2 GBytes  44.0 Gbits/sec

Thanks!


> Thanks,
>
> --
> Peter Xu
>

