Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C7E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 04:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOqsv-0001UP-Ev; Fri, 20 Dec 2024 23:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOqsu-0001UH-CA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:14:36 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOqss-0001KB-Ge
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 23:14:36 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so2061552a91.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734754473; x=1735359273; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OrL5FkxZFar2ABpgY9zxsditgaPmac+YsL5eW+DrlM=;
 b=Gd5kO2GYRFyqdCcRpZTilyL8xfcH6S4xEkQzVvNLiDFVw7IHPXoeGsChFUbiLaFzqq
 FjGA6stKz/sff8bb6Xm8+fVpSc0KY/eCUH6RTQ3IPt7zoC5iEa6JekCM0fTLMhCTEYIs
 epVs0jesgPb7fJxi2AywqYHA7GLzur2SzwYnbtZ2r+kugmPASjjH/SiOrtixaBb0Q6TX
 D9a5f/dhuc3swOM00LvSugcYQNFRKkoRklruHQp11EBXQoC1rV0pjkXIjvCbEXlPYsRU
 ACMSJ5wJK8c9RsTxhLTwPENzyPwA1XRMfQ8O6p1MvIJ6e21ikYAPOMpHDYVRmtV3ApQu
 72KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734754473; x=1735359273;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2OrL5FkxZFar2ABpgY9zxsditgaPmac+YsL5eW+DrlM=;
 b=OMtUNauIgxB6f4GvTrVOFNFoqJGzJO7tTgBipQ7zBV9EuvVTO4XkgFXI8eArg2FiuW
 FNNnODTYAxrAKSIKNVC6M6iJpywe/qBJMax35dK1VTMdt0kCLzR2rzZIRqaQGjClHiPF
 yNLVYCskqkYvsgl9C9r52QSMkwq97YRU9m5zIjayHfWUHKk2Mqt3/jGKo9HokE/Pnw18
 f/02Ju/INN1A7mvezYDpzphZRz24oOm/cvmAlDhTLL/j82vhsCf/Z8wciTwNP3T/LGqX
 AVcEdrxXbBecJqcsdhMgkdv1qdiFkHNLKk1dXm18d8S+FzglaVI7zHRFvCKdl/j621z6
 ZX/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZvJOH8MNW4SqnwmnC+jmodMQkDEalMWo9sNcwCGCqbS+TQZEnUCsI4JhZ2vief7BnBtNftyHrliM@nongnu.org
X-Gm-Message-State: AOJu0YwzoPbkAADwKR+QsfgYwOZa2jGAsqUcOVuzytc1YbaEDote2ojW
 QPHYAy7+GFV0XI3cD3L5NO8VknBbtUgVADMxGi7jBZHXH8+ph75K
X-Gm-Gg: ASbGnctc66uc2YaDG2BApFmJvtfurcqSS1/MefYghmoufBVeTsP5JrAcBbW+njVaZ9T
 Q2UeziTvk3TvSA5fLhyYNEfAkk06CUAoiwg3tUY3NVQLMGxGpPNiXqbONj7aBm0iQCyYjLM4fLD
 TfaI12k0TTsJXsSKgi0KCoWumCj3tu0eG1osqaz5LUCVoET62FQ3EoN3GJMgYy3SS02tvJW5E0A
 mC1Ys+h+KX+nGGiFRNmth8Yl6RtAeFO+PWRXBwgcSwi/AgDJtcF
X-Google-Smtp-Source: AGHT+IFBIr9uSNwDVvVpFByhY0Y0vAJXRHD7QcQbPmXEJVLZ/XG2t4xfMPhdHKgW3gQsHAoZSiqhrw==
X-Received: by 2002:a17:90b:54d0:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2f4536d193bmr8079668a91.11.1734754472733; 
 Fri, 20 Dec 2024 20:14:32 -0800 (PST)
