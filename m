Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4E9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwciX-00042u-J9; Tue, 16 Apr 2024 02:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwciV-00042j-J5
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:54:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rwciT-0008Ud-BL
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:54:55 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so2370133a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713250491; x=1713855291;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/6i0q+KF6i84lPj9V5TkSfBiTsGMyqFUJ7yR3p9N+8=;
 b=sjkgR+RcCMhBw4uqzigJEG9tVsjV0jiOJO711KiA2MQFsVGqPIrO0sFBjhm2/kNmom
 M8UrbQhfAjsRx/gDSgrDJ9EhCKALPn0jupsGtzFcQGchBg7QLMxFVbeebV6UBSLjAGpr
 f5GqUhX1zt4iXW10yv+ZBefNgWAekxKAKXnJ6OShhFiQGt9uQZNbxw8k/8zp0v+XB/FQ
 FlkVDJqn4WDkM4vVM8fLneat7gmY7sRQmmO/GLB0mTqm1fLtjhDJkDVX7n6G9FRPL4Pm
 hMr0i1rnIn+D96gpJDZtQzELF8CV4hCONLz8mXbsunrM4EvP4SaSG5/qyRYZuK1pssyd
 DcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713250491; x=1713855291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/6i0q+KF6i84lPj9V5TkSfBiTsGMyqFUJ7yR3p9N+8=;
 b=ml9Z+/0nMD/qS4Vgs1SmaUTolEu7uTCc6HUFfITVufwAeatfIk7a4I90SgIfOMmHQz
 EiR/xoUdTi7eJV48vBhQKM5Wdj8OVO8VDQqwEHCcUCsNKaA0wFacgDzXasGoUfhy3r3q
 XDSFAPkfz+OzKEeZGJfTuXUzjJtk1ag3lpNE+AYPIU83q76vWVYw68wAq5Oh8coPPW4q
 M69wbXSWKARxz/UXfGdmw/HqZM7UmkyCaZ8kmDJHQ+AhQbu0DjjIjIAHEh50cqRLVVD4
 HRGic/jAI/Fvx6IaVVPCKkce7qva/Ho8mXhw7cebF1cfKCs6hQlLW/FC0mIAyp7wHqan
 2J2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpt1j4Ld70YrhyE8nDh37Hhr/ThzJFtKKgC8iotGZMWGDq66k+XymwtNUIJ+BGhtiYoXh+tZooFM3j4rHOcmQ4q6YfMgQ=
X-Gm-Message-State: AOJu0Yz3w8itT1X3SgVLMOSwbm3jBnY1Fnf+8YGr0H0vsYg5pVZXYX62
 rxr0IJohrHC32vPYqkUiB3cop0RdsobtTMRcVYZwxXnxhzOb0+vIvxTB5xJldBo=
X-Google-Smtp-Source: AGHT+IFIOEaygbwPz1Z9bx41sjRAuQ9f4bU9KKG6HY0RZM52nFA8dq/dPgsAwD5Uk5Ejxva3nSWnUw==
X-Received: by 2002:a05:6a20:9717:b0:1a9:8861:9e77 with SMTP id
 hr23-20020a056a20971700b001a988619e77mr9464736pzc.28.1713250491417; 
 Mon, 15 Apr 2024 23:54:51 -0700 (PDT)
