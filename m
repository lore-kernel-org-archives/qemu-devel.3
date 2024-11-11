Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F6AD2E9FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVSs-0006aM-9Q; Mon, 11 Nov 2024 09:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tAVSo-0006Zr-A5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:32:22 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tAVSm-0008Sp-5l
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:32:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53BC71F38E;
 Mon, 11 Nov 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731335538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBpUsXKLSFaf/MAjCG2HZTZWktQ580QBpJ6d9j7qWpk=;
 b=IjTdKllglo6cCfVRda+pFFgA8bQ3QinuCVSDypkOOYmb8m3XEGCQ758cbZgA4e8v+0pLSR
 KKBH9cYikySEmzKeuQB61sKiv+gLBVOOcJ2TlBLDvhc/OYLqJnxe5JxADg2ZjlKY5xAb1Z
 kKq1mI9dGrpX86LY6BBpGOm5C35TDB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731335538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBpUsXKLSFaf/MAjCG2HZTZWktQ580QBpJ6d9j7qWpk=;
 b=s7XWSl9lNmLXFeW+g9I1bq0FSCx2wpFHombdszpDEITSgoGCbF9HGWz6SuzsSLpp4JBxD3
 KsUDGOilAG8kV3Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IjTdKllg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s7XWSl9l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731335538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBpUsXKLSFaf/MAjCG2HZTZWktQ580QBpJ6d9j7qWpk=;
 b=IjTdKllglo6cCfVRda+pFFgA8bQ3QinuCVSDypkOOYmb8m3XEGCQ758cbZgA4e8v+0pLSR
 KKBH9cYikySEmzKeuQB61sKiv+gLBVOOcJ2TlBLDvhc/OYLqJnxe5JxADg2ZjlKY5xAb1Z
 kKq1mI9dGrpX86LY6BBpGOm5C35TDB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731335538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBpUsXKLSFaf/MAjCG2HZTZWktQ580QBpJ6d9j7qWpk=;
 b=s7XWSl9lNmLXFeW+g9I1bq0FSCx2wpFHombdszpDEITSgoGCbF9HGWz6SuzsSLpp4JBxD3
 KsUDGOilAG8kV3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D030A13301;
 Mon, 11 Nov 2024 14:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 56RuJXEVMmfpaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Nov 2024 14:32:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH 4/5] qtest/xhci: Add controller and device setup and
 ring tests
In-Reply-To: <20241108154229.263097-5-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
 <20241108154229.263097-5-npiggin@gmail.com>
Date: Mon, 11 Nov 2024 11:32:15 -0300
Message-ID: <87msi5j0y8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 53BC71F38E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,redhat.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Add tests which init the host controller registers to the point
> where command and event rings, irqs are operational. Enumerate
> ports and set up an attached device context that enables device
> transfer ring to be set up and tested.
>
> This test does a bunch of things at once and is yet well
> librified, but it allows testing basic mechanisms and gives a
> starting point for further work.

Please give it a pass through checkpatch when you get the chance.

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/usb-hcd-xhci-test.h | 232 +++++++++++++++
>  tests/qtest/usb-hcd-xhci-test.c | 506 +++++++++++++++++++++++++++++++-
>  2 files changed, 732 insertions(+), 6 deletions(-)
>  create mode 100644 tests/qtest/usb-hcd-xhci-test.h
>

<snip>

