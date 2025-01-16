Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3308C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 05:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYItT-0008Lw-1z; Thu, 16 Jan 2025 00:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYItR-0008LO-4f
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:58:13 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYItO-00007M-O7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:58:12 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso11526725ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 21:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737007089; x=1737611889;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFQRgMGvqGHJbiby+mGDpXtQsIApGek0rCbwFbJxWCw=;
 b=sH2+hj1RqWkqxAs9Zfa9kB3vesHwVDvEIy0lZAqNmHmogpikP1Fy7vQjeq2PruHGUx
 gTz/8qkQU0j7UdCEmKtcDkUbFJZ7cTBOgKC57rs0qHXXZteaOJVVnXA3G062ruLZ1Ot+
 nWkjFNCXCsAtSsNfoB6g+qzwPVBdhhF10xyB07hU9wien433kVW/Zz1YA/OcDlD6PpZ5
 IhQHpqJDPmcTGX/NQCsxdCSGawjI4k6DLplpEoKUZknD9ho2mvDlzC+8m5Q5PCn7Jlny
 Eo368qLTOrD1veR0PdrlLJBu2ypj5mDzqem0WJ68BIwsOsekD2dKZAruLC/pRJdJ+WFW
 MaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737007089; x=1737611889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFQRgMGvqGHJbiby+mGDpXtQsIApGek0rCbwFbJxWCw=;
 b=AcNu9bX3tyrHgo7NFvGgrjBth5hLedaCQ1uc7m/ZmMvyZBbIOYFV4SYyaPoS4aR5RU
 RB3KjWjz3MyTg7kQjAgfRP2PC54vj7MwZupd2sE9u/kR6cyyy4id6MyGIb3EZUrcq8e5
 jl4yVUg0Dbx/Of1ER74vy7/qKAXJ3ng5R38LwtO9YoJiEbuO8wvhvc7irO5rs1/0MOLv
 iGVTHAdxGA9kn2ftJ4vaDxTjcBVxYZlgwxckX3LYwA5HTQllWn+n1d2Mw2cUdCOXzAdR
 L1e/qG9MEdO/dk65liI8vcYsFL7sjQkTSbX78TIk5Jtzv2QmjWlg5bf4iBE5fEUORusS
 MLoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDzgAKcAPaE6M3aMGdwcJ6Cb7XXIDOKgrwMjQeDO19hAn/YaOYK8HRUCg0AjbtvOtj25B3nCGbMI/C@nongnu.org
X-Gm-Message-State: AOJu0YzL/j/JHajsp9LVVux53DXINbr++8DkaORLZsCRyal08Jotd5WK
 81MnT/Z/Z+g2zCS9ik8R7iNwPLiutWY/JPZWyuClmZwopLICQ2z2piXMLRzj/5A=
X-Gm-Gg: ASbGncuQBUl8VnpEOJ4BRUuKcbBhtxN1H4w1LubaxfqV2tRn/x2EN/oT+C/zybYacyl
 +VFKAdYtWwLLbfYv6qiJ04kJcEq6mfOOnmoEpnRIGwkDFeH+dwAQ5PN8u8YTYfqJkk1Hc6kZ26D
 YToyopo9XYwqILxjT7nCGfyVBvQ1Bdy3WuF6GbF53DpxKwtQ+Qrb/U+xCLEd8hKLaJsKkjIGmA0
 Tpi3dVLkIyURjNtYT0NM1dC2x4AVWQirWBzz6itkg5IzecK+yr0Ihnq6HsmDhPIiY4=
X-Google-Smtp-Source: AGHT+IGFh+SZWcFRXM86Iw/ZESYtT1mQBeN4FdtrIEIOOvdfU434eCTvFJgroIEMgnfQN5DA0YKjAg==
X-Received: by 2002:a17:903:2451:b0:215:b74c:d7ad with SMTP id
 d9443c01a7336-21a83fc389cmr502073235ad.36.1737007089125; 
 Wed, 15 Jan 2025 21:58:09 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c2f31d6sm2375233a91.40.2025.01.15.21.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 21:58:08 -0800 (PST)
