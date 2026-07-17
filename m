Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96ADC44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfH1-0006em-1o; Fri, 17 Jul 2026 05:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkfGz-0006dx-M1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:54:25 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkfGw-0004sV-PU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:54:25 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66826484b67so2426967d50.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784282061; cv=none;
 d=google.com; s=arc-20260327;
 b=JYNbU4hATWMBN1tMTRMbhx58d6QLtkQjqMA5ezqHQg8n7w56oM3jLgrCtr5ERVdpm8
 u5y+BvzrCby2TlVnJQ6bLGKEwqQmVJQCkFm8OzQiqhTBhv/ZnIr+ZpYP4XppbBI2oApq
 MkqF6mDRZP5KdJsNjJOYDvN6rM2P/FbyquSzmkH2iC4NrGu3s164FRYfBwFzHO5MUIT4
 Fp1xkQvn1QMNlD9USZOSySlhmn6SXmdJFVrYT9aQ2cEJd7CSN5Wk3+I+tjLMUEPAq3fX
 F+RI8/jJYYV4MxCScVbAFjtcRHu6YwEj909Yk4GFK0OBEsT6ZgDAJgNpcX4KdJRAIfdg
 zq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kMuWD0hpErkcQclw4wc9oMq1059iNWYfAJlG9edA6/k=;
 fh=akbhKwgRgOSUCG1JBVCqiMpsRQ3OL8Xvqe1Ei6bUgDs=;
 b=ZYHDnB8zMkgd1MYLXm5kNoCkiPQaKk+c/O9kmK3OJx8VHnBZIyZoNVajuA9/sVQFIT
 p6zmH004VwOUBHFozu+E/8SXWVls+KG8G9miVFzHKlaDV5r2DtX4bUka90wdUrMPo13U
 tcOdIH6syztLrtYZJXAoaxQQ0mW7AbfiN5yuQs28MPmwqF1WgXm8osvC88fPlZmYS9Ie
 zFnTE/WdK5luQAZdXvbKFXtLt0TuDV4WTDmgoiwzETgxZTGnp2PugPugCAQtgA2SVyZm
 m7yKkt8xGwpjM9XeVsN7G7Fn6OG6Z2LCHOZTmPkk0EL2X1dMHypAykRfnXpEP8FDoZt2
 /wjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784282061; x=1784886861; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kMuWD0hpErkcQclw4wc9oMq1059iNWYfAJlG9edA6/k=;
 b=bHopL9H45DW+6G1xjx/11ZnVmRlgELu71aiqqGAFRy9GURbZgutUsdFrqeFxhb/MPX
 cR6kBXQMVqCx9VSI9VhZ1HR9t6Fn1mj6AUWSVp+W0gdLxYlbWHn13m5Ai0GHOHFg1oTh
 SZm5q2lsZYfrDNYOgC31DSuWWHHIq/jAL/p9SL9bqnhMO6iGLHtctNBvlLRM79CShlQX
 7fLoqb6xwyjgkcIrzdWUOZvDdPXkPO8Cy9vfDxBSq2rCEbchGZzz8VUJ5wJJKwkQEt8R
 ml+XGv1NJFwkKGLtjxuf6uGIwmWpEmOyhT1nLC238hfAP8HOyTKPPXg+LPqgZHqM8V5l
 GrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282061; x=1784886861;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kMuWD0hpErkcQclw4wc9oMq1059iNWYfAJlG9edA6/k=;
 b=iDQm7evJoLJ+eNB0SFpGnIhWtLGF4o6e2OfZ5lGKeRg6VXD1oxVPSnzdsa6bIDQkHy
 ba+eCxDj+wfBALEgQIHJ+vSw4Q4DXdSa1VlOmnZ/PyICQI1B15gjxRw2hBI6tOa9H82F
 mCV6Lh41uSW0K4Spp2hHgeOWYw4UAgjDnlqbt62P7d2NFeeluMSrB2CAj5mjGZ3JdMRQ
 j2zyEYhelrzkqWfc52XywXOyqeabLAIrJVMZ0+PS3P/SWmeL45bN10IQYdh1pQ2BGaE0
 /dUuPyAEuHlHJwOfeiuD/dh0EretHP8FbBMnTtpe26vm9tSOrD94E6OvPIZMk/M73Gby
 f7rg==
