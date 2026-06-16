Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D844CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXeV-0006zm-55; Tue, 16 Jun 2026 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZXeT-0006zI-Lj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZXeP-0004s0-IG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781631156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7Wzk/TQvkS6CvcQwpLhVO2b2vQ/s1FNEp2LrXNl3+v8=;
 b=frk6r77ObHgN0Y1NROZyXu3HSdcvc0LFw7DLZD53AgkumPBfkzY9hxIpUZLYysex7dEOeE
 zERIP1Jpclak4oeE0ET85k8/FpuHIL/ccqyfdl+JKMj2eEdKFHMGNyNIkM5ouviQbxq8c4
 QgzojxY37Hm1X2BQJf+13YuG1dJ5tcw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-owObVShEMU2flpv-qpT48g-1; Tue, 16 Jun 2026 13:32:35 -0400
X-MC-Unique: owObVShEMU2flpv-qpT48g-1
X-Mimecast-MFC-AGG-ID: owObVShEMU2flpv-qpT48g_1781631154
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso2770503f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781631154; x=1782235954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7Wzk/TQvkS6CvcQwpLhVO2b2vQ/s1FNEp2LrXNl3+v8=;
 b=Nbd/z/zZtX6u1AB11oEmHILMk09Yurx1dj79Q8KoCXBVf1lBrmetKvoSV9R8ubr3BR
 cTx2C05QaQ3cBtQBb0PFIKoVf6lfBeWhm4ag6UIOvEyanLW4t5iPemEIPdPAYfoWprHM
 SBpF9TwivRuGy/hNX7Z2rMBfL+V0PoDZV8lVrvPzqCCt9EgwpJYmcaJU6RZfKa8Zs3JI
 RTTnr0TdGRQSNpHaAhx5q3yHlrXJh4TZnLzNuBYNmVthMmNijUwk2W7++/by71WBvrjW
 GHOdTT21VB7R2ot9Bb52ULda/7VS2poXJIHh+GSoRLbmgyQgyD8LxXXRuQmnFi6gcDjZ
 yvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631154; x=1782235954;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Wzk/TQvkS6CvcQwpLhVO2b2vQ/s1FNEp2LrXNl3+v8=;
 b=J+eIHy538D1quRqUj6WleZAK59WLRO3lgNVoJC3+jaABtWm9gRRBIgSlRDkPbZuckf
 91MrzTpmnwjcfkBENsaB1Qb7XQD5U3sXvj+HHHY19L6cK63XLRiB0u7KTMisJtQ1JQ14
 dwPUP7jVrzFJQCKhgjFiQd/uLdBPKbf1mWqTkdRr7HupTDx7RC/aEBWF/gguKX6w7SqN
 h3rc6saNV2Qr7jpHQ0kzQYNB1TC9s3lqXJKRUF/EQQBFYUUbEmz0euRK9tCW3eqKo+Fk
 /I3evjoBWXyzNgz2ZLiJVJqskuKPI6AgyFqHx4PWhl1ScfCZcYGZaDPtPV0V2f28/qtC
 161g==
X-Forwarded-Encrypted: i=1;
 AFNElJ95gyb9IcKeO114BZDoQGVhrDSzI5AHSvoKdnvPM448cr8Hzqgs+BwNFQU7z70z8KfBMg/bt0W9bBz3@nongnu.org
X-Gm-Message-State: AOJu0Yy4WVB+n8HHIIJN3N/8Ajy6NeuxAKTNtwMPpwpJqhoiiQDameyO
 3s1mdox9DklFV+S3a0YNRxMZJW2p85MXTcKW/tlfjrf8sUimJKjOvc9wJ7roJ0N4aH4fMNzAoeV
 a1veT7PUv/u4wR14BPD10uQA4Cs8heF1hxuUsJHYccOKpYGrcPX5rejPn
