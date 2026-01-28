Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150D4D3F098
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8om-00024y-VC; Wed, 28 Jan 2026 11:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vl8oh-0001o9-Ta
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vl8og-0000c1-4a
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769619293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nNKtqZZX2SAP2nBC7CE5VsU2Xk12FaXrMgjZxQd/m0Y=;
 b=KSAXb0LYeSM0oh9PzSh84NJ8bY/+VeeNgH8hye7qev2Wr8ahKG+B+7IVSycYDw5GLTI1fj
 2QoENdJdk/HZ6KzU2cDv2Ss9KkW2Hxo+xSmc9VikvGr4gMN6xkRJxUbr5tHmLQve9B6qPC
 640vg4RcN5B95ygikJksTTFIwMRzcGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-c6FIOXDCP1CaeUb31pxMbw-1; Wed, 28 Jan 2026 11:54:50 -0500
X-MC-Unique: c6FIOXDCP1CaeUb31pxMbw-1
X-Mimecast-MFC-AGG-ID: c6FIOXDCP1CaeUb31pxMbw_1769619289
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso349635e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769619289; x=1770224089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nNKtqZZX2SAP2nBC7CE5VsU2Xk12FaXrMgjZxQd/m0Y=;
 b=dy5IQMCsaMrIYsG9XDj/V0y2+/8cR5Ikiak01dh836q2XMPYFXDUFQ3VhkNwsVi+67
 +jm5pJg1pm8gqhIEMOcLRBflp+LyPxb3XkniatEirwxrFhKj0+CUeaTJGp3xRM9Ocrfh
 6yhg6h3Vk7/dCaWg1KZryl2Tb9DzQvh8azgB9+4uZ8TVcglfYmmYYnp1eSege9u+CgD4
 z2VYwdlycw2yIucrflBAefNnzblD6mZHbcgpNjTHoF6BZjgAOzEXCLWC7nypEBWXRGMW
 spLw3HrOZNJCEArcK6SicpskuydS5Bnhcx5ZTjL5n4lxRpvw9IdVV9/6ONySToCKEWc2
 UUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619289; x=1770224089;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNKtqZZX2SAP2nBC7CE5VsU2Xk12FaXrMgjZxQd/m0Y=;
 b=QfCak+QRiEUMq6te8AyjzFIi8wYPxpQtF5H4ID5ySwSTtWS5blA6aXorDAWGj+ZDEB
 Jt0hJIbA58BDN/40YzpPlRiyxj3AG2vpjMnlyf+pR4UR9M1zkEN70+z3NPqYwtyiaYUt
 CtLRji+hBB+ujFSTXqU5VMO9Mk0WYGWa+VrsZQDtYgv0KfTTXclbLxXah93akAkDXWxL
 XpGNnQTROZYj6B0qkBiLIFL0rPoxaF6OWGdy62PM5ohQKEkZT6t6q2h4Cuyuk64YcAEt
 Uj/diPUmOnZluoeTZ3ViidOjtiiBKJ9nC9xwRlamW46PgttUQwk2w3hqlueodnXtrtC2
 wUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtDKsW9YO/RI4CFRhwNUe3Td7H1p7cK3IWPgAapY5lLeCYQSrB/cSGRQTC9aF3MAOCCfeAmei15TN4@nongnu.org
X-Gm-Message-State: AOJu0Yz0bRUHARMIsHG5bNAzuKlY/wgEcqigS8gz+avHBMIG04N9BVuW
 DkVqEdUIf3ffyBEiZfWE84vsM/vACOS9oGV256+BIMyfAToSIKnAHfaRaoMhgahygGZqUCq42o4
 CTokNeaFfZdqhcKbxrH/qOTKboNyr8XvE8eYFugA5lvz+KGZ99eBFVQa6
X-Gm-Gg: AZuq6aLCTpgEmhkf0a8jdcFLu2iCFDbHC1XwkE6ikKcXFoXwoKLhVA36ImHiObdR6ZR
 3wfzkiTi38EPqLwn9ffhq8UafTcCjd4d3glZfwLw+Hv1mJQqfc3BRdO6xedyTG3oeaQXlheIuhX
 JsNdysMLXounK1+i57qP2wcAlJAMxtY9TJM1bjyawY64lhfZuWdmCvcg93qAxK5vug+wYUPRLVf
 4/aJ0DsgKWtUHUiPVEdf9PXMwUeHLjV19XT14LeNN2tk2KazPlPwK23w37NHcLMAYfnD83XXFan
 wctuGDWTL02XKfOjQd8/VshEkxUcqjQaM8ZDClXgU+zBPvbj5VryHw1csWQseqQq8PGRXxkbt9v
 dbI9OwRB16bdDe2rg9na9C0KanxXa+6QFg4s7lXRTjIiMBdIp
X-Received: by 2002:a05:600c:8719:b0:480:1aae:676c with SMTP id
 5b1f17b1804b1-48069c78706mr75940575e9.18.1769619289183; 
 Wed, 28 Jan 2026 08:54:49 -0800 (PST)
X-Received: by 2002:a05:600c:8719:b0:480:1aae:676c with SMTP id
 5b1f17b1804b1-48069c78706mr75940345e9.18.1769619288792; 
 Wed, 28 Jan 2026 08:54:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce93sm7992945f8f.24.2026.01.28.08.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:54:48 -0800 (PST)
Message-ID: <9be64769-5d2f-42c5-b219-ce464f398774@redhat.com>
Date: Wed, 28 Jan 2026 17:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmp: Fix a typo for GSO over UDP features
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260128162428.2669768-1-lvivier@redhat.com>
 <7727d378-db7e-464f-89a3-c5e10c605fb5@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <7727d378-db7e-464f-89a3-c5e10c605fb5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/28/26 17:39, Paolo Abeni wrote:
> 
> 
> On 1/28/26 5:24 PM, Laurent Vivier wrote:
>> The description of VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM feature
>> was missing the _CSUM.
>>
>> Fixes: a76f5b795cab ("qmp: update virtio features map to support extended features")
>> Cc: pabeni@redhat.com
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hw/virtio/virtio-qmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index 968299fda0c9..45ca40ca50f8 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -329,7 +329,7 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>               "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>>               "UDP tunnel packets"),
>>       FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
>> -            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM: Driver can receive GSO over "
>>               "UDP tunnel packets requiring checksum offload for the outer "
>>               "header"),
>>       FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
> 
> LGTM, thanks!
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> Side note, I lost track of this patch:
> 
> https://patchew.org/QEMU/745e4b9ff93b27b4464d039d2ca24a9020f2c32f.1760103753.git.pabeni@redhat.com/
> 
> which would address the above and prevent similar errors in the future.
> AFAICS is sitting in patchew since 3m. Should I consider that one dropped?
> 

I agree, I was thinking at doing the same change.

Thanks,
Laurent


