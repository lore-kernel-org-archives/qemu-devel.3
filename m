Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34152C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPq7-0006CO-C0; Tue, 18 Aug 2026 15:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwPpy-0006B1-2n
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:51:07 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwPpv-0004mQ-Fo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:51:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6705A84716;
 Tue, 18 Aug 2026 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787082657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGb7lSFRf16JgTQSF0Dk05/B5VDd7+GdLiUxg4Xtim4=;
 b=Rs2UHnULMOH9VdAt6IxNE8WHMcaG4//pL6NFiXheFB4asMApkInVq0KI86iZDmROSmn3FW
 SzpRYT3uB6f/smliP+m+HIfiiURh72pO6Mg+alY+H5UDIEoofdgwuzQ+cGjUWxfL0+rPBQ
 mMOQTRspBa5/2OAC94qX7BjcqwsmYhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787082657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGb7lSFRf16JgTQSF0Dk05/B5VDd7+GdLiUxg4Xtim4=;
 b=dhJ4bLBXjScEDTq4l61qgc5NvrOXR0gRgxb6yJRojDEudFYFlCF7JYuNCtahP7nisnr8Ot
 d4/8ZlHwhai9ntDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CxnuBAYc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NmepGvvi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787082653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGb7lSFRf16JgTQSF0Dk05/B5VDd7+GdLiUxg4Xtim4=;
 b=CxnuBAYcc8SH9HiVeOxbcalRdt2bUe/Rtz5pF/i5YttdMFlboeUNq4ebFaIrI3ZsLDxzfe
 6wAaplBYUJO2GVRArooA13iO8wDjHMHadi6OdzLzK1ZpoV3WWx37xEj6a5jBoErWFsAjK3
 1hqG6r+OSnzh/xTP96u8UXO8MyREIkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787082653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGb7lSFRf16JgTQSF0Dk05/B5VDd7+GdLiUxg4Xtim4=;
 b=NmepGvviOYueRlEpeUnKI/Q3PALiwicPBXTrj7CaImtWa95FBiUgN/4zjceWKq21nlBszo
 NYuqg40xZsU3q2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5CA339C;
 Tue, 18 Aug 2026 19:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ENsGL5y3hGp9MgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 19:50:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jishnu Warrier <jishnuvw@linux.ibm.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, david@gibson.dropbear.id.au,
 adityag@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 04/10] tests/qtest: Enable spapr dma with linear
 iommu map
In-Reply-To: <20260817185539.376740-5-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
 <20260817185539.376740-5-jishnuvw@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:50:46 -0300
Message-ID: <875x17mcmh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,linaro.org,daynix.com,redhat.com,gibson.dropbear.id.au,linux.ibm.com];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6705A84716
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jishnu Warrier <jishnuvw@linux.ibm.com> writes:

