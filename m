Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172B7C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBoWk-0008Bf-Kh; Mon, 05 May 2025 01:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoWi-0008Aj-9P
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:38:04 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoWe-0000E1-0O
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:38:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so3562103b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746423478; x=1747028278;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIPJJls1S1//pR3moNNKF485vDygVJfVyoEewZxgwGE=;
 b=JpCFDKSebxVWAhLTmB+Ji+1mwi0ZQ9my4ZreSmUCYpop+wV020ywy/znNnoHtCtcPp
 dSeXCzjEy0LMxDpF7S+sCA9G33a4kp3CgrR5S8vKfajS5t6r/gEQgHVyWl/ZO1T4Z72p
 Yq1V02nFHHoDtiUUGJL0D4vZcYghCh+BSNrI0dE2YUCTGx4OiPSeaf6e+hYzrFKrQTxd
 hJxNxoEuOWqlXL8slqdXRl9mYj4HQO5NZLkk/3kP2DSmuMHbShbqd+sF9JEbToz+ad+Q
 w41Jkyd8FUVCoi8P86e/8REbQ8r37hCL69U1Wf2lcQMFjOLsE/DnLT3oL4xL/fLUzYtq
 iQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746423478; x=1747028278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIPJJls1S1//pR3moNNKF485vDygVJfVyoEewZxgwGE=;
 b=qIZ0NWoATSGbkFzlEuoMQ+6VX450AfwbN2/Dfv1lvj2UXubBkr72Rg6Pvy5KqsAOUo
 +uyUIQk/MnD2EVbp746jdStj/nIVIH2jSW8ddy8tN1dc2MGVqP8M0zcwNc1a2SN2rE4U
 SJpAdZx02Hx6urfpq+AwGy34LLfOZzHUMiQS4mYtMxNKP/NFlCo3d7EQgrEpfqal61tV
 CuuxBRsiW+7lslOkpfZoaUvLxuZ76JXeZxrpjlPMldpgkKIuzQnd+GvST1rzVs6YyiRk
 2QgRAdlmlidzZeawlSMJc4RbZE8HN19+TJQCSMT9nRzEQFymtrmyc2dwBMqdpKYVQZmm
 YkxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuMKJNGLPI0Ibo1AnGiLwiEmWNhETU3IZyeE09g1PKCJd1dJ6AnfduTKm9oWoe8+I53aHvJzTlAW41@nongnu.org
X-Gm-Message-State: AOJu0YzGsZDywokU6ogGkjFeqRtI50/KToJOb6mZ5h5FuLdiAXhoajc1
 hCyhVuYdcxkjBKzgdttE7OXVKYCBEe7N5zo0pEo+lolf5WMtOYPzyXWDB6bi5B8=
X-Gm-Gg: ASbGncsqz9bhMFXeCqpZfj1x7tWbOsA3bPZ8+gtqiocV1i/3272DRwzW7dFtn5ng/ki
 n1hiKHvbP84LOhKbxSZxiQHxpcNQxxe0/N1SIubUZPweGX3FnjmnWQrbpdCvec8MbU35H7xq5iM
 Or2NnUs+HW5xQiYnqdM1RUEznxR9/X762vhl4eQYsUCHIHxvpZThr46wYE/4qeYKaaT5byLKz8f
 xXP8QM5va+C9875fxmbIxgvRjetOAT4mnpasmhmHehbB/kjOeNwDWJZyoY0zIMbCU8T2jpjrqzS
 q37yGOMMpASloyHTcwGOiNKQvzi4gA/1ApI1KVAnsM53bH8LSBU=
X-Google-Smtp-Source: AGHT+IFKtmDo+eHTfZHhhUxCn88Wo9wtEk7nBeXRgzVrUqmsiq20p8rSpG89NZEecJ1nKnz4G9wBLQ==
X-Received: by 2002:aa7:9a84:0:b0:736:3979:369e with SMTP id
 d2e1a72fcca58-7406f0b0e9fmr8005819b3a.9.1746423478058; 
 Sun, 04 May 2025 22:37:58 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a225sm5826612b3a.23.2025.05.04.22.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:37:57 -0700 (PDT)
