Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12142C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 07:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue7VC-0007u1-S1; Tue, 22 Jul 2025 03:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ue7V2-0007qV-El
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 03:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ue7Uw-0005pS-F9
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 03:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753169590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQguFRDnQHyJdSq2GrO07NlcFzBXMo9T0F5s54XHLMA=;
 b=gn88GGvOPuftXWPZI+bSBQ4ZNrVjsSA5O7st5f7o6TDYsLpeOQ/CWPS50iBcZBGGoXqq+k
 UP26DDorurMR6mZuWfsgCS7i55lgAViJg90DLhWUUszYnNOHPIV7ISil8Hij/6ALC5YD1e
 2+TdIl5e+uKcfpRqF+3MiI01RMhvJCc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-uSO1rby4PleinFiGSjCiug-1; Tue, 22 Jul 2025 03:33:08 -0400
X-MC-Unique: uSO1rby4PleinFiGSjCiug-1
X-Mimecast-MFC-AGG-ID: uSO1rby4PleinFiGSjCiug_1753169587
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso3484282f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 00:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753169587; x=1753774387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQguFRDnQHyJdSq2GrO07NlcFzBXMo9T0F5s54XHLMA=;
 b=fTeZ2jBGjqgjiQ+ioRhu74TczGJK5jpv35J4e0lVF/mi1FFn2VeiKcgAW92qx6Ez35
 tfVjncPpftXsdqNdBIB54pEWEPCNzz8nJx9CscuKrhegRyt8N64y+wBKClRvIgqYpJsZ
 asW9sgrI6CR8wLNDJOAj1fFdX1rh7GtB7VV/BCZQiFQZtGHlxuqw1p1V8uKDxaclspSU
 Ph3bXekKC/Ft2gCWYgUdxoC8riF0BrLYDMl17M1R6u5XQ44itmlOFLgsfEjbBKf+TCWf
 TM/ukVUpLuWQapbBETZpTbkHX1g3/g7fRfEYUY3AECpjMJbKF6PCOHqCbKd2vYSVs1zJ
 qGPg==
X-Gm-Message-State: AOJu0Yz5zRbqfuWr85GM7yS6ta9oQ7Zc8YtYDq5BKRN4vossAH+gaLcj
 80oBCbLJcQII3WP/RWRDVXaCbBkY0GTab7yvk+LJoWxJ7NUhkNA9PpR0dybfq+uM6GXBMqHcgvf
 vzJrlKPIZDRPlib6E8QAdY+Jjh3aWG5PnVBUTT8DlYy7SGnMwdfr/9fNr
X-Gm-Gg: ASbGnctM1WoodkhJOuMGyswLOdHyHdXdecWpVXnB46swN5vV8wsf+WNcQtMzyYE6HH2
 aNRjAr4ft1PcAlh/CX3q5RuNFQARKgB6+BzeSwG59hlbSixL37uYROsxUH6QVR5TI6HCyXtLZT1
 Fh8Y4cIH15xEdkB+D8DlB0q4WCl52dVA8fQp7WkxnUjPZr7iY8yMLNBqVKBRzKqZaiZBZXmFaxt
 LVS9aIxpoU5z0HqhFoW0/EiCvdawYmn34TDE2VQNSyVGgDMez0Kd15/qcrNy3xS5rhJm1EiNJAz
 VACY7buqBjCimaaMs379QVNGlevPonnbrbZqpiXYdlkHqdcVvl/f853LGdbbSlandGBU++7eZg4
 lk2NZuIEg9ZU=
X-Received: by 2002:a5d:64c5:0:b0:3b7:61e5:a8a5 with SMTP id
 ffacd0b85a97d-3b761e5a9b5mr3232209f8f.47.1753169586586; 
 Tue, 22 Jul 2025 00:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnUSVngl4KBKdKubZsQQwWRZfCzc0efMwljlvF/PRVNi2H2OGL7IoX3L4xcHT9jm1ufxY6bw==
