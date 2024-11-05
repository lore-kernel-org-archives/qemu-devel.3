Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2709DD12693
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I7s-0004FB-3t; Tue, 05 Nov 2024 06:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8I7q-0004F0-P1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8I7p-0001z1-0t
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730807610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E9GCCeK8H/eNEIQ4EVE9mAtGB0y27+rVaBOR1tTIrZ4=;
 b=ew6clH92W6izRPo6KsIpmHrMEGZISlG48D+caQhKcZqjJTBxWfX0NvvpjoO6SDpGdL8buB
 bAZkhMECdtonkg9SIk880CEpvcHqNNAW5ip4yu38TedEtik4/sdEGrHvbxb9l30YaErPxy
 hbv97yFJFOVmNvzeCylbw38BVo+nNTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-CZcbLzKFP-eg90NxBWcVaw-1; Tue, 05 Nov 2024 06:53:29 -0500
X-MC-Unique: CZcbLzKFP-eg90NxBWcVaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso35465185e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730807608; x=1731412408;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E9GCCeK8H/eNEIQ4EVE9mAtGB0y27+rVaBOR1tTIrZ4=;
 b=acWuKUH3bk4DKCdcodzSU3qr0GFdRE0kUZiKPFKk1RJAP3t8gmhpxOeN3RAErFxCUZ
 Qom5zwGt/YQuoS7cew0a+AmPE7OvMvhRXHl9C5cjWYgfcFVOQkRKwgGC5foe4Gh9PAiy
 JOQe+pKF38MiICdFrX0bFocI/WaLsHmNTn7AY72QcazW5qeBfYuKQgfMYJHvAeBfKVHo
 AVVPSbo6dKh1oIfCf0mEO/0rlqQx2oKmhGZXrp4RYZsWcyIpI9BSrsoXoB73BpSDdwAC
 Yu1v9GfWMZBNbe221XjDzX8jJQZwE88NTuXYmayqzx1YXcgnp9K8oMfbO1QA1FkGAtwl
 QNrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7PJ1//IO+kmv2vD9/M94fSiSGTEeihuyVPwlAltY2j45I39qHhmCctTsXPh68pEr8vrzWbAGhfgPg@nongnu.org
X-Gm-Message-State: AOJu0YwyRrigEeQEbr2cmhHd0RGtYvM8A876EK81kzdYGCb/7JJc2Dgy
 t7qHZOTYkg28TJylEcXHc4hwOKMK4iQzkSnhH9GoC67HLiJeRUAkDYQbbzxupnJ1d5Ft+Us/tfE
 ciyNo1XHPKpTrSV6WxAeb+Kk6dPCI6BOkEOLKbg6L6mzAqPpWa/3k
X-Received: by 2002:a05:600c:354e:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-43283297ac6mr147935915e9.31.1730807608398; 
 Tue, 05 Nov 2024 03:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6EqY6VfpsDjvDwkrOiOHAjD2Nj9rcwaC+RwyaQlFF6KPQP+tdcTVgv2YGxElyqcm3HhSRvQ==
X-Received: by 2002:a05:600c:354e:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-43283297ac6mr147935685e9.31.1730807608018; 
 Tue, 05 Nov 2024 03:53:28 -0800 (PST)
Received: from [192.168.10.28] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e8562sm186017205e9.23.2024.11.05.03.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 03:53:27 -0800 (PST)
Message-ID: <44627917-a848-4a86-bddb-20151ecfd39a@redhat.com>
Date: Tue, 5 Nov 2024 12:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
To: Xiaoyao Li <xiaoyao.li@intel.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-35-xiaoyao.li@intel.com>
 <82b74218-f790-4300-ab3b-9c41de1f96b8@redhat.com>
 <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2bedfcda-c2e7-4e5b-87a7-9352dfe28286@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/5/24 12:38, Xiaoyao Li wrote:
> On 11/5/2024 6:06 PM, Paolo Bonzini wrote:
>> On 11/5/24 07:23, Xiaoyao Li wrote:
>>> +static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
>>> +                              Error **errp)
>>> +{
>>> +    X86CPU *cpu = X86_CPU(cs);
>>> +    uint32_t host_phys_bits = host_cpu_phys_bits();
>>> +
>>> +    if (!cpu->phys_bits) {
>>> +        cpu->phys_bits = host_phys_bits;
>>> +    } else if (cpu->phys_bits != host_phys_bits) {
>>> +        error_setg(errp, "TDX only supports host physical bits (%u)",
>>> +                   host_phys_bits);
>>> +    }
>>> +}
>>
>> This should be already handled by host_cpu_realizefn(), which is 
>> reached via cpu_exec_realizefn().
>>
>> Why is it needed earlier, but not as early as instance_init?  If 
>> absolutely needed I would do the assignment in patch 33, but I don't 
>> understand why it's necessary.
> 
> It's not called earlier but right after cpu_exec_realizefn().
> 
> Patch 33 adds x86_confidenetial_guest_cpu_realizefn() right after 
> ecpu_exec_realizefn(). This patch implements the callback and gets 
> called in x86_confidenetial_guest_cpu_realizefn() so it's called after
> cpu_exec_realizefn().
> 
> The reason why host_cpu_realizefn() cannot satisfy is that for normal 
> VMs, the check in cpu_exec_realizefn() is just a warning and QEMU does 
> allow the user to configure the physical address bit other than host's 
> value, and the configured value will be seen inside guest. i.e., "-cpu 
> phys-bits=xx" where xx != host_value works for normal VMs.
> 
> But for TDX, KVM doesn't allow it and the value seen in TD guest is 
> always the host value.  i.e., "-cpu phys-bits=xx" where xx != host_value 
> doesn't work for TDX.
> 
>> Either way, the check should be in tdx_check_features.
> 
> Good idea. I will try to implement it in tdx_check_features()

Thanks, and I think there's no need to change cpu->phys_bits, either. 
So x86_confidenetial_guest_cpu_realizefn() should not be necessary.

Paolo


