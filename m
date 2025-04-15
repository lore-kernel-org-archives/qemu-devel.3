Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F5FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cd8-0006lk-PX; Tue, 15 Apr 2025 05:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4cd0-0006dj-Fe
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4ccs-00031a-Jm
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744709438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J9fKlBoBjxdBePWvsNIgiH/mXvSVgkVwVwp0+z2NbK4=;
 b=UVm250xIOj2FgAjhz/FrvHOov8rnkz19UoUJz+1BXf2IpKrmeqzNqS/MVrDRZ257XQmpe8
 PD5E+Pooo9dyYNlARUMq/6xC4FglPhsSur57Bt8nAZQVqB4z3H4sbIS5JbE3UMx2pgIJrb
 joy48c82XweuhXRqz98mncJs/mimBs8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-_369A01XNXWDXpvJgbE4CA-1; Tue, 15 Apr 2025 05:30:36 -0400
X-MC-Unique: _369A01XNXWDXpvJgbE4CA-1
X-Mimecast-MFC-AGG-ID: _369A01XNXWDXpvJgbE4CA_1744709435
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so2059900f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 02:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744709435; x=1745314235;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9fKlBoBjxdBePWvsNIgiH/mXvSVgkVwVwp0+z2NbK4=;
 b=UmYAjS5H+rlHD0xuYoDICRAysGwnZv5+eadaYoNLh0KVZbo06OyGwJps1jEqwBlkKp
 av55c2SMDzimW3Z6HOwKL0lH1nyKwVH7qjHFGy5LLWiEX/tHs1d38F7j0tk2Xhx2iebe
 gNeIckMwgTHAMTYC+Fo1CPE+0hApcAy/WPizF1O4YFQNeA0sTlm37SF73Q7SISauIAp3
 JekcHvoaYVtWwNCudyhPLvKaGQ66TOOBVeLsB7LAh+ywHVlawNr5a+XAudtIahMQou5y
 R9iQHuEcWoe00N2IyUoyAS65kzhxEibbZM0VV0MwM63sBMhdXKVvaoEpa5wZrNsTwnpU
 vkaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0cI2g+RUd1xw/BswR2ex9jSoMoXww3f/idMLKcuqjXTafny/JmEl85wZ8e4ZM9XYMq66hf2wq6LMO@nongnu.org
X-Gm-Message-State: AOJu0YyqY9wjCjncP8vIBWTAbSt36uwSnZNOgOcyFt0jhbQg/dcAYuPr
 NpkIdGyBb4ZqT7aPqguXYSoI8mnm+AV5ZYzMQh3DypbC0JqFJU8aXL2vis8Hq0gCnbHRwGpSe2H
 R49BKb1YGsbgsGwHS/1Rtz0WJm6UX7Z1oAGwXmtsOyhTU1nDufs52
X-Gm-Gg: ASbGncugy9/HRY4xKicqYe2CCtm6v9z0CgXsLWa0/R4sc6sjK5VlsbzqLzN7a3Dzxt7
 ch+ws2JghR16YirHvfi8VL7134I5aaanAgQkE6e57mYyOO1XCNS+lHR9GWmVjLH3ZgvhMsgfIfb
 U65MEtzbGBnVrgHF3hQjqDpcwJ4UET5RZ2ZRMcN6KrzxiTLZbbszDVLvTyp09qxPci40MmKpqGw
 WHWHZL+repCggbF8BYvsd0ewjgaWLtDGpeqhChBAzNIRlB6yZArdGHpuuryXWAt/BSaGm1izGpV
 2zThe7/kYQnr8ufQ
X-Received: by 2002:a5d:64cb:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-39e9f3cb6f6mr11959831f8f.0.1744709435420; 
 Tue, 15 Apr 2025 02:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY3usniaCk1kobcABnGah5DZNu7QUaa89wDiHRGmMWOwTZ/lbh4YkXMsoAq+a7yhOe3KaT3g==
X-Received: by 2002:a5d:64cb:0:b0:390:fc83:a070 with SMTP id
 ffacd0b85a97d-39e9f3cb6f6mr11959809f8f.0.1744709435094; 
 Tue, 15 Apr 2025 02:30:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5e90sm201764305e9.38.2025.04.15.02.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 02:30:34 -0700 (PDT)
Message-ID: <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
Date: Tue, 15 Apr 2025 11:30:32 +0200
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

Please use a separate lock instead of the BQL.

Paolo

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
>   
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


