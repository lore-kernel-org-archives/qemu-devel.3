Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F1FC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4jh-0006bK-F5; Mon, 03 Mar 2025 07:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp4jb-0006WI-Na
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp4jZ-0005RK-8C
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741004239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HJv4pR22jpZQf+pJ8krGsd15am5SkHVX5usZPqlFYG4=;
 b=YSa3ndPPRJnrquVLRDviFi/BSwZdleW1/Li97JQKNxFKBEemfCOtr7ZRegiA2ZimuCeeJ8
 ZiOZB6Zb3ePSNw/ky6SYuV/oAlLX/TSmlcEteJRJ0A1FbJXelCYwHQIlK0glyh7RNfo1u8
 l4MuUJXsHDL2Tv504p7KE4jGXzP/M20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Wjgc9b05Oq2fEBIfTSsxbA-1; Mon, 03 Mar 2025 07:17:17 -0500
X-MC-Unique: Wjgc9b05Oq2fEBIfTSsxbA-1
X-Mimecast-MFC-AGG-ID: Wjgc9b05Oq2fEBIfTSsxbA_1741004236
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so16667625e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741004236; x=1741609036;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJv4pR22jpZQf+pJ8krGsd15am5SkHVX5usZPqlFYG4=;
 b=abh/AjSK8r6KfBLpNxcidvLAmFkmfQ99qFuM+MjctcqfhTeR/RXpqvD0bAFB4C60D7
 TltchBEffJKiC6IlPKOKFoK+vsepcC7cKVLf/oJNX7vkPPB96ryobklxyanD8k4nhx3S
 qyCyyXDPpqI1a9/ZiVPTrcXXFut/SKja2VJDXsDOA0N15yDGyckJHgzoEo39M+r+h0Gf
 4kkQZz+MtVbeZfmuaeAjqgVekIgf/Vy116nrNCUVJkSQxMImk9kYP9qEyKwlxvAD3jwp
 gDB/CTOiGE2gCIRTmmyxszzwyZTZw/SQd+RGnXIigdxM+bPtbuBsMPasNp6Xy3ylG4ub
 VdbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg/J+jN0uZ8hFyWQSgsyTcS25sqtCKJt5s2jMcVwwG39Wx33Cz/38WTxeAIFxEhJxojarkb57fIAwR@nongnu.org
X-Gm-Message-State: AOJu0YyvMBrywCZiQIebpc3xyhA4zu4XyhXVCawnUM0mmvkSjm7FtXpX
 rVbYWBstGwcEiPQf+hoN4z7M9bW8SuvFQwo2yrTM3XCQT7bJL++pxpWe2hbOzyDNLR6Zxsam5ws
 3YjWF1/Mftq/r3saFPI3l74o34Lw5nspA+rg3O/6KwIQ5ecUK4usw
X-Gm-Gg: ASbGnct3Xf1TfkYE54mOBrBmu9tjO3vNBLv7qN+4uoAUJfXTzeTyxy13uLqog0sadvf
 ODmB8mkZos/bWiynh+HlshgZs07Vm9LvEPcpG0vKTW5j3D4OfdWfE+lJChdIZ/IKBj4ZrQE1fSz
 x8SohwKWH1ihMjQmEx2TJs7Wc2HMie2+HrQXlrMRD5x58Dvn55ssOHtuZ8eLoYh/115o+0scBAh
 1Ksgg0+xXVoqId2JoSgKUj50gUBPTYHRacGxr1o/GVIYsrK3PGBo2R/0cYGzH1jzEFhjhpKpEGv
 mka88mLx/lzQXROrhKQ=
X-Received: by 2002:a05:600c:2d82:b0:43b:c0fa:f9c0 with SMTP id
 5b1f17b1804b1-43bc0fb0089mr22466335e9.28.1741004236368; 
 Mon, 03 Mar 2025 04:17:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtQSoKn2oJP12uIh0xdOXtj0IXsxDKX0t8AE1Uz0xDFgzoltV1iBCTFvfhWHymmGY7R8JqUQ==
X-Received: by 2002:a05:600c:2d82:b0:43b:c0fa:f9c0 with SMTP id
 5b1f17b1804b1-43bc0fb0089mr22466185e9.28.1741004236005; 
 Mon, 03 Mar 2025 04:17:16 -0800 (PST)
Received: from [192.168.10.27] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43bc63bcaafsm18418865e9.28.2025.03.03.04.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:17:15 -0800 (PST)
Message-ID: <0128cd62-b5d7-4aa1-b169-2a7717d33113@redhat.com>
Date: Mon, 3 Mar 2025 13:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb-storage: Allow manually adding SCSI device
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250303-usb-v1-1-70f700a181fd@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20250303-usb-v1-1-70f700a181fd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I might be misunderstanding what you're doing, but can't you do that 
already with usb-bot?

Paolo

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
>   
>   static const Property msd_properties[] = {
> 
> ---
> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
> change-id: 20250301-usb-5dde4bcb1467
> 
> Best regards,


