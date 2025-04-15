Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC51CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4g1c-0005bq-3H; Tue, 15 Apr 2025 09:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4g1Q-0005X2-Ms
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4g1O-0004TV-0c
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744722492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Duepog1g73Inl0WVjbk+yqjWWN5sggW4sd9XRRMBYgs=;
 b=Px6ebi2/aLedRL3yvL3x0nLwTyv/qFrLHm+Rw5A5Jczhsed/R5oYBvyoQHK7SUBvVFvyGm
 Rt/S7Ck2XLjJBKqO+pL6sGApPlqC3782SJGdmu3QXwFGOowKfehb0RyXAKXA6ysG1OLas9
 l9jFSuWu9fuC0CeU5KjGj/Ll6YgccGE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-VYhQHYuIP8-wQa2x2b2ImQ-1; Tue, 15 Apr 2025 09:08:10 -0400
X-MC-Unique: VYhQHYuIP8-wQa2x2b2ImQ-1
X-Mimecast-MFC-AGG-ID: VYhQHYuIP8-wQa2x2b2ImQ_1744722489
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d01024089so45340155e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744722489; x=1745327289;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Duepog1g73Inl0WVjbk+yqjWWN5sggW4sd9XRRMBYgs=;
 b=jvibWw4dnTtvNxCgMQvpI0Lec8ZeAXkM7/bIo6fDuoFdr9xk1o77eTkjnEqE6juKHz
 3ZPpQuak4/8sKmJkjiUuzTXeqgIjZ+5hJ0ILQF+2CvpHN3pNamfy6hSTZa8lfuC6Aw7l
 mYxon4h9wKkl7tXUcNwDXblxy1pL7MnarXn3oRX65SLR4JXpD/f6CW8uYS9K/DkctBCD
 Mm5H5VK8Gqe69VhqHrFddHraDzUcrzyblGpQCNeiKcA6z9e6LdreH9joZomzmHOm8FO7
 NHA+7cueXBAv5eHiIPnaDA7Cew6VuwROpWukRrLV0h1UJhbYBvs/xYGNFvZc6NLSEgxC
 rhZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfbGmwqfsHv1OBy2lxHbJL8Twy3k8cZlW684QfZki8T+OFqtB5KEKCIGNaKxkhlPJ5iAZPms+X2pjq@nongnu.org
X-Gm-Message-State: AOJu0YwvijmE93LuKMpSuf0LbQu8F00l2KXN7nFGaf0/pz1ZOV1lQe/j
 SmyPsypYMzR2IlWvJg1XIQV8QtLZf9lDnzvDrorHrbvwK1Kvg/1nFiY8IHA+XPRY0hv/Sax4MrU
 i/Dm/x1wVS5q60AeJU/9ZwUO+ccEoWhx7cS2y3H34j60PKk1OdUyM
X-Gm-Gg: ASbGncs5DJOIKZ/UoxvwGiyhqq1uztIcmistaMFsBdlG4XV3NxKRd98wMvgpBk+xy6q
 4fWuMYc3RQKfpxmkz7J+2hp16lw1qaBufcX+J9jLNpp4sWHX1vCPOLjgTDc+Z1Y9JmVuFRvOn4I
 l/412uq3n12DpDgWcNzy99H+mGwsFB8htpfizNt9xbWm42TMZSakPqBZ3ynMuXy6DWsyz24AyBW
 qYRga3XBnEaY7FNYxxCMDtc3tdIc6xhc+BVYuGbLoJOFdw/Hj9F7MT1cPP8stt+pkuxtka0371T
 RjL5iR2N3Dd1QWue
X-Received: by 2002:a05:600c:524c:b0:43d:1f1:8cd with SMTP id
 5b1f17b1804b1-43f3a9aa87bmr139625605e9.24.1744722489361; 
 Tue, 15 Apr 2025 06:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pSNRaQw0ee5U7qDRgZAjpDxfA8ETVqVnWsx0UBrZ4BJgPyUrv8Xk9BY6/qw8QqvSUqts0w==
X-Received: by 2002:a05:600c:524c:b0:43d:1f1:8cd with SMTP id
 5b1f17b1804b1-43f3a9aa87bmr139624885e9.24.1744722488746; 
 Tue, 15 Apr 2025 06:08:08 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43f233a273fsm205791525e9.9.2025.04.15.06.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 06:08:08 -0700 (PDT)
Message-ID: <8062d868-469f-4c1d-a071-099b8e18857c@redhat.com>
Date: Tue, 15 Apr 2025 15:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..fea2220013 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>       if (!vtd_dev_as) {
>           struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        bool take_bql = !bql_locked();

There is another problem here, in that g_hash_table_lookup is performed 
out of the lock.

You need to:
- take the lock around the first g_hash_table_lookup()
- release it before entering the BQL-protected region
- take the lock again after bql_unlock()
- do another lookup after vtd_switch_address_space(), and throw away 
vtd_dev_as if it succeeds
- then release the lock after g_hash_table_insert().

Note that g_hash_table_insert() replaces the old value with the new one, 
but that's undesirable here so you need a second g_hash_table_lookup().

Thanks,

Paolo

>           new_key->bus = bus;
>           new_key->devfn = devfn;
> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>           vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>           vtd_dev_as->iova_tree = iova_tree_new();
>   
> +        /* Some functions in this branch require the bql, make sure we own it */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +
>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
>   
> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>   
>           vtd_switch_address_space(vtd_dev_as);
>   
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>           g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>       }
>       return vtd_dev_as;


