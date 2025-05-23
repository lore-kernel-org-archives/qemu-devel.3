Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D70BC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPEF-0007ix-LE; Fri, 23 May 2025 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPEC-0007hJ-Kw
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPE8-0000QH-MS
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747994526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cWKYtJIUm7m8DhxzIaxdbaEZEAbaZSOIQvCGk0ZDT0=;
 b=A2vUdAgUODS0ChE+Uhr/sCArWdBZPgLATcbxy5ssTxQOHv2JNnAomkQfilXz6HGuaw1j/T
 VGvA6wtXbjWNlVxdJl4xtzQZNjPI1IswX7zji3btvIFnqN7hmffj/NnCcjykzIxWCZcahO
 p0kkdMRhC+rW2rRFdaxYVpIzl4zmAEc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-7cbE0GPsNNSVBX3gKC5W3g-1; Fri, 23 May 2025 06:02:05 -0400
X-MC-Unique: 7cbE0GPsNNSVBX3gKC5W3g-1
X-Mimecast-MFC-AGG-ID: 7cbE0GPsNNSVBX3gKC5W3g_1747994524
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55203a08e39so1501812e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747994523; x=1748599323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cWKYtJIUm7m8DhxzIaxdbaEZEAbaZSOIQvCGk0ZDT0=;
 b=uzmPaT6yaDVKXqhaFf5F7ly92Tu0EK1gSIAm5I9SwGlcT/m2RwsozRXMYzlBKWR1Bm
 e8sfbirjClKkvvklpbieTbwaKPgAudpgUO8MPNl9I7MLX97JTQzgnps1DmKIF5v2EyKU
 L8skYW1UnZv9ereXvEqNiN6/De0+m++6NLMF+ujYuNmUIZcUO6KLSpnreJHXZi4+VC1L
 M8vlOdLEET7ke4A0UTNlEIgwG6RsjHLRQyvweYfsOplrasjN4VBDAqiN2BNB07XRT1M5
 PL/1ccmkXH9RxUcF6WhdauvYZdc2b5UDLnwB7zSBbkmtivbrtPeMJS9dSOrmDyiE2TrN
 WZmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0oQWWPen7QUE6xFCEJSzYQrWRcSJ+Vajv9N4U4YslUS+KkHQFatwg6IqxxQMY8LI/ybDkSgkhoGms@nongnu.org
X-Gm-Message-State: AOJu0YzDMWCBZLSnstceG/QssgpECd4eKbblXKDpmRi+prprqBw9ShZi
 mQDWyugx9m7k9srDvAVGf3Vh8AT6znWSq46AMtJ9+3YwZSHYP9SXJr1iReKkUId7Zal9d6BdGoL
 PXoFLZZqavAPFL6A5iGJGywri6LxgwQFUpzefkEB1BEqmpp3gjzvPpcIzb+MpqIFDOKo=
X-Gm-Gg: ASbGnctCxQAyboKQU3J2gs38WMZzmMfmEkPQufwnwQnH863Bngwv95+d76tvqKnu2FC
 cSJzBUBdcOJYcsFCSKUY90Iwo7nYf1LB8WfsGu4WqheKbsrwwqVSFz6sN7FQyz7UEtvZuHEt8eg
 fThLwG/8kMuESm7teO8lX/6rdEKqLS4c/hTyl1ywgeMU/mUzh7ww7CI28q14mNp/++fF0y966oF
 tl3DjfTvlRI91i0m5lFaBAs5nrCs8ecn/1X3NY/LaY6LBqozSZ+BMWud6HidqzOWnVKXg5kzo7a
 cTmLJQCIElqIOqbMJqg=
X-Received: by 2002:a05:6512:10c1:b0:545:1e2d:6b73 with SMTP id
 2adb3069b0e04-55216e0cd3emr653003e87.13.1747994522872; 
 Fri, 23 May 2025 03:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmeN94PQ9eXd7ZpYrN3ZxkM2P2KxEo4bKuQmcxlbGWfaz4Mdq5LTXdpA1oGMVEktYCogzqxA==
X-Received: by 2002:a05:600c:3e08:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-44b6e7634bfmr17154325e9.20.1747994511994; 
 Fri, 23 May 2025 03:01:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78b0a46sm130822845e9.30.2025.05.23.03.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:01:51 -0700 (PDT)
Message-ID: <0c0efab7-826b-4759-b322-453a10499606@redhat.com>
Date: Fri, 23 May 2025 12:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/16] virtio-net: implement extended features support.
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <8fb9f142e25a0f1b01e8cf54a6c2a0971db00d83.1747825544.git.pabeni@redhat.com>
 <f598f776-e852-442c-a7c7-077d74b33503@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f598f776-e852-442c-a7c7-077d74b33503@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On 5/23/25 10:09 AM, Akihiko Odaki wrote:
> On 2025/05/21 20:34, Paolo Abeni wrote:
>> Use the extended types and helpers to manipulate the virtio_net
>> features.
>>
>> Note that offloads are still 64bits wide, as per specification,
>> and extended offloads will be mapped into such range.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   hw/net/virtio-net.c            | 87 +++++++++++++++++++++-------------
>>   include/hw/virtio/virtio-net.h |  2 +-
>>   2 files changed, 55 insertions(+), 34 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 9f500c64e7..193469fc27 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -90,6 +90,17 @@
>>                                            VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
>>                                            VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
>>   
>> +#define VIRTIO_OFFLOAD_MAP_MIN    46
>> +#define VIRTIO_OFFLOAD_MAP_LENGTH 4
>> +#define VIRTIO_OFFLOAD_MAP        MAKE_64BIT_MASK(VIRTIO_OFFLOAD_MAP_MIN, \
>> +                                                VIRTIO_OFFLOAD_MAP_LENGTH)
>> +#define VIRTIO_FEATURES_MAP_MIN   65
>> +#define VIRTIO_O2F_DELTA          (VIRTIO_FEATURES_MAP_MIN - \
>> +                                   VIRTIO_OFFLOAD_MAP_MIN)
>> +
>> +#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)  (fbit >= 64 ? \
>> +                                          fbit - VIRTIO_O2F_DELTA : fbit)
>> +
> 
> These are specific to virtio-net but look like they are common for 
> virtio as the names don't contain "NET".
> 
> VIRTIO_FEATURES_MAP_MIN is also a bit confusing. It points to the least 
> significant bit that refers to an offloading feature in the upper-half 
> of the feature bits, but the name lacks the context.

Uhmmm... putting the whole context in the macro name sounds very verbose
and/or hard, what about:

How about VIRTIO_NET_OFFLOAD_MAPPED_MIN

?

> @@ -862,13 +881,13 @@ static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>>           (1ULL << VIRTIO_NET_F_GUEST_USO4) |
>>           (1ULL << VIRTIO_NET_F_GUEST_USO6);
>>   
>> -    return guest_offloads_mask & features;
>> +    return guest_offloads_mask & virtio_net_features_to_offload(features);
> 
> 
> How about:
> 
> static const virtio_features_t guest_offload_features_mask = ...
> virtio_features_t masked_features = guest_offload_features_mask & features;
> 
> return masked_features | ((masked_features >> VIRTIO_FEATURES_MAP_MIN) 
> << VIRTIO_OFFLOAD_MAP_MIN);
> 
> This makes virtio_net_features_to_offload() unnecessary.

The above looks a little fragile, as (in future) 'features' could have
some bit in the mapped range set (and not representing a guest offload):
we need to explicitly mask such bits out before the first '&' operator.

If dropping the helper is preferred, it can still be dropped.

/P


