Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C801DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gbQ-0008K8-Nh; Mon, 22 Sep 2025 09:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0gbJ-0008HT-8c
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1v0gbC-0006a1-It
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758547734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAZ0BM6O8Tbwf9x9dPX/q0c+I12wI5EGYfuM6ZQgS7Y=;
 b=G/byy3iK0hTi3L4MXxTsjuaSgzklAMN/abiAHIjUzQbuiIaDz11C0Pa0Dx+sdsD340JgRN
 sNW8aIf91JpaMNHWbHfdq8DTwvCuqTToeEuX9UQPEeo7yNeAPiyMz7h/+4RaGnpLANOYJ+
 TTGC5RwFtkutgPn50GdSKWspueYRFOs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-1QuEFWSnNTObr85o9lpQig-1; Mon, 22 Sep 2025 09:28:53 -0400
X-MC-Unique: 1QuEFWSnNTObr85o9lpQig-1
X-Mimecast-MFC-AGG-ID: 1QuEFWSnNTObr85o9lpQig_1758547732
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46d88f7d691so4028105e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547732; x=1759152532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jAZ0BM6O8Tbwf9x9dPX/q0c+I12wI5EGYfuM6ZQgS7Y=;
 b=B9Bdvr25TjhbzRdB13OYcPxXWBw6283tj1o7vLxAmV3ni4k065/lANkQJZ/FxGF9ya
 4tZYBNwxTnIR6z31VZiHR+/BvSLGe37m0Rz4tJTDtS2n9Jv3fGg6thubtpf38UIkIs3T
 cQlnyLlK9oJjn00k0LB9mMh589VcMugslBLTTC8FYWqPMTYWYzn1N/dyXXDzmNkMuzFi
 7InIFnMppI8DdVp9HWoMp+zQLwO43VHey6Pi40FRdPXIkso8pvBykLhc2bS2vaF2s6PR
 WlkSFzyVh9WRqmWQCd74Qa6Cb+rW98msC2shWndpKms03zSFllLOhmkCmv4e5uX2asvA
 bOWw==
X-Gm-Message-State: AOJu0Yz3NDcUUtY31yIDWOBJVFfNQPJKI082i0is5+PJgryL7IgV6MCe
 hPZdDaShtZSNsvNenF2UcgdlvcHhTojOXfB2gaC0ieIVFgPA+pWJn3yD/RH2HA/QTiHF1Z8RwQJ
 xu/yNrjyVaTE0Cs8VWQHtgm73PVcfBRlD5K+Oyz3WeHU/VWKQQlAmpkx8
X-Gm-Gg: ASbGncseD9ZU2xQh1Fk5fPPRJlkYr4S+oBq2C9zkPfmFoutf+CELxrbRnpLvhTP7JGA
 rh0DCd0wI8kBOE0YL1l0zzcQ+b/vmSC7FZH5kvZPqJSbiitCG1PbfsfaLNLdq1SKp7nwye+i/wx
 yMiCyiYrkrp2WBmN6L27UT/uDq/CSTHeCrxhQIogyPk1gilqehGGyPIPuJ+7Vkqfl0JKZbhYmdt
 4Qe/U778laZbWa1IsfvkgG8Y3eYfjPc1l/+4j17gXCGfMKYWbuXbvwS2BV7qiMULbwbNcLqAzUS
 vYngiMx/AdmIjF9681aVC76ozXZDNz1moq1wHJtuHtuB17rPJc/LpmetusuF/ki67EDEHhEkXdr
 HosSqDizVyCSy
X-Received: by 2002:a05:600c:3b09:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-467eb8e220dmr98023265e9.13.1758547732211; 
 Mon, 22 Sep 2025 06:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGnmRkZD07yml2U7bc8l/td/suENQgXXD236LpM6+aOKLi4AdM9vBUDAvU1JPhkKyWdivOWg==
X-Received: by 2002:a05:600c:3b09:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-467eb8e220dmr98023135e9.13.1758547731798; 
 Mon, 22 Sep 2025 06:28:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f325a32f6sm139058415e9.2.2025.09.22.06.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 06:28:51 -0700 (PDT)
Message-ID: <3f79ff0e-5c21-4a89-99ce-b3fc31da8cbf@redhat.com>
Date: Mon, 22 Sep 2025 15:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] qmp: update virtio features map to support
 extended features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
 <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
 <20250922085341-mutt-send-email-mst@kernel.org>
 <ae5d139a-d6c7-477a-8083-26e64bdeda8b@redhat.com>
 <20250922091422-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250922091422-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/22/25 3:15 PM, Michael S. Tsirkin wrote:
> On Mon, Sep 22, 2025 at 03:10:36PM +0200, Paolo Abeni wrote:
>> On 9/22/25 2:55 PM, Michael S. Tsirkin wrote:
>>> On Fri, Sep 12, 2025 at 03:07:00PM +0200, Paolo Abeni wrote:
>>>> Extend the VirtioDeviceFeatures struct with an additional u64
>>>> to track unknown features in the 64-127 bit range and decode
>>>> the full virtio features spaces for vhost and virtio devices.
>>>>
>>>> Also add entries for the soon-to-be-supported virtio net GSO over
>>>> UDP features.
>>>>
>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> v3 -> v4:
>>>>   - cleanup unknown features init
>>>>   - update QMP example and doc accordingly
>>>>   - use new virtio_features macro names
>>>>
>>>> v2 -> v3:
>>>>   - unknown-dev-features-dword2 -> unknown-dev-features2
>>>>   - _array -> _ex
>>>>   - fixed typos in entries description
>>>>
>>>> v1 -> v2:
>>>>   - uint128_t -> uint64_t[]
>>>> ---
>>>>  hw/virtio/virtio-hmp-cmds.c |  3 +-
>>>>  hw/virtio/virtio-qmp.c      | 91 +++++++++++++++++++++++++------------
>>>>  hw/virtio/virtio-qmp.h      |  3 +-
>>>>  qapi/virtio.json            |  9 +++-
>>>>  4 files changed, 74 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
>>>> index 7d8677bcf0..1daae482d3 100644
>>>> --- a/hw/virtio/virtio-hmp-cmds.c
>>>> +++ b/hw/virtio/virtio-hmp-cmds.c
>>>> @@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
>>>>      }
>>>>  
>>>>      if (features->has_unknown_dev_features) {
>>>> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
>>>> +        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
>>>> +                       features->unknown_dev_features2,
>>>>                         features->unknown_dev_features);
>>>>      }
>>>>  }
>>>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>>>> index 3b6377cf0d..502c9ae930 100644
>>>> --- a/hw/virtio/virtio-qmp.c
>>>> +++ b/hw/virtio/virtio-qmp.c
>>>> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>>>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>>>>              "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>>>>              "negotiation supported"),
>>>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
>>>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>>>> +            "UDP tunnel packets"),
>>>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
>>>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>>>
>>> This really should be VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM.
>>>
>>> Given they all seem to start with repeating the feature name,
>>> why not just add it to the string automatically by the macro?
>>
>> UHmm... let me keep the things simple and just fix the string; macro
>> refactoring could be a follow-up, I hope?
>>
>> Thanks,
>>
>> Paolo
> 
> the fix can be a follow-up too, but I'd like it done now pls,
> there could be more I missed.

Np. I'll follow-up as soon as this series will be merged. I'll send v7
soon with the above typo fixed (plus the others pointed by Stefano).

Thanks,

Paolo


