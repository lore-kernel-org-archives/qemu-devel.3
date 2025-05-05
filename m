Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138D2C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpiR-0000dN-9x; Mon, 05 May 2025 02:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpiN-0000ct-27; Mon, 05 May 2025 02:54:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpiL-0008IL-BG; Mon, 05 May 2025 02:54:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fb0f619dso46963865ad.1; 
 Sun, 04 May 2025 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746428047; x=1747032847; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wowGIiiFMeKHVWFux66UfHV+qluA5cEIdlHu8LzfdQg=;
 b=lck9Syj7BBbLDWGjNGztw3Q3ICvhs+UsSg7nqu3WfQQExHsdpfL6VvzI5surqF7eSY
 CS6p5fcwd7sDsA99y3D7fgfVCk3CKnXo50HvzfT817e9ZpvjYkZc5Mn73Ceasko3yhnL
 OYDz7LpuKu5jpv+qDkIdQVshQgit6Hmm0zsbV05PPJvNw5lpAbR8A6TK02P689nJ285M
 ayYGsbPfJ1bnXyVQOFHqY7uLHDUgVBW6DbWnVE5zXCCR5V/71ARR8GdppeOjt+Y1/1S/
 KUC0VVotSieFwZwfaAN+KI2vkppnSyxvfNmXAMW+36lFoh12tJRMbvvK4geo/e/ckHJk
 I9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428047; x=1747032847;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wowGIiiFMeKHVWFux66UfHV+qluA5cEIdlHu8LzfdQg=;
 b=hw3FlVONy0xifNR0A/uuIOWRa06AnZnWgoS5wV0bza6ePl8ho2oaRFWfT9pxvM+rh6
 pdCxrj3blUIj4RGOOiaBlEaLAS0LmrY0ymC/hSAWTq/8JcRuNe/VVNr8sllKsSYQw3li
 t/6y5W12bQRljlrrw5XOMdARx1kv2YL8g81v1afjs03q0FfviRyM79qaVj7jQ72u+5lu
 hLEAXTrbWR27ErRiXx1ZFh3kh38shoLW9KK7n8BoBGD9R77wnabj+mKTTltDUZ1BJssk
 o4ZU6LwjFqUvk3rnpOAzOhDBl/04jFGwwWuycQ/qOBmrmjfsiU16a3wPp9HnD1/Y/lfr
 3CVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9/z/Akzk3wmKGzZm4DrnyE7MyZoZXokrYulHREJwlq7yAaKGR+Q8onaDMQ4TLObtgNjOYG2YUVsD8@nongnu.org,
 AJvYcCWLxUT8BGfIpLd/Tnsua5PMrcz47HaqNhvcgkJo06r6tXQyjjyumMTrQ8r6mEfWGQx6x9UnoUOoIXQ=@nongnu.org,
 AJvYcCXQOhMpt9VrPpp5A9GHcHlg7Wn0AjnJfVtolMWBf4maT5OOY+QZW7P37vqNz6UYpHFL6rCpKrXcbyP36Q==@nongnu.org
X-Gm-Message-State: AOJu0YzVSkZYDBW3ilYH/0EOPJiJlS0EMj/Drpp5HRt4Y3UlOLmEH1Qf
 9g2PebXi/O6nqoDBsx0YqqGbKfWhFnFCrlAO1oe5X2xbbKbGWSS6
X-Gm-Gg: ASbGnctRmL2f5oa/0tvofKfwW/hC9gpt/bTv1puuFXfCyXOyHbeW+eCrP3NnCGqIHy3
 yMo07oh/3drZNedA6jdYn9CWx/lBxt7ozaUpyIYrdxCCvb+TOEke+nXG7cH3rADOwy3IiOJVzbr
 hiQAUGrVsabmlTbmdm6y+HDZbYThgMHINyND1F/YcSEOrzVf8Hkib3LNtVEixK9nIOwOecXfK+3
 zxtm+qUjZgi+RauMw/Q3Rnzreh2hQ9GM7v/m31QshuyRbT7SAf3mJlRJoI030NH07AQKW5XxVBA
 C5UY2VMJrmCwm7o/mgmdnrLIk62fpNur9HUEYONx14E=
X-Google-Smtp-Source: AGHT+IHIwTKIxBwMGz+uNyWfoCcZPsXtcWK37wIoZFCfR6249VuPXOpLsoNA7oKqWrQRkvXenOymhg==
X-Received: by 2002:a17:902:cf0c:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22e1037f483mr165878585ad.47.1746428047111; 
 Sun, 04 May 2025 23:54:07 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151f1affsm47736805ad.106.2025.05.04.23.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:54:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:53:58 +1000
Message-Id: <D9O12L97TFAD.17AXDDOYZ7NQF@gmail.com>
Cc: "Fabiano Rosas" <farosas@suse.de>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "John Snow" <jsnow@redhat.com>, "Laurent Vivier"
 <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-block@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v5 02/11] tests/qtest: Fix virtio msix message endianness
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-3-npiggin@gmail.com>
 <00cf719b-4387-4e48-b9f5-eceb0f58f2e2@daynix.com>
In-Reply-To: <00cf719b-4387-4e48-b9f5-eceb0f58f2e2@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon May 5, 2025 at 3:05 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:04, Nicholas Piggin wrote:
>> msix messages are written to memory in little-endian order, so they
>> should not be byteswapped depending on target endianness, but read
>> as le and converted to host endian by the qtest.
>>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
>>   tests/qtest/libqos/virtio-pci.c        | 6 ++++--
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos=
/virtio-pci-modern.c
>> index f31b3be656d..5dae41e6d74 100644
>> --- a/tests/qtest/libqos/virtio-pci-modern.c
>> +++ b/tests/qtest/libqos/virtio-pci-modern.c
>> @@ -8,6 +8,7 @@
>>    */
>>  =20
>>   #include "qemu/osdep.h"
>> +#include "qemu/bswap.h"
>>   #include "standard-headers/linux/pci_regs.h"
>>   #include "standard-headers/linux/virtio_pci.h"
>>   #include "standard-headers/linux/virtio_config.h"
>> @@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, u=
int32_t msix_entry,
>>           return qpci_msix_pending(dev->pdev, msix_entry);
>>       }
>>  =20
>> -    data =3D qtest_readl(dev->pdev->bus->qts, msix_addr);
>> +    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
>> +    data =3D le32_to_cpu(data);
>>       if (data =3D=3D 0) {
>>           return false;
>>       }
>> diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio=
-pci.c
>> index 102e45b5248..76ea1f45ba9 100644
>> --- a/tests/qtest/libqos/virtio-pci.c
>> +++ b/tests/qtest/libqos/virtio-pci.c
>> @@ -131,7 +131,8 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtio=
Device *d, QVirtQueue *vq)
>>               /* No ISR checking should be done if masked, but read anyw=
ay */
>>               return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
>>           } else {
>> -            data =3D qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr)=
;
>> +            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data,=
 4);
>
> It may be a bit nicer if 4 is replaced with with sizeof(data).

Sure.

Thanks,
Nick

