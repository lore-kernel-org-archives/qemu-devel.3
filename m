Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F16D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FEm-0007eY-Ob; Thu, 02 Apr 2026 06:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1w8FEi-0007bS-Dx
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1w8FEa-0002el-27
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775125503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSMxmBMyluz59TzMB1EcTnjmusFahck11b+m94hFhy8=;
 b=OzxrqqtYl7DM6quqiIApacRZ0Nd69/eGtJzhleSJqFfMttgErT9YNau+s0Qsi1GnlAkvME
 uuBFsAHMWFz4y+zmxZOrHtHdeCPfQ9CtbnE2aISrljHCKbHF46NvISOBAplBNmxsVAqmFX
 jTvTJEKUkK1iIT+fBTTo9u4ypcoiHS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-O3rbRll4N1mJ8JmYKT_1cw-1; Thu, 02 Apr 2026 06:25:02 -0400
X-MC-Unique: O3rbRll4N1mJ8JmYKT_1cw-1
X-Mimecast-MFC-AGG-ID: O3rbRll4N1mJ8JmYKT_1cw_1775125501
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48531e6012bso6930625e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775125501; x=1775730301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CSMxmBMyluz59TzMB1EcTnjmusFahck11b+m94hFhy8=;
 b=Vpn2JTTpdfcQF0BLWZugu17qid2OTPOpMIncYLRmJRCJzday/goRbOY+Xxiv40c9al
 KG6PyEerZtGF47qccytRMs2C0ZHRm07tRft5gDIyIXbQiQXtm+5corUj9oAV9ap/wYS/
 Oe2WI8E1BECWY7AHwz/BUjtR7D17mN9nNymbT/NTe5i/G2D4PUBcGkSV6X1bS5UIANIR
 FnpOvBqSRbPM/hEQ6l5IkE+eE0jJlU3qU5nsCDBsAcfcILdEq7M/j8R2k7bbUYGmn87i
 dLp50tv7A+wEBtMQhO7Pcz9yAHoF2ss2kpVLlIbj34GemEQe77IpB2Buz4cmNXGoCWqL
 HHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775125501; x=1775730301;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSMxmBMyluz59TzMB1EcTnjmusFahck11b+m94hFhy8=;
 b=bO039gJmCNPbdUJq1ywHNrJdrLf50OY2f7e91uSPKl+htnAEQ4YZGvjjhA+cp++FWR
 FL6Or8C78NUtTapctu7PQoID9V23aTABK1/6vFc7EPn3DvYhlCeRvIw29OkZxBqM9POH
 LSkHKPrxjNM1BdEIF7ja+5wWQj8HaFcq6kyiGuteoRdynVj9DAPS95lLNdrbFfTU9PoL
 x8ecxYfrsU8K0wpAvJ7u7/TKijxKKmlNG3lnWSU/iMGYFXlDeX1TKLzglhmUMXxA7iyi
 U4FwHUO85mWod0qsHIRRp5fLWer8OeVFXpBaDaatgUzQI6CmoAAkkO9MqoFpzhLwyn3N
 oKlQ==
X-Gm-Message-State: AOJu0YxbDmNBDEZxPrdQKkHGChPh3Z2dgq3YO7svg6IZRheIJduwRXUJ
 zkkZFXKFdLU4KbU8UAdJYOaBdRL+2yb57OnIAYqXJyyzcNMBB2BRl45PtNkaubtBGNOA+jtQAne
 97TUYknOUo2EyhOC5y3FLkVOz92nG5+9Mmf2rI4Ww2uehG+K+W8plz2VI
X-Gm-Gg: AeBDietfhk0tb8b8/JXIWhp7YBh/MG98CzPe5ZFbH0dWWedAmLfwtL4XOhYlX4RlkvZ
 XMyv7zl7QxgHJjbQQKnDq3HUurECuVeKxWhU19yl5yzn/BA4RDo2AcaM1dg9CWF0qIU2KWwRALs
 K9FKZwfdIvZpuT5Jm8h9LQkdthUJn6kKjyTBXgAA6MTCjt8XLRRf3sMh1G4yN7HlybB/zfcG/qr
 Ay0CPkT2sLXbzVUjxSU6ZIn/zdHtqrfW3eLRipHqyTgceZf+jg8l29B6msSnj9+OEOTqKhxwoSH
 ezF6QdwoT/Z8hepVH2gu0YBikZP6vpXjiCg6s6sIL0ophBHmVAaUQ3KCug/OkCrVjqW845AWiQS
 0WEBl0HSTU1sH2rjBIZzjTowYFAb1tosXb29mSGn9RLXkv//QTW6R2EI=
X-Received: by 2002:a5d:5d05:0:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-43d15051bfdmr12575236f8f.11.1775125500592; 
 Thu, 02 Apr 2026 03:25:00 -0700 (PDT)
X-Received: by 2002:a5d:5d05:0:b0:43d:50c:6f18 with SMTP id
 ffacd0b85a97d-43d15051bfdmr12575194f8f.11.1775125500085; 
 Thu, 02 Apr 2026 03:25:00 -0700 (PDT)
