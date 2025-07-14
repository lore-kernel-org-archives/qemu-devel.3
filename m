Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9150FC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFcZ-00061t-LL; Mon, 14 Jul 2025 05:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubFMD-0004Dm-0h
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubFM8-0001XL-KJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752484813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iNjzFUj63mp05oAoU6RSseEf5iuXVQKRB275o/EjXxc=;
 b=hZgFcxC2HzBTuKXZLRVCDsIlvtDYsD3CnxIlAb4JVK1Zu2sG9i1IPBc8BVFqF9GBW2o6Eh
 0WDm0QEMxyo3jfZlUhhzLhhrRBPM3ehpGjqZPU6DNhMtcwWvrKXddVYgihG2e5s3LT3uGW
 qMACBpr+RdBX2kY468aQ3pJsU7cUoms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ZOA6rxxfPa-KOiMC0GYiDA-1; Mon, 14 Jul 2025 05:18:59 -0400
X-MC-Unique: ZOA6rxxfPa-KOiMC0GYiDA-1
X-Mimecast-MFC-AGG-ID: ZOA6rxxfPa-KOiMC0GYiDA_1752484738
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4560b81ff9eso11398555e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752484738; x=1753089538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNjzFUj63mp05oAoU6RSseEf5iuXVQKRB275o/EjXxc=;
 b=US5ZpvMyXXTgO3JyuT4AIJnC5UjyyS5uPMndbS2gYvFbTPLRiOukCkqZyV5wi6NP8t
 OcxcV8fs/3Kqv8wrWFndPNguBIX1cqvTxsik2qGYFBkFU+0V92VD5M/7SlbDVN0nZ7qO
 mroiXRgbZre5JwkNP3q3+TnpKYkg4PfWDwghD8qYX+9QMaMerTx9ixpUj7o5tKOJlBN+
 dafBDa6foFy6r33B5g12QM3ZmXSTfq6Z1MX3wJokaZ3Y31G1sYznWlInJIpE+Roo74fB
 uhoM19fMWoN/wFtEOPS4gEmEL5Bqp4ON8a66eTkn2iljrRYMgsj4XoJeeru/Ie0ygf+N
 bdXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuxLX1EbmYj1tDVTzsqUZjz6a7tdM5x8dbYZqRuYVUqW/MinROVceGs0XQ6D74ncC3a5WWpow3/4rm@nongnu.org
X-Gm-Message-State: AOJu0Yzq2wQ89QbWjQj82Y2xDCx7DdLeAVsvFbnTxMM+d9IhSHE4mOMb
 ABlCjJfzKAE5MHudWfDXmaxg5IJTQF36Ifd2TZfkVOSDtHzTV1m8gurW8AqcQqepPSrKcRQQMsj
 IzTAV6uCjro7kLAyyfmwnwOBI3blu2AynEjCUIxhwsifprtRMhplkOMUI
X-Gm-Gg: ASbGncvaRr2jy0KyjQxp1JlDIQF+TZKldofRumalynYR1nAw/yMPblPIgvdLwJJzso9
 kMnvV2D1YaARLgRKICdQ2QGGTCFiXsHfD15LqKx1oilafOr/aIQK07yywoj5GD+oF8qOC7nA2Uu
 yOI6uoC+OfON9oN56YzNz+CV880PXPaeBa2fxgebUsv3hW0s2FNokGiI6ZBFcgJ+kevpdip81kg
 y8kKL2yK5k6z85CZ03hmkOEpW7THwJ239DguSJfelFe7OZySLmOl7JWueiQJnPpAVDnurJninMW
 Np26wW8tuhH16YXjE/yu/jopLlbFj3KsqaeQqo2yVigk+A==
X-Received: by 2002:a05:6000:2a85:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b5f188e9d1mr7986851f8f.24.1752484738426; 
 Mon, 14 Jul 2025 02:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqEFH4PxVrdKlfFHtI0AEgbhzZ294pGOBccZXruKeyWX/B9W88cJOyaQT5a2wAcrhpLEclVQ==
X-Received: by 2002:a05:6000:2a85:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b5f188e9d1mr7986830f8f.24.1752484737787; 
 Mon, 14 Jul 2025 02:18:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e285e0sm11627980f8f.101.2025.07.14.02.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 02:18:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:18:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
Message-ID: <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
 <20250710123945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250710123945-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jul 10, 2025 at 12:40:43PM -0400, Michael S. Tsirkin wrote:
>On Thu, Jul 10, 2025 at 04:46:34PM +0100, Peter Maydell wrote:
>> Hi; Coverity complains about a potential filedescriptor leak in
>> net/vhost-vdpa.c:net_init_vhost_vdpa(). This is CID 1490785.
>>
>> Specifically, in this function we do:
>>     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
>>                                                  &has_cvq, errp);
>>     if (queue_pairs < 0) {
>>         [exit with failure]
>>     }
>>     ...
>>     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
>>     for (i = 0; i < queue_pairs; i++) {
>>        ...
>>        ncs[i] = net_vhost_vdpa_init(..., vdpa_device_fd, ...)
>>        ...
>>     }
>>     if (has_cvq) {
>>        ...
>>        nc = net_host_vdpa_init(..., vdpa_device_fd, ...)
>>        ...
>>     }
>>
>> So if queue_pairs is zero we will malloc(0) which seems dubious;
>> and if queue_pairs is zero and has_cvq is false then the init
>> function will exit success without ever calling net_vhost_vdpa_init()
>> and it will leak the vdpa_device_fd.
>>
>> My guess is that queue_pairs == 0 should be an error, or possibly
>> that (queue_pairs == 0 && !has_cvq) should be an error.
>>
>> Could somebody who knows more about this code tell me which, and
>> perhaps produce a patch to make it handle that case?
>
>Historically queue_pairs == 0 was always same as 1, IIRC.

Yep, also looking at vhost_vdpa_get_max_queue_pairs() it returns 1 if 
VIRTIO_NET_F_MQ is not negotiated, or what the device expose in the 
config space in the `max_virtqueue_pairs` field.

In the spec we have:
     The device MUST set max_virtqueue_pairs to between 1 and 0x8000 
     inclusive, if it offers VIRTIO_NET_F_MQ.

So, IMHO we can just change the error check in this way:
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..8f39e5a983 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1813,7 +1813,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
  
      queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
                                                   &has_cvq, errp);
-    if (queue_pairs < 0) {
+    if (queue_pairs <= 0) {
          qemu_close(vdpa_device_fd);
          return queue_pairs;
      }

I'll send a patch if no one complain.

>
>> Q: should this file be listed in the "vhost" subcategory of 
>> MAINTAINERS?
>> At the moment it only gets caught by "Network device backends".

Maybe yes, but it's really virtio-net specific.
@Michael WDYT?

Thanks,
Stefano


