Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC677E7FDD6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF86-0007fl-MW; Tue, 03 Feb 2026 07:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vnF82-0007fV-GT
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vnF80-0007XJ-U2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wrl8B01Dh0YbfY3+uk/+Iwcv/aEqnP0+S/EPiy7wQu8=;
 b=GXmQitCTZmjisDRsFr106mOStCu5qrnIXHLFyH3AK/GUvqFs60zEFNk1nYxHPV6yTlWEwM
 rMmmBZ75xfCsZ7RAnHNgWlsqvLIlHFNIKAmBdWjNHpoXyK/mncCQf80Mzn8416/VLWuioq
 dc1RTi3UD/e8EsVytqTyZCMALpvd8x8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-daTXKpdXMy6B05ZeMKtZYw-1; Tue, 03 Feb 2026 07:03:29 -0500
X-MC-Unique: daTXKpdXMy6B05ZeMKtZYw-1
X-Mimecast-MFC-AGG-ID: daTXKpdXMy6B05ZeMKtZYw_1770120208
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso3601797f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770120208; x=1770725008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wrl8B01Dh0YbfY3+uk/+Iwcv/aEqnP0+S/EPiy7wQu8=;
 b=TsBNt49QASi1nCi5w8lUKdg+8Z6NArhDmxoo3Hv/8eQvPz86C74nhM0m2/SCxWEtYq
 1sz+IKNlB2nX+YC3MkBiAi2LjedteGoWemKNRMxPDPdOQm4goedDPsolzWG0BE9a08aB
 m+bhvG2llHOc4liZ/j4TJ1r2KC1CwAnedQsrbAo18RZw6kxIQUPR3H+6ToekRd/Ka6uL
 IPQ/SnLoRSzAvrXMQPtTATiTEEur0dpEA0RAUb1s+HB1R++QGjBfpHEgiuaGl9+zvjnj
 DmHkbhr1b4LioRgc1HVw+sCyzLLUcda39S/mgoEMqykfG68WIXhWFJ7AWnjTrtzdlCaB
 vQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770120208; x=1770725008;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrl8B01Dh0YbfY3+uk/+Iwcv/aEqnP0+S/EPiy7wQu8=;
 b=ZajcnwJpCW5qP+2NoFejOq8MkaNr1SnZPjC0QvEJO6ev04JNByJsRcsmBZ4nHnwgql
 y3dkOdC2GXv5rHhhmumKAq+xHO3FdpUOnl896tdx3S8vFMJvUbY8cKUTjXUjmpHwHYLo
 S5L5qXVaoZnId5Ok1lFPQKbwIplMQN/jZdlzNV/WKY4bbfSw9cJJUUiiLyv7zkbyIjiC
 rxC9WgYVFEhGYIh8VGbWer98WPc7vxr8rsR0/sFHPre6sbvtcqZ5qglldI7A37mNRueu
 Kio+HPh916eplAMBCpJXUUzobkA+8giDb1Z3axJ9mztoVFrXdu3TSfpMhuqcKmhGj+cT
 4ZEA==
X-Gm-Message-State: AOJu0YxMY8nrodFVZ28DnlvY5w6QsGmn2PV5Re4uSFMKjixvj6vqWUpQ
 Ozn9X2VFITZuUunKOGSUHRnb4djEl279wv5p8HeLDSMm9lLJLUyyolh1vyjf57uwgOM9+smb8IU
 unRAs0tQI+NZ/n6RB1hLpmc4/iO1po4cGQyyJz11q1iBv1AILrMaehzqB
X-Gm-Gg: AZuq6aKhwXufjMI9UvBWxFVXgQ7rXxXj3uM1WbLYSVK9EBr51Ek7mL27h3RODay5KlA
 RfWD6qlP8L8MmxyZxU+hvnvhLgf23vo5MaMJBH5S8LNsbGfNWVEn6krToHtEVeIQFAmJfLlyYZw
 6V303uRV4V7L5bUCcGADIAfzkKyxZSdqgkQ6kcQY0Fo2b2GYmsEuPsBIO/Yp4CPJlPe8u+LYI9c
 RzFQWP+isMm87MRxES/PjWRgg8Fv4lWL/rWXSwBI6To00LoJyHVUgPiCqkG/vngKKbetm3ol6fk
 /iFdXHFtaMMr/iR92zi08plDrES9J3YJ98UvpQiokwqmMrGbXCuc0QmI4GZklsTYuN6xoV6uYzj
 FfFMpPEeUcS8BDWOp2GkIeFieyFJMwJ04MZo5NhV/F/KSc+3Q
X-Received: by 2002:adf:ed03:0:b0:436:145a:e54f with SMTP id
 ffacd0b85a97d-436145ae92emr1763605f8f.24.1770120207899; 
 Tue, 03 Feb 2026 04:03:27 -0800 (PST)
X-Received: by 2002:adf:ed03:0:b0:436:145a:e54f with SMTP id
 ffacd0b85a97d-436145ae92emr1763558f8f.24.1770120207466; 
 Tue, 03 Feb 2026 04:03:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322f40sm49699647f8f.34.2026.02.03.04.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 04:03:27 -0800 (PST)
Message-ID: <3806403b-a937-4b10-8bfb-bc4386b7fd82@redhat.com>
Date: Tue, 3 Feb 2026 13:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
To: Stefano Brivio <sbrivio@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260127192108.216495da@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/27/26 19:21, Stefano Brivio wrote:
> [Cc'ing Laurent and David]
> 
> On Tue, 27 Jan 2026 15:03:06 +0100
> Juraj Marcin <jmarcin@redhat.com> wrote:
> 
>> During switchover there is a period during which both source and
>> destination side VMs are paused. During this period, all network packets
>> are still routed to the source side, but it will never process them.
>> Once the destination resumes, it is not aware of these packets and they
>> are lost. This can cause packet loss in unreliable protocols and
>> extended delays due to retransmission in reliable protocols.
>>
>> This series resolves this problem by caching packets received once the
>> source VM pauses and then passing and injecting them on the destination
>> side. This feature is implemented in the last patch. The caching and
>> injecting is implemented using network filter interface and should work
>> with any backend with vhost=off, but only TAP network backend was
>> explicitly tested.
> 
> I haven't had a chance to try this change with passt(1) yet (the
> backend can be enabled using "-net passt" or by starting it
> separately).
> 
> Given that passt implements migration on its own (in deeper detail in
> some sense, as TCP connections are preserved if IP addresses match), I
> wonder if it this might affect or break it somehow.
> 

passt implements migration only with the vhost-user backend ("-netdev vhost-user") that is 
not supported by netpass. All the vhost-* cannot be supported because netpass cannot catch 
packets on the virtio queues.

passt with "-netdev stream" doesn't implement migration, but QEMU can be migrated with it 
and all the connections are lost. So netpass will forward packets for connections that 
will be broken.

"-netdev passt" is only some kind of wrapper on top of "-netdev stream" and "-netdev 
vhost-user" that starts the passt backend by itself (rather than expecting it has been 
started by the user).

Thanks,
Laurent


