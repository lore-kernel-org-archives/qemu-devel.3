Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C943C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Fqq-0005Bl-Hu; Fri, 25 Apr 2025 06:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Fqo-0005At-T6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:00:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Fqm-0002pr-Ho
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:00:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso13860445e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745575203; x=1746180003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxdmkHEq0pFQGxDjTDaZiXSaDwdSP8VoH1JzK7bL3tM=;
 b=d+QjrmFInkyZYLtKNiqtqeOWRkgjxIimSBV5EcEuaWREcok64a/lHApl9vY+hJsKlf
 G8cSTHuNsw8Jw9rddhsLZnGP75eVbqwZLf5giSiPVhRoluosUNoy464qYluFYDViXCOm
 1ehhUtOfYONcRIs67919VsG67C5CADUVHG0EVP9u6iv0Fdvy32eg2Tc9skt7eUpyr8BS
 j4/zxu/TTt8I1G0PzV98l4eIbLJNyaEPn8atoR5Q2BkVpvqnoMvNqf7hhE+r/UMsFuS4
 LJBb5ypvsAw0vbkfnlxnq051fGEikrgxmR5eITa6Nbl6xWmc2GVU4QOwoOVqdto6U0Zr
 kpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745575203; x=1746180003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxdmkHEq0pFQGxDjTDaZiXSaDwdSP8VoH1JzK7bL3tM=;
 b=tbeV2I+X3bH2XYYDGQrXXRnTJsmi3A7dM1UbRI2sGuZpZ+IfCzV9hyRWcAHKP4ni2w
 ZEGYG1PTkSUp+jL8j9ciiZidATpc79MxWWBxTaJf/f1bLPc8KBiI/nsRFkLO0R5Tqa3e
 AFXdg2T7vxi97jviM1C8sio+i+Qc2/BQIgl3hvo7JBnD2r95O8kazLGZ2w/oQThhohBT
 JiTq19oCaFqnzUk544wrdG0utKc4QbOAVl/ZgNyu5euUohi5EEReLCF6GeDMP4A+Z+MN
 NgAdPwNq/4AJ0QhMRy1rVlF+4E35HzKhelyPESOIUITN6NhzroBq+agP6msl/Bz7h3LB
 RQ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa33C8Bw2yhFz1S40chaJHUE3LM6Ykn/zZU2MBtmIHjnUyA8CypyMzWjCFqHoc7uiMLOnSkMWZItGx@nongnu.org
X-Gm-Message-State: AOJu0YzrcYLs492eaNhiHNm6gEUzpS5OxxQQ9cQNKGzgZcoTwL3OuBSF
 GMQcqmARv54DYDJ0lVmvUvzrKDmHCFLuu+8hR1cL6k2j2uvwlFuq0EZu/sy3DYg=
X-Gm-Gg: ASbGncu5uYEqqA/nQXdgH0VrD2ZPg7YHxg/+mxKI1Oo/ZtsCJbjks/tfVOrKnVNtJvm
 cE60U9BMqF2B95cRXH2roWO13ur7jQJUyKVp5vsCnAiNBKVnRZ2QYjDknNgFnllSiul0TEPOymX
 8B5hBzX+FDGJv7+80OJR2Ng5H3J4/JVDrjAN3ovRpTJXvL30UQxOufvj9i+Vj5svfXwKLxeGclB
 +4oKDKRHtymlJnpqPuUjJjUiKGEwXfmRhLScG0LClKrES+PeDxVzxMv1jCbA/xR+Ex2b/LUYGS2
 tf3b3JBo7Wz+CtLXQkjYXw3ot1wfvG7KMu2n/Vtk3qGPeOLjzEtnD8f/Er5i84oHYSmAosm4oE4
 m+ncDfSVpjtrJdA==
