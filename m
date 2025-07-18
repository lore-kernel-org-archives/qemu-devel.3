Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CDC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclOC-0000We-Ow; Fri, 18 Jul 2025 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uclO2-0000SA-AB
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uclO0-00078i-Eh
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752846265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2+GrSOjq5KttP/Ki1fhgykpHMooKGjZ+P9E74TQdV0=;
 b=eOHYclIMyd+892g8/c+JOrlRT/EAR/ijYM9qeeDTNgVxcHs3TSCJ4c8OjY0NgQAYW/uY9O
 cdp3JGIOBkSODASnrDe9CX5am12aR1G9aKnmjhdUvPbLQYUBF0jlPqarBYzX9e16dcJxG0
 TV26j9vBMneaQ/UVhubtbJgZuybsXxM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-hr-FB83rPAmvel1bYhyf9g-1; Fri, 18 Jul 2025 09:44:24 -0400
X-MC-Unique: hr-FB83rPAmvel1bYhyf9g-1
X-Mimecast-MFC-AGG-ID: hr-FB83rPAmvel1bYhyf9g_1752846263
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae3c5ca46f2so169488666b.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 06:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752846263; x=1753451063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2+GrSOjq5KttP/Ki1fhgykpHMooKGjZ+P9E74TQdV0=;
 b=IG9HAhZz/Lnok5KRT/j71WT0vSgki5ChO0zME71M6RaMkRgUDxQiozZ1mZT8hC+toP
 gk7xuttoQhEz6P1HoEtZqlaNK+BGbdknZ1lGcLsqny5JuYbFjBRyBR+QZJwuoozmAyBL
 xR0v2tqFVWgeMDUCkxUR/wHOHJbVJR2OHEKSFKGoj5YzgZzN6+UgT4l4MP7kF/MKKrZK
 y6ijy6HLPqVMjUE3q/KCK1Aqh9ROnwS5IzAAkBLCOogop9XPfgnKjh8ucKDQML/pkLfZ
 nMWRyaJ6qzND/MAEbJ/Ws+HsKX3XNEYCC79Tj/vuBkqMzOEjYf8n7xf+swz2h3qnUcOU
 N/SQ==
X-Gm-Message-State: AOJu0YwUqFfP03kAeMdLBLnQs3eEYsziMVWTAG898Sef/nAbQB8hG+6k
 K7ONcxpau1gh/7V2wLjw7xdIhQdMyXeE2Y+rXkQuDR1B2Y4UOHRSHjPZShpHNaOSRJv7mRftLzZ
 pwxOvvhcZAEDWQlhmeGaTDYl9rRtrje8Ndp2ZeKbVQOE5xa6v5xvgFrCT
X-Gm-Gg: ASbGncvI+/GQxQP6mWDIimeVnvUkZo0OuGpuTjqdziXswgwwLXIJMUQlVO7FYotlQrC
 mkK8LpiEvUkezi/QI1YACcm7w4D+SMik0Zqs5KFOCkPQeZXrE7AvJKeqZVxScpvutCVWPlK5bxX
 3jfyt7jWud1cUbwCtws4nl4ZxHwFnLsUuoiIbfN/HiJIP5Tf1v3sxtRvw+AxsKThvo57InvvIKm
 1otZqtLWsUs7VBl68B5GlikEsDBuWbtESTETbfDJnqzfjKmNIocd9Cns1AATtiWcoNhGm63WCcX
 GCqBqgqXE77YPG6XKXlVoSVXMo0Ya0DIDO3KE5pWLESmTmeRYv8ELHqPrrrK5j6zI/6BFqnno2Y
 9M/Doj9HwWOc=
X-Received: by 2002:a17:907:3c82:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae9ce0a5a13mr1051132766b.29.1752846262759; 
 Fri, 18 Jul 2025 06:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzkc2i1OIXfCMc4KRkOqG1yPz743WRAu2XBFMZP1MAbJ+5jKuTTSGOb+rqU8G1uY3dT4yW0A==
X-Received: by 2002:a17:907:3c82:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae9ce0a5a13mr1051127866b.29.1752846262235; 
 Fri, 18 Jul 2025 06:44:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca310aasm123506466b.72.2025.07.18.06.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 06:44:21 -0700 (PDT)
Message-ID: <a137cad8-862f-4601-93ca-b1d9240acc71@redhat.com>
Date: Fri, 18 Jul 2025 15:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 13/13] net: implement UDP tunnel features offloading
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
 <b59ee8e3eb926dd510a7a0f2de16f3d0380589f0.1752828082.git.pabeni@redhat.com>
 <7eaaizkny73ki3o3ph7bi2x6y7cjtfgyupsbyywxmcismtkdvn@vtgzq3bfygzz>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7eaaizkny73ki3o3ph7bi2x6y7cjtfgyupsbyywxmcismtkdvn@vtgzq3bfygzz>
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

On 7/18/25 3:22 PM, Stefano Garzarella wrote:
> On Fri, Jul 18, 2025 at 10:52:39AM +0200, Paolo Abeni wrote:
>> diff --git a/net/tap.c b/net/tap.c
>> index 23c6c118e7..2dfa843547 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -62,6 +62,8 @@ static const int kernel_feature_bits[] = {
>>     VIRTIO_F_NOTIFICATION_DATA,
>>     VIRTIO_NET_F_RSC_EXT,
>>     VIRTIO_NET_F_HASH_REPORT,
>> +    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
>> +    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> 
> The *_GSO_CSUM are not supported by vhost-net, right?
> (sorry, I don't know the details, it just occurred to me by looking at 
> the fetaures we enable in the other patch.)

Yes, the kernel module supports/exposes only the 2 features above:
vhost-net need only to be aware of the exact virtio_net_header size,
which in turn depends just on them. Enabling/disabling the outer header
csum offload does not change the virtio_net_header struct.

The actual csum offload is implemented by the tun device.

Please LMK if the above solves your doubt.

Thanks,

Paolo


