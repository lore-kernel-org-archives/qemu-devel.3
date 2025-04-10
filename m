Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5AAC369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2vDp-0004E7-JE; Thu, 10 Apr 2025 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2vDo-0004Ds-4P
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2vDm-0001pd-9v
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744304262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M5FzrRknDBF+rBZlrff8o23RTzd1+qMrKBFK3Dp7nQ0=;
 b=WxHvJwyaM28jBnEmlhFJGKZq8CkgLlPeHgpFurRkI3ijjYYt8QPHDmOMRrd8BOCYWt5avy
 T+FO7+gpffmO1R3BXbT7bGrPCUy40UaElWYbInKuILntbdK8KvpM8j6c6j8IeRUT45ODZH
 k79IWnF709SLCrONonoV1SdCWrWRf9I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-FsWKKFfMMgy1DKvHpgIUMg-1; Thu, 10 Apr 2025 12:57:41 -0400
X-MC-Unique: FsWKKFfMMgy1DKvHpgIUMg-1
X-Mimecast-MFC-AGG-ID: FsWKKFfMMgy1DKvHpgIUMg_1744304260
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac297c7a0c2so85880766b.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 09:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304259; x=1744909059;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5FzrRknDBF+rBZlrff8o23RTzd1+qMrKBFK3Dp7nQ0=;
 b=Tbhyvwkq+Z5HzSqZarq0fZsZdXbXk/3WZE2WLRyavt3ar1KgIx+Lz0GXY5JQE6eC0M
 mjyt9WfR8ZPWVZnixFN1trAl1oGvWDASzXuJMcShxUcpMLPpz+Gg9epnMCI6n6n7PHgI
 B8owFrAW40K5RZu9cUkkDh+Gu/iZCd+KRJmpSxZy9raJyj1CKy1kjvUIpby/8q4Om0ij
 /ECeeCS9vqhNBiqxF7iSmqvTerueq3xkWKTn7kLiCtVIvhzRNAJHOfGh8x18EjAPWbn5
 6tiIe3ouXFzvMOEEox0AnnRnX3buLbq5QeA0wRw5Q3fedwj4TS5abmfFnAMyCkx+pdhw
 ARHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2wELTLdQFNz/17OuRpE4WjM/IMlOQaQKzDRPk6hFcUoMxDwBFpWbHkGkEmHq2A9CkUOvrl5BaBIqS@nongnu.org
X-Gm-Message-State: AOJu0YymfW7z5FR30aDViA+EIYYDuLBgx6YcKxJkjeZbhT6DHoBy+jj2
 RwXzwzqRSYmqg9KGSvzBl4DDeI7vzo0ReiY3P/usOEZtmK3I0efeShuDPwNRwUmkNlJ0mRvrkmh
 MRYegoNlwq1JTWbiW70R14wD9HNrTlGy2gy1C2tRPzVF1JIiXA4cHchYd9Asc
X-Gm-Gg: ASbGncuHXIfrVQ3HfGbpWxII3OEWK0bQ4n21WWsdTB0Z3KywBHLwmOJvNASnXdGsHtX
 iwNBQbUEDMFFyUOtSgI3x7AXEQcuG2mO4cjgH6G7f1OunGchwMpJfdpNvPaTcGYvtfj7OTOy7cm
 yh7X150K1m2hcfo9Y6qhWunBM3fbPJOf4puhPmRfgTlfGqNVkAqHpM7sXh2NNw71t7QO4wAaQHS
 SVz2XrO5z5ohh4egrWCnB0jMLWUJlSseHIAqP05So149+dOHoYtpNZ+6SYL7y8u5VV7NiNRTjuW
 5fENnAAOrV75uy0arcn2J4WUYHqjQoUt4WaO6hg3xg4TV/SHQA==
X-Received: by 2002:a17:907:724b:b0:ac7:3918:752d with SMTP id
 a640c23a62f3a-acabd51b1f7mr300967266b.58.1744304259243; 
 Thu, 10 Apr 2025 09:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7b3YQNsyqR+YWy0enFe1MDc4mkL+CJveTRRUjuzDKoemkvUAfjuukLhs1JdhMRlGSCyapag==
X-Received: by 2002:a17:907:724b:b0:ac7:3918:752d with SMTP id
 a640c23a62f3a-acabd51b1f7mr300964966b.58.1744304258747; 
 Thu, 10 Apr 2025 09:57:38 -0700 (PDT)
Received: from [192.168.213.210] (93-33-70-196.ip43.fastwebnet.it.
 [93.33.70.196]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-acaa1ccd205sm309016566b.141.2025.04.10.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 09:57:37 -0700 (PDT)
Message-ID: <60d159a0-afbc-4314-b165-8711383e9086@redhat.com>
Date: Thu, 10 Apr 2025 18:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Reset parked vCPUs together with the online
 ones
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <e8b85a5915f79aa177ca49eccf0e9b534470c1cd.1743099810.git.maciej.szmigiero@oracle.com>
 <afff3782-08ab-42cd-a32d-33c307c5d9b7@maciej.szmigiero.name>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <afff3782-08ab-42cd-a32d-33c307c5d9b7@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/10/25 17:57, Maciej S. Szmigiero wrote:
> On 27.03.2025 19:24, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Commit 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on VM
>> reset") introduced a way to reset TSCs of parked vCPUs during VM reset to
>> prevent them getting desynchronized with the online vCPUs and therefore
>> causing the KVM PV clock to lose PVCLOCK_TSC_STABLE_BIT.
>>
>> The way this was done was by registering a parked vCPU-specific QEMU 
>> reset
>> callback via qemu_register_reset().
>>
>> However, it turns out that on particularly device-rich VMs QEMU reset
>> callbacks can take a long time to execute (which isn't surprising,
>> considering that they involve resetting all of VM devices).
>>
>> In particular, their total runtime can exceed the 1-second TSC
>> synchronization window introduced in KVM commit 5d3cb0f6a8e3 ("KVM:
>> Improve TSC offset matching").
>> Since the TSCs of online vCPUs are only reset from 
>> "synchronize_post_reset"
>> AccelOps handler (which runs after all qemu_register_reset() handlers) 
>> this
>> essentially makes that fix ineffective on these VMs.
>>
>> The easiest way to guarantee that these parked vCPUs are reset at the 
>> same
>> time as the online ones (regardless how long it takes for VM devices to
>> reset) is to piggyback on post-reset vCPU synchronization handler for one
>> of online vCPUs - as there is no generic post-reset AccelOps handler that
>> isn't per-vCPU.
>>
>> The first online vCPU was selected for that since it is easily available
>> under "first_cpu" define.
>> This does not create an ordering issue since the order of vCPU TSC resets
>> does not matter.
>>
>> Fixes: 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on 
>> VM reset")
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
> 
> Friendly ping?

Applied, thanks.

Paolo


