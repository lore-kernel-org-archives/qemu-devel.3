Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCB0D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SfU-0007HM-52; Mon, 28 Oct 2024 12:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t5SfR-00076j-2f
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t5SfP-0000O3-AK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730133147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gjggvzGWkBwrrwMfWh3JXGSzHIVlrh/OgLv0sI1bRiQ=;
 b=cczWJyoYdCSgyf3m1ZzvmwPTpFeQ50iAt1MoMfPDUcAszqi6Y6P0wAGGkOS1seV7KANYj2
 VmgNuYpyLMjuC3LxMtSfbuQ6m8SzPyOCFjy2K3yI2EX61fine2SBeTRNpJLpCciv4jONMe
 1guNvNeoUVxWZEOMYajN1ZRAlqUkQQg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-XslRG7tdPu2ShsyBP26fHA-1; Mon, 28 Oct 2024 12:32:26 -0400
X-MC-Unique: XslRG7tdPu2ShsyBP26fHA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso32471575e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730133145; x=1730737945;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjggvzGWkBwrrwMfWh3JXGSzHIVlrh/OgLv0sI1bRiQ=;
 b=ub0qgHQueqNYxetaHLJLmPyj1LQENRJHbSwTtaWE+0I+YDQ1Xoe26o9/fo3lBdOYd9
 o/hwHbyItpWZxXwfoWT31/iRR8mPJH0XHkpJ3SKt7AeO2xiJ73cL/hxHa63S4vQorE/3
 xJZkuJedxAhJe+j+LQtFM3oqmSfjtjch770qjF4mBiojOKQu6cmTbE4tHR3ZYCVJYMZ/
 niykzEArqg4fIG2Fuw/9DwjYfhBcXeUgF7kqYrYR7fb8QOUQjMdiLHvnDvqEfmh9aTWc
 0iEQH4aqdz7yujjN5uuiaf79CRgjKXwePyfGlCsFlxMS2kg6m36Egx04eglqrJUZk4JD
 C6dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCCccLwPUBL/Rz9QhHcWa4EZpTHj+Sk12XLWbefJ74TEG5idsiJ20d+ruYOV+cFxlVUk/czxhNEyJp@nongnu.org
X-Gm-Message-State: AOJu0YwIKiQhj33wSHwl1mvMN7iU7oj164oBVNQZaP6jtp9efT6GM9GC
 AMB1f3+XHPeUPr6OadYMLBFUiAoBhLx9sHGaYRmX90uD50N60VnTI9nmQlyBF/pmHR/pTIYi4r3
 +oeoK6glr9VDgrjHKsKLUBNvV3xIZI9JwjqBVH4WfO2lPq77PBFiB
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-4319ad049a8mr63761715e9.27.1730133145162; 
 Mon, 28 Oct 2024 09:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvrVzNQ5KvnDWYy7NCoR4A208IKWmafb3FxMi+dq1XB8mVrAuLmie/i7ZtybE4HCP+JfWBJw==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-4319ad049a8mr63761545e9.27.1730133144747; 
 Mon, 28 Oct 2024 09:32:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c722:3c00:70fc:90a8:2c65:79b4?
 (p200300cbc7223c0070fc90a82c6579b4.dip0.t-ipconnect.de.
 [2003:cb:c722:3c00:70fc:90a8:2c65:79b4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360d233sm113285555e9.45.2024.10.28.09.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 09:32:24 -0700 (PDT)
Message-ID: <be678d47-b8f5-4061-9287-adb6a44ad483@redhat.com>
Date: Mon, 28 Oct 2024 17:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 0/6] hugetlbfs largepage RAS project
To: William Roche <william.roche@oracle.com>, pbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, joao.m.martins@oracle.com
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
 <ec3337f7-3906-4a1b-b153-e3d5b16685b6@redhat.com>
 <9f9a975e-3a04-4923-b8a5-f1edbed945e6@oracle.com>
 <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <966bf4bf-6928-44a3-b452-d2847d06bb25@oracle.com>
 <0ef808b0-839d-4078-90cb-d3d56c1f4a71@oracle.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0ef808b0-839d-4078-90cb-d3d56c1f4a71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19.09.24 18:52, William Roche wrote:
> Hello David,

Hi William,

sorry for not replying earlier, it somehow fell through the cracks as my 
inbox got flooded :(

> 
> I hope my last week email answered your interrogations about:
>       - retrieving the valid data from the lost hugepage
>       - the need of smaller pages to replace a failed large page
>       - the interaction of memory error and VM migration
>       - the non-symmetrical access to a poisoned memory area after a recovery
>         Qemu would be able to continue to access the still valid data
>         location of the formerly poisoned hugepage, but any other entity
>         mapping the large page would not be allowed to use the location.
> 
> I understand that this last item _is_ some kind of "inconsistency".

That's my biggest concern. Physical memory and its properties are 
described by the QEMU RAMBlock, which includes page size, 
shared/private, and sometimes properties (e.g., uffd).

Adding inconsistent there is really suboptimal :(

> So if I want to make sure that a "shared" memory region (used for vhost-user
> processes, vfio or ivshmem) is not recovered, how can I identify what
> region(s)
> of a guest memory could be used for such a shared location ?
> Is there a way for qemu to identify the memory locations that have been
> shared ?

I'll reply to your other cleanups/improvements, but we can detect if we 
must not discard arbitrary memory (because likely something is relying 
on long-term pinnings) using ram_block_discard_is_disabled().

-- 
Cheers,

David / dhildenb


