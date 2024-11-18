Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F681D591A7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5DA-0004WO-MD; Mon, 18 Nov 2024 12:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tD5D6-0004Vr-Rh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tD5D4-0000rE-Or
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731949600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nF3B2rdPm63S4Q28XSScbmxiE6NpARMFQSYMFb1yAFU=;
 b=fb5ycz+XiO8KbYie9CQwD9PVPtUhAQn71hApqNfY72MIrwQO54TlA+YdU9/sSpD/0jn38O
 NjejXan+yyUXUUJtZQAiOxdDVYx/EBPy7sAZPZdYa4yE8yMVFK/NnHwFX/qvh4LL+DEpil
 CUTmuD6KFPHbf4hwVR7mXbBt5k9yNns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-pCJU_TI1NHu0hABtm19thA-1; Mon, 18 Nov 2024 12:06:38 -0500
X-MC-Unique: pCJU_TI1NHu0hABtm19thA-1
X-Mimecast-MFC-AGG-ID: pCJU_TI1NHu0hABtm19thA
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ff550d390aso27647911fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731949597; x=1732554397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nF3B2rdPm63S4Q28XSScbmxiE6NpARMFQSYMFb1yAFU=;
 b=C+YL1wFCKtYnzbzo+2jp4D3MUITWymZnqm8CZh1z1DtysMEo/YJ/XD8+ipaSk8bvyI
 YlXO4p0i3hAkCK1lCB7mkgHUI1EFClq8PZ+P6OvtWCOEcSMF/O8wrrE/SgKOuc4g5FYz
 7IbGlCqPCkznSHskERnx7NqO+ZDPGAkuiBVA5fWwwPzD3LLyNFPElMptPErE1FqFOzC7
 VcqiBQtA57QE9aF5D5KQrc8JKQdtVR/g2Ztmg2Gw7qnTxshEgDfjuiTTT3IXuwrlm7Vs
 7BO7cloNN8KvqW8d6s3MvS/PzF03Fdjf61I4W3Kl2BD6K25Iq+HRErFD5QeSSI9V++6o
 4+yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiIbI4I7/kheJ5hkcXjaJkKFqb+N5G1oz3UtyBFfjg3Z/71Ib4KX9M8ZvFbz2xlFASJL/Drx3REMWu@nongnu.org
X-Gm-Message-State: AOJu0YzkWt27bcunN79nP61DuAjdjEhzgrUqshoAgBlFtIPxpb7pxcpa
 14h0qHa3wJsM1fvcvSpBUp7PF3I7LxZ+lHEZy4YfiuEBqwis+itAiQkO/EIPTPUWr7i9RvlgJ0V
 WABkygDVPGTyEPtdBPHz21LEQsSUh9nXg85wKjzh7wim7H+m8wujKzZcTiFtcEQh4KrD/dA0SHs
 rzp2NAAThFkxl8NIy8ij/eWWiJ/fo=
X-Received: by 2002:a2e:bc02:0:b0:2fb:522c:7ee2 with SMTP id
 38308e7fff4ca-2ff6066170fmr62167331fa.21.1731949596498; 
 Mon, 18 Nov 2024 09:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUy9dR/ZjMh9or/lKcNFTB/03NiWjtj8CuVnbw89cq/BapEKLlorhztg2j+O4gmf28bSeZlfCOM+PLDbimZK8=
X-Received: by 2002:a2e:bc02:0:b0:2fb:522c:7ee2 with SMTP id
 38308e7fff4ca-2ff6066170fmr62167041fa.21.1731949596045; Mon, 18 Nov 2024
 09:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com> <ZzYVgRo_l2ZHQztg@redhat.com>
 <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
 <ZzY4D7t5asZZWgwN@redhat.com>
In-Reply-To: <ZzY4D7t5asZZWgwN@redhat.com>
From: Jakub Jelen <jjelen@redhat.com>
Date: Mon, 18 Nov 2024 18:06:24 +0100
Message-ID: <CAHrFiA9tURvg0xitWK6gaA9osGF1ZoHq6d1yFv+nB8FPTg7-Cg@mail.gmail.com>
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, mpitt@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jjelen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Kevin,
Sorry for the delay, my gmail filters will need some love to handle this
high-traffic mailing lists so I can catch replies ...

