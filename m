Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A7C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlj7D-0003pe-4W; Mon, 20 Jul 2026 04:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlj78-0003mt-5l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlj75-0000F4-MQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784535154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b4ZN4w49/scrUqvtulLtVv+8lCiA06QCX3kOQJrZMKg=;
 b=PmaLCHdbPoGteNRl1Er5NsovWTgiGSy1ntd6QkimsFrTmB6RVzCsXV8UqqwoXGXxEAF2Bn
 BYz8j7wzFfxdKG+vHUdlKVoULdlpauxkLMbeBViBhokEtYDVMvbxeWsu9jULgl20nAIPnA
 Vg2e/P4EAZ/rVytC2D0iQuCERb2Z61o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-t4VvCfYTPyWOhMBP8FyybQ-1; Mon, 20 Jul 2026 04:12:32 -0400
X-MC-Unique: t4VvCfYTPyWOhMBP8FyybQ-1
X-Mimecast-MFC-AGG-ID: t4VvCfYTPyWOhMBP8FyybQ_1784535151
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49554715277so17146665e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784535151; x=1785139951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:cc
 :from:content-language:references:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b4ZN4w49/scrUqvtulLtVv+8lCiA06QCX3kOQJrZMKg=;
 b=eSX6OgXHYDjni+UqdNRK/x6vEtk+YHBF4Q5+wGE49z541h4RRETBw8ihj/gkts+Ozy
 dFhIWEB9zedqNkGeVdFfT7MlM6cwdlmJNGA4nuAnUh44kA5qB9xYJOlw+ZTsmQaL3e/t
 gfcPveqfpsl97XuFHdO3t7DsNJpxzpM3X2uFajmwT1uwF6iWl9j7BXlqCsiWJ2AmVMxG
 YurPd8xoxueJj+3CwBrfalZqz34d4Pp3Biu9njeMjBxeB9o07F72/w/A7P3IZKNpDMaa
 QynydWtUjQBprC739NEbIITeTB5HSZ49PAxZN6O6Ie+c8PvwV310xnBXazrMNExoZ79H
 nQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535151; x=1785139951;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:cc
 :from:content-language:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4ZN4w49/scrUqvtulLtVv+8lCiA06QCX3kOQJrZMKg=;
 b=W0cUEGV1bu97cULCQvjfiKfOHkF0BZeZ6TWJm7yuoSLD41OfV9JQeP4U+CgiYb1Lin
 xZG6hz6Izzc+MDEqMltKnHJok/gLr+hfARi7meT3UdS/1YrwXxaY4Z+jSkuWZ4pnRuEJ
 QX23c5KMpFfWjkE6AuPBw8jy0DaXRwhtoNzYj5q8ys+uBif9pEQFtNuc9i8IpqUqJ11q
 AJxiz488Fv0ILb6OnFmwlBE/AQuxv9m1GSmhRKe705pwbSt52MN5Ebk4VEZ10I4aoVsA
 0W/iw1AxBMZuEdeB0Tb/mgs5dIZ1p3JQrtL1U5GIGH9zoOvkvmxPNvP3JmBx9moSOQXc
 7p1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXpv8pv6vSby2K3USDd5nbi9JYx/+q7XONtJP5pSCCKR4mKTLf3nTuf9zthC2onpHJkVD6Yp0l0IHN@nongnu.org
X-Gm-Message-State: AOJu0YzAVLCRoDqu9i6C4MoFVcLDo2+mhOze3SchEy73QENaz77flrO4
 oNz+CHF7gRei6+VHNBFwfUrjnFfccQ6fz1FQyGqhC4xNL9k05sVsQ9KajSsitxoekfw38lx8Ko9
 XagT44xetoUjOod4LM8FMkFtnxM37qiC05Uq2FKT0Q0Mq7svgq4M5+c+k
