Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F840C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlHr-0007DI-Ir; Mon, 21 Jul 2025 03:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udlHY-0006zO-Fq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:49:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udlHU-0003ar-S5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:49:56 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56L7nTm9075995
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 16:49:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sR+xtdWtfCKlGHxN5bliOwYPB83lLYJPuQmK7SR6Ywg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753084170; v=1;
 b=hqrG9MGJ2pMLw7aeCPtVstuYbS5sWAvFSlOreVC7PmTH3FZWgXzVFN2hqCswcbR8
 pCH+ycvPB9CBkIG64aoasSBlF1UDvmwIx1ZoRkaspNviL8G43WBqfLkz818iJWJI
 P8/WBgdg8Kwk9xD9mKFeOZiDG7YfccO5Sw1sDKExQuDwyNfUz5stFQXg2jvpAqhc
 Ofw1z1yCP29sBzZoFbQkqTTPw98rBtj1Atd8F0rK4RSJ6Wj/n73i7gaUmfB6bBEm
 g2kGF56aS9i+hZ7SwvA/llDsBnVrdB0WlU4ylasJHs4K3D+BdMrScuGuCo55mQnR
 rPO6YiYDJeyAKfy3uKpdHQ==
Message-ID: <e89fade5-1912-45d5-8c4e-259b45a8a3bd@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 16:49:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/13] virtio: introduce extended features type
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <c1b14368e79fb3fd3cf402d7b03aed4449cdf0a8.1752828082.git.pabeni@redhat.com>
 <18dd4847-769f-4c5d-8559-8647822d362a@rsg.ci.i.u-tokyo.ac.jp>
 <fe72a900-9b4f-472d-af1d-e5f37d78a529@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <fe72a900-9b4f-472d-af1d-e5f37d78a529@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2025/07/21 16:33, Paolo Abeni wrote:
> On 7/20/25 12:41 PM, Akihiko Odaki wrote:
>> On 2025/07/18 17:52, Paolo Abeni wrote:
>>> diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
>>> new file mode 100644
>>> index 0000000000..68e326e3e8
>>> --- /dev/null
>>> +++ b/include/hw/virtio/virtio-features.h
>>> @@ -0,0 +1,123 @@
>>> +/*
>>> + * Virtio features helpers
>>> + *
>>> + * Copyright 2025 Red Hat, Inc.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef QEMU_VIRTIO_FEATURES_H
>>> +#define QEMU_VIRTIO_FEATURES_H
>>> +
>>> +#include "qemu/bitops.h"
>>> +
>>> +#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
>>> +#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
>>> +
>>> +#define VIRTIO_FEATURES_MAX        128
>>> +#define VIRTIO_BIT(b)              BIT_ULL((b) % 64)
>>> +#define VIRTIO_DWORD(b)            ((b) >> 6)
>>> +#define VIRTIO_FEATURES_WORDS      (VIRTIO_FEATURES_MAX >> 5)
>>> +#define VIRTIO_FEATURES_DWORDS     (VIRTIO_FEATURES_WORDS >> 1)
>>
>> These shifts are better to be replaced with division for clarity;
>> BIT_WORD() is a good example.
>>
>> "WORD" and "DWORD" should be avoided due to contradicting definitions
>> common in QEMU as described at:
>> https://lore.kernel.org/qemu-devel/aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp/
>>
>> BITS_TO_U32S() is a good example this regard.
> 
> Ok, I'll rename:
> 	VIRTIO_FEATURES_DWORDS -> VIRTIO_U64_PER_FEATURES
> 	VIRTIO_FEATURES_WORDS -> VIRTIO_U32_PER_FEATURES

U64 and U32 should be plural (i.e., rename them into 
VIRTIO_U64S_PER_FEATURES and VIRTIO_U32S_PER_FEATURES)

"PER_FEATURES" also sounds a bit awkward; BITS_PER_BYTE and 
BITS_PER_LONG had singular after "per" so the unit was clear, but it is 
not in this case.

I could think of several options:
- VIRTIO_U64S_PER_FEATURES (what you proposed + plural U64S)
- VIRTIO_FEATURES_U64S (closer to the previous version)
- VIRTIO_FEATURES_NU64S (like CPU_TEMP_BUF_NLONGS)
- VIRTIO_U64S_PER_FEATURE_BITMASK

They have downsides and upsides, and I don't have an idea what's the best.

Regards,
Akihiko Odaki