On Thu, Nov 14, 2024 at 6:49=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> [...]
> Hm, after looking some more at the code, I agree that it can't have
> worked, for the simple reason that sftp_read() never returns SSH_AGAIN,
> but turns it into 0. Which QEMU would have reported as an I/O error if
> we're not at EOF.
>
> What I don't understand yet where in the code it would have blocked
> before rather than returning an error. I tried to follow the code path
> and didn't see anything like it, but obviously I'm also not familiar
> with libssh code. I guess it also doesn't really matter as long as we
> know it has always been broken...

I think it is the cycle in the sftp_packet_read(), which was polling
until we got
something to read here:

https://gitlab.com/libssh/libssh-mirror/-/blob/master/src/sftp_common.c?ref=
_type=3Dheads#L75-L100

But I would have to retrace through the code as I already forgot where I
was looking to.

> The thing that maybe misled me is that sftp_recv_response_msg() calls
> ssh_channel_poll() first to make sure that there is even something to
> read. So I expected it should have been non-blocking at least in some
> cases, but if it had been, we would probably have seen I/O errors all
> the time?

Note, that the sftp_recv_response_msg() function is new in master and
not yet in any released versions. The 0.11 version had processing directly
in the sftp_read() (and in each other function handling some responses).

https://gitlab.com/libssh/libssh-mirror/-/blob/stable-0.11/src/sftp.c?ref_t=
ype=3Dheads#L1200

Also the ssh_channel_poll() is called only when the file handle is in
non-blocking
mode (whatever it means). The qemu sets the blocking mode here:

https://github.com/qemu/qemu/blob/master/block/ssh.c#L805C1-L805C44

This means the execution goes directly into sftp_read_and_dispatch(), which
we discussed above as it does the blocking.

> > > So I'm not sure if sftp_aio_*() can be combined with something else i=
nto
> > > a working solution, and I also don't know if it's affected by the sam=
e
> > > libssh bug.
> >
> > Right now, we do not have a full solution. But having SFTP working
> > completely in nonoblocking mode is one of the things we would like to h=
ave
> > in the long term.
> >
> > > Jakub, can you help with that?
> > >
> > > [...]
> > >
> > > As far as I can see, libssh sessions aren't thread safe, so we'll hav=
e
> > > to make sure to have only one request going at the same time, but I
> > > assume that calling ssh_read/write() from different threads sequentia=
lly
> > > isn't a problem?
> >
> > My understanding is that the thread safety of libssh is limited to not
> > sharing session between threads -- there is no synchronization if two
> > threads would send packets at the same time:
> >
> > https://api.libssh.org/master/
> >
> > If you will make sure you will not call sftp_read()/sftp_write() at
> > the same time from different threads, it might work, but it is
> > untested.
>
> How do you feel about it? Do you think this is something libssh can
> support, or is it something that might accidentally work today, but not
> necessarily next year?

If we will write some test coverage for this, I think we can make sure it
keeps working. There is really nothing that libssh would do in the backgrou=
nd
so the stuff should not go wrong. We will just make sure to double-check
all the variables are a part of session and not scattered around as static
variables or thread local ones (I hope we don't have much of these though).

> We have a thread pool readily available that we could use, but then
> requests for the same session would come from different threads - just
> never at the same time. If we need a single long-lived thread per
> session instead, that might be a little more involved because we might
> have to implement all the communication and synchronisation from
> scratch.
>
> (Hmm... Or we abuse the IOThread object to create one internally and
> just move the request coroutine to it around libssh calls. That could be
> easy enough.)

Sorry, I don't have much experience around this to bring any useful insight
here.

So going back to the original issue, is the proposed patch something that
could work for you in the short term before a better solution will be
implemented
or is there something we should change?

Jakub


