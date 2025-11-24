Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDD2CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNW1R-00020e-Iq; Mon, 24 Nov 2025 07:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNW1N-0001xo-Ux
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:50:22 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNW1M-0000ng-52
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:50:21 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-641e9422473so3256539d50.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763988618; x=1764593418; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ecz9LZiYhJiqGkPqT8oJbQQNHTPc6HJnI79d6w3JSM=;
 b=w4lwOD/0RYG39XzeTWbDUmT+6bUyLWLzuSmmaeoXOcMYxhtcwEHJG9tRVlz2rzlmJ8
 hVmVpAmwCJ1uk0fYzIocCxZDW+5VPdLTul3Mf8kbQ1joyF3DTFCWJm+rrxnNbrepaeQq
 C/l8SBdupXqB10Uac4Rl8ZCB0KYQL2RCwmYmPJDfFKIlsb9ByffX0ds0hHO9HFcAjMdZ
 pmor8b+BeGylsSC2hl/q3XQSfUxvUTiel//47li3asZaSPi55wcz8EOad6bjfVIZGkYf
 +7cuuAS5SucTpwhVOgmIXVtku4MGHAvA8y8Fgh7SUgJmYi5bYLDMoBd278Z8yfkUFWJt
 Xj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763988618; x=1764593418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ecz9LZiYhJiqGkPqT8oJbQQNHTPc6HJnI79d6w3JSM=;
 b=Hx285V43pQChn0GNeAwJ6n6FVCnBGKY9tVS+mqM9YJIx8c056pfpdDbVvHuLogsoat
 UNixxffXQ581VFG46Y713C7VBsU44SJCKOwEkpBuYX8Io6AWml4ul2ouv75/7YzNel/L
 2xOXPUjf8X/A5P158FkN3HMUnmoSJdB5cODMrYtbXiSxJLmvKvuD/BPqmi9ldSqFX7Fm
 RNvHlTkGraol4wWh9mUPfbHweuEiqeopiRDhXWDnNqhv3XE0qMbboZVVRiodZD/XL347
 0oFx3ucDI5FWalTpWeCDDIMH/EUugr9TB1lq/PYElbQlNEkdttnHbz6udHf6LpGvFz0z
 o7Vg==
X-Gm-Message-State: AOJu0YxtO0fHITniLVKURLXqhzWMEQ/5KcObjErAvTpO2tzuBlyLh5XA
 yNl1ZbNT04RUznFX4VAjQgPXzfLqnC2neXLoHeqydKUYVU+pfR3lqymZlEU1eEnBE8OFekKzBXt
 VTAd1a0cDDg3Cn+tyq/XGHA1fI5zmbbXz6QvrqQZnkw==
X-Gm-Gg: ASbGncsWG5KeV3GUDMPF1F/zxe/V7ccjOLDdmu2IS8jrZhpDvfgl29iHF8n0msZ1kAd
 uPn7Tp2i2b5CxfFJXAvEcIms56u1DQPTnuBEcMmrXRxJWpe5GL28/YZXnCFGb4Z+f69Vfd7RH4w
 FAgk/+kVKKdxJWf5hw7KozrB9VJmxTMp5A9XUHIaMHWqlw9RdZ9FlAwXCbUQpRyKFZ7gakzvPX+
 eio9NfXbUtWOaTjGO1vcQXyySwbsePlgZEwy3ULhV63r6YXr88gCaYQABAmdFUPefj7HC5R
X-Google-Smtp-Source: AGHT+IFo2/3xkw/ibwCpp7judtQQt0EX/Py+60aSkm1dy3zSI/xUSN3e1RqVNiQLMH8h7O+bLTMS7YToQT/rExXg1Hc=
X-Received: by 2002:a05:690c:6d0f:b0:789:2e24:b786 with SMTP id
 00721157ae682-78a8b551232mr176888317b3.52.1763988617856; Mon, 24 Nov 2025
 04:50:17 -0800 (PST)
