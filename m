Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22472E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCHo-0002yA-IH; Thu, 19 Dec 2024 03:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCHl-0002lV-La
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:53:33 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOCHj-0001Hb-5D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:53:33 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-728e3826211so481631b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734598409; x=1735203209;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xomMKpVsIzMcMmRXWKPtmGg2Gt1yWwPokkh/vE9p+WM=;
 b=G7dyS0PGIfa5W+3RXFy0z7tmGNaH3U7vQcnBnY5t2bUqgnlkUJebfKhjgp9cLDIqEn
 9Heg2sjmHN7/ogMmYuuzHrhyxcnrJUBKCxP2yJkugLIff5ftMzUz7859RzryaOZ2fN/z
 agpcvkiLa94Rs3hn1cJ/eA2D61fFZfFhGW4SW8/vJxW0RH7hRGtebmqbnbn4WTA408pm
 VBDrEXLfGhKW/YlbyjWy3zna5MryJR1eAwZU7MrIlhV/392ISzRuCs7ccRevMUEd9CeM
 lvuESRfbuET2DTumCFUdhXm+PFnp1J0y77rC8cLGl0E+I6CQSf2tCqcOB3qs0qHM98dn
 RkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734598409; x=1735203209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xomMKpVsIzMcMmRXWKPtmGg2Gt1yWwPokkh/vE9p+WM=;
 b=U8wjJIPg3q+gGEr2qML8eLH4b4xNd1+t9Lh/Qs8FqEhMfSfSn3tI4wF3paVMwOoMzT
 ztOMQARXeb5tPJTZF9hcm+nzCzLs/fiYKLPDtIgUlwnw45iM49IbO0uajiIkbET+pUGL
 JGVRjP9W9rzQ94qpZI7KJqZTwREyM6lmXfggkuNAqggE4gSMizr6dwTcRUYWPKigmUlk
 rjegRQ6u1t2Ej8E3Xqu2ubs9xVbZnQSH/p65nfaZu97ThtuPzKGu0tLl0ucgfgAMI56Q
 VAeEZFlsVv+kHT8A5LRLpPjhT/H9PtGWvNdY7e7rUlWz67vc8NnwBc6BSi6Lv5sCZqo7
 0/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI60ZUEC1eTbMQU3RNEUdRpXFw0liS3nBIFve5UaL6mT7NN41y163LDOwyNwOrhmqoHkI392v26+ZU@nongnu.org
X-Gm-Message-State: AOJu0Yzh2LihnA/Zm11CajVAzAnjwUtm51wf2n3sKZu/fhgdt0nvCez9
 xHo726j096Kpw7lt7wSTOf7mZ6MA9On3I57lrEmdWQmpKRknftMqDFoYBvdcOfU=
X-Gm-Gg: ASbGnctrlf6qb0tmMVuKIi1Av9QtHk+2SC3f+DlkW8vyT30OTPEYZVwMIqPvniYV+Ek
 8/tiMhxxJgqBbsc1BxNcJiQ3JlCVxuF7nuzh10259J50MRPOkO91+wmWfsuLLtqqVpY+PYej94Y
 v7TgzCNDXu5lz1kfGxnS9TU58C39Ach7V226bGWbhKob3cXqtBppSzks5NrHnI7TYzqAef1hB30
 4FqXTJWhkXytvbfylNIeWx6G/x2eTI1s2oSrQtC4OG+cnL3BK0fwF5Z3OdEiWMojcQ=
X-Google-Smtp-Source: AGHT+IGXhrF6JoUFjLiPn6eCwACj7b8VLjBWs3WXvDONCnah8QZjRFpeXovfEdogOXsJaEscyWQKLA==
X-Received: by 2002:a05:6a20:728f:b0:1da:2e7c:e510 with SMTP id
 adf61e73a8af0-1e5b45ffc70mr9656434637.1.1734598409613; 
 Thu, 19 Dec 2024 00:53:29 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e25953e1sm704795a12.69.2024.12.19.00.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 00:53:29 -0800 (PST)
Message-ID: <ceadd6b1-c9d8-4531-a901-ef7a57e3d304@daynix.com>
Date: Thu, 19 Dec 2024 17:53:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
 <20241218074232.1784427-6-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241218074232.1784427-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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

