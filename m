Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CCDC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udl4Y-0004f3-0C; Mon, 21 Jul 2025 03:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udl1Y-0002uu-7l
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udl1P-0001kj-S8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753083193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2q5C51tCKKdwbJa7MSfnb0p5m6TW3oxHxqT0txYotko=;
 b=Nihy/aFj9Byn1IRbBhy/6wY1+W165juup2SqyRYFX7RALjnMC/3xMLZpPOM8NQqBzLnJrB
 TgV4YpXTx5cYBu3M0TVjW3t2rfpfECXUpJrL2NkWOya3+9dQk1ZBOIcQmm2ZL8FGLt+WXs
 lpF/e8Ml3SjnGGOtlB8ufPXbdGUYsi0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590--tw7Sd8zM1eV6RdBamln5Q-1; Mon, 21 Jul 2025 03:33:10 -0400
X-MC-Unique: -tw7Sd8zM1eV6RdBamln5Q-1
X-Mimecast-MFC-AGG-ID: -tw7Sd8zM1eV6RdBamln5Q_1753083190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45624f0be48so22104795e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753083189; x=1753687989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2q5C51tCKKdwbJa7MSfnb0p5m6TW3oxHxqT0txYotko=;
 b=mOn1HE6iZOPw4T3U8efgRoq9OuNJIvzf3FSLL+QabhIXbP5c2fdEskrAIAoPur9bSN
 t1ASA4bYwoVBp6sd9J7+xePJVAucr9WI88V8PvwF+boN2WbURUR8gbISvQ543wluY6Ow
 wPF+GPRHiE7m3PF3fHM+mjDeIwi2ADVeI+lk0W3FgqVg8B+1QrwUITFsb41iwbgzfDA+
 TxdQi3cztaCLUD+nDC7GTI03d6oozWa880Tb1XUFmpsrzeJ6jO+n+MP49jrqMOhgM1Jd
 UUNbthdfp/Jo/eh6Ze/+hZD4f1jywNiDaMvRd1EpjzhM+6zJAtQHzO8SyndRgQ2njl04
 Ct7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGmLFFT4NMbKtrr6JcA0QrilbR82zP8dHkk/We+OtV2NezABQ225Pp0dnvDhgz0AshYxtln6HrzX4V@nongnu.org
X-Gm-Message-State: AOJu0YxjuV4JQ/cjSgrWnLO3Sygv/91Axcbho2sNMSPFk4Le/CJA7+lw
 xteh8rsi0XaZEKvoG3ZpFS6siy8uQc83G9olztiTL1YsCYsYV6VUq8ivnoyO1IBETh4XfuC+mPT
 ll0SxR5sYrF3q7nH6G0NZdI47THlo/rdnJYRNASuwushR46mCmH1s1LtF
X-Gm-Gg: ASbGnct2M4cQo2ReRAMxeYxdTdjsCsGt/auUxg0uUDYlweM1UqQbIIqhNjv7gIbu+O6
 6zRbhKcr3bpnIvAgm1VqjfHl5UHH5L5dp1MkemdaWvTA2ED9SqBG0NH6mZl0TeCVmGNexeEFTtU
 P+9qO0UAWHtFMoD3M4UaAD1QUsVf/dxaB/ybIKvU5G+19A4bPITygR38og14IY/ZGiqtt8I2rD1
 tRL4KdQhwA2YJWwBFQN7EQxUgz3MRb5LhiL15enRkZjEWa/Rjmn7sEpV+l02Ii+xvtmam5FIF2A
 usyFssGssIEdy3ItfCMGDWfvohk1NYe2DPOMnjzy9q4z16Mc8EGRGadllwbM2D6WO6moj3DXuM3
 GBxGflDyjI/4=
X-Received: by 2002:a05:6000:4704:b0:3a6:cfca:efee with SMTP id
 ffacd0b85a97d-3b60dd6aa5amr14947121f8f.17.1753083189563; 
 Mon, 21 Jul 2025 00:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPmba87Lo+ffzVrmcvXKOdqa1TLZ9PIrMJLkZ7TT/Nl1UIGP6YlLQuLxWpZK0fvZdqJbqkLg==
X-Received: by 2002:a05:6000:4704:b0:3a6:cfca:efee with SMTP id
 ffacd0b85a97d-3b60dd6aa5amr14947084f8f.17.1753083189036; 
 Mon, 21 Jul 2025 00:33:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bc6fsm9662031f8f.28.2025.07.21.00.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 00:33:08 -0700 (PDT)
Message-ID: <fe72a900-9b4f-472d-af1d-e5f37d78a529@redhat.com>
Date: Mon, 21 Jul 2025 09:33:06 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <18dd4847-769f-4c5d-8559-8647822d362a@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

On 7/20/25 12:41 PM, Akihiko Odaki wrote:
> On 2025/07/18 17:52, Paolo Abeni wrote:
>> diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
>> new file mode 100644
>> index 0000000000..68e326e3e8
>> --- /dev/null
>> +++ b/include/hw/virtio/virtio-features.h
>> @@ -0,0 +1,123 @@
>> +/*
>> + * Virtio features helpers
>> + *
>> + * Copyright 2025 Red Hat, Inc.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QEMU_VIRTIO_FEATURES_H
>> +#define QEMU_VIRTIO_FEATURES_H
>> +
>> +#include "qemu/bitops.h"
>> +
>> +#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
>> +#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
>> +
>> +#define VIRTIO_FEATURES_MAX        128
>> +#define VIRTIO_BIT(b)              BIT_ULL((b) % 64)
>> +#define VIRTIO_DWORD(b)            ((b) >> 6)
>> +#define VIRTIO_FEATURES_WORDS      (VIRTIO_FEATURES_MAX >> 5)
>> +#define VIRTIO_FEATURES_DWORDS     (VIRTIO_FEATURES_WORDS >> 1)
> 
> These shifts are better to be replaced with division for clarity; 
> BIT_WORD() is a good example.
> 
> "WORD" and "DWORD" should be avoided due to contradicting definitions 
> common in QEMU as described at:
> https://lore.kernel.org/qemu-devel/aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp/
> 
> BITS_TO_U32S() is a good example this regard.

Ok, I'll rename:
	VIRTIO_FEATURES_DWORDS -> VIRTIO_U64_PER_FEATURES
	VIRTIO_FEATURES_WORDS -> VIRTIO_U32_PER_FEATURES
	VIRTIO_DWORD ->  VIRTIO_FEATURES_U64
(imho VIRTIO_U64 would sound ambiguous)
        VIRTIO_BIT -> VIRTIO_FEATURES_BIT
(for consistency with the previous one)

>> +static inline bool virtio_features_equal(const uint64_t *f1,
>> +                                         const uint64_t *f2)
>> +{
>> +    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_DWORDS);
>> +}
>> +
>> +static inline bool virtio_features_use_extended(const uint64_t *features)
> 
> "extended" should be abbreviated as "ex" for consistency.

Ok.

Thanks,

Paolo


