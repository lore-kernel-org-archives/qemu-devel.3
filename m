Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CAEC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucmAX-0003Ut-7n; Fri, 18 Jul 2025 10:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucm9m-0003IQ-HI
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucm9j-0006V3-Dv
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752849225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxwdNNudFq9hF2LEo8/LSwBiGxBoroi+CIjxHbRX0IY=;
 b=d3MJg2uLsyjSg016lRS57ulOyuvRnhntQHiH9BCVxrDv+fEwAUPCgyo+lVffjPLMWhfgGr
 G9lhEFQ58vjQO+AZkM6mjQbBij1eOApy1DHDFXkDQneMOaE5AlVg7XneOxBFwB67iGTJJ7
 5/n0EBBCpx1oYXy3StfGi6esk/HlqEQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-mz9jHU1vO0S0HUpY4wcG_w-1; Fri, 18 Jul 2025 10:33:44 -0400
X-MC-Unique: mz9jHU1vO0S0HUpY4wcG_w-1
X-Mimecast-MFC-AGG-ID: mz9jHU1vO0S0HUpY4wcG_w_1752849223
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b61e53eea3so386457f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 07:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752849223; x=1753454023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxwdNNudFq9hF2LEo8/LSwBiGxBoroi+CIjxHbRX0IY=;
 b=vta5WugoyHYXuX/a5cnQXFepBCrJqqjKuPsPaD6CZAMjK5KXHXkgHUKoZCVDeioKUK
 /3AdNwae3tTWzX+rXG594ox64gt/e01p8GWAjnJo0UphB582/ducQ3RuKVyK3XUdcU+G
 9aCK8aq62tVWG3hNdrN/KxvZrvwhopqfWhji+nWXFV72r8EAdznPDq/NCfca5ZLwL2Jw
 oCtsZ9OFsuZbk1VroRfAqOrFcg2gelaRJlvi4UNM5abBjh6Lmx6vDBpSNgGOrdQthaus
 lDY3dqUGDdwcbnNiOq/t9y2XuDosvYVOOcYLE/dCUHiylEiaUtq3BVAiVnz6YpEXVlhV
 LCfA==
X-Gm-Message-State: AOJu0YxBZBMZDrT+40UrxB3CsgC0dxu+pBI/b137uNk5o2XAhAej1XDK
 RjUXZHLLlDlW6WZFBUKJequ/Po1fL/okarDGarqCKtEFoZ7MmzcrikH37tiqtzR4/7T5GvhGG5S
 BX1ldTCGJltYa3IFjlXoBihoov45q7xmJ/Uu1qp4chQvXTm7FUnnkTljA
X-Gm-Gg: ASbGnctyXMGTagv9f1UiyC3/JVNkjYNjz46lo6bHOWsOAm6QF1V4BbX0ib3PtVbVjKV
 81v07XZv4zzKYRdU6kZfVX67nWmK5gEA2HRXfIGvORJS0foxzWdD84bsTqUa3leZe63+OX+pH/k
 O6aVoU8cZwwoiOIneLtRhhBKe1GyZdc1QoPfBIturUFKqP6CLfi2b0PfSrs9yVHcqN33aipYZwv
 3PGz8jAo2ZuHE7DpHksuJBY4q9qf8c2ALfmHQcDceT/ir5AajpKT3N0SyDDk280TqViaWQn0pEy
 L2hv1jrroYQrgT9OCGmQ8eB9SUWbw7NOXPyMDyB+jgZdQ09/qaVL8cMG4MDn1FeVHIb5I3L+KPU
 3Zu1LhK5qSvo=
X-Received: by 2002:a5d:584e:0:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3b60e4c8e2emr7695946f8f.13.1752849222829; 
 Fri, 18 Jul 2025 07:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLlj8yh5JHgdAqeErBlPhMgGNNyaoxTxzIaWd1PbZqQ6TBUYiMyHw9oV2P5hkDmwhpzgpbiw==
