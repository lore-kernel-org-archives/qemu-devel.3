Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A58D597AA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 22:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAzHL-000629-No; Tue, 12 Nov 2024 17:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAzHJ-00061a-Ee
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAzHH-0001De-Kh
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731450145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3o0DKyNkxN5HS2qO4ZFqK7rqbTR2jz7047eqx7d5yDk=;
 b=IxEhyUPrVs2+mGux1hFAqONAJXf9DfsnjaKCCDXVh4VeF/+zfRTSjJmiciM4UU2yPywmIF
 cyNINQDu/1G7/ASQI84SL4iIBCK52BNT3zg4rh0Ky1+DaitWmI3jvi9oTfW8s3KzVex93h
 NCJXzvVWhsP+pqK/au8ZKGjXKjcKNg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-J80XiG0IOWqmvqXC6LpfCw-1; Tue, 12 Nov 2024 17:22:24 -0500
X-MC-Unique: J80XiG0IOWqmvqXC6LpfCw-1
X-Mimecast-MFC-AGG-ID: J80XiG0IOWqmvqXC6LpfCw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so46320775e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 14:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731450143; x=1732054943;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3o0DKyNkxN5HS2qO4ZFqK7rqbTR2jz7047eqx7d5yDk=;
 b=XB/PLRV6tllx+3t6k7YjaugAYPm6D4jKvvVaZtvN9iF7OFYS3AWUoEUEB5u6FVlJdR
 VjoQtOm5K+3fi1zxCh47iWjuYwotVJ2MSHeCV60GoGpMOB+bmeM5RwGAN4YNqafEMIYn
 wYZJ4FhxUZfiqwBHW0JleCpUM0NJHJX5uGXXI8ErRVuWKcW8udiw8M3noOlEyX9R1kDe
 QQav5iZHc21nGy8O0rpP8g9hVMbsfvwRrEqOwfRPr82PLvaGSc6Kr7Gi7K8B47ng6tB0
 ZeRPXfU24HhoklpT/OZpAuhKBi3PzFsz8tuU3CX1DikbecSIgNc6xNtOsXcVrXzATJ2y
 aYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXysKDAHoOjC0ItNFC1lnfO4kIyGTR3WaMBlqL3L3TkG0PDu68TFdxTf4rFXKSfWfcxTeMeM0Eoiv3S@nongnu.org
X-Gm-Message-State: AOJu0Yw9FICmHFtx3oCyIiAKNJSYYZyVFEld2dX0vHgeMRZF8I0IZ5dK
 H6kaVAQxljqk4DSSK72cPWaatjE7QU0ptGCyaSDMF4xRdTDRFENFI5jxKVFE7NVJQCh+o0KWvr4
 +7LJk50AtT+p0uBrby2zVmQAFegeym4bcqg0aI9eYyorYF7euMRjq
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-432b7501fdemr163843275e9.14.1731450143075; 
 Tue, 12 Nov 2024 14:22:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7vJgFJ6cnT2cMByJDAJyPfZoHyd8+ZgKel+fJKu7cHyD+JghCm0HBpC3v2yBE83mGk0ivvA==
X-Received: by 2002:a05:600c:4f09:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-432b7501fdemr163843015e9.14.1731450142643; 
 Tue, 12 Nov 2024 14:22:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d?
 (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de.
 [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54e2cbesm1321355e9.4.2024.11.12.14.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 14:22:22 -0800 (PST)
Message-ID: <e5d6bae8-a3bd-4225-b38f-65de6b1a2b54@redhat.com>
Date: Tue, 12 Nov 2024 23:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] accel/kvm: Report the loss of a large memory page
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
 <20241107102126.2183152-4-william.roche@oracle.com>
 <f5b43126-acbd-4e3f-8ec4-3a5c20957445@redhat.com>
 <08e03987-3c9a-49b2-adf5-fd40e7ede0c0@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <08e03987-3c9a-49b2-adf5-fd40e7ede0c0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12.11.24 19:17, William Roche wrote:
> On 11/12/24 12:13, David Hildenbrand wrote:
>> On 07.11.24 11:21, “William Roche wrote:
>>> From: William Roche <william.roche@oracle.com>
>>>
>>> When an entire large page is impacted by an error (hugetlbfs case),
>>> report better the size and location of this large memory hole, so
>>> give a warning message when this page is first hit:
>>> Memory error: Loosing a large page (size: X) at QEMU addr Y and GUEST
>>> addr Z
>>>
>>
>> Hm, I wonder if we really want to special-case hugetlb here.
>>
>> Why not make the warning independent of the underlying page size?
> 
> We already have a warning provided by Qemu (in kvm_arch_on_sigbus_vcpu()):
> 
> Guest MCE Memory Error at QEMU addr Y and GUEST addr Z of type
> BUS_MCEERR_AR/_AO injected
> 
> The one I suggest is an additional message provided before the above
> message.
> 
> Here is an example:
> qemu-system-x86_64: warning: Memory error: Loosing a large page (size:
> 2097152) at QEMU addr 0x7fdd7d400000 and GUEST addr 0x11600000
> qemu-system-x86_64: warning: Guest MCE Memory Error at QEMU addr
> 0x7fdd7d400000 and GUEST addr 0x11600000 of type BUS_MCEERR_AO injected
> 

Hm, I think we should definitely be including the size in the existing 
one. That code was written without huge pages in mind.

We should similarly warn in the arm implementation (where I don't see a 
similar message yet).

> 
> According to me, this large page case additional message will help to
> better understand the probable sudden proliferation of memory errors
> that can be reported by Qemu on the impacted range.
> Not only will the machine administrator identify better that a single
> memory error had this large impact, it can also help us to better
> measure the impact of fixing the large page memory error support in the
> field (in the future).

What about extending the existing one to something like

warning: Guest MCE Memory Error at QEMU addr $ADDR and GUEST $PADDR of 
type BUS_MCEERR_AO and size $SIZE (large page) injected


With the "large page" hint you can highlight that this is special.


On a related note ...I think we have a problem. Assume we got a SIGBUS 
on a huge page (e.g., somewhere in a 1 GiB page).

We will call kvm_mce_inject(cpu, paddr, code) / 
acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)

But where is the size information? :// Won't the VM simply assume that 
there was a MCE on a single 4k page starting at paddr?

I'm not sure if we can inject ranges, or if we would have to issue one 
MCE per page ... hm, what's your take on this?


-- 
Cheers,

David / dhildenb