Received: from localhost ([118.210.105.205]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed0d8bb2sm6033809a91.0.2024.12.20.20.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 20:14:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 14:14:26 +1000
Message-Id: <D6H34WA2W76T.2ADM8CT9LAZEH@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Dmitry Fleytman"
 <dmitry.fleytman@gmail.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
X-Mailer: aerc 0.18.2
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-6-npiggin@gmail.com>
 <ceadd6b1-c9d8-4531-a901-ef7a57e3d304@daynix.com>
In-Reply-To: <ceadd6b1-c9d8-4531-a901-ef7a57e3d304@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

On Thu Dec 19, 2024 at 6:53 PM AEST, Akihiko Odaki wrote:
> On 2024/12/18 16:42, Nicholas Piggin wrote:
> > The e1000e and igb tests don't clear the msix pending bit after waiting
> > for it, as it is masked so the irq doesn't get sent. Failing to clear
> > the pending interrupt means all subsequent waits for that interrupt
> > after the first do not actually wait for an interrupt genreated by the
> > device.
> >=20
> > This affects the multiple_transfers tests, they never actually verify
> > more than one interrupt is generated. So for those tests, enable the
> > msix vectors for the queue interrupts so they are delivered and the
> > pending bit is cleared.
> >=20
> > Add assertions to ensure the masked pending tests are not used to test
> > an interrupt multiple times.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> > Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/qtest/libqos/e1000e.h |   8 +++
> >   tests/qtest/e1000e-test.c   |   2 +
> >   tests/qtest/igb-test.c      |   2 +
> >   tests/qtest/libqos/e1000e.c | 113 +++++++++++++++++++++++++++++++++++=
-
> >   4 files changed, 122 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> > index 30643c80949..6cc1a9732b1 100644
> > --- a/tests/qtest/libqos/e1000e.h
> > +++ b/tests/qtest/libqos/e1000e.h
> > @@ -25,6 +25,9 @@
> >   #define E1000E_RX0_MSG_ID           (0)
> >   #define E1000E_TX0_MSG_ID           (1)
> >  =20
> > +#define E1000E_RX0_MSIX_DATA        (0x12345678)
> > +#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
> > +
> >   #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
> >  =20
> >   typedef struct QE1000E QE1000E;
> > @@ -40,6 +43,10 @@ struct QE1000E_PCI {
> >       QPCIDevice pci_dev;
> >       QPCIBar mac_regs;
> >       QE1000E e1000e;
> > +    uint64_t msix_rx0_addr;
> > +    uint64_t msix_tx0_addr;
>  > +    bool msix_found_rx0_pending;> +    bool msix_found_tx0_pending;
>
> I prefer having an enum that contains E1000E_RX0_MSG_ID,=20
> E1000E_TX0_MSG_ID, and "E1000E_RX0_MSG_MAX" or something similar. These=
=20
> values can be used to create and index an array containing both rx and=20
> tx, which will save redundant comparisons with E1000E_RX0_MSG_ID and=20
> E1000E_RX0_MSG_ID.

Okay I'll see how that looks.

>
> >   };
> >  =20
> >   static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint=
32_t val)
> > @@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d,=
 uint32_t reg)
> >   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
> >   void e1000e_tx_ring_push(QE1000E *d, void *descr);
> >   void e1000e_rx_ring_push(QE1000E *d, void *descr);
> > +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator =
*alloc);
> >  =20
> >   #endif
> > diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> > index a69759da70e..4921a141ffe 100644
> > --- a/tests/qtest/e1000e-test.c
> > +++ b/tests/qtest/e1000e-test.c
> > @@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *ob=
j, void *data,
> >           return;
> >       }
> >  =20
> > +    /* Triggering msix interrupts multiple times so must enable vector=
s */
> > +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
> >       for (i =3D 0; i < iterations; i++) {
> >           e1000e_send_verify(d, data, alloc);
> >           e1000e_receive_verify(d, data, alloc);
> > diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> > index 2f22c4fb208..06082cbe7ff 100644
> > --- a/tests/qtest/igb-test.c
> > +++ b/tests/qtest/igb-test.c
> > @@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj, =
void *data,
> >           return;
> >       }
> >  =20
> > +    /* Triggering msix interrupts multiple times so must enable vector=
s */
> > +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
> >       for (i =3D 0; i < iterations; i++) {
> >           igb_send_verify(d, data, alloc);
> >           igb_receive_verify(d, data, alloc);
> > diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> > index 925654c7fd4..7b7e811bce7 100644
> > --- a/tests/qtest/libqos/e1000e.c
> > +++ b/tests/qtest/libqos/e1000e.c
> > @@ -19,6 +19,7 @@
> >   #include "qemu/osdep.h"
> >   #include "hw/net/e1000_regs.h"
> >   #include "hw/pci/pci_ids.h"
> > +#include "hw/pci/pci_regs.h"
> >   #include "../libqtest.h"
> >   #include "pci-pc.h"
> >   #include "qemu/sockets.h"
> > @@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *dev=
, int devfn, void *data)
> >       g_free(dev);
> >   }
> >  =20
> > +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
> > +                                 uint64_t guest_msix_addr,
> > +                                 uint32_t msix_data)
> > +{
> > +    QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e1000e);
> > +    QPCIDevice *pci_dev =3D &d_pci->pci_dev;
> > +
> > +    if (msg_id =3D=3D E1000E_RX0_MSG_ID) {
> > +        g_assert(!d_pci->msix_found_rx0_pending);
> > +    } else if (msg_id =3D=3D E1000E_TX0_MSG_ID) {
> > +        g_assert(!d_pci->msix_found_tx0_pending);
> > +    } else {
> > +        /* Must enable MSI-X vector to test multiple messages */
> > +        g_assert_not_reached();
> > +    }
>
> This assertions are somewhat tricky. If there is something that sets the=
=20
> Pending Bit and we are not aware of it, d_pci->msix_found_rx0_pending=20
> and d_pci->msix_found_tx0_pending will be left cleared and assertions=20
> will not fire.
>
> I think asserting that the message is not masked is easier and less=20
> error-prone.

I don't understand what you mean. I allow the masked case
to be used, but only for 1 irq. It is only the multiple case
where we unmask.

If you do not expect the irq to be raised, then you should
add an assert for !e1000e_test_msix_irq().

Thanks,
Nick

