Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57154C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpAw-0000vg-Rq; Mon, 07 Jul 2025 12:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYp6q-0005dC-LV
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYp6o-0007ZY-Hp
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751907264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJUba9+yTZu+99k9uS5OXkEe6ctGoTCs3ackjTQQfqg=;
 b=RtY3Kv1Ug+nbnifKER1FWBNMeKzy2SDNcb5kj/qTnS7DrbGXBVccPw6wKV8GtnEIKIUmGB
 dbkEbwFqvZewzCIoWTqqJfZOser/Kx9BbVh87IHMjPytz7ZZXvUpdTvpZMKVtJvN+1wxBh
 Es8RywsRqomrYtUguQYHAoyROdJtsg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-8nAOC5nUPyyH8keoSDj3RQ-1; Mon, 07 Jul 2025 12:54:23 -0400
X-MC-Unique: 8nAOC5nUPyyH8keoSDj3RQ-1
X-Mimecast-MFC-AGG-ID: 8nAOC5nUPyyH8keoSDj3RQ_1751907262
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so17311605e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751907262; x=1752512062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJUba9+yTZu+99k9uS5OXkEe6ctGoTCs3ackjTQQfqg=;
 b=CNsYk6Lk1tVy6K1EjbLhXB1k0teDK+lcBefjk/6ekUE3cQH+15jBYJoElhDMWj9ht3
 PTYFUSJt3+XyaveE6P/rxw+B6LZeidhkVfHTH3B/hfG+rkhx1+FtAw2JJgI9EkqjQvzI
 d2z4Lv9tjPcRukaOHVuULRDa+zDd/y0mm06+SAADUSURksf2MqETNifIktaVrVpcZ0gO
 W3ERyeGDxInvhmJNHmwmStrdAZyOnSsixGvaPTKZ48uX9xuhV0HbNqmcfVlB5qDHVkHS
 bGM5gSz3esxQoVDDfl7GirbYd+Yf8zEVf/NBNSu2RqZmMWg0262C8qhZJj+5cOanhns+
 OW3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOCaNsibGYIT2Dqq4VANTs+hajI71Nqm6VRWBvonQ7Wjg7aPvuHd4m7d0JjvpHte20b+FQCaHntolp@nongnu.org
X-Gm-Message-State: AOJu0YyS+uYaP/z6GgQ0M5Y0KpDLKhcfF4dZRRtpdbo1TlZa+Q67MVrc
 Imor7OLuUxovdcsyKqeFjIskNqj7SsPZ393YeV0iNO/sxuxX4WcQiDRIhwmtx9fU9Ep1xhTI6RT
 jPRyxpdgbXHlS8aJfqYwvxX1uGjaAZvCyh4yCeumpTYk2RXdcXHkNuYdF
X-Gm-Gg: ASbGnctaZfbWbl/VSx6S1krlhjZ+Wo0oDcvztDnsXzonNPyJfBDMb1ALe2feFPqstRT
 kcyHkprTu2chp0dme2TPBiC+Jry+b3wMoD/qPzgvqv0FmoskkVtus32mSLX+Hy+1Bekmz1yjLCJ
 yxQMQT41vrowtbrC1M+8WpB8zdcWUBT7J1Zksug2n2NDywrzxG3zEYMpjDA8Cb5X/jN5uBf6w3W
 BmjYWS1KfhYWbYP6URPeBrQt+m8rB3tPNl8StxtAC3OTtVLlySkeU6tRj3f2hpCYR6zduYzjtPv
 j0pJwuGIKTvGXzHp+S7Q3yTjK1ssdSH+TK8Ul6COzFB1+9CDSf04va+ap5aQV7fvS/bcrQ==
X-Received: by 2002:a05:600c:c104:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-454ccc5d2b3mr3241695e9.12.1751907261644; 
 Mon, 07 Jul 2025 09:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkZcM1ZfOCWlMBkQjTTEGs4PCnKjwreL9ZJRtODlQFeeTNOxIlxDfaHDWzGhRsHd1DaPQO/w==
X-Received: by 2002:a05:600c:c104:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-454ccc5d2b3mr3241295e9.12.1751907261072; 
 Mon, 07 Jul 2025 09:54:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm144967715e9.15.2025.07.07.09.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:54:20 -0700 (PDT)
Message-ID: <77e9dcb3-1704-4418-8d6c-b349c02ff2e7@redhat.com>
Date: Mon, 7 Jul 2025 18:54:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/19] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-10-zhenzhong.duan@intel.com>
 <3babbbd5-23e3-4b6b-9f9c-e879d4ddb125@redhat.com>
 <IA3PR11MB9136359F208103BA9F3DB8F79278A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136005A33841A077E546E9E924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136005A33841A077E546E9E924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 7/7/25 5:12 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Duan, Zhenzhong
