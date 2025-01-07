Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB361E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVC8j-0002Xi-L4; Tue, 07 Jan 2025 11:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVC8f-0002Wp-S3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVC8d-00010a-Vx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736266142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUtxwADAU9mg60+stM7QG1aiyiN7XGLZCqLiqM4AQ+4=;
 b=BQ2PJbD96wsHorKy1TbXvfgGNNkr6KDekcnKSNMoe5zr5TGYjecE9NaVIaiXy75V1gG1Mo
 jQms9lvRLsio19TaxcqRKVNbyoX22Sfi6PRJfEjCF4ng+CvaGSaEQPWL1HsTo7POiiB5ir
 GBcouoFlPjThzcOZyAxIUkOkgpX4PvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-faAojJirPvKTJ9gZpfXXCg-1; Tue, 07 Jan 2025 11:07:43 -0500
X-MC-Unique: faAojJirPvKTJ9gZpfXXCg-1
X-Mimecast-MFC-AGG-ID: faAojJirPvKTJ9gZpfXXCg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso6585710f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736266063; x=1736870863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUtxwADAU9mg60+stM7QG1aiyiN7XGLZCqLiqM4AQ+4=;
 b=RrQmQ59mHMRIvdmGJarRJwVcvcgSnYcz9xYDThIe7ijsJPPCjfTh0O6ivh0B/F4BZw
 bAoNcukGPTvqEr9XY4umvjiI9ziJGUpSu+VM41uNYRUxqHXiYoPFYBCnsGo4F69mDUqU
 ATnqCMu4nXgWqZF5qsEJxk5v3PRhyoWixglN+qidFuHCudV0mGCMPdFFM5UOoKdIQjXI
 pCqLel40ua/qlSq8yt+8JqjtHqDr/9tpWOb3enZR890cS+UxUxOc588fuZfZUgXQQg7P
 yg6bi6lD6m3XPf7DcY5+l2grNbx5mfDxZCSBA+VaoAwKHdqjjk3GusXl/iMG+U212uZg
 3fKg==
X-Gm-Message-State: AOJu0Yw+/iKhAcakeyWwBIHhSi6UigCo0dR8pLZBXtTqoRdHjIzDANzt
 B6vzfQZbDMCfyFbJ5usOebm9dOgIk+BapQ5FNplQxLQp4hj72hEthzsbIZzgO+wF4Er68f/Si+s
 PbusWMn4oA7v4xe46M9jCvR2fynzJLL7unZ0H1Q/qBHs0ULxPvAr3
X-Gm-Gg: ASbGnctI4Zq2MlbMmuFDytDvfiMkEUVKtQssIS33WSOwSaYbWE/PyWpX2vxg2oH7PPW
 +DFt9OyuT9N1MhdWwperrd820pugeJ7T+u/o+1cFjzRSMtwqSnr492odnGwv5d4Bab3Z6bdpT8N
 OReH7qPRJmuQRYAHCnwl+vfler5SCG+b3a3DNgLo9a9u8+EJj9ybOdBGLKvtCHjOmpDDuNB6EfK
 cHVl4x3uUz8IDJrA6kCek6oxYtHq+47c9YcG5XeRchyQHF6PPXo
X-Received: by 2002:adf:b30d:0:b0:38a:5122:5a07 with SMTP id
 ffacd0b85a97d-38a51225b64mr24353617f8f.15.1736266061057; 
 Tue, 07 Jan 2025 08:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG80/ncQrIrDPTJ6H1mk0KO7Tvyh3lX7g+gy7YIaQJf9HyuNCd58dzPC08CwCf8KFer3If4Nw==
X-Received: by 2002:adf:b30d:0:b0:38a:5122:5a07 with SMTP id
 ffacd0b85a97d-38a51225b64mr24353557f8f.15.1736266060170; 
 Tue, 07 Jan 2025 08:07:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:9bff:5947:c940:c49b:3e80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4471bsm635564245e9.44.2025.01.07.08.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:07:39 -0800 (PST)
