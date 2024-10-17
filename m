Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F6D21274
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Noq-0006mz-L4; Thu, 17 Oct 2024 06:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Noo-0006kj-HT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Nol-0006W0-HY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729161195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RHca4pvRoZkohBuLKqJU3k5QegE3GxCGkY+li/2m3n8=;
 b=XngyK5NUZSPwNb2TL9y/O8T5ilghDViE3qTbPjr3dh7GpLF3RdD+P75M+NmfIZOKS7bTwB
 KS05dDb2336IyRr1waXzMgiKKKBrVCEwHbMIAUph540EvOYbfJyEYe+0gzvuZj70QrbUdX
 sJ8oVInrAFD5pwis9xNXB9f+afnKlEk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-GfLLGfbKOwWTz2VEp1fLHQ-1; Thu, 17 Oct 2024 06:33:12 -0400
X-MC-Unique: GfLLGfbKOwWTz2VEp1fLHQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso280145f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 03:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729161191; x=1729765991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHca4pvRoZkohBuLKqJU3k5QegE3GxCGkY+li/2m3n8=;
 b=tNKbsmd3QM1FUejcKy3j/52aK9+eK/FhacqhEhQDrZk9LF7cywq1XqqfBv9fw6W23W
 ryLjkaaSbOUyo5ZUyEZnmOLYdSjVRrp8pDL7riWL6itNKTDjJ7dGNP363EtA0TeRBQ6V
 riilvvvVJd+PcoECJ246ypgVNacm0s/LAvAerd5k6Q/TUf+vxAUSdsl+jttguyWdcm2p
 s/EM47bpU8Y6JtOPSzyf6PRY32YGrzcJ3c0k0wNGivo6i9lxWYm2nya+kYVJ5xU3UdRA
 7I3ZTQZ9k/qD2iJa2GbytNaeOxPqDd5phjuiOAhC+PP8MgrYz/tcB+329uxNuJ7/e4SZ
 /ewg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1lki31DMjHToQAjzckHc2mTXglPujwwV+YGotr4cj0+5bGabnplrDEOo7cnUMjjPIQIhdUJAlslpR@nongnu.org
X-Gm-Message-State: AOJu0Yy3Nxf2oSSQ4mo2Cj4NBWf8JypjIna+/vc+vu23HJsEGZd8/vgm
 sUVwSMy6RjSi3X4dR7IW68ZME95/IjFsCA232wgvYXT6bsxSJ48d7lGEWpvSXb1mKDaunsuGlm4
 FRmfFoRIcIT6Wom5EC+SMQXhttOEaJhiAeAYmO9iSIUWFW3a4OqUJ
X-Received: by 2002:adf:ea41:0:b0:37d:4cd6:6f2f with SMTP id
 ffacd0b85a97d-37d86ba83b6mr4449398f8f.3.1729161191319; 
 Thu, 17 Oct 2024 03:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU87CmKPPdk1/4656KY9He8ndFm//psEVx5/ulSARJu3dUuA3lKJcvWm7I0qMnsjuoyiWlng==
X-Received: by 2002:adf:ea41:0:b0:37d:4cd6:6f2f with SMTP id
 ffacd0b85a97d-37d86ba83b6mr4449385f8f.3.1729161190911; 
 Thu, 17 Oct 2024 03:33:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc403d3sm6802314f8f.101.2024.10.17.03.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:33:10 -0700 (PDT)
Message-ID: <9f7f0503-0366-43f0-a3af-a5f2221fc3a2@redhat.com>
Date: Thu, 17 Oct 2024 12:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] pc-bios/s390-ccw: Remove panics from Netboot IPL
 path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
 <20241017014748.829029-12-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017014748.829029-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/10/2024 03.47, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from Netboot specific functions so that error recovery
> may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/s390-ccw.h   |  2 +-
>   pc-bios/s390-ccw/bootmap.c    |  1 +
>   pc-bios/s390-ccw/netmain.c    | 17 +++++++++++------
>   pc-bios/s390-ccw/virtio-net.c |  7 +++++--
>   4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 3e844abd71..344ad15655 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -57,7 +57,7 @@ unsigned int get_loadparm_index(void);
>   void main(void);
>   
>   /* netmain.c */
> -void netmain(void);
> +int netmain(void);
>   
>   /* sclp.c */
>   void sclp_print(const char *string);
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index a277fc3431..f1cfb7aaa8 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -1073,6 +1073,7 @@ void zipl_load(void)
>   
>       if (virtio_get_device_type() == VIRTIO_ID_NET) {
>           netmain();
> +        panic("\n! Cannot IPL from this network !\n");
>       }
>   
>       if (ipl_scsi()) {
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index bc6ad8695f..0bb359e09f 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
>       return false;
>   }
>   
> -static void virtio_setup(void)
> +static bool virtio_setup(void)
>   {
>       Schib schib;
>       int ssid;
> @@ -495,10 +495,10 @@ static void virtio_setup(void)
>           }
>       }
>   
> -    IPL_assert(found, "No virtio net device found");
> +    return found;
>   }
>   
> -void netmain(void)
> +int netmain(void)
>   {
>       filename_ip_t fn_ip;
>       int rc, fnlen;
> @@ -506,11 +506,15 @@ void netmain(void)
>       sclp_setup();
>       puts("Network boot starting...");
>   
> -    virtio_setup();
> +    if (!virtio_setup()) {
> +        puts("No virtio net device found.");
> +        return 1;
> +    }
>   
>       rc = net_init(&fn_ip);
>       if (rc) {
> -        panic("Network initialization failed. Halting.");
> +        puts("Network initialization failed.");
> +        return 1;
>       }
>   
>       fnlen = strlen(fn_ip.filename);
> @@ -528,5 +532,6 @@ void netmain(void)
>           jump_to_low_kernel();
>       }
>   
> -    panic("Failed to load OS from network.");
> +    puts("Failed to load OS from network.");
> +    return 1;
>   }

I'd maybe also change the netmain() function to return -1 in case of errors.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


