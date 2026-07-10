Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D920DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDGX-0001Tc-0j; Fri, 10 Jul 2026 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDGV-0001TJ-MN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:35:47 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDGS-0005Vb-RO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:35:47 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664db84f074so1442374d50.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697744; cv=none;
 d=google.com; s=arc-20260327;
 b=efhnI7GnvMjfb5uhEkKmt+IhaAVlsNAPZ9f6f73XK5gFQvRA7LjtemZBPB6uXTX7br
 Ns89EcSGCm3eXNrQk4LjzbBMxRU5Idnv61xNkxYVvjVysiJG/xGmPxYnIB4nAxHf+8+a
 cYK8AFMwa5/UiI80BUNaDTA522FCbCewOepmTtI3jcG5GJTZ91KXphdGi2nSY1J/vHv0
 xm/BbOIDIryfpjdifm0B4OFQ09SwkGxyLxvQdLhR1Kh63+ioFRTv8y7RuB1vMrDgt1uV
 +b87KxCglYzXYkVPrG2IxIU42PQWcIW6sITNzsD34iL/0womUTCxUAuOkX+YTH1WxpH+
 aD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=brpid9hA+oeeOPIkA8YZ56T2Mv4J1vcmvdwBvJQdRE4=;
 fh=u291Lbw2b9rxg9HnhWHMXpxLq0jujIsiYuVyT0n7GJs=;
 b=h8obPojt0ldrLkbR/7V2qEdCUVM8QhzOEeD7KovwJtbmxUOQoIYmIJcMI0OrC1uj1q
 4VjDvBKXwooVZMFROH4TvnQsDOaFHoQqdkhm/CJfdJ4QP8b6pbqiPP8o0BEUGOZjvzlG
 YGeg6Xw1L644t/dYpBioWWFh9lNOMsGCSA2z7u3cbZPqwtFFaLtzm7eILOZbX+RhkiTC
 b1h7W3Y0rHkrix5w55zaTOuf61kEvb6QsiA1/z9BAeM4iRVqSRmyIDE/r0E4tPTNCNgs
 PNKaEAAIsA4e/ptoKhFZ3Pfruu5jank/wGOwrSjLD6pXsReXGAR9TIQUpV4vmUPhoKMm
 /aEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783697744; x=1784302544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=brpid9hA+oeeOPIkA8YZ56T2Mv4J1vcmvdwBvJQdRE4=;
 b=SxyVF32Ed2q5L2bzWCr3Ms3zQCRlwrxuwlTTRcICdYQjOAqCJefMOYkSkMcLdrXnui
 uMlDPLa5Tv9J8PFzXoSRyvUe3UubunrUwJYzfUzYNDjKIv+WoccmzgQ5aWrloqEhqyxb
 YZYyefaan2RU70d71clnXui3CS0A8kX7V/WkLtGEUt5VtIAnKjumWFHCd3dls9QN11mZ
 tW2A8JWHm1vlkBkTVl9+9VHEVEVQ63WHrgMmy4A8xU4mrrP1eLSAHn6L9RQ7twVJRyon
 NFmp+Tn+h6c5C5df4pchaxe0/QkmoaWOjdvw9+a4ZvRm0e68fKxvKKMAJFXlixmrtqRI
 978Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697744; x=1784302544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brpid9hA+oeeOPIkA8YZ56T2Mv4J1vcmvdwBvJQdRE4=;
 b=hpOA0snaaCnzNt+nKvLweIj7yu0hRQaPGuSCnof7Ehf2RXI3OBwXWngSwMWBBB0Hww
 NbmKhfTIvXU+zVyGgTkkLfpCpwG55SEFJzGEVPwgwrbKRDIQpCd/gtkq95yF1bGsnja3
 whdFxuGzLoYcPBhNsd9Rco/AMm3fZ1pAwPbyo+apF26QvkMCGtLz/+GUS2QOTJD9Wt2H
 L/ZNppQx0chhCcsZPOzNfRtOAEk2Nt07App8YZz4/ii8H1BdLoYIdoFKzYr/h56t2Uym
 DJqfDqiIekvmcsFgOrzZ/adbHwf82Gz7CPOVPCmn0VjwOqjxp/ZbZ4Qj4F/ot2r5LieG
 fuTA==
