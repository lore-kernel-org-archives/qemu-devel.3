Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8D6CA0EEB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 02:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoY6k-0006O9-Ge; Tue, 19 Aug 2025 21:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uoY6i-0006O1-8H
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 21:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uoY6f-0006VA-SP
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 21:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755655155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7x5XmTqR8JdlGwr13nhDESsfWC0UcTvqqpDegE5R7eE=;
 b=GZmWywfZeIW3ilJate70V/P2HIE1gbsZp6hAHz5qLaByCxdPVlUUUWE4WWckq5XDiy0uO/
 G+n0BjPFLtaRC09raPzYzmLwIZiE0Iplocm7x17ggXyQB6y2xCznsbXbR8enkW3WBDJj1I
 K/0+45lvE89/lcBuqnNjm235q3C0A0U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-EunuDNWzOo2x3TsO7DjhWw-1; Tue, 19 Aug 2025 21:59:13 -0400
X-MC-Unique: EunuDNWzOo2x3TsO7DjhWw-1
X-Mimecast-MFC-AGG-ID: EunuDNWzOo2x3TsO7DjhWw_1755655152
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-618b3c75118so3988318a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 18:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755655152; x=1756259952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7x5XmTqR8JdlGwr13nhDESsfWC0UcTvqqpDegE5R7eE=;
 b=VCGzWKHMigrecIW6OrUgmOWulYxIkr+3104AEC/BNSY0L0CmKAvI9aHUj/H3t3dFW5
 ROU9g6s8coVwhO7HFOI8CFXdu55M9QsUZ4K+TH9iCJvXRgwFCKJEi32pvt4A3hEfW9Ev
 OgpvDjb8qeqp269FyxRqEkyL1446NOWfbSD3IqxjNIXbpXf87FJo7XPqjg5VH1IM1Fe8
 GaryZn7mMbtrZ5cWxYtYAl6hlxilA98u3lUF2AV0iEEq+kUX4FTCnXWt69yj+b3nlbPE
 Yl8Jf8yDhBmuXe2743t+Prvm68NrB1SbBiQZ4ESjKelUGN5PMcnzi2qoQRDUAgU0JJqX
 sk2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLn8O9LO9EhsRTyHVSk1p0faaWfNBK1WkN5BQ29mCqp4l4CYhgfKLRl63bfn79t2bm/9S4WZL4c/9h@nongnu.org
X-Gm-Message-State: AOJu0YxwDv4pbRByCbP7MO6CkVaj/bw0WM1JCDWeMiQTCGSEpIqWZNQF
 fmQ6z+SdDnejCasl/QNdeAuqRkjMesiG/aCFCU33oV5OHNAccjXsrekzYm1hmOnXqw+uLFvCBVu
 5FcWcj4AA9nnvy39CAYpDOC2JnJGbVJKm+ANlFMQAWBw/lkYtBj7guFdxdmjsm+pV4gGvkh/5U8
 CbhT0IC77kOJ2pbtv83RkscwvWBqLeVdg=
X-Gm-Gg: ASbGnctdVtx18xzBBakDZxpIxpRFQGguyJJnUS60Kt52MhTIundsh0Y6v5S/IFEtG8M
 LFqPaJQHTCpRQYUpe/PdeT0fU33FDUX4hm/OQzFjvJ2v6PqB2K64pc6etFrqVlt0f9LAAoM2bzE
 G6BO+8gbnYYC0ZOjI1i6ENQw==
X-Received: by 2002:a17:907:60d2:b0:ae9:8dc8:511c with SMTP id
 a640c23a62f3a-afdf005ae90mr92942566b.13.1755655151911; 
 Tue, 19 Aug 2025 18:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIElmzOLkYsIzx3rD9P/m/udeG6ddKmno6tZZ1qCF0ECVOistbgMLOxpzhoMrvkwYhPngUgDxsO4NfstIzBA=
X-Received: by 2002:a17:907:60d2:b0:ae9:8dc8:511c with SMTP id
 a640c23a62f3a-afdf005ae90mr92940666b.13.1755655151556; Tue, 19 Aug 2025
 18:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
 <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
 <CAPpAL=zQ-PQo78TeqmYgvGRnGeQFy0g-BAd2R405pdBbtCJQpw@mail.gmail.com>
 <7c27b2a0-afb1-4289-998f-9a0d624f135d@yandex-team.ru>
In-Reply-To: <7c27b2a0-afb1-4289-998f-9a0d624f135d@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 20 Aug 2025 09:58:34 +0800
X-Gm-Features: Ac12FXygHHibhkWQ9qUbVlSyWREAovddBruTibtq5Xv3ZKLObQgJwfYnfcbI2RA
Message-ID: <CAPpAL=xH235fSE4iJa8cWsKTx7zXuexexViNeTVkPPi4UAcNgw@mail.gmail.com>
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 9:28=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 19.08.25 16:14, Lei Yang wrote:
> > Hi Vladimir
> >
> >  From the QE perspective, this series of patches cause a regression iss=
ues for multi queues:
> > [qemu output] qemu-system-x86_64: -netdev ..."vhostfds": "20:21:22:23",=
 "fds": "10:16:17:19" : vhostfds=3D is invalid if fds=3D wasn't specified
>
> Oh right, thanks, I see the mistake in "[PATCH 15/19] net/tap: introduce =
net_tap_open()", I've refactored the end of net_init_tap() like it's only f=
or "open" case, but fds case doesn't have own "return" operator actually, a=
nd goes to the end and fails on the last check. Will fix.
>
> Which tests should I execute? At least "make check" doesn't see this prob=
lem.

The test step is to use the qemu binary with the current patch applied
to boot a guest that uses a multi-queues nic.
I will test this series of patches again when you update to V2.

>
> >
> > Thanks
> > Lei
> >
> >
> > On Tue, Aug 19, 2025 at 4:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <v=
sementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> >
> >     On 19.08.25 05:45, Jason Wang wrote:
> >      > On Mon, Aug 18, 2025 at 10:06=E2=80=AFPM Vladimir Sementsov-Ogie=
vskiy
> >      > <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> w=
rote:
> >      >>
> >      >> Hi all!
> >      >>
> >      >> As preparation for further development of TAP live local migrat=
ion
> >      >> (passing open fds through unix socket),
> >      >
> >      > I'm not sure I understand this, but I think it has been supporte=
d now,
> >      > or anything I miss?
> >      >
> >
> >     Hmm, may be I missing something, but where?
> >
> >     I see no code which put TAP fd into migration channel. Nothing abou=
t migration in tap.c at all.
> >
> >     So, normally, to make local migration with TAP device, you have to =
create a new TAP for new QEMU
> >     process.
> >
> >     I want to add a migration state, which will include needed part of =
TAPState, including fd,
> >     to continue using same TAP device in target process, avoiding also =
any initialization steps
> >     on that fd.
> >
> >     --
> >     Best regards,
> >     Vladimir
> >
>
>
> --
> Best regards,
> Vladimir
>


