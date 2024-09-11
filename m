Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6899EEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMra-0003Fj-QF; Wed, 11 Sep 2024 08:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soMrZ-00039d-8S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soMrX-0003UM-Jm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726059262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z+4ZC1CwbWGjVgpaFSRDqeWKMvdFmsfE3BcY7VBWDLU=;
 b=GJO2NDkw+DJ5UHMd1BhVUOiRIpae98jyhLmQeQXxdqr3BSdODCMpOVcmLAa9+Ajfl4IIEg
 g6vt8/X65xv3YnXvRQebL5I2IgZhoIc0uZaL2qWXwgJSd3CRPxnmkp8CEtDd641rJ3ys5i
 ur8v5f67zI/4mhGt9vm1oSlRDzp8T0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Mhk_0Hg3Pse7uXOJrLGx4g-1; Wed, 11 Sep 2024 08:54:20 -0400
X-MC-Unique: Mhk_0Hg3Pse7uXOJrLGx4g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374b385b146so2979895f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726059259; x=1726664059;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=z+4ZC1CwbWGjVgpaFSRDqeWKMvdFmsfE3BcY7VBWDLU=;
 b=b4CLw0t14j7UTHtjM8UgGef3bbBUCpIQrGqLmVU4MyKpBxY3SPFkudLuuSRLbh4wWC
 2S/3rfgtn9rXA6mohidlYrOX5ptHX5+WfNF/VZ7Un1IkQGAPwYLyjZ1zoGVi/PhQM23h
 49t8cBHuGBLL0Y77M1KirjaSIbyO3spB9lnfBRv16jDtvrnokN5mIzgNEU6Gjvr5Yglj
 hgYf2z3cpoUvjyDKNA70+T1LeqSD/VWvNh2/ymePZKxp0cU5bEWIaC1MkgQvSqPsaf8O
 5zmBjusnCUKC7tETp6yE/BCwG7bZrTBoXrsvvbZvJRzmwPHtWp1ZRuVt8vqkPWPFCFyY
 btNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTtAlgYnA1ENJzmDvGa6x1NQpRk25pz05mXpC5KA0qpxo4pf/CmNFVDwYjVjq9Z/EN8yLgkdA1OrU@nongnu.org
X-Gm-Message-State: AOJu0YyHOI7j97c7vMXAwGwjKTrlUZp3wC+FZ/1xBBjdsLRWU4UiB9aY
 2O9426/cOr+SSGnLLmtP/MHxISCABkCRSfC/DjRGxGMwGNgTWgSg/ExX9JV3ngNl5qQb+a0wHmp
 2bOlceAu6bQAxM+gkizcG5Gm1QFOywnpxJB1MkwBjUvLoByYCCDnC
X-Received: by 2002:a5d:5449:0:b0:374:c0f5:79f4 with SMTP id
 ffacd0b85a97d-378895c5457mr11658000f8f.7.1726059259085; 
 Wed, 11 Sep 2024 05:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAIW4zIaVeL5PzqdhmHWgNAgR3WEa0/37UebPNFRTvv6uSrzhNZ5PkA+/ti0OS6CLXHINnIQ==
X-Received: by 2002:a5d:5449:0:b0:374:c0f5:79f4 with SMTP id
 ffacd0b85a97d-378895c5457mr11657976f8f.7.1726059258462; 
 Wed, 11 Sep 2024 05:54:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:7e00:c672:608:5b3e:df8c?
 (p200300cbc7007e00c67206085b3edf8c.dip0.t-ipconnect.de.
 [2003:cb:c700:7e00:c672:608:5b3e:df8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a52csm11550920f8f.11.2024.09.11.05.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 05:54:17 -0700 (PDT)
Message-ID: <7273e9a2-c80c-438d-98e8-e2c871842edc@redhat.com>
Date: Wed, 11 Sep 2024 14:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM
 sizes
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-2-david@redhat.com>
 <df04fd44-de71-4616-86fe-a9ae5fe9af08@linux.ibm.com>
 <b3739492-6f80-4dba-bfec-466ca2e12513@redhat.com>
 <973bb16d-7143-40f1-ad2a-b37c0cacd5e7@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <973bb16d-7143-40f1-ad2a-b37c0cacd5e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11.09.24 14:46, Thomas Huth wrote:
> On 11/09/2024 14.38, David Hildenbrand wrote:
>> On 11.09.24 13:28, Janosch Frank wrote:
>>> On 9/10/24 7:57 PM, David Hildenbrand wrote:
>>>> KVM is not happy when starting a VM with weird RAM sizes:
>>>>
>>>>      # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>>>      qemu-system-s390x: kvm_set_user_memory_region:
>>>> KVM_SET_USER_MEMORY_REGION
>>>>        failed, slot=0, start=0x0, size=0x244000: Invalid argument
>>>>      kvm_set_phys_mem: error registering slot: Invalid argument
>>>>      Aborted (core dumped)
>>>>
>>>> Let's handle that in a better way by rejecting such weird RAM sizes
>>>> right from the start:
>>>>
>>>
>>> Huh, I always assumed that ram is handled in multiples of 1MB in QEMU.
>>
>> Me as well, I did not dig if that changed at some point ... or why such odd
>> sizes would even be required :)
> 
> I guess it's there for some old PC hardware ... Remember, 640K ought to be
> enough for anybody.

True, maybe the "default to MiB" made some of us believe that something
smaller is impossible :)

And in fact, I think suffix support was added in

commit 6e1d3c1c855818a6d1399698572afae0d11b872b
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Wed Nov 27 01:27:35 2013 +0100

     vl: convert -m to QemuOpts
     
     Adds option to -m
      "size" - startup memory amount
     
     For compatibility with legacy CLI if suffix-less number is passed,
     it assumes amount in Mb.
     
     Otherwise user is free to use suffixed number using suffixes b,k/K,M,G


-- 
Cheers,

David / dhildenb


