Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0726BCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fpp-0005RG-P0; Tue, 14 Oct 2025 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v8fpg-0005Na-HJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v8fpd-00061n-BM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760451408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgfOk8B3jU/TP/97nw+aYN/x2JeMujlv5ljYaWvjKd8=;
 b=F0vczpOYIubbZKmAI2lAMrYMIvH/bl29w8ppd4IvE1k0ZAcLpx/C3xpg+DMK3JH9xHw8f5
 KnZrTKUHCMOgbLOki4MvfU8b7nlGCy0lw+7uyVWSxlIpUrm2nF+78iAJ2vcGoKAQkVjwC5
 zwz35VtHS1OIinkQML2/woOdgJR1GhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-dw415jgcOCSFFTb_bfzvdg-1; Tue, 14 Oct 2025 10:16:47 -0400
X-MC-Unique: dw415jgcOCSFFTb_bfzvdg-1
X-Mimecast-MFC-AGG-ID: dw415jgcOCSFFTb_bfzvdg_1760451406
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e509374dcso23987225e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 07:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451406; x=1761056206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SgfOk8B3jU/TP/97nw+aYN/x2JeMujlv5ljYaWvjKd8=;
 b=vWObI9L3zDk8geZK33kpfXU7hjbxKpVyOh90dFTd/VMPdNK3pNzpg38jJgoHrMZkGG
 M4lSklV0TEiBjxUjFim+mOHH2eD5iJJ9Rhuq003xgQc7HOlpYbDcqyuE90ZCrCWWfa1Y
 hUtmIHUhCPzLBZ7sAo5gMrhaBjs7I9sUIWZOdE0w2iiDoxxnI5mpn0v/HoH+yapYczfH
 2dk85wztyO2S54y3Y9vKRkijckrhGci46cvmLndOMQraaxFglleNTqH7bRC9HW9FwFZ6
 j5pnUWKQ7NDS7ipozgUx8XXgW9n6hObaadXwm8XXeVxY5U9NjlNfEgZnLuqWmYpDisjE
 MQoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ppQS8O2Pi8Z+qKkUK7RNSkzDir4Pq6Pg4vrDc2nwxHzv/lVREvu61khWSwTti3IaZS2/VUSDVMNa@nongnu.org
X-Gm-Message-State: AOJu0YwE9pePnJd7y9GRTlQrEq2zw0CQwppLSUe0pe9j43vK6jAbXtUi
 Q3LyOxbtaB/90HjlqPU0b8EwMfeflyVua8OjZbmKkfNU5PDEdNmgCmIjXEW/PpaA5OfhEEkbf4q
 gprlspFCJBbi1N+WtzoTUeF4fYptE//HmP4N2b7dnNVwtJWjYgacn7ul5
X-Gm-Gg: ASbGncuQU5Ff+0PWCwn3Pko9yiyBJBXXeY+YrgbBu2BmgAovMXcGr18v761rYY0zDsV
 6LPxmDiRHzvbyjA+OZoEkWl5RBexgZrRkIfRo5YVAA5sau3CT/9Hvt+ydUgwPo80skbFU8g0KMV
 F74+9gJjz0BxDAt6MpKu/LJpJbTsYCEcEaScdwL5+cLyWfte0Ya4hRKygRS5cZQBj99/QZhikJl
 X4rflsIZpRYuxwl6LnLFvj3Zm3jDnWic+D1IBjh3lllNtGTLFYYfMI9gBl8mbUhOEleo06Ot98r
 Oor8BucxF1kqdZKW6P2qgL5pl8qevoVIyH2agUbBwZjMwgk+Y9Ieqy3bnwTJn2fOKkrDLDH2qZM
 W3aDjaiTFEW8=
X-Received: by 2002:a05:600c:34c4:b0:46f:d682:3df6 with SMTP id
 5b1f17b1804b1-46fd682434fmr21345485e9.35.1760451405661; 
 Tue, 14 Oct 2025 07:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVKWDU/LEoFRvz/OaWfbB9mIGyCz/E39JBEpR8a7egs9SSUMsYNBXuw35EjzVMYkXvvTdWFw==
X-Received: by 2002:a05:600c:34c4:b0:46f:d682:3df6 with SMTP id
 5b1f17b1804b1-46fd682434fmr21345275e9.35.1760451405199; 
 Tue, 14 Oct 2025 07:16:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab4f3b07sm156546175e9.2.2025.10.14.07.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 07:16:44 -0700 (PDT)
Message-ID: <9590ce96-6617-4cfb-849e-b24ea7fcacb9@redhat.com>
Date: Tue, 14 Oct 2025 16:16:43 +0200
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87ikgpv6yo.fsf@redhat.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/8/25 3:49 PM, Cornelia Huck wrote:
> On Fri, Oct 03 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Sebastian,
>>
>> On 9/18/25 6:16 PM, Sebastian Ott wrote:
>>> On Thu, 11 Sep 2025, Eric Auger wrote:
>>>> New kernels sometimes expose new registers in an unconditionnal
>>>> manner.  This situation breaks backward migration as qemu notices
>>>> there are more registers to store on guest than supported in the
>>>> destination kerenl. This leads to a "failed to load
>>>> cpu:cpreg_vmstate_array_len" error.
>>>>
>>>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>>>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>>>> migration from a host kernel which features the commit to a destination
>>>> host that doesn't fail.
>>>>
>>>> Currently QEMU is not using that feature so ignoring this latter
>>>> is not a problem. An easy way to fix the migration issue is to teach
>>>> qemu we don't care about that register and we can simply ignore it,
>>>> including its state migration.
>>>>
>>>> This patch introduces a CPU property, under the form of an array of
>>>> reg indices which indicates which registers can be ignored.
>>>>
>>>> The goal then is to set this property in machine type compats such
>>>> as:
>>>> static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>>>>    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>>>>    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>>>> }
>>> One thing worth noting - once this series lands:
>>> https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/
>>>
>>> we might need to add a bit more logic here. Either using the kvm
>>> interfaces (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2 when the register
>>> value is 0) or qemu knowledge (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>> when the impl-cpu property is not used).
>> Effectively if we "hide" KVM_REG_ARM_VENDOR_HYP_BMAP_2 on save/restore
>> we must enforce the reg is not used by userspace.
>>
>> One way would be to test whether KVM_REG_ARM_VENDOR_HYP_BMAP_2 is hidden
>> in kvm_arm_target_impl_cpus_supported() and if it is, report false.
>> However for every new functionality in qemu it does not sound sensible
>> to check whether new KVM regs being used are anonymously hidden.
>>
>> Another way could be to fail kvm_set_one_reg/kvm_get_one_reg in case the
>> register is hidden. That way in Shameer's series, kvm_arch_init_vcpu()
>> would fail if BMAP_2 is hidden, ie. in our example for all machines
>> types before 10.2. By the way adding Shameer.
> I think tying this to the state of the reg (hidden or not) is less
> error-prone (I'd assume we'd have different ways of detecting whether
> something is used for future cases, and "is the reg hidden?" would work
> in all cases.) We'd need to tie migration to matching machine versions
> anyway, I think.
>
I guess you suggest to check the hidden/fake state in

kvm_set_one_reg/kvm_get_one_reg too. One issue is those helpers are arch agnostic. I would need to either introduce a callback in the CPU class to check the actual status or add the props in the parent CPU object. Or introduce a KVM IOTCL to teach KVM a reg shall never be accessed.

Thoughts?

Thanks

Eric


