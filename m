Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFC9E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKX7K-0004m5-QG; Mon, 09 Dec 2024 01:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKX7I-0004lv-IW
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:19:36 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKX7E-0001sA-Ey
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:19:34 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fd45005a09so557656a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733725171; x=1734329971;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYOIcXWN7KO8l3rzxMVHIOJZ6RKh9Laq1f2FFIoCtto=;
 b=NtUEta7ppm11gU3jhkVdW7LR+JSDELWGZehGrellc87LSwU+7ntT0/fJ/+Sl0bRW9V
 SHE3sijNdknWN4qtpNc4oCmZemsTDWuBXpXWsi7ZYooaSa9iBNs4OqyZItD23FedB8bF
 O1Jncu3Eku8V8BCGunybvXIyCf9Zsoyi7q1XOvuKPqbTQR+05AVF3U0w4cG8w2Dyi1N+
 fMy+3XPN9nKRdYZ5cimdUBZ/cUom7lXcC1es/fufHAQoPk8f4P502NVKPrwVX6XwYoZu
 X+hFP/d2SosVIEjtICOE2PYyAAEQbDrMT760n4IugI7cFtoPCAM/TzbNIDQZDC6vbmnJ
 PFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733725171; x=1734329971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYOIcXWN7KO8l3rzxMVHIOJZ6RKh9Laq1f2FFIoCtto=;
 b=hCc5aTngWU5jJqD6tMyEQxxhQaEMIOBsDQgUt7zi3PrZsZHKHcG4R8/GapYH54CQjY
 hJYADx3bwzpAiSHp6x3/TtQKASA2t0OZFVKLzJBACnIygDHsGQqzcW+zQt5b3t9QvwMq
 9O4H5g68cCWCOFboazl4uBUndmZvdRhZn3LwX6ItYyiRJxZc55qenxiEmuBH0Xadf6fh
 QryhwxaR/YJ+Otnxk//ScvHHhEbHsqU+A6UaItyy+KfA/GHGCxdu229Df505705sD0sD
 h0YSZLb73KYRG1mvQov/IzMf+Xt+4kO+nU9yCg0ksQDu23mQvnTorGoqS4IkJf+skF5U
 wfzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeQ0+JKcMvZH+FOQoX2WBwxwgOcjTA/9r4DdlCt+l9AROt0uN2uPfirRMq7G+GYwTINH1NaMfvosAX@nongnu.org
X-Gm-Message-State: AOJu0YwLG6ZN1ojN7qphLsAplsAwko7US+YPHB+/ScmKpSaezhtqbb0Q
 pmFn+ecEGBbM7r1l22xKJgsTleGuMa8f1usxxf5KJzQMze8oZNm0NcHFjsP23os=
X-Gm-Gg: ASbGncs0LrgKiyQ5v1hrMcZ7yTvDVleiJ+jNmZGzxBqe+mGt5ua+284kLBQmCZQeccF
 ymN1xfM3hmulawqz5bjJrN8kBFK0XCigwsEvd1CAwTheE507MCcvo0g4nPozFjzSD0tHA+3C/T8
 DrL95J3HXxSnfnXCtN37CVa3eFHLGpFiDiek0Ex8A+bAl633u43MmyEBFD2UFbffHg/XrTRkArf
 eYH288cFpugsnGUwx4Vs2gCV36zIFC0ARw+9mctBw6pcVhI4nsLn+9HfQ==
X-Google-Smtp-Source: AGHT+IFtCZ8iLYL9VysIkLBhHAZ6+TPw2QeMv2c4OOV8fp/P+Egpq3oLMfRCFGrUyL3TguqCLxlyBw==
X-Received: by 2002:a17:90b:3891:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2ef69f0b13bmr16652764a91.10.1733725170663; 
 Sun, 08 Dec 2024 22:19:30 -0800 (PST)
