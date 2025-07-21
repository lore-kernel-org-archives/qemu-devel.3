Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73306C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udmA6-0004co-2a; Mon, 21 Jul 2025 04:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udm9x-0004YZ-5Z
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udm9s-0002n6-Jt
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753087561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10CQIQEs5rhQGP10WD3z2WHI/tTPeoT74TkbLmKSqDI=;
 b=CY1g0sXpYt0agh6tzr+otKu9St3Ez+X6ac8a+IoaDF6yESReQLzbFRiFZkkwF8JjyBqM70
 CtS+y3kTQWbcewbVsJX+eiKaXpfY/rVKGzOkupChiOGSMHNv1TmbKWZvGRCU9TQd5A+UdY
 eKFEOabB7XWIPyqZ4zhMXWGTAOuqVFQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-HOrS-L9TPvqildwe7bKU3w-1; Mon, 21 Jul 2025 04:45:59 -0400
X-MC-Unique: HOrS-L9TPvqildwe7bKU3w-1
X-Mimecast-MFC-AGG-ID: HOrS-L9TPvqildwe7bKU3w_1753087558
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so24927195e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753087558; x=1753692358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10CQIQEs5rhQGP10WD3z2WHI/tTPeoT74TkbLmKSqDI=;
 b=C/c46/u/fPsofrIYEwul/lAtkbBg4HVJuWNXZAhHr0hhvILpEMbeh5tE88HRL2G6BI
 DEaDtJ/jdoUZi8vVeLqElYab+Rgmm9BCMnatF9o3d05DTy90rb01c2QQau5+4n4wChK9
 37CC23quvHv7UFXwNoRa4dPTMg9qFXEjXJptnwcDMLl2onJHHw2fnvgYLsiIF6bU95QY
 hSPE/tEz/Zb/xhi7O+iJfImoRA4Btu7DetBCx+3Bxh8B3hLk2BZntiJzmhvrbTyHGnQG
 FwjgH/oB5jMn2sKaw9vJ5F5FyYau7GSm36iUsKU4pp8miypeYr6RC0SGb8cmp3+K1FeT
 N4gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFcXauQ7twbzmCQ71n4PmyIiir7OqTDzvGGrghCFq+03t0VxCv3Wo7h1gjRRLt7qpDW03EA8pG/qqZ@nongnu.org
X-Gm-Message-State: AOJu0Yy/o9Xf6Ydb8XKM9G3p+WOZkkgYbWBIfdqESmRBLMKozO1C8+Mn
 glcqSJw24bdQqhrDvYGK+gmmYvRVrAxR9dsjyZs/V/Jlws1rKoq6t33217B+l4MH1iWi9cSrawV
 mnCM3JW61Dd5a2Yoib5Y3DerxctR1AFLw4yOrbdvtpaaX+H/vWrHWnyQD
X-Gm-Gg: ASbGncuRlG5ny9kfCs17znibYHrELv0YcUygHbzpBlrFZXQZTzECv1vCCfObyESBt+L
 ByQH+jw7HNXas6UYnN4ui9cNYNMSA/DEajSKI/gS8zncutMTY7c/4iKao/RYxPnVEBN6vhXxzO7
 9yUD7wrm0bK0NOMurjWfRuIvu3TtQysY4+cMvhbhYNFCxPScWu3j6RjqfZy0R4CHrN8B0+IeGDL
 +Q2B6bJtoPjalST4VXaxLU2QcN9kUxB4WxTykYBKNFFWDlwMD7eDRcZj3DbzKZWcs9VgVZEK+Lk
 Wa/VtKKBB4iKfK82QpHTvFxynANE5JeG9NbtBECjmaWtwliGLLmTUjznzbWfIGJ/pO2ewn0TZoo
 hRUAxOvnVxqo=
X-Received: by 2002:a05:600c:c0d2:20b0:456:1e4a:bb5b with SMTP id
 5b1f17b1804b1-45635845454mr76483795e9.32.1753087558047; 
 Mon, 21 Jul 2025 01:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhESKfL9pHlF+9Qqcev4RYPAhSWJGkxaeGX2dFJsiFEhN3OwwzAoMXHBsJqKsLDn/oRA3CbQ==
