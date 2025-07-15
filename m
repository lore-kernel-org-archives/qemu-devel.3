Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E36AC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZjV-0005fM-7b; Tue, 15 Jul 2025 03:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubZhG-0004Z4-8f
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:03:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubZhC-0004uS-M0
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:03:26 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F6vTWF005302
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 15:57:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+bRDBcd027Jl6j1IgelOV9GiK3y3UJWJS2DK8YOHsAM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752562650; v=1;
 b=BQLK6C9rsZpWo331xiT2pSN9EMbOuae58KK85aevbWlNWJrpeCajiaakguxSMhO8
 9++UckJbs4ZuGFwXk7r4FY5HjCmETFriM1hrltVfD4/lrK/7wh3Nzo9vYej9GO1j
 C06u7u5k4nTxAoKqFJYavfGI4QbPUis0YRh7L+KM/dF7jg31NtfMDammRE+/O+j0
 3JE6Kn6yAChPuS1i/3htsOq6wlHtYOx10eyngguYzokpERUkWA7C3bfptI+NpKPl
 N33IoWbRANMiSzwNeqR21Usa3HFVcWGhMiKSoeVvw3fXs3yfSiFijsD5iSN/rK/Q
 zvT+/p9aSn/o33xQ7oLWeA==
Message-ID: <45e600c7-90f4-4daa-a68b-8da90758b861@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 15:57:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/13] virtio: introduce extended features type
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <8c179f9cd04d6cb5e6f822203c6a057704133386.1752229731.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8c179f9cd04d6cb5e6f822203c6a057704133386.1752229731.git.pabeni@redhat.com>
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

On 2025/07/11 22:02, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio net driver.
> 
> Represent the virtio features bitmask with a fixes size array, and
> introduce a few helpers to help manipulate them.
> 
> Most drivers will keep using only 64 bits features space: use union
> to allow them access the lower part of the extended space without any
> per driver change.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - use a fixed size array for features instead of uint128
>    - use union with u64 to reduce the needed code churn
> ---
>   include/hw/virtio/virtio-features.h | 124 ++++++++++++++++++++++++++++
>   include/hw/virtio/virtio.h          |   7 +-
>   2 files changed, 128 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/virtio/virtio-features.h
> 
> diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
> new file mode 100644
> index 0000000000..cc735f7f81
> --- /dev/null
> +++ b/include/hw/virtio/virtio-features.h
> @@ -0,0 +1,124 @@
> +/*
> + * Virtio features helpers
> + *
> + * Copyright 2025 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef _QEMU_VIRTIO_FEATURES_H
> +#define _QEMU_VIRTIO_FEATURES_H

An identifier prefixed with an underscore and a capital letter is 
reserved and better to avoid. Let's also keep consistent with QEMU_VIRTIO_H.

> +
> +#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
> +#define VIRTIO_FEATURES_PR(f)      f[1], f[0]
> +
> +#define VIRTIO_FEATURES_MAX        128
> +#define VIRTIO_BIT(b)              (1ULL << (b & 0x3f))

Let's use BIT_ULL().

I also think (b % 64) is easier to understand than (b & 0x3f); you may 
refer to BIT_MASK() and BIT_WORD() as prior examples.

> +#define VIRTIO_DWORD(b)            ((b) >> 6)

VIRTIO_FEATURES_PR() and VIRTIO_BIT() should have parentheses around 
their parameters as VIRTIO_DWORD() does.

> +#define VIRTIO_FEATURES_WORDS     (VIRTIO_FEATURES_MAX >> 5)

This macro is misaligned; personally I prefer just use one whitespace to 
delimit the macro name and value to avoid the trouble of aligning them 
and polluting "git blame".

> +#define VIRTIO_FEATURES_DWORDS      (VIRTIO_FEATURES_WORDS >> 1)
> +
> +#define VIRTIO_DECLARE_FEATURES(name)                        \
> +    union {                                                  \
> +        uint64_t name;                                       \
> +        uint64_t name##_array[VIRTIO_FEATURES_DWORDS];       \
> +    }
> +
> +static inline void virtio_features_clear(uint64_t *features)
> +{
> +    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
> +{
> +    virtio_features_clear(features);
> +    features[0] = from;
> +}
> +
> +static inline bool virtio_has_feature_ex(const uint64_t *features,
> +                                         unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    return features[VIRTIO_DWORD(fbit)] & VIRTIO_BIT(fbit);
> +}
> +
> +static inline void virtio_add_feature_ex(uint64_t *features,
> +                                         unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    features[VIRTIO_DWORD(fbit)] |= VIRTIO_BIT(fbit);
> +}
> +
> +static inline void virtio_clear_feature_ex(uint64_t *features,
> +                                           unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    features[VIRTIO_DWORD(fbit)] &= ~VIRTIO_BIT(fbit);
> +}
> +
> +static inline bool virtio_features_equal(const uint64_t *f1,
> +                                         const uint64_t *f2)
> +{
> +    uint64_t diff = 0;
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i) {
> +        diff |= f1[i] ^ f2[i];
> +    }
> +    return !!diff;

Let's use memcmp().

> +}
> +
> +static inline bool virtio_features_use_extended(const uint64_t *features)
> +{
> +    int i;
> +
> +    for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i) {
> +        if (features[i]) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static inline bool virtio_features_is_empty(const uint64_t *features)

Let's follow bitmap_empty() and omit "is".

> +{
> +    return !virtio_features_use_extended(features) && !features[0];
> +}
> +
> +static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
> +{
> +    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_andnot(uint64_t *to, const uint64_t *f1,
> +                                           const uint64_t *f2)
> +{
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] & ~f2[i];
> +    }
> +}
> +
> +static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
> +                                       const uint64_t *f2)
> +{
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] & f2[i];
> +    }
> +}
> +
> +static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
> +                                       const uint64_t *f2)
> +{
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] | f2[i];
> +    }
> +}
> +
> +#endif
> +
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 214d4a77e9..0d1eb20489 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -16,6 +16,7 @@
>   
>   #include "system/memory.h"
>   #include "hw/qdev-core.h"
> +#include "hw/virtio/virtio-features.h"
>   #include "net/net.h"
>   #include "migration/vmstate.h"
>   #include "qemu/event_notifier.h"
> @@ -121,9 +122,9 @@ struct VirtIODevice
>        * backend (e.g. vhost) and could potentially be a subset of the
>        * total feature set offered by QEMU.
>        */
> -    uint64_t host_features;
> -    uint64_t guest_features;
> -    uint64_t backend_features;
> +    VIRTIO_DECLARE_FEATURES(host_features);
> +    VIRTIO_DECLARE_FEATURES(guest_features);
> +    VIRTIO_DECLARE_FEATURES(backend_features);
>   
>       size_t config_len;
>       void *config;


