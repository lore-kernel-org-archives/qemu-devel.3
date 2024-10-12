Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E9FCF2564
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 12:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szaxj-0001W2-EI; Sat, 12 Oct 2024 08:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szaxh-0001Ts-Se
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 08:11:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szaxd-0002O1-WA
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 08:11:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso30521835ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728735064; x=1729339864;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhzeFZq5rUX+9oZUukYcR2ebS6hy2Xlti8Kskef03cg=;
 b=XT/+5mYICJYrzLmIEc6apUkRbCj98dJzJDINbz6BVhyEUchmrDDPYwc6+v3VKbKOq1
 Kj6i24Tlge7i77w8pT4Kzg1/8wnLkin8mY6F4yYHWT6Fsl0mk2S/oklBUYxJzovctnAX
 morHdTdXsFYfmoh/8TOkluNAjMMnHWoel9PTE2//iDe6bH4dR67hq8nBqWNWg0cY31Dc
 YKFU9oBRjSVs9RgFJpLP/DNyFUvDpUMAmtc/mdYGqoKySUdZA8u1fLtv7jqXCLl6/4lF
 UG0JdqzkctL1RRghAKWt+OXXVaKa7EEIAxgf8hBG+eRVuzUEVNuVhwIo0sFlaLUI3a4o
 Xktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728735064; x=1729339864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhzeFZq5rUX+9oZUukYcR2ebS6hy2Xlti8Kskef03cg=;
 b=rZl3QRpLvFVAl/khWWvwPSV1fyni9Xi6Ep5V4TLAsdmWIU3iCE4owy9oZ/+Xcbdo6o
 WH7ineBr/+1WcCIBZs7qBrpvDEpdvSp63lFKpza/N4viifZHFiMn2zWLGUYrRhfGa6km
 cXEVNTRC2xN3mgK9Xh7Od6+wPLFcI4vUDCgRtxxD1s3z3W/H3vHDuF0LNIBmCpjSAX4g
 KO7208KULEAU1OIWeTIdQg7xAYt7JMekva4pWdZmj+g6AwaO5R7q8cwQchkdaZ2+dewk
 PZXYxhLrlTKcl3bXoR7XT+lxCfG6FXykq9U5+3rc4XwQzrH/yRkMh3j3u0jQkyLXb468
 iJdQ==
X-Gm-Message-State: AOJu0Yz9gCvER5OHlZtD50lZwSsWx8j0V39mPcajd84cLn4qQSueIQej
 4YbRhQX86/FTPopgqVpHp6PQV1BCOzC2btv4um/2717CuUf3vSTaGhBUF+z4Prs=
X-Google-Smtp-Source: AGHT+IGstB/XASE/X8nf60W/GmSEkqoCvKGDNut8vHmuxdU8tIlVCRtTt/e1OuE2M06WnfQmQn4hmA==
X-Received: by 2002:a17:903:8c7:b0:20c:6bff:fc8a with SMTP id
 d9443c01a7336-20cbb1a96a5mr42297015ad.2.1728735064477; 
 Sat, 12 Oct 2024 05:11:04 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bad34dasm36203675ad.53.2024.10.12.05.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 05:11:03 -0700 (PDT)
Message-ID: <4c472991-f296-4c7d-beee-0332ff29d9b0@daynix.com>
Date: Sat, 12 Oct 2024 21:10:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/13] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-3-d016b4b4f616@daynix.com>
 <3cc3456d-a47d-4960-9d5e-10cf1c8b4beb@redhat.com>
 <84adb86d-a60c-4468-84a3-5bdc545bc161@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <84adb86d-a60c-4468-84a3-5bdc545bc161@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2024/10/12 2:22, Shivaprasad G Bhat wrote:
> On 9/18/24 7:57 PM, Cédric Le Goater wrote:
>> Adding :
>>
>>   Harsh for QEMU/PPC pseries machine,
>>   Shivaprasad for KVM/PPC VFIO and IOMMU support.
>>
>> Thanks,
>>
>> C.
>>
>>
>> On 9/13/24 05:44, Akihiko Odaki wrote:
>>> A PF may automatically create VFs and the PF may be function 0.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/ppc/spapr_pci.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>> index f63182a03c41..ed4454bbf79e 100644
>>> --- a/hw/ppc/spapr_pci.c
>>> +++ b/hw/ppc/spapr_pci.c
>>> @@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler 
>>> *plug_handler,
>>>        * hotplug, we do not allow functions to be hotplugged to a
>>>        * slot that already has function 0 present
>>>        */
>>> -    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 
>>> 0)] &&
>>> +    if (plugged_dev->hotplugged &&
>>> +        !pci_is_vf(pdev) &&
> 
> I see there is history to this change. The reverted[1] virtio-net-pci 
> SRIOV emulation support
> 
> needed this as the VFs were explicitly specified with -device virtio- 
> net-pci,sriov-pf=X
> 
> property. I see the pre_plug handlers for the VFs cant be reached now 
> with the reverted
> 
> code base for the other devices(nvme and igb) supporting the SRIOV 
> emulation.
> 
> 
> Do the VFs really reach this path in today's code base ? Other than the 
> above
> 
> workflow, the pre_plug() handlers wont be called for VFs when the
> 
> echo X > /<sys-fs-pf-path>/sriov_numvfs inside the guest too. I don't 
> see the
> 
> workflow(PF automatically creating VFs) to hit this path. Could you 
> clarify how?
> 
> 
> I see before the revert of virito-net-pci sriov use-case, the out of 
> order VF hot|cold
> 
> plug post PF are prevented here. Even if we allowed VFs to continue 
> here, PFs were
> 
> prevented in pcie_sriov_register_device() which is followed sequentially 
> anyway. Now,
> 
> as the pcie_sriov_register_device() is no longer there, this check 
> actually makes
> 
> sense as this would be the only place we avoid the out of order plugging.

VFs are always plugged after its paired PF. Currently, VFs are plugged 
when the guest writes sriov_numvfs. With "[PATCH v16 08/13] pcie_sriov: 
Reuse SR-IOV VF device instances", which follows this patch, VFs will 
plug while the PF is being realized.

I have no idea why you can't reproduce the issue by writing 
sriov_numvfs, but it is easy to reproduce it with "[PATCH v16 08/13] 
pcie_sriov: Reuse SR-IOV VF device instances" applied. You can use the 
following command:
qemu-system-ppc64 -nographic -monitor stdio -serial none <<< 'device_add 
igb'

It should say:
Error: PCI: slot 18 function 0 already occupied by igbvf, additional 
functions can no longer be exposed to guest.

Regards,
Akihiko Odaki

> 
> 
> On a side note, for testing this fulky on PPC, we need more work on Qemu 
> today as the
> 
> open-sriov[2] is supported only on PowerVM.
> 
> 
> Thanks,
> 
> Shivaprasad
> 
> 
> Reference :
> 
> [1] - Atleast till commit b0fdaee5d1
> 
> [2] - https://lore.kernel.org/linuxppc-dev/20180105164552.36371-1- 
> bryantly@linux.vnet.ibm.com/
> 


