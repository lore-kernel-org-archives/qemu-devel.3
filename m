Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB19CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcjA-0004oY-3B; Mon, 08 Sep 2025 10:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcit-0004eR-RN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvcif-0000kB-Jv
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757341181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=35e6rq1inm1qiEi1Ze0OmsUix0PFI3G3ih64wZTDO5U=;
 b=iOQHU/7uceJVWeMtqQEhoUmrNE9i6M19F/m6xBu7iSLjh1seTrdU3m/Td1bA7aItrXAnMH
 T5gE8HzJnZ4yR2BU5lTFQxbOxUSUaRYnZ06mSZUg6vGOpuLCpEkUQggZrKMZF5m8a52vzK
 9BhuUODUZ89QGiCZRzwiH8yx7Fx3oH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-jnIaQ-KGPCWvbMg2hbT3yQ-1; Mon, 08 Sep 2025 10:19:38 -0400
X-MC-Unique: jnIaQ-KGPCWvbMg2hbT3yQ-1
X-Mimecast-MFC-AGG-ID: jnIaQ-KGPCWvbMg2hbT3yQ_1757341174
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3db89e4f443so2744375f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757341174; x=1757945974;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35e6rq1inm1qiEi1Ze0OmsUix0PFI3G3ih64wZTDO5U=;
 b=AYuFIdOAyN0QXXMRtZ6+JgJ4+/qli5ASebVdGuISC8JTKsfkY7c05dlZcverzndhwj
 qXJQWqdaMp3v6xfLdl5+njMXKrBrJ4ZQ0yaY/MPT3QNOM5/iHRqoyq5lMP2iWM4sHZVE
 7zbbzWO1Ag2AjMf2dituK+kESQdqssb2FjWESTTs2U+W9/hhLJokt84Z162wsakRXmm5
 6tJ5P/unREhwbt8Rq1+g05CTErC3l7MACltxvdKD1VfVHB0Z0/fqRl+wIxJ/LFHADI1V
 x0Xo3EtAz2LcDwWztnhKh9yCmlafM9xCugp+J9oSGIeizInm5hAnJLiyMV/gyOlhVx6r
 G+Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0rpai0LFm68XMiwZIbCI1a1vxOmY1/nc03UhUYXVDlcVqntpa8RyYT7MFUnAo5b7UZT25GR0s1+pZ@nongnu.org
X-Gm-Message-State: AOJu0Yw/7TRvM/m8OY0viRhgeLBd71lW9olidD3GPO7pSnoD1NQmoZtc
 JN6Fbt5HW3UkyMzFIvAA8FrxxeMGeAIqTf1FpEojY5OtpAhKZTKwtoKvcIqY0F9dZAbpC05XkSh
 kNIgSwFMIwFoJf8s7QIHk2Z7aibztbToah/S94X3UBTiNo86stifqGZSy
X-Gm-Gg: ASbGncvJ7+mjbTrESFnMx27GsoHXb07Tx6pEuDiz3Yy+9LVOAaRWrH5cBSYQ4Jfv/Li
 wY9rOFRsUCmEbXIecTHSlWv9P/X7AyG9eqZRDjMq+vv7ui89EDpwjhBoo+f2qhyr1CFakraPU8h
 ZsKO3h14lwFiVP4ZiSu9FQt5uVEAMjchsXu1E2spdO4EayBFGMA1dUEbhTs07WR45phlIgEh4Vg
 9INlinikbqx8I0kC6rqKJldnC/RC2deuVUDfK4VPvdh0U+32cOlGG1sBMaTD88nFwXMy5pu2t1I
 /xD9PBAuXFywqz7hY1/Vhx8x+mLPW0x3dLgR2zT7XeAQ5266rlv9BzRUTclD5158iFaLirz/zJW
 0xUU=
X-Received: by 2002:a05:6000:40d9:b0:3e0:e23f:c6d9 with SMTP id
 ffacd0b85a97d-3e6429cc8f4mr5792626f8f.17.1757341174188; 
 Mon, 08 Sep 2025 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXUXkPxHHaot7OBwvHNhyyHVPcwXhsotoEWGpWNMwi7On0MBpGSqWdWI7GUQgVE0UbZxkBuQ==
