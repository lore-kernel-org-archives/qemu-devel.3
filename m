Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84052C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGen-0004v0-Cb; Tue, 22 Jul 2025 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ueGGv-0008Aj-Ei
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ueGGt-00066S-5W
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753203317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9IMRC5pnjyWLkLzedIO3vJ4yfRS9ckGvBxr39fPPSY=;
 b=HriEAB8z8IrL5JJfUmxhw33FN21s8bTrFPAgV/t6mf4g0BhTG7XlUQZ0dBt4YVSAH2FWB4
 dfraJAAeqV78HmGHsQyBr7g4UocTh9nHi69SLOzxIFgwfFvV1UWghAPNBcNcKTvpIOaqtY
 oEff5sqFP0mTYpfnL+7yRk7elDRSr6g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-qZ_UEfTHPJyi_wOVat4NVQ-1; Tue, 22 Jul 2025 12:55:10 -0400
X-MC-Unique: qZ_UEfTHPJyi_wOVat4NVQ-1
X-Mimecast-MFC-AGG-ID: qZ_UEfTHPJyi_wOVat4NVQ_1753203309
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so46573f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 09:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753203308; x=1753808108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9IMRC5pnjyWLkLzedIO3vJ4yfRS9ckGvBxr39fPPSY=;
 b=eyT24KR3jU14RWvCAy5U0Bs++5sX3AP+1eGIBOKbBQpdCR1x7tMiiDIRAjVUblH1WG
 YCU8bLicGHW96EFdJuX5wn5lbzXEFwec7J/z5FUWm9QK0Dbk17R33yM//hiSNGiXNwSB
 9/6B7yy22QPAlbpdjn1zCQMuJ+6YTNu+dDBYUfDW5ZKC505jmpwlKmfFenptXKqxQEmP
 fhkyZrWgshHma2J9/mLa9OKaifCt5sZtMxwD8t6amD5Tb/3wq7c8Ve9lTa5N6SvbFF5D
 DCxogMUgLGcjvd4jV/lwqzH53bac2UbAi1DQO+Ayc2hYIvUZ+oqSZwUCZZKD4VObtTC6
 Lkbw==
X-Gm-Message-State: AOJu0Yxo5+f5FUmEgCztsbVFMK7bL8mJIaS5tMi5ZerHze8D1xb4AQ4W
 4TmsqiLHh83HHV9XoyWvahH6hDYnmVgvL5T2TXdeRYr6FN95SYjcq0Sptwoho2dxZtaY+gO/hi8
 f9draWDAbUaFnKs0Dd2nYP8LmGocgSbf2/G9hv/wlFURPfCLM4U59lQ6T
X-Gm-Gg: ASbGncsQ+oDRM1SzLM+UtyQlIj7Mz25Jk5o46ayiWWqVcCnPpcKy6n1IKH8JvVjQQ0M
 5aT1fjq9L6VeUZ4rCtZqj/mDbIbaDDSgOq2F+a63woPyHFYMz+n9i5M7qUSn4cBzbhAVMXPURYF
 3Mgj1JgRvfJABeZAHHL7WqU21kDmPzG5GCSwFslxoV81LdILq0MZ2Sji/Qr8HB8FmYedtWLfrE5
 ja/xYV/NgMQYeF2/qu4Z3s/4fcxL4/vLetbZvS+jeeWehbsuzgBdxLBqiZpIOxLIjWY4xZ6S0ia
 7G7Zq/vvu9lQphEaHgo0kc00/DP54rWdvd1HjssB6Wo=
X-Received: by 2002:a05:6000:1885:b0:3b5:f8ea:28ff with SMTP id
 ffacd0b85a97d-3b763485513mr3278682f8f.6.1753203308532; 
 Tue, 22 Jul 2025 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxB0dSp3mNeY+G0Y+KSBUIswqqLeABL1nXeIVs8sbcTpEuH8HfoUosvpZwQxLYWXnYnyx04g==
