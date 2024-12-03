Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BDE6C606
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 05:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tILPB-00074S-Hb; Tue, 03 Dec 2024 00:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tILP9-00074G-8h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:24:59 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tILP6-000819-Hc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:24:59 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29e6399b009so1152995fac.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 21:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733203495; x=1733808295;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=us8+SCSpokDznNAV2ixF9OGkLxAjf5vXM5BoDQ9nvMI=;
 b=oG+WnNnzlWHuGT8leU7IQH6J+LreLQD73U9ytXy9ybKr81LweAsoQeZoAT9e9WlXcE
 8IYcyCcHY2MRoBJBPMR+yWOq4zFOI+ACNbVmSxBN8VZSay49UR1P/YLWSaLlFxCyipjO
 20zsrJb5zMroE/mtJMuqKogTwtOSqJkiL2tmH+vb2Judo9Yd3Jts291OB5JOHg+Xmhmq
 IHg9agQtJkqAvjozj8Nim21T4WIhl+UIykWCY7OJ8p/Lu/hk8mK1yY6xhPP0l5mph9q5
 SfYPlI+AGvS2qwomJ1Bd8s3nvlT8fJxXRxI9E4OVJUam58PA3GtnCwmKEPIVAe2s0QzI
 aoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733203495; x=1733808295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=us8+SCSpokDznNAV2ixF9OGkLxAjf5vXM5BoDQ9nvMI=;
 b=LxIr1dhq7AQIFQmZf1XdHVkKxbNirLDA8rgQlSCUeQXdyWniQNx+Vmp4DCU6WqyoH5
 WgSJC6sYFkxzv7/yZuc/cVTrovhatcyVLbTcdHZLSNeP2Vwp/HFI1vBfryOKPkjRl4yC
 qa7HJhFf2hTk3IStvOYsmdblA+AYfzKYwXShEK1gKy54UlSpcGfmoxVfWajkEr6Gu1jh
 6OPTLpiJZAjD1kV4jk5UtViksxt2EJft2Ak5JbECWPBIj2h7Ry3SfomlddW7e/2Ixpgm
 Qry4+JgGwkyMnMV5Nt2V6GgoVabUkOeYxiFRELD4OKQZ0CziTlLBm/2vCm6HPAeFnQCA
 R1uw==
X-Gm-Message-State: AOJu0YwlVdkDWBYLw2+JOeRnV5Fb5O+joK3Ver+DdPVqoVO2u++bGS6P
 yt90fcHjpdcgfLncZv1fjDysXC8Tq4q+O8DFgGpB0zpT/tIHpoBMSwuD1EJqEAI=
X-Gm-Gg: ASbGnctMkINiYZ6kXddCLJRIWGt52DOG/xhBfAsWMDC66vqBjjdDfOg1LatdfT1o8V9
 T3vlbeGyQQ6wCrP1XrkjI1FLLELtgfeYMOtMVhEOwkQxNQJxH0eFThcvWbh408PfEx2CY8pFVIH
 qCJZAYL+arrqTLbrcbJXAyB0BxZhgJLA3FUhKt1ODbmPy1IF7dPc8RoX6dqN0Tl7W0wb5sPnp9Q
 ydxxfm6bKiad8BhiiZghrLA618mYu5guWxa75HPly5cjACrm3E2WtQuBELsPZo=
X-Google-Smtp-Source: AGHT+IHLKSSMm0tzrrrpRgOnlasxoKGJ+WJZMflUU3YODtRtnIeAV+5zmGvkKysFEDgDSeGQFxq8iQ==
X-Received: by 2002:a05:6871:80c:b0:297:23a8:1e0 with SMTP id
 586e51a60fabf-29e88234e61mr1336864fac.0.1733203494927; 
 Mon, 02 Dec 2024 21:24:54 -0800 (PST)
