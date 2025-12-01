Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CCBD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ52d-0007XI-ME; Mon, 01 Dec 2025 09:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ52V-0007T6-O2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vQ52U-0002it-1Q
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764599883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7v+lweDAC/ONxi5Ke+G7XPhiCVaYiQxzBE48FlTPxk=;
 b=Wy/cz759HxeGR9ohd3ZQutk45xiQWxSeAe7H/snYwDUIlFgp6bRf9CEXx6FEB9AAMOJpNC
 S3YAC0hoNK5o2e7XjT0+PYccwUADwGdL882wF7mgZstI66Ou/37/NgKDKNNb4ARM9hSKxK
 Lt1n2m4urz4a/5kGcT98YbNxndnwCRk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-eWihxX3oNQ2cF78VCameeA-1; Mon, 01 Dec 2025 09:38:01 -0500
X-MC-Unique: eWihxX3oNQ2cF78VCameeA-1
X-Mimecast-MFC-AGG-ID: eWihxX3oNQ2cF78VCameeA_1764599880
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-295592eb5dbso73700375ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764599880; x=1765204680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q7v+lweDAC/ONxi5Ke+G7XPhiCVaYiQxzBE48FlTPxk=;
 b=ZB+5KKIDVFwDpmIb2bD8MJOvG5cLBl1TdLe8F7JpRCcZRT8shJWU0iR1bUqIRtthJe
 jhGOhb29TA1yl8f0gXVivw1ecfc9lqiC/fPgtTiu6MfRODHFTT7VCRooAqfxUqy1vOGA
 ILJuhmJb/nvbjJaSgerFpKEPKXCo8d5NCmXcceUNJ2Iuc/kiGrAvn+qTWIOY/SxkKRel
 OOa4cClnRmM2BK31OMEW9S3iLOOPj8MptzZgjHQ4qYI0X20fjzfXMr2b9IB43y+A7ykV
 FysTkgHbS75LkVEs4PDZJngF5r42nUKN5FWx2Q4rJRn9MgoEEi6gNgwS1HiN27wVkvY0
 1DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764599880; x=1765204680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7v+lweDAC/ONxi5Ke+G7XPhiCVaYiQxzBE48FlTPxk=;
 b=fQIta8CZGAV5S+HL9kI/PmfcJRg2rapCcl62Afxmke/fk45z8xrKKIPbMTaPelvdHm
 psZ5wzA/gPQhQD3u+3q1tNaNPab7NjpI9BJNIulolaiozz3WnXrAXohVz34k4gtwUK+H
 ww3jC26Xf4wgOhZIYxM/ZWrkvCEXLhEss0IthIMY+4Qk/92J5JTuuTUgnmtWlgmKvfJx
 LCE8uWKJx1MgaOkgH3HhpVGHc8OSTKoBC5dgN18vEbWbLCdv1kr1U0hCLM4jaImBRXTk
 RQgNoSiyBNz//Hg0ROBqWUDyBVTtNF/QTRp7UWl6fMkRT5K54LD84uXJISA3LUYN1MdO
 5tTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUGeLeCw+evHnC1dHYWnEr8HVXkOiRsknX+2F4X7Ayu7/rt7ofnjduiP5BwJvx3dICX5oVr2o7n5U@nongnu.org
X-Gm-Message-State: AOJu0YyuEu7iKmSIe8A1boKbXSvudTACwZCcgIOdEQIgfawtjTeffqZK
 RArRiNJnidN2t4lCpZH8/ggV/01JRd4ewfU+xGLiOxbsh6sOMknHoFNDIdPdjfOmGX4pFb2WmVg
 7BfghYB/uxrxij0ClPDQe1wgq19wwbpzOBzZcNI6mPOCuzkUcU8OCVWms