>> Subject: RE: [PATCH v2 09/19] intel_iommu: Introduce two helpers
>> vtd_as_from/to_iommu_pasid_locked
>>
>>
>>
>>> -----Original Message-----
>>> From: Eric Auger <eric.auger@redhat.com>
>>> Subject: Re: [PATCH v2 09/19] intel_iommu: Introduce two helpers
>>> vtd_as_from/to_iommu_pasid_locked
>>>
>>> Hi Zhenzhong,
>>>
>>> On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>>>> PCI device supports two request types, Requests-without-PASID and
>>>> Requests-with-PASID. Requests-without-PASID doesn't include a PASID TLP
>>>> prefix, IOMMU fetches rid_pasid from context entry and use it as
>> IOMMU's
>>>> pasid to index pasid table.
>>>>
>>>> So we need to translate between PCI's pasid and IOMMU's pasid specially
>>>> for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
>>>> For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.
>>>>
>>>> vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to
>>> vtd_as
>>>> which contains PCI's pasid vtd_as->pasid.
>>>>
>>>> vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to
>>> iommu_pasid.
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>  hw/i386/intel_iommu.c | 58
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 58 insertions(+)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index 9d4adc9458..8948b8370f 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -1602,6 +1602,64 @@ static int
>>> vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>>>      return 0;
>>>>  }
>>>>
>>>> +static inline int vtd_as_to_iommu_pasid_locked(VTDAddressSpace
>> *vtd_as,
>>>> +                                               uint32_t
>> *pasid)
>>> Is it meaningful to use inline here and below? Below I guess you do so
>>> to avoid "defined but not used" compilation error but I don't think it
>>> should stay as is.
>> Yes, that's the only reason I define the both inline.
>> Do you have other suggestions to avoid compilation error if not use inline?
> I find I am not clear on above comments yet, do you just want to remove inline flag?
> Maybe merging the two helpers to other patches using them to avoid inline?
In the past what I did in such situation consisted in introducing a
declaration of the static function before its definition and when the
actual user is introduced, in a subsequent patch, remove the spurious
declaration.
Now, reading 
https://www.reddit.com/r/cpp_questions/comments/15kfije/how_to_decide_if_a_function_should_be_inline_or/,
maybe adding the inline here is not a problem given the compiler may or
may not inline the function.

Thanks

Eric
>
> If I misunderstood, could you share more light on what changes you want this piece of code to have?
>
> Thanks
> Zhenzhong
>
>>> I don't really understand the iommu_pasid terminology. Either it is a
>>> pasid passed through the PCI transaction or it is the default pasid
>>> found in rid2passid ce field. So that's a pasid both ways ;-) can't you
>>> simply call it pasid.
>> Yes, PCI side we call it just pasid, the other side I name it iommu pasid to
>> distinguish.
>> Does that work for you?
>>
>>>> +{
>>>> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
>>>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>>>> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
>>>> +    uint8_t devfn = vtd_as->devfn;
>>>> +    VTDContextEntry ce;
>>>> +    int ret;
>>>> +
>>>> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
>>>> +        ce = cc_entry->context_entry;
>>>> +    } else {
>>>> +        ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
>>>> +        if (ret) {
>>>> +            return ret;
>>>> +        }
>>>> +    }
>>> if the above pattern is used at many locations I still think it may be
>>> valuable to have a _locked helper.
>> Not get, both vtd_as_to_iommu_pasid_locked() and
>> vtd_as_from_iommu_pasid_locked()
>> are already _locked helper, isn't it?
>>
>> Do you mean adding a comment saying "Caller of this function should hold
>> iommu_lock."
>>
>>>> +
>>>> +    /* Translate to iommu pasid if PCI_NO_PASID */
>>>> +    if (vtd_as->pasid == PCI_NO_PASID) {
>>>> +        *pasid = VTD_CE_GET_RID2PASID(&ce);
>>>> +    } else {
>>>> +        *pasid = vtd_as->pasid;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key,
>> gpointer
>>> value,
>>>> +                                                   gpointer
>> user_data)
>>>> +{
>>>> +    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
>>>> +    struct vtd_as_raw_key *target = (struct vtd_as_raw_key
>> *)user_data;
>>> why target? can't you name it key instead?
>> There is already a parameter named key, maybe target_key?
>>
>> Thanks
>> Zhenzhong
>>
>>>> +    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus),
>> vtd_as->devfn);
>>>> +    uint32_t pasid;
>>>> +
>>>> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    return (pasid == target->pasid) && (sid == target->sid);
>>>> +}
>>>> +
>>>> +/* Translate iommu pasid to vtd_as */
>>> same here
>>>> +static inline
>>>> +VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState
>> *s,
>>>> +                                                uint16_t sid,
>> uint32_t pasid)
>>>> +{
>>>> +    struct vtd_as_raw_key key = {
>>>> +        .sid = sid,
>>>> +        .pasid = pasid
>>>> +    };
>>>> +
>>>> +    return g_hash_table_find(s->vtd_address_spaces,
>>>> +
>> vtd_find_as_by_sid_and_iommu_pasid, &key);
>>>> +}
>>>> +
>>>>  static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>>>>                                       void *private)
>>>>  {
>>> Thanks
>>>
>>> Eric


