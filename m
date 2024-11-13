Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91409D41C32
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBAoS-0005jb-OZ; Wed, 13 Nov 2024 05:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tBAoR-0005jM-74
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tBAoP-00043A-VN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731494483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ilqw2CHhh6L53SCGGa4T6xUTh3AJOaAiNbq0K1ZHXOM=;
 b=QSPx1p+Ov9afGpswN4Pj0VkxO26jZBXUCTbCptLe28FBreKWbzZ6ytfRF2IqKW2vOrAOg5
 zEdTh9Hwua7QCeGXYI07fBNb5Sr+3+nnwvGoYFWf9ARff/+O+OwjXeUCu4rQRWZK5f+QLg
 8E2FuR73Fq+bNcxghts5iAYhWy4BnvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-0m68L-ZmOEajNha9wMo-2A-1; Wed, 13 Nov 2024 05:41:21 -0500
X-MC-Unique: 0m68L-ZmOEajNha9wMo-2A-1
X-Mimecast-MFC-AGG-ID: 0m68L-ZmOEajNha9wMo-2A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso3653765e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 02:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731494480; x=1732099280;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilqw2CHhh6L53SCGGa4T6xUTh3AJOaAiNbq0K1ZHXOM=;
 b=CeFEcr7XQQGxW/wucM+icD/AIIIo8OqmzGwEeNQbrf0W6Grj6Lfv9QFBH/6U7P00Yo
 ng26X7mAIIYLEDwXn9Fpg6yUQi1YyHqJzfVz+yJDufkMkTyUCm+df1x5RzPqc7Imj6E4
 QIZ1H5DhLyMppTvl5IMOOluY6e6MdjUiTYtSx0WoT3Cn0xyl2+rHjnXuTvxp23y+Ygxa
 5xv3mLPHBnNWGIiQKgvVoaU3zcSShCFn4reWb0KiA73nAbrizM0K8zywcF8qhbh8KLOq
 6/29JoijF/lfnkw/GzWLoiKNQdMbg6K/sfOtlgQIq/GkHtTB9tesbu0w0sReXJhqb55z
 TUrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG8JGb6Lc3IIqPxc9f9dLAsuzrKcyD7Si9WSqrgDEKVEZ9Zx3VZzv4EsPPJqHOPf+qHq5jcGffcZ2g@nongnu.org
X-Gm-Message-State: AOJu0YymvBhzJTLXnMvUG/8XRi1zzdIkDaHKNJ4tvA921oL8kFage+Ww
 ZJFf/35C5uC1LE5CtgawKpU2Oq35KNFpVh/AaaJiEtN/VKVQ1AfGwy0NWpYlzNYQWqHnvXItJrO
 OQ4KjMPrHFlO5D8+RcsoO+rM/KXrM5CRsCC+O+z2c6vMxh7oYWegF
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432b77fe58bmr170968035e9.0.1731494479844; 
 Wed, 13 Nov 2024 02:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiT+p8QjmPLpNRZ5nE6tKUE9dWoPx3svVLGGW3WkCaMLrU75zJ4kI8isIr2fMuxGdRYH62Dw==
X-Received: by 2002:a05:600c:8608:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432b77fe58bmr170967855e9.0.1731494479434; 
 Wed, 13 Nov 2024 02:41:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d54f82b6sm19833565e9.15.2024.11.13.02.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 02:41:18 -0800 (PST)
Message-ID: <fe4cd7d7-99d7-47db-9a03-5ebe115bd86b@redhat.com>
Date: Wed, 13 Nov 2024 11:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Add queues before loading them
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20241022-load-v1-1-99df0bff7939@daynix.com>
 <20241023040059-mutt-send-email-mst@kernel.org>
 <CACGkMEtKBdwkd9LDaMAga0YoJgBj5Pj_rL7ii8C3_SCC3XnPPA@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEtKBdwkd9LDaMAga0YoJgBj5Pj_rL7ii8C3_SCC3XnPPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/10/2024 10:44, Jason Wang wrote:
> On Wed, Oct 23, 2024 at 4:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Oct 22, 2024 at 03:49:01PM +0900, Akihiko Odaki wrote:
>>> Call virtio_net_set_multiqueue() to add queues before loading their
>>> states. Otherwise the loaded queues will not have handlers and elements
>>> in them will not be processed.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>>> Reported-by: Laurent Vivier <lvivier@redhat.com>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>>
>> Jason, your queue?
>>
> 
> Yes, queued.
> 

Is this merged now ?

Thanks
Laurent