X-Received: by 2002:a05:6000:1885:b0:3b5:f8ea:28ff with SMTP id
 ffacd0b85a97d-3b763485513mr3278666f8f.6.1753203308019; 
 Tue, 22 Jul 2025 09:55:08 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca315basm13924239f8f.39.2025.07.22.09.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 09:55:07 -0700 (PDT)
Message-ID: <776da82d-b218-45fe-8780-e8048b6074de@redhat.com>
Date: Tue, 22 Jul 2025 18:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
 <CACGkMEtWOk2o1xRK9XtaXPuWBnd8Yrfk4DVNJZB4kRCZzxWwRQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtWOk2o1xRK9XtaXPuWBnd8Yrfk4DVNJZB4kRCZzxWwRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/22/25 5:32 AM, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 4:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Similar to virtio infra, vhost core maintains the features status
>> in the full extended format and allows the devices to implement
>> extended version of the getter/setter.
>>
>> Note that 'protocol_features' are not extended: they are only
>> used by vhost-user, and the latter device is not going to implement
>> extended features soon.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>   - fix compile warning
>>   - _array -> _ex
>>
>> v1 -> v2:
>>   - uint128_t -> uint64_t[]
>>   - add _ex() variant of features manipulation helpers
>> ---
>>  hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++----
>>  include/hw/virtio/vhost-backend.h |  6 +++
>>  include/hw/virtio/vhost.h         | 33 ++++++++++++--
>>  3 files changed, 100 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index c30ea1156e..85ae1e4d4c 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>>  static int vhost_dev_set_features(struct vhost_dev *dev,
>>                                    bool enable_log)
>>  {
>> -    uint64_t features = dev->acked_features;
>> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>>      int r;
>> +
>> +    virtio_features_copy(features, dev->acked_features_ex);
>>      if (enable_log) {
>> -        features |= 0x1ULL << VHOST_F_LOG_ALL;
>> +        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
>>      }
>>      if (!vhost_dev_has_iommu(dev)) {
>> -        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
>> +        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>>      }
>>      if (dev->vhost_ops->vhost_force_iommu) {
>>          if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
>> -            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
>> +            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>>         }
>>      }
>> -    r = dev->vhost_ops->vhost_set_features(dev, features);
>> +
>> +    if (virtio_features_use_extended(features) &&
>> +        !dev->vhost_ops->vhost_set_features_ex) {
>> +        VHOST_OPS_DEBUG(r, "extended features without device support");
>> +        r = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    if (dev->vhost_ops->vhost_set_features_ex) {
>> +        r = dev->vhost_ops->vhost_set_features_ex(dev, features);
>> +    } else {
>> +        r = dev->vhost_ops->vhost_set_features(dev, features[0]);
>> +    }
>>      if (r < 0) {
>>          VHOST_OPS_DEBUG(r, "vhost_set_features failed");
>>          goto out;
>> @@ -1506,12 +1520,27 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>>      }
>>  }
>>
>> +static int vhost_dev_get_features(struct vhost_dev *hdev,
>> +                                  uint64_t *features)
>> +{
>> +    uint64_t features64;
>> +    int r;
>> +
>> +    if (hdev->vhost_ops->vhost_get_features_ex) {
>> +        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
>> +    }
>> +
>> +    r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
>> +    virtio_features_from_u64(features, features64);
>> +    return r;
>> +}
> 
> Nit: let's have a vhost_dev_set_features() as well?

I guess you mean to factor out the
vhost_set_features_ex()/vhost_set_features() in a specific helper am I
correct?

Note that there is already a vhost_dev_set_features() function. It's
touched by the previous chunk. I opted for not creating the mentioned
helper to avoid some weird naming issues, as such helper would not lead
to any code deduplication.

Please LMK if you have strong opinion for a different choice.

Thanks,

Paolo


