Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE443C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPp4-0002ng-I9; Fri, 23 May 2025 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPp2-0002id-Na
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPoz-00052C-8l
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747996811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSAR2oP9aif2PDPWow5q8ViVzjxb1+2hfHb5dvrmC30=;
 b=gKJ0GJUZhv4gtEQmVygT2sbdpZehaM3SnqfA4hqM21iIq49875QPLlrzLbxinpNAk4rLXh
 OAdqw+jrX4jJsvP1z+9rBVlZf+bRrdn5JQ6102Ilo1LQ+ghvEPpx/37r91N3PAHaBK0qUY
 zUTRGQhVCH5oN2WYWyvb1rhEsdowWcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-oJpKAt4PPia4Q06OJyv5TQ-1; Fri, 23 May 2025 06:40:09 -0400
X-MC-Unique: oJpKAt4PPia4Q06OJyv5TQ-1
X-Mimecast-MFC-AGG-ID: oJpKAt4PPia4Q06OJyv5TQ_1747996808
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so48905255e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747996808; x=1748601608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSAR2oP9aif2PDPWow5q8ViVzjxb1+2hfHb5dvrmC30=;
 b=GihS6zeDymh973bV7xYKBC7CslvG9n8ZkHHMUKBxglIEhO4IdU99J41rgrelj/4BNK
 uZ6mjEEnuPp2Igy4qFIdwAQvzye4dBCtdg0PLyi4gf3BQqpYf8zvsxah9WE81+u3ihEw
 mpMZ3JWjmCSKN99n3b/IfEiIU9u8X5yD4xBSorvgG3N6cvl/65ds8kulwgcjIkdR31dR
 qlyg9qL5mhGUbzwFqbwZU33YwDwCClDAFD9MGV++SIvrhndcTgUCJ09H0ANj6S4SqqRE
 l0GBCazDzDTlLFV3At09iRsD9hpL803oEfmt4tekzuY8dplr/xvu/ouKrBT838rHZ+KV
 Y5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbv/VAnjJ16Us9Y/DBY32hBFTcq/MUnNuENITETjNc0oA7IE0oEA84yloZlAe8XYpxMFcgZzm5400t@nongnu.org
X-Gm-Message-State: AOJu0YxRqcF47BzSwrcCM6ilSkZ4DuvYM1bNAFhCNo/8O2GcPI886rQi
 +Hp3Pknw6pYrnT0PUnMjmNnqyDRIlSg4rPCQrSgQcb8L9Mp3O8Tx6odmYhh6NaVPEKiW9S6sBQd
 jfUYE+K4Yg95kPEgPqm8EmwcrphKJGJpL+f841LdCAbveZvS8/Y/9rqaF
X-Gm-Gg: ASbGncv4ySiXWVHDNiz4tuQQI8sUXAQzdgb9cRQqNHj9Ik4GtfiMlq+1Yj60dflEcqb
 Kgtfa/U+IAUUrU62OI5yHENlOkB1ZG9oCfza5c22g7+8HyRrjqceXBniZSnQ10vb39/IW4/krus
 x1Sn2QghQTo/YoCwRejkzhSlKVqYmebHef6xx2HbRPz874BIbRiW/EQ6VbiUq1ShSs640lB7F6d
 IJEkv6SYWGv0S/hvHekPy/aw0tSEmlOfiNS9W05EYZMRiF5NDqbauq+J0YKqI7OAeGW1Xw1mYd+
 C2oPLw2lvXpQDMybe1k=
X-Received: by 2002:a05:600c:820e:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-44b6cc09789mr41197025e9.3.1747996808466; 
 Fri, 23 May 2025 03:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELNKvww9fhNfl3zJyHSIqVqjn7ICzT1OKo1K27pNsKEg0UfA/BxHoq8NMLflI0HlKcUmvKAw==
X-Received: by 2002:a05:600c:820e:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-44b6cc09789mr41196545e9.3.1747996808059; 
 Fri, 23 May 2025 03:40:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f74cce5bsm132089705e9.24.2025.05.23.03.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:40:07 -0700 (PDT)
Message-ID: <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
Date: Fri, 23 May 2025 12:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
 <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/23/25 10:16 AM, Akihiko Odaki wrote:
> On 2025/05/21 20:34, Paolo Abeni wrote:
>> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>>          .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>>          .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>>          .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>> +#ifdef CONFIG_INT128
>> +       .tnl  = !!(n->curr_guest_offloads &
>> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
>> +       .tnl_csum = !!(n->curr_guest_offloads &
>> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
> 
> "[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a 
> struct for offloading, but how about passing n->curr_guest_offloads as 
> is instead?
> 
> It loses some type safety and makes it prone to have unknown bits, but 
> omitting duplicate these bit operations may outweigh the downside.

I *think* that one of the relevant point about the current interface is
that qemu_set_offload() abstracts from the virtio specifics, as it's
also used by other drivers. Forcing them to covert the to-be-configured
offloads to a virtio specific bitmask sound incorrect to me. Possibly I
misread your suggestion?

[...]
>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>> index aa5f3a6e22..b7662ece63 100644
>> --- a/net/tap-linux.c
>> +++ b/net/tap-linux.c
>> @@ -287,6 +287,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>>           if (ol->uso6) {
>>               offload |= TUN_F_USO6;
>>           }
>> +        if ((ol->tso4 || ol->tso6 || ol->uso4 || ol->uso6) && ol->tnl) {
> 
> Is it possible to have ol->tnl without TSO or USO? If so, is ignoring 
> ol->tnl really what you want?

The virtio specifications actually prevent setting UDP-tunnel offload
without any other "inner" offload (TSO or USO), as it makes little to no
sense (the stack can't GSO/GRO the outer header without doing the same
for the inner).

Does the above makes sense/answer your questions?

/P