X-Received: by 2002:a5d:584e:0:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3b60e4c8e2emr7695913f8f.13.1752849222274; 
 Fri, 18 Jul 2025 07:33:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca486edsm2046124f8f.56.2025.07.18.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 07:33:41 -0700 (PDT)
Message-ID: <12b37ffa-19d4-4f8c-8ff5-30d323260cdd@redhat.com>
Date: Fri, 18 Jul 2025 16:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 10/13] vhost-net: implement extended features
 support
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <083cd54b7ee4909fdedbf5c9128e60563469057e.1752828082.git.pabeni@redhat.com>
 <zdfxqwsj7bmx6dfoxticifa2max3rkqhhoor5mjxfy7xcj7tys@6hwveszzsbua>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <zdfxqwsj7bmx6dfoxticifa2max3rkqhhoor5mjxfy7xcj7tys@6hwveszzsbua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/18/25 3:01 PM, Stefano Garzarella wrote:
> On Fri, Jul 18, 2025 at 10:52:36AM +0200, Paolo Abeni wrote:
>> @@ -234,7 +234,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>     int r;
>>     bool backend_kernel = options->backend_type == VHOST_BACKEND_TYPE_KERNEL;
>>     struct vhost_net *net = g_new0(struct vhost_net, 1);
>> -    uint64_t features = 0;
>> +    uint64_t missing_features[VIRTIO_FEATURES_DWORDS];
>> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
> 
> Should we initialize `features` (IIUC calling virtio_features_clear)
> since it was set to 0 before this patch?
> 
>>     Error *local_err = NULL;
>>
>>     if (!options->net_backend) {
>> @@ -261,7 +262,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>         net->backend = r;
>>         net->dev.protocol_features = 0;
>>     } else {
>> -        net->dev.backend_features = 0;
>> +        virtio_features_clear(net->dev.backend_features_ex);
>>         net->dev.protocol_features = 0;
>>         net->backend = -1;
>>
>> @@ -279,28 +280,31 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>     if (backend_kernel) {
>>         if (!qemu_has_vnet_hdr_len(options->net_backend,
>>                                sizeof(struct virtio_net_hdr_mrg_rxbuf))) {
>> -            net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
>> +            net->dev.features &= ~VIRTIO_BIT(VIRTIO_NET_F_MRG_RXBUF);
>>         }
>> -        if (~net->dev.features & net->dev.backend_features) {
>> -            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
>> -                   " for backend\n",
>> -                   (uint64_t)(~net->dev.features & net->dev.backend_features));
>> +
>> +        if (virtio_features_andnot(missing_features,
>> +                                   net->dev.backend_features_ex,
>> +                                   net->dev.features_ex)) {
>> +            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
>> +                   " for backend\n", VIRTIO_FEATURES_PR(missing_features));
>>             goto fail;
>>         }
>>     }
>>
>>     /* Set sane init value. Override when guest acks. */
>>     if (options->get_acked_features) {
>> -        features = options->get_acked_features(net->nc);
>> -        if (~net->dev.features & features) {
>> -            fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
>> -                    " for backend\n",
>> -                    (uint64_t)(~net->dev.features & features));
>> +        virtio_features_from_u64(features,
>> +                                 options->get_acked_features(net->nc));
>> +        if (virtio_features_andnot(missing_features, features,
>> +                                   net->dev.features_ex)) {
>> +            fprintf(stderr, "vhost lacks feature mask 0x" VIRTIO_FEATURES_FMT
>> +                    " for backend\n", VIRTIO_FEATURES_PR(missing_features));
>>             goto fail;
>>         }
>>     }
>>
>> -    vhost_net_ack_features(net, features);
>> +    vhost_net_ack_features_ex(net, features);
> 
> If `options->get_acked_features` is false, `features` here is not
> initialized (it was set to 0 before this patch).

Indeed the initialization is needed. I will fix the next revision.

Thanks,

Paolo


