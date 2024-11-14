Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE2BD68B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBd3l-0006he-NR; Thu, 14 Nov 2024 11:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tBd3j-0006hL-Sj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjelen@redhat.com>) id 1tBd3g-0008VZ-O7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731603063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP/Ipz8QTL91KJZtkdAb3BBxMs+7QXPO80jm6NiUqAA=;
 b=MOHgYyUdnA5LIIWjJBEJ5YfYnLyriPfKgCnmKnnT7/u5/Tc7y2+c0w4ya003jU2ou3lO2B
 fTCwDGlL4wxRqp7LoP4I4FP7Dh4GUD0Xwr+FvTLa5a9WxC4bCBSNZ6ecqM/tHQypJq0zTY
 jZDKt3ABgGTbxQ8zlA4f6irndlb+/mc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-kvGjkspZPFyVp9uZ19FCJg-1; Thu, 14 Nov 2024 11:49:45 -0500
X-MC-Unique: kvGjkspZPFyVp9uZ19FCJg-1
X-Mimecast-MFC-AGG-ID: kvGjkspZPFyVp9uZ19FCJg
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2fb58c0df21so6011401fa.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731602979; x=1732207779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VP/Ipz8QTL91KJZtkdAb3BBxMs+7QXPO80jm6NiUqAA=;
 b=H33N2gqOzY4wfGKt8JPeGr8oP63UTCt/qeF8x6kMJu5dsDHwg5fHMmgQ0SkH0vpE+P
 NMF25KiVukfZUcjm1YmVZFtiefGAponkPGGaCCh38lBogaYWlAHPU80DLYvYbqeUlwE0
 VDNbb2UF6ralkJ2wrKkrKotcpntQsNtUTXvD4l+dr+061doClmtlvM+m3Iz38ykfYS/s
 uWqp+lE8Q2aGTiG+Rpzf+vVyUf7ljkiv/PzIM1/VCvWc1ob0WfKG+SEHd9IvhH+KxgnE
 e/BQoeQowqgMkllll/0Yhxv98vPV8E5Immce9te7KFYT0GF1Bvyk7UVKjGW+d546toR6
 ufmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmSljjz/iH2R5a/l3m+f+DLZ1Rdp9l06IRqDp21W76x7z160Wdyc2EGUlx5Nz6omhTTPDzuQMFIJ1i@nongnu.org
X-Gm-Message-State: AOJu0Yz4gFPqhvmEZn8iXATjyADXsVOumv/H7iOd7Kufng12C0K7oBnW
 rhdlCaj3T+pwyA3ARD93phWynzoSFd7aKNtcHOVlKpPG4SVt6nembZTPBhSXENE62ImYzp+VFHW
 eqvNVEeAVn9N26NThSrYlhURKs61DN93zS2vT9NSDR/Uj3qOQpiTaP+Ip+/4FiMKpV4uCDwlO3A
 LHthwr1Tf7J/WfeN1OGNNdCIQBNiE=
X-Received: by 2002:a05:651c:543:b0:2fb:2b5d:215d with SMTP id
 38308e7fff4ca-2ff201284e2mr124509871fa.7.1731602979196; 
 Thu, 14 Nov 2024 08:49:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFKfkokPQshWlSVSL76zP4mtHF5N+vSaLoap9ls4llzZViMn1D8PN7+8vlNvUtVDCEdF+Rg09d/+ouYWoTPhY=
X-Received: by 2002:a05:651c:543:b0:2fb:2b5d:215d with SMTP id
 38308e7fff4ca-2ff201284e2mr124509781fa.7.1731602978787; Thu, 14 Nov 2024
 08:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
 <20241113130021.GA20898@redhat.com> <ZzYVgRo_l2ZHQztg@redhat.com>
In-Reply-To: <ZzYVgRo_l2ZHQztg@redhat.com>
From: Jakub Jelen <jjelen@redhat.com>
Date: Thu, 14 Nov 2024 17:49:27 +0100
Message-ID: <CAHrFiA98_icSL5WqTFN1gpWN+=70d58rH=V3iJWDf4zYApSMQA@mail.gmail.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,
comments inline below.

On Thu, Nov 14, 2024 at 4:21=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> [...]
>
> > I'll just note that I'm only forwarding on the patch from Jakub.
> > I didn't write it.
> >
> > I did lightly test it, and it seems to work.  However it seems also
> > likely that it is causing qemu to block internally.  Probably not
> > noticable for light use, but not something that we'd want for serious
> > use.  However if libssh doesn't support non-blocking SFTP there's not
> > much we can do about that in qemu.
>
> ...just making it blocking is not acceptable. It will potentially make
> the guest hang while we're waiting for sftp responses.

This is the limitation of the SFTP API we have (and a reason why we
have a new API below, but only in new 0.11.0 release so not solution
for older systems that wont get new libssh).

> I see that there is an sftp_aio_*() API, but it looks weird. Instead of
> allowing you to just poll the next request that is ready, you have to
> call a (blocking) wait on a specific request.

Its more "streaming" API allowing the request and response overlap in time
allowing better throughput on networks with large latency.

To support fully non blocking API in SFTP, there is still way to go, but th=
is
api should be more ready for that than the old one.

> co_yield(), which is currently used when sftp_read() returns SSH_AGAIN,
> makes sure that we poll the socket fd, so we can know that _something_
> new has arrived. However it's unclear to me how to know _which_ request
> received a reply and can be completed now. It seems you have to call
> sftp_aio_wait_*() in non-blocking mode on all requests to do that, which
> probably is affected by the libssh bug, too.

Are you sure that with the old libssh versions you were getting SSH_AGAIN
in non-blocking mode? Michael in the following comment found the
change where the issue started to demonstrate:

https://gitlab.com/libssh/libssh-mirror/-/issues/280#note_2204139954
https://gitlab.com/libssh/libssh-mirror/-/commit/2d3b7e07af3675b9a0326bc5c6=
253a0bbbda567b

And from what I read, it was just silently behaving as blocking
(potentially infinitely)
instead of returning SSH_AGAIN deep in libssh code.

> So I'm not sure if sftp_aio_*() can be combined with something else into
> a working solution, and I also don't know if it's affected by the same
> libssh bug.

Right now, we do not have a full solution. But having SFTP working
completely in nonoblocking mode is one of the things we would like to have
in the long term.

> Jakub, can you help with that?
>
> [...]
>
> As far as I can see, libssh sessions aren't thread safe, so we'll have
> to make sure to have only one request going at the same time, but I
> assume that calling ssh_read/write() from different threads sequentially
> isn't a problem?

My understanding is that the thread safety of libssh is limited to not shar=
ing
session between threads -- there is no synchronization if two threads would
send packets at the same time:

https://api.libssh.org/master/

If you will make sure you will not call sftp_read()/sftp_write() at
the same time
from different threads, it might work, but it is untested.

(joined the ML so I hope this mail will make it there)

Jakub


