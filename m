Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCC9E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 08:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOua1-0006xk-9s; Sat, 21 Dec 2024 03:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOuZz-0006xK-Q3
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 03:11:19 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tOuZx-0005JA-Mx
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 03:11:19 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21644aca3a0so29330945ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 00:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734768676; x=1735373476; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdqdRb8N99RiW94fmEBTWsEC/aEAf2G4+LokG1CBQlk=;
 b=EXpKeY0XJTA0D8beoY8gyZ4YEAyTZ4FwYrvpnVIRFsxxWqEtKUdDIXvHYhY76/1lQI
 qwXB9O2CE86cRI4+UM3mlJjZMb8Jq3hliOkjjis5VTntcKJdNDCjYTWJJ5/PmoIDQXXT
 aKZDHkDfRjMwqSbPJGyWvbQzG9e/nWqQ2r9FSqmwFpfTK9ihF/EY8k24m7ir7GC6eeEP
 YVzxEK3K+V5SUsgGInqCoxykL0q48HYGH/llIufMJ6L3JcB0NW1k4jMezQ0VjqZGOkS6
 o1eMdA9t1lSSo74xwhG26naWSszfYdf56ywWiq2XVDV5dNNnYhGh9GdE5qDB1Unm8i/1
 cf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734768676; x=1735373476;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sdqdRb8N99RiW94fmEBTWsEC/aEAf2G4+LokG1CBQlk=;
 b=V9i0/CeQC3WdmURashxhoU6WjFMvtn0cNbfBhntrrUAGWODIq+h3Q4buSaTHq991u6
 zHzCPX3UtqqJ8E4bO7rDnY2oCRV0Sct+UtAhELeg2hDdLpvSxnchCVzUaXx/O05tWod5
 w6Uk947H5w1KNICfRYIKTn6hfdDMV/Xq0lvz0HGthvmaae17eXzjeClwgTzasx6F/55z
 Xzq2RWe3ku91Pn4SnIg6x3/tQUbj16ZLnub1YgEll4AqR1hbPfoOyWGQcl1ZQqyeUHUX
 buGUlWslP51WiaPfMdduNxj0ZWYSL91okbm6M3IaeRf44lYWxsprrLe0pRsgrHwLE4QG
 FcDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlmy+BqTXQl4rlu/7JJyizpnsKDmG5YR061C62CtfCU5HF+1FxQt+Ku8ULMtcY8U2qUd9AhJhqGEMN@nongnu.org
X-Gm-Message-State: AOJu0Yx4kNpf1nAggJlHh/maBcwNGr9WtLOhthGvrCcmXw+l3rNF9en2
 zUBrfKB7jCiSDzCn4gCFrZ3wSI6+XfDuJuBxCBYysyn993VJa4cj
X-Gm-Gg: ASbGncuoz/ilo6SQpRlXjvkMK0QwtVrchtCHdnDQ57+cTI960CUwACscslLovTOtyM6
 1t1AV3VzEV2ISeLMHAe1Hvvo40YRfcuUXO4flHAgaDVJ1cPOxlEQORBU5xC/yCaUTWMEEedBif8
 lvrZpHGmHyblt7uqWJdyy5TNJ1jMxSZVwpb98fn1tH0pKt3xi30QE6DrDpoBntkoBwKQf+GsWes
 AtgZZvwg5snbnQJ0B8gmtozXXBVeh2B77GIeEKaZM0CmfZtBGFkOQEyyrSent/XekMsNVcF8zfL
 aQ==
X-Google-Smtp-Source: AGHT+IEWYF2st0PqyHQO7mEFBaRJr9liWtRm//PgqoiB6hk/qBlFajjjJW1lZ3HJ+wz6FISShzT3ig==
X-Received: by 2002:a17:903:3205:b0:215:b9a7:526d with SMTP id
 d9443c01a7336-219e6ecfbb4mr85466935ad.32.1734768676078; 
 Sat, 21 Dec 2024 00:11:16 -0800 (PST)
