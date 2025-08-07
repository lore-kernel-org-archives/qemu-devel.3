Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF34C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 20:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk74c-0003jQ-SJ; Thu, 07 Aug 2025 16:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uk74b-0003iu-GS
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uk74Z-0003Cx-8G
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754597923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2OY/bQK/bo8qD2ZyI6I3wo0z+Cvow2EolW6L7OKFR8=;
 b=BFOo0Vs6gsn90K+7anP6FtBd5PIK0JZcYCvMTY0FPIiNqChgltyB3ns1p/FRkJh9u/Kfuk
 RytT53oO6JmMbzQ+1xD3GFlTUg1uK1EZX6g3venFw8Q/66oNSZW8X2AZBAjKxjGJgch1GJ
 ClzYQS2qG2Cygxcnh5t7IdpyLN28FUw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-JxaMv2jvMO6HJ7F5HtzeyQ-1; Thu, 07 Aug 2025 16:18:42 -0400
X-MC-Unique: JxaMv2jvMO6HJ7F5HtzeyQ-1
X-Mimecast-MFC-AGG-ID: JxaMv2jvMO6HJ7F5HtzeyQ_1754597921
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b836f17b50so627976f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 13:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754597921; x=1755202721;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2OY/bQK/bo8qD2ZyI6I3wo0z+Cvow2EolW6L7OKFR8=;
 b=VyxNcaapYt873zvrGNjTTGhwsMSsiI8ge48PSmyHMHGd8HNtVhqJ1VLGa20zyRd+xe
 +F+t4vvOaYbhni1QRMOn/hyJYDdHO9F/QSkL8qlNkRNguyTQ3PbsngNiJpA92x3YcO90
 b2Wp6oWBotBoFROM4DCciGiDVo7DPl199DxkI3mgVpWgx/rBtMvWxFxTRqIYzUMBNS7y
 jGNU6gdNfBz1VrsEJz7MLyUiq1KUcQ4hZiDpyuibqBh8rcZx+ZN9Ya1CSsmB8mTkkHAv
 JSP4l+/JD6Ivm+ZOxineeJA6vP5foEHaoNaxBuSxb4HxgshgwnS/Gakrv0GTa0oZysA7
 YiMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjwT+EqdEGm45GXgKF88b+9pS+Kw8rLO70JJL1vFKYxpfXGMFXtItXVjGWMr+DZe9Ihw9zX1eJ9qe2@nongnu.org
X-Gm-Message-State: AOJu0YxYN+9YKedHg7aHNAdub+iyzd7mWr13AV3t84EvcYSyTxK2fOHR
 BmzCrn6a2cScwYQlY21ZnvSLc9uYq15g0wh/Nu+UjKzuwx/vJer63ZNntqDEgVOqcl9QcrQTfLu
 dw+OR9QdPq1FWT2WBdyxJZrA5NQKUGNh6Q2gIvcmjXpCjo27EdKyO/QCx
X-Gm-Gg: ASbGncuPyqXwjvjzEnkNcLWcGtUN1P+H1ahHOkkGlPfjoFlivRe/t+Usyx8zCZ7Dh26
 EZCsciYIzvdkwa5068U+YKwGhcLnn4b3YyZlUD0TBEx6xrJQaPaYmLR9rsaRe/SXwsNtJbU1b/a
 i+49DqbDbilV7FLcCo6bRmZ02D2dvGNHqZ1MAuOElVEedVNTqOaqkeTTmN1BDGYTac8zmIxoqge
 HGIIc58FRW6PYCRG6F+g/Z9JWdMdfffc5mlY5Wub35z/qiRAabazuSwGnLTSuqbSSKoNgLc7566
 adihss1I/Ifu8k688S90mPgnuP7iXd41d3wN8giB7Vo=
X-Received: by 2002:a05:6000:2011:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b900b4dbdemr413792f8f.34.1754597920865; 
 Thu, 07 Aug 2025 13:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUxLDmsSH/R25WZTJge5V9qcZyENHiRnw0BUVWz8COetj9VQ1sx9j2vDWVDIgCDZBTfrn1ZA==
X-Received: by 2002:a05:6000:2011:b0:3a5:1cc5:aa6f with SMTP id
 ffacd0b85a97d-3b900b4dbdemr413765f8f.34.1754597920457; 
 Thu, 07 Aug 2025 13:18:40 -0700 (PDT)
Received: from [192.168.0.110] ([169.155.232.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469319sm27310805f8f.54.2025.08.07.13.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 13:18:39 -0700 (PDT)
Message-ID: <7c7c3f2c-e643-46ad-810c-aefdd486ad78@redhat.com>
Date: Thu, 7 Aug 2025 22:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
 <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/26/25 1:52 PM, Akihiko Odaki wrote:
> On 2025/07/24 4:31, Paolo Abeni wrote:
>> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>>       return virtio_pci_add_mem_cap(proxy, &cap.cap);
>>   }
>>   
>> +static int virtio_pci_select_max(const VirtIODevice *vdev)
>> +{
>> +    return virtio_features_use_ex(vdev->host_features_ex) ?
>> +           VIRTIO_FEATURES_NU32S :
>> +           2;
> 
> This function could be simplified by replacing VIRTIO_FEATURES_NU32S 
> without any functional difference:
> 
> 1. For writes: virtio_set_features_ex() already ignores extended 
> features when !virtio_features_use_ex(vdev->host_features_ex)
> 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), the 
> upper bits of host_features_ex are zero, and guest_features upper bits 
> remain zero (since they can't be set per point 1)
> 
> So the conditional logic is redundant here.

This is to satisfy a request from Jason:

https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05291.html
https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05423.html

I agree there will not be functional differences always accessing the
full space, but the guest could still be able to notice, i.e. the
extended space will be zeroed on read with that patched qemu and
untouched by the current code and this patch. To be on the safe side I
think it would be better to avoid such difference, as suggested by Jason.

Does the above make sense to you?

Thanks,

Paolo


