Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC5C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgO2-0008C2-Ry; Fri, 17 Jul 2026 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkgO1-0008BK-9P
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:05:45 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkgNz-0005cz-H9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:05:45 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81ef11a0972so5446727b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784286342; cv=none;
 d=google.com; s=arc-20260327;
 b=IgZ9K+8MA6LfEAXwgkvlmj56KLLtsj+7OKbw5Pac1XvAqVz0L3YrkDQeWSj8JF7awm
 FLHRDrP7sA8AHUWRPQtUmvF76dxE0x3KSUB4xxg2z1PHo4WLr8cOMMzlWvp5B9Ic1QSQ
 adma6/gQEx2hf2z/NMDpy4YwIse2yJyU/wQToEOuCSg3OJyx+DOW2P8nCHWxgPZ84t+7
 1sdBVa6F83dIIxUyLsZXnXUInzhRadbAlehmbJTAhNmEiDbmTM96gYV4L789QrJVwQRf
 YQlxg1BOgRAbibGApYZZF2PNyD12fVGcdrJ5tFLR+I4xXTKDIL83huDablsE0KrRepdF
 JK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ekVtR/loJxDrA3aerqu3GtkExdV3IdtPovuInh/R/9s=;
 fh=akbhKwgRgOSUCG1JBVCqiMpsRQ3OL8Xvqe1Ei6bUgDs=;
 b=UQek5zSpcgS7UYsaY3BIPrkD07tfNDwzzQcag++3kwf0Y5B780KXG7qrrQB8VDZ75f
 yfFkJTvdFmyf+EoFgp09BQ0Bh4Xj9oBMuhxrQRGEs1JXSY1UrS8RedLqweraa1PNfAYR
 JnG8ibq1jwiMIOFcDXxpKTAaM8pLhLzU2N9lA6/fOnL2XsI7i/fqxu+iQUE6CoNpiFjY
 wYuYWRI7OBs6oqswMBZBJe1ff7fjBcFqpcUXI7vEOBPPhb2HQOFgBkrdlMAip1LAiXDa
 0VH51nPf70LSJ0nCImvHAP9tnB0gnqLPgSKXUwf5DGavxrqC7Ne5Q5s6HvKjzZXq6l3d
 z8bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784286342; x=1784891142; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ekVtR/loJxDrA3aerqu3GtkExdV3IdtPovuInh/R/9s=;
 b=DtgS5lYZz9ps1kprAaDVG2mqrLGLxLY0zW+LD97zEzobIoeOo8VYYbvXUBoDfaW4+Z
 Tl2NJdZskKYkEEw1a5C1QDT8D3nQRckKtNH+D9P1gWSpgzekdue7+k9/7IPhQUXQLTXV
 C9rGkW2iRCmBlf86EpbRcSL7qiSKYYrWHR8uOW47sJiMDAyNZ02T/y7ds/ksKWgcBbx3
 OHyGq/iJs+x7MrA8BzHoQnu6AO8yQWLR1slnMKavxLAqTBru9ln1LxU6CIGH1glWulP4
 5TqQoXSSpT8Oe3IJ5X8iVsGB/Q4w9bY3R8U8zg5x4ihPFEdpfQy+L+0YzG58BpDyRRRz
 Mqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784286342; x=1784891142;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ekVtR/loJxDrA3aerqu3GtkExdV3IdtPovuInh/R/9s=;
 b=AZ3WWoNyBKqTinYgXhzMGhtOjaFpMNDyvhJPvNWE90P7V6j1IiP4yv3q3JQpp3r5by
 rUauNATXPqiZCxSvSnDWu8vSaw9oGSVAhsIwknUW7Nrda6QOtGGo0uEOVCCWE44CkyOI
 n4VBesr6dbuyyRjDdzJ+ytEnwNZ0s8wgZy714/mIy8n3KlECxNH6kwEDtzx+ppL2ADkY
 5zgnW82boDkalkA9sYsJkMH+QMKBey+dw14Fadn7+hS64+0+YgwOgnkdUWyW4UdpXWcE
 n6x3fHj4isOBaXaye5SQHyMze4yenZ8L2XcKidpbLL0HceDgMDE3D/qCj5o+jyGjepOq
 boKA==