Message-ID: <b9e73795-c866-4c13-ab80-e1a5d7226c17@daynix.com>
Date: Thu, 16 Jan 2025 14:58:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
References: <20250115150112.346497-1-npiggin@gmail.com>
 <20250115150112.346497-6-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250115150112.346497-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2025/01/16 0:01, Nicholas Piggin wrote:
> The e1000e and igb tests don't clear the msix pending bit after waiting
> for it, as it is masked so the irq doesn't get sent. This means all
> subsequent waits for the interrupt does not wait or verify the interrupt
> was generated, affecting the multiple_transfers tests.
> 
> To fix this, have device setup always enable and unmask the RXQ and TXQ
> irq vectors, and verify interrupt was seen by checking the msix message
> was seen.

I have a late question: What about using the PBACLR register? It seems 
easier than unmasking MSI-X vectors.

I first thought you are going to have a generic testing code so I 
suggested unmasking MSI-X vectors, which is not specific to e1000e/igb 
and portable. However, you are only fixing e1000e/igb now so it is fine 
to rely on device-specifics. With the PBACLR you can easily clear the PBA.

> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/e1000e.h | 11 ++++-
>   tests/qtest/libqos/e1000e.c | 87 +++++++++++++++++++++++++++++++++++--
>   tests/qtest/libqos/igb.c    |  9 ++++
>   3 files changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> index 30643c80949..63aa8c28a39 100644
> --- a/tests/qtest/libqos/e1000e.h
> +++ b/tests/qtest/libqos/e1000e.h
> @@ -22,8 +22,13 @@
>   #include "qgraph.h"
>   #include "pci.h"
>   
> -#define E1000E_RX0_MSG_ID           (0)
> -#define E1000E_TX0_MSG_ID           (1)
> +enum  {
> +    E1000E_RX0_MSG_ID,
> +    E1000E_TX0_MSG_ID,
> +    E1000E_MSG_ID_MAX
> +};
> +
> +#define E1000E_MSIX_DATA ((uint32_t[]) { 0x12345678, 0xabcdef00 })
>   
>   #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
>   
> @@ -40,6 +45,7 @@ struct QE1000E_PCI {
>       QPCIDevice pci_dev;
>       QPCIBar mac_regs;
>       QE1000E e1000e;
> +    uint64_t msix_msg_addr[E1000E_MSG_ID_MAX];
>   };
>   
>   static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
> @@ -57,5 +63,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
>   void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>   void e1000e_tx_ring_push(QE1000E *d, void *descr);
>   void e1000e_rx_ring_push(QE1000E *d, void *descr);
> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E_PCI *d);
>   
>   #endif
> diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> index 925654c7fd4..49bedb5e009 100644
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
> @@ -77,16 +78,48 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
>       g_free(dev);
>   }
>   
> +static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
> +                                 uint64_t guest_msix_addr,
> +                                 uint32_t msix_data)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    QPCIDevice *pci_dev = &d_pci->pci_dev;
> +    uint32_t data;
> +
> +    /* msix irq test must enable msix */
> +    g_assert(pci_dev->msix_enabled);
> +
> +    /* Vector must be enabled (e.g., with enable_rxtxq_vectors) */
> +    g_assert(!qpci_msix_masked(pci_dev, msg_id));
> +
> +    data = qtest_readl(pci_dev->bus->qts, guest_msix_addr);
> +    if (data == msix_data) {
> +        /* Clear msix addr ready for next interrupt */
> +        qtest_writel(pci_dev->bus->qts, guest_msix_addr, 0);
> +        return true;
> +    } else if (data == 0) {
> +        return false;
> +    } else {
> +        /* Must only be either 0 (no interrupt) or the msix data. */
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
> +    uint64_t guest_msix_addr = d_pci->msix_msg_addr[msg_id];
> +    uint32_t msix_data = E1000E_MSIX_DATA[msg_id];
> +
> +    assert(pci_dev->msix_enabled);
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
> @@ -99,6 +132,45 @@ static void e1000e_pci_destructor(QOSGraphObject *obj)
>       qpci_msix_disable(&epci->pci_dev);
>   }
>   
> +static void e1000e_pci_msix_enable_vector(QE1000E_PCI *d, uint16_t msg_id)
> +{
> +    QPCIDevice *pci_dev = &d->pci_dev;
> +    uint64_t guest_msix_addr = d->msix_msg_addr[msg_id];
> +    uint32_t msix_data = E1000E_MSIX_DATA[msg_id];
> +    uint32_t control;
> +    uint64_t off;
> +
> +    g_assert_cmpint(msg_id , >=, 0);
> +    g_assert_cmpint(msg_id , <, qpci_msix_table_size(pci_dev));
> +    g_assert_cmpint(msg_id , <, E1000E_MSG_ID_MAX);
> +    g_assert(guest_msix_addr != 0);
> +    g_assert(msix_data != 0);
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
> +void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E_PCI *d)
> +{
> +    g_assert(d->pci_dev.msix_enabled);
> +
> +    e1000e_pci_msix_enable_vector(d, E1000E_RX0_MSG_ID);
> +    e1000e_pci_msix_enable_vector(d, E1000E_TX0_MSG_ID);
> +}
> +
>   static void e1000e_pci_start_hw(QOSGraphObject *obj)
>   {
>       QE1000E_PCI *d = (QE1000E_PCI *) obj;
> @@ -113,6 +185,7 @@ static void e1000e_pci_start_hw(QOSGraphObject *obj)
>   
>       /* Enable and configure MSI-X */
>       qpci_msix_enable(&d->pci_dev);
> +    e1000e_pci_msix_enable_rxtxq_vectors(d);
>       e1000e_macreg_write(&d->e1000e, E1000_IVAR, E1000E_IVAR_TEST_CFG);
>   
>       /* Check the device status - link and speed */
> @@ -196,6 +269,14 @@ static void *e1000e_pci_create(void *pci_bus, QGuestAllocator *alloc,
>       d->e1000e.rx_ring = guest_alloc(alloc, E1000E_RING_LEN);
>       g_assert(d->e1000e.rx_ring != 0);
>   
> +    /* Allocate and clear msix msg addr for TX */
> +    d->msix_msg_addr[E1000E_TX0_MSG_ID] = guest_alloc(alloc, 4);
> +    g_assert(d->msix_msg_addr[E1000E_TX0_MSG_ID] != 0);
> +
> +    /* Allocate and clear msix msg addr for RX */
> +    d->msix_msg_addr[E1000E_RX0_MSG_ID] = guest_alloc(alloc, 4);
> +    g_assert(d->msix_msg_addr[E1000E_RX0_MSG_ID] != 0);
> +
>       d->obj.get_driver = e1000e_pci_get_driver;
>       d->obj.start_hw = e1000e_pci_start_hw;
>       d->obj.destructor = e1000e_pci_destructor;
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd2..c902634b3df 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -75,6 +75,7 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>   
>       /* Enable and configure MSI-X */
>       qpci_msix_enable(&d->pci_dev);
> +    e1000e_pci_msix_enable_rxtxq_vectors(d);
>       e1000e_macreg_write(&d->e1000e, E1000_IVAR0, IGB_IVAR_TEST_CFG);
>   
>       /* Check the device link status */
> @@ -161,6 +162,14 @@ static void *igb_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
>       d->e1000e.rx_ring = guest_alloc(alloc, E1000E_RING_LEN);
>       g_assert(d->e1000e.rx_ring != 0);
>   
> +    /* Allocate and clear msix msg addr for TX */
> +    d->msix_msg_addr[E1000E_TX0_MSG_ID] = guest_alloc(alloc, 4);
> +    g_assert(d->msix_msg_addr[E1000E_TX0_MSG_ID] != 0);
> +
> +    /* Allocate and clear msix msg addr for RX */
> +    d->msix_msg_addr[E1000E_RX0_MSG_ID] = guest_alloc(alloc, 4);
> +    g_assert(d->msix_msg_addr[E1000E_RX0_MSG_ID] != 0);
> +
>       d->obj.get_driver = igb_pci_get_driver;
>       d->obj.start_hw = igb_pci_start_hw;
>       d->obj.destructor = e1000e_pci_destructor;