X-Received: by 2002:a5d:64c5:0:b0:3b7:61e5:a8a5 with SMTP id
 ffacd0b85a97d-3b761e5a9b5mr3232169f8f.47.1753169585987; 
 Tue, 22 Jul 2025 00:33:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5a4253sm124822425e9.3.2025.07.22.00.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 00:33:05 -0700 (PDT)
Message-ID: <b865db9f-725f-4ca7-9101-caf4b3caa430@redhat.com>
Date: Tue, 22 Jul 2025 09:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
 <CACGkMEunxuooL+z=Oz1FsNabNuh=QwfMbzG0k0S+avL3LxEV7w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEunxuooL+z=Oz1FsNabNuh=QwfMbzG0k0S+avL3LxEV7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 7/22/25 5:50 AM, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 4:54 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> Tap devices support GSO over UDP tunnel offload. Probe for such
>> feature in a similar manner to other offloads.
>>
>> GSO over UDP tunnel needs to be enabled in addition to a "plain"
>> offload (TSO or USO).
>>
>> No need to check separately for the outer header checksum offload:
>> the kernel is going to support both of them or none.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v2 -> v3:
>>   - use bool type for tap_probe_has_tunnel()
>>   - rebased on top of 2deec9ab7d ("virtio-net: Move
>>         virtio_net_get_features() down")
>>   - _array -> _ex
>>
>> v1 -> v2:
>>   - peer_has_tunnel return a bool
>>   - move TUN_F definition in net/tun-linux.h
>> ---
>>  hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
>>  include/net/net.h   |  3 +++
>>  net/net.c           |  9 +++++++++
>>  net/tap-bsd.c       |  5 +++++
>>  net/tap-linux.c     | 11 +++++++++++
>>  net/tap-linux.h     |  9 +++++++++
>>  net/tap-solaris.c   |  5 +++++
>>  net/tap-stub.c      |  5 +++++
>>  net/tap.c           | 11 +++++++++++
>>  net/tap_int.h       |  1 +
>>  10 files changed, 96 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 53413ec4d5..70c85f7f77 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
>>      return qemu_has_uso(qemu_get_queue(n->nic)->peer);
>>  }
>>
>> +static bool peer_has_tunnel(VirtIONet *n)
> 
> Nit: it looks better to use peer_has_udp_gso_tunnel().
> 
>> +{
>> +    if (!peer_has_vnet_hdr(n)) {
>> +        return false;
>> +    }
>> +
>> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
>> +}
>> +
>>  static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>>                                         int version_1, int hash_report)
>>  {
>> @@ -3070,6 +3079,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
>>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>>
>> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
>> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
>> +        virtio_clear_feature_ex(features,
>> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
>> +        virtio_clear_feature_ex(features,
>> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
>> +
>>          virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>>      }
>>
>> @@ -3083,6 +3099,15 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
>>      }
>>
>> +    if (!peer_has_tunnel(n)) {
>> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
>> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
>> +        virtio_clear_feature_ex(features,
>> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
>> +        virtio_clear_feature_ex(features,
>> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
>> +    }
>> +
>>      if (!get_vhost_net(nc->peer)) {
>>          if (!use_own_hash) {
>>              virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
>> @@ -4137,6 +4162,10 @@ static const VMStateDescription vmstate_virtio_net = {
>>      .dev_unplug_pending = dev_unplug_pending,
>>  };
>>
>> +#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
>> +    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
>> +                      (_bit) % 64, _defval)
>> +
>>  static const Property virtio_net_properties[] = {
>>      DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
>>                      VIRTIO_NET_F_CSUM, true),
>> @@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] = {
>>                                    rss_data.specified_hash_types,
>>                                    VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1,
>>                                    ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
>> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
>> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
>> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features_ex,
>> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true),
>>  };
> 
> Need compatibility work like:
> 
> d83f46d189 ("virtio-pci: compat page aligned ATS")

If I read correctly the only missing pieces are the hw_compat_10_1
entries, am I correct?

If so, as mentioned here:

https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05032.html

I'll add the needed entries after that the hw_compat_10_1 will be created.

Thanks,

Paolo


