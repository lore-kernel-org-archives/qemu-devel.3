Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB09C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23tT-0006QC-UQ; Tue, 08 Apr 2025 04:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u23tQ-0006Ku-BI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u23tM-0006FO-4V
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744099266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BZX4Yk07RRqkiy1iF5ETNbZ0QOuKcGRu12r903hHR6o=;
 b=UPGJhr+ZMjyhCNFpWAqmFkVAtAURD1L6+xN8oQFJmKVKLJVbQlOnC6er5NRe/4gkW/hVEp
 qNI3RCghyvRn/mgpl5JXFYpA0InFki6FNwvzMu9q1KRl/z2NRf/6PMaAn1ZGqYh6cbUpUh
 iaEaToLt0UuHNm6OwP4f/7w4QfIRIFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-cR2wUJU7OKGkG_M7V-ZIiA-1; Tue, 08 Apr 2025 04:01:04 -0400
X-MC-Unique: cR2wUJU7OKGkG_M7V-ZIiA-1
X-Mimecast-MFC-AGG-ID: cR2wUJU7OKGkG_M7V-ZIiA_1744099263
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so2845521f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 01:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744099263; x=1744704063;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZX4Yk07RRqkiy1iF5ETNbZ0QOuKcGRu12r903hHR6o=;
 b=lLRi44MEmFWDUp+wxAFNmcQg9HTg0kXNCzp4nS4oxj/7Khzx2/D3qSyLKPRAprv0bX
 F1YE8jUmGNS/v8I+7ahAEb8xQUY4Eb2sdR6/BEKkSQWV3x06hUa4GVGMN5nuW/CDX7va
 k/Me6vIMlNXZoat88NNyXJa7b84LiwdWO1sqhmMqwNAzNKFZsBWvk7WoKXDY9laNMpgM
 LyONmuvrSPzmFHgDqwW86GEJ/pKDM3jtleUTMTUJpuHVccG7SUVBfBozEzTGIKMy6XFJ
 ew/VDepV9I2iMFO6c44iq9xTMKN/fxhDmfEQWpg4gxYHUkg2gvwpiyYBB2CrWQTWke8Y
 3Rxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaqhhgP854etNsZdHjHyIIAUTgeuQCvvAFdNZFFAOaVb6RGKbm1/9G+y19rDn6GAff5eoZ0lPApAuy@nongnu.org
X-Gm-Message-State: AOJu0YyUqkSidmTh0YvU4TZ8zDjgFR+Mt+dYUFo6NMLrU1CIUycskQYj
 FfjY+/czfyo8hGzqZJSCqizhkk3nr40231VsWj4Pja3yewf5gVIxH42ex1t880RsEV13UUNnQf5
 seseZ00WHsYX3CgDs9HnB+yR7L7tOzK/kOjTGLaTDU84kNpNXCRzH
X-Gm-Gg: ASbGncu1HF47hiHjb4f16mBU64J4wI11eW9LrqAilecdecW8bOjnJaEM5Wejj4iNtNE
 eid3xB37px4fK/KRoSSjFgYi1i/pEVJWESihJHlw243au2kRpqN6XAqknH2w6E9lkY7aIGrUC3U
 OkqQT9bTEVe1/Aq+jIEGstU7WkasG78AeB800zz0WX2YeskoKubVYfP2gVttPpeUqPaDIdlmsZU
 ZTd77Yzt6sfA4rgfbqIRkpU4fQzbVhPud3FUb4yfbXT7O8nXH/9VrDNb0ZdBXXs2tiJE5kEvKp0
 o6cDt7R/I2QxoYlVsjmaOpiTX42LQ5796SkAU/z0JlHLTJdKo3WWbg==
X-Received: by 2002:a5d:5f48:0:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39d6fc4930amr9728277f8f.17.1744099263056; 
 Tue, 08 Apr 2025 01:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCzfCz9R5qysyrxllZR0v1MpwBYeZt3TjAjfgST52/EHulI3aFPcokSqZAukJ8gPcaObIFTw==
X-Received: by 2002:a5d:5f48:0:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39d6fc4930amr9727604f8f.17.1744099254345; 
 Tue, 08 Apr 2025 01:00:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm14246962f8f.60.2025.04.08.01.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 01:00:53 -0700 (PDT)
Message-ID: <16fc9fa0-2b88-4029-ad0b-cedc279c956c@redhat.com>
Date: Tue, 8 Apr 2025 10:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
 <084cbb65-f3c3-4f18-ae3a-88f20480d2ff@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <084cbb65-f3c3-4f18-ae3a-88f20480d2ff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/7/25 13:19, Cédric Le Goater wrote:
> On 2/19/25 09:22, Zhenzhong Duan wrote:
>> Currently we have realize() callback which is called before attachment.
>> But there are still some elements e.g., hwpt_id is not ready before
>> attachment. So we need a realize_late() callback to further initialize
>> them.
> 
> The relation between objects HostIOMMUDevice and VFIOIOMMU is starting
> to look too complex for me.
> 
> I think it makes sense to realize HostIOMMUDevice after the device
> is attached. Can't we move :
> 
>          hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>          vbasedev->hiod = hiod;
> 
> under ->attach_device() and also the call :
> 
>      if (!vfio_device_hiod_realize(vbasedev, errp)) {
> 
> later in the ->attach_device() patch ?
> 
> hiod_legacy_vfio_realize() doesn't do much. We might need to rework
> hiod_iommufd_vfio_realize() which queries the iommufd hw caps, later
> used by intel-iommu.

The only dependency I see on the IOMMUFD HostIOMMUDevice when attaching
the device to the container is in iommufd_cdev_autodomains_get(). The
flags for IOMMU_HWPT_ALLOC depends on the HW capability of the IOMMFD
backend and we rely on hiod_iommufd_vfio_realize() to have done the
query on the iommufd kernel device before.

Since this is not a hot path, I don't think it is a problem to add
a redundant call to iommufd_backend_get_device_info() in
iommufd_cdev_autodomains_get() and avoid the IOMMUFD HostIOMMUDevice
dependency. With that we can move the HostIOMMUDevice creation and
realize sequence at the end of the device attach sequence.

I think this makes the code cleaner when it comes to using the
vbasedev->hiod pointer too.

> Anyway, it is good time to cleanup our interfaces before adding more.

On that topic, I think

    iommufd_cdev_attach_ioas_hwpt
    iommufd_cdev_detach_ioas_hwpt

belong to IOMMUFD backend.


Thanks,

C.

  


