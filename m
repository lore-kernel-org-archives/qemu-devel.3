Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F374CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 11:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNUnJ-0002Zz-Ir; Mon, 24 Nov 2025 06:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNUmx-0002Sg-Bd
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:31:31 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNUmv-00011T-Nv
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:31:23 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-787df0d729dso39999537b3.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 03:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763983880; x=1764588680; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/+fq3Urp/TAekKLUl/fWaZbY+dzZHekvFsjZmcLDyo=;
 b=HIhgLKiRpyPNHCk3+plP/Q9ORsTqDRfOyzM2qImj0UWgn5ESsA+j/SPgCu+npAgMoa
 5PSOfxKiAQdoX+NJxWzrzIKPq01qjKBIqAugQKA/6HMumSIhE8rRcPC2y6OOkaKqnOdx
 qJ3zKr+MzHnNI8NtrRKky6OR5islJMRuBe2BsOA7vEzqbOh+dpOTVRY+zXFSySJbAT95
 6mmE2JQRcfYTUpLHhKtVJuHVMOVEdRPcGqTSMlqUZViW8y5KfXyxqNEkmmXkETIyMXEs
 31pHzmUZw9Fugeag2sRRB9wvq5J9Spnm/MD4bbE3YRAFS/hj5T03QYJA5/CBBKMsWzVZ
 LPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763983880; x=1764588680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/+fq3Urp/TAekKLUl/fWaZbY+dzZHekvFsjZmcLDyo=;
 b=HxJ7HhzGEZHxdY5wHNxZwBc5uvA3sjUpviCEGXcrVKgAwJjfS0gFs8tt2ZV7j4ap4f
 ZuUYUHLAy+l6+Qgu3ONQk0c6v0H3gs/XLTvjTXJelgmaPbqWkqNAXyu0l6yjh1s6gCmo
 ZwyqZ+aR3vQJPi/I/3FPVVlNQopC+XhYUFO+OfdLDiy/+Upxbvyk5ipcQQQC+Ifr0+PO
 Euqea//Rljpl0NQ53RRZCmpXrbqyVpeMoQagRkwG/bpZsV2GjzxXeB9+56yyjXlph9tL
 wlyi/ujCj4eVPLymVSJTkjyHUYIs4CEttD9zvbSxJsCqMjKtdm6SMy2Ifu6B9Le6qNYD
 XOBQ==
X-Gm-Message-State: AOJu0YwYpPEAN62IsBljcuCPJ5yK6IVfi2KZoTPB/OPoxbz1HCG93BbF
 yrhGLZ1l2ICnDrfBkZUkKZnifLAVut5ZGwBgrsIUuAtj1YzdqAnoA29tpyh2I6hIFsIuUdu/kCX
 BIVxT9clspVCO3Sfd2CgqesFMdbhDUKqh1SEypG/rtA==
X-Gm-Gg: ASbGncsGWAvYOUFvJngq9HkckNRzpX5cyIkY2lc1BN5zS8c1KINpDlWN6wTH5YMzonF
 wwfsRMaGqf/834ycz/WY1dq7c5H5kbrgPBGiVroZRv3uH6AMmmA4LTQOkNIQ7Qhw2ZAbObchs8t
 GNh4JBQg5YrXFYVuUtkV4AlRYqAzHX3BKALFW6DtrDzNAWG16njsHuvgq30M3POAFWyBRIdKL4i
 PvxgduzvbpqzYAjo8lf9j4rax1RS/CHvXYt4wQ3DkaVMST3vliMmCICjb9Gi4iWQBxVzT2N
X-Google-Smtp-Source: AGHT+IFcBUI1eYnh/fxhv83a2ZnxPfOy6aD0aFd6wNmYEqaO63NziLgTF7e8AD64+MQJ2AKonmp7eqY0WPg7GHJhAWM=
X-Received: by 2002:a05:690c:744a:b0:786:45ce:9b8b with SMTP id
 00721157ae682-78a8b478cb6mr97847447b3.11.1763983880413; Mon, 24 Nov 2025
 03:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20251104094151.2218252-1-zoudongjie@huawei.com>
