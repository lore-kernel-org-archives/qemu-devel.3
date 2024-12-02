Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ACAD4979F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 05:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHzA6-0002lr-Ti; Mon, 02 Dec 2024 00:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHzA4-0002lT-Ta
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:39:57 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHzA2-0001dj-NF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:39:56 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea45abb4e1so1316615b6e.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 21:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733117992; x=1733722792;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0h5/BJMARaJRy68VutD5mwkeUyaCsT1kUZjvH+b4rk=;
 b=dJVf/8cEgZGFwGH20loks6Ag36z2ZpVf8Oibc5k/lOQXVk7RyGXfZuX5nlUxI0yoba
 16LfBfurrdSuuUF2QC+r9drFHUtSNMPu5vcdwJLI4QewWDfVp7I/Mq76DlT5enarCcch
 XaY61icsmlI5X7cG9r6/+FANQYlzEY0d7u31islpkJ7ifTy0uM/dfMbZ6kTyBWqLx2oG
 J0HBE/vhLsvLTu945IaFn8/dEnJReWG0M5SdfnQykd15D3Jk9k0GFuxPIFqpimVrvOlW
 Co1xDf9rxoR0q1u1EZ11eWc7jYMfn0YR7CGi8NSq58w/pYi/liDjBiMTeI4/BMuQFZcY
 zlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733117992; x=1733722792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0h5/BJMARaJRy68VutD5mwkeUyaCsT1kUZjvH+b4rk=;
 b=NOFxKDH9oSx+EV4GcGaV0jdok9/6lknSuMWjgYWxGfVVBeTA2VfvspjIoN4GVg5/39
 9QQ6HlCrd3CVvoVtfVjTPawPHiTkkUlIdAbR5Byisv1vrpqK+KkfU2zClJ5bJLb5FSpz
 B+XM7v6/5z1PH+YI+hY4W8S7nmfIAJzmCwHR3TbcFspBI+4bjvd8jkZ31s8zmdAKiMMQ
 zviALqlrNlT0NaZuLx26281hUk/Iqqt5B98ZiraYpzVxN93Ni9HLxz/A0UYzrf59zFHx
 6jLdAYgYe8BhK583bM+yUHwSwoaUJmizD37+9pCW55piRBI0hB4tTbXZCgl0R4Z1WaK9
 SPww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsvzEiDDzhp6p0IKF2kJFMLG+WNP2MIdd1r5SAMDpl+OUSqw++9RVO5LADv7jr75cNnp7I/hSGbXB@nongnu.org
X-Gm-Message-State: AOJu0YybwyEEPWmZ/5RdpPwRYwOu3n9XWzr5IJza1QLa6McxV++hEJgx
 ir8H9RB/SPXvTALC9p2tK/uMEhRRLz+EBPq0N8dUfNDzXe+RnDuaxkszOUBunvc=
X-Gm-Gg: ASbGncsP6MRPEx8W+1nOH9c6v1zqHvZJOvuykNL2S9s7E6iAJH3lGSbpYdOUqueUH+e
 +/0NqvIqS4K5SW5eK1eQB61WSxe/E0LYWvQfGg/+D8cfDXQ4SgBgb89t3kxGx2AFP/LMoDP4f+9
 NCtNGsqx3NKY6I90DJPFvjFgieubFk99nGJvjXcOlPOD6wQwBDSOM5y6OwWqmdb2HMiwO1uZDCB
 wzUthhqv1Wdx+5oItrKkP4umGU0i4TcYPGX9NneQFp5iwfpyW4hC1Udo1N9j9U=
X-Google-Smtp-Source: AGHT+IHNlDChwqqCBq24AT1zYpq6i2PmX6I4xey24dcpz3SliJwm0hgn2Hn19Nuh/qhfG89KSb9P3Q==
X-Received: by 2002:a05:6808:1486:b0:3ea:4240:e024 with SMTP id
 5614622812f47-3ea6dd45f56mr14609876b6e.27.1733117992579; 
 Sun, 01 Dec 2024 21:39:52 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea860e897csm2151365b6e.23.2024.12.01.21.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 21:39:52 -0800 (PST)
Message-ID: <a3812fbe-f5b7-442c-8140-54e87da6a78c@daynix.com>
Date: Mon, 2 Dec 2024 14:39:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC-for-10.0] hw/usb/hcd-xhci-pci: Use event ring 0 if
 interrupter mapping unsupported
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com
References: <20241201160316.96121-1-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241201160316.96121-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
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

On 2024/12/02 1:03, Phil Dennis-Jordan wrote:
> This change addresses an edge case that trips up macOS guest drivers
> for PCI based XHCI controllers.
> 
> The XHCI specification, section 4.17.1 specifies that "If Interrupter
> Mapping is not supported, the Interrupter Target field shall be
> ignored by the xHC and all Events targeted at Interrupter 0."
> 
> The PCI XHCI controller supports MSI(-X) and maxintrs is therefore
> reasonably set to 16. The specification does not address whether
> interrupter mapping should be considered "supported" if the guest
> driver does not enable MSI(-X) via the PCI configuration area, possibly
> because the PCI host bus does not support it.