X-Received: by 2002:a05:600c:c0d2:20b0:456:1e4a:bb5b with SMTP id
 5b1f17b1804b1-45635845454mr76483625e9.32.1753087557568; 
 Mon, 21 Jul 2025 01:45:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f4294sm152558615e9.3.2025.07.21.01.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:45:57 -0700 (PDT)
Message-ID: <28bcda3f-52a9-43b9-86be-69e66b1f4ec2@redhat.com>
Date: Mon, 21 Jul 2025 10:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/13] virtio: introduce extended features type
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <c1b14368e79fb3fd3cf402d7b03aed4449cdf0a8.1752828082.git.pabeni@redhat.com>
 <18dd4847-769f-4c5d-8559-8647822d362a@rsg.ci.i.u-tokyo.ac.jp>
 <fe72a900-9b4f-472d-af1d-e5f37d78a529@redhat.com>
 <e89fade5-1912-45d5-8c4e-259b45a8a3bd@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e89fade5-1912-45d5-8c4e-259b45a8a3bd@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/21/25 9:49 AM, Akihiko Odaki wrote:
> On 2025/07/21 16:33, Paolo Abeni wrote:
>> On 7/20/25 12:41 PM, Akihiko Odaki wrote:
>>> On 2025/07/18 17:52, Paolo Abeni wrote:
>>>> diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
>>>> new file mode 100644
>>>> index 0000000000..68e326e3e8
>>>> --- /dev/null
>>>> +++ b/include/hw/virtio/virtio-features.h
>>>> @@ -0,0 +1,123 @@
>>>> +/*
>>>> + * Virtio features helpers
>>>> + *
>>>> + * Copyright 2025 Red Hat, Inc.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#ifndef QEMU_VIRTIO_FEATURES_H
>>>> +#define QEMU_VIRTIO_FEATURES_H
>>>> +
>>>> +#include "qemu/bitops.h"
>>>> +
>>>> +#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
>>>> +#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
>>>> +
>>>> +#define VIRTIO_FEATURES_MAX        128
>>>> +#define VIRTIO_BIT(b)              BIT_ULL((b) % 64)
>>>> +#define VIRTIO_DWORD(b)            ((b) >> 6)
>>>> +#define VIRTIO_FEATURES_WORDS      (VIRTIO_FEATURES_MAX >> 5)
>>>> +#define VIRTIO_FEATURES_DWORDS     (VIRTIO_FEATURES_WORDS >> 1)
>>>
>>> These shifts are better to be replaced with division for clarity;
>>> BIT_WORD() is a good example.
>>>
>>> "WORD" and "DWORD" should be avoided due to contradicting definitions
>>> common in QEMU as described at:
>>> https://lore.kernel.org/qemu-devel/aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp/
>>>
>>> BITS_TO_U32S() is a good example this regard.
>>
>> Ok, I'll rename:
>> 	VIRTIO_FEATURES_DWORDS -> VIRTIO_U64_PER_FEATURES
>> 	VIRTIO_FEATURES_WORDS -> VIRTIO_U32_PER_FEATURES
> 
> U64 and U32 should be plural (i.e., rename them into 
> VIRTIO_U64S_PER_FEATURES and VIRTIO_U32S_PER_FEATURES)
> 
> "PER_FEATURES" also sounds a bit awkward; BITS_PER_BYTE and 
> BITS_PER_LONG had singular after "per" so the unit was clear, but it is 
> not in this case.
> 
> I could think of several options:
> - VIRTIO_U64S_PER_FEATURES (what you proposed + plural U64S)
> - VIRTIO_FEATURES_U64S (closer to the previous version)
> - VIRTIO_FEATURES_NU64S (like CPU_TEMP_BUF_NLONGS)
> - VIRTIO_U64S_PER_FEATURE_BITMASK
> 
> They have downsides and upsides, and I don't have an idea what's the best.

Indeed an optimal name here could be impossible to fit. IMHO
VIRTIO_FEATURES_NU64S is the best option among the above and I like it.

I'll use that one.

Thanks,

Paolo


