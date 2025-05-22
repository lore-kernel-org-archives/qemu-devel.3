Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9D7C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7aw-0001hP-FI; Thu, 22 May 2025 11:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uI7au-0001h2-Vv
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:12:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uI7as-0006iV-L8
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:12:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-b200047a6a5so7708782a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747926744; x=1748531544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TsZfcqtkOh0DXqJjBYRf1sBTSOgoykSHK7tOb9m7798=;
 b=jSecHar8OPl0011opRqI2e8qOxAmE4T8zgQ6wFCxzNe06T8bZAM3tS0GGehO49VSS+
 J+0Dzb5pz44feKyvoVLfZRE2QfWHWB2WlZQZqjAWSRJqnns6mmdpkwcAuDjbcq1mSbHv
 YLTLOhIgP+ChBp1UOaHgE05eAq7uYY/zImD67kFtfJkce/woftudggYgHPIj876ZOptW
 1fPUkbFNKTF9w1MJHwdPHzBAVC6edL9vK/egWEf3qsnFmajFJ39UnQ8XQOu37RwGFtG3
 PApEGeTq25p/u6nX1cEVRKZsvr1nULP0rM1ogk/Zu790QEpoAGmYEn2VVFIHrZOrOmYD
 ABGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747926744; x=1748531544;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsZfcqtkOh0DXqJjBYRf1sBTSOgoykSHK7tOb9m7798=;
 b=VFIXrCiSyC6kbgJnFPq3jrFckgNp7koDiz6Y7gRldHWIC6D0xMuwgsYYk10sNC2n8Z
 3FMZXbyU3gERETiGZqZZnF1SAaFdzCNBjmLQlbMhhiMo4rNU6rxYiIPXijHYhb7UCV+Z
 SBEuVpysoMtmZ6jw+bb65gIgyGtaGssfehpO3ccZDmJbto0UU8wz89/2hgqdS0VqcTu1
 U0EqjkGRB9n7wX0W4Wm5UyQwxR+yMuLIknzXpzL76zjcQyGOTx7ukPdfUNRigXQAMw4R
 RzLxqiOBBM6Y52NzUMGIyRira24FLzKd09e51YzcGKcXB8Q//r0jNGH9Gnh1qKFFeJ5m
 F/+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ7nnkGPVDE6dsFWLvqO1aACt7R6X1lCCcy0lxl0kNhNmg9FpSdQEoAYThIzlDrKPndvS7TiOfZkjW@nongnu.org
X-Gm-Message-State: AOJu0YxfHiLlBDYNHnEeOu2YZrgYlgb8xSrDjymN1Po1tqtdcwBlZbfO
 r0KCi0yvoS/6tJZYEWW5SS3vv1Wt86hVcAGSuBwy1ptx/xDagV6Oeag=
X-Gm-Gg: ASbGncvh2p6WNkRKc6VkoIRfIZeSreN/6Ni25FyoSBHPquY7Fm4rU6g7nPljRKTMt9g
 pSDZvfZfz9YGZjxvzKjnHyq/RfecIrEv1YSSyDBfA2wrL4ycGXE4f3VWsURr4eqkkFznLjLcyot
 W3DGbAVjAs9thybeRq7Kza3+rJtUkggz2pNfIYarZnjRCPi8n+2ym9THy0FPGI8+2vhQuJpxh1t
 w2WSJdzJFz1UNnTaoPzcexg0WuWtECq/sPMP3LsA0uOUz5/9SiENqSfpsKiw5oGrPhOCnSrb7+Q
 FbtWPyXEKDNYTVciw6lDr5MK7OeGCgQJ78BIOP2WSKp2bvbvbvVos72NEA==
X-Google-Smtp-Source: AGHT+IFHxcRcXiy/JayS0pm5xS8U9Dph9J/aqRhyevtK91TeiEY5sIfk1mpKmLmaTqPWNrGgY6Eegg==
X-Received: by 2002:a17:902:c209:b0:231:bc7e:a54f with SMTP id
 d9443c01a7336-231bc7ea667mr304046595ad.26.1747926744267; 
 Thu, 22 May 2025 08:12:24 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23211e75f58sm83989985ad.252.2025.05.22.08.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 08:12:23 -0700 (PDT)
