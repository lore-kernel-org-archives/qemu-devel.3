Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109ECAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrvb-0006q4-JB; Wed, 17 Sep 2025 09:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyrv5-0006ZE-78
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:10:05 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyrv3-0007Bh-1a
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:09:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ec4d6ba12eso1428276f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758114594; x=1758719394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Nhi0UR3jj1fb8FsfaXvRrhc7WCF6DG+4ikdmpLzz8J0=;
 b=GIBZVnzq2DUF1UrafNRPxGhqvcGdtjxFn0iz7XzkFSowuY2K7xovvoU+2bQb9L7Gso
 2EZqAGoMWHlMB4nQ2GAC1RkFQfWYYxjReyoAMSnVu3vb/Xvk/rIfISwplXvYKr0nLboN
 edatwpnM8/a72DMmliF9wAl2VFNCY+8RpVsgV5L5sWFKaNeckhZHQvrpxd2WN/IFdQG/
 D/pdEB41UzzeHb/NAHR85+0SD7wGIXMMkL7evucCGJxMpemzWcQFCrQ+J0IXRUl8C8//
 jYoCn7C0OIKZ2Hub2h9SpSVRb4t6hWSp6FfbW26u6M7wniwO3gluz3FIXZTNHGD01qLU
 Zn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758114594; x=1758719394;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nhi0UR3jj1fb8FsfaXvRrhc7WCF6DG+4ikdmpLzz8J0=;
 b=fI8aVVhakt5+rsJpotPmhNyf2wK7s3fKWIX6uxD+Agnn5sDBfzUaf1zd4vD1ewxAR3
 Eyiy0hmHwbb5vZulmC0400Sru+xxqrxTAhOpA+UA0Oox0dgD9aSAbVHKJVtqtWLS9PR9
 xQm1QPv2MFGRkcEKhPwEwK5//exdyty4HxOPdizxvE0Gy2s0KZkePwivrwc8NMb1Zwci
 a4jjStJhn6zkcjxcuoSmIxVZTydxmxiFexqnEzOYwfAp/zCWhYSo4cTTpDqA7+rx7nfn
 I0yZjgCAoMQ4+XFkk0fAxBxT0DPaabuNz9pWzWr2xfjBPGIC/fPEC55LlveAd3wnm1NU
 2RKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHk3lYiu8RZ87PkPfVlL5Wm2GTF2hVpwRPNMhf1VjU6NREC8PopHUwQJJ1Fu9EdT/oyKma9icVslFh@nongnu.org
X-Gm-Message-State: AOJu0YwV57X4e51uGzmSd1hT57S5OKnnVRIV3lbl4YH6rI6sxSDtby/T
 xedlQLxXZ7GrtcEozGLc+9nsCUYu9DXA/6TgdsnEP9uA3Cq5moSM2WNN
X-Gm-Gg: ASbGnctQL4/yzlj3IcJc9bPxYFfV/Uo8iBqG+1v37Btbv3LIBjSJCRXuZo3uBM33JPA
 HiY+dNiEKrygKe/VluMKsskdCKaz3nsOjjVz7EChK+XLKWRX1FaU0b7rTX7ZyK52zEqoDdQsI3R
 xF4IFM5RmwyoBy8c/b9HZHEvg5XcXXDSo2Esi8VEtlmaWWwaMqAz8BQIjAh30n17FkFg8pk719/
 ZmYi0dLXODKJV/z+jpMnfD+Wacv+2wtZpEmtpA+DtRH4sOIvdnZ2ZTkrv1d86XXHijKmdYBMto2
 CeAwc+3nI0av+ejnEloFo5C3qKRAbtapDGwpXgW0CvDJXcwgwu10SdR7W2mroYHtQVqeWQU1ClZ
 Uwv8WPtM4TSMZJ6qDcd6x1l4j776WZRNqeBptMmwHn0+HPimD+f73MX3pE6CbJg==
X-Google-Smtp-Source: AGHT+IH3+xZJsR3L/m9YPjacaTpPZE3hU41v4ZSnQ5Rru/txInn4N/wBOcvWZ6aj8CCjTp6XDPAyyA==
X-Received: by 2002:a5d:5f56:0:b0:3e7:63c5:9a9d with SMTP id
 ffacd0b85a97d-3ecdf9b97c0mr1984254f8f.6.1758114594320; 
 Wed, 17 Sep 2025 06:09:54 -0700 (PDT)
Received: from ehlo.thunderbird.net (37-48-56-34.nat.epc.tmcz.cz.
 [37.48.56.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ece199ad24sm1152511f8f.50.2025.09.17.06.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 06:09:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:09:50 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
CC: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
User-Agent: Thunderbird for Android
In-Reply-To: <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
Message-ID: <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42c.google.com
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



On September 17, 2025 11:39:55 AM GMT+02:00, Maximilian Immanuel Brandtner=
 <maxbr@linux=2Eibm=2Ecom> wrote:
> On Tue, 2025-09-16 at 00:02 +0200, Filip Hejsek wrote:
> > On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel Brandtner
> > wrote:
> > > Update the terminal size upon SIGWINCH delivery=2E
> > >=20
> > > Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux=2Eibm=2Eco=
m>
> >=20
> > I don't think this will work, because SIGWINCH is only delivered for
> > the process' controling terminal=2E Unfortunately I don't think there
> > is
> > any way to get size notifications for arbitrary terminal=2E
>=20
> In that case there are two solutions:
> 1=2E make qemu the controlling process of the pty (this has the
> disadvantage of QEMU being quit when the pty is closed)

A bigger disadvantage is that a process can only have one controlling term=
inal, and a terminal can only be the controlling terminal for a single sess=
ion (and only sends signals to the foreground process group of that session=
)=2E It would require forking a process for each pty, and I don't even know=
 if the master end can have its own session=2E

> 2=2E create a timer polling every eg 100ms to check if the winsize has
> changed
>=20
> I would go with the second approach then

Me too, the timer is a bit unfortunate, but it's probably the less bad opt=
ion=2E

