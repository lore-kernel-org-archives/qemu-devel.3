Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C613CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RrO-0003xW-Bu; Thu, 16 Oct 2025 13:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9RrL-0003xI-92
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9Rr7-0006ot-Aa
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760636011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lKLu4Av1xpHCHBANQM6SCtMuajiuq4iWmzi38wMJxY=;
 b=auNLj4jnBGIr6ci9C/JpcVBcTDEwp+45TRtGM2Vw55peqhzg2bBToZOXBSjx6K94rrhX68
 lwrb05//MtlfAOOmeSw8aD6nTDQB1MSk9TvOGtFbtHB6N1ZXMqWCgE3IzC6dTR5NMtIXL+
 +Wx3mjLm3pCiDHX+XZVBackXKRj+/yg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Nd7PYVCtNiybTAMFldDPtA-1; Thu, 16 Oct 2025 13:33:30 -0400
X-MC-Unique: Nd7PYVCtNiybTAMFldDPtA-1
X-Mimecast-MFC-AGG-ID: Nd7PYVCtNiybTAMFldDPtA_1760636009
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88ef355f7a3so374478385a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760636009; x=1761240809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lKLu4Av1xpHCHBANQM6SCtMuajiuq4iWmzi38wMJxY=;
 b=PB4bPJV3H990EeLcF8W577piRnSKziylg7ghhDyKbJ3AOesA1xf3B3huXmcnA1xF82
 hsSHO6ikm04lS9RmkgPFQu0yp3xMmr4Z8K5LLB/sRGkHGpqNjaqcrtB7LgFe9Z+e5JIK
 6ZE910h3pHVBQE7hfX74NZDd8H8JjzautYGZtSK5WEDnBlyecptCK5nPpKddB4gor823
 BVIE3QRmCiOgSkBejLXI3yv7wW3gfv01jQCVkBvuZN1fdW9yB/UPheO9gmBOtWPlA3hZ
 xv1yli1S1sw82/HgjY3PQYeoDgXo+MK8LALPIBenoV97Okfr9aOYCSuHASPOPbZ34dGT
 PWQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqslPuUPoIVJCEtNWVstxA6Nk+e4LJXk1jwYh8SRMAhApVK4xnlb0vUtBKh4Qle8DxWDyTidW81BZ@nongnu.org
X-Gm-Message-State: AOJu0YxGRrL7h30qKJc+yc3IRnuv2Z7Dsy53gYO7HJ9+8F4RQTrAZviy
 bKlClAJzDGpKYvS+k5tYPqvMHntN4xAPE2A7X/f9GYe3aNSP97qX0uL3gij7OBeHokiqkrJ4+y7
 EkortWyLeZqC3Ol6of09zLaoaCT9vfmeifvbMuidMOhRjEBBGx24rEBSW
X-Gm-Gg: ASbGnct5e0sL7730fcP9uY3oqqi2yivyNEVbQywpnf9gbh/u1DFmwjPRc+VuJ2kdGSq
 lziTfkGDV+RG8VElelsWYbeKbXmjkGWGxWMNoGLdQVq8OsuWpR9bMY6/dMkXieLQp/8R/+5q6lc
 lxNIk2BwmPUszRXyd9iRN1CilyQ1tqyGvpx34aXTrgMSBo8D6Xz7rR1lbXUoM1Mu64+4YNt6ZsQ
 lHofHCpiW01ufTleJUxnlzy8gRfpwYkjoAluhm9eLN8gubFnSazgprgX6vlVDp0hIJW+WFfuk8j
 jXrrrDjs808ToZ+/bwzLa8N4ci7pMVCMw/uHgERzBeGApQaRwVSzJN/hS/fLXJYjlW45YnkMinQ
 npNWt6X2IYBBwYsBRUDOLrrxOPNgm7w7dnux0S6q42Z3PxQ==
X-Received: by 2002:a05:622a:2c7:b0:4e0:3486:8873 with SMTP id
 d75a77b69052e-4e89d414c8fmr13679601cf.75.1760636009414; 
 Thu, 16 Oct 2025 10:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmRrDRdc2F9Fmhs+JizR4ybIBNZ//fiU+oHWXD3HcZg3wJVk4EVeHueGz0x3Isz2j5LcUf7g==
X-Received: by 2002:a05:622a:2c7:b0:4e0:3486:8873 with SMTP id
 d75a77b69052e-4e89d414c8fmr13679161cf.75.1760636008900; 
 Thu, 16 Oct 2025 10:33:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f35c6756asm242033185a.22.2025.10.16.10.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:33:28 -0700 (PDT)
