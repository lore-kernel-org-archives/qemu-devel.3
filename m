Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA474C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lZB-0000ku-12; Tue, 29 Apr 2025 10:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lZ8-0000gg-Bj
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lZ6-0005VP-5M
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so4454153f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935442; x=1746540242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FT0gPLQIqFJdu7Hw3NeG3OeUiKS5i9v7i7fGQgOfr6I=;
 b=HbmVZIJmYRCJv8cfN22MD6JL2ZdmMVKLI8hhZ3LDqT6rR+HIhpcMig4/GBzcwQze8E
 BVPW1a1fclm1OH+lUhsY85zC/5iQch5wZt6DlMEOaYMTdyJe2zBaeL5K5l6+meCkQ9HK
 K4MiI89PqJqeDsN2ojwLI7PyZtgp/YDN1482aWHl/zXuaQJbxtOVrwz87bTHkcN6yoDK
 Y2GsNoYP99K2I7uqCUp0p3MPUBYz7sD+r5tfnDv1ECFvKqxrLmlpc6JM+dQKyP4O9K1b
 v7JZ3/aKzCMLBEruP8GBnOJvZiKMQhEnOovZOuqT45jKs7F0LFCWlLHkjKMGuiFKAbZv
 sLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935442; x=1746540242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FT0gPLQIqFJdu7Hw3NeG3OeUiKS5i9v7i7fGQgOfr6I=;
 b=GmM9oT909s58bIqIdSBrc5eKtEPP9XwT/CVKDHgWuuKHE8MX59OhUvC02y/s+OBZUe
 tJcb9schtUdAdyPcQJmKBaD+Irs4o3gjzgRER92Nbx+hCp0ioSPBpQZxBsGXjmZX6w/q
 UUdILExdkV2KLPhP8u4LQmn7H1ydZC6PI08KXFlfCNqBHAHLXYZe/RsaHRJBs5qds5EX
 8bouBLVbbLiRUNBL+ATsso/QOg5BwqUdZal2zJuTWX/BjMBWpJNoTv8xN/Q8qRRby31Q
 IpCqkvCjoI6Awow6y030k/LIUpZ/bLiaA5CoQ6EniiNl4cnfuczgz8ILUKBM6OWTiv/B
 E7RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeNXBIJZA33ybicCwTOFcWLly+iiqef+Nm/uUtk1U1zowTquwW7CoHcMD4hZQxZWkV2IThJaN0A6Ou@nongnu.org
X-Gm-Message-State: AOJu0Yyc20uWO0OiLlHwqIextAvfiz76PIom8IFkuQ6SEc5XMXQSiD+3
 UWArIlnxF2oTJzZscmgM0RlpLc6NxGzlwp+1jKonrh7UxW9Jhd1Wf0xieMkv5+I=
X-Gm-Gg: ASbGncuSj9MeWyUh9GM4wzkjpPgUgzptdWuGTeAYXQ2pZ7eE2SSBGDKW/wgkNyfSHE0
 hY7q3n8fUvMEZI2WjkItrsW1Hc/XeoinHDZ1jYiPy8x5VyWaUrP97HgeSAEQlZw/S/rJXVJjAS1
 fYSZCVh/Zb7Af2hG4u5aVbM636RTVPksVprkGsO23M099TfGCJMXb7AnpWD0vjuAtaE+1IPnpEU
 ygCicnloi73nrhOJwI6MnMd3qq5YtpGzON/DtQKF1bLRJDA5/lRQoMewjjYoJ0Nb76PObiiCTo0
 6TRljPOcvV9sNg0BN486vV1y3ev7w+9FUNVn9VJyK5h19bjDMukmx9GcRewyJIsE9A99YKdO1Cq
 WNMK3EMIUuLMVOg==
X-Google-Smtp-Source: AGHT+IHKWviWj1SVyRhQRBjDuKWyufcaz27b3V2byv8zWr4US6lBNzLHYwBHjxwEGVqHGGfBPfaL4w==
X-Received: by 2002:a05:6000:290a:b0:3a0:8098:b6c with SMTP id
 ffacd0b85a97d-3a080980c45mr8068682f8f.14.1745935441993; 
 Tue, 29 Apr 2025 07:04:01 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedf4sm13859222f8f.45.2025.04.29.07.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 07:04:01 -0700 (PDT)
Message-ID: <a8f9d877-edf1-4cad-8e1e-6c8f9f10ec81@linaro.org>
Date: Tue, 29 Apr 2025 16:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
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
 <20250115232247.30364-18-philmd@linaro.org>
 <774d37cb-0dca-4a38-9285-16e180dc0c24@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <774d37cb-0dca-4a38-9285-16e180dc0c24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/1/25 10:21, Thomas Huth wrote:
> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>> PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
>> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
>> We removed all machines using that array, lets remove all the
>> code around PVSCSI_COMPAT_DISABLE_PCIE_BIT.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/scsi/vmw_pvscsi.c | 44 ++++++++------------------------------------
>>   1 file changed, 8 insertions(+), 36 deletions(-)


>> @@ -1228,21 +1219,8 @@ pvscsi_post_load(void *opaque, int version_id)
>>       return 0;
>>   }
>> -static bool pvscsi_vmstate_need_pcie_device(void *opaque)
>> -{
>> -    PVSCSIState *s = PVSCSI(opaque);
>> -
>> -    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
>> -}
>> -
>> -static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
>> -{
>> -    return !pvscsi_vmstate_need_pcie_device(opaque);
>> -}
>> -
>>   static const VMStateDescription vmstate_pvscsi_pcie_device = {
>>       .name = "pvscsi/pcie",
>> -    .needed = pvscsi_vmstate_need_pcie_device,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
>>           VMSTATE_END_OF_LIST()
>> @@ -1256,9 +1234,8 @@ static const VMStateDescription vmstate_pvscsi = {
>>       .pre_save = pvscsi_pre_save,
>>       .post_load = pvscsi_post_load,
>>       .fields = (const VMStateField[]) {
>> -        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
>> -                            pvscsi_vmstate_test_pci_device, 0,
>> -                            vmstate_pci_device, PCIDevice),
>> +        VMSTATE_STRUCT(parent_obj, PVSCSIState, 0,
>> +                       vmstate_pci_device, PCIDevice),
> 
> I think this is wrong, too. pvscsi_vmstate_test_pci_device() should 
> return false for modern machines, so this should be removed instead?

You are correct, good catch!


