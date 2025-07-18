Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8880C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 10:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uciFa-0005H9-9F; Fri, 18 Jul 2025 06:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uciFX-0005Cy-2p
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 06:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uciFU-0004n3-CK
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 06:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752834206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZOeF2W+jpREX6RAkQjvBW5UlWO5s0CkxMFjYdcjDC8=;
 b=P/sZJvsVwfAAHbQFjoy6cL5262e7jU746tJC1pnRxT2bHnWW/72g8Jl82aGVsR4wUuVwAc
 r+EYw5bkezNzSToExbO6PiIShhIdmn3IHFNaOZylVi6fJX98kH1CTV03GbB2wGwoedD6L3
 fvoARRiEvxrU0MQOFcpDYv0CsOcZVrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-OdlBbpyZOUq-zXjoR0oWKA-1; Fri, 18 Jul 2025 06:23:25 -0400
X-MC-Unique: OdlBbpyZOUq-zXjoR0oWKA-1
X-Mimecast-MFC-AGG-ID: OdlBbpyZOUq-zXjoR0oWKA_1752834204
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4563f15f226so867695e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752834204; x=1753439004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZOeF2W+jpREX6RAkQjvBW5UlWO5s0CkxMFjYdcjDC8=;
 b=vr5ySmpKFp7a7afXwZgvKFEHVl0yhMtnpWp/O3wXWuTf8pNtXJ+2/vjNpOtQFd6uEn
 OurxbJP+RfTP2XyoIYROxB+mWnI4ckCFiXLo9AmVzfkamVx6bmiocae8BcHi5sZtW/LM
 hrlwG1ZQkgQ5eLndgw//iKNl+ZMvfFD+bzwLlhNzy3Aw1R4Lj+dXRECnBlaUiprJFVWw
 vqTrhpYIV04MLAEeCkqqxIBeOZmdq4cJmJqd5RbKWbRX9ZaC5GTgwul1eZrbYk8cwUwO
 B46pHyc/cRrEJJ3cUeJ61tnZYITST9MVRkevRcsRqcjwa3fV4wlBq0cQkpp83cBioAtr
 3yiQ==
X-Gm-Message-State: AOJu0YzPS8hvkQzUUkoTOKcW1GgCkcU3ZOFXiTG90zHtjjd14ZCl5cGV
 1Xr+Pn9kVUaw0kAegM2SNn7OfacM/a8R/oMjUpokF+mnp3FzSoYQztDu7hdTZqaqu/N+agPDGVr
 C3tuhQa0C94+Mlxp6ViNyD77e0Rt2xsg+xdQHRzvFE2XLvZyU6UePW8iZ
X-Gm-Gg: ASbGncvlHTXPW8tpVrlRwTY3t7LGZagoZYBk2YVqV64q4oMYDVyhPqpUXE4R077kir3
 hR8ICkdLZI+26IXCCkarrwCFNYC+Z6skRhDkFkbnZiz34LuTAnvkOSp588krra1tb2TB4u67/TB
 qdbndzVbu6zgp8zjtaGJezrao7oLjVzvhMiKrHriW242minl563RdSnr2F4TaI4OQCk0KscU2Ud
 DVFUQTAUeSOCm0UheNyWanmlAUxSwGnIqwumi17qZKBjXZAnTfwtu+VW2eJubO9SVyWrf+3BNyh
 ZgW1sJ+sLVTag9P8YbYtj6l/y1QaG173VTmsv9kxg8p9DVKVfkBparlFzz7NZO14ZxqH4HNjbCX
 wTIqn214CuQI=
X-Received: by 2002:a05:600c:1c03:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-4563b8fc975mr18817995e9.29.1752834203733; 
 Fri, 18 Jul 2025 03:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBSEdYag8twN8pt8Pe1KxhnWOrC8q3ZIX1qQRJq7Zw0Z7/48yTa2jTpFgJE3D/c3qIckhqyw==
X-Received: by 2002:a05:600c:1c03:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-4563b8fc975mr18817695e9.29.1752834203210; 
 Fri, 18 Jul 2025 03:23:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5a4e40sm16523695e9.6.2025.07.18.03.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 03:23:22 -0700 (PDT)
Message-ID: <8842b61b-eb9b-4484-ab5d-0dda9642cb02@redhat.com>
Date: Fri, 18 Jul 2025 12:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
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
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 <5vwmpqfuwdo66kydy7k45fmps2jtgawwsan6bd2ipzs6v5j3lo@cuoibjphppck>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5vwmpqfuwdo66kydy7k45fmps2jtgawwsan6bd2ipzs6v5j3lo@cuoibjphppck>
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

On 7/18/25 12:18 PM, Stefano Garzarella wrote:
> On Fri, Jul 18, 2025 at 10:52:34AM +0200, Paolo Abeni wrote:
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index 3b6377cf0d..03c6163cf4 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>>             "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>>             "negotiation supported"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>> +            "UDP tunnel packets"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>> +            "UDP tunnel packets requiring checksum offload for the outer "
>> +            "header"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>> +            "UDP tunnel packets"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>> +            "UDP tunnel packets requiring checksum offload for the outer "
>> +            "header"),
> 
> Is this chunk supposed to be here in this patch or better in the last 
> patches where you add UPD tunnel features support?

Note that this point was discussed in the previous iteration:

https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg04418.html

I think it could be both way: it could be useful for QMP to be able to
dump the (kernel/backend) features in human readable format even if qemu
does not support them.

No big objection to move the above chunk in patch 13/13, if there is
agreement :)

/P