This section says "an xHC implementation may support Interrupter 
Mapping," and section 3 says "Host Controller (xHC). The host controller 
is the specific hardware implementation of the host controller 
architecture." So the entity that "supports" interrupt mapping is the 
hardware and does not include the guest driver.

> 
> QEMU's XHCI device has so far not specially addressed this case, and
> no interrupt is generated for events delivered to event rings 1 and
> above. The macOS guest driver does not get along with this
> interpretation, so many events are not delivered to the guest OS when
> MSI(-X) is off.
> 
> This patch changes the xhci_event() function such that event ring 0
> is always used when numintrs is 1 (as per spec section 4.17.1) or
> if neither MSI nor MSI-X are enabled. The latter is checked by adding
> a new, optional intr_mapping_supported function pointer field supplied
> by the concrete XHCI controller implementation. The PCI implementation's
> supplied function calls msix_enabled and msi_enabled accordingly.

I think the current behavior to drop interrupts is correct and targeting 
Interrupter 0 is a violation of the specification.

As noted earlier, this xHC implementation supports Interrupter Mapping, 
so it must target Interrupters 1 to MaxInstrs-1 instead of always 
targeting Interrupter 0.

At the beginning of section 4.7, the specification also says "an 
Interrupter shall assert an interrupt if it is enabled and its 
associated Event Ring contains Event TRBs that require an interrupt". It 
also says "interrupters 1 to MaxIntrs-1 shall be disabled" "when the PCI 
Pin Interrupt is activated". So disabled Interrupters must drop interrupts.

While the proposed behavior violates the specification, it is still 
crucial to run macOS guests. A possible solution is to add a property to 
enable this behavior not conforming to the specification, and requires 
users to opt-in it when running macOS.

> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
> ---
> I've been chasing this problem for a while, and I've finally figured
> out the cause, and I think an acceptable solution. I've explained the
> problem and quoted the relevant sections of the XHCI spec in more
> detail in the linked GitLab issue:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/2705
> 
> The fix provided is I think the simplest one in terms of lines of code,
> but it's also a little ugly, as we're constantly checking msix_enabled
> and msi_enabled via a callback function. Granted, we're already doing
> that in xhci_pci_intr_raise and xhci_pci_intr_update, but this adds
> a bunch more calls.

The fact that macOS rejects xHC with numintrs < 4 implies macOS still 
expects multiple Interrupters are enabled, but all Interrupters assert 
the INTx# pin. Implementation of such a behavior will be contained in 
xhci_pci_intr_raise() so we can save an indirection call of 
intr_mapping_supported() as a bonus.

Regards,
Akihiko Odaki

> 
> The main alternative I can see is to "push" the state of whether
> interrupter mapping is supported: provide a custom config_write
> implementation for the PCI device, and every time the configuration
> area is updated, evaluate whether or not this means that MSI or MSI-X
> are enabled and update a corresponding flag inside XHCIState. We could
> even use this opportunity to switch out different .intr_raise and
> .intr_update functions depending on which interrupt delivery mechanism
> is active in the PCI device.
> 
> 
>   hw/usb/hcd-xhci-pci.c | 9 +++++++++
>   hw/usb/hcd-xhci.c     | 5 +++++
>   hw/usb/hcd-xhci.h     | 5 +++++
>   3 files changed, 19 insertions(+)
> 
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index a039f5778a6..21802211cf7 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -81,6 +81,14 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
>       return false;
>   }
>   
> +static bool xhci_pci_intr_mapping_supported(XHCIState *xhci)
> +{
> +    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
> +    PCIDevice *pci_dev = PCI_DEVICE(s);
> +
> +    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
> +}
> +
>   static void xhci_pci_reset(DeviceState *dev)
>   {
>       XHCIPciState *s = XHCI_PCI(dev);
> @@ -118,6 +126,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>       object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
>       s->xhci.intr_update = xhci_pci_intr_update;
>       s->xhci.intr_raise = xhci_pci_intr_raise;
> +    s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_supported;
>       if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
>           return;
>       }
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index d85adaca0dc..a2a878e4594 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -644,6 +644,11 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
>       dma_addr_t erdp;
>       unsigned int dp_idx;
>   
> +    if (xhci->numintrs == 1 ||
> +        (xhci->intr_mapping_supported && !xhci->intr_mapping_supported(xhci))) {
> +        v = 0; /* Per section 4.17.1 */
> +    }
> +
>       if (v >= xhci->numintrs) {
>           DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
>           return;
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index fe16d7ad055..6e901de6e6b 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -193,6 +193,11 @@ typedef struct XHCIState {
>       uint32_t max_pstreams_mask;
>       void (*intr_update)(XHCIState *s, int n, bool enable);
>       bool (*intr_raise)(XHCIState *s, int n, bool level);
> +    /*
> +     * Device supports Interrupter Mapping per section 4.17.1 of XHCI spec.
> +     * If NULL, assume true if numintrs > 1.
> +     */
> +    bool (*intr_mapping_supported)(XHCIState *s);
>       DeviceState *hostOpaque;
>   
>       /* Operational Registers */