X-Received: by 2002:a05:6000:40d9:b0:3e0:e23f:c6d9 with SMTP id
 ffacd0b85a97d-3e6429cc8f4mr5792581f8f.17.1757341173647; 
 Mon, 08 Sep 2025 07:19:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0f85c287fsm39828374f8f.52.2025.09.08.07.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 07:19:30 -0700 (PDT)
Message-ID: <999058e5-747f-487f-abc6-4ab29cfbb9f7@redhat.com>
Date: Mon, 8 Sep 2025 16:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] vfio: improve use of QOM and coding guidelines
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> This series attempts to improve use of QOM within the vfio subsystem which
> appears to have been added at a later date. It's mostly mechanical changes
> that do the following:
> 
>    1) Format the QOM structs per our coding guidelines
> 
>    2) Ensure the parent object is called parent_obj
> 
>    3) Use QOM casts to access the parent object, instead of accessing
>       the parent struct member directly
> 
> The benefits of this are that the QOM casts included type checking to help
> ensure the right object is being passed into the cast, and it also becomes
> much easier to infer the class hierarchy from reading the code.
> 
> Having produced this series, it feels to me that the readability could be
> further improved by renaming the structs as follows:
> 
>     VFIOContainer     -> VFIOLegacyContainer
>     VFIOContainerBase -> VFIOContainer
> 
> However I have left this for now given how close that we are to freeze.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> 
> Mark Cave-Ayland (22):
>    vfio/vfio-container-base.h: update VFIOContainerBase declaration
>    vfio/vfio-container.h: update VFIOContainer declaration
>    hw/vfio/cpr-legacy.c: use QOM casts where appropriate
>    hw/vfio/container.c: use QOM casts where appropriate
>    ppc/spapr_pci_vfio.c: use QOM casts where appropriate
>    vfio/spapr.c: use QOM casts where appropriate
>    vfio/vfio-container.h: rename VFIOContainer bcontainer field to
>      parent_obj
>    vfio-user/container.h: update VFIOUserContainer declaration
>    vfio/container.c: use QOM casts where appropriate
>    vfio-user/container.h: rename VFIOUserContainer bcontainer field to
>      parent_obj
>    vfio-user/pci.c: update VFIOUserPCIDevice declaration
>    vfio-user/pci.c: use QOM casts where appropriate
>    vfio-user/pci.c: rename VFIOUserPCIDevice device field to parent_obj
>    vfio/pci.h: update VFIOPCIDevice declaration
>    vfio/pci.h: use QOM casts where appropriate
>    vfio/pci.c: use QOM casts where appropriate
>    vfio/pci-quirks.c: use QOM casts where appropriate
>    vfio/cpr.c: use QOM casts where appropriate
>    vfio/igd.c: use QOM casts where appropriate
>    vfio-user/pci.c: use QOM casts where appropriate
>    s390x/s390-pci-vfio.c: use QOM casts where appropriate
>    vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj
> 
>   hw/ppc/spapr_pci_vfio.c               |   2 +-
>   hw/s390x/s390-pci-vfio.c              |  14 +-
>   hw/vfio-user/container.c              |  26 ++--
>   hw/vfio-user/container.h              |   7 +-
>   hw/vfio-user/pci.c                    |  16 +-
>   hw/vfio/container.c                   |  31 ++--
>   hw/vfio/cpr-legacy.c                  |  14 +-
>   hw/vfio/cpr.c                         |  10 +-
>   hw/vfio/igd.c                         |  38 ++---
>   hw/vfio/pci-quirks.c                  |  48 +++---
>   hw/vfio/pci.c                         | 206 +++++++++++++++-----------
>   hw/vfio/pci.h                         |   5 +-
>   hw/vfio/spapr.c                       |  16 +-
>   include/hw/vfio/vfio-container-base.h |  13 +-
>   include/hw/vfio/vfio-container.h      |   7 +-
>   15 files changed, 249 insertions(+), 204 deletions(-)
> 

I did some tests with an IGB device and didn't see any performance
regression.

Applied to vfio-next.

Thanks,

C.



