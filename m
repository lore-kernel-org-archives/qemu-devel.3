Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B20AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlfi-0003mI-3z; Thu, 12 Dec 2024 11:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlfg-0003lg-Gg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLlfY-0001gt-CA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734019442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O2FeCasfTCDWNjup0wvu4++3ookbsXZ8av7Z7qJZrMY=;
 b=fT3sWkV/wZ05LJvNJav6AfW1+QRVgl7Ta0RDm1Eo9TVZ1YzA7Kwew4YojgHRhBVphA9VZs
 ka8JHE/QBxkQK8MFZTxuEWLq/WHS0Ml5LaI4TLNCbAh1JUj6o2cmqNxzmzrdmG/kHLRGC/
 LrCNAQ8hHlSQQsX4ryG+11FGk3SclFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-YyUDM5OxOtGHoZO4hDRsWQ-1; Thu, 12 Dec 2024 11:03:59 -0500
X-MC-Unique: YyUDM5OxOtGHoZO4hDRsWQ-1
X-Mimecast-MFC-AGG-ID: YyUDM5OxOtGHoZO4hDRsWQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so4981585e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019438; x=1734624238;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2FeCasfTCDWNjup0wvu4++3ookbsXZ8av7Z7qJZrMY=;
 b=bJqt0a0bp/KeEOgWhmXug+xokkez8W7CZ886LTF65In1udVuGsq1Ft1ZIB55Uudjp2
 n07qpqmFgt2ZAQtTJq0V651hHN5Vwg7zjc27REwi6Oo5RLgVI7xgDBjUGRqRk9z560Nh
 xTildPFuPzu8TVhGlAjiMvGN4Q5jf0pWnEq25d+j8x35v/pP7IUprddAyLg/qlAvUYdZ
 EzhIT0CjR1KQW2oYR+7lG+6jECdr77GCiedxLGX1Zz6U6Eas5H/PyYbQMco6/2JzhS55
 GUm0BImSEx/6hCwKHC4QWivJ/HsD1D3iE8fEI52JTw7/EEW8SXiV3AxT4wZf+1gNFOgr
 Z0nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX597Oj60aHlTXT4/I+nzIfACRRYnr8CDPnx0qXGHHz0IWa9BI4ICxM71G8PcofnEwnYwF2Y04VyxtB@nongnu.org
X-Gm-Message-State: AOJu0Yw3u2LEG7n7QjejS1v1/72Cv8w/r7gLq8AvNAr4uBB/kMJKxlWY
 MM5IcBA526OnyM3maOX8jYvTeXOOgQrBUPkNqrU4aOIs7PyoLRzDZCHg4qlUbjqgunfo7+g33Dh
 jtGNWI1RrQACsONmUhdEleNokXzmUqMlN1tU1b/fZrmfd9uhZBk8NnM9HJvXa
X-Gm-Gg: ASbGncuorp9tEny/Y9muGQ/O/33DEjvnHjmidhNZHvHgPpZVMA63B9tV11WQdgL2nRc
 wkImywhnjze7PbPqo2zGttNHjwSgOCTZjhHTIU02lM/MPwKIjw1In/Fy3RXThVNC8L0PgXKSsuS
 Hka538fnVPfrS8jAOT2wZEjjyLTOEnVarI6Iq545IkFYhNB+3ZK3bg22rTEqP6ksUF6Ps61x8gx
 aSqpYM2drIO89GbUzUfpTKDv3ZEEnbTzbgZT9jcTb/ABE+JoDtr4ZU3oHIM
X-Received: by 2002:a05:600c:1d15:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-4362285f785mr31423225e9.25.1734019436610; 
 Thu, 12 Dec 2024 08:03:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGNuUDavo2N97B2FMW5UKpbHf0RFUutY5rTGY18bxlvfv4bGoqwSTNNV0Sa0WrOYgeMBL3Kw==
X-Received: by 2002:a05:600c:1d15:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-4362285f785mr31420475e9.25.1734019433975; 
 Thu, 12 Dec 2024 08:03:53 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43625550518sm20682295e9.5.2024.12.12.08.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 08:03:53 -0800 (PST)
Message-ID: <1a5e2988-9a7d-4415-86ad-8a7a98dbc5eb@redhat.com>
Date: Thu, 12 Dec 2024 17:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
To: Zhao Liu <zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: xiaoyao.li@intel.com, qemu-devel@nongnu.org, seanjc@google.com,
 michael.roth@amd.com, rick.p.edgecombe@intel.com, isaku.yamahata@intel.com,
 farrah.chen@intel.com, kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <Z1qZygKqvjIfpOXD@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z1qZygKqvjIfpOXD@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/12/24 09:07, Zhao Liu wrote:
> On Thu, Dec 12, 2024 at 11:26:28AM +0800, Binbin Wu wrote:
>> Date: Thu, 12 Dec 2024 11:26:28 +0800
>> From: Binbin Wu <binbin.wu@linux.intel.com>
>> Subject: [PATCH] i386/kvm: Set return value after handling
>>   KVM_EXIT_HYPERCALL
>> X-Mailer: git-send-email 2.46.0
>>
>> Userspace should set the ret field of hypercall after handling
>> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>>
>> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>> ---
>> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
>> otherwise, TDX guest boot could fail.
>> A matching QEMU tree including this patch is here:
>> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
>>
>> Previously, the issue was not triggered because no one would modify the ret
>> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
>> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
>> value could be modified.
> 
> Could you explain the specific reasons here in detail? It would be
> helpful with debugging or reproducing the issue.
> 
>> ---
>>   target/i386/kvm/kvm.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 8e17942c3b..4bcccb48d1 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>>   
>>   static int kvm_handle_hypercall(struct kvm_run *run)
>>   {
>> +    int ret = -EINVAL;
>> +
>>       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
>> -        return kvm_handle_hc_map_gpa_range(run);
>> +        ret = kvm_handle_hc_map_gpa_range(run);
>> +
>> +    run->hypercall.ret = ret;
> 
> ret may be negative but hypercall.ret is u64. Do we need to set it to
> -ret?

If ret is less than zero, will stop the VM anyway as
RUN_STATE_INTERNAL_ERROR.

If this has to be fixed in QEMU, I think there's no need to set anything
if ret != 0; also because kvm_convert_memory() returns -1 on error and
that's not how the error would be passed to the guest.

However, I think the right fix should simply be this in KVM:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146f..e2118ba93ef6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10066,6 +10066,7 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
  		}
  
  		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
+		vcpu->run->ret                = 0;
  		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
  		vcpu->run->hypercall.args[0]  = gpa;
  		vcpu->run->hypercall.args[1]  = npages;

While there is arguably a change in behavior of the kernel both with
the patches in kvm-coco-queue and with the above one, _in practice_
the above change is one that userspace will not notice.

Paolo

>> -    return -EINVAL;
>> +    return ret;
>>   }
>>   
>>   #define VMX_INVALID_GUEST_STATE 0x80000021
>>
>> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
>> -- 
>> 2.46.0
>>
>>