Received: from [157.82.207.154] ([157.82.207.154])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d84a7sm2716890a34.49.2024.12.02.21.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 21:24:54 -0800 (PST)
Message-ID: <9fd4fbd0-6957-4125-bbf1-bddf28bbb4e6@daynix.com>
Date: Tue, 3 Dec 2024 14:24:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC-for-10.0] hw/usb/hcd-xhci-pci: Use event ring 0 if
 interrupter mapping unsupported
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com
References: <20241201160316.96121-1-phil@philjordan.eu>
 <a3812fbe-f5b7-442c-8140-54e87da6a78c@daynix.com>
 <CAAibmn1c45kjKkDZAmWmwwZZJ2hv88UgadBffid81=wXg91HYw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1c45kjKkDZAmWmwwZZJ2hv88UgadBffid81=wXg91HYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x34.google.com
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

On 2024/12/02 18:49, Phil Dennis-Jordan wrote:
> 
> 
> On Mon, 2 Dec 2024 at 06:39, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/12/02 1:03, Phil Dennis-Jordan wrote:
>      > This change addresses an edge case that trips up macOS guest drivers
>      > for PCI based XHCI controllers.
>      >
>      > The XHCI specification, section 4.17.1 specifies that "If Interrupter
>      > Mapping is not supported, the Interrupter Target field shall be
>      > ignored by the xHC and all Events targeted at Interrupter 0."
>      >
>      > The PCI XHCI controller supports MSI(-X) and maxintrs is therefore
>      > reasonably set to 16. The specification does not address whether
>      > interrupter mapping should be considered "supported" if the guest
>      > driver does not enable MSI(-X) via the PCI configuration area,
>     possibly
>      > because the PCI host bus does not support it.
> 
>     This section says "an xHC implementation may support Interrupter
>     Mapping," and section 3 says "Host Controller (xHC). The host
>     controller
>     is the specific hardware implementation of the host controller
>     architecture." So the entity that "supports" interrupt mapping is the
>     hardware and does not include the guest driver.
> 
> 
> I wasn't talking about the driver in this context - I'm questioning 
> whether there is any reasonable interpretation where hardware should be 
> considered to support interrupter mapping when it is configured to use 
> pin-based interrupts.

The section says:

 > If the Number of Interrupters (MaxIntrs) field is greater than 1, then
 > Interrupter Mapping shall be supported.

MaxIntrs > 1 in our case so Interrupter Mapping is supported. It is 
irrelevant whether MSI(-X) is enabled.

> 
>      >
>      > QEMU's XHCI device has so far not specially addressed this case, and
>      > no interrupt is generated for events delivered to event rings 1 and
>      > above. The macOS guest driver does not get along with this
>      > interpretation, so many events are not delivered to the guest OS when
>      > MSI(-X) is off.
>      >
>      > This patch changes the xhci_event() function such that event ring 0
>      > is always used when numintrs is 1 (as per spec section 4.17.1) or
>      > if neither MSI nor MSI-X are enabled. The latter is checked by adding
>      > a new, optional intr_mapping_supported function pointer field
>     supplied
>      > by the concrete XHCI controller implementation. The PCI
>     implementation's
>      > supplied function calls msix_enabled and msi_enabled accordingly.
> 
>     I think the current behavior to drop interrupts is correct and
>     targeting
>     Interrupter 0 is a violation of the specification.
> 
>     As noted earlier, this xHC implementation supports Interrupter Mapping,
>     so it must target Interrupters 1 to MaxInstrs-1 instead of always
>     targeting Interrupter 0.
> 
>     At the beginning of section 4.7, the specification also says "an
>     Interrupter shall assert an interrupt if it is enabled and its
>     associated Event Ring contains Event TRBs that require an interrupt". 
> 
> 
> Unfortunately, this is an ambiguous wording - "it" could refer to either 
> the interrupt or the interrupter, and I suspect it is talking about the 
> IE flag. The IE flag is called "Interrupt Enable," not "InterruptER 
> Enable." (If it's off, you can still use the Event Ring in polling mode 
> - the interruptER includes the event ring, the flag only applies to 
> interrupt delivery.) On the other hand, there is an "InterruptER 
> Enable" (INTE) flag in the USBCMD register - but there's only one, which 
> covers all the interrupters available.

This statement contains a phrase "its associated Event Ring contains 
Event TRBs that require an interrupt". A preceding statement says:
 > Each Interrupter consists of an Interrupter Management Register, an
 > Interrupter Moderation Register and an Event Ring.