Message-ID: <9243ac0c-54c2-4a37-bb0f-bf5bf45dc86b@gmail.com>
Date: Thu, 22 May 2025 23:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
To: "edmund.raile" <edmund.raile@proton.me>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
References: <20250521154036.28219-1-tomitamoeko@gmail.com>
 <ZL9xNjLqKmv1NRP9uwZF60EnTu29ZbIqGXg_349mZsZugjfmDqzcMAdUf0DJAPVeHddBnKqlqnZzFN_v7mIriWj-o5niX56bbCCXDodzDWs=@proton.me>
Content-Language: en-US
Cc: "edmund.raile@protonmail.com" <edmund.raile@protonmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 xsFNBGeBS+MBEACn/yFPrdM6on+MxXrQMYXDCDzOrIPa60zJg0DvQFW/LDTDuOvduTOIVgKS
 Zxwtj2PGjIfJLir94olButVmhqrmwBaSGDlmONQwbM99OJt0jur70XQJkvBZyyd82ZuTMOO+
 aadlfwFmpL9tnMBHxPG2msIAd1DtB4UVKk1vU0VyCfUU5urCbKjpd8qKDK0WzqZSq+bfbUnm
 0zJtKu3IRgJjHYIOicm7nuD981kx/2mqYYc4rhTMoRuXV7j38MOc2EBwajzn0AIkQPKDNoh/
 39YqWnUvkrAtJBTOiPTTFzKnTi/U8RUUlv2xkVHsDbQn5Hk3hw+dgZ+KEnZoN9mpM742Bdxl
 NZV+ux1/xTBjhc4JMsn+fnp/XMQEu7heGXJBpTGpCzFfF3Lww/wv0IZo6LqoL/oNKlvqtCZv
 R0Vke7YxI/LWPJg26vA+lpjDfZsnuOKR6e7VKH7d2Ys4SM7wdWH7Skmvzzi32OaWXgSUT7ts
 N5n0s7hhsDQNNQDAegENpFdBH188zZaNvxORAicmQMjp+LIWhxQVFmEFehOPAmnq6xD/fbWV
 wPg9iJ0TEvrX6jsT5f4YYH2yFBsOgXCoykUwN6P52lesF2p5naeUYhN7Qe+9m25HZ+XUzoWE
 wgqcBoJVdOksFcqL6zsP6Y5WcvefuHQwtfF164+zLcOW4BCQjQARAQABzSRUb21pdGEgTW9l
 a28gPHRvbWl0YW1vZWtvQGdtYWlsLmNvbT7CwY4EEwEKADgWIQS8KzUD0amz9vuEE3wF51cy
 H0ouBgUCZ4FL4wIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRAF51cyH0ouBo2JD/9p
 QkjDLiWAcpqhW/agYsxPTQRea8CxaZGSIESa+T9EmfY59Wn30mUkZMEL0rJD1LRJnC7r2Poq
 Z7WnvhiUv25lpXBTugD3mBUV9egKgTKUMen9fpdj9cBiP1OiHchJke0F5cM6NeJxgWSifBVV
 cKVnsCyeCMQq2i340g8IsJJP9tSPeo8tF4ijkO4KCn2aXdY3NruGuKH7JrNca/QjhMlav1ES
 2j18TngTxIqPD95O5U/BeDxWA1FonDOANode39naK1qwYBu5v+T8U8FE/0peYU+HEe1OmIfH
 DVN6BKgRrfz6Or446PWS0tfY2H3WsUD+Z9oOQllbIa6h/FXULPtr7yY3UwV5pbZkHmfeaZ+m
 pmROun9WIPXUsva+E6HrTBvUBmcytZDc1v5wYb48xB9p4OgBJtC2i1BJP5jS3Pnl2SoLQAgR
 7nlbBqQdugAKlfAB8jKOWFbZ+eZssMXYIKCDOvPc5PwFrfDUj2MVzgzaxgtKYMWPATTj6L3j
 nfT9elW6RKSSF+dhycQTt9dd368BmpnHnM0MQvzt/rhH3uzYcHceOkBUjaqJzlj4EBJhY6P/
 QSXwnwkeuXdZLZ27Rluigy9O9pIdJBCEWPQ3hvaZnP+BKkObqD+1wOXNFdcMvFVsfRqEpcbI
 3GSXMsP3O0IQ803Lx3c8T8/tUN3mHTx/dM7BTQRngUvjARAAqO+N3GXDWSOTAbylaiDDQ6jM
 Vl1XucU29l9ODuXpIaovqlfxvZbl4snGB2rdFP+rmO0LuwpxuORWUuI3lh3whKjQv19YaNbF
 U0DblgBvPYQsXtv0gYoQr54RcLaQ52Q1Yz07Cy+M3tA0FK1wLKPHFcfsY1zfF9leJZlzw4hO
 SSsKk4RvidXK4NxgkWw3VYfFm+eDK5dikosm+AT8L11/PPVAlqqz5m7CqAWyP2DV92sMe9Jb
 i+O4suIQsF5vvWWQaUCzA+CshkbMiF0xWVeJaftM1X01z+r2GA+dwcrrac1qrsqN1nw8aDa2
 XJ2IbIGk1lazW7yqm/KEXLx0bIO3opyack81+iVUU2Yb2+td9n6zj1YScl2Aa1OzKJsnEnfJ
 Pw4GE98wv8hYMEfKCHNIY1ajVDXiCBw3sqtTR2lpXeOVwHDhF4FyLIiy/DrTOW58mCZG+Nz9
 /fBM9p1WSJhUWcYzFaBq43imaCrvBg14edaFWBK+xkK+trdjyZBgMWtmStWebS+Ifevyu9oH
 jugTlm81F/eWZAAcTM5fshhUe2JSvOerEM5jHUla5YNHzMuv7j7/xSNJSpeNOe3Q4H2oaejl
 idHucoLMe8OhIDrNqTX3s+DbKonvexavLLBp/9PKrmPWtxTV7qcvUoLNK3I+ctTXZez10/O7
 z6fnfk3mLb0AEQEAAcLBdgQYAQoAIBYhBLwrNQPRqbP2+4QTfAXnVzIfSi4GBQJngUvjAhsM
 AAoJEAXnVzIfSi4GoiEP+wUV4uOcaMOTdINCOWAUX3wNQf7wvdLUBdWHM/7wm8wynBf9ZvPR
 YOTEsI2sHy2WK44eexnws4xLeR41X9jFbKYtA1zDGQJumpillnnMKVaNYWt/G9hj6QmKsFDw
 hT/A/QWwMH9fjH8nBxgZjZCqIraRUrhNChqm2Lm3nkoRpnSZgMfcllMtXt4ld+Eh30Mir8hD
 80dmaHJJB64xOrJzIKQVvTnWD3qlFXtL+OEgqT4HPIFOEfbCka8WbMmyIiDDI+3xx68NKTpV
 733RG/I5+dhr+DDBEIyd+i/IilykqA/zHOeMTujwlIUMeor+QsoACG3LydkR/oKpOqexl4N6
 XcjwZ6dEoeJOLBzq6vikF9qVYUmY0hfaCh77ly4VHtKL6xGCb8PYawgiyTHO5on0h4RzDJKP
 P8jzYYK2wSWe7EJgk5EW9xs1irmawzven9NZDEaJrBecWrN4c+V7MpxpIOrCg2mRp1WnKh8a
 YtmMnmYQqDpGW/+M14/jLkNPxW62q0DEoeLLaRI/eiljk7Ld0rpCSK1r4zLYF4Ad4D2/TU5c
 eR8oCkBhmfKaLFohZAxwwjHLm/iLXKH3Y3E8AKCEO9bDtjM2/O8cu6mRWCrU97NWiqlxtvqa
 1knqGaLNT5NXjwaR3PHbrp/Wg0UxLznD0LzQeT5XHrROJ1+OH0ntUwQd