> +static void pci_xhci_stress_rings(void)
> +{
> +    XHCIQState *s;
> +    uint32_t value;
> +    uint64_t input_context;
> +    XHCIEvRingSeg ev_seg;
> +    XHCITRB trb;
> +    uint32_t hcsparams1;
> +    uint32_t slotid;
> +    void *mem;
> +    int i;
> +
> +    mem = g_malloc(0x1000);

This is leaking.

> +    memset(mem, 0, 0x1000);
> +
> +    s = xhci_boot("-M q35 "
> +            "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
> +            "-device usb-storage,bus=xhci.0,drive=drive0 "
> +            "-drive id=drive0,if=none,file=null-co://,"
> +                "file.read-zeroes=on,format=raw "
> +            );
> +//            "-d trace:*xhci*,trace:*usb*,trace:*msi*");
> +
> +    hcsparams1 = xhci_cap_readl(s, 0x4); /* HCSPARAMS1 */
> +    s->maxports = (hcsparams1 >> 24) & 0xff;
> +    s->maxintrs = (hcsparams1 >> 8) & 0x3ff;
> +    s->maxslots = hcsparams1 & 0xff;
> +
> +    s->dboff = xhci_cap_readl(s, 0x14); /* DBOFF */
> +    s->rtoff = xhci_cap_readl(s, 0x18); /* RTOFF */
> +
> +    s->dc_base_array = xhci_guest_zalloc(s, 0x800);
> +    s->command_ring = xhci_guest_zalloc(s, 0x1000);
> +    s->event_ring = xhci_guest_zalloc(s, 0x1000);
> +    s->event_ring_seg = xhci_guest_zalloc(s, 0x100);
> +
> +    /* Arbitrary small sizes so we can make them wrap */
> +    s->cr_trb_entries = 0x20;
> +    s->cr_trb_c = 1;
> +    s->er_trb_entries = 0x10;
> +    s->er_trb_c = 1;
> +
> +    ev_seg.addr_low = cpu_to_le32(s->event_ring & 0xffffffff);
> +    ev_seg.addr_high = cpu_to_le32(s->event_ring >> 32);
> +    ev_seg.size = cpu_to_le32(0x10);
> +    ev_seg.rsvd = 0;
> +    qtest_memwrite(s->parent->qts, s->event_ring_seg, &ev_seg, sizeof(ev_seg));
> +
> +    xhci_op_writel(s, 0x0, USBCMD_HCRST); /* USBCMD */
> +    do {
> +        value = xhci_op_readl(s, 0x4); /* USBSTS */
> +    } while (value & (1 << 11)); /* CNR */
> +
> +    xhci_op_writel(s, 0x38, s->maxslots); /* CONFIG */
> +
> +    /* DCBAAP */
> +    xhci_op_writel(s, 0x30, s->dc_base_array & 0xffffffff);
> +    xhci_op_writel(s, 0x34, s->dc_base_array >> 32);
> +
> +    /* CRCR */
> +    xhci_op_writel(s, 0x18, (s->command_ring & 0xffffffff) | s->cr_trb_c);
> +    xhci_op_writel(s, 0x1c, s->command_ring >> 32);
> +
> +    xhci_rt_writel(s, 0x28, 1); /* ERSTSZ */
> +
> +    /* ERSTBA */
> +    xhci_rt_writel(s, 0x30, s->event_ring_seg & 0xffffffff);
> +    xhci_rt_writel(s, 0x34, s->event_ring_seg >> 32);
> +
> +    /* ERDP */
> +    xhci_rt_writel(s, 0x38, s->event_ring & 0xffffffff);
> +    xhci_rt_writel(s, 0x3c, s->event_ring >> 32);
> +
> +    qpci_msix_enable(s->dev);
> +    xhci_op_writel(s, 0x0, USBCMD_RS | USBCMD_INTE); /* RUN + INTE */
> +
> +    /* Enable interrupts on ER IMAN */
> +    xhci_rt_writel(s, 0x20, IMAN_IE);
> +
> +    assert(!qpci_msix_pending(s->dev, 0));
> +
> +    /* Wrap the command and event rings with no-ops a few times */
> +    for (i = 0; i < 100; i++) {
> +        /* Issue a command ring no-op */
> +        memset(&trb, 0, sizeof(trb));
> +        trb.control |= CR_NOOP << TRB_TYPE_SHIFT;
> +        trb.control |= TRB_TR_IOC;
> +        submit_cr_trb(s, &trb);
> +        wait_event_trb(s, &trb);
> +    }
> +
> +    /* Query ports */
> +    for (i = 0; i < s->maxports; i++) {
> +        value = xhci_port_readl(s, i, 0); /* PORTSC */
> +
> +        /* Only first port should be attached and enabled */
> +        if (i == 0) {
> +            g_assert(value & PORTSC_CCS);
> +            g_assert(value & PORTSC_PED);
> +	    /* Port Speed must be identified */
> +	    g_assert(((value >> PORTSC_SPEED_SHIFT) & PORTSC_SPEED_MASK) != 0);
> +        } else {
> +            g_assert(!(value & PORTSC_CCS));
> +            g_assert(!(value & PORTSC_PED));
> +            g_assert(((value >> PORTSC_PLS_SHIFT) & PORTSC_PLS_MASK) == 5);
> +        }
> +    }
> +
> +    /* Issue a command ring enable slot */
> +    memset(&trb, 0, sizeof(trb));
> +    trb.control |= CR_ENABLE_SLOT << TRB_TYPE_SHIFT;
> +    trb.control |= TRB_TR_IOC;
> +    submit_cr_trb(s, &trb);
> +    wait_event_trb(s, &trb);
> +    slotid = (trb.control >> TRB_CR_SLOTID_SHIFT) & 0xff;
> +
> +    s->slots[slotid].transfer_ring = xhci_guest_zalloc(s, 0x1000);
> +    s->slots[slotid].tr_trb_entries = 0x10;
> +    s->slots[slotid].tr_trb_c = 1;
> +
> +    /* 32-byte input context size, should check HCCPARAMS1 for 64-byte size */
> +    input_context = xhci_guest_zalloc(s, 0x420);
> +
> +    /* Set input control context */
> +    ((uint32_t *)mem)[1] = cpu_to_le32(0x3); /* Add device contexts 0 and 1 */
> +    ((uint32_t *)mem)[8] = cpu_to_le32(1 << 27); /* 1 context entry */
> +    ((uint32_t *)mem)[9] = cpu_to_le32(1 << 16); /* 1 port number */
> +
> +    /* Set endpoint 0 context */
> +    ((uint32_t *)mem)[16] = 0;
> +    ((uint32_t *)mem)[17] = cpu_to_le32((ET_CONTROL << EP_TYPE_SHIFT) |
> +                                        (0x200 << 16)); /* max packet sz XXX? */
> +    ((uint32_t *)mem)[18] = cpu_to_le32((s->slots[slotid].transfer_ring & 0xffffffff) | 1); /* DCS=1 */
> +    ((uint32_t *)mem)[19] = cpu_to_le32(s->slots[slotid].transfer_ring >> 32);
> +    ((uint32_t *)mem)[20] = cpu_to_le32(0x200); /* Average TRB length */
> +    qtest_memwrite(s->parent->qts, input_context, mem, 0x420);
> +
> +    s->slots[slotid].device_context = xhci_guest_zalloc(s, 0x400);
> +
> +    ((uint64_t *)mem)[0] = cpu_to_le64(s->slots[slotid].device_context);
> +    qtest_memwrite(s->parent->qts, s->dc_base_array + 8*slotid, mem, 8);
> +
> +    /* Issue a command ring address device */
> +    memset(&trb, 0, sizeof(trb));
> +    trb.parameter = input_context;
> +    trb.control |= CR_ADDRESS_DEVICE << TRB_TYPE_SHIFT;
> +    trb.control |= slotid << TRB_CR_SLOTID_SHIFT;
> +    submit_cr_trb(s, &trb);
> +    wait_event_trb(s, &trb);
> +
> +    /* XXX: Check EP state is running? */
> +
> +    /* Shut it down */
> +    qpci_msix_disable(s->dev);
> +
> +    guest_free(&s->parent->alloc, s->slots[slotid].device_context);
> +    guest_free(&s->parent->alloc, s->slots[slotid].transfer_ring);
> +    guest_free(&s->parent->alloc, input_context);
> +    guest_free(&s->parent->alloc, s->event_ring);
> +    guest_free(&s->parent->alloc, s->event_ring_seg);
> +    guest_free(&s->parent->alloc, s->command_ring);
> +    guest_free(&s->parent->alloc, s->dc_base_array);
> +
> +    xhci_shutdown(s);
> +}
> +
> +/* tests */
>  int main(int argc, char **argv)
>  {
>      int ret;
> +    const char *arch;
>  
>      g_test_init(&argc, &argv, NULL);
>  
> +    /* Check architecture */
> +    arch = qtest_get_arch();
> +    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> +        g_test_message("Skipping test for non-x86");
> +        return 0;
> +    }
> +
> +    if (!qtest_has_device("nec-usb-xhci")) {
> +        return 0;
> +    }
> +
>      qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
>      if (qtest_has_device("usb-uas")) {
>          qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
> @@ -56,11 +549,12 @@ int main(int argc, char **argv)
>      if (qtest_has_device("usb-ccid")) {
>          qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
>      }
> +    if (qtest_has_device("usb-storage")) {
> +        qtest_add_func("/xhci/pci/xhci-stress-rings", pci_xhci_stress_rings);
> +    }
>  
> -    qtest_start("-device nec-usb-xhci,id=xhci"
> -                " -drive id=drive0,if=none,file=null-co://,"
> -                "file.read-zeroes=on,format=raw");
>      ret = g_test_run();
> +
>      qtest_end();
>  
>      return ret;