Received: from localhost (124-148-89-113.tpgi.com.au. [124.148.89.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971751sm39921855ad.109.2024.12.21.00.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 00:11:15 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 18:11:09 +1000
Message-Id: <D6H864XV1LS0.1UMX4CPO9AT5T@gmail.com>
Subject: Re: [PATCH 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Dmitry Fleytman"
 <dmitry.fleytman@gmail.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-6-npiggin@gmail.com>
 <ceadd6b1-c9d8-4531-a901-ef7a57e3d304@daynix.com>
 <D6H34WA2W76T.2ADM8CT9LAZEH@gmail.com>
 <c88dd8a9-bf21-4950-a91d-37fe18516ba5@daynix.com>
In-Reply-To: <c88dd8a9-bf21-4950-a91d-37fe18516ba5@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Sat Dec 21, 2024 at 2:26 PM AEST, Akihiko Odaki wrote:
> On 2024/12/21 13:14, Nicholas Piggin wrote:
> > On Thu Dec 19, 2024 at 6:53 PM AEST, Akihiko Odaki wrote:
> >> On 2024/12/18 16:42, Nicholas Piggin wrote:
> >>> The e1000e and igb tests don't clear the msix pending bit after waiti=
ng
> >>> for it, as it is masked so the irq doesn't get sent. Failing to clear
> >>> the pending interrupt means all subsequent waits for that interrupt
> >>> after the first do not actually wait for an interrupt genreated by th=
e
> >>> device.
> >>>
> >>> This affects the multiple_transfers tests, they never actually verify
> >>> more than one interrupt is generated. So for those tests, enable the
> >>> msix vectors for the queue interrupts so they are delivered and the
> >>> pending bit is cleared.
> >>>
> >>> Add assertions to ensure the masked pending tests are not used to tes=
t
> >>> an interrupt multiple times.
> >>>
> >>> Cc: Michael S. Tsirkin <mst@redhat.com>
> >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >>> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> >>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>>    tests/qtest/libqos/e1000e.h |   8 +++
> >>>    tests/qtest/e1000e-test.c   |   2 +
> >>>    tests/qtest/igb-test.c      |   2 +
> >>>    tests/qtest/libqos/e1000e.c | 113 ++++++++++++++++++++++++++++++++=
+++-
> >>>    4 files changed, 122 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.=
h
> >>> index 30643c80949..6cc1a9732b1 100644
> >>> --- a/tests/qtest/libqos/e1000e.h
> >>> +++ b/tests/qtest/libqos/e1000e.h
> >>> @@ -25,6 +25,9 @@
> >>>    #define E1000E_RX0_MSG_ID           (0)
> >>>    #define E1000E_TX0_MSG_ID           (1)
> >>>   =20
> >>> +#define E1000E_RX0_MSIX_DATA        (0x12345678)
> >>> +#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
> >>> +
> >>>    #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
> >>>   =20
> >>>    typedef struct QE1000E QE1000E;
> >>> @@ -40,6 +43,10 @@ struct QE1000E_PCI {
> >>>        QPCIDevice pci_dev;
> >>>        QPCIBar mac_regs;
> >>>        QE1000E e1000e;
> >>> +    uint64_t msix_rx0_addr;
> >>> +    uint64_t msix_tx0_addr;
> >>   > +    bool msix_found_rx0_pending;> +    bool msix_found_tx0_pendin=
g;
> >>
> >> I prefer having an enum that contains E1000E_RX0_MSG_ID,
> >> E1000E_TX0_MSG_ID, and "E1000E_RX0_MSG_MAX" or something similar. Thes=
e
> >> values can be used to create and index an array containing both rx and
> >> tx, which will save redundant comparisons with E1000E_RX0_MSG_ID and
> >> E1000E_RX0_MSG_ID.
> >=20
> > Okay I'll see how that looks.
> >=20
> >>
> >>>    };
> >>>   =20
> >>>    static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, u=
int32_t val)
> >>> @@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *=
d, uint32_t reg)
> >>>    void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
> >>>    void e1000e_tx_ring_push(QE1000E *d, void *descr);
> >>>    void e1000e_rx_ring_push(QE1000E *d, void *descr);
> >>> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocato=
r *alloc);
> >>>   =20
> >>>    #endif
> >>> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> >>> index a69759da70e..4921a141ffe 100644
> >>> --- a/tests/qtest/e1000e-test.c
> >>> +++ b/tests/qtest/e1000e-test.c
> >>> @@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *=
obj, void *data,
> >>>            return;
> >>>        }
> >>>   =20
> >>> +    /* Triggering msix interrupts multiple times so must enable vect=
ors */
> >>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
> >>>        for (i =3D 0; i < iterations; i++) {
> >>>            e1000e_send_verify(d, data, alloc);
> >>>            e1000e_receive_verify(d, data, alloc);
> >>> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> >>> index 2f22c4fb208..06082cbe7ff 100644
> >>> --- a/tests/qtest/igb-test.c
> >>> +++ b/tests/qtest/igb-test.c
> >>> @@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj=
, void *data,
> >>>            return;
> >>>        }
> >>>   =20
> >>> +    /* Triggering msix interrupts multiple times so must enable vect=
ors */
> >>> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
> >>>        for (i =3D 0; i < iterations; i++) {
> >>>            igb_send_verify(d, data, alloc);
> >>>            igb_receive_verify(d, data, alloc);
> >>> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.=
c
> >>> index 925654c7fd4..7b7e811bce7 100644
> >>> --- a/tests/qtest/libqos/e1000e.c
> >>> +++ b/tests/qtest/libqos/e1000e.c
> >>> @@ -19,6 +19,7 @@
> >>>    #include "qemu/osdep.h"
> >>>    #include "hw/net/e1000_regs.h"
> >>>    #include "hw/pci/pci_ids.h"
> >>> +#include "hw/pci/pci_regs.h"
> >>>    #include "../libqtest.h"
> >>>    #include "pci-pc.h"
> >>>    #include "qemu/sockets.h"
> >>> @@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *d=
ev, int devfn, void *data)
> >>>        g_free(dev);
> >>>    }
> >>>   =20
> >>> +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
> >>> +                                 uint64_t guest_msix_addr,
> >>> +                                 uint32_t msix_data)
> >>> +{
> >>> +    QE1000E_PCI *d_pci =3D container_of(d, QE1000E_PCI, e1000e);
> >>> +    QPCIDevice *pci_dev =3D &d_pci->pci_dev;
> >>> +
> >>> +    if (msg_id =3D=3D E1000E_RX0_MSG_ID) {
> >>> +        g_assert(!d_pci->msix_found_rx0_pending);
> >>> +    } else if (msg_id =3D=3D E1000E_TX0_MSG_ID) {
> >>> +        g_assert(!d_pci->msix_found_tx0_pending);
> >>> +    } else {
> >>> +        /* Must enable MSI-X vector to test multiple messages */
> >>> +        g_assert_not_reached();
> >>> +    }
> >>
> >> This assertions are somewhat tricky. If there is something that sets t=
he
> >> Pending Bit and we are not aware of it, d_pci->msix_found_rx0_pending
> >> and d_pci->msix_found_tx0_pending will be left cleared and assertions
> >> will not fire.
> >>
> >> I think asserting that the message is not masked is easier and less
> >> error-prone.
> >=20
> > I don't understand what you mean. I allow the masked case
> > to be used, but only for 1 irq. It is only the multiple case
> > where we unmask.
> >=20
> > If you do not expect the irq to be raised, then you should
> > add an assert for !e1000e_test_msix_irq().
>
> For example, think of the case where E1000E_RX0_MSG_ID is accidentally=20
> fired due to a bug in the emulation or test code. This interrupt is=20
> unintentional, so there is no corresponding call of=20
> e1000e_test_msix_irq(). This interrupt is followed by an operation that=
=20
> is intended to fire E1000E_RX0_MSG_ID and this is expected to be=20
> confirmed with e1000e_test_msix_irq().
>
> In this case, e1000e_test_msix_irq() will not properly ensure the=20
> presence of the latter interrupt because the Pending Bit is set by the=20
> earlier one. g_assert(!d_pci->msix_found_rx0_pending) is intended to=20
> detect the Pending Bit set earlier, but it is ineffective in this case=20
> because e1000e_test_msix_irq() is not called for the earlier interrupt=20
> and d_pci->msix_found_rx0_pending is not set. In this sense, this=20
> assertion is incomplete.

I think this scenario can not be detected even if we unmask, because
we can never distinguish the unintended interrupt from the intended
one.

The test case will always have to assert(!e1000e_tests_msix_irq())
before deliberately raising an interrupt if it wanted to be sure there
are no earlier unintended ones.

> Instead of having such assertions, we can unmask MSI-X vectors when=20
> testing interrupts. I also expect there will be less amount of code in=20
> this way because it will save the msix_found_rx0_pending and=20
> msix_found_tx0_pending flags and corresponding assertions.

We could always unmask, yes it would be less code. I just thought it
was neat to be able to test both paths. But that might be better left
to a msix specific test.

Thanks,
Nick

