Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE7E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 04:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOqth-00029L-46; Fri, 20 Dec 2024 23:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOqtf-00028i-RL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:15:23 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOqte-0001ap-Bf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:15:23 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728ec840a8aso3105821b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 20:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734754520; x=1735359320; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynxvFSx+IUwsr9Ee2CcYwY3bE9bIkvk8RYNIdrfaD6Q=;
 b=ZvH85+/hxWNMdULs5ecgxXTEWna3lug09Rdyyieb56/0+i/e5BWOKQv8axi6QoZKKj
 /ZjDvO8wJxEnSirO6IDKRsJh6VVInrFkZ0qso88e9XVApx/bonIZWe+MQ2KGQPCkq1Br
 y92Isp1QWRKi1PGjmJRT5kmAUWG3qX+YgsmVRqL8N4HCY67VxX3O9/hPtTX0mdEXScOM
 ceA7UGwCStO8EmHS0tc35i78ssodzhSLWsU7EpxP7W8NLezZjbI9wTg3t3xsh7ayfkvJ
 1Gn0rw0LQJmwdYiyLyDkH3RBiSESnShwtVgcl6Gmyjx3JPpHmvA6KMjYTw4tt3wXWeU8
 OGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734754520; x=1735359320;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ynxvFSx+IUwsr9Ee2CcYwY3bE9bIkvk8RYNIdrfaD6Q=;
 b=vYVARYRe5g27YbGA6bJbM7+aaYfrtJZ/ixDY0m+/Lx7XFAf8Duk1rgqRud50ptj2YA
 GARb3lQSFp7f5digspSfB97i7P89z/TRxXjV3a/3Eza5BFQFFgH+hDB+CcOYnh8bSUAF
 n/M7qJABftjX+AMA+aYvElrNJ2+JNL4gzIo16mC5wwFF3wmtNuVUPnHAl4lJBYNVegrL
 lyChr88uaxddKiPEmCYON3xRCZFxpD0rKebkkhYpZ3Cmq8EQv2PfY8ERS6XOF4tBMOiq
 cDir2/GaLwt9YvC0INH98QSJBC/oHunjnQ69nmOPxPNW0dNZk1bJAG5bf9b9P05dcx64
 OflA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnDKPli7VP9bvlrJt8mrolCjb9YGknGWhq2Ji4MLgotJIgxOKKrazeuNOWScKEw9wXbSHcsKWbD1a@nongnu.org
X-Gm-Message-State: AOJu0YxeGc5sfqDLBbImGYuQpPoylqKxLVrgtij2KB+0oSzD2J6E4NP4
 mZwVYu4T2xxICMpQj5KGVNVVH9gDqyVBT0Ownn3TKcQfFdFFSK3LNMGD+g==
X-Gm-Gg: ASbGnctDP+BtJqZvi917Jn8JPlXCdrBRTjdAq/zDyuxmp+ulTAnm3IbNnG6lD9a5Osv
 zTwpP3EXtKwVw+3GXytQbjC1u8aPZRT0SKlvLfotmmeIFIWsnWFzadkvc2Hxbo9tHJ7sYDd1otK
 tCm75e2TbFSbTaq1JVjYK/l4LYqVaM7JMiPOc0j30yiqywT7WaSf075OS4+C+tlQvq92Ka6tPhQ
 k3/2L42DMerpTTIVcsbC/slOaqYVQxo5tDoykMxDEwm/y5Xy9Gf
X-Google-Smtp-Source: AGHT+IG+d6akDJckD4tyoU+riXVs77fKNXJduFBVWBfJlN3ioV49kenS9oVSxN9+hBJpKsiG+n4n2Q==
X-Received: by 2002:a05:6a00:35ca:b0:725:e499:5b86 with SMTP id
 d2e1a72fcca58-72abde97ec4mr8413128b3a.20.1734754520657; 
 Fri, 20 Dec 2024 20:15:20 -0800 (PST)
Received: from localhost ([118.210.105.205]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb42sm3897435b3a.115.2024.12.20.20.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 20:15:20 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 14:15:14 +1000
Message-Id: <D6H35IACQM5F.2SKVF41KXO7GN@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Dmitry Fleytman"
 <dmitry.fleytman@gmail.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] qtest/e1000e|igb: Clear interrupt-cause bits after irq
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-5-npiggin@gmail.com>
 <1b6ed10c-7dc7-4e27-9f84-d89c6c0adf55@daynix.com>
In-Reply-To: <1b6ed10c-7dc7-4e27-9f84-d89c6c0adf55@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Thu Dec 19, 2024 at 7:00 PM AEST, Akihiko Odaki wrote:
> On 2024/12/18 16:42, Nicholas Piggin wrote:
> > The e1000e and igb tests do not clear the ICR/EICR cause bits (or
> > set auto-clear) on seeing queue interrupts, which inhibits the
> > triggering of a new interrupt.
> >=20
> > Fix this by clearing the cause bits, and verify that the expected
> > cause bit was set.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> > Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/qtest/e1000e-test.c | 8 ++++++--
> >   tests/qtest/igb-test.c    | 8 ++++++--
> >   2 files changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> > index de9738fdb74..a69759da70e 100644
> > --- a/tests/qtest/e1000e-test.c
> > +++ b/tests/qtest/e1000e-test.c
> > @@ -64,8 +64,10 @@ static void e1000e_send_verify(QE1000E *d, int *test=
_sockets, QGuestAllocator *a
> >       /* Put descriptor to the ring */
> >       e1000e_tx_ring_push(d, &descr);
> >  =20
> > -    /* Wait for TX WB interrupt */
> > +    /* Wait for TX WB interrupt (this clears the MSIX PBA) */
>
> It doesn't clear the MSI-X PBA unless the next patch is applied. This=20
> comment change should be moved to that patch.

Good catch. That was leftover from my improper PBA write patch.

> >       e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
> > +    /* Read ICR which clears it ready for next interrupt, assert TXQ0 =
cause */
>
> I suggest the following to make this comment clearer:
> Read ICR to make it ready for next interrupt, assert TXQ0 cause

Sure.

Thanks,
Nick

