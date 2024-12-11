Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AFAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP79-0006OC-H1; Wed, 11 Dec 2024 10:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP75-0006Nw-Q6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:59:00 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tLP74-0004PH-DU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:58:59 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso3576811b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733932737; x=1734537537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DPncGeCk5CpnPSb2PpqPFzcGEhpDMKSVRWofbaFTbpo=;
 b=Xoy/mqRWu8Ft76lSiowrQiqPvR15QrWRdRyViOVt5EpJqFsnq08BYcyUg0AOIm1sKc
 pkFAW1F/jl16GmEls09DSLGIaS7jXyeAsRsVI99uhSu6vG4cB1HF3G3x82ZwRTZjq+CL
 wvmhZEqnMabMBwtg8okSTE2nNJl+XoRaixY8htlQULftX1eTUSJer7UmivdAFXHWZJED
 fJPgGjwAqaIOgjnZNulGudsSkAmIa2P5XPURwbhFZupuL8Z8sOidrLimmWzLNUNIhdox
 D8Kk42cF/SU7J78GBcWHC1n3hB0pE+RIAjbCuKb5zxsg2OMTWZSLAIbydBa3oTm/7hS8
 InIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932737; x=1734537537;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPncGeCk5CpnPSb2PpqPFzcGEhpDMKSVRWofbaFTbpo=;
 b=YMECNtEAmYZW+/eFnxRXwMCUjGnSOW525lzKbT/YUa2023b5wbC8+nac0ZxKP7y1vx
 NW8TH4z3II601ShF/7wycPayknaug2P7N0Wwl7on0Q4C1mHWLxuNNYsgF6gjSi5iU+TY
 jc9HkKELiW+P9njO6LSvMpiIQKNYgngM+n7S37/iASuNJi5pdqqF/I6bt0/Z5Z2co5xe
 0fbUkv0BLCYAOX0ETNYvVepHQXd7RYnt30MBbsM12OMwdMAeuh9HPewusU8KUGc56aYH
 gRJTE5bn3XVU6znpeS0IcfYPU6U9NnHyyfLIoW7C8NcGZ92ogQ2OL5ytKi+hP1glGegq
 +AVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjzUhLJjHvX6YZPkdmkhQDKnq6krC8c/doM55ZoNTMNthEy4tlmKX5JFeX68iJuc7BdP5gRN7CJ8lP@nongnu.org
X-Gm-Message-State: AOJu0YzpYzwjvd1BhpPSaaH8mB9VKN+/JylQ9UBib+pgrttbUdolegJR
 Eq3fU4IyXiGH/x2Q0JrVMY7JTixQUqpJOJL0Lgy0VVV0oTnldMSYZoxTug==
X-Gm-Gg: ASbGncsE+uSLbvLayBSag6fYF809ZJZ8PaJ+d/smztWfQ3cAt9vaU5hNnTGqDjMurYB
 G9aU/HanWHd46OYjau1zyTdB/il3VVpzlEJHXOF1qsrY5DE4CHqK2ygC4YKvO5GyEQEtfdpVlTC
 X/WkDzT6EyjEnYiv6KKSqM4SZymWXRq+mBfIiklHGsKdprJeIaPw/Uh0hWlFjkUndnjTiL3c0YV
 dyVoKiMM8THlKVtiSol0XK+
X-Google-Smtp-Source: AGHT+IG2VJS23zjhUVBo37vXxa+tkqX5j3uguUioJkTXPCYGlwoCYEWsFcBzxaG/aX+ywMQC0n7vDg==
X-Received: by 2002:a05:6a20:d50c:b0:1e1:9fef:e96a with SMTP id
 adf61e73a8af0-1e1c12aac6emr5323912637.6.1733932736888; 
 Wed, 11 Dec 2024 07:58:56 -0800 (PST)
Received: from [192.168.1.18] ([223.233.86.194])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725d911615asm7768039b3a.147.2024.12.11.07.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:58:56 -0800 (PST)
Message-ID: <511b1b12-cb5f-4636-a331-aef0575b3e88@gmail.com>
Date: Wed, 11 Dec 2024 21:28:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/5] vhost: Write descriptors to packed svq
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <20241205203430.76251-3-sahilcdq@proton.me>
 <CAJaqyWchuA__QeFVCgozSJGQdLfhGD97x6vm3zRiuM=8q+tm-w@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWchuA__QeFVCgozSJGQdLfhGD97x6vm3zRiuM=8q+tm-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

On 12/10/24 2:24 PM, Eugenio Perez Martin wrote:
> On Thu, Dec 5, 2024 at 9:35 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> This commit is the first in a series to add support for packed
>> virtqueues in vhost_shadow_virtqueue.
>>
>> This patch implements the insertion of available buffers in the
>> descriptor area. It takes into account descriptor chains, but does
>> not consider indirect descriptors.
>>
>> Also validate svq-specific features that vdpa supports.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> Changes v3 -> v4:
>> - Split commit #1 in v3 into 2 commits.
>> - vhost-shadow-virtqueue.c
>>    (vhost_svq_valid_features): Add enums.
>>
>>   hw/virtio/vhost-shadow-virtqueue.c | 83 +++++++++++++++++++++++++++++-
>>   1 file changed, 81 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>> index bb7cf6d5db..6eee01ab3c 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
>>            ++b) {
>>           switch (b) {
>>           case VIRTIO_F_ANY_LAYOUT:
>> +        case VIRTIO_F_RING_PACKED:
>> +        case VIRTIO_F_RING_RESET:
>> +        case VIRTIO_RING_F_INDIRECT_DESC:
>>           case VIRTIO_RING_F_EVENT_IDX:
> 
> This is good, but it should be added in the last commit. Otherwise
> we're enabling packed vq without the code to handle it.
> 
> The rest looks good to me.
> 

Got it. I'll make this change before sending the next patch
series.

Thanks,
Sahil

