Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5866FCCA490
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 01:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHstR-0003CX-9P; Fri, 16 Oct 2026 21:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xHstC-0003Bb-CW
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 21:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xHst7-00020T-8R
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 21:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792199221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
 b=fe1cntVazzuvlMfGm5f748BhDFUoaVF2mU/0Byt1BgxCWwdsYr8hqiIqIdwtVP4eH1bTH2
 zne4vVD6FnJkumQ4APnI0/o09BhkrD+CEfvWrQDNII+UH/d4E5UT9aIRNV4wbu3mVI6ZOC
 uyPrTmqlDrM9zUA+KPDlMw7arh128RA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-g1TT95OPNSWITPW_eCfcjg-1; Sat, 17 Oct 2026 01:06:59 +0000
X-MC-Unique: g1TT95OPNSWITPW_eCfcjg-1
X-Mimecast-MFC-AGG-ID: g1TT95OPNSWITPW_eCfcjg_1792199218
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc435388657so486776a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792199218; x=1792804018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
 b=MJWWg/8/sHcXCK4zm3YVEd9VqVGiJ7ouzIcEmP6jodqytvRqlCv9/8OFyBnqMz8Q5b
 TzTax6ldAoTPAoqPQeShQFTMuZxBwim0GmIKkGuhFfq+V7HyKSPT//kqPHSeQiANz3rl
 myS5AsqrBj2wPOnEd56k8MgHU94fsVh9aZBW+IGFkIKC/ve1l+OArjat2lP/NT7TdZ6O
 PaL3PF2lAKRuBz1UT95xu4jqeqn3cBbo2wk32BPzhKiPaqxoheAeB0aeTgasihN3gR8s
 jZ0jqlvg6L6+vHmSha/qBOGZYzoorZkuzYPdfEqy+21r1p2Yfp3dTWcc9hFLpf9Zp0U9
 NA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792199218; x=1792804018;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
 b=y3hztTWdKjCPpFlHeUZA2u4ejNnMERmKaSc9HsqZY5lM6nB3hQx5UiI6LF9NIzF3Ra
 cNVdHHoy+9Ewte3EBbaFivhVi53l+EOzegEYzxfYkweqAEb5cIEFAJM1AenMocKWOkMf
 4ZnSVYL1tNvIlpPV0xikjyt+x7aEfLSyH0luQpI49kYJhDOL5Nz8ivJjV9lUn1NH2oyl
 PZwuObesKnKxpZWcRd20B3TPVAAS8KEzCgtPZawvORq0EEQIMQSW9A6PytgF138kcrBy
 ss6SwuUkd0qT8YyQMtWUTEUGVP1kjDsAj+c5XsC0MDlkok0ef7x9457DCVgXoGregDPN
 SADA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDQLCl58TLt+xl7Z6Sgabu6B99AOhgTRO5GVZo/J7Wb8hPicPGtz50ypxo2eTL7jIzDtdRyY8JN1A8@nongnu.org
X-Gm-Message-State: AFq9FYLySf41n37AEl4PCLLxGTepuz+bmQH98qXaX+TnYSKt8Ix7h+mI
 ZSX23zZAA16Qm0d7WsAg3oqVFjyzNAllD0Zr74odlhFbMjOitKzMerm2Z6lFkfsej3YrqGJFLgu
 N6KxQ0sKfJqYAlgI1fP2Ek86m1M5UarAPX6cHeOa66mbtblO0IW19/jWd
X-Gm-Gg: AYBFou1G2yrZJtGd8XDkUVch/+rykWupZoLGRW46qU1vBYRiqSCuEHnXbgO1g2N43by
 SmNHmB8PsVd4LbO9XXSPwDUWeKCKqN7pdtd/RkVWsopyDBkjBnHzPmjKQDRKVZjOTensJsJ9hKZ
 ZXVGPA1ny0YoXqQtvGMQFf/d+JL4sRstOvy1FfzdGgxvA4auxW/nt4+HaSmpgxYpYFvZXDE6sIp
 8pOg/mNhDE3JcfGAzV0+rv3f5FBxToey+scP1jKq33UF7tkdmITLYe7hoMFMpUODdqAOo2dDSXN
 wipWxPyyBAWOUtyiRlyBGQ6YjJas8RnwwDmqoskfEksHqrs9unfSd+K1qY0aE+UkB3CB7fcR8Ns
 pQXXKTItG6O/yG/EWzjU60qbPk2u4rD3v3LlyNmdu0A==
