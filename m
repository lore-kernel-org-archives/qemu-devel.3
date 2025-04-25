Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB10C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8IUe-0007qT-G9; Fri, 25 Apr 2025 08:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8IUc-0007q2-B7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u8IUa-0006vS-K3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745585357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QYGRSk9EMOc+ohdOFgvOsQqhOO83k3hgQYJev3Y0mt8=;
 b=J/02qZSjrKvI2kNBOmnwc+TP+jLxOXQwrlCIhwrf19j3D1BK12HJifr5nWJa0WhazOmBtc
 Xjg1YC9NoiVSwNGE/CtKxOV3tBi32zFlD+Ucynd2UlWkyD/BdEO/Ea7NgPy7nrWl87ZzcH
 +z3QisrCWNvtSW5mZSBGQPiwN1IvcKM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-gx3lvUN_ORaHcTVjSygQ8w-1; Fri, 25 Apr 2025 08:49:16 -0400
X-MC-Unique: gx3lvUN_ORaHcTVjSygQ8w-1
X-Mimecast-MFC-AGG-ID: gx3lvUN_ORaHcTVjSygQ8w_1745585355
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so1132951f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745585355; x=1746190155;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QYGRSk9EMOc+ohdOFgvOsQqhOO83k3hgQYJev3Y0mt8=;
 b=v5+mD5IgFfZRWKVI9HUolvHGtxA3ht2YIDzL7dj/kXCSFa73ObyLkTXdjZ6h/rxevD
 /vqF0MSRqUvNlh8dspm9occ7r3f1a95S40IWz+6xbm753Y8HoRtAw5DZ2Cg4HXk0VK1Z
 11acuCa8ou+2UYclf/C2+d1Cx3/sky/7ka1DpcwYm7hmJvJwiAS6+xpv+UIjwhtodPKw
 VdeN2/9ofhfBokMALU8wq8hm8KI8nQaetecl+ojcjH+gxx8T/JVABtpOTDq3Td8ulyPI
 vmBxKGecDI1hcQMhG9RqObM40grjCQZEKj1+QjYHJdA8FR6zAumj2rdIzScJdy8YoArd
 5MRQ==
X-Gm-Message-State: AOJu0Ywvms+AmaQYAOCPgJ5wSd6rRjuv5m+TpBrdBkaHH9ga/xUNOc8d
 5wTqoqoe2tn28tBy+leIQD3G2m3FyxtfqP8EmqiTdDXBAHqDk1uMzIuYiFxhUXwLxVVXpj5QLKj
 MdHDeDEteUEYTK3HDPctOAPQ7sg+32aaaebhwoqEQKE8DhmbjFf2d
X-Gm-Gg: ASbGnctGWLr3zgAq1R4XjDI3oomEl5m3pXZiCdrOl7m4+QMFFvSDv/CmxWBL2sPyy7Q
 ywpPjRSMkw57Uy4KKgUDAdjhFWOv659piJ9IL6ddXQAEnncBKQK3C/9nuid/eLFTG2xgUFfm23l
 FK09sLhQfyqgZ9EaAMwpFTgdmf+RcF4K2dG9Yqf0foO601Ejj4O38qSyoPbdjt69L4w2WNn89jm
 QxcY4CACCZCa/qbr7M1uQpY1m0J58yu/44AyAYbqZGdfxC7mbB9pXuFejy7chUA6X6d01Yhy2n3
 T4W+DZYRdxUxbmuHcsrikPzAuR05RabirYK7bEAJJXJQ+2MOK7ZUIMvxpv0OdndKZq2tuAIPPk3
 64uPi8dgDXiCZOa2TIcXKm88SgI5fD3LS+42B
X-Received: by 2002:a5d:6d82:0:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-3a074f2ecbemr1829656f8f.46.1745585354879; 
 Fri, 25 Apr 2025 05:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtw87bkAqffObS5495XqBM3FBiJn3HJ1+ERi3N86EKTpOViCMyMKry06K00JbDrQNOGIhGbg==
X-Received: by 2002:a5d:6d82:0:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-3a074f2ecbemr1829635f8f.46.1745585354480; 
 Fri, 25 Apr 2025 05:49:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:6900:6c56:80f8:c14:6d2a?
 (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de.
 [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d4b0sm2239853f8f.89.2025.04.25.05.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:49:12 -0700 (PDT)
Message-ID: <d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com>
Date: Fri, 25 Apr 2025 14:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] memory: Introduce generic state change parent
 class for RamDiscardManager
To: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-5-chenyi.qiang@intel.com>
 <402e0db2-b1af-4629-a651-79d71feffeec@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <402e0db2-b1af-4629-a651-79d71feffeec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09.04.25 11:56, Alexey Kardashevskiy wrote:
> 
> 
> On 7/4/25 17:49, Chenyi Qiang wrote:
>> RamDiscardManager is an interface used by virtio-mem to adjust VFIO
>> mappings in relation to VM page assignment. It manages the state of
>> populated and discard for the RAM. To accommodate future scnarios for
>> managing RAM states, such as private and shared states in confidential
>> VMs, the existing RamDiscardManager interface needs to be generalized.
>>
>> Introduce a parent class, GenericStateManager, to manage a pair of
> 
> "GenericState" is the same as "State" really. Call it RamStateManager.
> 
> 
> 
>> opposite states with RamDiscardManager as its child. The changes include
>> - Define a new abstract class GenericStateChange.
>> - Extract six callbacks into GenericStateChangeClass and allow the child
>>     classes to inherit them.
>> - Modify RamDiscardManager-related helpers to use GenericStateManager
>>     ones.
>> - Define a generic StatChangeListener to extract fields from
> 
> "e" missing in StateChangeListener.
> 
>>     RamDiscardManager listener which allows future listeners to embed it
>>     and avoid duplication.
>> - Change the users of RamDiscardManager (virtio-mem, migration, etc.) to
>>     switch to use GenericStateChange helpers.
>>
>> It can provide a more flexible and resuable framework for RAM state
>> management, facilitating future enhancements and use cases.
> 
> I fail to see how new interface helps with this. RamDiscardManager
> manipulates populated/discarded. It would make sense may be if the new
> class had more bits per page, say private/shared/discarded but it does
> not. And PrivateSharedManager cannot coexist with RamDiscard. imho this
> is going in a wrong direction.

Agreed.

In the future, we will have virtio-mem co-exist with guest_memfd.

Both are information sources, and likely we'd have some instance on top, 
that merges these sources to identify if anybody needs to be notified.

Until we figure out how that would look like, I would suggest to keep it 
as is.

Maybe, in the future we would have a single RamDiscardManager and 
multiple RamDiscardSources per RAMBlock.

The sources notify the manager, and the manager can ask other sources to 
merge the information.

-- 
Cheers,

David / dhildenb


