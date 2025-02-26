Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3243BC021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 04:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn9Tw-0006SB-1G; Tue, 25 Feb 2025 23:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tn9Tt-0006S0-Un
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 23:57:13 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tn9Tr-0001vX-LS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 23:57:13 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220e6028214so139276965ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 20:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1740545829; x=1741150629;
 darn=nongnu.org; 
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CHTaSnYAThej+8730P0CwtDAUDA1nPOOzm1cksT3a50=;
 b=AgxyhlcqAgo8TLlnetiZ8wjR582q0aF/sjXxxm6VmXmHIP71k2XEs9rvYFpbVYI6sX
 cT0XFh5aureauq1zzQCGMyZuBC0uVnfqCOMJEC0Yjb0dzu0yo6tAcVpih59PLX++eNVb
 NjWpjXrKYO13e/zjIqxWlSzfAEgcAj59y3LU+DeZ5kr1dNILkYWc50jXQa647AVanUSo
 DvdNK4ISnB1L0vAT/VoCc08izZCCR/ct/BAXdtBeRY1OARbocVFPeE98f8Pzmb8wGsN1
 swHMfJR+p8W82oGUFb7d3IDdeRp5/TQlpWAKW0kE0oyM0XVETkTE1zcHiuL0bJVVFG61
 5Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740545829; x=1741150629;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHTaSnYAThej+8730P0CwtDAUDA1nPOOzm1cksT3a50=;
 b=Hhf1v7skV86PwuNDIqXrwz+mKmniFa6p8Hq3RkUC020y0Dh90f2VkbinF5+GFGpLxt
 bCPtf8YJ8rg+pvdliwAQFhNYrB8flcST8i8Gmg9+pZZ7C/kodGSVrJsdEFLDTrAYOgPG
 nACQp0KDg0L1SNZTOzZhnG0Sm6j6bH31jWO54rGmo59uXUPLRo3hatG6b9zbt6AR/fiS
 67LLna28E52aWlB5t55sCDdP7+wU1K0pG3oj0KVAsMZMPz2PmGYMf5TihNH2ppC/Oj6g
 uuBcroknA3wEqSPEiDvROC8oWuhsrJUDUBVKCfb/5u1cji4Pics94X9tJ84r3ZALkhM4
 IY1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtSGv9XptMDhyVr96kn9LdKq6eAaFFxzaSCdpBkEv07EdGhd9nxJIGlAZWWIlBFQDBKinMGX1rjWvR@nongnu.org
X-Gm-Message-State: AOJu0YwaO+VAU107rHKJov9dytZj2S/rWww5HHefUZM3Aog8SrEBH1Ly
 XwngqukDUqt/AnrLfCmC/6shIj0WK27fnY7Kgm5bgBb3OYEOklLOBLjE8QeB2+0=
X-Gm-Gg: ASbGncuTFrWdpfnuoBLRrdUxQifEDQPM35QoP566SzVKj0YQEIfjQeKSxNVyvCNs2cA
 shQ9rXT33T1mEyauRVWOXrzdFr9wid9cjXy3ppyWcR/mjOve2JViXfyVpBsbQauAPfxXBq9BOeU
 nGZBFAFtqOjszGbKLK53HqESrXaD6F63MF+RU5vhprp3Yn0OsEHyaMzxk1IV3e94oH7VM7A9z4k
 rSy6ORAkjX8Rhml/SghPUjqGzN7kH5HYPE9bX99ERPGGyCDuaNlF95a3Ob7dU+vkd/ODjUkhx+c
 sI8unBC/RWOi9YWRgBWDzi4ji9HyHODOu7srow==
X-Google-Smtp-Source: AGHT+IGlr58+55jfCZ9qNR/zozxDTSjxrjmTxFLoTdI6hNNdCwFjdS+ji0fJVdjesHjxx/WHXanVeA==
X-Received: by 2002:a05:6a00:13a2:b0:730:927c:d451 with SMTP id
 d2e1a72fcca58-73426d989a0mr31619706b3a.20.1740545828183; 
 Tue, 25 Feb 2025 20:57:08 -0800 (PST)
Received: from smtpclient.apple ([156.226.172.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a7f7de2sm2542494b3a.106.2025.02.25.20.57.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2025 20:57:07 -0800 (PST)
From: Haoqian He <haoqian.he@smartx.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] chardev: use remoteAddr if the chardev is client
Date: Wed, 26 Feb 2025 12:56:55 +0800
References: <20250225104526.2924175-1-haoqian.he@smartx.com>
 <CAJ+F1CLTXwgbJzxNiK7ZyrK_-ToD2ibwU8WR27y3w4Mj5O+eVw@mail.gmail.com>
 <C7E4AAD7-657F-4109-9627-49EB9F4CD7DA@smartx.com>
 <CAJ+F1C+hoQAUfvn6FN=TJ74vWaSfqa-rxa3HCOPe7gBDz3P=tA@mail.gmail.com>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
In-Reply-To: <CAJ+F1C+hoQAUfvn6FN=TJ74vWaSfqa-rxa3HCOPe7gBDz3P=tA@mail.gmail.com>
Message-Id: <EBF8821F-91BA-4EB4-AAD0-E4D00696941B@smartx.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


> 2025=E5=B9=B42=E6=9C=8825=E6=97=A5 21:29=EF=BC=8CMarc-Andr=C3=A9 =
Lureau <marcandre.lureau@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Haoqian
>=20
> On Tue, Feb 25, 2025 at 5:19=E2=80=AFPM Haoqian He =
<haoqian.he@smartx.com> wrote:
>>=20
>> I use chardev to connect with a vhost-user target, the chardev =
backend type is
>> socket, part of QEMU boot parameter:
>>  -device =
vhost-user-blk-pci,chardev=3Dmy-vhost-blk-0,id=3Dmy-vhost-blk-0,\
>>  bus=3Dpci.1,addr=3D0x1,bootindex=3D1,num-queues=3D4 \
>>  -chardev socket,id=3Dmy-vhost-blk-0,path=3D/tmp/vhost-blk.1
>>=20
>> I want to log the chardev=E2=80=99s socket path when socket =
successfully connected
>> in tcp_chr_connect (chr->filename), but i got "unix:" instead of the =
expected
>> "unix:/tmp/vhost-blk.1".
>>=20
>> The chr->filename was computed from the function =
qemu_chr_compute_filename,
>> which always return the unix path store by local QIOChannelSocket =
localAddr.
>>=20
>> Unfortunately, the localAddr is obtained via getsockname (see the =
function
>> qio_channel_socket_set_fd), and according to the man page:
>> "getsockname() returns the current address bound by the socket =
sockfd".
>>=20
>> In this scenario, the socket client's sockfd is unbonded, so the =
socket
>> filename in localAddr(ss) is NULL.
>> As a solution, we can use remoteAddr(ps) obtained by getpeername (see =
the
>> function qio_channel_socket_set_fd).
>>=20
>=20
> thanks a lot, I didn't notice ps !=3D ss in the patch. That makes =
sense.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

Thanks, Lureau.

--
Haoqian=