On 2024/12/18 16:42, Nicholas Piggin wrote:
> The e1000e and igb tests don't clear the msix pending bit after waiting
> for it, as it is masked so the irq doesn't get sent. Failing to clear
> the pending interrupt means all subsequent waits for that interrupt
> after the first do not actually wait for an interrupt genreated by the
> device.
> 
> This affects the multiple_transfers tests, they never actually verify
> more than one interrupt is generated. So for those tests, enable the
> msix vectors for the queue interrupts so they are delivered and the
> pending bit is cleared.
> 
> Add assertions to ensure the masked pending tests are not used to test
> an interrupt multiple times.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/e1000e.h |   8 +++
>   tests/qtest/e1000e-test.c   |   2 +
>   tests/qtest/igb-test.c      |   2 +
>   tests/qtest/libqos/e1000e.c | 113 +++++++++++++++++++++++++++++++++++-
>   4 files changed, 122 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> index 30643c80949..6cc1a9732b1 100644
> --- a/tests/qtest/libqos/e1000e.h
> +++ b/tests/qtest/libqos/e1000e.h
> @@ -25,6 +25,9 @@
>   #define E1000E_RX0_MSG_ID           (0)
>   #define E1000E_TX0_MSG_ID           (1)
>   
> +#define E1000E_RX0_MSIX_DATA        (0x12345678)
> +#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
> +
>   #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
>   
>   typedef struct QE1000E QE1000E;
> @@ -40,6 +43,10 @@ struct QE1000E_PCI {
>       QPCIDevice pci_dev;
>       QPCIBar mac_regs;
>       QE1000E e1000e;
> +    uint64_t msix_rx0_addr;
> +    uint64_t msix_tx0_addr;
 > +    bool msix_found_rx0_pending;> +    bool msix_found_tx0_pending;

I prefer having an enum that contains E1000E_RX0_MSG_ID, 
E1000E_TX0_MSG_ID, and "E1000E_RX0_MSG_MAX" or something similar. These 
values can be used to create and index an array containing both rx and 
tx, which will save redundant comparisons with E1000E_RX0_MSG_ID and 
E1000E_RX0_MSG_ID.

>   };
>   
>   static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
> @@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
>   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>   void e1000e_tx_ring_push(QE1000E *d, void *descr);
>   void e1000e_rx_ring_push(QE1000E *d, void *descr);
> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc);
>   
>   #endif
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index a69759da70e..4921a141ffe 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>           return;
>       }
>   
> +    /* Triggering msix interrupts multiple times so must enable vectors */
> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>       for (i = 0; i < iterations; i++) {
>           e1000e_send_verify(d, data, alloc);
>           e1000e_receive_verify(d, data, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 2f22c4fb208..06082cbe7ff 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>           return;
>       }
>   
> +    /* Triggering msix interrupts multiple times so must enable vectors */
> +    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
>       for (i = 0; i < iterations; i++) {
>           igb_send_verify(d, data, alloc);
>           igb_receive_verify(d, data, alloc);
> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> index 925654c7fd4..7b7e811bce7 100644
> --- a/tests/qtest/libqos/e1000e.c
> +++ b/tests/qtest/libqos/e1000e.c
> @@ -19,6 +19,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/net/e1000_regs.h"
>   #include "hw/pci/pci_ids.h"
> +#include "hw/pci/pci_regs.h"
>   #include "../libqtest.h"
>   #include "pci-pc.h"
>   #include "qemu/sockets.h"
> @@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
>       g_free(dev);
>   }
>   
> +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
> +                                 uint64_t guest_msix_addr,
> +                                 uint32_t msix_data)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
> +
> +    if (msg_id == E1000E_RX0_MSG_ID) {
> +        g_assert(!d_pci->msix_found_rx0_pending);
> +    } else if (msg_id == E1000E_TX0_MSG_ID) {
> +        g_assert(!d_pci->msix_found_tx0_pending);
> +    } else {
> +        /* Must enable MSI-X vector to test multiple messages */
> +        g_assert_not_reached();
> +    }

This assertions are somewhat tricky. If there is something that sets the 
Pending Bit and we are not aware of it, d_pci->msix_found_rx0_pending 
and d_pci->msix_found_tx0_pending will be left cleared and assertions 
will not fire.

