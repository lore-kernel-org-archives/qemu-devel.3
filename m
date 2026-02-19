Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4496DE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 08:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszBB-0005FK-9E; Thu, 19 Feb 2026 03:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vszB9-0005F8-Q5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vszB8-00067j-9X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771488868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+KNm4kV1eyQL4P6Pga5+sg9nFnSiFIjjxS8g26qpJ9s=;
 b=Hdv2N7R136QNUHo/VhuYBd3A3CM6EU2DmompjGGtvC8ycQqEvnKliIsLVhvUIeCZSw5Nq8
 9Adeoqno5g7586h6Z8RkL0mdTzxSxQLlHouzy67cBN7PB8oK+VutpQOMcHiu5rYzPzeKxp
 LnVBF0CnkHNQTK0lmKeUizmDmaxNLdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-R5Az4jt_PGqiN-qmJES8tw-1; Thu, 19 Feb 2026 03:14:26 -0500
X-MC-Unique: R5Az4jt_PGqiN-qmJES8tw-1
X-Mimecast-MFC-AGG-ID: R5Az4jt_PGqiN-qmJES8tw_1771488866
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836b7fbf4fso5958505e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 00:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771488865; x=1772093665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+KNm4kV1eyQL4P6Pga5+sg9nFnSiFIjjxS8g26qpJ9s=;
 b=RWX3hlvDf0bxuWsrOnkWzxPkUyJEN7R7urh5UJ1s0ieR+8WbQ5T9AYwHThyeKmDTkU
 bUBcGK+KXRvpxIXkCHU6HyBkGROjdsKtDDEMKNyS1MSLWCyXxaMUeSyXgQyoAgKBp0u2
 nEAj+ysPYZihKE6UldtnifmuS9yCB47AMUxMntDhrIzZmI0zVYqwV/o8Kz5osWFdKErH
 yD0p1Un7J+t2rcH9yBEaLfYGKr5E7m+BW5YjAsBM/Xs0fzs72qyvYk2M5Zx3yXXwDcYr
 p0skgSbQsi8xw+6jynvRHu6NKiaCtPRS9zpovHzi5HCxc5kT/4Wd/+QkQPHrdZ3ILVt7
 447w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771488865; x=1772093665;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KNm4kV1eyQL4P6Pga5+sg9nFnSiFIjjxS8g26qpJ9s=;
 b=UKzgyO8YzKdsmWt0uUJP0OhMvi45SO/Q36j0P0yCfYdLxVhIUfX2TTpIUgqntoMq24
 qZudCrLymHEZTIr2LD9DEcZZEGfd9JJxacgoSCmM4/UFwmsqxSIjpdb3x/LghwTxGDX2
 BaK3TIfLZiGR+G+tRaLyYKJy5V7lFekXXnyel9JiAfR5Z/ox/3hSvfBIwdntG0bCUG5H
 myRmrkQ8/mfrsJgQKt8D1a/wmpQehCUsnUKkecsuc5EuO9AG252D4FwmEEiKhAOJaYCG
 xMfmJg1D+DI8ZYLH7OkcvFvrq/rMBjihPvC3e7J9u3F/ycynD5LxtQ9TtB6tZM+Ohmk0
 7z0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkayhDgGP3/JNVHymyEGFFdaJPK28Lau51LHIzm2sNQj67v54sMJurhh3Zks9daHPcqncgaQHm40MS@nongnu.org
X-Gm-Message-State: AOJu0YwOqKA/6C7LOP4rhqpmwaVmQioKpHtO0Sz8sIRX/gY1CLt8IWjC
 ljEFVOVvENWztTtJpYsNhXqHa0sa2zFreG+BbxPaAHeLz/t8WzDrSAEIELOsUd997XCt5dRaiRZ
 L1uiHnwZjjDFcUsBdKV+wogv3ORfPVI/PaW0h6YpIM1g2phmSXPU5ynGZ
X-Gm-Gg: AZuq6aLn2YVuOOjHbFN/f4eB5IIfIRFf92o+lRtv4w8fiM+65mrFRWqo4C+/3gIbPGn
 WWnuZsjlLiDNk90npma2t6i5uA8CZuKJ7ZZiL8NLPUImHD+nZe7MHyetWr4xUDR++v6DGImKr7v
 4QlYHPxs31zqp2SOQF0gDmt02rBRvHP+09WVMBNX/54PC2yuuM1y3u/qnqQotlqfj43vB9QHR+8
 i4KniFFFl/JnleOO+vQXeffKI2DwgtIMcbt3k6jeBnlF33cfBtfzXcIFD64yKjHpMK5A5oSa77E
 Ujkr+zVxZd8Y4cSll4VzouAt7vSHaKe7O/XNRFc0DG+JyYnzrTrQNpuwoAiIObINuWc44v2+7jF
 66GhNMH53wyCoVoH6g7JhWvb+LGosZSpQeT6TZd7RIHKLOVEsSs1vFrxXLYG1
X-Received: by 2002:a05:600c:1e24:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-4839e668a55mr28238995e9.25.1771488865538; 
 Thu, 19 Feb 2026 00:14:25 -0800 (PST)
X-Received: by 2002:a05:600c:1e24:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-4839e668a55mr28238625e9.25.1771488865123; 
 Thu, 19 Feb 2026 00:14:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839f905d3csm29406065e9.1.2026.02.19.00.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 00:14:24 -0800 (PST)
Message-ID: <b7c1cb1e-7ca8-4d79-94f1-8f6e3bee4b65@redhat.com>
Date: Thu, 19 Feb 2026 09:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
 <CAK3XEhOFvXUEiO3z1MhGqjBQUH3hB_3u9suLpweBs9vaTr1zog@mail.gmail.com>
 <61f1dfa8-705e-4f2f-ac9c-35da4e8eac02@redhat.com>
 <3D89ED00-C696-4ECA-BE4C-7ADF04631900@redhat.com>
 <a03128b2-ce06-3e22-08f2-2eea68f0afe1@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a03128b2-ce06-3e22-08f2-2eea68f0afe1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> please try this patch on top of my v5. It should fix the issue. I tested
> on a RHEL 9 host and a fc43 SEV-SNP host, 1 or multiple vcpus, two
> different guests and all looks good.
> 
>  From 26db44eba8c727160dd9e97c9d5582a0ddc5884d Mon Sep 17 00:00:00 2001
> From: Ani Sinha <anisinha@redhat.com>
> Date: Thu, 19 Feb 2026 13:12:02 +0530
> Subject: [PATCH] Call cpu_synchronize_all_post_init for coco as well
> 
> Fixes issue reported by Cedric
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d7ea60f582..0610bf8434 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2816,7 +2816,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>       }
> 
>       s->vmfd = ret;
> -
> +    kvm_state->guest_state_protected = false;
>       kvm_setup_dirty_ring(s);
> 
>       /* rebind memory to new vm fd */
> @@ -2872,6 +2872,9 @@ static int kvm_reset_vmfd(MachineState *ms)
>        * kvm fd has changed. Commit the irq routes to KVM once more.
>        */
>       kvm_irqchip_commit_routes(s);
> +    if (ms->cgs) {
> +        cpu_synchronize_all_post_init();
> +    }
>       trace_kvm_reset_vmfd();
>       return ret;
>   }

Tested (OS reboot, system_reset) with a RHEL10 guest (2 vCPUs) on
a RHEL9 and a RHEL10 host, using a SATA device and active NIC VFs.
All Looks good.

There is still one message :

   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.

which seems normal.

Thanks,

C.