X-Gm-Message-State: AOJu0Yw/MytMbZixmvIAZ9FOlu2VKctDOWYa48JXb3RbjAeueSP1Gajo
 6wDo+bIADStx7cd/Ufhdc7B3IiyZ4ZgOhbBn1AV40fr0/7dWrn4mLtpuyoeQTBnwd18rZpZUjSg
 VDmnDOLEBzCYlRyz9MqSJ6L9utPPwCgeXIfLx8kT+6g==
X-Gm-Gg: AfdE7cnooWqjCRNBYanCb9AfRrTFDu/iPtnCK6xv5Mbm0niZBNJUoslj5DoETpxZDvQ
 7PGqcnrBD+rAtPkaN1cVKFRAxktl1uletAtZOCcwykuIZx3ipwtIWKHGUYypd/nt2wDR0YgT7vG
 i6XkHkhpIqQO52wwr9yxP6adeK7GlYEDVY8FeNCoAlCyKJ1N+/jaArW0+PnkJrhTr+OpkrElRrL
 DPpjtvs0tCnsF4Y9XO/oOhZcpc06DyuaUpsByXoXN9NkwpTXe0L7c6gqIEnjwpl1Bo6I9wjrGxD
 9akgGahC60pPfSgncFf9HojnQ++DVf5PWFDX/JJ40V0wrszWYewL24f3
X-Received: by 2002:a05:690e:134a:b0:667:a1d6:9c35 with SMTP id
 956f58d0204a3-667a1d6aa47mr7906100d50.33.1783697743431; Fri, 10 Jul 2026
 08:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260710144327.600572-1-thuth@redhat.com>
In-Reply-To: <20260710144327.600572-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 16:35:32 +0100
X-Gm-Features: AUfX_mw7fHLpi5yTv0bRGBD6i2tHm-t-Q-wg57oubaJrBAoHFLR0lCCKDrOX-Zs
Message-ID: <CAFEAcA_aoctX5Cj9dUHSrt_MyzcSfN+bxHxzo+kip88Z-V0YKg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-xhci: Turn guest-triggerable abort() into
 qemu_log_mask()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 10 Jul 2026 at 15:44, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The FIXME macros in xhci_alloc_device_streams() can be triggered
> by a (malicious) guest. Since the macro also contains an abort()
> statement, this terminates QEMU. Turn the FIXME statements into
> a qemu_log_mask() instead to avoid that a guest can shoot itself
> this way.
>
> Reported-by: Feifan Qian <bea1e@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 2cdab3ba0e4..002f801348f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState=
 *xhci, unsigned int slotid,
>           * together and make an usb_device_alloc_streams call per group.
>           */
>          if (epctxs[i]->nr_pstreams !=3D req_nr_streams) {
> -            FIXME("guest streams config not identical for all eps");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "guest streams config not identical for all ep=
s\n");
>              return CC_RESOURCE_ERROR;
>          }
>          if (eps[i]->max_streams !=3D dev_max_streams) {
> -            FIXME("device streams config not identical for all eps");
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "device streams config not identical for all e=
ps\n");
>              return CC_RESOURCE_ERROR;

I get the impression from the comment that these cases are not
guest errors, but unimplemented QEMU support for a corner case
of the spec, so should be LOG_UNIMP. I had a quick look through
the XHCI spec, and it seems to define the streams handling
purely as a per-endpoint thing, making it valid for a device
to have multiple endpoints with different max streams settings.
It's just that it doesn't happen in practice so we haven't
implemented the "group identical endpoints and call
usb_device_alloc_streams for each group" solution the comment
sketches out.

Incidentally, there is just one remaining use of the FIXME macro
in this file: the "unhandled USB_RET_*" default case in
xhci_try_complete_packet(). I think we could (as a separate patch)
replace that with g_assert_not_reached(), because the function
handles all the USB_RET_* values except for USB_RET_ADD_TO_QUEUE and
USB_RET_REMOVE_FROM_QUEUE, which are both internal return
values for when an async packet needs to be queued or dequeued,
and which (I believe) shouldn't still be the status by the time we
get to this function.

There's also one raw printf that should be a LOG_UNIMP:
        fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet=
");

thanks
-- PMM

