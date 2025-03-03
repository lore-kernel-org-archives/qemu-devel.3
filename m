Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C740C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3Y4-0005S6-IK; Mon, 03 Mar 2025 06:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3Y1-0005PR-4y
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:01:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3Xz-0003Ey-6Y
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:01:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so10473325e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740999677; x=1741604477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVsU7WNyQa11iM/L+2a4eDXNaOCPZHn6aLu4cKzTPd0=;
 b=wLxMccbQVZwtrkh0tA4f+Ae3nM8eh4AAIgoMaBNRPgBzx2uobz/g3Oq7vFAYg9JXHI
 apbfSVZ9ohmneQmhVJL4MnpBWd3hzcA1cyelCabZ5jYQ+NaHkTU54JZb28MtPjsLTn3a
 0Svj5OTBpCEIi/oDRZ5fE5q7FUtekZyMXRrE3F3eOZdhlT3z+eU04VnQKwCAASgi90fT
 EjrcVaXjXo+9xLdHK2bYwUdRxRQbVRMviDVMgz/qsjqizX3QDb8g//icc5mI9/S/ly2e
 +4w+nzwkU01MHlIIbnlad35CZyxZ/fZ3wQ4bDuYY99v1i2lZHXMDOw+v7BUgB9WcYGi2
 93pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740999677; x=1741604477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVsU7WNyQa11iM/L+2a4eDXNaOCPZHn6aLu4cKzTPd0=;
 b=AdZbtKMzE6FQm2AHzDDAhoNEw4u3ZIJEmGyCf/J4ai6/R6j+DiugAp80rXX5amYI/9
 HK7lUsMZ35raohS3lFCv9nlY4rPeECdR1WUHvCQczIWaOhkEzt+xumdlygCH/mh5gY3D
 5fs6y7UPGDfJYL+RLafGS5os0cW3VxwPNicDH78vixD7yPQ63hDMo3zUlhCtJblHYxL0
 C0KT8mGfgjXFQzypI2VrFlGHGMx/AXTYf7DU4Zf3FuZaVeiDkCllEJNZ+zrjltw+kCpr
 VUSu1LIlu4c/l/xZwP4YC5eXs57qNjMt6HfMv7kYPYVjWEmmCA8LObjHLAybnUsRHhCK
 0WFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQyfA/YpQSO1XfQaMpDk5ChZnO0Suz/pxQ9hKeK99u4z8gNJyGfjyMLee34GZG+DIAzamQ29D97VL@nongnu.org
X-Gm-Message-State: AOJu0YyD1sM7HzMR7zRrSuleA3Rtjtunntl8n3WCmGaEAOB9GrhwV+/2
 PlxCT7Zrt2S88r4Hn/IgbOMCb/nnS1ohCSQ45xQlFA5PG7TCjCFM57ZAmzjY/LA=
X-Gm-Gg: ASbGnctcxTwGYSnExeR+b5VbSvfGIp9XLFPA4zGrk9YWOsz7jCPEXARAcbGmy46bvI/
 tuHrDP6Z09s/smgeayCYj3hChj++WhT5xU+IOhrqci0pWNHwaxAE3NinusDq3dm7vXj4VLfF7AN
 bXdwEbj/Jb06whkSzAwcWDJ2I3Oe5LXIeglvNoFYhEwLrQMc35SDWQZcmTwpeksXYTQUrIDDwPT
 N6rwfwXso9LHjZZni15K2qG8p5Bf1y6xlC5GnHimi7mKIYaSMGo3nkMub0qUbW5UAcM6XmkG1xK
 K89Fst2HulX/a8sfFsHqBmOO3njGBKtoTEkdjX1Q7g1Z4G1SOEMRilZ8+N1g7ZxAoebrXlhO1zv
 1FqpBzh62BCVU
X-Google-Smtp-Source: AGHT+IHKGZumc0iOCB0VRx2z0uf+PW8tODyHwQlyDU3JkAY+8u4degysQagJDGDUglTtliOIHg6MMQ==
X-Received: by 2002:a05:600c:44d6:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-43bc0fb007dmr26750525e9.7.1740999676648; 
 Mon, 03 Mar 2025 03:01:16 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc864c379sm7295965e9.14.2025.03.03.03.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:01:15 -0800 (PST)
Message-ID: <b20eae18-b058-4c46-9ba7-cabf0eb2821c@linaro.org>
Date: Mon, 3 Mar 2025 12:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Allow manually adding SCSI device
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
References: <20250303-usb-v1-1-70f700a181fd@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303-usb-v1-1-70f700a181fd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/3/25 11:28, Akihiko Odaki wrote:
> usb-storage automatically adds a SCSI device, but it limits
> configurability of the added SCSI device and causes usability
> problems as observed in:
> https://gitlab.com/libvirt/libvirt/-/issues/368
> 
> Allow manually adding SCSI device when the drive option is not
> specified.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/usb/dev-storage-classic.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
> index 56ef39da2e634d1639a07ac4636cdaa000989f5f..33e5a7cfc8bdf3f92b18014e885771aee6d32f5e 100644
> --- a/hw/usb/dev-storage-classic.c
> +++ b/hw/usb/dev-storage-classic.c
> @@ -33,10 +33,9 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
>       BlockBackend *blk = s->conf.blk;
>       SCSIDevice *scsi_dev;
>   
> -    if (!blk) {
> -        error_setg(errp, "drive property not set");
> -        return;
> -    }
> +    usb_desc_create_serial(dev);
> +    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
> +                 &usb_msd_scsi_info_storage);
>   
>       /*
>        * Hack alert: this pretends to be a block device, but it's really
> @@ -48,23 +47,23 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
>        *
>        * The hack is probably a bad idea.
>        */
> -    blk_ref(blk);
> -    blk_detach_dev(blk, DEVICE(s));
> -    s->conf.blk = NULL;
> +    if (blk) {
> +        blk_ref(blk);
> +        blk_detach_dev(blk, DEVICE(s));
> +        s->conf.blk = NULL;
> +
> +        scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
> +                                             &s->conf, dev->serial, errp);
> +        blk_unref(blk);
> +        if (!scsi_dev) {
> +            return;
> +        }
> +        s->scsi_dev = scsi_dev;
> +    }
>   
> -    usb_desc_create_serial(dev);
>       usb_desc_init(dev);
>       dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
> -    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
> -                 &usb_msd_scsi_info_storage);
> -    scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
> -                                         &s->conf, dev->serial, errp);
> -    blk_unref(blk);
> -    if (!scsi_dev) {
> -        return;
> -    }
>       usb_msd_handle_reset(dev);
> -    s->scsi_dev = scsi_dev;
>   }

LGTM but I'd rather feedback from block team (Cc'ed).

Regards,

Phil.