Message-ID: <e9af660f-713a-4bc4-889d-f619e91c01d8@daynix.com>
Date: Mon, 5 May 2025 14:37:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] tests/qtest: Add libqos function for testing
 msix interrupt status
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-4-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502030446.88310-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/02 12:04, Nicholas Piggin wrote:
> This function is duplicated 3 times, with more potential future users.
> Factor it into libqos, using qtest_memset instead of qtest_writel to
> clear the message just because that looks nicer with the qtest_memread
> used to read it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/pci.h               |  2 ++
>   tests/qtest/libqos/pci.c               | 48 ++++++++++++++++++++++++++
>   tests/qtest/libqos/virtio-pci-modern.c | 31 +++--------------
>   tests/qtest/libqos/virtio-pci.c        | 40 ++++-----------------
>   4 files changed, 62 insertions(+), 59 deletions(-)
> 
> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index 83896145235..9f8f154c301 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h
> @@ -92,6 +92,8 @@ void qpci_msix_enable(QPCIDevice *dev);
>   void qpci_msix_disable(QPCIDevice *dev);
>   bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
>   bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
> +bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
> +                              uint64_t msix_addr, uint32_t msix_data);
>   uint16_t qpci_msix_table_size(QPCIDevice *dev);
>   
>   uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index a59197b9922..773fd1fb6cf 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -351,6 +351,54 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
>       }
>   }
>   
> +/**
> + * qpci_msix_test_interrupt - test whether msix interrupt has been raised

Nitpick: Let's write as "MSI-X" instead of msix in documentation.

> + * @dev: PCI device
> + * @msix_entry: msix entry to test
> + * @msix_addr: address of msix message

Perhaps deriving the address in this function may make things simpler by 
removing the documentation and assertion code and not requiring callers 
to pass it.

> + * @msix_data: expected msix message payload
> + *
> + * This tests whether the msix source has raised an interrupt. If the msix

Another nitpick: "whether the device has raised an MSI-X interrupt" - 
"msix source" is not a pharsed used elsewhere and it can raise other 
kind of interrupts too so let's make the kind of interrupt specific.

> + * entry is masked, it tests the pending bit array for a pending message
> + * and @msix_addr and @msix_data need not be supplied. If the entry is not
> + * masked, it tests the address for corresponding data to see if the interrupt
> + * fired.
> + *
> + * Note that this does not lower the interrupt, however it does clear the
> + * msix message address to 0 if it is found set. This must be called with
> + * the msix address memory containing either 0 or the value of data, otherwise
> + * it will assert on incorrect message.
> + */
> +bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
> +                              uint64_t msix_addr, uint32_t msix_data)
> +{
> +    uint32_t data;
> +
> +    g_assert(dev->msix_enabled);
> +    g_assert_cmpint(msix_entry, !=, -1);
> +
> +    if (qpci_msix_masked(dev, msix_entry)) {
> +        /* No ISR checking should be done if masked, but read anyway */
> +        return qpci_msix_pending(dev, msix_entry);
> +    }
> +
> +    g_assert_cmpint(msix_addr, !=, 0);
> +    g_assert_cmpint(msix_data, !=, 0);
> +
> +    /* msix payload is written in little-endian format */
> +    qtest_memread(dev->bus->qts, msix_addr, &data, 4);
> +    data = le32_to_cpu(data);
> +    if (data == 0) {
> +        return false;
> +    }
> +
> +    /* got a message, ensure it matches expected value then clear it. */
> +    g_assert_cmphex(data, ==, msix_data);
> +    qtest_memset(dev->bus->qts, msix_addr, 0, 4);
> +
> +    return true;
> +}
> +
>   uint16_t qpci_msix_table_size(QPCIDevice *dev)
>   {
>       uint8_t addr;
> diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
> index 5dae41e6d74..0d7d89bbcb1 100644
> --- a/tests/qtest/libqos/virtio-pci-modern.c
> +++ b/tests/qtest/libqos/virtio-pci-modern.c
> @@ -126,28 +126,6 @@ static void set_status(QVirtioDevice *d, uint8_t status)
>                             status);
>   }
>   
> -static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
> -                            uint32_t msix_addr, uint32_t msix_data)
> -{
> -    uint32_t data;
> -
> -    g_assert_cmpint(msix_entry, !=, -1);
> -    if (qpci_msix_masked(dev->pdev, msix_entry)) {
> -        /* No ISR checking should be done if masked, but read anyway */
> -        return qpci_msix_pending(dev->pdev, msix_entry);
> -    }
> -
> -    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
> -    data = le32_to_cpu(data);
> -    if (data == 0) {
> -        return false;
> -    }
> -    /* got a message, ensure it matches expected value then clear it. */
> -    g_assert_cmphex(data, ==, msix_data);
> -    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
> -    return true;
> -}
> -
>   static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>   {
>       QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
> @@ -155,8 +133,8 @@ static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>       if (dev->pdev->msix_enabled) {
>           QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
>   
> -        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
> -                               vqpci->msix_data);
> +        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
> +                                        vqpci->msix_addr, vqpci->msix_data);
>       }
>   
>       return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
> @@ -167,8 +145,9 @@ static bool get_config_isr_status(QVirtioDevice *d)
>       QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
>   
>       if (dev->pdev->msix_enabled) {
> -        return get_msix_status(dev, dev->config_msix_entry,
> -                               dev->config_msix_addr, dev->config_msix_data);
> +        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
> +                                        dev->config_msix_addr,
> +                                        dev->config_msix_data);
>       }
>   
>       return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
> diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
> index 76ea1f45ba9..ea8114e2438 100644
> --- a/tests/qtest/libqos/virtio-pci.c
> +++ b/tests/qtest/libqos/virtio-pci.c
> @@ -122,25 +122,12 @@ static void qvirtio_pci_set_status(QVirtioDevice *d, uint8_t status)
>   static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>   {
>       QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
> -    QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
> -    uint32_t data;
>   
>       if (dev->pdev->msix_enabled) {
> -        g_assert_cmpint(vqpci->msix_entry, !=, -1);
> -        if (qpci_msix_masked(dev->pdev, vqpci->msix_entry)) {
> -            /* No ISR checking should be done if masked, but read anyway */
> -            return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
> -        } else {
> -            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
> -            data = le32_to_cpu(data);
> -            if (data == 0) {
> -                return false;
> -            }
> -            /* got a message, ensure it matches expected value then clear it. */
> -            g_assert_cmphex(data, ==, vqpci->msix_data);
> -            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
> -            return true;
> -        }
> +        QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
> +
> +        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
> +                                        vqpci->msix_addr, vqpci->msix_data);
>       } else {
>           return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
>       }
> @@ -149,24 +136,11 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
>   static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
>   {
>       QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
> -    uint32_t data;
>   
>       if (dev->pdev->msix_enabled) {
> -        g_assert_cmpint(dev->config_msix_entry, !=, -1);
> -        if (qpci_msix_masked(dev->pdev, dev->config_msix_entry)) {
> -            /* No ISR checking should be done if masked, but read anyway */
> -            return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
> -        } else {
> -            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
> -            data = le32_to_cpu(data);
> -            if (data == 0) {
> -                return false;
> -            }
> -            /* got a message, ensure it matches expected value then clear it. */
> -            g_assert_cmphex(data, ==, dev->config_msix_data);
> -            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
> -            return true;
> -        }
> +        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
> +                                        dev->config_msix_addr,
> +                                        dev->config_msix_data);
>       } else {
>           return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
>       }