Date: Tue, 7 Jan 2025 11:07:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
Message-ID: <20250107110718-mutt-send-email-mst@kernel.org>
References: <e592f9127f2d9919e6ccb76a0afb38c5d725d8ec.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e592f9127f2d9919e6ccb76a0afb38c5d725d8ec.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 19, 2024 at 05:24:11PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The system GSIs are not designed for sharing. One device might assert a
> shared interrupt with qemu_set_irq() and another might deassert it, and
> the level from the first device is lost.
> 
> This could be solved by using a multiplexer which functions as an OR
> gate, much like the PCI code already implements for pci_set_irq() for
> muxing the INTx lines.
> 
> Alternatively, it could be solved by having a 'resample' callback which
> is invoked when the interrupt is acked at the interrupt controller, and
> causes the devices to re-trigger the interrupt if it should still be
> pending. This is the model that VFIO in Linux uses, with a 'resampler'
> eventfd that actually unmasks the interrupt on the hardware device and
> thus triggers a new interrupt from it if needed. QEMU currently doesn't
> use that VFIO interface correctly, and just bashes on the resampler for
> every MMIO access to the device "just in case".
> 
> This does neither of those. The Xen event channel GSI support *already*
> has hooks into the PC gsi_handler() code, for routing GSIs to PIRQs. So
> we can implement the logical OR of the external input (from PCI INTx,
> serial etc.) with the Xen event channel GSI by allowing that existing
> hook to modify the 'level' being asserted.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2731
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Xen things so feel free to merge.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/kvm/xen_evtchn.c | 48 +++++++++++++++++++++++++++++++---------
>  hw/i386/kvm/xen_evtchn.h |  2 +-
>  hw/i386/x86-common.c     | 32 ++++++++++++++++++---------
>  3 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 07bd0c9ab8..62b906e4ef 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -140,6 +140,8 @@ struct XenEvtchnState {
>  
>      uint64_t callback_param;
>      bool evtchn_in_kernel;
> +    bool setting_callback_gsi;
> +    int extern_gsi_level;
>      uint32_t callback_gsi;
>  
>      QEMUBH *gsi_bh;
> @@ -431,7 +433,16 @@ void xen_evtchn_set_callback_level(int level)
>      }
>  
>      if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
> -        qemu_set_irq(s->callback_gsis[s->callback_gsi], level);
> +        /*
> +         * Ugly, but since we hold the BQL we can set this flag so that
> +         * xen_evtchn_set_gsi() can tell the difference between this code
> +         * setting the GSI, and an external device (PCI INTx) doing so.
> +         */
> +        s->setting_callback_gsi = true;
> +        /* Do not deassert the line if an external device is asserting it. */
> +        qemu_set_irq(s->callback_gsis[s->callback_gsi],
> +                     level || s->extern_gsi_level);
> +        s->setting_callback_gsi = false;
>          if (level) {
>              /* Ensure the vCPU polls for deassertion */
>              kvm_xen_set_callback_asserted();
> @@ -1596,7 +1607,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
>      return pirq;
>  }
>  
> -bool xen_evtchn_set_gsi(int gsi, int level)
> +bool xen_evtchn_set_gsi(int gsi, int *level)
>  {
>      XenEvtchnState *s = xen_evtchn_singleton;
>      int pirq;
> @@ -1608,16 +1619,33 @@ bool xen_evtchn_set_gsi(int gsi, int level)
>      }
>  
>      /*
> -     * Check that that it *isn't* the event channel GSI, and thus
> -     * that we are not recursing and it's safe to take s->port_lock.
> -     *
> -     * Locking aside, it's perfectly sane to bail out early for that
> -     * special case, as it would make no sense for the event channel
> -     * GSI to be routed back to event channels, when the delivery
> -     * method is to raise the GSI... that recursion wouldn't *just*
> -     * be a locking issue.
> +     * For the callback_gsi we need to implement a logical OR of the event
> +     * channel GSI and the external input (e.g. from PCI INTx), because
> +     * QEMU itself doesn't support shared level interrupts via demux or
> +     * resamplers.
>       */
>      if (gsi && gsi == s->callback_gsi) {
> +        /* Remember the external state of the GSI pin (e.g. from PCI INTx) */
> +        if (!s->setting_callback_gsi) {
> +            s->extern_gsi_level = *level;
> +
> +            /*
> +             * Don't allow the external device to deassert the line if the
> +             * eveht channel GSI should still be asserted.
> +             */
> +            if (!s->extern_gsi_level) {
> +                struct vcpu_info *vi = kvm_xen_get_vcpu_info_hva(0);
> +                if (vi && vi->evtchn_upcall_pending) {
> +                    *level = 1;
> +                }
> +            }
> +        }
> +
> +        /*
> +         * The event channel GSI cannot be routed to PIRQ, as that would make
> +         * no sense. It could also deadlock on s->port_lock, if we proceed.
> +         * So bail out now.
> +         */
>          return false;
>      }
>  
> diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
> index b740acfc0d..0521ebc092 100644
> --- a/hw/i386/kvm/xen_evtchn.h
> +++ b/hw/i386/kvm/xen_evtchn.h
> @@ -23,7 +23,7 @@ void xen_evtchn_set_callback_level(int level);
>  
>  int xen_evtchn_set_port(uint16_t port);
>  
> -bool xen_evtchn_set_gsi(int gsi, int level);
> +bool xen_evtchn_set_gsi(int gsi, int *level);
>  void xen_evtchn_snoop_msi(PCIDevice *dev, bool is_msix, unsigned int vector,
>                            uint64_t addr, uint32_t data, bool is_masked);
>  void xen_evtchn_remove_pci_device(PCIDevice *dev);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 3f78182692..e061580f67 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -450,8 +450,27 @@ static long get_file_size(FILE *f)
>  void gsi_handler(void *opaque, int n, int level)
>  {
>      GSIState *s = opaque;
> +    bool bypass_ioapic = false;
>  
>      trace_x86_gsi_interrupt(n, level);
> +
> +#ifdef CONFIG_XEN_EMU
> +        /*
> +         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
> +         * routing actually works properly under Xen). And then to
> +         * *either* the PIRQ handling or the I/OAPIC depending on
> +         * whether the former wants it.
> +         *
> +         * Additionally, this hook allows the Xen event channel GSI to
> +         * work around QEMU's lack of support for shared level interrupts,
> +         * by keeping track of the externally driven state of the pin and
> +         * implementing a logical OR with the state of the evtchn GSI.
> +         */
> +    if (xen_mode == XEN_EMULATE) {
> +        bypass_ioapic = xen_evtchn_set_gsi(n, &level);
> +    }
> +#endif
> +
>      switch (n) {
>      case 0 ... ISA_NUM_IRQS - 1:
>          if (s->i8259_irq[n]) {
> @@ -460,18 +479,9 @@ void gsi_handler(void *opaque, int n, int level)
>          }
>          /* fall through */
>      case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
> -#ifdef CONFIG_XEN_EMU
> -        /*
> -         * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
> -         * routing actually works properly under Xen). And then to
> -         * *either* the PIRQ handling or the I/OAPIC depending on
> -         * whether the former wants it.
> -         */
> -        if (xen_mode == XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
> -            break;
> +        if (!bypass_ioapic) {
> +            qemu_set_irq(s->ioapic_irq[n], level);
>          }
> -#endif
> -        qemu_set_irq(s->ioapic_irq[n], level);
>          break;
>      case IO_APIC_SECONDARY_IRQBASE
>          ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:
> -- 
> 2.47.0
> 
> 