X-Google-Smtp-Source: AGHT+IG5kOb23QnP7zoG7jSNMxnY+XHcDOw/3vWB9yhmNzAimCOjeNvn8IHq2TKeLvC7EmD+cMdkOg==
X-Received: by 2002:a05:600c:c8d:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-440a63470c6mr15520275e9.0.1745575202707; 
 Fri, 25 Apr 2025 03:00:02 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac27dsm51270175e9.22.2025.04.25.02.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:00:01 -0700 (PDT)
Message-ID: <747b53e3-2913-4a51-95d0-1a8b67de2d4a@linaro.org>
Date: Fri, 25 Apr 2025 11:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Enable QEMU NVMe userspace driver on s390x
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: stefanha@redhat.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <15457df6-11fd-41d4-9cb1-14e4473c1866@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15457df6-11fd-41d4-9cb1-14e4473c1866@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 24/4/25 18:24, Farhan Ali wrote:
> Hi Alex,

Cc'ing Cédric as co-maintainer with Alex.

> 
> Polite ping. Please let me know if there are any concerns with this 
> version of the patches.
> 
> Thanks
> 
> Farhan
> 
> On 4/17/2025 10:37 AM, Farhan Ali wrote:
>> Hi,
>>
>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].
>> This allows us to take advantage and use userspace drivers on s390x. 
>> However,
>> on s390x we have special instructions for MMIO access. Starting with z15
>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
>> operate on virtually mapped PCI memory spaces, and can be used from 
>> userspace.
>> On older platforms we would fallback to using existing system calls 
>> for MMIO access.
>>
>> This patch series introduces support the PCI MIO instructions, and 
>> enables s390x
>> support for the userspace NVMe driver on s390x. I would appreciate any 
>> review/feedback
>> on the patches.
>>
>> Thanks
>> Farhan
>>
>> [1] https://lore.kernel.org/linux-s390/20250226-vfio_pci_mmap-v7-0- 
>> c5c0f1d26efd@linux.ibm.com/
>>
>> ChangeLog
>> ---------
>> v4 series https://lore.kernel.org/qemu-devel/20250414213616.2675-1- 
>> alifm@linux.ibm.com/
>> v4 -> v5
>>      - Fixup typo in PCI MMIO API (patch 2).
>>
>> v3 series https://lore.kernel.org/qemu-devel/20250401172246.2688-1- 
>> alifm@linux.ibm.com/
>> v3 -> v4
>>      - Use generic ld/st functions for non s390x PCI access suggested 
>> by Alex (patch 2).
>>      - Removed R-b for patch 2 as the host PCI MMIO access API changed 
>> for non-s390x.
>>      Would appreciate review on this again.
>>
>> v2 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/ 
>> msg06847.html
>> v2 -> v3
>>      - Update the PCI MMIO APIs to reflect that its PCI MMIO access on 
>> host
>> as suggested by Stefan(patch 2)
>>      - Move s390x ifdef check to s390x_pci_mmio.h as suggested by 
>> Philippe (patch 1)
>>      - Add R-bs for the respective patches.
>>
>> v1 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/ 
>> msg06596.html
>> v1 -> v2
>>      - Add 8 and 16 bit reads/writes for completeness (patch 1)
>>      - Introduce new QEMU PCI MMIO read/write API as suggested by 
>> Stefan (patch 2)
>>      - Update NVMe userspace driver to use QEMU PCI MMIO functions 
>> (patch 3)
>>
>>
>> Farhan Ali (3):
>>    util: Add functions for s390x mmio read/write
>>    include: Add a header to define host PCI MMIO functions
>>    block/nvme: Use host PCI MMIO API
>>
>>   block/nvme.c                  |  41 +++++-----
>>   include/qemu/host-pci-mmio.h  | 141 ++++++++++++++++++++++++++++++++
>>   include/qemu/s390x_pci_mmio.h |  24 ++++++
>>   util/meson.build              |   2 +
>>   util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 338 insertions(+), 18 deletions(-)
>>   create mode 100644 include/qemu/host-pci-mmio.h
>>   create mode 100644 include/qemu/s390x_pci_mmio.h
>>   create mode 100644 util/s390x_pci_mmio.c
>>