Message-ID: <e08c0f4b-fc8d-4420-ac07-78b9f2ce4ef0@redhat.com>
Date: Thu, 16 Oct 2025 19:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to
 hide
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 gshan@redhat.com
References: <20250911134324.3702720-1-eric.auger@redhat.com>
 <20250911134324.3702720-2-eric.auger@redhat.com>
 <0f05a0ec-8b98-a9b7-6e3a-9ef73d0c34e7@redhat.com>
 <b2ae3dc0-9bf0-4e89-a995-b97410d57861@redhat.com> <87ikgpv6yo.fsf@redhat.com>
 <9590ce96-6617-4cfb-849e-b24ea7fcacb9@redhat.com> <87cy6oux45.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87cy6oux45.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 10/15/25 3:12 PM, Cornelia Huck wrote:
> On Tue, Oct 14 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> On 10/8/25 3:49 PM, Cornelia Huck wrote:
>>> On Fri, Oct 03 2025, Eric Auger <eric.auger@redhat.com> wrote:
>>>
>>>> Hi Sebastian,
>>>>
>>>> On 9/18/25 6:16 PM, Sebastian Ott wrote:
>>>>> On Thu, 11 Sep 2025, Eric Auger wrote:
>>>>>> New kernels sometimes expose new registers in an unconditionnal
>>>>>> manner.  This situation breaks backward migration as qemu notices
>>>>>> there are more registers to store on guest than supported in the
>>>>>> destination kerenl. This leads to a "failed to load
>>>>>> cpu:cpreg_vmstate_array_len" error.
>>>>>>
>>>>>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>>>>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>>>>>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>>>>>> migration from a host kernel which features the commit to a destination
>>>>>> host that doesn't fail.
>>>>>>
>>>>>> Currently QEMU is not using that feature so ignoring this latter
>>>>>> is not a problem. An easy way to fix the migration issue is to teach
>>>>>> qemu we don't care about that register and we can simply ignore it,
>>>>>> including its state migration.
>>>>>>
>>>>>> This patch introduces a CPU property, under the form of an array of
>>>>>> reg indices which indicates which registers can be ignored.
>>>>>>
>>>>>> The goal then is to set this property in machine type compats such
>>>>>> as:
>>>>>> static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>>>>>>    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>>>>>>    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>>>>>> }
>>>>> One thing worth noting - once this series lands:
>>>>> https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/
>>>>>
>>>>> we might need to add a bit more logic here. Either using the kvm
>>>>> interfaces (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2 when the register
>>>>> value is 0) or qemu knowledge (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>>>> when the impl-cpu property is not used).
>>>> Effectively if we "hide" KVM_REG_ARM_VENDOR_HYP_BMAP_2 on save/restore
>>>> we must enforce the reg is not used by userspace.
>>>>
>>>> One way would be to test whether KVM_REG_ARM_VENDOR_HYP_BMAP_2 is hidden
>>>> in kvm_arm_target_impl_cpus_supported() and if it is, report false.
>>>> However for every new functionality in qemu it does not sound sensible
>>>> to check whether new KVM regs being used are anonymously hidden.
>>>>
>>>> Another way could be to fail kvm_set_one_reg/kvm_get_one_reg in case the
>>>> register is hidden. That way in Shameer's series, kvm_arch_init_vcpu()
>>>> would fail if BMAP_2 is hidden, ie. in our example for all machines
>>>> types before 10.2. By the way adding Shameer.
>>> I think tying this to the state of the reg (hidden or not) is less
>>> error-prone (I'd assume we'd have different ways of detecting whether
>>> something is used for future cases, and "is the reg hidden?" would work
>>> in all cases.) We'd need to tie migration to matching machine versions
>>> anyway, I think.
>>>
>> I guess you suggest to check the hidden/fake state in
>>
>> kvm_set_one_reg/kvm_get_one_reg too. One issue is those helpers are arch agnostic. I would need to either introduce a callback in the CPU class to check the actual status or add the props in the parent CPU object. Or introduce a KVM IOTCL to teach KVM a reg shall never be accessed.
> Aren't they always called from arch code, though? We could easily wrap
> them for arm, I think. (Unless there's some more generic interest in
> conditional ONE_REG accesses.)

For the time being I chose to add a new CPU class callback to check
whether the reg is hidden in kvm_set/get_one_reg.
Let's wait for other comments ... ;-)

Thanks

Eric
>


