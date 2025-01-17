Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9F9C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpSE-0001bR-8F; Fri, 17 Jan 2025 11:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpS8-0001au-9t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:44:12 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpRx-0000Q8-NE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:44:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38637614567so1165396f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132239; x=1737737039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RGQEicfXp8ygk7BdiCeHtgatykjkNeKCo54KXBZR0dg=;
 b=GHuIO33fylfv6aDqedrLzqBJQDSHx6ADmHk9J8xB9qlrs550T3nAgcVIK+i3/6Cr3J
 VHj63GzR8WEJ9wu94v9qcR/e+Wo5S1ry9paRi0GiyPDk0Ta5xdwEOIR2Og6plR+hEZ6m
 S3JtxDDlVTohqCCxB0vlOKqMJpqkZiJsDLeWU5ZEXqpRDPvjyN65T3PB9gJeK//EZooF
 YT+Cs47y4VRTi/q6UvS+CY2W9OMHG+IkfmSipZFGQeXY6psoP1NyD3U0SH6ZGK5DRUCI
 LY1rjNGOek/05S3OEHFwbouwarci30coekTxMWMvAxvkfSlf7SIYYed9uX97Sqo0RQ06
 nDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132239; x=1737737039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RGQEicfXp8ygk7BdiCeHtgatykjkNeKCo54KXBZR0dg=;
 b=Q1KkxnJStNGgTNwfR6ShDo7PBTJM4JeIzk7NCCW/X3vzTSj5helpqvvYyaztGjAZGd
 9H3bKhsLHsdINEblYwJbZjGt9VXdZ83MVoeWp/vZvKk1cnPwswMRijxC9kGCp8XO3XNE
 HgrL6t1V/KwwCrKO+CHqzW2HVKDjecGW1u7I2E2adBP4po5avrTz9OgcGQRUBdanfs3Q
 Oq72rDOWccfhZceQA3iE72QUokjyGIIDtE9dGpAUJPs39XcAj99lRI64BC17BGKdasjV
 bXDbaT+jSmA5Xsoekm1cLX7D2ZePZakhHwRXq+esvv+a2uLGB3lb6lS2MEKRRDM8o7Dw
 ckaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzFJkj5CIwglAKc9V0stlSuJp4DFSTZ+92TIJabLmgZtYaD6eVNUOMm3W9IsjpnD1yKPOi7yxTxtHV@nongnu.org
X-Gm-Message-State: AOJu0YxYjFUGebcGKbz8F+U6BHAAKWh27i3fj1LAVx+elKUfRFyka7UF
 0uS8BxZkkWDIUcB71ADE0S/1jySkhafpCDOD5vooilaY7CRw1bgoNeT1npkN/QU=
X-Gm-Gg: ASbGnctRLNs/L3E+Uhm2IWhViw2q3aY0BnBnivzIKsHWdagWYtnagIjfzBDasTd4+8M
 hBh8lWxguD43GHIFmu4D7A4eALo2sO1zAzLxzRzQzbsyyzgPb8D9pC7nuCouzFw4fF92LRltfw1
 qIjHCU0l/wi7WPQpQREJi/X/pGPA6JsybiCmKrMrPZ9mP6KseLcsZSRAoMTh/2Bdl9we1XiexUN
 2Zp6gUr5z41tg2XkdY2a7KuF4XGnDHcIhAdKI2dmF/63gwcT3mznQNw9pet+6rS5L6TCw4lkhGg
 wwiGjFv5JuQ6qMvsdhp3IqMV
X-Google-Smtp-Source: AGHT+IGyeriFfiMpWkosQkpamef/d0uqOyfcvgvNpfJb5GwKg52Dq79dC/6WHGy5tFZDt2EVuG6d8A==
X-Received: by 2002:adf:a113:0:b0:38a:8d4c:aad3 with SMTP id
 ffacd0b85a97d-38bf5664d6bmr2555645f8f.18.1737132239472; 
 Fri, 17 Jan 2025 08:43:59 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm100140285e9.20.2025.01.17.08.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:43:58 -0800 (PST)
Message-ID: <6b916259-da1a-4a16-84a3-64eb466714c8@linaro.org>
Date: Fri, 17 Jan 2025 17:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-11-philmd@linaro.org>
 <aa863f22-57fb-4ddd-bce4-1b0a86c9023b@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aa863f22-57fb-4ddd-bce4-1b0a86c9023b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/1/25 10:08, Thomas Huth wrote:
> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>> VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the
>> hw_compat_2_4[] array, via the 'x-disable-pcie=false'
>> property. We removed all machines using that array,
>> lets remove all the code around VIRTIO_PCI_FLAG_DISABLE_PCIE.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/virtio/virtio-pci.h | 4 ----
>>   hw/virtio/virtio-pci.c         | 5 +----
>>   2 files changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/ 
>> virtio-pci.h
>> index dd6eb9a4fc7..1ca7419cd43 100644
>> --- a/include/hw/virtio/virtio-pci.h
>> +++ b/include/hw/virtio/virtio-pci.h
>> @@ -33,7 +33,6 @@ enum {
>>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>> -    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>>       VIRTIO_PCI_FLAG_ATS_BIT,
>>       VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
> 
> I assume it's ok that the other following bits change their value here?

I followed previous commit 9a4c0e220d8 ("hw/virtio-pci:
fix virtio behaviour"):

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index e4548c2f970..25fbf8a375d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -61,8 +61,6 @@ typedef struct VirtioBusClass VirtioPCIBusClass;
  enum {
      VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
      VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
-    VIRTIO_PCI_FLAG_DISABLE_LEGACY_BIT,
-    VIRTIO_PCI_FLAG_DISABLE_MODERN_BIT,
      VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
      VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,

> 
> If so:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