In-Reply-To: <ZL9xNjLqKmv1NRP9uwZF60EnTu29ZbIqGXg_349mZsZugjfmDqzcMAdUf0DJAPVeHddBnKqlqnZzFN_v7mIriWj-o5niX56bbCCXDodzDWs=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 5/22/25 15:31, edmund.raile wrote:
> Hi Moeko,
> 
>> I did some further debugging, and found it was caused by a mistake in
>> error handling. In vfio_pci_igd_opregion_detect(), `errp` is set when
>> OpRegion is not found. However, in pci_qdev_realize(), the caller of
>> vfio_realize(), it checks if the errp is set for failure, rather than
>> the return value.
> 
> Am I correct in assuming that errp can just be removed because the
> return status already carries the information?

Hi, Edmund

Please "reply all" to get your reply posted to the mailing list :)

Not really so. Here we checks if kernel exposes OpRegion VFIO region on
that device, if it doesn't, we believe it is not a IGD. So it should not
be a error if OpRegion is not found on a Intel VGA device (It can be
discrete GPU, SR-IOV VF, or something else). Here I choose to only print
the "OpRegion detected..." message if OpRegion found rather than the
misleading "OpRegion not supported" message on all Intel VGA.

>> I will submit a patch later to fix error handling.
> 
> I've had to manually apply the patch by hand.
> For me, your patch became:
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7952d15a0..e7a9d1ffc1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>  }
>  
>  static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
> -                                         struct vfio_region_info **opregion,
> -                                         Error **errp)
> +                                         struct vfio_region_info **opregion)
>  {
>      int ret;
>  
> -    /* Hotplugging is not supported for opregion access */
> -    if (vdev->pdev.qdev.hotplugged) {
> -        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
> -        return false;
> -    }
> -
>      ret = vfio_device_get_region_info_type(&vdev->vbasedev,
>                      VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>                      VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>      if (ret) {
> -        error_setg_errno(errp, -ret,
> -                         "Device does not supports IGD OpRegion feature");
> +        return false;
> +    }
> +
> +    /* Hotplugging is not supported for opregion access */
> +    if (vdev->pdev.qdev.hotplugged) {
> +        warn_report("IGD device detected, but OpRegion is not supported "
> +                    "on hotplugged device.");
>          return false;
>      }
>  
> @@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      }
>  
>      /* IGD device always comes with OpRegion */
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          return true;
>      }
>      info_report("OpRegion detected on Intel display %x.", vdev->device_id);
> @@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          /* Should never reach here, KVMGT always emulates OpRegion */
>          return false;
>      }
> 
> Testing it, it works (for me)!
> Though I can only confirm the negative (for a SR-IOV iGPU
> virtual function).
> I can't unbind my primary GPU (the root iGPU device) since
> I'm using it.
> The VM boots fine regardless whether
> `-device vfio-pci,...,x-igd-opregion=` is set to off or on now.
> Tested-by: Edmund Raile <edmund.raile@protonmail.com>
> 
> Your patch provides successful automatic OpRegion detection.
> 
> But for the case that this automatic detection should some day break
> or become ineffective due to new hardware: should I still send in my
> [PATCH v3]?

I'm not sure if it is really needed. We only apply quirks on device that
exposes OpRegion, ignoring others. And x-igd-opregion=off disables
passing it to guest. So far "A Intel VGA device with OpRegion is an IGD"
is true, but there may be other possibilities in future... It also
breaks the behavior as other quirks (like ASLS register) will not be
applied when x-igd-opregion=off.

If we decide to move the flag check before vfio_pci_igd_opregion_detect,
then probably the check before calling vfio_pci_igd_opregion_init can be
removed.

Any ideas will be appreciated.

Thanks,
Moeko
 
> [PATCH v3] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7a9d1ffc1..ac9f504e8f 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -521,6 +521,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> +    /* Respect x-igd-opregion=off by skipping OpRegion handling */
> +    if (!(vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
> +        return true;
> +    }
> +
>      /* IGD device always comes with OpRegion */
>      if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          return true;
> 
> That way, we'd have a certain way to force it off if need be
> A redundancy, in case.
> Can't always expect everything to always work perfectly.
> 
> Thanks,
> Edmund

