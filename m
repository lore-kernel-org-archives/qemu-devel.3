Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E54C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 10:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tva2J-0002nS-UF; Fri, 21 Mar 2025 06:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tva2E-0002mw-QO
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:55:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tva2C-0008SR-5l
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:55:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22401f4d35aso37050215ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742554526; x=1743159326;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4JdB9ck+e7ZqHuT3VmxkSKTc69aPJ+oRmM++DRxII0g=;
 b=BgNRNCOsKjgkADReloVlZJuWtfcle+9QEJ0ONc7IhSHPTrPZEtEL5tBtzvn8LRKJTT
 xHI2hN4619IsIJePh+usLChQFzJ2GoB5t5+1dQh9G0zd4Zr3AA1eABY8L5F5YfF8Hdqm
 fCj7kC/wt8zMq6B5UzPIR/6HSuJYZVQygk/L2EAdRKImdwXYz8ZzxbilGr5Izn1yZv/4
 IEGyZ6JvftM5oyb5h4iOBkwBNL3evnZzzRLMiMdC0RcFFqr13K3C7oNz7cUS6Jv2B3MN
 KJcFqEi8KYa9xEbPt9BYGVAOS6s2CMf0Jkrd09Z5KEFcpMD0DOIIFd1mVIUO1uosuwyd
 oTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742554526; x=1743159326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JdB9ck+e7ZqHuT3VmxkSKTc69aPJ+oRmM++DRxII0g=;
 b=ZB36PvW0wjNh/cU7t1BC1NEB+Y89Wj4ie4if8oYz5XA/ePSNajBCUuaO+6OKuol7o6
 GAecjRp5kJamxeAy92q6rb2CG9UWCsayFQxsVtPsdwJ5ItA67iJuaWxpniimpGPGXa1q
 oRf/eGU95uZd+t45L3t4hbp/uj17/RpOWbNHswpKFQJXltLvxh6jBbGENzhUT+7b6yLm
 HkTtf8f6iRh8Gsl0NV+HLL7t1Wd/VvolTdPx/uQBw74wKUFeVbwP1nwehJxugrz6KtsT
 nK+aSpt93tcErTQnjrJX1gSQTl83GL7Fth427jnyCId1YnAoWM9TAPoURulvTXJAOEH1
 pTTA==
X-Gm-Message-State: AOJu0Yx11pwjvBezhIRCu7jUgxpPVyvedppKLyli1+7Enf5OKEh3dep8
 E/UUd8ubGYyljRb+3utMNP7KKT3iwDutUmrAE0q7S8T2Xwe3DsOI8oavXYp/n7U=
X-Gm-Gg: ASbGncvU5rjb+sCkp892M1xqspbleDW9x1l+11fmMDRGgAnXhNjdye94IeLzM07BTrC
 A8XzqqZIfaV5CBkd/y8pZN6ppSyaoQLMmIfVs45wIZ2P7uwjREJRAPYxf5SVuu4QSzl0EwjoMMt
 JYp9sv4W/mKEff7xPYMsdt1SNXwtn4bnBgrqY1dR5Iv5ocETj0LoHEReQKM5uyiHn+L2bTH4tq0
 TK/Pqt5QV3AQScNFvT6qnikbzwDOGJmm1cpqkHonxYi/Ct+zE+zrH2fonhLt7P0zxl42kclSAiU
 FyhfGKXywUMaduFZlSgG9BCCyF8JNssK+mF4lJD1qxJMHbXiojtMJjZCzA==
X-Google-Smtp-Source: AGHT+IGgRnijpZ515D9Q3DT9AOWuATq2FpKJkSYzs8rD9YpWPZ71HchmL+jPRFZPhJgFkunhAAeGUQ==
X-Received: by 2002:a17:903:320e:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22780e3f352mr45664155ad.53.1742554526238; 
 Fri, 21 Mar 2025 03:55:26 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811daa38sm13326125ad.195.2025.03.21.03.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 03:55:25 -0700 (PDT)
