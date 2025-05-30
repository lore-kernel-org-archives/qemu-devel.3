Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 14:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL0vY-0004hy-L9; Fri, 30 May 2025 10:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL0vW-0004gE-OQ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uL0vU-0007KI-Kx
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748616099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvtyvJk7HAoppDHS6ndBXj8icS9cRtiRmRTq3rpAHiw=;
 b=ETAF91jDo1WwTwkiwGqVbCtr029avFSOzY4p+W3wMPiRv+rFQ08aKvMfkAnsW5UBMVWHgN
 ro48cFw2LtIWors9bfmDRu1UU6PfrzLfzT1wGBaPvG4l+mc3FFCbjNX153hfs7i5GdC/v2
 I2g7f6CTCICI3uBOUaBURd83+hBk7Rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-w62XlvOtPxu5BJ43phFklQ-1; Fri, 30 May 2025 10:41:37 -0400
X-MC-Unique: w62XlvOtPxu5BJ43phFklQ-1
X-Mimecast-MFC-AGG-ID: w62XlvOtPxu5BJ43phFklQ_1748616096
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so12648885e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 07:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748616096; x=1749220896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvtyvJk7HAoppDHS6ndBXj8icS9cRtiRmRTq3rpAHiw=;
 b=O4QD11iQXxoDTWSZ1lGQShLyrDpuTmBcX3dGhatU2wMprxtya3ny14KVcx/cKYL9y0
 ItOC95+ovbOLgkb8qdaIFOmDb09KST1fXNxERwcMu61pa2EGoesI/Z+jiXYgd+xDLOCL
 nRSbM+6papiRq4bS4kaunrQSliM3buWgs50aKdGw/ADTejnqVaoQnx77uzhg5V+rHFzN
 WPmd+xzarKkXis83qU28qvxmkZOxNNxZLzcTB90LcGB8Qchy1BSY34OpPQQtanXJL2V+
 rw+LUSJpQrRxh7chifMq7QfQAfoEfOiLdmwx76FN5r/7g9WJ+OiBHs/bwW5pGxTIYx24
 e5OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSZZo1kzKuYnGGGsYytKFhogMDak7pPIxeqhcPxHJPMhYL9H98Px1xdABAaCLLF4/32cqk9z8yTY4/@nongnu.org
X-Gm-Message-State: AOJu0YwkVkcOSj/EDqSdqGuN8uw8H9OjrniEzbNSzYTfVaz9tod9UWKT
 bKwzlHVqpfa3TvZb8xphbFFiFP6uHcLHiHXBNJ2gjK8b36vzDMJwL2XaSn+OzzbCuXAgbKfjouA
 sEgf9/k212dYZmmUYv0Hj59vxiWBRXkVK++91jPNJgSLd8srpU/IgojfQ
X-Gm-Gg: ASbGncsEiQybJMNcBA7fH1CBe6UAc/tRkpnpLCVteleTDxwFeGAX6q7U/LYt97n2u58
 F9MeRJVNqcJ5KbkHW/GOVKuf6r6tO44nnFY26fr7xK3478ZPKjf/W7VUrvzC3zS4jUhMgRahs6/
 AFRmU/5tO7t8f0nNfMAPiSG3fI+teCrML6XsyeeNZbnCfKpWAhkVdhusxYgQbvp3SEKxojSA972
 C32zR0A7Oyp1OCqgJwQHxwAXJdZt1petdcuNynXVTPFoOauB/ywqict1Nw898JbuEHPEczfwo/y
 b+UMuPe1oiWZjis8gAUqSskeQM5Ckxyl
X-Received: by 2002:a05:600c:3f1a:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-450d880a7bamr26014975e9.6.1748616095952; 
 Fri, 30 May 2025 07:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG90qID3E7JdcgyrDBUigUyNJBWgXWph4mz2gGyYdHcW3n1uL9j5/uhNFKk4CJlScjHXdLpfg==
X-Received: by 2002:a05:600c:3f1a:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-450d880a7bamr26014595e9.6.1748616095525; 
 Fri, 30 May 2025 07:41:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009752esm4982231f8f.74.2025.05.30.07.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:41:35 -0700 (PDT)
Date: Fri, 30 May 2025 16:41:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH RFC 0/3] Attempt to add GHES for x86
Message-ID: <20250530164134.6c666b2e@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue,  4 Mar 2025 14:30:55 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Hi Igor,
> 
> This patch series comes after:
>    https://lore.kernel.org/qemu-devel/cover.1740903110.git.mchehab+huawei@kernel.org/
> 
> I'm basically trying to add support for error injection for x86,
> without success so far.
> 
> On x86, the notification mechanism is different: it is via QMP.
> Yet, from what I saw on Linux implementation, it works on
> a similar way to GED. So, I ended implementing a notification
> via GED.

I'd use GED only for microvm.
pc/q35 already have ACPI controller builtin,
so I'd rather use that for hosting hest addr logic and event delivery.


> 
> HEST table build seems to be working OK on it, and the
> error injection notification for x86 is called. Yet, OSPM is not
> receiving any notifications.
> 
> Could you help me figuring out what are the missing bits?
> 
> PS.: there are some things at the code that require polishing,
> plus there are some extra printf() there to help debugging.
> Finally, we would need to add x86 CPU error event at the
> ghes script, but I'd like to have at least something that the 
> OSPM receives before improving it further.
> 
> It can be tested with:
>    $ ./scripts/ghes_inject.py arm
> 
> (Ok, this would be generating an ARM processor event , but
> I guess Linux would at least mark the event as read, even if
> it doesn't recognize it)
> 
> Mauro Carvalho Chehab (3):
>   acpi/ghes: move use_hest_addr out of acpi_build_hest()
>   hw/i186: add support for HEST table with SCI
>   Add a GED device for RAS notification
> 
>  hw/acpi/ghes.c           | 16 ++++-----
>  hw/arm/virt-acpi-build.c | 12 ++++---
>  hw/i386/Kconfig          |  1 +
>  hw/i386/acpi-build.c     | 75 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c             | 41 ++++++++++++++++++++++
>  include/hw/acpi/ghes.h   | 25 +++++++-------
>  include/hw/i386/pc.h     |  5 +++
>  include/hw/i386/x86.h    |  2 ++
>  8 files changed, 153 insertions(+), 24 deletions(-)
> 