Received: from [157.82.206.17] ([157.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001e42bb057b9sm9014847plw.105.2024.04.15.23.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 23:54:50 -0700 (PDT)
Message-ID: <dabf20e9-1002-469e-b255-d3954bf8cf3d@daynix.com>
Date: Tue, 16 Apr 2024 15:54:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
 <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/16 13:00, Jason Wang wrote:
> On Mon, Apr 15, 2024 at 10:05 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
>>
>> On Wed, Apr 3, 2024 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
>>> implicitly disables RSS even if the user explicitly requests it. Return
>>> an error instead of implicitly disabling RSS if RSS is requested but not
>>> available.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------------------
>>>   1 file changed, 48 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 61b49e335dea..3d53eba88cfc 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>>>           return features;
>>>       }
>>>
>>> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
>>> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
>>> -    }
>>>       features = vhost_net_get_features(get_vhost_net(nc->peer), features);
>>>       vdev->backend_features = features;
>>>
>>> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>>>       return qatomic_read(&n->failover_primary_hidden);
>>>   }
>>>
>>> +static void virtio_net_device_unrealize(DeviceState *dev)
>>> +{
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>> +    VirtIONet *n = VIRTIO_NET(dev);
>>> +    int i, max_queue_pairs;
>>> +
>>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>>> +        virtio_net_unload_ebpf(n);
>>> +    }
>>> +
>>> +    /* This will stop vhost backend if appropriate. */
>>> +    virtio_net_set_status(vdev, 0);
>>> +
>>> +    g_free(n->netclient_name);
>>> +    n->netclient_name = NULL;
>>> +    g_free(n->netclient_type);
>>> +    n->netclient_type = NULL;
>>> +
>>> +    g_free(n->mac_table.macs);
>>> +    g_free(n->vlans);
>>> +
>>> +    if (n->failover) {
>>> +        qobject_unref(n->primary_opts);
>>> +        device_listener_unregister(&n->primary_listener);
>>> +        migration_remove_notifier(&n->migration_state);
>>> +    } else {
>>> +        assert(n->primary_opts == NULL);
>>> +    }
>>> +
>>> +    max_queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
>>> +    for (i = 0; i < max_queue_pairs; i++) {
>>> +        virtio_net_del_queue(n, i);
>>> +    }
>>> +    /* delete also control vq */
>>> +    virtio_del_queue(vdev, max_queue_pairs * 2);
>>> +    qemu_announce_timer_del(&n->announce_timer, false);
>>> +    g_free(n->vqs);
>>> +    qemu_del_nic(n->nic);
>>> +    virtio_net_rsc_cleanup(n);
>>> +    g_free(n->rss_data.indirections_table);
>>> +    net_rx_pkt_uninit(n->rx_pkt);
>>> +    virtio_cleanup(vdev);
>>> +}
>>> +
>>>   static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>   {
>>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>>
>>>       net_rx_pkt_init(&n->rx_pkt);
>>>
>>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>>> -        virtio_net_load_ebpf(n);
>>> -    }
>>> -}
>>> -
>>> -static void virtio_net_device_unrealize(DeviceState *dev)
>>> -{
>>> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>> -    VirtIONet *n = VIRTIO_NET(dev);
>>> -    int i, max_queue_pairs;
>>> -
>>> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
>>> -        virtio_net_unload_ebpf(n);
>>> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
>>> +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
>>> +        virtio_net_device_unrealize(dev);
>>> +        error_setg(errp, "Can't load eBPF RSS for vhost");
>>>       }
>>
>> As I already mentioned, I think this is an extremely bad idea to
>> fail to run qemu due to such a reason as .absence of one feature.
>> What I suggest is:
>> 1. Redefine rss as tri-state (off|auto|on)
>> 2. Fail to run only if rss is on and not available via ebpf
>> 3. On auto - silently drop it
> 
> "Auto" might be promatic for migration compatibility which is hard to
> be used by management layers like libvirt. The reason is that there's
> no way for libvirt to know if it is supported by device or not.

Certainly auto is not good for migration, but it is useful in the other 
situations. You can still set "on" or "off" if you care migration. I'll 
add "auto" support in the next version.

> 
> Thanks
> 
>> 4. The same with 'hash' option - it is not compatible with vhost (at
>> least at the moment)
>> 5. Reformat the patch as it is hard to review it due to replacing
>> entire procedures, i.e. one patch with replacing without changes,
>> another one - with real changes. >> If this is hard to review only for me - please ignore that.

I'll split this patch accordingly in the next version.

Regards,
Akihiko Odak

