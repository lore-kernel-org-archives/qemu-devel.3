Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183BC02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 05:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZkOo-0002tu-Aj; Mon, 20 Jan 2025 00:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tZkLc-0002Zy-UZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 00:29:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tZkLb-0006pT-6B
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 00:29:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso27980495e9.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 21:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737350948; x=1737955748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5rAfiZJz+9oEvlJoSXxBPIfjutD28B8EZy7D2WO+Ns=;
 b=bRLa65rLDr3bTZUva9Frx4dym7gpand44f4j82Uu6BpxKcOsTULcjuO7fu7HXCpmRY
 L687HEyiAEO4b1tg0k1RYaZMriM532rZriUCJs52P7R5Zwrrv2VBwDA1y668MAERrjr3
 DO5e6Wp5khzrjBGfBrkf0O58BOwdbzr4yHUz2iW0DLzQvq0uGcbGWHaIPx+nQ8mgWaBA
 wr5tQjLgOVRk4EBDWhq7MbcgnMBLRIxiK60eGoeFjDq+OYNuzFlfza/JpRtpLrn8NZ4q
 y9WS9hf/fp4HJulEY4UeZpSgnHAqdKSYKKNlIPuax6brtGDpow0pMYo5r9zfuR6hqppZ
 ItbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737350948; x=1737955748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c5rAfiZJz+9oEvlJoSXxBPIfjutD28B8EZy7D2WO+Ns=;
 b=q+jNP+Ti8mq+ZH74rKKBCjsFZUTo1yYoKhWEzMwNJEq4TMUPcatqLJcTN4fxPVWsKl
 B9KpvIxMbhNcozbOq5MP+2JEjU7F3Qmb1cloWNLySRgLdcR1MHBHEWcjQgqA3GYJEYvR
 uDh3BTHImdNEc0SKh5GYEcR26P5r3okkltmNCu8ixwTmwqt15JaiPtZmQJaSwRIAGcFz
 n2dNWTWwVoakgB+I0whrW6ggmBLJsIMFYyBn8wvr0uMlsTZwAXoNz1rP9je5P+NEBKr1
 UZW9MzMs/7911rcuEeqHS50jAkqGmNAOA79fVsTWpxWCQe475WHTD2yutV1SPnhbuPUb
 u63A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNW8Mx3reLucXu4twpmdkOTFTxT1kf0zXgQ6M/OGIxAlWsfaeHS3jbNtVhJYIs2OSxRDJIjD8L6XmV@nongnu.org
X-Gm-Message-State: AOJu0Yygc47d1fNOHpE7cln4WW+TEQKyMqANS2dn8bY2Mm1MbsPZEFtT
 OD02ZWlv+3YXLbn6KpAO10CL6bQ+BK62cpEiq9U5KUY4kUlDS2og8C9Tgu9cMoZcOlqsN8cSTrk
 2E/U=
X-Gm-Gg: ASbGncsbvNHpvDqi1IrPafz7Sla8cMfqmLQRAVwyQ1tM6gbvoweOsszCTOLR5m6FFUj
 KeMn6oPuOaCDWEiQVZzR6pzX7jQGlYYxp+dpqvVee6mE4J3zLI838nta0ivfvgFoXpLqUOsC478
 DQFwVUabTOsNuLxBLkMYMhD95KYkw3L8dQ3vUtTLIaKen2SvMeGn5u1Dq0QefbqypuzWcBalRD3
 clmVcNZUR9kIM0nZ2MA5O4GYQoue9A68dNSjsKwJlOygOtkFFCP2HINAec+4gsgq0nhEq5OYmDw
 NAY5PZ6Q1M8/km/1GDoSVGqP9ZmmUGA8nLFc+Q==
X-Google-Smtp-Source: AGHT+IF0GPfjd8bIW6bmq7/U5eWQ84xO0CCqrhisRqpAGZfZoGhRmXA0Y9vXYPpEbnCnKr3PbeWcNA==
X-Received: by 2002:a05:600c:3b94:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438913e02f8mr127283675e9.16.1737350948485; 
 Sun, 19 Jan 2025 21:29:08 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041fe29sm123825645e9.22.2025.01.19.21.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2025 21:29:07 -0800 (PST)
Message-ID: <0584eb66-ab11-40ab-bf97-64299eaab52d@linaro.org>
Date: Mon, 20 Jan 2025 06:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] qtest/libqos/pci: Enforce balanced iomap/unmap
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20250117172244.406206-1-npiggin@gmail.com>
 <20250117172244.406206-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117172244.406206-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Nick,

Only nitpicking comments...

On 17/1/25 18:22, Nicholas Piggin wrote:
> Add assertions to ensure a BAR is not mapped twice, and only
> previously mapped BARs are unmapped. This can help catch some
> bugs.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/qtest/libqos/ahci.h       |  1 +
>   tests/qtest/libqos/pci.h        |  2 ++
>   tests/qtest/libqos/virtio-pci.h |  1 +
>   tests/qtest/ahci-test.c         |  2 ++
>   tests/qtest/libqos/ahci.c       |  6 ++++++
>   tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
>   tests/qtest/libqos/virtio-pci.c |  6 +++++-
>   7 files changed, 48 insertions(+), 2 deletions(-)

Maybe put the AHCI fix in a preliminary patch?

> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index 83896145235..9dc82ea723a 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h

Consider using a definition rather than a magic value:

   #define PCI_BAR_COUNT 6

> @@ -65,6 +65,8 @@ struct QPCIDevice
>   {
>       QPCIBus *bus;
>       int devfn;
> +    bool bars_mapped[6];
> +    QPCIBar bars[6];


> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index a59197b9922..05089a5f24f 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -93,12 +93,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
>   {
>       uint16_t vendor_id, device_id;
> +    int i;
>   
>       qpci_device_set(dev, bus, addr->devfn);
>       vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>       device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>       g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
>       g_assert(!addr->device_id || device_id == addr->device_id);
> +
> +    for (i = 0; i < 6; i++) {
> +        g_assert(!dev->bars_mapped[i]);
> +    }
>   }


> @@ -572,12 +579,35 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>       }
>   
>       bar.addr = loc;
> +
> +    dev->bars_mapped[barno] = true;
> +    dev->bars[barno] = bar;
> +
>       return bar;
>   }
>   
>   void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
>   {
> -    /* FIXME */
> +    static const int bar_reg_map[] = {
> +        PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
> +        PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
> +    };
> +    int bar_reg;
> +    int i;
> +
> +    for (i = 0; i < 6; i++) {
> +        if (!dev->bars_mapped[i]) {
> +            continue;
> +        }
> +        if (dev->bars[i].addr == bar.addr) {
> +            dev->bars_mapped[i] = false;
> +            bar_reg = bar_reg_map[i];
> +            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
> +            /* FIXME: the address space is leaked */
> +            return;
> +        }
> +    }
> +    g_assert_not_reached();
>   }
Regards,

Phil.