X-Gm-Message-State: AOJu0YzZyS1JgMOv+shRDcD/k4jpynKs9Mzppx2yiZaU9gBYp5FsnBv8
 v3GI8A1j/+iI2bOM1cFnWeNFhWTlu3J5IGVJPQYgHpQGlz+Ovrg1CVV7/yEGUwdfTEhodZRduOo
 rC1M90xQeGM4bdNgHoXhU9A1VB5YuvoLD/7LZGusWog==
X-Gm-Gg: AfdE7ckPr6vpBECBlIgc5TMp8b3d1H5Y6d+gIk/oaVIyyvSTJTRmyakfSoz1xc6ctxR
 nqE8BY88PJCO4ZZ3rrxxJj5lwiJxfQWH/0QssbuTOJMTT+5ogRPTrDt4b1gik1DEAjdAkHIBAnV
 DhSpK7liiHoOoApBpIp8t4xQrDvsH5vhAidf1YYQQuGIaYkzQJrWgjWNnozDGLdfPX222KRf8Ck
 /tGDohp4O2RBy0kVwLJIomEL6QXbQc5kGwB2PmHRRTg6DxFxw22q8OB99JEEFRMCenAq4Nk43mV
 cMyokBWXEWs+15Y7SFCKNx42le9sjQhzfAvQ2TetrluhqxQBmcmtP1BB
X-Received: by 2002:a53:cac2:0:b0:667:e04a:8a42 with SMTP id
 956f58d0204a3-6683bbe3608mr347422d50.46.1784282061131; Fri, 17 Jul 2026
 02:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260715203357.424556-1-thuth@redhat.com>
In-Reply-To: <20260715203357.424556-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 10:54:09 +0100
X-Gm-Features: AUfX_mwOvYyWnOXFJt3hoL0HCE_9akmQ34m-yUoa9lrGaRH_aWFYsbye1aMN1YI
Message-ID: <CAFEAcA_kCY6hZ4Px6E82oLsVKoiZxGbuwCAr1mqrFrZ1FL3wEA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-xhci: Fix guest-triggerable assert() in
 xhci_find_stream()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 15 Jul 2026 at 21:34, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The assert() statement in xhci_find_stream() can be triggered by
> the guest (see bug tickets #273, #3895 and #3988 on gitlab.com).
> Turn it into a qemu_log_mask() instead to fix this problem.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/273
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index c7e050e38fd..ae8add4227e 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1009,7 +1009,12 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
>      dma_addr_t base;
>      uint32_t ctx[2], sct;
>
> -    assert(streamid != 0);
> +    if (!streamid) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "xhci: stream ID is zero\n");
> +        *cc_error = CC_INVALID_STREAM_ID_ERROR;
> +        return NULL;
> +    }
> +

This matches the error code that we should use for this case
of zero stream ID when checking the stream IDs in USB packets,
as per the XHCI spec 4.12.2.1 "Stream Array Bounds Checking",
which seems to be what the other error codes in the function
follow. (I'm looking at
https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
as the spec here.)

However, we don't actually seem to use this function for that
purpose. We call it in three places:
 - xhci_set_ep_dequeue(), which is the handler for the
   "Set TR Dequeue Pointer Command"
 - xhci_stall_ep, which ignores the error code
 - xhci_kick_epctx, which also ignores the error code

For the "Set TR Dequeue Pointer" case, the spec states that
the right error code for all cases of "bogus stream ID" is
"TRB Error", including "max_pstreams > 0 and stream ID == 0
(see 4.12.2.1 and 4.6.10.)

So:
(1) as far as this patch goes,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(2) xhci_set_ep_dequeue() ought to be doing

        sctx = xhci_find_stream(epctx, streamid, &err);
        if (sctx == NULL) {
            return CC_TRB_ERROR;
        }
rather than "return err;"

(3) xhci_set_ep_dequeue() should reject (CC_TRB_ERROR) a
non-zero streamid in its "nr_pstreams == 0" case, rather than
ignoring the streamid value

(4) Somewhere presumably we ought to check the stream ID
in a USB packet and halt the endpoint if it's out of range,
i.e. somewhere should be calling xhci_find_stream() and not
ignoring the error code...

thanks
-- PMM

