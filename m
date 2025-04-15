Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CEC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 18:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4khJ-0002IH-Tu; Tue, 15 Apr 2025 14:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4khA-0002Gt-UQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:07:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4kh7-00054a-C1
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:07:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BAD5211A0;
 Tue, 15 Apr 2025 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744740455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAZnqB+1navEeRSN5eeMNti2MLqJcq3umMSysKM++hk=;
 b=kTJCipTmuQjcCcwTdTjn47Po6W/CZ39nSOQ6mJwdW+logazag2QBMaWHaep5dlM9DkDWdx
 I4HFNkQJ2yMByTnJ7qs3/P3eB840ePg9DKf6jvtq9Qg4DBTFj9F6aflklSDuBbYLl2rzD+
 8Q/Y9ZuM9SUL0CUZgQFVqJjDqoQ3MI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744740455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAZnqB+1navEeRSN5eeMNti2MLqJcq3umMSysKM++hk=;
 b=f6zZcdPTWxaILFMWwmlCk7MgmZt9UrPArL7jbDGIcSl50Q13KDEItcviDsX+wPazQWZkJI
 SVS7DQ5bnWsXiTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744740455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAZnqB+1navEeRSN5eeMNti2MLqJcq3umMSysKM++hk=;
 b=kTJCipTmuQjcCcwTdTjn47Po6W/CZ39nSOQ6mJwdW+logazag2QBMaWHaep5dlM9DkDWdx
 I4HFNkQJ2yMByTnJ7qs3/P3eB840ePg9DKf6jvtq9Qg4DBTFj9F6aflklSDuBbYLl2rzD+
 8Q/Y9ZuM9SUL0CUZgQFVqJjDqoQ3MI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744740455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAZnqB+1navEeRSN5eeMNti2MLqJcq3umMSysKM++hk=;
 b=f6zZcdPTWxaILFMWwmlCk7MgmZt9UrPArL7jbDGIcSl50Q13KDEItcviDsX+wPazQWZkJI
 SVS7DQ5bnWsXiTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E952137A5;
 Tue, 15 Apr 2025 18:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iV7sEmag/mcxfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Apr 2025 18:07:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC PATCH 2/2] tests/qtest: Enable spapr dma with linear iommu
 map
In-Reply-To: <20250415081914.378236-3-npiggin@gmail.com>
References: <20250415081914.378236-1-npiggin@gmail.com>
 <20250415081914.378236-3-npiggin@gmail.com>
Date: Tue, 15 Apr 2025 15:07:31 -0300
Message-ID: <87ikn5fgd8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,redhat.com,nongnu.org];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> qtests spapr dma was broken because the iommu was not set up.
>
> spapr requires hypercalls to set up the iommu (TCE tables), but
> there is no support for that or a side-channel to the iommu in
> qtests at the moment, so add a quick workaround in QEMU to have
> the spapr iommu provide a linear map to memory when running
> qtests.

That's fine.

But what would it take to add support? Add another callback such as
qtest_rtas_call() to handle hcalls and call H_PUT_TCE from the test? Or
is there some other complication?

>
> The buggy msix checks can all be removed since the tests all work
> now.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/libqos/pci.h             |  4 ----
>  hw/ppc/spapr_iommu.c                 |  9 ++++++++-
>  tests/qtest/e1000e-test.c            | 23 +++--------------------
>  tests/qtest/igb-test.c               | 21 ---------------------
>  tests/qtest/libqos/generic-pcihost.c |  1 -
>  tests/qtest/libqos/pci-pc.c          |  3 ---
>  tests/qtest/libqos/pci-spapr.c       |  7 ++++---
>  tests/qtest/libqos/pci.c             | 14 --------------
>  tests/qtest/vhost-user-blk-test.c    |  6 ------
>  tests/qtest/virtio-blk-test.c        | 12 ------------
>  10 files changed, 15 insertions(+), 85 deletions(-)
>

...

> @@ -173,13 +159,10 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>  
>      QE1000E_PCI *e1000e = obj;
>      QE1000E *d = &e1000e->e1000e;
> -    QOSGraphObject *e_object = obj;
> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>  
> -    /* FIXME: add spapr support */
> -    if (qpci_check_buggy_msi(dev)) {
> -        return;
> -    }
> +    /* Use EITR for one irq and disable it for the other, for testing */
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 500);
> +    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);

What's this about?

>  
>      for (i = 0; i < iterations; i++) {
>          e1000e_send_verify(d, data, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 3d397ea6973..1b3b5aa6c76 100644
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
> index 4bbeb5ff508..568897e0ecc 100644
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
> index 147009f4f44..8b79d858bd5 100644
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
> index 0f1023e4a73..dfa2087a599 100644
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
> index a59197b9922..3bf6a0e0127 100644
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
> diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
> index ea90d41232e..3e71fdb9d78 100644
> --- a/tests/qtest/vhost-user-blk-test.c
> +++ b/tests/qtest/vhost-user-blk-test.c
> @@ -554,14 +554,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
>      uint32_t desc_idx;
>      uint8_t status;
>      char *data;
> -    QOSGraphObject *blk_object = obj;
> -    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
>      QTestState *qts = global_qtest;
>  
> -    if (qpci_check_buggy_msi(pci_dev)) {
> -        return;
> -    }
> -
>      qpci_msix_enable(pdev->pdev);
>      qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
>  
> diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
> index 98c906ebb4a..3a005d600c1 100644
> --- a/tests/qtest/virtio-blk-test.c
> +++ b/tests/qtest/virtio-blk-test.c
> @@ -474,14 +474,8 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
>      uint32_t free_head;
>      uint8_t status;
>      char *data;
> -    QOSGraphObject *blk_object = obj;
> -    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
>      QTestState *qts = global_qtest;
>  
> -    if (qpci_check_buggy_msi(pci_dev)) {
> -        return;
> -    }
> -
>      qpci_msix_enable(pdev->pdev);
>      qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
>  
> @@ -584,14 +578,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
>      uint32_t desc_idx;
>      uint8_t status;
>      char *data;
> -    QOSGraphObject *blk_object = obj;
> -    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
>      QTestState *qts = global_qtest;
>  
> -    if (qpci_check_buggy_msi(pci_dev)) {
> -        return;
> -    }
> -
>      qpci_msix_enable(pdev->pdev);
>      qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);