X-Gm-Message-State: AOJu0YwMtjlO111IPeteYG8sty6H0ZJ/+lfF1/n1NNHfN2cw9YWJU5mW
 z9CUDuboA4eiM+vdWR09gkR0ahreLDoh4Co/iAJAGX+wj749G7tipSKnSZJyEtmHbV3RGYRUig6
 /JMhcymW3KKBAK+KyZ6vaI7KRsdSYmtSDAtdphb4k0g==
X-Gm-Gg: AfdE7ckty4AEfJZDWI12hIROFcqwz5a3/s3BGpZRh9O8nyceDDfD8FfKsi1iJNnIrU0
 5zm9BrEoxq/PgcL+TkJnD3LJr5ULWY7JE+AfYzTk+L1DyUsP4Y4pM/LoCVNTlagQ+o+OujbLWoi
 2f8uD9ot8YFmHpqcNSPJuHCSkYKYl2b5ImlVJOekaZelYlHqU/iQFt6aWmEW+wb8bI6d7EOqKy+
 LU2vwJeR3/y5Me5uGBL7cGRTVnBT3HIHWS356lCNiFK203THrgWFRXz8Sbor5jE0XTZB9B0vu/x
 9MfKfZMRdvNe4EJHmXpZPX1HGfJ55saCKrUcqkvNZRH24MFk5K3NR7xZ
X-Received: by 2002:a05:690c:e3ec:b0:81e:c972:e8c3 with SMTP id
 00721157ae682-81ef252281bmr5824547b3.29.1784286341730; Fri, 17 Jul 2026
 04:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260716193321.256391-1-thuth@redhat.com>
In-Reply-To: <20260716193321.256391-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 12:05:29 +0100
X-Gm-Features: AUfX_mzVAvkMgtpzTvt3oL5b8INESf04TJZp_VHQrGdBZF8IGE9zE_US5SFKiEA
Message-ID: <CAFEAcA_s8pZmJu9GW5Kqkg=7UZjKcMOGCrQNz=n_z8vY45doaA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 16 Jul 2026 at 20:33, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The stream ID is under control of the guest, so we must not use
> it for indexing into the status3[] array without checking it for
> being in range.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/dev-uas.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index 8576dfec96f..7df58cdeee7 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -383,8 +383,15 @@ static void usb_uas_send_status_bh(void *opaque)
>
>  static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
>  {
> -    USBPacket *p = uas_using_streams(uas) ?
> -        uas->status3[st->stream] : uas->status2;
> +    USBPacket *p = NULL;
> +
> +    if (!uas_using_streams(uas)) {
> +        p = uas->status2;
> +    } else if (st->stream <= UAS_MAX_STREAMS) {
> +        p = uas->status3[st->stream];
> +    } else {
> +        warn_report_once(TYPE_USB_UAS ": bad stream ID 0x%x", st->stream);
> +    }
>
>      st->length += length;
>      QTAILQ_INSERT_TAIL(&uas->results, st, next);

Doesn't this just postpone the problem? This function puts the
UASStatus struct (with the out-of-range stream value) oto the
uas->results queue. Later on we will end up in the
usb_uas_send_status_bh function, which picks USBStatus structs
off the queue and uses the same "assume st->stream is in bounds"
logic for finding a USBPacket for them.

Also, once we put this UASStatus into the results queue we
will never take it off again -- the code for handling reads
on the status pipe will only remove and process UASStatus
entries where st->stream matches the stream ID used for
the read on the status pipe (which must be in-bounds, we
check that).

The copy of the USB attached storage spec I found is not very
clear about error handling. But I think there is no way for us
to report back the "invalid stream ID" case. So I think:

(1) in usb_uas_command() we should check the tag for being
in bounds first, before any other error check; if it is not
then LOG_GUEST_ERROR and return (do not call
usb_uas_queue_fake_sense(); have comment about why not)

(2) is usb_uas_queue_status() and usb_uas_send_status_bh(),
assert() that st->stream is in bounds before using it

thanks
-- PMM

