Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E0C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuMH-0002hT-V4; Fri, 02 Aug 2024 11:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZuMF-0002cQ-La
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:38:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZuMD-0008Er-Pj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:38:19 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cfec641429so1346571a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722613096; x=1723217896;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvVqhJ5uHFLEigCD/TzNoXXOOiaeOSex1l3cjIzyF+s=;
 b=qo+qJysZ9o7w4RWUIfvp4DhL7jGSL6AtTcRs6T1Y1zfP2zju8lg2KVAv2wJoyfBser
 eS2a3BN5vgzEWQFhnLtKIvAADEve8GGD6NQIKjJotghc4k7C0U0GuzcxQCMuQue04Fqt
 AHsQlt1wS4D+EFE/gS2z5QQCBaC9KUBNMRii6/F0QEi77KuRim1fWKrLq7BCt6VapVfq
 eemegDiVWqS3DjssRj5FaqSzdufe3V5WqnsPr+7QApSr192q1WpbiIc5sHJbXPlc+jGM
 Gaj4wF3hJZWA+DtUCC7OlbfgUKTbXHVdv4qmstk8HXUspzgMkTdcfq3GjpYORpYVTJ7j
 Mo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722613096; x=1723217896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvVqhJ5uHFLEigCD/TzNoXXOOiaeOSex1l3cjIzyF+s=;
 b=PimkfMjWPyROsDkI9fAVTbre69yr5ium+etu4La3WVfffKa+cqAupTAS+xjXcHUt6M
 JtCKRoqWuQa6A8dAogjFwJhPoAns0/WtcjXWbsCA91TEIs3aRSjz6rJfpXDVEM+WnuAw
 iKn9nr87unofRI+hsvRaI73Vyx8qzMj+J9d62thEJpjRjd9hE3RbBK/O9me84O2hWm2X
 4KZ+AJ8db5UsZTH5CqQGZSQVsANFNS5Qhhb0wAGbkOebbGMKTPaI+yprXpsJ1J1TR2mE
 qagNHI3nZWfvV9cDDfjjs5BDg+R4y2XV3yJnV32Y3T5Wp/l26q+vkJUUuq0AU8twl1eU
 TtSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJvp6ovW1+UlRwsvWnyyC7ioH8nZNyjMjzJm3aSr0AtYPSswd5G25JPEr4QjHywXRNLLpRn2ptP2RA@nongnu.org
X-Gm-Message-State: AOJu0YztbrmL9ZQepzhKafjPETGhO4GCbGBdyQ2pF53zV8Y4n/WqnF4r
 cKTETyzdrmZdAdJgmdPMz83IBDBMNMpBZ4iV79XDp3tAQiUYizJD0M7nsnsaLZg=
X-Google-Smtp-Source: AGHT+IHx9gNStq8vgR1KOTFDewk3ulkSHNEL4IxMvOd03+p90tC5J2nRrUvebubsA/8zQSDmOpOW6w==
X-Received: by 2002:a17:90b:1c03:b0:2c9:9fdf:f72e with SMTP id
 98e67ed59e1d1-2cff9547ea1mr4636353a91.26.1722613096069; 
 Fri, 02 Aug 2024 08:38:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4e3b5fsm5323350a91.51.2024.08.02.08.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 08:38:15 -0700 (PDT)
Message-ID: <5058d9d4-7922-4746-b6d1-b16046bf69f9@daynix.com>
Date: Sat, 3 Aug 2024 00:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v11 08/11] pcie_sriov: Remove num_vfs from
 PCIESriovPF
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-8-fb83bb8c19fb@daynix.com>
 <20240802083911-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240802083911-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/08/02 21:58, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2024 at 02:17:58PM +0900, Akihiko Odaki wrote:
>> num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
>> instead.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/pci/pcie_sriov.h |  1 -
>>   hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
>>   hw/pci/trace-events         |  2 +-
>>   3 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
>> index 70649236c18a..5148c5b77dd1 100644
>> --- a/include/hw/pci/pcie_sriov.h
>> +++ b/include/hw/pci/pcie_sriov.h
>> @@ -16,7 +16,6 @@
>>   #include "hw/pci/pci.h"
>>   
>>   typedef struct PCIESriovPF {
>> -    uint16_t num_vfs;   /* Number of virtual functions created */
>>       uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
>>       PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>>   } PCIESriovPF;
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index 9bd7f8acc3f4..fae6acea4acb 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -57,7 +57,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>>       pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
>>                           offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>>       dev->exp.sriov_cap = offset;
>> -    dev->exp.sriov_pf.num_vfs = 0;
>>       dev->exp.sriov_pf.vf = NULL;
>>   
>>       pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
>> @@ -186,6 +185,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
>>       }
>>   }
>>   
>> +static void clear_ctrl_vfe(PCIDevice *dev)
>> +{
>> +    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
> 
> space here, after definition
> 
>> +    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
>> +}
>> +
> 
> Pls use pci_word_test_and_clear_mask

That sounds good. I'll do so with the next version.

> 
> 
>>   static void register_vfs(PCIDevice *dev)
>>   {
>>       uint16_t num_vfs;
>> @@ -195,6 +200,7 @@ static void register_vfs(PCIDevice *dev)
>>       assert(sriov_cap > 0);
>>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>       if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
>> +        clear_ctrl_vfe(dev);
>>           return;
>>       }
>>   
>> @@ -203,20 +209,18 @@ static void register_vfs(PCIDevice *dev)
>>       for (i = 0; i < num_vfs; i++) {
>>           pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>>       }
>> -    dev->exp.sriov_pf.num_vfs = num_vfs;
>>   }
>>   
>>   static void unregister_vfs(PCIDevice *dev)
>>   {
>> -    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
>>       uint16_t i;
>> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>>   
>>       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>> -                               PCI_FUNC(dev->devfn), num_vfs);
>> -    for (i = 0; i < num_vfs; i++) {
>> +                               PCI_FUNC(dev->devfn));
>> +    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
> 
> Why PCI_SRIOV_TOTAL_VF not PCI_SRIOV_NUM_VF/pcie_sriov_num_vfs?

Because PCI_SRIOV_NUM_VF is overwritten when unregister_vfs() is called.

> 
> 
>>           pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>>       }
>> -    dev->exp.sriov_pf.num_vfs = 0;
>>   }
>>   
>>   void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>> @@ -242,6 +246,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>           } else {
>>               unregister_vfs(dev);
>>           }
>> +    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
>> +        clear_ctrl_vfe(dev);
>> +        unregister_vfs(dev);
> 
> So any write into PCI_SRIOV_NUM_VF automatically clears VFE?
> 
> Yes writing into PCI_SRIOV_NUM_VF should not happen when VFE
> is set, but spec does not say we need to clear it automatically.
> Why come up with random rules? just don't special case it,
> whatever happens, let it happen.
> 
> And what does this change have to do with getting rid of
> num_vfs?

Keeping VFs working requires to know the number of VFs, but we do no 
longer know it because PCI_SRIOV_NUM_VF is overwritten. This disables 
all VFs instead of trying to keep VFs alive.

Regards,
Akihiko Odaki