I think asserting that the message is not masked is easier and less 
error-prone.

> +
> +    if (pci_dev->msix_enabled) {
> +        if (qpci_msix_masked(pci_dev, msg_id)) {
> +            /* No ISR checking should be done if masked, but read anyway */
> +            bool p = qpci_msix_pending(pci_dev, msg_id);
> +            if (p) {
> +                if (msg_id == E1000E_RX0_MSG_ID) {
> +                    d_pci->msix_found_rx0_pending = true;
> +                } else if (msg_id == E1000E_TX0_MSG_ID) {
> +                    d_pci->msix_found_tx0_pending = true;
> +                } else {
> +                    g_assert_not_reached();
> +                }
> +            }
> +            return p;
> +        } else {
> +            uint32_t data = qtest_readl(pci_dev->bus->qts, guest_msix_addr);
> +            if (data == msix_data) {
> +                qtest_writel(pci_dev->bus->qts, guest_msix_addr, 0);
> +                return true;
> +            } else if (data == 0) {
> +                return false;
> +            } else {
> +                g_assert_not_reached();
> +            }
> +        }
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}
> +
>   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
>   {
>       QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> -    guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
> +    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +    uint64_t guest_msix_addr;
> +    uint32_t msix_data;
> +
> +    assert(pci_dev->msix_enabled);
> +
> +    if (msg_id == E1000E_RX0_MSG_ID) {
> +        guest_msix_addr = d_pci->msix_rx0_addr;
> +        msix_data = E1000E_RX0_MSIX_DATA;
> +    } else if (msg_id == E1000E_TX0_MSG_ID) {
> +        guest_msix_addr = d_pci->msix_tx0_addr;
> +        msix_data = E1000E_TX0_MSIX_DATA;
> +    } else {
> +        g_assert_not_reached();
> +    }
>   
>       do {
> -        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
> +        if (e1000e_test_msix_irq(d, msg_id, guest_msix_addr, msix_data)) {
>               return;
>           }
> -        qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
> +        qtest_clock_step(pci_dev->bus->qts, 10000);
>       } while (g_get_monotonic_time() < end_time);
>   
>       g_error("Timeout expired");
> @@ -99,6 +161,51 @@ static void e1000e_pci_destructor(QOSGraphObject *obj)
>       qpci_msix_disable(&epci->pci_dev);
>   }
>   
> +static void e1000e_pci_msix_enable_vector(QE1000E *d, uint16_t msg_id,
> +                                          uint64_t guest_msix_addr,
> +                                          uint32_t msix_data)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
> +    uint32_t control;
> +    uint64_t off;
> +
> +    g_assert_cmpint(msg_id , >=, 0);
> +    g_assert_cmpint(msg_id , <, qpci_msix_table_size(pci_dev));
> +
> +    off = pci_dev->msix_table_off + (msg_id * 16);
> +
> +    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
> +                   off + PCI_MSIX_ENTRY_LOWER_ADDR, guest_msix_addr & ~0UL);
> +    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
> +                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
> +                   (guest_msix_addr >> 32) & ~0UL);
> +    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
> +                   off + PCI_MSIX_ENTRY_DATA, msix_data);
> +
> +    control = qpci_io_readl(pci_dev, pci_dev->msix_table_bar,
> +                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
> +                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
> +                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +}
> +
> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
> +
> +    g_assert(pci_dev->msix_enabled);
> +
> +    d_pci->msix_rx0_addr = guest_alloc(alloc, 4);
> +    d_pci->msix_tx0_addr = guest_alloc(alloc, 4);
> +
> +    e1000e_pci_msix_enable_vector(d, E1000E_RX0_MSG_ID,
> +                                  d_pci->msix_rx0_addr, E1000E_RX0_MSIX_DATA);
> +    e1000e_pci_msix_enable_vector(d, E1000E_TX0_MSG_ID,
> +                                  d_pci->msix_tx0_addr, E1000E_TX0_MSIX_DATA);
> +}
> +
>   static void e1000e_pci_start_hw(QOSGraphObject *obj)
>   {
>       QE1000E_PCI *d = (QE1000E_PCI *) obj;


