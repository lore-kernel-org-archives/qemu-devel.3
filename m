Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABDD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzzp-0001l2-65; Fri, 15 Nov 2024 12:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBzzk-0001kg-HL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBzzi-0000qH-Ac
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0+ejgmuJB3V2O2WYI8XqlXSmKnq9xsdZLaYqBP/ydSQ=;
 b=DLZUGV/mB/hcrZ7WBoX7TxgVnKRBxzIVclPyN8QdqfPzQeTG8M8d0AiXtadjSUeCGBCqt9
 x/sopKQpRYY8bQmtDZF1uCLh+tfkeBl1bBR3QTlKM/nL7e8z40ipOLPHd+LwecZkoVBdcj
 tLzTsLmPJchaOFOAUv4LVgYuNRul1ig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-y4tP-2vsMziGVRAODP4haQ-1; Fri, 15 Nov 2024 12:20:25 -0500
X-MC-Unique: y4tP-2vsMziGVRAODP4haQ-1
X-Mimecast-MFC-AGG-ID: y4tP-2vsMziGVRAODP4haQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so14337105e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691225; x=1732296025;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0+ejgmuJB3V2O2WYI8XqlXSmKnq9xsdZLaYqBP/ydSQ=;
 b=O+AI7BgBQT+ywZc8PYBlXGVyqnIHE0NwSX2NoUyjMU7RrPQlbUxyEsLBkKAZ3JMDt2
 zn7SFNQyF3dQ7gudf0VAPHawzv0DjX4Ww///u716G/vX2xpoPtN0bk4j5CPaakqfMI6k
 QyBV+BWVMEnd72hv9+NxVll9iCjmINoAkOo6YNKh6SNvvNu+T5Lunbu4m29P2X1mQFth
 srqykOhP0twP4XIO2tGsFpfEJ22tqYy3l29pBGQ/vM39xp/oBAz/lb6n9KQt9Gr80kkW
 LWOso/mSmV6981DzWD9kRR+YYSTmjVmoiaxa/SjtZiCcIknddrsGEnQJ1HBB+qF80ck/
 ozkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXge1nVcGiDtdY8G2UQxtlSuWe6uSOxOBOdA2iA2ALNOMeVjiHPYYuAM0eTwFgUBOzN/kRVc8O6H7ZU@nongnu.org
X-Gm-Message-State: AOJu0YyxamABrZPIjKtX3gI3W92hzUHe5c+MYyZYz1Vbmij4oGNMAm1k
 Z5ArLUJ9+fkkrHq7BLeIirAUk1kHcry5hIU09uWdqDaEO3GVkVxt8hvOIrxJRiMX9P/fJDF7SQG
 e1Ymr7f21c5zbkT20M6eYIPIUAlGnIho4zQmIM+PGAH1dxoCp+1TA
X-Received: by 2002:a5d:59ad:0:b0:382:2f62:bd45 with SMTP id
 ffacd0b85a97d-3822f62bff4mr1029810f8f.29.1731691224704; 
 Fri, 15 Nov 2024 09:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiHc0aA9rNB4klNL+ebkxJEuTEkAuN+XQpT94vaI8oEt4AheK1W4WQXFlmF2ArotLZ+4sP4Q==
X-Received: by 2002:a5d:59ad:0:b0:382:2f62:bd45 with SMTP id
 ffacd0b85a97d-3822f62bff4mr1029789f8f.29.1731691224330; 
 Fri, 15 Nov 2024 09:20:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec?
 (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de.
 [2003:cb:c721:8100:177e:1983:5478:64ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbeb47sm4844132f8f.63.2024.11.15.09.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:20:22 -0800 (PST)
Message-ID: <23912b62-9a91-4489-abc1-5d8b34231303@redhat.com>
Date: Fri, 15 Nov 2024 18:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Enable shared device assignment
To: Rob Nertney <rnertney@nvidia.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
 <b7197241-7826-49b7-8dfc-04ffecb8a54b@intel.com>
 <84ef5f82-6224-4489-91be-8c1163d5b287@intel.com>
 <Zzd69pa75CKM1OzU@rnertney-mlt>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zzd69pa75CKM1OzU@rnertney-mlt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On 15.11.24 17:47, Rob Nertney wrote:
> On Tue, Oct 08, 2024 at 04:59:45PM +0800, Chenyi Qiang wrote:
>> Hi Paolo,
>>
>> Kindly ping for this thread. The in-place page conversion is discussed
>> at Linux Plumbers. Does it give some direction for shared device
>> assignment enabling work?
>>
> Hi everybody.

Hi,

> 
> Our NVIDIA GPUs currently support this shared-memory/bounce-buffer method to
> provide AI acceleration within TEE CVMs. We require passing though the GPU via
> VFIO stubbing, which means that we are impacted by the absence of an API to
> inform VFIO about page conversions.
> 
> The CSPs have enough kernel engineers who handle this process in their own host
> kernels, but we have several enterprise customers who are eager to begin using
> this solution in the upstream. AMD has successfully ported enough of the
> SEV-SNP support into 6.11 and our initial testing shows successful operation,
> but only by disabling discard via these two QEMU patches:
> - https://github.com/AMDESE/qemu/commit/0c9ae28d3e199de9a40876a492e0f03a11c6f5d8
> - https://github.com/AMDESE/qemu/commit/5256c41fb3055961ea7ac368acc0b86a6632d095
> 
> This "workaround" is a bit of a hack, as it effectively requires greater than
> double the amount of host memory than as to be allocated to the guest CVM. The
> proposal here appears to be a promising workaround; are there other solutions
> that are recommended for this use case?

What people we are working on is supporting private and shared memory in 
guest_memfd, and allowing an in-place conversion between shared and 
private: this avoids discards + reallocation and consequently any double 
memory allocation.

To get stuff into VFIO, we must only map the currently shared pages 
(VFIO will pin + map them), and unmap them (VFIO will unmap + unpin 
them) before converting them to private.

This series should likely achieve the 
unmap-before-conversion-to-private, and map-after-conversion-to-shared, 
such that it could be compatible with guest_memfd.

QEMU would simply mmap the guest_memfd to obtain a user space mapping, 
from which it can pass address ranges to VFIO like we already do. This 
user space mapping only allows for shared pages to be faulted in. 
Currently private pages cannot be faulted in (inaccessible -> SIGBUS). 
So far the theory.

I'll note that this is likely not the most elegant solution, but 
something that would achieve in a reasonable timeframe one solution to 
the problem.

Cheers!


-- 
Cheers,

David / dhildenb