X-Gm-Gg: AfdE7cmgv9DPERY7YKx0R/G5fz4OS9PzVO5C3N4rwoSPZF/Sj/huTjknQo/d+5dQ9io
 hQcxPcf1ljFwWYRIo1iyEw9YxxUQrzIdj4+zUP2nxUY1Omu7wb4FBnUWIbJog59JFs+92et6Uy2
 3Hdq1kwcrx4wPGQAgbwWne02jtBcZxwjuOhGm1+s/OQougTaf93OjpRsLNW4WfcWFLNSIIBnMjm
 WTbBQuGbVEZOAg+sckncnbbDQf5tLFv/TqMpvGXMogcvNryLiJdVNfNDGUTMFs3QY5qCdVLV2OP
 EbMvl3g7karb77M6aIfXDcFRtYsf5blQU88WTfDA6K7gYLWllvcKqb4RCd/wpczbMUE0HdUgeQ=
 =
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id
 5b1f17b1804b1-4954c733e07mr125172705e9.23.1784535150670; 
 Mon, 20 Jul 2026 01:12:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id
 5b1f17b1804b1-4954c733e07mr125172295e9.23.1784535150140; 
 Mon, 20 Jul 2026 01:12:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955370d78csm143531045e9.12.2026.07.20.01.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:12:29 -0700 (PDT)
Message-ID: <bb76dd56-e97e-4d1c-aaf8-9eb55e6858b3@redhat.com>
Date: Mon, 20 Jul 2026 10:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>, qemu-devel@nongnu.org
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


  Hi Gerd,

since you originally wrote commit e058fa2dd599, could you maybe have a look 
at this patch?

  Thanks,
   Thomas


On 12/09/2025 13.14, Timo Teräs wrote:
> This is partial revert of commit e058fa2dd599.
> 
> The portion to immediately validate the device is kept, but this
> adds and enables again the autoscan functionality. This is needed
> to detect and relay USB device disconnect event to the guest.
> 
> Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
> Signed-off-by: Timo Teräs <timo.teras@iki.fi>
> ---
>   hw/usb/host-libusb.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index b74670ae25696b5252f0d034cb9b759e338a050f..f0baf6b2f2d12fbf8feb5b788b46d3187028df58 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -90,7 +90,6 @@ struct USBHostDevice {
>       uint32_t                         iso_urb_frames;
>       uint32_t                         options;
>       uint32_t                         loglevel;
> -    bool                             needs_autoscan;
>       bool                             allow_one_guest_reset;
>       bool                             allow_all_guest_resets;
>       bool                             suppress_remote_wake;
> @@ -1211,7 +1210,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>   #if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
>       if (s->hostdevice) {
>           int fd;
> -        s->needs_autoscan = false;
>           fd = qemu_open(s->hostdevice, O_RDWR, errp);
>           if (fd < 0) {
>               return;
> @@ -1227,7 +1225,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>           !s->match.vendor_id &&
>           !s->match.product_id &&
>           !s->match.port) {
> -        s->needs_autoscan = false;
>           ldev = usb_host_find_ref(s->match.bus_num,
>                                    s->match.addr);
>           if (!ldev) {
> @@ -1242,14 +1239,13 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>                          s->match.bus_num, s->match.addr);
>               return;
>           }
> -    } else {
> -        s->needs_autoscan = true;
> -        QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> -        usb_host_auto_check(NULL);
>       }
>   
>       s->exit.notify = usb_host_exit_notifier;
>       qemu_add_exit_notifier(&s->exit);
> +
> +    QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> +    usb_host_auto_check(NULL);
>   }
>   
>   static void usb_host_instance_init(Object *obj)
> @@ -1267,9 +1263,7 @@ static void usb_host_unrealize(USBDevice *udev)
>       USBHostDevice *s = USB_HOST_DEVICE(udev);
>   
>       qemu_remove_exit_notifier(&s->exit);
> -    if (s->needs_autoscan) {
> -        QTAILQ_REMOVE(&hostdevs, s, next);
> -    }
> +    QTAILQ_REMOVE(&hostdevs, s, next);
>       usb_host_close(s);
>   }
>   
> 
> ---
> base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
> change-id: 20250912-usbhost-disconnect-192ecaa8fc3e
> 
> Best regards,