Received: from [133.11.54.81] ([133.11.54.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef85961f22sm4007209a91.35.2024.12.08.22.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:19:30 -0800 (PST)
Message-ID: <a90fc398-2713-4b2b-a9e4-ab591e994ebd@daynix.com>
Date: Mon, 9 Dec 2024 15:19:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/usb/hcd-xhci-pci: Adds property for disabling
 mapping in IRQ mode
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-5-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241208191646.64857-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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

On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> This change addresses an edge case that trips up macOS guest drivers
> for PCI based XHCI controllers. The guest driver would attempt to
> schedule events to XHCI event rings 1 and 2 even when only one interrupt
> line is available; interrupts would therefore be dropped, and events
> only handled on timeout when using pin-based interrupts. Moreover,
> when MSI is available, the macOS guest drivers would only configure 1
> vector and leading to the same problem.
> 
> So, in addition to disabling interrupter mapping if numintrs is 1, a
> callback is added to xhci to check whether interrupter mapping should be
> enabled. The PCI XHCI device type now provides an implementation of
> this callback if the new "conditional-intr-mapping" property is enabled.
> (default: disabled) When enabled, interrupter mapping is only enabled
> when MSI-X is active, or when MSI is active with more than 1 vector.
> 
> This means that when using pin-based interrupts, or only 1 MSI vector,
> events are only submitted to interrupter 0 regardless of selected
> target. This allows the macOS guest drivers to work with the device in
> those configurations.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
> ---
>   hw/usb/hcd-xhci-pci.c | 23 +++++++++++++++++++++++
>   hw/usb/hcd-xhci-pci.h |  1 +
>   hw/usb/hcd-xhci.c     |  3 ++-
>   hw/usb/hcd-xhci.h     |  5 +++++
>   4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index 0278b0fbce2..8e293cd5951 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -81,6 +81,23 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
>       return false;
>   }
>   
> +static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)
> +{
> +    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
> +    PCIDevice *pci_dev = PCI_DEVICE(s);
> +
> +    /*
> +     * Implementation of the "conditional-intr-mapping" property, which only
> +     * enables interrupter mapping if there are actually multiple interrupt
> +     * vectors available. Forces all events onto interrupter/event ring 0
> +     * in pin-based IRQ mode or when only 1 MSI vector is allocated.
> +     * Provides compatibility with macOS guests on machine types where MSI-X is
> +     * not available.
> +     */
> +    return msix_enabled(pci_dev) ||
> +        (msi_enabled(pci_dev) && msi_nr_vectors_allocated(pci_dev) > 1);

This will make it behave incosistently when 
msi_nr_vectors_allocated(pci_dev) is not sufficient to accomodate all 
Interrupters;  If > 1, overflowed Interrupters will be ignored, but if 
<= 1, overflowed Interrupters will be redirected to Interrupter 0. 
Remove the condition unless it is truly unnecessary.

> +}
> +
>   static void xhci_pci_reset(DeviceState *dev)
>   {
>       XHCIPciState *s = XHCI_PCI(dev);
> @@ -118,6 +135,9 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
>       object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
>       s->xhci.intr_update = xhci_pci_intr_update;
>       s->xhci.intr_raise = xhci_pci_intr_raise;
> +    if (s->conditional_intr_mapping) {
> +        s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_conditional;
> +    }
>       if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
>           return;
>       }
> @@ -200,6 +220,9 @@ static void xhci_instance_init(Object *obj)
>   static Property xhci_pci_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
> +    /* When true, disable interrupter mapping for IRQ mode or only 1 vector */
> +    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
> +                     conditional_intr_mapping, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
> index 08f70ce97cc..5b61ae84555 100644
> --- a/hw/usb/hcd-xhci-pci.h
> +++ b/hw/usb/hcd-xhci-pci.h
> @@ -40,6 +40,7 @@ typedef struct XHCIPciState {
>       XHCIState xhci;
>       OnOffAuto msi;
>       OnOffAuto msix;
> +    bool conditional_intr_mapping;
>   } XHCIPciState;
>   
>   #endif
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 5fb140c2382..b607ddd1a93 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -644,7 +644,8 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
>       dma_addr_t erdp;
>       unsigned int dp_idx;
>   
> -    if (xhci->numintrs == 1) {
> +    if (xhci->numintrs == 1 ||
> +        (xhci->intr_mapping_supported && !xhci->intr_mapping_supported(xhci))) {
>           v = 0;
>       }
>   
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index fe16d7ad055..fdaa21ba7f6 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -193,6 +193,11 @@ typedef struct XHCIState {
>       uint32_t max_pstreams_mask;
>       void (*intr_update)(XHCIState *s, int n, bool enable);
>       bool (*intr_raise)(XHCIState *s, int n, bool level);
> +    /*
> +     * Callback for special-casing interrupter mapping support. NULL for most
> +     * implementations, for defaulting to enabled mapping unless numintrs == 1.
> +     */
> +    bool (*intr_mapping_supported)(XHCIState *s);
>       DeviceState *hostOpaque;
>   
>       /* Operational Registers */


