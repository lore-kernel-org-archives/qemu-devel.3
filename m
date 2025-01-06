Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E95AE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 09:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUizX-0003B0-E2; Mon, 06 Jan 2025 04:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUizS-0003As-DN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:01:39 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUizO-0003ay-Mg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:01:38 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2167141dfa1so197862805ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736154092; x=1736758892;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Zw+4BMIlDv7Lp2uk6bEJyFIH1fqfTmZJ0Z9/vIo3JM=;
 b=OSOtBgq8lfBj9w/6DwEDoYBo+vyNHgn+RlIjmKstPgT4gwAAUQ+SJwAK31ht5pPaNQ
 DgPmj+l5BMSfGjPKSzVud19/sPoQsOOTReH/bXkjBcxd+PFo7PDIFb65aST/ZYQQnDYS
 563MXahyUG8WCmo3kaEyPKKMVX9G45OoOznDlLHURQwLuozRQJEzZQk1zUdfuPW4tIc/
 PPMj6dKVmWzy2VzmGBXuh5kHd3L8kXkw3PHsmAuosMLIk01oevvsxufk1K9NsysYG9t/
 LziR9RhV7BRUPvW4JqGsorPIdPk4GbRfy9J9tjiu4zHkgLbeEbaqFn6FGG/q9ovL+ZP6
 cJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736154092; x=1736758892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Zw+4BMIlDv7Lp2uk6bEJyFIH1fqfTmZJ0Z9/vIo3JM=;
 b=nSznr2Inu5lx3PMPg4tuVe3hKbfcyWMA+TUSE2OHlB6tJc9JeIiBP/pojSfS13WH1S
 /bIA1BKbe87vBCpVA2xpVxc/gHNPP7oFrt/Dh8smC1TMnqlFCfzuWIjQMKxQv/1LEp7g
 o1CEC8BpxPdaYrAxME2m1/bnFUtSCjSO0I3LwlBApXQo6hqDejdj0GJpCx/7unWpe0e6
 qJUbS9JzH0VhDe0K+FUjAXujGCoVHctcpKj6cKwfBYKEWEcSvjku1mEnitSnp7/DFO8H
 sedo5ujYyr3g1K19Bx6a/u1ODeRCV1WMUFtsFnNs30mu3Ya8M0vY+3HwGJk3AW1w1vu/
 oRJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5kPY3Kc/Aenv7EmvrTVKnZhqFeUkYn1efL0KyoPmSN9itmeTqm9aGyXOq1wRdO/NxThOFcCHdSJ7I@nongnu.org
X-Gm-Message-State: AOJu0Yxgn4nu0uAZt78U5/lHBcliG7x+moQn06v2nZayxg2YUvry7tPV
 YcMlSHKIqbvLoHF1kY9zPLnYzsdgsvSOLsnIm7l8QMgA5MPjT2SW9pptkRBAH38=
X-Gm-Gg: ASbGncsMtpchUeoY2J6iKse+peP/sCQFPHhfV3hXRU9ZNirr949/BHFQ9T6/nTo5YGJ
 rvCengviZWFQ4g97vdd9jlkIooidkiCGgtWm1ZACYz5XQ1mBbUbq1fh8zWpEX9vcTZrE4Gk7ImR
 8eI2pAa0MIQPpyYV6AiFZi4H5ClUjencEZqT1Ju4ntysI+tsv6IJw3Z04Q6tiQxoYzPYPGaU2tr
 2INcEKtqSKqqeELSTSw2x5TKLl8S3LMiTcOpzf/GwmkG4Eaf2inmM6r6Mbs155i
X-Google-Smtp-Source: AGHT+IHi1yf8O/lA8IESHw3Hs7TLp0D7be5GHEnD9k0mzNLSZlKXEtJJMrDizVQ/2KU+JI6gkoRXxA==
X-Received: by 2002:a17:902:ecd2:b0:215:58be:334e with SMTP id
 d9443c01a7336-219e6ccdcecmr700375115ad.10.1736154092009; 
 Mon, 06 Jan 2025 01:01:32 -0800 (PST)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4c73sm279501335ad.121.2025.01.06.01.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 01:01:31 -0800 (PST)
