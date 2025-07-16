Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFDFC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyE0-0006Ne-JO; Wed, 16 Jul 2025 05:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubyDv-0006JU-SL
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubyDs-0005kc-F9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752657279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3590grheIM7SBHSSWdWWCgMSUC8TLviiTt0ycoGy/w=;
 b=Mn7tNt6FUKQk64irubGo4KqmU2i+NYAxee7YZ/8PRITMqo+2AoIkmQOdM7HbPypabeCqfW
 woQonlbPJuTh85Dw9qcowH8wRLpyJn5O8FbrE2lBz89D1pDe66MyaCy2msBsrdAq6Kw0ZB
 EJ8QdeYLprdjIY8sGcQfjzm5NY0nhg0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-I2LPIGk8Nye2DmC4cwVhzQ-1; Wed, 16 Jul 2025 05:14:38 -0400
X-MC-Unique: I2LPIGk8Nye2DmC4cwVhzQ-1
X-Mimecast-MFC-AGG-ID: I2LPIGk8Nye2DmC4cwVhzQ_1752657277
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so40136745e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 02:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752657277; x=1753262077;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3590grheIM7SBHSSWdWWCgMSUC8TLviiTt0ycoGy/w=;
 b=IdzUB4U8mn/6gAVkxqKJEh8y6mrcSyfxAP3TR0JFnCis7bq1u+2wmmMaXrj382avzx
 gWWoHgifjI7RzSu7Fe6Mf7xuSdw1JHSFwsPI537VjrAQ3tFG8Kb0h7UWc6J19z2artcs
 Gr3XrySp0jxbIi+sxMSehXogM52X/Z+ht5DZjEszD/ZMysXRWWQSsx+dOtFgHRbJhfwg
 Af4WbcKmzloyuTcMgZFoXZmnQ8zN3jf4Rbrvf9iSTKVgFQfqPLKWWDFf20xdg/15Ks3Z
 Ke7bIpUNpfIwXwJgRirZfiHlwA7F02Dk5UAmB/7ligU00sMYoRA1raFXesdFvsoa5TEk
 Nqzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ+MnmoV/jX94XzhnKKbIUjHtxLgRXf5o8gc+VBjDEV1uAWBJaTmiwqNrT25p7spxuGICQ50s8rG+U@nongnu.org
X-Gm-Message-State: AOJu0Yz99AMw+dYyCtbjKqHo/LG9juryVTTjG4ZIrKoe1amsEn4AAuTU
 YTDx9Gxx+UbBL8SY6Gzs5gBWLoeThzcZec6dRzWY63OkzAmg8RrbXODPp77r/4wM7DYHQXC1R93
 pr85f194jvSG3Cw7uRoZbtq2vFvDNUbeHHiM/k8gHxvH9P5zLPgs/Z/Kw
X-Gm-Gg: ASbGncuuZe3UkNRJGBUDiKab3EYezeFRqJ4iv7BnR6RKQqDkQoXqGrSej/FK9Eh1Laz
 CXNwowoofWjl/8MGJJAY+PSJ2H8jwP0PWgUmUq8jOqdo6Rok7TyQ8AQm5+GIy6SSOa7fRhxAwA1
 OmPXkVRJAXjphNDgVzDQRW2U+S1pXv07uE5Csn1G2qxZRa109yDvCS1rlpxdJqjRXu1//yT0F2m
 9+CI6YSPaZOM/zzzIdGNBUplhnoySc03F1B1DDFoE0MhOErNFZJ2zg3wq5F26BKQPxQXkTt8jEh
 6Nj/GB1inMQnvSKEQNyV/3hPGdsUpLfy6TSRa22Me2pZ0Mf76IkldB17HdVa7vdsftmDj8eU6qb
 RFVeSTrV1qdM=
X-Received: by 2002:a05:600c:1ca9:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-4562e039c45mr17589705e9.7.1752657276698; 
 Wed, 16 Jul 2025 02:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGybf5a1t+wptrgD61Zw0KBNta+k6d7nSI6sfxYjqw/ky3lpLxQlL6Xe7+rGINNZk79IybFlg==
X-Received: by 2002:a05:600c:1ca9:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-4562e039c45mr17589355e9.7.1752657276269; 
 Wed, 16 Jul 2025 02:14:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f2f28sm15022205e9.2.2025.07.16.02.14.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 02:14:35 -0700 (PDT)
Message-ID: <59102a09-1e25-4c14-a681-7170c87df501@redhat.com>
Date: Wed, 16 Jul 2025 11:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/13] virtio-pci: implement support for extended
 features
From: Paolo Abeni <pabeni@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <eb1aa9c8442d9b482b5c84fdca54b92c8a824495.1752229731.git.pabeni@redhat.com>
 <8af39b78-a95d-4093-b68c-20b556860a09@rsg.ci.i.u-tokyo.ac.jp>
 <f1381483-a507-4420-a0c9-52bf8131e6e6@redhat.com>
Content-Language: en-US
In-Reply-To: <f1381483-a507-4420-a0c9-52bf8131e6e6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/15/25 6:21 PM, Paolo Abeni wrote:
> On 7/15/25 9:42 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> @@ -158,7 +159,10 @@ struct VirtIOPCIProxy {
>>>       uint32_t nvectors;
>>>       uint32_t dfselect;
>>>       uint32_t gfselect;
>>> -    uint32_t guest_features[2];
>>> +    union {
>>> +        uint32_t guest_features[2];
>>> +        uint32_t guest_features128[4];
>>> +    };
>>
>> I don't see anything preventing you from directly extending guest_features.
> 
> Uhmm... I have a vague memory of some interim revisions doing that and
> failing miserably (but I have no log of the actual details). I'll try to
> have another shot at it.

The VMSTATE_ARRAY() macro has explicit checks on the specified array
matching exactly the specified array size. Using a single:

	uint32_t guest_features[4];

variable, this statement

	 VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),

causes the following build error:

--
include/migration/vmstate.h:259:48: error: invalid operands to binary -
(have ‘uint32_t (*)[2]’ {aka ‘unsigned int (*)[2]’} and ‘uint32_t
(*)[4]’ {aka ‘unsigned int (*)[4]’})
  259 | #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
      |                                                ^
include/migration/vmstate.h:282:6: note: in expansion of macro
‘type_check_array’
  282 |      type_check_array(_type, typeof_field(_state, _field), _num))
      |      ^~~~~~~~~~~~~~~~
include/migration/vmstate.h:373:19: note: in expansion of macro
‘vmstate_offset_array’
  373 |     .offset     = vmstate_offset_array(_state, _field, _type,
_num), \
      |                   ^~~~~~~~~~~~~~~~~~~~
include/migration/vmstate.h:1090:5: note: in expansion of macro
‘VMSTATE_ARRAY’
 1090 |     VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_uint32, uint32_t)
      |     ^~~~~~~~~~~~~
include/migration/vmstate.h:1096:5: note: in expansion of macro
‘VMSTATE_UINT32_ARRAY_V’
 1096 |     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
      |     ^~~~~~~~~~~~~~~~~~~~~~
../hw/virtio/virtio-pci.c:168:9: note: in expansion of macro
‘VMSTATE_UINT32_ARRAY’
  168 |         VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
      |         ^~~~~~~~~~~~~~~~~~~~
--

I'll keep the union here.

Thanks,

Paolo