So Event Rings are associated with interrupters and "its" should mean 
"the Interrupter's". It is also strange to say "require an interrupt" if 
"its" refers to an interrupt; it should just say "require it".

It is very awkward if "it" and "its" in one statement refer to different 
things so I think it's safe to assume "it" refers to an Interrupter here.

This section is to describe Interrupters after all. Considering the 
context, a natural interpretation would be to assume "it" or "its" refer 
to an Interrupter.

> 
> On the other hand, in 4.2 it says "Enable the Interrupter by writing a 
> '1' to the Interrupt Enable (IE) field…".
> 
> So the terminology is not consistent.
 > >     It
>     also says "interrupters 1 to MaxIntrs-1 shall be disabled" "when the
>     PCI
>     Pin Interrupt is activated". So disabled Interrupters must drop
>     interrupts.
> 
> 
> What does disabling the Interrupter (again, not the interrupt) mean? The 
> Event Ring is part of the Interrupter. So if the interrupter is 
> disabled, is the ring disabled? If the ring is disabled, should the 
> hardware really be dispatching events to it?

The associated Event Ring may still contain Event TRBs, but they will 
not assert interrupts:
 > An Interrupter shall assert an interrupt if it is enabled and its
 > associated Event Ring contains Event TRBs that require an
 > interrupt.