In-Reply-To: <20251104094151.2218252-1-zoudongjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 11:31:08 +0000
X-Gm-Features: AWmQ_bkoCfNb1ta42SwLas9koXTP-R27Qel7BopwDppJsRRtQH4baPkVfWWig4g
Message-ID: <CAFEAcA9z8RkBq9=6y+E73mzVDKfkXTR59grCBTPfozC6PYwPOQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/host-libusb: cancel the processing of inflight
 packets correctly
To: zoudongjie <zoudongjie@huawei.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 alex.chen@huawei.com, luolongmin@huawei.com, mujinsheng@huawei.com, 
 chenjianfei3@huawei.com, eric.fangyi@huawei.com, renxuming@huawei.com, 
 suxiaodong1@huawei.com, wangjian161@huawei.com, liuxiangdong5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 4 Nov 2025 at 09:42, zoudongjie <zoudongjie@huawei.com> wrote:
>
> The EHCI controller in QEMU seems to cause a UAF (Use-After-Free) issue when
> handling packets from abnormal USB devices. Specifically, when the USB device's
> firmware behaves abnormally and causes some initialization requests to block
> and time out, passing that USB device through to QEMU's EHCI controller appears
> to make the do-while loop in ehci_advance_state repeatedly submit multiple
> requests to handle the same packet (this do-while loop is quite complex;
> I confirmed the issue by adding logs in usb_host_cancel_packet).

Hi; thanks for this patch. I'm not a USB expert so my comments
below are just some surface level questions.  Like you, I wonder
if the correct fix ought instead to be to not have multiple in-flight
requests for the same packet, but I don't know our USB subsystem
at all well enough to answer that.

> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index b74670ae25..b5aab12aee 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -406,18 +406,6 @@ static void usb_host_req_free(USBHostRequest *r)
>      g_free(r);
>  }
>
> -static USBHostRequest *usb_host_req_find(USBHostDevice *s, USBPacket *p)
> -{
> -    USBHostRequest *r;
> -
> -    QTAILQ_FOREACH(r, &s->requests, next) {
> -        if (r->p == p) {
> -            return r;
> -        }
> -    }
> -    return NULL;
> -}
> -
>  static void LIBUSB_CALL usb_host_req_complete_ctrl(struct libusb_transfer *xfer)
>  {
>      USBHostRequest *r = xfer->user_data;
> @@ -1276,7 +1264,7 @@ static void usb_host_unrealize(USBDevice *udev)
>  static void usb_host_cancel_packet(USBDevice *udev, USBPacket *p)
>  {
>      USBHostDevice *s = USB_HOST_DEVICE(udev);
> -    USBHostRequest *r;
> +    USBHostRequest *r, *next_entry;
>
>      if (p->combined) {
>          usb_combined_packet_cancel(udev, p);
> @@ -1285,10 +1273,17 @@ static void usb_host_cancel_packet(USBDevice *udev, USBPacket *p)
>
>      trace_usb_host_req_canceled(s->bus_num, s->addr, p);
>
> -    r = usb_host_req_find(s, p);
> -    if (r && r->p) {
> -        r->p = NULL; /* mark as dead */
> -        libusb_cancel_transfer(r->xfer);
> +    QTAILQ_FOREACH_SAFE(r, &s->requests, next, next_entry) {
> +        if (r->p == p) {
> +            if (unlikely(r && r->fake_in_flight)) {

What is this fake_in_flight field ? r is a USBHostRequest
but the definition of this struct doesn't seem to have that
field in it.

> +                usb_host_req_free(r);
> +                continue;
> +            }
> +            if (r && r->p) {

We're inside the "if (r->p == p)" check here, so we
know that r and r->p are the same. And the
QTAILQ_FOREACH_SAFE() macro that iterates 'r' through
the request list will only give us non-NULL pointers;
it terminates when it hits the NULL. So I don't think
we need to test this, it's always true.

> +                r->p = NULL; /* mark as dead */
> +                libusb_cancel_transfer(r->xfer);
> +            }
> +        }
>      }
>  }

thanks
-- PMM

