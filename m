Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDE4E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVChV-0001av-C7; Tue, 07 Jan 2025 11:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVChR-0001Xz-Uq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:45:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVChP-0004wX-P8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:45:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso105422105e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268298; x=1736873098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=loqH/A9V8RJySSRaJEkB2voNjbm7ujyFE4Se4pcsygQ=;
 b=DD2/kc8Nis2R71SfyXLkIeeR437YLi24vUtEiuZc/VOHT2begxl9dMasrwdUHvcnDZ
 Z+D1CAz5aLDJ+pN9CsxEOuEOJIHPvdKoG4kSmHUNIPwKHguAmnQqPGg+Xc3LW7+VyOXG
 u178HuX/vdFPa72j8r6KegVF0xv+6UONiprkGtgGUi0wCsiIYDKVTQT2DIHwi/Wh1/hB
 zVtsMoFTpfGP9i+yxljH4q8hLKRN0qVJDg9vV4R8hCtY8KYqlb47yg8EYSedDC6qvC3R
 8IRJf+6RzR34EsJCN6/ac6KLkZoDLu3HCMys5FS6gHP4kAXPoh8pOBg0yJzKKsdXjTCY
 5ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268298; x=1736873098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loqH/A9V8RJySSRaJEkB2voNjbm7ujyFE4Se4pcsygQ=;
 b=PRK5zctEWM3T41OGyJtw3TUECGhidIrUHS5zwTjb8AH+SNachoZguRMQ/hjPjXdLyO
 gX36pAruVzGBtfrd266ep6EMxaqB+aQ6YlKJGs+1OewqEAOWweglEPmhZPjvH3GSWZj1
 e/7wDcDRgvEyI30F6yBY36zdb/yU0vf00wlQ3CCcMavn2D9R3i48Sy2GqAY6brIBua7R
 ZpHiG7/vVZPNZdE+XTX6i7Tbc9LGN+m4FqIbQXXiaf77rCgECGfcAwOfT5Uu37gt6e/q
 p68i2ouWZ9MorQnBQvN0OZjWleV8FCb0mopkEyUWlRPDReYpkctNWkspE3Zl67+Y+4i5
 RmeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+KZGHqjWYWtwfOK/6YFVpU8HKL7bEDwqZirBExM2KPYjpfc/WUcrDhtpB4ywPmR07xfDM+zTP28N@nongnu.org
X-Gm-Message-State: AOJu0YwYyaP20PXrqVFv5iDQ2pKEAPLpSeCG+XDzKgnCPhZKJCXPLcet
 w3DS71U5zkxSdQ8ah1u+2f6hZPllyX/07wh9mOCAGzSeQfkVbf9b0JrodrgKPXo=
X-Gm-Gg: ASbGncuFIhpS+mmsFCHhmZtiQP14df1RB2StfMNbocKKsrRnJyeVPHfFmgUPEo8Phyb
 ExvJSbFzV7Gg1iVP6AJPJBs+l9hBBIltkoB5gaa3z/Kyq7WCYAmZmD8w62s0UMZKO6d3JD4kEul
 3Vkwo4paQqUStiyTZQDkrSncr69MFDWSyL+k1zH6j6jxYPBKNIwib6MSLRI7dNcmuUa7ICowGZX
 cg4fQiiRK6c8vK5oHIe4JsUSv6Cx4vXopaQKIghIdKRjFDYQk6PQ/+wP/zv9y6FCoTVu9TpxuvL
 rUbDYyAG0EAd/QcQR6nLWHv4
X-Google-Smtp-Source: AGHT+IE/qRqO2g9EwzhgV9RC2ZYCx3KxbMMUHlkuKdx8MjVEkxdsRIA62AL0cJiCW3NVIGHVzn3a/Q==
X-Received: by 2002:a05:600c:1c95:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-43668b5f5aamr480497335e9.23.1736268297995; 
 Tue, 07 Jan 2025 08:44:57 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm606698595e9.19.2025.01.07.08.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:44:57 -0800 (PST)