X-Gm-Gg: ASbGnctRzmCm0LCbSYtdugxZ4wG65Kj7Tr/f+C4mp/fQoX43aSpDbUFEyBNuuxHIe8G
 JQDzO3Q4ETW26CfBnk/YaEavhgbss9WOa/kM5or+tRYbs8x/KXnxxzMxiAzEgr6LCJtsckg/xin
 w62iH66460cNsvCgous7mrnDpFHWlTA4IkV7yqp5v/V61o+3n71pP5EgYQWWfHDZtISlfzKgaC6
 cw5GNo2qctQHQHk+mYUN0jCxI9bSW9XDXltVJV3Rp0Riym5+6eY8hOELQQYv/2SopoIMcjz/R2z
 RnUOK8lBWLymKO7MDS9HMsGY1WqtnDLE/ALYNsEdHRIbMXiHyBgpOTNkF7C+wJHUiqaFfqOvLET
 Fpp2j8orPCTZbMKnxEcxtM/55QvC1pOV72vIm6IfJZkFdbqvSUQ==
X-Received: by 2002:a17:903:1209:b0:298:3e3a:ae6 with SMTP id
 d9443c01a7336-29b6c6ae64fmr409151375ad.48.1764599880498; 
 Mon, 01 Dec 2025 06:38:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlDc4+C/44Vkt4/h7bMFtt2THg+cgiTD3THaQnCU6xxAcSL8m/OAjvBVmNt6+A+ncrbhNFIQ==
X-Received: by 2002:a17:903:1209:b0:298:3e3a:ae6 with SMTP id
 d9443c01a7336-29b6c6ae64fmr409150995ad.48.1764599879946; 
 Mon, 01 Dec 2025 06:37:59 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb277ebsm125734955ad.56.2025.12.01.06.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 06:37:59 -0800 (PST)
Message-ID: <dd43197e-ff56-4adf-a413-03f63d5f5078@redhat.com>
Date: Tue, 2 Dec 2025 00:37:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251201131729.615abe68@foz.lan>
 <12b7baee-1d6d-440a-a119-971b47d7f3ad@redhat.com>
 <20251201153121.190c22ec@foz.lan>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251201153121.190c22ec@foz.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mauro,

On 12/2/25 12:31 AM, Mauro Carvalho Chehab wrote:
> On Tue, 2 Dec 2025 00:13:06 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>> On 12/1/25 10:17 PM, Mauro Carvalho Chehab wrote:
>>> On Thu, 27 Nov 2025 10:44:30 +1000
>>> Gavin Shan <gshan@redhat.com> wrote:

[...]

>>>
>>> Btw, what setup are you using to test memory errors? It would be
>>> nice to have it documented somewhere, maybe at
>>> docs/specs/acpi_hest_ghes.rst.
>>>    
>>
>> I don't think docs/specs/acpi_hest_ghes.rst is the right place for that
>> as it's for specifications.
> 
> Perhaps not, but it would be nice to have it documented somewhere,
> either there or at QEMU wiki.
> 

QEMU wiki may be the best place for it. I never updated to QEMU wiki and
any guiding steps on how to do that?

>> I'm sharing how this is tested here to make the thread complete.
> 
> Thanks!
> 
>>
>> - Both host and guest has 4KB page size
>>
>> - Start the guest by the following command lines
>>
>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                  \
>>     -accel kvm -machine virt,gic-version=host,nvdimm=on,ras=on               \
>>     -cpu host -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1   \
>>     -m 4096M,slots=16,maxmem=128G                                            \
>>     -object memory-backend-ram,id=mem0,size=4096M                            \
>>     -numa node,nodeid=0,cpus=0-7,memdev=mem0                                 \
>>     -L /home/gavin/sandbox/qemu.main/build/pc-bios                           \
>>     -monitor none -serial mon:stdio -nographic                               \
>>     -gdb tcp::6666 -qmp tcp:localhost:5555,server,wait=off                   \
>>     -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd   \
>>     -boot c                                                                  \
>>     -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                    \
>>     -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                    \
>>     -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                    \
>>        :                                                                     \
>>     -device pcie-root-port,bus=pcie.0,chassis=16,id=pcie.16                  \
>>     -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=drive0      \
>>     -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4  \
>>     -netdev tap,id=tap1,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>>     -device virtio-net-pci,bus=pcie.8,netdev=tap1,mac=52:54:00:f1:26:b0
>>
>> - Trigger 'victim -d' in the guest
> 
> Hmm... from where I can get victim?
> 

https://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git

> Regards,
> Mauro
> 

Thanks,
Gavin


