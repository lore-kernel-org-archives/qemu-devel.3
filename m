Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9187DC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzMK-0006Uq-TO; Wed, 16 Jul 2025 06:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubz8X-0000Zk-VH
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubz8U-0001ho-IM
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752660791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDg9fNKVULSPywM4snHAHkQlAePZyW2iPDo8IaasA5s=;
 b=EyWxFCS0TUdNP1TxBG4hcUaeUhkrxp7OegIWbXDxYGl1dB49bk0nh/lk5abCBAvHsuNFGf
 1UcWBcplrEie612ee45tT9CjPZeA9KNQEtKSPf3D1jFGVo97tKhtInrCHkDD5IAVQPjkz+
 CTVcL/Fm8YqBD4f8sGCmTeLbax/XN88=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-3MeJo9W2PRSztNs8lPIZeA-1; Wed, 16 Jul 2025 06:13:09 -0400
X-MC-Unique: 3MeJo9W2PRSztNs8lPIZeA-1
X-Mimecast-MFC-AGG-ID: 3MeJo9W2PRSztNs8lPIZeA_1752660788
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so2841639f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752660788; x=1753265588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDg9fNKVULSPywM4snHAHkQlAePZyW2iPDo8IaasA5s=;
 b=oNoZGcKmuC0DHksJ3M4xlkwy1bqKJGBcn2Bn3ca9q35rMRENW5nfymuw5K7Lju8iwm
 WF8y6L3HUB6VHVsXSTSalBed8dsJqDcun0Be6mxYLXbhMdzn9Xhrq+kuHMgCoFcfRqlo
 GDxztQwoq4ERmHuE0trpz9OrhQpVx4+l35AD5Wad4mFekfQiifG9zgV6jVjriu+iqBdL
 pyou0d+V6wZlBoUVPW1pyyqhOaOhYQgJBC/baIz6M5bTrrtu+CQeiEDBz4EZ614e87mz
 ui1sskIEXOAsMZIojqzekDfe/NnVNps1s++KN/z4K1IiZLCPmOCehGA5bWCEJSK1k9Pj
 vDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZycsGyJYBmLFybk5hosNSqNb6lrrr2DN3Rg1fnhTGxYi86o5LUgPwDdjG+Y3LKfDsKq7J56pScvwl@nongnu.org
X-Gm-Message-State: AOJu0YzwWpcDrClQ1Kw3OBdsvDn7AXFxsLiSAjuRp66HcL46c5FUu3Ib
 dk02ZcHbuggAM3+QD6Y6WBhTzhaGCGi6G6/jzbkd0LAfzHcElFne7SlPfETLqsilq8rA1IqSBly
 IKDA5qtfPlzd1wq40usgiTH6u4vI8QqF6ndOMBY4Wm/oJboPHtHVJUocd
X-Gm-Gg: ASbGnctZSgUgtgMVUllc72zZ9UTLmulLRYX3NckA/nvKxiBc1glUY6e+pSBbeFf+PDJ
 KzCQYje8QU44CJOpgk+44b1znTFxvv+5azufyp//Ngy3Bd6rB0Fa80wxSzUbIOB/gYS2arQ+/Iw
 ReKpNURRyihlRZp86r+ecVZPFVoBJGrtooDZD3e8jx+9B+V/CF0I779nwUi1Dehf2hlkmar1tm1
 KfaJuz4J7jAyZ0skhyPAd/OAX8/GlXf5NWDORfy+MN7IwCw8ZW7GQInTvCYladtiBNTOSYT3bOE
 DLURPnjKhuoHqb/4VtlS+b0J30N/W63AC9/mOUvWUl5tCFZ4ps0AHQIvfQDCvr11NnTdB7xBhTp
 z+sqi/2Do6K0=
X-Received: by 2002:a05:6000:22c2:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3b60e523c46mr1553380f8f.27.1752660787785; 
 Wed, 16 Jul 2025 03:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoGu1ZMJP681KqUVqeq25FjmKb96lWRRkwj0gCeExoWeI/XqpEHgo8aaGRe7lLpQzLbwrMAA==
X-Received: by 2002:a05:6000:22c2:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3b60e523c46mr1553350f8f.27.1752660787282; 
 Wed, 16 Jul 2025 03:13:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0dc3esm17279608f8f.47.2025.07.16.03.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 03:13:06 -0700 (PDT)
Message-ID: <1d582df4-2995-423c-8b6c-351beaf94139@redhat.com>
Date: Wed, 16 Jul 2025 12:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/13] net: implement UDP tunnel features offloading
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <509e49207e4dc4a10ef36492a2ee1f90f3c2c237.1752229731.git.pabeni@redhat.com>
 <f266ffe9-f601-46cc-85be-515475cbfe12@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f266ffe9-f601-46cc-85be-515475cbfe12@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

On 7/15/25 10:07 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> When any host or guest GSO over UDP tunnel offload is enabled the
>> virtio net header includes the additional tunnel-related fields,
>> update the size accordingly.
>>
>> Push the GSO over UDP tunnel offloads all the way down to the tap
>> device extending the newly introduced NetFeatures struct, and
>> eventually enable the associated features.
>>
>> As per virtio specification, to convert features bit to offload bit,
>> map the extended features into the reserved range.
>>
>> Finally, make the vhost backend aware of the exact header layout, to
>> copy it correctly. The tunnel-related field are present if either
>> the guest or the host negotiated any UDP tunnel related feature:
>> add them to host kernel supported features list, to allow qemu
>> transfer to such backend the needed information.
> 
> Please also update: hw/virtio/virtio-qmp.c

Do you mean by adding FEATURE_ENTRY() for
{GUEST,HOST}_UDP_TUNNEL_GSO{,_CSUM} ?

Such entries are added in patch 8/13 "qmp: update virtio features map to
support extended features". Even if the features are not supported yet
in such patch, I think the code could already parse their name.

Do you prefer I move the features entry definition here?

Thanks,

Paolo