MIME-Version: 1.0
References: <MW4PR11MB8291BDD718BE9BB5A160C839ACD4A@MW4PR11MB8291.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB8291BDD718BE9BB5A160C839ACD4A@MW4PR11MB8291.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 12:50:05 +0000
X-Gm-Features: AWmQ_bkreB4_iNsUajaak6mlGpYErwOUpSFbVb6dVustceytCoYGmycijbltxZA
Message-ID: <CAFEAcA9J=ETmdptn7cbzsx6hU_EiD+Pmvro+QW-T957vNMCSqw@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
To: "Yang, Liang1" <liang1.yang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, 
 "Kim, Dongwon" <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 20 Nov 2025 at 05:27, Yang, Liang1 <liang1.yang@intel.com> wrote:
>
> Dear QEMU maintainers,
>
>
>
> I would like to submit a patch for preventing the guest VM crash caused by the assertion failure in usb_host_ep_update() during USB hotplug/unplug on host passthrough.
>
>
>
> QEMU issue submitted:
>
> https://gitlab.com/qemu-project/qemu/-/issues/3189
>
>
>
> Please help to review below patch, thanks!

Hi; thanks for this patch. I don't really know our USB
subsystem, so this is more some surface-level comments
rather than an in-depth review.

(PS: for future patch submissions, it would be helpful
if you could send them as plain text, not HTML emails.)


> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 691bc881fb..3a08caafa5 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
>
> @@ -885,6 +885,15 @@ static void usb_host_ep_update(USBHostDevice *s)
>      trace_usb_host_parse_config(s->bus_num, s->addr,
>                                  conf->bConfigurationValue, true);
>
> +    /* Log and skip if configuration is NULL or has no interfaces */

This comment says what the code does, which is not very useful.
More helpful is to say *why* the code does something.

> +    if (!conf || conf->bNumInterfaces == 0) {

Why are we testing conf for NULL here? We already dereference
it in the line above, so this is too late to check if we need to.
We get conf by calling libusb_get_active_config_descriptor(),
and I don't think that will set conf to NULL if it succeeds,
so it looks to me like we don't need to test for NULL.

> +        warn_report("usb-host: ignoring invalid configuration "
> +            "for device %s (bus=%03d, addr=%03d)",
> +            udev->product_desc ? udev->product_desc : "unknown",
> +            s->bus_num, s->addr);
> +        return;

This is something we already get wrong in a lot of the
error-exit paths of this function, but we need to free
the conf descriptor with libusb_free_config_descriptor().
(If you wanted to include a patch to fix those existing
leaks that would be great.)

We already ignored a bNumInterfaces==0 config
(because the rest of the function would just do nothing), so
the only change here is to warn about it.

(1) Have you seen the bNumInterfaces==0 situation in real life?

(2) This is unrelated to the other half of the patch, so it
should be its own patch (i.e. one which just says "warn about
this kind of invalid device rather than silently ignoring it").

(3) All the other cases in this function of "the info about
the endpoint looked weird" we report via the tracepoint
trace_usb_host_parse_error(). I don't have a strong opinion
about warn_report vs a tracepoint here, but I do think we
should be consistent.

> +    }
> +
>      for (i = 0; i < conf->bNumInterfaces; i++) {
>          /*
>           * The udev->altsetting array indexes alternate settings
> @@ -896,7 +905,21 @@ static void usb_host_ep_update(USBHostDevice *s)
>          alt = udev->altsetting[intf->bInterfaceNumber];
>
>          if (alt != 0) {
> -            assert(alt < conf->interface[i].num_altsetting);
> +            if (alt >= conf->interface[i].num_altsetting) {
> +                /*
> +                 * Recommend fix: sometimes libusb reports a temporary

"Recommend fix" doesn't make sense here -- you can delete that bit.

> +                 * invalid altsetting index during fast hotplug/unplug.
> +                 * Instead of aborting, log a warning and skip the interface.
> +                 */
> +                warn_report("usb-host: ignoring invalid altsetting=%d (max=%d) "
> +                    "for interface=%d on %s (bus=%03d, addr=%03d)",
> +                    alt,
> +                    conf->interface[i].num_altsetting ? conf->interface[i].num_altsetting - 1 : -1,
> +                    i,
> +                    udev->product_desc ? udev->product_desc : "unknown",
> +                    s->bus_num, s->addr);
> +                continue;

For other errors with the intf info we "return", i.e.
skip the whole endpoint, rather than just continuing.
Should we do the same thing here ?
(Conceptually the same thing -- just "return" leaks
the config descriptor, as noted above.)

> +            }
>              intf = &conf->interface[i].altsetting[alt];
>          }

thanks
-- PMM