X-Gm-Gg: Acq92OF3PbclDv0ntxMMx2S/8DGo6MldkNNVtPFDjT8jtM/GZOps1vr0uSiIM8xHb8P
 fOx/LsbLAFuHYFLbBBhwYRNPkADC+AT4+MfSafh1GVoiyZ2xC8jN/odWXxjgyxKEcDyaB2QVBgn
 0WhkJuXqKH3Q0ds9kutNsaEjpurjOI6wHA9ZfUTPWR01fU+vkDr8DJZecDLdcXhbotmkgIXmNyD
 bd4i3PZbbf+w/3KolMiKVsmknclfIF7FZ3pPgvKKeY+yFnOBLtda5uWTGTIbCByjCtdU0uV/ezJ
 Vk18Hpm2tDEUe7FIO6LxjBIDoDdXOfajCcqLXdHcmKbJVEL9ZdhXnWxG1aWHWvkYy1wlNCRwHLc
 fBm3cjHchI79uA64eLx0iVgEbXcDADWbVa3aIHkQf/lE49C5zHBVV5G5Sq28q
X-Received: by 2002:a5d:5d13:0:b0:460:3b5d:43b6 with SMTP id
 ffacd0b85a97d-46238508dfcmr726199f8f.31.1781631153792; 
 Tue, 16 Jun 2026 10:32:33 -0700 (PDT)
X-Received: by 2002:a5d:5d13:0:b0:460:3b5d:43b6 with SMTP id
 ffacd0b85a97d-46238508dfcmr726130f8f.31.1781631153314; 
 Tue, 16 Jun 2026 10:32:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm3212387f8f.22.2026.06.16.10.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:32:32 -0700 (PDT)
Message-ID: <1f309815-d64f-4350-b013-14a6bd077928@redhat.com>
Date: Tue, 16 Jun 2026 19:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Propagate errors in vfio_pci_load_rom() using
 Error API
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, philmd@mailo.com
References: <20260611094348.516879-1-mcasquer@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260611094348.516879-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Mario,

On 6/11/26 11:43, Mario Casquero wrote:
> Updates vfio_pci_load_rom() to use Error API for error propagation
> instead of error_report(), improving error handling consistency.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> ---
>   hw/vfio/pci.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d7..11876fd5b4 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -1040,7 +1040,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>                                         &reg_info);
>   
>       if (ret != 0) {
> -        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
> +        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
>           return false;
>       }
>   
> @@ -1052,10 +1052,10 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_offset = reg_info->offset;
>   
>       if (!vdev->rom_size) {
> -        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
> -        error_printf("Device option ROM contents are probably invalid "
> -                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
> -                    "or load from file with romfile=\n");
> +        error_setg(errp, "vfio-pci: Cannot read device rom at %s. "
> +                   "Device option ROM contents are probably invalid "
> +                   "(check dmesg). Skip option ROM probe with rombar=0, "
> +                   "or load from file with romfile=", vbasedev->name);

Here I would add :

     error_setg(errp, "vfio-pci: Cannot read device rom at %s", vbasedev->name);

and keep the error_printf() as it is.

The error_setg() propagates the error and error_printf() emits
the "hint" whether the caller handles or not the error.


>           return false;
>       }
>   
> @@ -1076,9 +1076,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %s",
> -                         strreaderror(bytes));
> -
> +            error_setg(errp, "vfio: Error reading device ROM: %s",
> +                       strreaderror(bytes));

May be instead :

     error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");

and since vdev->rom_size and vdev->rom_offset are left dirty :

     g_free(vdev->rom);
     vdev->rom = NULL;
     vdev->rom_size = 0;
     vdev->rom_offset = 0;
     return false;


>               break;
>           }
>       }
> @@ -1147,7 +1146,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   
>       /* Load the ROM lazily when the guest tries to read it */
>       if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> -        vdev->rom_read_failed = !vfio_pci_load_rom(vdev);
> +        vdev->rom_read_failed = !vfio_pci_load_rom(vdev, NULL);

The NULL 'errp' parameter will silently discard the error of
vfio_pci_load_rom(). All error_setg() / error_setg_errno() calls
become no-ops.

This would be better :

     Error *local_err = NULL;

     vdev->rom_read_failed = !vfio_pci_load_rom(vdev, &local_err);
     if (vdev->rom_read_failed) {
         error_report_err(local_err);
     }

Thanks,

C.

>       }
>   
>       memcpy(&val, vdev->rom + addr,