Message-ID: <3cfbdb16-16f4-431a-9e19-76df3b2902c3@daynix.com>
Date: Fri, 21 Mar 2025 19:55:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Fix the interpretation of max_tx_vq
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
References: <20250321-vq-v1-1-6d6d285e5cbc@daynix.com>
 <CAOEp5Od-TTWt9yAQfxpSNGg=1edXaAX8b71vd7ZQfNnr7-2ArA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Od-TTWt9yAQfxpSNGg=1edXaAX8b71vd7ZQfNnr7-2ArA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 2025/03/21 19:44, Yuri Benditovich wrote:
> On Fri, Mar 21, 2025 at 11:56 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
>> determine the number of queue pairs and emits an error message saying
>> "Can't get queue_pairs". However, the field tells only about tx.
>>
>> Examine the indirection table to determine the number of queues required
>> for rx, and correct the name of field in the error message, clarifying
>> its correct semantics.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/net/virtio-net.c | 25 +++++++++++++++----------
>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index de87cfadffe1..d9ab9e1eb74d 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -1450,23 +1450,28 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
>>           err_value = (uint32_t)s;
>>           goto error;
>>       }
>> -    for (i = 0; i < n->rss_data.indirections_len; ++i) {
>> -        uint16_t val = n->rss_data.indirections_table[i];
>> -        n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
>> -    }
>>       offset += size_get;
>>       size_get = sizeof(temp);
>>       s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
>>       if (s != size_get) {
>> -        err_msg = "Can't get queue_pairs";
>> +        err_msg = "Can't get max_tx_vq";
>>           err_value = (uint32_t)s;
>>           goto error;
>>       }
>> -    queue_pairs = do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_queue_pairs;
>> -    if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
>> -        err_msg = "Invalid number of queue_pairs";
>> -        err_value = queue_pairs;
>> -        goto error;
>> +    if (do_rss) {
>> +        queue_pairs = virtio_lduw_p(vdev, &temp.us);
>> +        for (i = 0; i < n->rss_data.indirections_len; ++i) {
>> +            uint16_t val = n->rss_data.indirections_table[i];
>> +            n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
>> +            queue_pairs = MAX(queue_pairs, n->rss_data.indirections_table[i]);
>> +        }
> 
> I think this change will create a problem rather than improve something.
> curr_queue_pairs is used in virtio_net_can_receive.
> Let's say the device has 4 queues and 4 CPUs.
> If the OS currently configures the RSS for first 2 queues only the
> curr_queue_pairs becomes 2.
> The packets that come to queues 2 and 3 will be dropped, see
> virtio_net_receive_rcu and virtio_net_can_receive
> 
> IMO the curr_queue_pairs should not be changed after it was set by
> VIRTIO_NET_CTRL_MQ / VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET

VIRTIO_NET_CTRL_MQ_RSS_CONFIG is part of class VIRTIO_NET_CTRL_MQ and 
should be used for configurable receive steering while 
VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET should be used for automatic receive 
steering.

5.1.6.5.5 "Device operation in multiqueue mode" says:
 > The driver enables multiqueue by sending a command using class
 > VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
 > operation, as follows:
 >
 > #define VIRTIO_NET_CTRL_MQ    4
 > #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0 (for automatic
 > receive steering)
 > #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable
 > receive steering)
 > #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable
 > hash calculation)
 >
 > If more than one multiqueue mode is negotiated, the resulting device
 > configuration is defined by the last command sent by the driver.

VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET may not be even available if 
VIRTIO_NET_F_RSS is negotiated as VIRTIO_NET_F_RSS does not depend on 
VIRTIO_NET_F_MQ.

Jason, as you are participating in a relevant discussion on LKML, I'd 
also like to ask you if you have anything to add.

Regards,
Akihiko Odaki

> 
>> +        if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
>> +            err_msg = "Invalid number of queue_pairs";
>> +            err_value = queue_pairs;
>> +            goto error;
>> +        }
>> +    } else {
>> +        queue_pairs = n->curr_queue_pairs;
>>       }
>>       if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>>           err_msg = "Invalid key size";
>>
>> ---
>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>> change-id: 20250321-vq-87aff4f531bf
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>


