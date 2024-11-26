Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F8AD3B9B2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxt0-0006L9-2J; Tue, 26 Nov 2024 10:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFxsy-0006Kk-6F
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFxsw-0004u1-Li
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732636433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KE9ej8SXahlscLndMydhMSLCQD7wA69jhqva7D7oJ60=;
 b=Yubfpur7/FCDPtCGJzLzKvYDMp452tnIx8XApOueFRg2gerBV+ccpqW1LTywc43tYSM7yi
 tTugrv3EYNK/Ul8M7KSj3RXn7Ojk6ZwA/f2AuuyEhs6HGogQtUExkxzzrbPcTgS7/mUbgw
 Wdm3rNZnqxn/GXV6Docfe9zkSlASHqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-_-pgYZXGNh-fxKshYo0j7g-1; Tue, 26 Nov 2024 10:53:51 -0500
X-MC-Unique: _-pgYZXGNh-fxKshYo0j7g-1
X-Mimecast-MFC-AGG-ID: _-pgYZXGNh-fxKshYo0j7g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38233ea8c1bso3596934f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732636430; x=1733241230;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KE9ej8SXahlscLndMydhMSLCQD7wA69jhqva7D7oJ60=;
 b=hjShl8/JQ+U6bQ/36WhgKCp7QxhQznRjex4GH7BYPlgn7Zri8vTHf66QuVw3lIOmd1
 yJuZ3w9pW6l8gwJciuFY+Uc8ob+bXw+Mz2wWo7OGBNIwbh1iaO6u2gfVYIxPANjoe+5k
 30hnXJz0G76EFJ5Jem6vsAJoLkXrR63IXVuD/Wty9x2QVOwruBki9ZvmSQGUJMjzVUAN
 hN64UgNdfOTvk8u0D71ZiTWybN7A43ORsK6b2Oz4MwgHUN2VhrolM1CTT33WxEFjUoyu
 cAPmSR+E2CdLMDeODqTSf4rP91ESWZ5eFXpxdfsI+JjXVNvQ6uEZ36y1X9SGeVCOp7tL
 9auQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGdqUK3YFVvIdkPzfOg1SmoUCy7IuY1FQXg+7zXESX0cifX02GLjkR3s2QUS2ftlwDeino4TOAwV4P@nongnu.org
X-Gm-Message-State: AOJu0YxgCDwnpz2VsQl4SdZWYLsBYwPI8BmmJJOLz/S+iq2aaRDKGfvj
 iP3YY8LpsT34v/6Lsm5pf+9IvLmTbDQXAX/bhzRkrxI3KKEUhY6pLap9zcC2tbSK8Hd5JjR0cds
 2DD4owU/zBkDjvuvzM+uukhbBWgd6xofH3fOQR8r3PUU1hE4cub+G
X-Gm-Gg: ASbGncveV+wSKmxvXwIZ1mvfL9E65x3LcwJMoK1wUwIzEKGyVbStRWdBZI1EOtaskv9
 vSe5JqYB90xQh2FV/khDX02hjHRm5msOUpARmZIgCkDyCopZ+leI3ICexk7lA5UYM5gasntpMIr
 UHKhFD07kM0DQGkpIrCk82kbtrD07DGcpzgnZJmYPO/oz5+V2OpmQ9ozF51R4GZXwOTu3r6+nA6
 bLHiW/Rg9FY3UVc/RDbmnc4MVEddWMqXP0hk5Vfmcu0mM6RLUjIlrLMuzz24/u04Oekz1VOFQZq
 /c0=
X-Received: by 2002:a05:6000:1ac8:b0:382:395d:bf93 with SMTP id
 ffacd0b85a97d-385bf9ef35emr3349478f8f.6.1732636430600; 
 Tue, 26 Nov 2024 07:53:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWlzhR3fwLsVwviUNeoZlzjXU0gw44jQDEAO1T/29Upv8HWssq2Q0cpp6ijNJofF4O0IVH7Q==
X-Received: by 2002:a05:6000:1ac8:b0:382:395d:bf93 with SMTP id
 ffacd0b85a97d-385bf9ef35emr3349464f8f.6.1732636430257; 
 Tue, 26 Nov 2024 07:53:50 -0800 (PST)
Received: from [192.168.3.141] (p4ff23d2a.dip0.t-ipconnect.de. [79.242.61.42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd04ef5sm13575850f8f.111.2024.11.26.07.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:53:49 -0800 (PST)
Message-ID: <ed809337-4055-4ad4-b0f4-8d71f957467b@redhat.com>
Date: Tue, 26 Nov 2024 16:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <79c4ed2c-2ac8-43b5-ad90-2b91f6e7fd8f@redhat.com>
 <d75f20d9-dd4a-4439-a261-612766b7cfba@redhat.com>
 <0a3b9e0b-6725-44f8-8599-ae868a3fc864@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0a3b9e0b-6725-44f8-8599-ae868a3fc864@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26.11.24 16:41, Wei Chen wrote:
> Thanks for the information! I will try to come up with V2 that does not
> impact virtio-mem's functionality.

Thanks. In case we want to go this path in this patch, we'd have to glue 
the new behavior to a new feature flag, and implement support for that 
in Linux (+Windows) drivers.

So if we can find a way to avoid that, it would be beneficial.

-- 
Cheers,

David / dhildenb


