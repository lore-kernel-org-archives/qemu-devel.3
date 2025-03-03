Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C729C282D2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Je-000214-GW; Mon, 03 Mar 2025 08:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tp0QJ-0006pi-D3
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 02:41:11 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tp0QF-0002QY-RN
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 02:41:10 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so1028256a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 23:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740987666; x=1741592466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzWTMkuidDSJBz3N4EE+4LYbLVxTUm8uWWig8vVQknw=;
 b=iFeyewre5ZN4h2qh35TC+ewQvsgsEwjAWzHYqE3B0c+RR9g+6fNfD7ygXSUh0SSybh
 i7globyLEVpyguCJdl0QXyUQv4LEK4QrfAgNhVDP17UvcuTT6Vz7GWj84QvE+9sz/D4r
 ySlejg9IkYXmSFZclcGwG6ypWDPDDZHGrQt/Ws/zcngUOwlEYARhm8GctaxBSJtQCR2c
 DKIKriJltGc6h5ExW49ORkr54uJHyxmHxZbuudNY+/5o+7syp1KXwdjcRfzt5GZyi3Us
 Wt3eylxQWNeVyhBz2Z78um3xxcyqyh/ThpE9Bmqj9jIt+dQgC7YLhTj435YuJJ0jkSWs
 My1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740987666; x=1741592466;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KzWTMkuidDSJBz3N4EE+4LYbLVxTUm8uWWig8vVQknw=;
 b=f3aLcQkc0N1GgyWl8OIRkGUythPnjUWy0jVnTlLc0dje7N1J0Pv9b1qX1UMqd9nhuO
 W8zgPNYDPXfh43db2hMKTb51mOzTIu8feHfwfO6xt8lBu8sCAw6j2GDxln61+GElnvMt
 IC2+0mLi3mvU0Z8DPXYgkD2LNnGJ6OtuMHfu3omkyBYDYqBmbUX3Qbse6kWpoRD8B3d3
 MD/EwolqgdJja6MDWT8ekKjOHxc0S+sQ1TlovI/ch9wzmLkCvHGTv1JKDNEvkAWoZA/f
 8hrHvekBTLmBl9H62+c+fmTfDyN45nFJMLTeYnRT4a271oBIpRR2vz3H+Nb3qIgDo1vl
 5sSQ==
X-Gm-Message-State: AOJu0YwYrFo+qDil3NO7vNN1yLmTTPpR/GkhCi+Ai03vYfA+62ED5sVQ
 FBkjkSV0T+PAlMlGdAMmuN+q7ADgTwyTAArs+uAsq2WIFVa9gTAS
X-Gm-Gg: ASbGncsmPcjc6tHhIRzrAGNoPUPklPW0Mo7JHHrktNh9QqRuf1f9yvp4DXaIK3xZStO
 /fkI2QjIZ71kEUzk7AFX/UaUWPzNSiGw1efTv/zdHRuYZW++gX/2OoN4CMh9FZksK3CWHQUdQEb
 1YruMKUaJ+vEtFRtpczOJtPwQauz8IH96i+wEjkZpGZThEk52yX8Mn+WDr5Ai+PBrDExh6GkLmz
 qZlnHHKiGqHnfx48JAPST134PBhHAaCbF84nEhvMXzS5FwRF4wgjgBgM2ILlrst6hKjaciWcG2g
 ClJJN+Py0DYd+SsvQ9H27LZlhB0vmOHgAQLkEGPIprmFqf2nurFv+OwMfg==
X-Google-Smtp-Source: AGHT+IH6GSo4OkaceH9oHhGgJ1b5hitNJqKtkFwoRwWErWt5KiL4s6652psHE1uFBT1l3Kt/JLKB3A==
X-Received: by 2002:a17:90b:4ac6:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2febabdcc28mr18419061a91.25.1740987665888; 
 Sun, 02 Mar 2025 23:41:05 -0800 (PST)
Received: from [101.5.20.87] ([101.5.20.87]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67530d0sm8268546a91.10.2025.03.02.23.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Mar 2025 23:41:05 -0800 (PST)
Message-ID: <ea7e1e88-d627-4230-8a6c-5aefbbb3bbef@gmail.com>
Date: Mon, 3 Mar 2025 15:41:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-pci: fix memory leak from device realization
 failure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <7702b335-6e92-47c7-baf9-a384f75a0db3@gmail.com>
 <69cb6f19-d87a-4ddf-9fca-612b30828679@gmail.com>
 <c6bf97bf-df26-495d-9886-dfda55cc99db@linaro.org>
Cc: qemu-devel@nongnu.org
From: Zheng Huang <hz1624917200@gmail.com>
In-Reply-To: <c6bf97bf-df26-495d-9886-dfda55cc99db@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Mar 2025 08:58:40 -0500
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


Hi Philippe,

On 2025/2/28 17:24, Philippe Mathieu-Daudé wrote:
> Hi Zheng,
> 
> On 28/2/25 06:03, Zheng Huang wrote:
>> This commit adds failback routine for `virtio_pci_realize` to
>> fix the memory leak of an address space and the virtio-net device object.
>> If the realization of the device failed, the address space should be
>> destroyed too.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2845
>>
>> Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
>>
>> ---
>>   hw/virtio/virtio-pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index c773a9130c..4b0d8cd90a 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2266,6 +2266,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>>       virtio_pci_bus_new(&proxy->bus, sizeof(proxy->bus), proxy);
>>       if (k->realize) {
>>           k->realize(proxy, errp);
>> +        if (*errp) {
>> +            address_space_destroy(&proxy->modern_cfg_mem_as);
>> +        }
>>       }
>>   }
>>   
> 
> I think instead we want to add an instance_init in virtio_pci_class_init
> and move the address_space_init call from virtio_pci_realize there.
> 
> Regards,
> 
> Phil.

I have reviewed the relevant code again and found that if address_space_init
is moved into instance_init, it will not be able to take follow-up actions
such as free the AS if device realization failed, thus failing to address the
issue. Additionally, I referred to the code for AS initialization and
destruction in other devices and found that they are managed in device
realize and unrealize handlers. Therefore, I still believe the previous
approach is a better choice.

If there are other potential solutions or considerations that I might have
missed, please let me know. I'm looking forward to hearing your thoughts!

Best regards,

Zheng.