Message-ID: <f383b5c0-3bce-4c6c-bef7-ae34535083e8@linaro.org>
Date: Tue, 7 Jan 2025 17:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/pc: Fix level interrupt sharing for Xen event
 channel GSI
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <975f9dab5718b441e6d4463a43845dc22b5ddf8f.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <975f9dab5718b441e6d4463a43845dc22b5ddf8f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

(Cc'ing Bernhard)

On 7/1/25 17:32, David Woodhouse wrote:
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v2:
>   • Fix deassertion of PIRQ GSI.
> 
>   hw/i386/kvm/xen_evtchn.c | 50 +++++++++++++++++++++++++++++++---------
>   hw/i386/kvm/xen_evtchn.h |  2 +-
>   hw/i386/x86-common.c     | 32 ++++++++++++++++---------
>   3 files changed, 61 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index bd2a3cbee0..93f68790b0 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -140,6 +140,8 @@ struct XenEvtchnState {
>   
>       uint64_t callback_param;
>       bool evtchn_in_kernel;
> +    bool setting_callback_gsi;
> +    int extern_gsi_level;
>       uint32_t callback_gsi;
>   
>       QEMUBH *gsi_bh;
> @@ -431,7 +433,16 @@ void xen_evtchn_set_callback_level(int level)
>       }
>   
>       if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
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
>           if (level) {
>               /* Ensure the vCPU polls for deassertion */
>               kvm_xen_set_callback_asserted();
> @@ -1596,7 +1607,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
>       return pirq;
>   }
>   
> -bool xen_evtchn_set_gsi(int gsi, int level)
> +bool xen_evtchn_set_gsi(int gsi, int *level)
>   {
>       XenEvtchnState *s = xen_evtchn_singleton;
>       int pirq;
> @@ -1608,16 +1619,33 @@ bool xen_evtchn_set_gsi(int gsi, int level)
>       }
>   
>       /*
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
>        */
>       if (gsi && gsi == s->callback_gsi) {
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
>           return false;
>       }
>   
> @@ -1628,7 +1656,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
>           return false;
>       }
>   
> -    if (level) {
> +    if (*level) {
>           int port = s->pirq[pirq].port;
>   
>           s->pirq_gsi_set |= (1U << gsi);
> diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
> index b740acfc0d..0521ebc092 100644
> --- a/hw/i386/kvm/xen_evtchn.h
> +++ b/hw/i386/kvm/xen_evtchn.h
> @@ -23,7 +23,7 @@ void xen_evtchn_set_callback_level(int level);
>   
>   int xen_evtchn_set_port(uint16_t port);
>   
> -bool xen_evtchn_set_gsi(int gsi, int level);
> +bool xen_evtchn_set_gsi(int gsi, int *level);
>   void xen_evtchn_snoop_msi(PCIDevice *dev, bool is_msix, unsigned int vector,
>                             uint64_t addr, uint32_t data, bool is_masked);
>   void xen_evtchn_remove_pci_device(PCIDevice *dev);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index a7d46c3105..13badc26a5 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -450,8 +450,27 @@ static long get_file_size(FILE *f)
>   void gsi_handler(void *opaque, int n, int level)
>   {
>       GSIState *s = opaque;
> +    bool bypass_ioapic = false;
>   
>       trace_x86_gsi_interrupt(n, level);
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
>       switch (n) {
>       case 0 ... ISA_NUM_IRQS - 1:
>           if (s->i8259_irq[n]) {
> @@ -460,18 +479,9 @@ void gsi_handler(void *opaque, int n, int level)
>           }
>           /* fall through */
>       case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
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
>           }
> -#endif
> -        qemu_set_irq(s->ioapic_irq[n], level);
>           break;
>       case IO_APIC_SECONDARY_IRQBASE
>           ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:


