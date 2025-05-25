Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67BC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 21:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJIpJ-0000X6-IC; Sun, 25 May 2025 17:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJIpF-0000Wf-Px
 for qemu-devel@nongnu.org; Sun, 25 May 2025 17:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJIpE-0006r5-4l
 for qemu-devel@nongnu.org; Sun, 25 May 2025 17:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748208242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMdC/hyJGUnWtM01CaSKaQjQDtgCYtSA6RVVyC/U8m0=;
 b=KwMZAhh88K45M3KqStT3Oos/iBo+bv0iQEaptzXvRw1yKea82/31GlrfYu/cagwiYkFXE4
 6CKtxkVbqHOw4GBIiaHQmSfkpwIlx+uqPdmTcggMe9M9ChNpVDEhKSjxi5lDeqsu+DXv26
 Ic1+CQBNWR0rykIoC0OyIPHbeGEqmME=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-7RiAn9G0OO2XDeZNxL1kdQ-1; Sun, 25 May 2025 17:24:00 -0400
X-MC-Unique: 7RiAn9G0OO2XDeZNxL1kdQ-1
X-Mimecast-MFC-AGG-ID: 7RiAn9G0OO2XDeZNxL1kdQ_1748208240
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso5932055e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 14:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748208240; x=1748813040;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMdC/hyJGUnWtM01CaSKaQjQDtgCYtSA6RVVyC/U8m0=;
 b=YhC9ElvLCAYNk8ziWx++QFEl7Ogcva02Je62r92NzfjLq402sb5y7ilO5+Jbu5JHvy
 Dzng7XzgAtKqIsYYXqBxMkMfZXXjqEeLJm/y1HdMDBrFlE+YRgoqyZ0lFMHZvk5eJKGr
 8lPbGPwPyAwWLZVH89S3/+9Cqfrl8mBGXzlK64vQxVwSXawavR4lGlsCekOKCZ7euqBM
 SQJsYWP92p+//I/s2BBIQu47wkr5DnEo+RVaHRLDZTmfvq1+1qJgJ0hm6scMjbNjPsBq
 SSsEN1pnQ/MXPWqrPnIoldJnFr/wmT5ody3PtllA1wvPxFpTxBJvMLOiRA1rvhTvSIjX
 p+rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ8mIpdhwBpKS8iO2to/62itHg9BnAgzM0KVc9KR6ZTldDIthcM9DxWrRvK0vnNigSsOacRj03+7Zh@nongnu.org
X-Gm-Message-State: AOJu0YwTwtIOLmoQ/h0V8EU1gidIV+WEi07GXJzN7frzfGrufeG7xFBn
 tl83fS6XGbf72HNOU+1+UgMD5hDzradTgCbBToqDUUdMptWqIiMOm3yHjt7TtGuBkFnBDzSX2oH
 SluMGnDzyeRhhH7sRr2goA0gCvLtxvCuVkHKQXW7usM9OoZffcUSMls9v
X-Gm-Gg: ASbGncuefK4/wjpC7yxBOHn3rd6/ltLrRl0oTX/MlyneK/DUst7u6kyW27lVPQF9pQk
 LCiVj6CmBsSvn+iHmEuujrVfGx0Vjf1U3bHyP0Wm+c1Nhyb4cjctVus1afNbpM0S7sfh6xJfm8R
 pQkQQ6CwdjadM87PbrhfeFRe3DIDNklXYJ1ZAm+ijCGAdBugkxNehfV5cMdAjNPtm8PY3Rqawy1
 nCnOrIWzY52bwcoN1TGtkKPL5yC2BjWifoMuwm7Pcu77SbA3povhK4gs7jMRRUfd3/QTjz+c9HB
 5KgaPlfEdJnNfyarIXKmrYeDU7ft5hBtTOOqQdFuW0Tbx9c44A==
X-Received: by 2002:a05:6000:2211:b0:3a4:d8b6:ca3f with SMTP id
 ffacd0b85a97d-3a4d8b6cc0bmr1097043f8f.30.1748208239748; 
 Sun, 25 May 2025 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGefmKKvZzDwJtrzxPwjzDgzpvlazlZj2DNn/3B94GLOfjinqHrgZq3RA8a/2PbNh4I84FHWg==
X-Received: by 2002:a05:6000:2211:b0:3a4:d8b6:ca3f with SMTP id
 ffacd0b85a97d-3a4d8b6cc0bmr1097033f8f.30.1748208239417; 
 Sun, 25 May 2025 14:23:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d6c9faffsm2022533f8f.74.2025.05.25.14.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 14:23:58 -0700 (PDT)
Message-ID: <bc0d41f3-752a-4797-ac61-6716d78a2aea@redhat.com>
Date: Sun, 25 May 2025 23:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
 <bad3129a-8470-415e-8e85-0238b3ef1b26@redhat.com>
 <ef48d347-b36e-4442-b97e-bea284eab1ac@oracle.com>
 <304064d5-7211-443a-8ded-43f704a7ab1f@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <304064d5-7211-443a-8ded-43f704a7ab1f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael,

On 5/20/25 15:46, Cédric Le Goater wrote:
> 
>>>> @@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>>       ram_addr_t translated_addr;
>>>>       Error *local_err = NULL;
>>>>       int ret = -EINVAL;
>>>> +    MemoryRegion *mr;
>>>> +    ram_addr_t xlat;
>>>
>>> xlat should be :
>>>
>>>      hwaddr xlat;
>>
>> Will you make that change when you pull, or do you want me to submit a V6
>> with this and the RB's?
> 
> I can handle it.
> 
> An ack from Michael (vhost) is needed for the PR.

Are you okay with us merging this patch via the vfio queue ?

This would facilitate the progress of 2 larges series : live update
and vfio-user

Thanks,

C.