> From: Nicholas Piggin <npiggin@gmail.com>
>
> qtests spapr dma was broken because the iommu was not set up.
>
> spapr requires hypercalls to set up the iommu (TCE tables), but
> there is no support for that or a side-channel to the iommu in
> qtests at the moment, so add a quick workaround in QEMU to have
> the spapr iommu provide a linear map to memory when running
> qtests.
>
> The buggy msix checks can all be removed since the tests all work
> now.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_iommu.c                 | 10 +++++++++-
>  tests/qtest/e1000e-test.c            | 21 ---------------------
>  tests/qtest/igb-test.c               | 21 ---------------------
>  tests/qtest/libqos/generic-pcihost.c |  1 -
>  tests/qtest/libqos/pci-pc.c          |  3 ---
>  tests/qtest/libqos/pci-spapr.c       |  7 ++++---
>  tests/qtest/libqos/pci.c             | 14 --------------
>  tests/qtest/libqos/pci.h             |  4 ----
>  tests/qtest/nvme-test.c              |  4 ----
>  tests/qtest/vhost-user-blk-test.c    |  6 ------
>  tests/qtest/virtio-blk-test.c        | 12 ------------
>  11 files changed, 13 insertions(+), 90 deletions(-)
>
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index e6264b07..5470602e 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -22,6 +22,8 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "system/kvm.h"
> +#include "system/qtest.h"
> +#include "exec/target_page.h"
>  #include "kvm_ppc.h"
>  #include "migration/vmstate.h"
>  #include "system/dma.h"
> @@ -125,7 +127,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>          .perm = IOMMU_NONE,
>      };
>  
> -    if ((addr >> tcet->page_shift) < tcet->nb_table) {
> +    if (qtest_enabled()) {
> +        /* spapr qtests does not set up the IOMMU, shortcut a linear map */
> +        ret.iova = addr & TARGET_PAGE_MASK;
> +        ret.translated_addr = addr & TARGET_PAGE_MASK;
> +        ret.addr_mask = ~TARGET_PAGE_MASK;
> +        ret.perm = IOMMU_RW;
> +    } else if ((addr >> tcet->page_shift) < tcet->nb_table) {
>          /* Check if we are in bound */
>          hwaddr page_mask = IOMMU_PAGE_MASK(tcet->page_shift);
>  
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index de9738fd..8300bf5a 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QGuestAllocator * alloc)
>  {
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      e1000e_send_verify(d, data, alloc);
>  }
> @@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
>  {
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      e1000e_receive_verify(d, data, alloc);
>  }
> @@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>  
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      for (i = 0; i < iterations; i++) {
>          e1000e_send_verify(d, data, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 3d397ea6..1b3b5aa6 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGuestAllocator * alloc)
>  {
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      igb_send_verify(d, data, alloc);
>  }
> @@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGuestAllocator * alloc)
>  {
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      igb_receive_verify(d, data, alloc);
>  }
> @@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>  
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> -
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
>  
>      for (i = 0; i < iterations; i++) {
>          igb_send_verify(d, data, alloc);
> diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
> index b7761752..93cc3b85 100644
> --- a/tests/qtest/libqos/generic-pcihost.c
> +++ b/tests/qtest/libqos/generic-pcihost.c
> @@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
>  
>      qpci->gpex_pio_base = 0x3eff0000;
>      qpci->bus.not_hotpluggable = !hotpluggable;
> -    qpci->bus.has_buggy_msi = false;
>  
>      qpci->bus.pio_readb = qpci_generic_pio_readb;
>      qpci->bus.pio_readw = qpci_generic_pio_readw;
> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
> index 147009f4..8b79d858 100644
> --- a/tests/qtest/libqos/pci-pc.c
> +++ b/tests/qtest/libqos/pci-pc.c
> @@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
>  {
>      assert(qts);
>  
> -    /* tests can use pci-bus */
> -    qpci->bus.has_buggy_msi = false;
> -
>      qpci->bus.pio_readb = qpci_pc_pio_readb;
>      qpci->bus.pio_readw = qpci_pc_pio_readw;
>      qpci->bus.pio_readl = qpci_pc_pio_readl;
> diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
> index 3723cbb3..b58cc1b5 100644
> --- a/tests/qtest/libqos/pci-spapr.c
> +++ b/tests/qtest/libqos/pci-spapr.c
> @@ -20,6 +20,10 @@
>   * PCI devices are always little-endian
>   * SPAPR by default is big-endian
>   * so PCI accessors need to swap data endianness
> + *
> + * The spapr iommu model has a qtest_enabled() check that short-cuts
> + * the TCE table and provides a linear map for DMA, since qtests does
> + * not have a way to make hcalls to set up the TCE table.
>   */
>  
>  static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
> @@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
>  {
>      assert(qts);
>  
> -    /* tests cannot use spapr, needs to be fixed first */
> -    qpci->bus.has_buggy_msi = true;
> -
>      qpci->alloc = alloc;
>  
>      qpci->bus.pio_readb = qpci_spapr_pio_readb;
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index 986ce31d..76b13ade 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>      }
>  }
>  
> -bool qpci_has_buggy_msi(QPCIDevice *dev)
> -{
> -    return dev->bus->has_buggy_msi;
> -}
> -
> -bool qpci_check_buggy_msi(QPCIDevice *dev)
> -{
> -    if (qpci_has_buggy_msi(dev)) {
> -        g_test_skip("Skipping due to incomplete support for MSI");
> -        return true;
> -    }
> -    return false;
> -}
> -
>  static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
>  {
>      g_assert(dev);
> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index 9f8f154c..ef40a691 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h
> @@ -51,7 +51,6 @@ struct QPCIBus {
>      QTestState *qts;
>      uint64_t pio_alloc_ptr, pio_limit;
>      uint64_t mmio_alloc_ptr, mmio_limit;
> -    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
>      bool not_hotpluggable; /* TRUE if devices cannot be hotplugged */
>  
>  };
> @@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
>  void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
>  int qpci_secondary_buses_init(QPCIBus *bus);
>  
> -bool qpci_has_buggy_msi(QPCIDevice *dev);
> -bool qpci_check_buggy_msi(QPCIDevice *dev);
> -
>  void qpci_device_enable(QPCIDevice *dev);
>  uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
>  void qpci_msix_enable(QPCIDevice *dev);
> diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
> index f9395cc2..388011be 100644
> --- a/tests/qtest/nvme-test.c
> +++ b/tests/qtest/nvme-test.c
> @@ -492,10 +492,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
>          { 333, false }
>      };
>  
> -    if (qpci_check_buggy_msi(pdev)) {
> -        return;
> -    }
> -

The nvme-test now fails with:

# starting QEMU: exec ./qemu-system-ppc64 -qtest
  unix:/tmp/qtest-1116322.sock -qtest-log /dev/null -chardev
  socket,path=/tmp/qtest-1116322.qmp,id=char0 -object
  monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with
  exit-with-parent=on -M pseries -drive
  id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw -object
  memory-backend-ram,id=pmr0,share=on,size=16 -device
  nvme,addr=04.0,drive=drv0,serial=foo -accel qtest

# nvme_wait_ready: csts 0
#  q 0x561957dedaa8 db_idx 1 doorbell 0x1004
# cq 0x561957dedaa8 db_idx 1 cqe 0x100000
#  q 0x561957deda78 db_idx 0 doorbell 0x1000
# sq 0x561957deda78 db_idx 0 sqe 0x101000
# nvme_wait_ready: csts 1
# sending req cid 123 no_wait 0
# sq 0x561957deda78 next_sqe 0 sqe 0x101000
# sq 0x561957deda78 commit sqe tail 0
**
ERROR:../tests/qtest/nvme-test.c:281:nvme_wait: assertion failed: (ready)

not ok
/ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/nvme/nvme-tests/migrate
- ERROR:../tests/qtest/nvme-test.c:281:nvme_wait: assertion failed: (ready)