Message-ID: <e6147828-5e3c-43ac-9ec7-073415e3b166@daynix.com>
Date: Mon, 6 Jan 2025 18:01:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] virtio-net: Convert feature properties to OnOffAuto
To: Lei Yang <leiyang@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, devel@daynix.com
References: <20250104-auto-v4-0-972461ee87fd@daynix.com>
 <20250104-auto-v4-1-972461ee87fd@daynix.com>
 <CAPpAL=y2FsZHNwfQhFXBk6dPKfHyex5uQ6tzCnJibBiwjsVLMQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPpAL=y2FsZHNwfQhFXBk6dPKfHyex5uQ6tzCnJibBiwjsVLMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2025/01/06 16:13, Lei Yang wrote:
> On Sat, Jan 4, 2025 at 3:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Some features are not always available, and virtio-net used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>>
>> Convert feature properties to OnOffAuto so that the user can explicitly
>> tell QEMU to automatically select the value by setting them "auto".
>> QEMU will give an error if they are set "on".
>>
>> Convert "on" to "auto" when using an old machine for compatbility.
>> VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS are exceptional and not
>> converted to "auto" if the peer is not vhost because they were
>> previously forcibly enabled even if they were not supported by the
>> peer and required the in-QEMU implementation, which incurred overhead.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/virtio/virtio-net.h |   3 +-
>>   hw/core/machine.c              |   1 +
>>   hw/net/virtio-net.c            | 261 ++++++++++++++++++++++++++---------------
>>   3 files changed, 169 insertions(+), 96 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index b9ea9e824e3c..d41f042d4e2f 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -178,7 +178,7 @@ struct VirtIONet {
>>       uint32_t has_vnet_hdr;
>>       size_t host_hdr_len;
>>       size_t guest_hdr_len;
>> -    uint64_t host_features;
>> +    OnOffAutoBit64 host_features;
>>       uint32_t rsc_timeout;
>>       uint8_t rsc4_enabled;
>>       uint8_t rsc6_enabled;
>> @@ -218,6 +218,7 @@ struct VirtIONet {
>>       /* primary failover device is hidden*/
>>       bool failover_primary_hidden;
>>       bool failover;
>> +    bool force_features_auto;
>>       DeviceListener primary_listener;
>>       QDict *primary_opts;
>>       bool primary_opts_from_json;
> 
> Hi Akihiko
> 
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index bff26b95dd74..1b4435fc1a64 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -38,6 +38,7 @@
>>
>>   GlobalProperty hw_compat_9_2[] = {
>>       { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
> 
> It looks like you forgot to remove this line you added in v3 when
> sending v4: "{ TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" } .
> Please feel free to correct me if I'm wrong.

With v4, I rebased the series to another one "[PATCH v3 0/3] virtio: 
Convert feature properties to OnOffAuto". That line is added by it. It 
converts properties common for all virtio devices to OnOffAuto. This 
patch converts properties specific to virtio-net on the other hand.

Regards,
Akihiko Odaki

> 
> Thanks
> 
> 
>> +    { TYPE_VIRTIO_NET, "x-force-virtio-net-features-auto", "on" },
>>   };
>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 06f096abf678..6b2104c6b68d 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -751,58 +751,110 @@ static void virtio_net_set_queue_pairs(VirtIONet *n)
>>
>>   static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
>>
>> +static bool virtio_net_clear_features(OnOffAutoBit64 *features,
>> +                                      uint64_t clear_bits,
>> +                                      const char *reason, Error **errp)
>> +{
>> +    if (features->on_bits & clear_bits) {
>> +        error_setg(errp, "%s", reason);
>> +        return false;
>> +    }
>> +
>> +    features->auto_bits &= ~clear_bits;
>> +
>> +    return true;
>> +}
>> +
>>   static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>>                                           Error **errp)
>>   {
>>       VirtIONet *n = VIRTIO_NET(vdev);
>>       NetClientState *nc = qemu_get_queue(n->nic);
>> -
>> -    /* Firstly sync all virtio-net possible supported features */
>> -    features |= n->host_features;
>> -
>> -    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
>> -
>> -    if (!peer_has_vnet_hdr(n)) {
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
>> -
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
>> -
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
>> -
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>> +    OnOffAutoBit64 on_off_auto_features = n->host_features;
>> +
>> +    if (n->force_features_auto) {
>> +        on_off_auto_features.auto_bits |= on_off_auto_features.on_bits;
>> +        on_off_auto_features.on_bits =
>> +            get_vhost_net(nc->peer) ?
>> +            0 :
>> +            on_off_auto_features.on_bits &
>> +            (BIT_ULL(VIRTIO_NET_F_HASH_REPORT) | BIT_ULL(VIRTIO_NET_F_RSS));
>> +    }
>> +
>> +    on_off_auto_features.auto_bits |= features;
>> +    virtio_add_feature(&on_off_auto_features.auto_bits, VIRTIO_NET_F_MAC);
>> +
>> +    if (!((peer_has_vnet_hdr(n) ||
>> +           virtio_net_clear_features(&on_off_auto_features,
>> +                                     BIT_ULL(VIRTIO_NET_F_CSUM) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_ECN) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HASH_REPORT),
>> +                                     "A requested feature requires the peer to support virtio-net headers.",
>> +                                     errp)) &&
>> +          (peer_has_ufo(n) ||
>> +           virtio_net_clear_features(&on_off_auto_features,
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO),
>> +                                     "UFO is on but the peer does not support it.",
>> +                                     errp)) &&
>> +          (peer_has_uso(n) ||
>> +           virtio_net_clear_features(&on_off_auto_features,
>> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6),
>> +                                     "USO is on but the peer does not support it.",
>> +                                     errp)) &&
>> +          (virtio_has_feature(on_off_auto_features.on_bits |
>> +                              on_off_auto_features.auto_bits,
>> +                              VIRTIO_NET_F_CTRL_VQ) ||
>> +           virtio_net_clear_features(&on_off_auto_features,
>> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE),
>> +                                     "guest_announce is on but ctrl_vq is off.",
>> +                                     errp)))) {
>> +        return 0;
>>       }
>>
>> -    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
>> -    }
>> +    if (!get_vhost_net(nc->peer)) {
>> +        if (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET_F_HASH_REPORT) ||
>> +            (virtio_has_feature(on_off_auto_features.on_bits, VIRTIO_NET_F_RSS) &&
>> +             !ebpf_rss_is_loaded(&n->ebpf_rss))) {
>> +            virtio_clear_feature(&on_off_auto_features.auto_bits,
>> +                                 VIRTIO_NET_F_RSS);
>> +        }
>>
>> -    if (!peer_has_uso(n)) {
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
>> -    }
>> +        virtio_clear_feature(&on_off_auto_features.auto_bits,
>> +                             VIRTIO_NET_F_HASH_REPORT);
>>
>> -    if (!get_vhost_net(nc->peer)) {
>> -        return features;
>> +        return on_off_auto_features.on_bits | on_off_auto_features.auto_bits;
>>       }
>>
>> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
>> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
>> +    if (!ebpf_rss_is_loaded(&n->ebpf_rss) &&
>> +        !virtio_net_clear_features(&on_off_auto_features,
>> +                                   BIT_ULL(VIRTIO_NET_F_RSS),
>> +                                   "Both RSS and vhost are on but eBPF is unavailable; fix eBPF or disable RSS.",
>> +                                   errp)) {
>> +        return 0;
>>       }
>> -    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
>> +    features = vhost_net_get_features(get_vhost_net(nc->peer),
>> +                                      on_off_auto_features.on_bits |
>> +                                      on_off_auto_features.auto_bits);
>>       vdev->backend_features = features;
>>
>>       if (n->mtu_bypass_backend &&
>> -            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
>> +        virtio_has_feature(on_off_auto_features.on_bits |
>> +                           on_off_auto_features.auto_bits,
>> +                           VIRTIO_NET_F_MTU)) {
>>           features |= (1ULL << VIRTIO_NET_F_MTU);
>>       }
>>
>> @@ -821,6 +873,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>>           virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
>>       }
>>
>> +    if ((features & on_off_auto_features.on_bits) !=
>> +        on_off_auto_features.on_bits) {
>> +        error_setg(errp, "A requested feature is incompatible with vhost.");
>> +        return 0;
>> +    }
>> +
>>       return features;
>>   }
>>
>> @@ -3639,7 +3697,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>       int i;
>>
>>       if (n->net_conf.mtu) {
>> -        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
>> +        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_MTU);
>>       }
>>
>>       if (n->net_conf.duplex_str) {
>> @@ -3651,7 +3709,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>               error_setg(errp, "'duplex' must be 'half' or 'full'");
>>               return;
>>           }
>> -        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>> +        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>>       } else {
>>           n->net_conf.duplex = DUPLEX_UNKNOWN;
>>       }
>> @@ -3661,7 +3719,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>       if (n->net_conf.speed >= 0) {
>> -        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>> +        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>>       }
>>
>>       if (n->failover) {
>> @@ -3670,10 +3728,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>           device_listener_register(&n->primary_listener);
>>           migration_add_notifier(&n->migration_state,
>>                                  virtio_net_migration_state_notifier);
>> -        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
>> +        n->host_features.on_bits |= (1ULL << VIRTIO_NET_F_STANDBY);
>>       }
>>
>> -    virtio_net_set_config_size(n, n->host_features);
>> +    virtio_net_set_config_size(n,
>> +                               n->host_features.on_bits |
>> +                               n->host_features.auto_bits);
>>       virtio_init(vdev, VIRTIO_ID_NET, n->config_size);
>>
>>       /*
>> @@ -3800,7 +3860,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>
>>       net_rx_pkt_init(&n->rx_pkt);
>>
>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>> +    if (virtio_has_feature(n->host_features.on_bits |
>> +                           n->host_features.auto_bits,
>> +                           VIRTIO_NET_F_RSS)) {
>>           Error *err = NULL;
>>           if (!virtio_net_load_ebpf(n, &err)) {
>>               /*
>> @@ -3827,7 +3889,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>       VirtIONet *n = VIRTIO_NET(dev);
>>       int i, max_queue_pairs;
>>
>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>> +    if (virtio_has_feature(n->host_features.on_bits |
>> +                           n->host_features.auto_bits,
>> +                           VIRTIO_NET_F_RSS)) {
>>           virtio_net_unload_ebpf(n);
>>       }
>>
>> @@ -3986,53 +4050,58 @@ static const VMStateDescription vmstate_virtio_net = {
>>   };
>>
>>   static const Property virtio_net_properties[] = {
>> -    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CSUM, true),
>> -    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_CSUM, true),
>> -    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
>> -    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_TSO4, true),
>> -    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_TSO6, true),
>> -    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_ECN, true),
>> -    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_UFO, true),
>> -    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_GUEST_ANNOUNCE, true),
>> -    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_HOST_TSO4, true),
>> -    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_HOST_TSO6, true),
>> -    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_HOST_ECN, true),
>> -    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_HOST_UFO, true),
>> -    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_MRG_RXBUF, true),
>> -    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_STATUS, true),
>> -    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_VQ, true),
>> -    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_RX, true),
>> -    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_VLAN, true),
>> -    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_RX_EXTRA, true),
>> -    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_MAC_ADDR, true),
>> -    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
>> -    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
>> -    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_RSS, false),
>> -    DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
>> -                    VIRTIO_NET_F_HASH_REPORT, false),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("csum", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CSUM, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_csum", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_CSUM, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("gso", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GSO, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso4", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_TSO4, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso6", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_TSO6, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ecn", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_ECN, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ufo", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_UFO, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_announce", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_ANNOUNCE,
>> +                                  ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso4", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HOST_TSO4, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso6", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HOST_TSO6, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ecn", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HOST_ECN, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ufo", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HOST_UFO, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mrg_rxbuf", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_MRG_RXBUF, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("status", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_STATUS, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vq", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CTRL_VQ, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CTRL_RX, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vlan", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CTRL_VLAN, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx_extra", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CTRL_RX_EXTRA, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_mac_addr", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_CTRL_MAC_ADDR, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_guest_offloads", VirtIONet,
>> +                                  host_features,
>> +                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
>> +                                  ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mq", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_MQ, ON_OFF_AUTO_OFF),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("rss", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_RSS, ON_OFF_AUTO_OFF),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HASH_REPORT, ON_OFF_AUTO_OFF),
>>       DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
>>                         ebpf_rss_fds, qdev_prop_string, char*),
>> -    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
>> +    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features.on_bits,
>>                       VIRTIO_NET_F_RSC_EXT, false),
>>       DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
>>                          VIRTIO_NET_RSC_DEFAULT_INTERVAL),
>> @@ -4051,12 +4120,14 @@ static const Property virtio_net_properties[] = {
>>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>       DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
>> -    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
>> -                      VIRTIO_NET_F_GUEST_USO4, true),
>> -    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
>> -                      VIRTIO_NET_F_GUEST_USO6, true),
>> -    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>> -                      VIRTIO_NET_F_HOST_USO, true),
>> +    DEFINE_PROP_BOOL("x-force-virtio-net-features-auto", VirtIONet,
>> +                     force_features_auto, false),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso4", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_USO4, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso6", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_GUEST_USO6, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_uso", VirtIONet, host_features,
>> +                                  VIRTIO_NET_F_HOST_USO, ON_OFF_AUTO_AUTO),
>>   };
>>
>>   static void virtio_net_class_init(ObjectClass *klass, void *data)
>>
>> --
>> 2.47.1
>>
>>
> 


