Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17350F3C24E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzapX-0000qE-5M; Mon, 09 Mar 2026 09:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzapP-0000pf-Ij
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:39:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzapN-0004pG-DB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:39:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so139178645e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773063560; x=1773668360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eSDg1yE03uRLTsL/bo6GVuY6MoNonZbnSKgb1RuYv+c=;
 b=h9cORLXerybC4yFK0+iIIrm0F4G7GhEFM89XPds6JCLVZ7CGnVq0QE5aRqjIGMhiRW
 uYqV9zBunIjs9vFGf/+y5g/iH6I35Ym4Y3oCxbGkzb4CTofWE0fSlSXBOcf7OhzzmrfZ
 XChtRUIevF+/GvAsh+WCt5/h+9DajTKY60bOoK1QxVPYPRQ1J8mUjaOufWxDmZewTtnb
 YOItiTG8G7EIUZjvzWeKPdIC6OoGeoPxt5NPePtkF1tcH08qv5EDkn2+RVfDGzCjjAWd
 sVQIqOMX2pREj5LL8xJZFeajX0zRPzXKKNbY9jnEkuLholPV1QreC7A5BzEGYEH7xPDF
 99DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773063560; x=1773668360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSDg1yE03uRLTsL/bo6GVuY6MoNonZbnSKgb1RuYv+c=;
 b=ej/Am4K6vDBLfnYJ3LBendNOPUlzVeiw9IV6W/zLY7nf1NWLNBWcHWobeEzQ+5XxAI
 MLU/+Hu5cp30PpPWCz48h2YUFJCL9pFfhipzQiL3IIrQQtNJCcioxq8qUBJD4OYjBz98
 747ZhsYj9B08+YGwTDIhmYT4MkeSmlDLzywzXB2mdsDCRDMcvQiS6gXvigoERVkxsF/g
 +YGMsYDEEp4RO5DRK5GTRLIR02qDxtwaTxPsfqpE/2OteuC4vNGWgFWN2KkarJWGpdxb
 oN6L/c47W095WmGI5EIhqCnqbbcjgAz1duYxSW1av4r5TTDvCv/0U0w6GVxlTlo5hDpk
 4PWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWUkRL6laZCPHgl3d1RHtf6CnGAZyJv33s+x+MWxlPuSVbcgZrd+GN9vdSnm5dU6zR/ckQY99yr6A2@nongnu.org
X-Gm-Message-State: AOJu0YxAauoqE23FYAgomwb3or22Prl4M9UL7RSbmoOAvDL/yoQruOLu
 0m0y9j2UtLMvqKPbp3nT8nMuxRh/KveTlCR+bFp1h/8aGLJQ0yimGEmxKkZkp3lywHM=
X-Gm-Gg: ATEYQzwLHi6UIW8PftbC9jAGh8/kwZ91pyfGao20Mx5fGJFQ5jWjbKdp2ifQe54hXlm
 GTV4mrs0qH2b6cb91oro4UjRigg8vpBnmUgmQDTstl2ycIoiuFKfUfxas8B75mT3uef/OfTaHnO
 2uiPlR1M6yBQ6206gENgsDA1q0NoJytS/1HIOGsx+pbdXqVlG4g9h0S2+si2hAqnNf/aFL6tPUP
 HYSFsH9aUaZ6Mc2QKNi2QISYXF3QYrWyYK4D6/ln4MDXngFZrZ1eEBEqHAjsmZ9NrWHv3jr13Wv
 0IoC4ChZznnOyEn6n6ejVf7mLlItWCAJ+SfweYGF99KgMbKBkaMtti2I0eGPd6Y/H4xd6k8Njgs
 VOOlXWERuZoiHL6Oi3by11r4pisBe1+K68KptVJ1st36GZ9xlwRPuuM0v+RWTbXHZ9LpDsE9i/Q
 IdWJGZpy7pd009LI9L27DuvjqZ7ws6MLhVCni2B36DBgFqo6j2539kirOZNhBdqy3vVtAsuwZbN
 hgg
X-Received: by 2002:a05:600c:3d90:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-48526930a4fmr176472955e9.12.1773063559562; 
 Mon, 09 Mar 2026 06:39:19 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48535c7fae3sm57195605e9.1.2026.03.09.06.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:39:18 -0700 (PDT)
Message-ID: <a335a8ea-a513-434e-82da-673c3d12192c@linaro.org>
Date: Mon, 9 Mar 2026 14:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, clg@redhat.com, nathanc@nvidia.com,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
 <aa7Dw5PBcqLpG5HC@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aa7Dw5PBcqLpG5HC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/3/26 13:57, Daniel P. Berrangé wrote:
> On Mon, Mar 09, 2026 at 01:44:15PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 9/3/26 10:20, Zhenzhong Duan wrote:
>>> We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
>>> year, it's fine to remove 'x-' now.
>>>
>>> This is a prerequisite to enable intel_iommu's scalable mode and first stage
>>> translation support in libvirt.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    docs/devel/vfio-iommufd.rst    | 10 +++++-----
>>>    hw/i386/intel_iommu.c          |  8 ++++----
>>>    hw/i386/intel_iommu_accel.c    |  4 ++--
>>>    tests/qtest/intel-iommu-test.c |  2 +-
>>>    4 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
>>> index 78bcdffac7..5755532443 100644
>>> --- a/docs/devel/vfio-iommufd.rst
>>> +++ b/docs/devel/vfio-iommufd.rst
>>> @@ -153,22 +153,22 @@ RAM discarding for mdev.
>>>    ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
>>>    devices are always mdev and RAM discarding is force enabled.
>>> -Usage with intel_iommu featuring x-flts=on
>>> +Usage with intel_iommu featuring flts=on
>>>    ------------------------------------------
>>>    Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
>>> -with x-flts=on, for legacy container backed VFIO device, below error shows:
>>> +with flts=on, for legacy container backed VFIO device, below error shows:
>>>    .. code-block:: none
>>> -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
>>> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
>>>    VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
>>>    otherwise below error shows:
>>>    .. code-block:: none
>>> -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
>>> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when flts=on
>>>    If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
>>>    is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
>>> @@ -177,4 +177,4 @@ below if it's not needed by guest:
>>>    .. code-block:: bash
>>> -    -device intel-iommu,x-scalable-mode=off
>>> +    -device intel-iommu,scalable-mode=off
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index d24ba989bf..001847ad37 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -4200,8 +4200,8 @@ static const Property vtd_properties[] = {
>>>        DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>>>                          VTD_HOST_ADDRESS_WIDTH),
>>>        DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
>>> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>>> -    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>>
>> IMHO safer would be to officially deprecate these in
>> docs/about/deprecated.rst and keeping them aliased until deprecation
>> period expires. Other changes LGTM.
> 
> The purpose of using an 'x-' prefix for properties in QEMU is to declare
> that they are subject to change with no warning, so we are free to change
> them without any deprecation IMHO.

OK, good to know, thanks.

> 
>>> +    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>>> +    DEFINE_PROP_BOOL("flts", IntelIOMMUState, fsts, FALSE),
>>>        DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
>>>        DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>>>        DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>>
> 
> With regards,
> Daniel