Received: from [192.168.100.100] (82-64-211-94.subs.proxad.net. [82.64.211.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5294sm5870355f8f.35.2026.04.02.03.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 03:24:59 -0700 (PDT)
Message-ID: <844999be-3057-4753-8978-77074c3fe56c@redhat.com>
Date: Thu, 2 Apr 2026 12:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: allow vhost-user backends to provide config
 space
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260320163844.754762-1-lvivier@redhat.com>
 <CAJaqyWeqgO9fR+Xi5rtBw0VL=gaMBFa9N7wV20bYhEgq3SbMMw@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CAJaqyWeqgO9fR+Xi5rtBw0VL=gaMBFa9N7wV20bYhEgq3SbMMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/31/26 13:33, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 5:40 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> Remove the vDPA-only guard on vhost_net_get_config/set_config calls so
>> any vhost backend that negotiates VHOST_USER_PROTOCOL_F_CONFIG can
>> provide device configuration.
>>
>> To manage backends that don't support vhost_net_get_config/set_config,
>> modify the stubs and vhost_net_get_config/vhost_net_set_config
>> with NULL vhost_net parameter to return -ENOSYS.
>>
>> Until now VHOST_USER_PROTOCOL_F_CONFIG was requisited with the
>> supports_config flag in VhostUserState or ignored, but now stop
>> stripping VHOST_USER_PROTOCOL_F_CONFIG when the device code doesn't
>> explicitly require it, so vhost-user backends that advertise F_CONFIG
>> can negotiate it.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hw/net/vhost_net-stub.c |  4 ++--
>>   hw/net/vhost_net.c      |  8 ++++++++
>>   hw/net/virtio-net.c     | 36 ++++++++++--------------------------
>>   hw/virtio/vhost-user.c  | 31 +++++++++++--------------------
>>   4 files changed, 31 insertions(+), 48 deletions(-)
>>
>> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>> index 0740d5a2ebe6..6edc0a222f3b 100644
>> --- a/hw/net/vhost_net-stub.c
>> +++ b/hw/net/vhost_net-stub.c
>> @@ -53,12 +53,12 @@ void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
>>   int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>>                            uint32_t config_len)
>>   {
>> -    return 0;
>> +    return -ENOSYS;
>>   }
>>   int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>>                            uint32_t offset, uint32_t size, uint32_t flags)
>>   {
>> -    return 0;
>> +    return -ENOSYS;
>>   }
>>
>>   void vhost_net_ack_features_ex(struct vhost_net *net, const uint64_t *features)
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index a8ee18a91266..13f926b5cfb6 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -42,11 +42,19 @@ void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
>>   int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>>                            uint32_t config_len)
>>   {
>> +    if (net == NULL) {
>> +        return -EINVAL;
>> +    }
>> +
>>       return vhost_dev_get_config(&net->dev, config, config_len, NULL);
>>   }
>>   int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>>                            uint32_t offset, uint32_t size, uint32_t flags)
>>   {
>> +    if (net == NULL) {
>> +        return -EINVAL;
>> +    }
>> +
>>       return vhost_dev_set_config(&net->dev, data, offset, size, flags);
>>   }
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 2a5d642a6476..7ad2dac450d9 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -180,17 +180,9 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>>                    n->rss_data.supported_hash_types);
>>       memcpy(config, &netcfg, n->config_size);
>>
>> -    /*
>> -     * Is this VDPA? No peer means not VDPA: there's no way to
>> -     * disconnect/reconnect a VDPA peer.
>> -     */
>> -    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>> -        ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
>> -                                   n->config_size);
>> -        if (ret == -1) {
>> -            return;
>> -        }
>> -
>> +    ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
>> +                               n->config_size);
>> +    if (ret >= 0) {
>>           /*
>>            * Some NIC/kernel combinations present 0 as the mac address.  As that
>>            * is not a legal address, try to proceed with the address from the
>> @@ -223,15 +215,9 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>>           qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>>       }
>>
>> -    /*
>> -     * Is this VDPA? No peer means not VDPA: there's no way to
>> -     * disconnect/reconnect a VDPA peer.
>> -     */
>> -    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>> -        vhost_net_set_config(get_vhost_net(nc->peer),
>> -                             (uint8_t *)&netcfg, 0, n->config_size,
>> -                             VHOST_SET_CONFIG_TYPE_FRONTEND);
>> -      }
>> +    vhost_net_set_config(get_vhost_net(nc->peer),
>> +                         (uint8_t *)&netcfg, 0, n->config_size,
>> +                         VHOST_SET_CONFIG_TYPE_FRONTEND);
>>   }
>>
>>   static bool virtio_net_started(VirtIONet *n, uint8_t status)
>> @@ -3868,6 +3854,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VirtIONet *n = VIRTIO_NET(dev);
>> +    struct virtio_net_config netcfg = {};
>>       NetClientState *nc;
>>       int i;
>>
>> @@ -4023,12 +4010,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>       nc = qemu_get_queue(n->nic);
>>       nc->rxfilter_notify_enabled = 1;
>>
>> -   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>> -        struct virtio_net_config netcfg = {};
>> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>> -        vhost_net_set_config(get_vhost_net(nc->peer),
>> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
>> -    }
>> +    memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>> +    vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg, 0,
>> +                         ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
> 
> Hi!
> 
> This is a vdpa specific workaround, kind of. As an open question,
> perhaps omitting this `set_config` is better so vhost-user has
> consistent parameters? On one hand I think it's weird to honor only
> the MAC address from the command line and ignore all other parameters
> like mq= or vlan=. From the other point of view, making vhost-vdpa and
> vhost-user consistent offers benefits.
> 
> Or maybe to set the mac address is the motivation for this?
> 

This is a good point.

According to the virtio spec (5.1.4) [1] all the fields in virtio_net_config are read-only 
and they are provided by the device, but the mac address field always exists (though is 
only valid if VIRTIO_NET_F_MAC is set, but in the realize the feature are not already 
negociated, so we don't know).

Moreover, according to the vhost-user spec [2] VHOST_USER_SET_CONFIG, the vhost-user 
back-end must check the flags field, and back-ends must not accept SET_CONFIG for 
read-only configuration space fields unless the live migration bit is set.

So I agree, according to the spec we shouldn't set any read-only configuration field 
(including MAC address) in the realize.

I update the patch.

Thanks,
Laurent

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-2000004
[2] https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#front-end-message-types


