Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88835E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCAT-00072G-Cm; Thu, 19 Dec 2024 03:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOCAO-00071o-A6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOCAM-00086L-Lz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SQT+czbIBPwcEB91PHxjuXShyWUiM0SbdQv7r6W3a4w=;
 b=eFQWmcN0YiIpWuzbF6FvuTCCIk/EmGn81BLz32f/GHu0AhwwOnPaXAYJO2N/sbSCj86l72
 ipSE0BZMDEckCHKVFeoZ0U8KRryzftEQ6iB8OmganwXfr5sv/IOeC6x0c/E7DP7XkIOyOu
 7NC1oqSV/tFifhpIx0db+H03cXIND+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-nb2uE69JMWuyKrTaY34cmg-1; Thu, 19 Dec 2024 03:45:51 -0500
X-MC-Unique: nb2uE69JMWuyKrTaY34cmg-1
X-Mimecast-MFC-AGG-ID: nb2uE69JMWuyKrTaY34cmg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso2961615e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597950; x=1735202750;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQT+czbIBPwcEB91PHxjuXShyWUiM0SbdQv7r6W3a4w=;
 b=P3HPsRQZ6bdxZIEAnBhK2hNHYo8PBDWltlpmdXe/jK/KkmAu6MpUG2SGfk8Q6aHjDR
 earcUUr64O3G7+/TPKlaFfqUU2iM1N0REg1N2/dBACBdkDuDD8DsjUDTXDLeLaL955GV
 DjHwQxDuWPays/Wp7B3gqQYZx1iwXwMxjczdaq4gIV9YjZ+zDzlrf0ok2FHM2PDS1A+j
 HggzV5ZM7beneSrcowYHHbLy35tyxn1KclzkNxsUmzo1ilK4RI7etgQTvVtEWnz6MiBK
 zBDF7I2LhwDtIbsEGmnez5lN+ib87MTfFYyH7HdIhCGynRLpJv5SLsM/025V3R9Hbr1m
 +KrA==
X-Gm-Message-State: AOJu0Ywsq3xZIAmVrqTYr9FhMPn5xzRQCIe8bKDxlQvRB0XiV+TP/e7h
 Qx73zyRMNA/6tUqV9Zcl1Xk4/Mi8Z/LPPQ8wwGIOIvIsn+MjwaAL0keILqEb+rGFkJJkWppBz+h
 5pGJ5+GUg17Feu4VHcbvCVmc1zrOLs/RCp/H+hZq26Wr/pK3/x1qHb1oOPGNQ
X-Gm-Gg: ASbGncvbjo7TC449/tvXwtkV2VdPdRnsCF34sc9D+s/hRG4rMBbIHPZdgSBc7afcxiO
 RH8dIDuhixbzayp8YN7kcURTZK8qzyA0+wBRcnU9cLXO5+eD3oeYm0bc6GL6whWETmxOWCMWtuP
 1qzewAeSRBbt4j1sxHO8jWpuV9ofy9/bBDGYqz7dw7eCyJbT7AxDb1qOK+KFmlCbHkkVPsAHpyW
 e57IGyb1/8DifPVrDEzcoj2DpS2dm/Ca9OEwBiSJ8in2BVce6y41HvdZI3K
X-Received: by 2002:a5d:6f01:0:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-388e4d7d296mr6002871f8f.34.1734597950272; 
 Thu, 19 Dec 2024 00:45:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKfzqIUAKS2/uxwB7rnUhYhC7Cv01lV1596qO/KPv4Wk4kB6pZ+BpBVLcRihlDAkj7dMbyUA==
X-Received: by 2002:a5d:6f01:0:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-388e4d7d296mr6002847f8f.34.1734597949877; 
 Thu, 19 Dec 2024 00:45:49 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6ca5sm1023562f8f.86.2024.12.19.00.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 00:45:49 -0800 (PST)
Message-ID: <73ec51e5-1fa3-4a77-930b-c7db0519256a@redhat.com>
Date: Thu, 19 Dec 2024 09:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use of BQL from thread in PCIe device
To: Markus Lavin <markus.lavin@ericsson.com>,
 John Levon <levon@movementarian.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <DU2PR07MB8179DBDD123A4615CBD1688EE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
 <Z2MGMM56+HzQ/ehS@movementarian.org>
 <DU2PR07MB8179C2AC676CF8B8DFECD00AE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <DU2PR07MB8179C2AC676CF8B8DFECD00AE8052@DU2PR07MB8179.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/18/24 20:10, Markus Lavin wrote:
> Sorry but I don't quite follow. Which callbacks are we talking about?
> Are you saying that it is fine to call pci_dma_read/pci_dma_write/ 
> msix_notify from a thread without acquiring any particular lock in advance?

Depending on how exactly your code is being called, it may be that the 
BQL is taken already.  Even if not, DMA is fine without acquiring any 
lock; MSIs are also DMA.  The DMA operations will take the BQL for you 
if needed.

However:

1) it may make sense for interrupts to go through an eventfd file 
descriptor (see kvm_virtio_pci_vq_vector_use, 
kvm_virtio_pci_vq_vector_release, kvm_virtio_pci_irqfd_use, 
kvm_virtio_pci_irqfd_release) instead of using msix_notify.  If you're 
using KVM, the write to the file descriptor will go straight to the 
kernel, bypassing the DMA emulation.

2) note that INTX, which is toggled by pci_set_irq(), needs the big QEMU 
lock.

Paolo

> Thanks,
> Markus
> 
> ------------------------------------------------------------------------
> *From:* John Levon <levon@movementarian.org>
> *Sent:* Wednesday, December 18, 2024 6:28 PM
> *To:* Markus Lavin <markus.lavin@ericsson.com>
> *Cc:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> *Subject:* Re: Use of BQL from thread in PCIe device
> [You don't often get email from levon@movementarian.org. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification <https:// 
> aka.ms/LearnAboutSenderIdentification> ]
> 
> On Wed, Dec 18, 2024 at 04:19:47PM +0000, Markus Lavin wrote:
> 
>  > Hi,
>  >
>  > I think that I might have misunderstood something fundamental about 
> the BQL
>  > (or possibly Qemu in general).
>  >
>  > I have a custom PCIe device that connects to an outside simulation 
> environment
>  > using Unix domain sockets. To deal with bus-mastering from this outside
>  > environment I have a thread created with qemu_thread_create listening 
> to the
>  > socket.
>  >
>  > If I get a read/write/interrupt request over the socket then the 
> thread should
>  > perform a pci_dma_read/pci_dma_write/msix_notify. Since this is 
> called from
>  > the threads context I assumed I should first grab the BQL. Issuing a 
> bql_lock
>  > from the thread however hangs Qemu.
>  >
>  > Is my thinking flawed?
> 
> The BQL will be already taken for these callbacks higher up in the stack 
> I believe.
> 
> regards
> john
if