X-Received: by 2002:a17:90a:e7c9:b0:3a4:ca46:8d44 with SMTP id
 98e67ed59e1d1-3aceeb95e4cmr1332827a91.18.1792199217994; 
 Fri, 16 Oct 2026 18:06:57 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:3a4:ca46:8d44 with SMTP id
 98e67ed59e1d1-3aceeb95e4cmr1332766a91.18.1792199216281; 
 Fri, 16 Oct 2026 18:06:56 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc38b457esm6669073a91.0.2026.10.16.18.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 18:06:55 -0700 (PDT)
Message-ID: <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
Date: Sat, 17 Oct 2026 11:06:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com> <atKEWmnXA-Gu1Y9T@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atKEWmnXA-Gu1Y9T@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/17/26 6:08 AM, Mathieu Poirier wrote:
> On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> Once the Realm descriptor has been created, tell KVM to transfer runtime
>>> images (kernel, DT, and rootfs) from guest memory to Realm memory.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 76 insertions(+)
>>>
>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>> index 9985f5daba89..c082a5d8f3d1 100644
>>> --- a/target/arm/kvm-rme.c
>>> +++ b/target/arm/kvm-rme.c
>>> @@ -15,6 +15,7 @@
>>>    #include "migration/blocker.h"
>>>    #include "qapi/error.h"
>>>    #include "qemu/error-report.h"
>>> +#include "qemu/memalign.h"
>>>    #include "qom/object_interfaces.h"
>>>    #include "system/confidential-guest-support.h"
>>>    #include "system/kvm.h"
>>> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>    static RmeGuest *rme_guest;
>>> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
>>> +                              Error **errp)
>>> +{
>>> +    int ret;
>>> +    void *buffer;
>>> +    hwaddr size = region->size;
>>> +    hwaddr base = region->base;
>>> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
>>> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
>>> +    struct kvm_arm_rmi_populate populate_args;
>>> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
>>
>> s/qemu_real_host_page_size()/RME_PAGE_SIZE
> 
> I refactored this function in V5 [1], along with the above declarations.
> 
> [1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/
> 
>>
>>> +
>>> +    if (!region->data) {
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    ret = kvm_set_memory_attributes_private(start, end - start);
>>> +    if (ret) {
>>> +        error_report("RME: failed to configure initial"
>>> +                     "private guest memory");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Allocate page-aligned memory */
>>> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
>>> +
>>> +    if (!buffer) {
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    memset(buffer, 0, aligned_size);
>>> +    memcpy(buffer, region->data, region->size);
>>> +
>>> +    populate_args = (struct kvm_arm_rmi_populate) {
>>> +        .base = start,
>>> +        .size = end - start,
>>> +        .source_uaddr = (uintptr_t)buffer,
>>> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
>>> +    };
>>> +
>>> +    while (populate_args.size > 0) {
>>> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, -ret,
>>> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>>> +                start, end);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    qemu_vfree(buffer);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>
>> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
>> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
>> is 64KB. The question is how do we know the added regions due to the alignment
>> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
>> I guess we probably just reject unaligned regions if they're not expected.
> 
> To make sure I understand your point, please expand on what would be an
> unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries.
> 
>>
>> Even if the unaligned regions are allowed, they seem not well handled.
>>
>> - @aligned_size is still 64KB instead of the 128KB ?
> 
> I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?
> 

ROUND_UP(64KB+4KB, 64KB) corresponds to ROUND_UP(size+base, 64KB) for local
variable @end instead of @aligned_size. @aligned_size is calculated as
ROUND_UP(64KB, 64KB) and the output is still 64KB.

>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> 
> I agree with you.  That part was refactored in V5 [1]:
> 
>          memcpy(buffer + (base - start), region->data, region->size);
> 
>>
>>> +static void rme_populate_ram_region(gpointer data, gpointer err)
>>> +{
>>> +    Error **errp = err;
>>> +    const RmeRamRegion *region = data;
>>> +
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>> +
>>> +    rme_populate_range(region, /* measure */ true, errp);
>>> +}
>>> +
>>>    static void rme_vm_state_change(void *opaque, bool running, RunState state)
>>>    {
>>> +    Error *errp = NULL;
>>> +
>>>        if (!running) {
>>>            return;
>>>        }
>>> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
>>> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
>>> +    if (errp) {
>>> +        return;
>>> +    }
>>> +
>>>        kvm_mark_guest_state_protected();
>>>    }
>>

Thanks,
Gavin