> 
>     While the proposed behavior violates the specification, it is still
>     crucial to run macOS guests. A possible solution is to add a
>     property to
>     enable this behavior not conforming to the specification, and requires
>     users to opt-in it when running macOS.
> 
> 
> It's certainly a possibility - but it adds user-facing complexity for no 
> discernible gain. Users of non-macOS guests won't care which way the 
> flag is set because it doesn't affect them, and the default setting 
> won't work for macOS guest users, meaning they need to research what's 
> going on if they're hit by the problem. OK, we can enable it by default 
> for the vmapple machine type, and most users of x86-64 macOS guests will 
> be using the Q35 machine type, where MSI-X is functional. I'm just not 
> convinced the higher complexity(*) is worth a user setting that no user 
> will ever change.
> 
> (* And it WILL be higher complexity, because you definitely need to 
> insert the condition in xhci_event(). This isn't fixable with just a 
> tweak in xhci_pci_intr_raise, say - the HCI needs to behave as if 
> interrupter mapping was unsupported, or it won't work.)

That's unfortunate but the higher complexity seems inevitable.

The proposed behavior is not a natural interpretation of the 
specification and requires an alternative interpretation very favorable 
for macOS. If I am to choose either of adopting an unnatural behavior 
for all or complicating one platform, I'll choose the latter.

> 
>      >
>      > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu
>     <mailto:phil@philjordan.eu>>
>      > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
>     <https://gitlab.com/qemu-project/qemu/-/issues/2705>
>      > ---
>      > I've been chasing this problem for a while, and I've finally figured
>      > out the cause, and I think an acceptable solution. I've explained the
>      > problem and quoted the relevant sections of the XHCI spec in more
>      > detail in the linked GitLab issue:
>      >
>      > https://gitlab.com/qemu-project/qemu/-/issues/2705 <https://
>     gitlab.com/qemu-project/qemu/-/issues/2705>
>      >
>      > The fix provided is I think the simplest one in terms of lines of
>     code,
>      > but it's also a little ugly, as we're constantly checking
>     msix_enabled
>      > and msi_enabled via a callback function. Granted, we're already doing
>      > that in xhci_pci_intr_raise and xhci_pci_intr_update, but this adds
>      > a bunch more calls.
> 
>     The fact that macOS rejects xHC with numintrs < 4 implies macOS still
>     expects multiple Interrupters are enabled, but all Interrupters assert
>     the INTx# pin. Implementation of such a behavior will be contained in
>     xhci_pci_intr_raise() so we can save an indirection call of
>     intr_mapping_supported() as a bonus.
> 
> 
> It's not as simple as redirecting xhci_pci_intr_raise for n != 0 to 
> still trigger the pin-based interrupt when MSI(-X) is disabled with 
> macOS guests. For one, pin-based interrupts are level-triggered, so you 
> have to cheat with the IMAN_IP state. Even then though, the macOS guest 
> will only process event rings for which it received an interrupt, which 
> makes some sense, as there's no point having multiple rings if you're 
> going to check all of them when you receive an interrupt for only one of 
> them.
> 
>     Regards,
>     Akihiko Odaki
> 
>      >
>      > The main alternative I can see is to "push" the state of whether
>      > interrupter mapping is supported: provide a custom config_write
>      > implementation for the PCI device, and every time the configuration
>      > area is updated, evaluate whether or not this means that MSI or MSI-X
>      > are enabled and update a corresponding flag inside XHCIState. We
>     could
>      > even use this opportunity to switch out different .intr_raise and
>      > .intr_update functions depending on which interrupt delivery
>     mechanism
>      > is active in the PCI device.
>      >
>      >
>      >   hw/usb/hcd-xhci-pci.c | 9 +++++++++
>      >   hw/usb/hcd-xhci.c     | 5 +++++
>      >   hw/usb/hcd-xhci.h     | 5 +++++
>      >   3 files changed, 19 insertions(+)
>      >
>      > diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
>      > index a039f5778a6..21802211cf7 100644
>      > --- a/hw/usb/hcd-xhci-pci.c
>      > +++ b/hw/usb/hcd-xhci-pci.c
>      > @@ -81,6 +81,14 @@ static bool xhci_pci_intr_raise(XHCIState
>     *xhci, int n, bool level)
>      >       return false;
>      >   }
>      >
>      > +static bool xhci_pci_intr_mapping_supported(XHCIState *xhci)
>      > +{
>      > +    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
>      > +    PCIDevice *pci_dev = PCI_DEVICE(s);
>      > +
>      > +    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
>      > +}
>      > +
>      >   static void xhci_pci_reset(DeviceState *dev)
>      >   {
>      >       XHCIPciState *s = XHCI_PCI(dev);
>      > @@ -118,6 +126,7 @@ static void usb_xhci_pci_realize(struct
>     PCIDevice *dev, Error **errp)
>      >       object_property_set_link(OBJECT(&s->xhci), "host",
>     OBJECT(s), NULL);
>      >       s->xhci.intr_update = xhci_pci_intr_update;
>      >       s->xhci.intr_raise = xhci_pci_intr_raise;
>      > +    s->xhci.intr_mapping_supported =
>     xhci_pci_intr_mapping_supported;
>      >       if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
>      >           return;
>      >       }
>      > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>      > index d85adaca0dc..a2a878e4594 100644
>      > --- a/hw/usb/hcd-xhci.c
>      > +++ b/hw/usb/hcd-xhci.c
>      > @@ -644,6 +644,11 @@ static void xhci_event(XHCIState *xhci,
>     XHCIEvent *event, int v)
>      >       dma_addr_t erdp;
>      >       unsigned int dp_idx;
>      >
>      > +    if (xhci->numintrs == 1 ||
>      > +        (xhci->intr_mapping_supported && !xhci-
>      >intr_mapping_supported(xhci))) {
>      > +        v = 0; /* Per section 4.17.1 */
>      > +    }
>      > +
>      >       if (v >= xhci->numintrs) {
>      >           DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci-
>      >numintrs);
>      >           return;
>      > diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
>      > index fe16d7ad055..6e901de6e6b 100644
>      > --- a/hw/usb/hcd-xhci.h
>      > +++ b/hw/usb/hcd-xhci.h
>      > @@ -193,6 +193,11 @@ typedef struct XHCIState {
>      >       uint32_t max_pstreams_mask;
>      >       void (*intr_update)(XHCIState *s, int n, bool enable);
>      >       bool (*intr_raise)(XHCIState *s, int n, bool level);
>      > +    /*
>      > +     * Device supports Interrupter Mapping per section 4.17.1 of
>     XHCI spec.
>      > +     * If NULL, assume true if numintrs > 1.
>      > +     */
>      > +    bool (*intr_mapping_supported)(XHCIState *s);
>      >       DeviceState *hostOpaque;
>      >
>      >       /* Operational Registers */
> 


