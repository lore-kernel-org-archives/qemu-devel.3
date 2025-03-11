Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7584DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts15w-0001uS-29; Tue, 11 Mar 2025 11:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts15r-0001u9-Ea
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:00:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts15m-0007u9-Co
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:00:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso2770987f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741705224; x=1742310024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+VavorE6dIvHLAiezZf4MxdRYbIvW6WRULkvUnzAqY=;
 b=Y+LTUr5qnc37k3nxmkcow4aGbzCACV8xq7HTIDlXW8HNNwdLufW0y2XZscf8zF4EaG
 xAWxtpLiWw2i2CnRPW3F788vAQQ0luZLf6rz5x4pABUIT3RRGSiXCPvtwflfer05NjWH
 Dn+hya4nvOh75V8uBAoH37cQkOH8H60u6MTOewxITLytrRhhVhkX9MfQAM0XY2JwN/lG
 Tday02kRuUW5M7DfJbz962Vi8EJ9GzPBDvjWUZOWJIHn/smxBiKJAnkTC1eEDxT47YvW
 bYz7olyxhJiL/TVuBV02vCE2jswlwZf0P0YPlhhb7LTag2qK7VnpnW/HqFJkR4OBrLog
 egtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741705224; x=1742310024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+VavorE6dIvHLAiezZf4MxdRYbIvW6WRULkvUnzAqY=;
 b=D8fennYHQsxRy0/YvniMn00tOWVZeX9SuhCiuwIxn9aSDN4DVdXLySxNWgONsi+p3Q
 5E1Jca7Z6XDoB4LR/bQPFltIskd9vA9k0rjELXYVTWCO0B2bWYEM4Xvh5YOYn8mDnCJ9
 itxy9lfDnfnT5XKo4yVU90p3XVJSC9p9xTYse7oKeZ4euwWGyxl0UEQ/nmHh/5Yu3C0J
 dgDKdYTrSdqWQatFncFn/YmomAWJjerO17OHkQFVurfzYctLxBMWCdLQLAUmUslLH/uq
 jy2+g3IEMSObKEz3mWNxsQzkgbOnZsw5az4iZ8ad4DFKDfTw+2zM/7r9+v4COQvE+EVZ
 tB3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGCZW+fNq4HXZ5TtraRV9ChEaDLLi039Z2Y5X7RmZd0MmD7J6RyzYjoVcdu1Vkmx0Xmoq75Y0QXYK@nongnu.org
X-Gm-Message-State: AOJu0YzQ5/RCXyZUW/wFmgVF3fAYU0lEH8Ic5nChtnhAheKLdjtuJqLK
 PBg+Hwb2X4YPU1zCF7QTHCJbs6LZeuUczdcA+Wi5QgX3ZKBvao7SPaBYxoRrKTI=
X-Gm-Gg: ASbGncsao+68fu8V+2pXy4GCwrT1uEMIUpcAiapVSLmzI49FprzAlgySc7YYjHPDYFF
 4JXE99oSVzO90OV3HLoOn5ZSByPplCffLJzag3dQbTYVXJyAlYgi2c2cn6YTYjostSSwI9hzvCD
 qzSQPG3lmzX17SdXPeE72+m8JzgtLaMtcl1hqDzxQHWigw/2l5SfSMkimynk+BjKLPRuAUv2DfE
 XrreFvHnPXxEBIqVOEaYuIFMHonHTup4boRKyTI0LtqlWnHfaBp5Xin5u0zNpahL8kgB/+1/p7h
 YDnDxQCA6nHLNmG0zvES1Ku96j6Db0lMknB0qOhOJJeHBxMQ5e1CB+wOFsA4m5lqeZbVSZukS+7
 KTeF3z6whA0aL
X-Google-Smtp-Source: AGHT+IF8BhytmPgEyCSXsKzBykvQGtFUXjTpqUpsfqdq6FN6F1eCwW7zvilmqD/6iva9bsSt+jLrvQ==
X-Received: by 2002:a05:6000:18a2:b0:391:4684:dbef with SMTP id
 ffacd0b85a97d-3914684de0bmr7499840f8f.17.1741705222008; 
 Tue, 11 Mar 2025 08:00:22 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdb9sm18222625f8f.27.2025.03.11.08.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:00:20 -0700 (PDT)
Message-ID: <a140cfae-261e-4d78-985c-efbad93b7a9d@linaro.org>
Date: Tue, 11 Mar 2025 16:00:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/10] Add Hyper-V Dynamic Memory Protocol driver
 (hv-balloon) base
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
 <0d9e8c0b670b7856d36ed155d43548d2491230e7.1699279190.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0d9e8c0b670b7856d36ed155d43548d2491230e7.1699279190.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Maciej,

On 6/11/23 15:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This driver is like virtio-balloon on steroids: it allows both changing the
> guest memory allocation via ballooning and (in the next patch) inserting
> pieces of extra RAM into it on demand from a provided memory backend.
> 
> The actual resizing is done via ballooning interface (for example, via
> the "balloon" HMP command).
> This includes resizing the guest past its boot size - that is, hot-adding
> additional memory in granularity limited only by the guest alignment
> requirements, as provided by the next patch.
> 
> In contrast with ACPI DIMM hotplug where one can only request to unplug a
> whole DIMM stick this driver allows removing memory from guest in single
> page (4k) units via ballooning.
> 
> After a VM reboot the guest is back to its original (boot) size.
> 
> In the future, the guest boot memory size might be changed on reboot
> instead, taking into account the effective size that VM had before that
> reboot (much like Hyper-V does).
> 
> For performance reasons, the guest-released memory is tracked in a few
> range trees, as a series of (start, count) ranges.
> Each time a new page range is inserted into such tree its neighbors are
> checked as candidates for possible merging with it.
> 
> Besides performance reasons, the Dynamic Memory protocol itself uses page
> ranges as the data structure in its messages, so relevant pages need to be
> merged into such ranges anyway.
> 
> One has to be careful when tracking the guest-released pages, since the
> guest can maliciously report returning pages outside its current address
> space, which later clash with the address range of newly added memory.
> Similarly, the guest can report freeing the same page twice.
> 
> The above design results in much better ballooning performance than when
> using virtio-balloon with the same guest: 230 GB / minute with this driver
> versus 70 GB / minute with virtio-balloon.
> 
> During a ballooning operation most of time is spent waiting for the guest
> to come up with newly freed page ranges, processing the received ranges on
> the host side (in QEMU and KVM) is nearly instantaneous.
> 
> The unballoon operation is also pretty much instantaneous:
> thanks to the merging of the ballooned out page ranges 200 GB of memory can
> be returned to the guest in about 1 second.
> With virtio-balloon this operation takes about 2.5 minutes.
> 
> These tests were done against a Windows Server 2019 guest running on a
> Xeon E5-2699, after dirtying the whole memory inside guest before each
> balloon operation.
> 
> Using a range tree instead of a bitmap to track the removed memory also
> means that the solution scales well with the guest size: even a 1 TB range
> takes just a few bytes of such metadata.
> 
> Since the required GTree operations aren't present in every Glib version
> a check for them was added to the meson build script, together with new
> "--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
> If these GTree operations are missing in the system's Glib version this
> driver will be skipped during QEMU build.
> 
> An optional "status-report=on" device parameter requests memory status
> events from the guest (typically sent every second), which allow the host
> to learn both the guest memory available and the guest memory in use
> counts.
> 
> Following commits will add support for their external emission as
> "HV_BALLOON_STATUS_REPORT" QMP events.
> 
> The driver is named hv-balloon since the Linux kernel client driver for
> the Dynamic Memory Protocol is named as such and to follow the naming
> pattern established by the virtio-balloon driver.
> The whole protocol runs over Hyper-V VMBus.
> 
> The driver was tested against Windows Server 2012 R2, Windows Server 2016
> and Windows Server 2019 guests and obeys the guest alignment requirements
> reported to the host via DM_CAPABILITIES_REPORT message.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   Kconfig.host                           |    3 +
>   hw/hyperv/Kconfig                      |   10 +
>   hw/hyperv/hv-balloon-internal.h        |   33 +
>   hw/hyperv/hv-balloon-page_range_tree.c |  228 +++++
>   hw/hyperv/hv-balloon-page_range_tree.h |  118 +++
>   hw/hyperv/hv-balloon.c                 | 1160 ++++++++++++++++++++++++
>   hw/hyperv/meson.build                  |    1 +
>   hw/hyperv/trace-events                 |   13 +
>   include/hw/hyperv/hv-balloon.h         |   18 +
>   meson.build                            |   28 +-
>   meson_options.txt                      |    2 +
>   scripts/meson-buildoptions.sh          |    3 +
>   12 files changed, 1616 insertions(+), 1 deletion(-)
>   create mode 100644 hw/hyperv/hv-balloon-internal.h
>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
>   create mode 100644 hw/hyperv/hv-balloon.c
>   create mode 100644 include/hw/hyperv/hv-balloon.h
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index d763d892693c..2ee71578f38f 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -46,3 +46,6 @@ config FUZZ
>   config VFIO_USER_SERVER_ALLOWED
>       bool
>       imply VFIO_USER_SERVER
> +
> +config HV_BALLOON_POSSIBLE
> +    bool
> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
> index fcf65903bd05..41dd827c841b 100644
> --- a/hw/hyperv/Kconfig
> +++ b/hw/hyperv/Kconfig
> @@ -16,3 +16,13 @@ config SYNDBG
>       bool
>       default y
>       depends on VMBUS
> +
> +config HV_BALLOON_SUPPORTED
> +    bool
> +
> +config HV_BALLOON
> +    bool
> +    default y
> +    depends on VMBUS
> +    depends on HV_BALLOON_POSSIBLE

Where is HV_BALLOON_POSSIBLE set?

> +    depends on HV_BALLOON_SUPPORTED
> diff --git a/hw/hyperv/hv-balloon-internal.h b/hw/hyperv/hv-balloon-internal.h
> new file mode 100644
> index 000000000000..164c2e582539
> --- /dev/null
> +++ b/hw/hyperv/hv-balloon-internal.h
> @@ -0,0 +1,33 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_HYPERV_HV_BALLOON_INTERNAL_H
> +#define HW_HYPERV_HV_BALLOON_INTERNAL_H
> +
> +#include "qemu/osdep.h"
> +
> +#define HV_BALLOON_PFN_SHIFT 12
> +#define HV_BALLOON_PAGE_SIZE (1 << HV_BALLOON_PFN_SHIFT)
> +
> +#define SUM_OVERFLOW_U64(in1, in2) ((in1) > UINT64_MAX - (in2))
> +#define SUM_SATURATE_U64(in1, in2)              \
> +    ({                                          \
> +        uint64_t _in1 = (in1), _in2 = (in2);    \
> +        uint64_t _result;                       \
> +                                                \
> +        if (!SUM_OVERFLOW_U64(_in1, _in2)) {    \
> +            _result = _in1 + _in2;              \
> +        } else {                                \
> +            _result = UINT64_MAX;               \
> +        }                                       \
> +                                                \
> +        _result;                                \
> +    })
> +
> +#endif
> diff --git a/hw/hyperv/hv-balloon-page_range_tree.c b/hw/hyperv/hv-balloon-page_range_tree.c
> new file mode 100644
> index 000000000000..e178d8b413c7
> --- /dev/null
> +++ b/hw/hyperv/hv-balloon-page_range_tree.c
> @@ -0,0 +1,228 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "hv-balloon-internal.h"
> +#include "hv-balloon-page_range_tree.h"
> +
> +/*
> + * temporarily avoid warnings about enhanced GTree API usage requiring a
> + * too recent Glib version until GLIB_VERSION_MAX_ALLOWED finally reaches
> + * the Glib version with this API
> + */
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
> +/* PageRangeTree */
> +static gint page_range_tree_key_compare(gconstpointer leftp,
> +                                        gconstpointer rightp,
> +                                        gpointer user_data)
> +{
> +    const uint64_t *left = leftp, *right = rightp;
> +
> +    if (*left < *right) {
> +        return -1;
> +    } else if (*left > *right) {
> +        return 1;
> +    } else { /* *left == *right */
> +        return 0;
> +    }
> +}
> +
> +static GTreeNode *page_range_tree_insert_new(PageRangeTree tree,
> +                                             uint64_t start, uint64_t count)
> +{
> +    uint64_t *key = g_malloc(sizeof(*key));
> +    PageRange *range = g_malloc(sizeof(*range));
> +
> +    assert(count > 0);
> +
> +    *key = range->start = start;
> +    range->count = count;
> +
> +    return g_tree_insert_node(tree.t, key, range);
> +}
> +
> +void hvb_page_range_tree_insert(PageRangeTree tree,
> +                                uint64_t start, uint64_t count,
> +                                uint64_t *dupcount)
> +{
> +    GTreeNode *node;
> +    bool joinable;
> +    uint64_t intersection;
> +    PageRange *range;
> +
> +    assert(!SUM_OVERFLOW_U64(start, count));
> +    if (count == 0) {
> +        return;
> +    }
> +
> +    node = g_tree_upper_bound(tree.t, &start);
> +    if (node) {
> +        node = g_tree_node_previous(node);
> +    } else {
> +        node = g_tree_node_last(tree.t);
> +    }
> +
> +    if (node) {
> +        range = g_tree_node_value(node);
> +        assert(range);
> +        intersection = page_range_intersection_size(range, start, count);
> +        joinable = page_range_joinable_right(range, start, count);
> +    }
> +
> +    if (!node ||
> +        (!intersection && !joinable)) {
> +        /*
> +         * !node case: the tree is empty or the very first node in the tree
> +         * already has a higher key (the start of its range).
> +         * the other case: there is a gap in the tree between the new range
> +         * and the previous one.
> +         * anyway, let's just insert the new range into the tree.
> +         */
> +        node = page_range_tree_insert_new(tree, start, count);
> +        assert(node);
> +        range = g_tree_node_value(node);
> +        assert(range);
> +    } else {
> +        /*
> +         * the previous range in the tree either partially covers the new
> +         * range or ends just at its beginning - extend it
> +         */
> +        if (dupcount) {
> +            *dupcount += intersection;
> +        }
> +
> +        count += start - range->start;
> +        range->count = MAX(range->count, count);
> +    }
> +
> +    /* check next nodes for possible merging */
> +    for (node = g_tree_node_next(node); node; ) {
> +        PageRange *rangecur;
> +
> +        rangecur = g_tree_node_value(node);
> +        assert(rangecur);
> +
> +        intersection = page_range_intersection_size(rangecur,
> +                                                    range->start, range->count);
> +        joinable = page_range_joinable_left(rangecur,
> +                                            range->start, range->count);
> +        if (!intersection && !joinable) {
> +            /* the current node is disjoint */
> +            break;
> +        }
> +
> +        if (dupcount) {
> +            *dupcount += intersection;
> +        }
> +
> +        count = rangecur->count + (rangecur->start - range->start);
> +        range->count = MAX(range->count, count);
> +
> +        /* the current node was merged in, remove it */
> +        start = rangecur->start;
> +        node = g_tree_node_next(node);
> +        /* no hinted removal in GTree... */
> +        g_tree_remove(tree.t, &start);
> +    }
> +}
> +
> +bool hvb_page_range_tree_pop(PageRangeTree tree, PageRange *out,
> +                             uint64_t maxcount)
> +{
> +    GTreeNode *node;
> +    PageRange *range;
> +
> +    node = g_tree_node_last(tree.t);
> +    if (!node) {
> +        return false;
> +    }
> +
> +    range = g_tree_node_value(node);
> +    assert(range);
> +
> +    out->start = range->start;
> +
> +    /* can't modify range->start as it is the node key */
> +    if (range->count > maxcount) {
> +        out->start += range->count - maxcount;
> +        out->count = maxcount;
> +        range->count -= maxcount;
> +    } else {
> +        out->count = range->count;
> +        /* no hinted removal in GTree... */
> +        g_tree_remove(tree.t, &out->start);
> +    }
> +
> +    return true;
> +}
> +
> +bool hvb_page_range_tree_intree_any(PageRangeTree tree,
> +                                    uint64_t start, uint64_t count)
> +{
> +    GTreeNode *node;
> +
> +    if (count == 0) {
> +        return false;
> +    }
> +
> +    /* find the first node that can possibly intersect our range */
> +    node = g_tree_upper_bound(tree.t, &start);
> +    if (node) {
> +        /*
> +         * a NULL node below means that the very first node in the tree
> +         * already has a higher key (the start of its range).
> +         */
> +        node = g_tree_node_previous(node);
> +    } else {
> +        /* a NULL node below means that the tree is empty */
> +        node = g_tree_node_last(tree.t);
> +    }
> +    /* node range start <= range start */
> +
> +    if (!node) {
> +        /* node range start > range start */
> +        node = g_tree_node_first(tree.t);
> +    }
> +
> +    for ( ; node; node = g_tree_node_next(node)) {
> +        PageRange *range = g_tree_node_value(node);
> +
> +        assert(range);
> +        /*
> +         * if this node starts beyond or at the end of our range so does
> +         * every next one
> +         */
> +        if (range->start >= start + count) {
> +            break;
> +        }
> +
> +        if (page_range_intersection_size(range, start, count) > 0) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +void hvb_page_range_tree_init(PageRangeTree *tree)
> +{
> +    tree->t = g_tree_new_full(page_range_tree_key_compare, NULL,
> +                              g_free, g_free);
> +}
> +
> +void hvb_page_range_tree_destroy(PageRangeTree *tree)
> +{
> +    /* g_tree_destroy() is not NULL-safe */
> +    if (!tree->t) {
> +        return;
> +    }
> +
> +    g_tree_destroy(tree->t);
> +    tree->t = NULL;
> +}
> diff --git a/hw/hyperv/hv-balloon-page_range_tree.h b/hw/hyperv/hv-balloon-page_range_tree.h
> new file mode 100644
> index 000000000000..07a9ae0da611
> --- /dev/null
> +++ b/hw/hyperv/hv-balloon-page_range_tree.h
> @@ -0,0 +1,118 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
> +#define HW_HYPERV_HV_BALLOON_PAGE_RANGE_TREE_H
> +
> +#include "qemu/osdep.h"
> +
> +/* PageRange */
> +typedef struct PageRange {
> +    uint64_t start;
> +    uint64_t count;
> +} PageRange;
> +
> +/* return just the part of range before (start) */
> +static inline void page_range_part_before(const PageRange *range,
> +                                          uint64_t start, PageRange *out)
> +{
> +    uint64_t endr = range->start + range->count;
> +    uint64_t end = MIN(endr, start);
> +
> +    out->start = range->start;
> +    if (end > out->start) {
> +        out->count = end - out->start;
> +    } else {
> +        out->count = 0;
> +    }
> +}
> +
> +/* return just the part of range after (start, count) */
> +static inline void page_range_part_after(const PageRange *range,
> +                                         uint64_t start, uint64_t count,
> +                                         PageRange *out)
> +{
> +    uint64_t end = range->start + range->count;
> +    uint64_t ends = start + count;
> +
> +    out->start = MAX(range->start, ends);
> +    if (end > out->start) {
> +        out->count = end - out->start;
> +    } else {
> +        out->count = 0;
> +    }
> +}
> +
> +static inline void page_range_intersect(const PageRange *range,
> +                                        uint64_t start, uint64_t count,
> +                                        PageRange *out)
> +{
> +    uint64_t end1 = range->start + range->count;
> +    uint64_t end2 = start + count;
> +    uint64_t end = MIN(end1, end2);
> +
> +    out->start = MAX(range->start, start);
> +    out->count = out->start < end ? end - out->start : 0;
> +}
> +
> +static inline uint64_t page_range_intersection_size(const PageRange *range,
> +                                                    uint64_t start, uint64_t count)
> +{
> +    PageRange trange;
> +
> +    page_range_intersect(range, start, count, &trange);
> +    return trange.count;
> +}
> +
> +static inline bool page_range_joinable_left(const PageRange *range,
> +                                            uint64_t start, uint64_t count)
> +{
> +    return start + count == range->start;
> +}
> +
> +static inline bool page_range_joinable_right(const PageRange *range,
> +                                             uint64_t start, uint64_t count)
> +{
> +    return range->start + range->count == start;
> +}
> +
> +static inline bool page_range_joinable(const PageRange *range,
> +                                       uint64_t start, uint64_t count)
> +{
> +    return page_range_joinable_left(range, start, count) ||
> +        page_range_joinable_right(range, start, count);
> +}
> +
> +/* PageRangeTree */
> +/* type safety */
> +typedef struct PageRangeTree {
> +    GTree *t;
> +} PageRangeTree;
> +
> +static inline bool page_range_tree_is_empty(PageRangeTree tree)
> +{
> +    guint nnodes = g_tree_nnodes(tree.t);
> +
> +    return nnodes == 0;
> +}
> +
> +void hvb_page_range_tree_init(PageRangeTree *tree);
> +void hvb_page_range_tree_destroy(PageRangeTree *tree);
> +
> +bool hvb_page_range_tree_intree_any(PageRangeTree tree,
> +                                    uint64_t start, uint64_t count);
> +
> +bool hvb_page_range_tree_pop(PageRangeTree tree, PageRange *out,
> +                             uint64_t maxcount);
> +
> +void hvb_page_range_tree_insert(PageRangeTree tree,
> +                                uint64_t start, uint64_t count,
> +                                uint64_t *dupcount);
> +
> +#endif
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> new file mode 100644
> index 000000000000..5f3674ba0642
> --- /dev/null
> +++ b/hw/hyperv/hv-balloon.c
> @@ -0,0 +1,1160 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "hv-balloon-internal.h"
> +
> +#include "exec/address-spaces.h"
> +#include "exec/cpu-common.h"
> +#include "exec/ramblock.h"
> +#include "hw/boards.h"
> +#include "hw/hyperv/dynmem-proto.h"
> +#include "hw/hyperv/hv-balloon.h"
> +#include "hw/hyperv/vmbus.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/qdev-core.h"
> +#include "hw/qdev-properties.h"
> +#include "monitor/qdev.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "qapi/qapi-events-machine.h"
> +#include "qapi/qapi-types-machine.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/visitor.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "qemu/timer.h"
> +#include "sysemu/balloon.h"
> +#include "sysemu/hostmem.h"
> +#include "sysemu/reset.h"
> +#include "hv-balloon-page_range_tree.h"
> +#include "trace.h"
> +
> +#define HV_BALLOON_GUID "525074DC-8985-46e2-8057-A307DC18A502"
> +
> +/*
> + * Some Windows versions (at least Server 2019) will crash with various
> + * error codes when receiving DM protocol requests (at least
> + * DM_MEM_HOT_ADD_REQUEST) immediately after boot.
> + *
> + * It looks like Hyper-V from Server 2016 uses a 50-second after-boot
> + * delay, probably to workaround this issue, so we'll use this value, too.
> + */
> +#define HV_BALLOON_POST_INIT_WAIT (50 * 1000)
> +
> +#define HV_BALLOON_HA_CHUNK_SIZE (2 * GiB)
> +#define HV_BALLOON_HA_CHUNK_PAGES (HV_BALLOON_HA_CHUNK_SIZE / HV_BALLOON_PAGE_SIZE)
> +
> +#define HV_BALLOON_HR_CHUNK_PAGES 585728
> +/*
> + *                                ^ that's the maximum number of pages
> + * that Windows returns in one hot remove response
> + *
> + * If the number requested is too high Windows will no longer honor
> + * these requests
> + */
> +
> +struct HvBalloonClass {
> +    VMBusDeviceClass parent_class;
> +} HvBalloonClass;
> +
> +typedef enum State {
> +    /* not a real state */
> +    S_NO_CHANGE = 0,
> +
> +    S_WAIT_RESET,
> +    S_POST_RESET_CLOSED,
> +
> +    /* init flow */
> +    S_VERSION,
> +    S_CAPS,
> +    S_POST_INIT_WAIT,
> +
> +    S_IDLE,
> +
> +    /* balloon op flow */
> +    S_BALLOON_POSTING,
> +    S_BALLOON_RB_WAIT,
> +    S_BALLOON_REPLY_WAIT,
> +
> +    /* unballoon + hot add ops flow */
> +    S_UNBALLOON_POSTING,
> +    S_UNBALLOON_RB_WAIT,
> +    S_UNBALLOON_REPLY_WAIT,
> +} State;
> +
> +typedef struct StateDesc {
> +    State state;
> +    const char *desc;
> +} StateDesc;
> +
> +typedef struct HvBalloon {
> +    VMBusDevice parent;
> +    State state;
> +
> +    union dm_version version;
> +    union dm_caps caps;
> +
> +    QEMUTimer post_init_timer;
> +
> +    unsigned int trans_id;
> +
> +    struct {
> +        bool enabled;
> +        bool received;
> +        uint64_t committed;
> +        uint64_t available;
> +    } status_report;
> +
> +    /* Guest target size */
> +    uint64_t target;
> +    bool target_changed;
> +
> +    /* Current (un)balloon */
> +    union {
> +        uint64_t balloon_diff;
> +
> +        struct {
> +            uint64_t unballoon_diff;
> +        };
> +    };
> +
> +    /* Nominal size of each memslot (the last one might be smaller) */
> +    uint64_t memslot_size;
> +
> +    PageRangeTree removed_guest, removed_both;
> +
> +    uint64_t removed_guest_ctr, removed_both_ctr;
> +} HvBalloon;
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, HV_BALLOON, VMBUS_DEVICE, \
> +                                   { })
> +
> +#define HV_BALLOON_SET_STATE(hvb, news)             \
> +    do {                                            \
> +        assert(news != S_NO_CHANGE);                \
> +        hv_balloon_state_set(hvb, news, # news);    \
> +    } while (0)
> +
> +#define HV_BALLOON_STATE_DESC_SET(stdesc, news)         \
> +    _hv_balloon_state_desc_set(stdesc, news, # news)
> +
> +#define HV_BALLOON_STATE_DESC_INIT \
> +    {                              \
> +        .state = S_NO_CHANGE,      \
> +    }
> +
> +typedef struct HvBalloonReq {
> +    VMBusChanReq vmreq;
> +} HvBalloonReq;
> +
> +/* TODO: unify the code below with virtio-balloon and cache the value */
> +static int build_dimm_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> +        DeviceState *dev = DEVICE(obj);
> +        if (dev->realized) { /* only realized DIMMs matter */
> +            *list = g_slist_prepend(*list, dev);
> +        }
> +    }
> +
> +    object_child_foreach(obj, build_dimm_list, opaque);
> +    return 0;
> +}
> +
> +static ram_addr_t get_current_ram_size(void)
> +{
> +    GSList *list = NULL, *item;
> +    ram_addr_t size = current_machine->ram_size;
> +
> +    build_dimm_list(qdev_get_machine(), &list);
> +    for (item = list; item; item = g_slist_next(item)) {
> +        Object *obj = OBJECT(item->data);
> +        if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM))
> +            size += object_property_get_int(obj, PC_DIMM_SIZE_PROP,
> +                                            &error_abort);
> +    }
> +    g_slist_free(list);
> +
> +    return size;
> +}
> +
> +/* total RAM includes memory currently removed from the guest */
> +static uint64_t hv_balloon_total_ram(HvBalloon *balloon)
> +{
> +    ram_addr_t ram_size = get_current_ram_size();
> +    uint64_t ram_size_pages = ram_size >> HV_BALLOON_PFN_SHIFT;
> +
> +    assert(ram_size_pages > 0);
> +
> +    return ram_size_pages;
> +}
> +
> +/*
> + * calculating the total RAM size is a slow operation,
> + * avoid it as much as possible
> + */
> +static uint64_t hv_balloon_total_removed_rs(HvBalloon *balloon,
> +                                            uint64_t ram_size_pages)
> +{
> +    uint64_t total_removed;
> +
> +    total_removed = SUM_SATURATE_U64(balloon->removed_guest_ctr,
> +                                     balloon->removed_both_ctr);
> +
> +    /* possible if guest returns pages outside actual RAM */
> +    if (total_removed > ram_size_pages) {
> +        total_removed = ram_size_pages;
> +    }
> +
> +    return total_removed;
> +}
> +
> +/* Returns whether the state has actually changed */
> +static bool hv_balloon_state_set(HvBalloon *balloon,
> +                                 State newst, const char *newststr)
> +{
> +    if (newst == S_NO_CHANGE || balloon->state == newst) {
> +        return false;
> +    }
> +
> +    balloon->state = newst;
> +    trace_hv_balloon_state_change(newststr);
> +    return true;
> +}
> +
> +static void _hv_balloon_state_desc_set(StateDesc *stdesc,
> +                                       State newst, const char *newststr)
> +{
> +    /* state setting is only permitted on a freshly init desc */
> +    assert(stdesc->state == S_NO_CHANGE);
> +
> +    assert(newst != S_NO_CHANGE);
> +
> +    stdesc->state = newst;
> +    stdesc->desc = newststr;
> +}
> +
> +static VMBusChannel *hv_balloon_get_channel_maybe(HvBalloon *balloon)
> +{
> +    return vmbus_device_channel(&balloon->parent, 0);
> +}
> +
> +static VMBusChannel *hv_balloon_get_channel(HvBalloon *balloon)
> +{
> +    VMBusChannel *chan;
> +
> +    chan = hv_balloon_get_channel_maybe(balloon);
> +    assert(chan != NULL);
> +    return chan;
> +}
> +
> +static ssize_t hv_balloon_send_packet(VMBusChannel *chan,
> +                                      struct dm_message *msg)
> +{
> +    int ret;
> +
> +    ret = vmbus_channel_reserve(chan, 0, msg->hdr.size);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
> +                              NULL, 0, msg, msg->hdr.size, false,
> +                              msg->hdr.trans_id);
> +}
> +
> +static bool hv_balloon_unballoon_get_source(HvBalloon *balloon,
> +                                            PageRangeTree *dtree,
> +                                            uint64_t **dctr)
> +{
> +    if (g_tree_nnodes(balloon->removed_guest.t) > 0) {
> +        *dtree = balloon->removed_guest;
> +        *dctr = &balloon->removed_guest_ctr;
> +    } else if (g_tree_nnodes(balloon->removed_both.t) > 0) {
> +        *dtree = balloon->removed_both;
> +        *dctr = &balloon->removed_both_ctr;
> +    } else {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void hv_balloon_unballoon_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    VMBusChannel *chan = hv_balloon_get_channel(balloon);
> +    struct dm_unballoon_request *ur;
> +    size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
> +
> +    assert(balloon->state == S_UNBALLOON_RB_WAIT);
> +
> +    if (vmbus_channel_reserve(chan, 0, ur_size) < 0) {
> +        return;
> +    }
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_POSTING);
> +}
> +
> +static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    VMBusChannel *chan = hv_balloon_get_channel(balloon);
> +    PageRangeTree dtree;
> +    uint64_t *dctr;
> +    struct dm_unballoon_request *ur;
> +    size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
> +    PageRange range;
> +    bool bret;
> +    ssize_t ret;
> +
> +    assert(balloon->state == S_UNBALLOON_POSTING);
> +    assert(balloon->unballoon_diff > 0);
> +
> +    if (!hv_balloon_unballoon_get_source(balloon, &dtree, &dctr)) {
> +        error_report("trying to unballoon but nothing seems to be ballooned");
> +        /*
> +         * there is little we can do as we might have already
> +         * sent the guest a partial request we can't cancel
> +         */
> +        return;
> +    }
> +
> +    assert(dtree.t);
> +    assert(dctr);
> +
> +    ur = alloca(ur_size);
> +    memset(ur, 0, ur_size);
> +    ur->hdr.type = DM_UNBALLOON_REQUEST;
> +    ur->hdr.size = ur_size;
> +    ur->hdr.trans_id = balloon->trans_id;
> +
> +    bret = hvb_page_range_tree_pop(dtree, &range, MIN(balloon->unballoon_diff,
> +                                                      HV_BALLOON_HA_CHUNK_PAGES));
> +    assert(bret);
> +    /* TODO: madvise? */
> +
> +    *dctr -= range.count;
> +    balloon->unballoon_diff -= range.count;
> +
> +    ur->range_count = 1;
> +    ur->range_array[0].finfo.start_page = range.start;
> +    ur->range_array[0].finfo.page_cnt = range.count;
> +    ur->more_pages = balloon->unballoon_diff > 0;
> +
> +    trace_hv_balloon_outgoing_unballoon(ur->hdr.trans_id,
> +                                        range.count, range.start,
> +                                        balloon->unballoon_diff);
> +
> +    if (ur->more_pages) {
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_RB_WAIT);
> +    } else {
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_REPLY_WAIT);
> +    }
> +
> +    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
> +                             NULL, 0, ur, ur_size, false,
> +                             ur->hdr.trans_id);
> +    if (ret <= 0) {
> +        error_report("error %zd when posting unballoon msg, expect problems",
> +                     ret);
> +    }
> +}
> +
> +static void hv_balloon_balloon_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    VMBusChannel *chan = hv_balloon_get_channel(balloon);
> +    size_t bl_size = sizeof(struct dm_balloon);
> +
> +    assert(balloon->state == S_BALLOON_RB_WAIT);
> +
> +    if (vmbus_channel_reserve(chan, 0, bl_size) < 0) {
> +        return;
> +    }
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_POSTING);
> +}
> +
> +static void hv_balloon_balloon_posting(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    VMBusChannel *chan = hv_balloon_get_channel(balloon);
> +    struct dm_balloon bl;
> +    size_t bl_size = sizeof(bl);
> +    ssize_t ret;
> +
> +    assert(balloon->state == S_BALLOON_POSTING);
> +    assert(balloon->balloon_diff > 0);
> +
> +    memset(&bl, 0, sizeof(bl));
> +    bl.hdr.type = DM_BALLOON_REQUEST;
> +    bl.hdr.size = bl_size;
> +    bl.hdr.trans_id = balloon->trans_id;
> +    bl.num_pages = MIN(balloon->balloon_diff, HV_BALLOON_HR_CHUNK_PAGES);
> +
> +    trace_hv_balloon_outgoing_balloon(bl.hdr.trans_id, bl.num_pages,
> +                                      balloon->balloon_diff);
> +
> +    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
> +                             NULL, 0, &bl, bl_size, false,
> +                             bl.hdr.trans_id);
> +    if (ret <= 0) {
> +        error_report("error %zd when posting balloon msg, expect problems",
> +                     ret);
> +    }
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_REPLY_WAIT);
> +}
> +
> +static void hv_balloon_idle_state_process_target(HvBalloon *balloon,
> +                                                 StateDesc *stdesc)
> +{
> +    bool can_balloon = balloon->caps.cap_bits.balloon;
> +    uint64_t ram_size_pages, total_removed;
> +
> +    ram_size_pages = hv_balloon_total_ram(balloon);
> +    total_removed = hv_balloon_total_removed_rs(balloon, ram_size_pages);
> +
> +    /*
> +     * we need to cache the values computed from the balloon target value when
> +     * starting the adjustment procedure in case someone changes the target when
> +     * the procedure is in progress
> +     */
> +    if (balloon->target > ram_size_pages - total_removed) {
> +        uint64_t target_diff = balloon->target -
> +            (ram_size_pages - total_removed);
> +
> +        balloon->unballoon_diff = MIN(target_diff, total_removed);
> +
> +        if (balloon->unballoon_diff > 0) {
> +            assert(can_balloon);
> +            HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_RB_WAIT);
> +        }
> +    } else if (can_balloon &&
> +               balloon->target < ram_size_pages - total_removed) {
> +        balloon->balloon_diff = ram_size_pages - total_removed -
> +            balloon->target;
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_RB_WAIT);
> +    }
> +}
> +
> +static void hv_balloon_idle_state(HvBalloon *balloon,
> +                                  StateDesc *stdesc)
> +{
> +    assert(balloon->state == S_IDLE);
> +
> +    if (balloon->target_changed) {
> +        balloon->target_changed = false;
> +        hv_balloon_idle_state_process_target(balloon, stdesc);
> +        return;
> +    }
> +}
> +
> +static const struct {
> +    void (*handler)(HvBalloon *balloon, StateDesc *stdesc);
> +} state_handlers[] = {
> +    [S_IDLE].handler = hv_balloon_idle_state,
> +    [S_BALLOON_POSTING].handler = hv_balloon_balloon_posting,
> +    [S_BALLOON_RB_WAIT].handler = hv_balloon_balloon_rb_wait,
> +    [S_UNBALLOON_POSTING].handler = hv_balloon_unballoon_posting,
> +    [S_UNBALLOON_RB_WAIT].handler = hv_balloon_unballoon_rb_wait,
> +};
> +
> +static void hv_balloon_handle_state(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    if (balloon->state >= ARRAY_SIZE(state_handlers) ||
> +        !state_handlers[balloon->state].handler) {
> +        return;
> +    }
> +
> +    state_handlers[balloon->state].handler(balloon, stdesc);
> +}
> +
> +static void hv_balloon_remove_response_insert_range(PageRangeTree tree,
> +                                                    const PageRange *range,
> +                                                    uint64_t *ctr1,
> +                                                    uint64_t *ctr2,
> +                                                    uint64_t *ctr3)
> +{
> +    uint64_t dupcount, effcount;
> +
> +    if (range->count == 0) {
> +        return;
> +    }
> +
> +    dupcount = 0;
> +    hvb_page_range_tree_insert(tree, range->start, range->count, &dupcount);
> +
> +    assert(dupcount <= range->count);
> +    effcount = range->count - dupcount;
> +
> +    *ctr1 += effcount;
> +    *ctr2 += effcount;
> +    if (ctr3) {
> +        *ctr3 += effcount;
> +    }
> +}
> +
> +static void hv_balloon_remove_response_handle_range(HvBalloon *balloon,
> +                                                    PageRange *range,
> +                                                    bool both,
> +                                                    uint64_t *removedctr)
> +{
> +    PageRangeTree globaltree =
> +        both ? balloon->removed_both : balloon->removed_guest;
> +    uint64_t *globalctr =
> +        both ? &balloon->removed_both_ctr : &balloon->removed_guest_ctr;
> +
> +    trace_hv_balloon_remove_response(range->count, range->start, both);
> +
> +    if (range->count > 0) {
> +        hv_balloon_remove_response_insert_range(globaltree, range,
> +                                                globalctr, removedctr, NULL);
> +        trace_hv_balloon_remove_response_remainder(range->count, range->start,
> +                                                   both);
> +        range->count = 0;
> +    }
> +}
> +
> +static void hv_balloon_remove_response_handle_pages(HvBalloon *balloon,
> +                                                    PageRange *range,
> +                                                    uint64_t start,
> +                                                    uint64_t count,
> +                                                    bool both,
> +                                                    uint64_t *removedctr)
> +{
> +    assert(count > 0);
> +
> +    /*
> +     * if there is an existing range that the new range can't be joined to
> +     * dump it into tree(s)
> +     */
> +    if (range->count > 0 && !page_range_joinable(range, start, count)) {
> +        hv_balloon_remove_response_handle_range(balloon, range, both,
> +                                                removedctr);
> +    }
> +
> +    if (range->count == 0) {
> +        range->start = start;
> +        range->count = count;
> +    } else if (page_range_joinable_left(range, start, count)) {
> +        range->start = start;
> +        range->count += count;
> +    } else { /* page_range_joinable_right() */
> +        range->count += count;
> +    }
> +}
> +
> +static gboolean hv_balloon_handle_remove_host_addr_node(gpointer key,
> +                                                        gpointer value,
> +                                                        gpointer data)
> +{
> +    PageRange *range = value;
> +    uint64_t pageoff;
> +
> +    for (pageoff = 0; pageoff < range->count; ) {
> +        uint64_t addr_64 = (range->start + pageoff) * HV_BALLOON_PAGE_SIZE;
> +        void *addr;
> +        RAMBlock *rb;
> +        ram_addr_t rb_offset;
> +        size_t rb_page_size;
> +        size_t discard_size;
> +
> +        assert(addr_64 <= UINTPTR_MAX);
> +        addr = (void *)((uintptr_t)addr_64);
> +        rb = qemu_ram_block_from_host(addr, false, &rb_offset);
> +        rb_page_size = qemu_ram_pagesize(rb);
> +
> +        if (rb_page_size != HV_BALLOON_PAGE_SIZE) {
> +            /* TODO: these should end in "removed_guest" */
> +            warn_report("guest reported removed page backed by unsupported page size %zu",
> +                        rb_page_size);
> +            pageoff++;
> +            continue;
> +        }
> +
> +        discard_size = MIN(range->count - pageoff,
> +                           (rb->max_length - rb_offset) /
> +                           HV_BALLOON_PAGE_SIZE);
> +        discard_size = MAX(discard_size, 1);
> +
> +        if (ram_block_discard_range(rb, rb_offset, discard_size *
> +                                    HV_BALLOON_PAGE_SIZE) != 0) {
> +            warn_report("guest reported removed page failed discard");
> +        }
> +
> +        pageoff += discard_size;
> +    }
> +
> +    return false;
> +}
> +
> +static void hv_balloon_handle_remove_host_addr_tree(PageRangeTree tree)
> +{
> +    g_tree_foreach(tree.t, hv_balloon_handle_remove_host_addr_node, NULL);
> +}
> +
> +static int hv_balloon_handle_remove_section(PageRangeTree tree,
> +                                            const MemoryRegionSection *section,
> +                                            uint64_t count)
> +{
> +    void *addr = memory_region_get_ram_ptr(section->mr) +
> +        section->offset_within_region;
> +    uint64_t addr_page;
> +
> +    assert(count > 0);
> +
> +    if ((uintptr_t)addr % HV_BALLOON_PAGE_SIZE) {
> +        warn_report("guest reported removed pages at an unaligned host addr %p",
> +                    addr);
> +        return -EINVAL;
> +    }
> +
> +    addr_page = (uintptr_t)addr / HV_BALLOON_PAGE_SIZE;
> +    hvb_page_range_tree_insert(tree, addr_page, count, NULL);
> +
> +    return 0;
> +}
> +
> +static void hv_balloon_handle_remove_ranges(HvBalloon *balloon,
> +                                            union dm_mem_page_range ranges[],
> +                                            uint32_t count)
> +{
> +    uint64_t removedcnt;
> +    PageRangeTree removed_host_addr;
> +    PageRange range_guest, range_both;
> +
> +    hvb_page_range_tree_init(&removed_host_addr);
> +    range_guest.count = range_both.count = removedcnt = 0;
> +    for (unsigned int ctr = 0; ctr < count; ctr++) {
> +        union dm_mem_page_range *mr = &ranges[ctr];
> +        hwaddr pa;
> +        MemoryRegionSection section;
> +
> +        for (unsigned int offset = 0; offset < mr->finfo.page_cnt; ) {
> +            int ret;
> +            uint64_t pageno = mr->finfo.start_page + offset;
> +            uint64_t pagecnt = 1;
> +
> +            pa = (hwaddr)pageno << HV_BALLOON_PFN_SHIFT;
> +            section = memory_region_find(get_system_memory(), pa,
> +                                         (mr->finfo.page_cnt - offset) *
> +                                         HV_BALLOON_PAGE_SIZE);
> +            if (!section.mr) {
> +                warn_report("guest reported removed page %"PRIu64" not found in RAM",
> +                            pageno);
> +                ret = -EINVAL;
> +                goto finish_page;
> +            }
> +
> +            pagecnt = int128_get64(section.size) / HV_BALLOON_PAGE_SIZE;
> +            if (pagecnt <= 0) {
> +                warn_report("guest reported removed page %"PRIu64" in a section smaller than page size",
> +                            pageno);
> +                pagecnt = 1; /* skip the whole page */
> +                ret = -EINVAL;
> +                goto finish_page;
> +            }
> +
> +            if (!memory_region_is_ram(section.mr) ||
> +                memory_region_is_rom(section.mr) ||
> +                memory_region_is_romd(section.mr)) {
> +                warn_report("guest reported removed page %"PRIu64" in a section that is not an ordinary RAM",
> +                            pageno);
> +                ret = -EINVAL;
> +                goto finish_page;
> +            }
> +
> +            ret = hv_balloon_handle_remove_section(removed_host_addr, &section,
> +                                                   pagecnt);
> +
> +        finish_page:
> +            if (ret == 0) {
> +                hv_balloon_remove_response_handle_pages(balloon,
> +                                                        &range_both,
> +                                                        pageno, pagecnt,
> +                                                        true, &removedcnt);
> +            } else {
> +                hv_balloon_remove_response_handle_pages(balloon,
> +                                                        &range_guest,
> +                                                        pageno, pagecnt,
> +                                                        false, &removedcnt);
> +            }
> +
> +            if (section.mr) {
> +                memory_region_unref(section.mr);
> +            }
> +
> +            offset += pagecnt;
> +        }
> +    }
> +
> +    hv_balloon_remove_response_handle_range(balloon, &range_both, true,
> +                                            &removedcnt);
> +    hv_balloon_remove_response_handle_range(balloon, &range_guest, false,
> +                                            &removedcnt);
> +
> +    hv_balloon_handle_remove_host_addr_tree(removed_host_addr);
> +    hvb_page_range_tree_destroy(&removed_host_addr);
> +
> +    if (removedcnt > balloon->balloon_diff) {
> +        warn_report("guest reported more pages removed than currently pending (%"PRIu64" vs %"PRIu64")",
> +                    removedcnt, balloon->balloon_diff);
> +        balloon->balloon_diff = 0;
> +    } else {
> +        balloon->balloon_diff -= removedcnt;
> +    }
> +}
> +
> +static bool hv_balloon_handle_msg_size(HvBalloonReq *req, size_t minsize,
> +                                       const char *msgname)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    uint32_t msglen = vmreq->msglen;
> +
> +    if (msglen >= minsize) {
> +        return true;
> +    }
> +
> +    warn_report("%s message too short (%u vs %zu), ignoring", msgname,
> +                (unsigned int)msglen, minsize);
> +    return false;
> +}
> +
> +static void hv_balloon_handle_version_request(HvBalloon *balloon,
> +                                              HvBalloonReq *req,
> +                                              StateDesc *stdesc)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_version_request *msgVr = vmreq->msg;
> +    struct dm_version_response respVr;
> +
> +    if (balloon->state != S_VERSION) {
> +        warn_report("unexpected DM_VERSION_REQUEST in %d state",
> +                    balloon->state);
> +        return;
> +    }
> +
> +    if (!hv_balloon_handle_msg_size(req, sizeof(*msgVr),
> +                                    "DM_VERSION_REQUEST")) {
> +        return;
> +    }
> +
> +    trace_hv_balloon_incoming_version(msgVr->version.major_version,
> +                                      msgVr->version.minor_version);
> +
> +    memset(&respVr, 0, sizeof(respVr));
> +    respVr.hdr.type = DM_VERSION_RESPONSE;
> +    respVr.hdr.size = sizeof(respVr);
> +    respVr.hdr.trans_id = msgVr->hdr.trans_id;
> +    respVr.is_accepted = msgVr->version.version >= DYNMEM_PROTOCOL_VERSION_1 &&
> +        msgVr->version.version <= DYNMEM_PROTOCOL_VERSION_3;
> +
> +    hv_balloon_send_packet(vmreq->chan, (struct dm_message *)&respVr);
> +
> +    if (respVr.is_accepted) {
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_CAPS);
> +    }
> +}
> +
> +static void hv_balloon_handle_caps_report(HvBalloon *balloon,
> +                                          HvBalloonReq *req,
> +                                          StateDesc *stdesc)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_capabilities *msgCap = vmreq->msg;
> +    struct dm_capabilities_resp_msg respCap;
> +
> +    if (balloon->state != S_CAPS) {
> +        warn_report("unexpected DM_CAPABILITIES_REPORT in %d state",
> +                    balloon->state);
> +        return;
> +    }
> +
> +    if (!hv_balloon_handle_msg_size(req, sizeof(*msgCap),
> +                                    "DM_CAPABILITIES_REPORT")) {
> +        return;
> +    }
> +
> +    trace_hv_balloon_incoming_caps(msgCap->caps.caps);
> +    balloon->caps = msgCap->caps;
> +
> +    memset(&respCap, 0, sizeof(respCap));
> +    respCap.hdr.type = DM_CAPABILITIES_RESPONSE;
> +    respCap.hdr.size = sizeof(respCap);
> +    respCap.hdr.trans_id = msgCap->hdr.trans_id;
> +    respCap.is_accepted = 1;
> +    respCap.hot_remove = 1;
> +    respCap.suppress_pressure_reports = !balloon->status_report.enabled;
> +    hv_balloon_send_packet(vmreq->chan, (struct dm_message *)&respCap);
> +
> +    timer_mod(&balloon->post_init_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +              HV_BALLOON_POST_INIT_WAIT);
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_POST_INIT_WAIT);
> +}
> +
> +static void hv_balloon_handle_status_report(HvBalloon *balloon,
> +                                            HvBalloonReq *req)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_status *msgStatus = vmreq->msg;
> +
> +    if (!hv_balloon_handle_msg_size(req, sizeof(*msgStatus),
> +                                    "DM_STATUS_REPORT")) {
> +        return;
> +    }
> +
> +    if (!balloon->status_report.enabled) {
> +        return;
> +    }
> +
> +    balloon->status_report.committed = msgStatus->num_committed;
> +    balloon->status_report.committed *= HV_BALLOON_PAGE_SIZE;
> +    balloon->status_report.available = msgStatus->num_avail;
> +    balloon->status_report.available *= HV_BALLOON_PAGE_SIZE;
> +    balloon->status_report.received = true;
> +
> +    /* report event */
> +}
> +
> +static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
> +                                                 HvBalloonReq *req,
> +                                                 StateDesc *stdesc)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_unballoon_response *msgUrR = vmreq->msg;
> +
> +    if (balloon->state != S_UNBALLOON_REPLY_WAIT) {
> +        warn_report("unexpected DM_UNBALLOON_RESPONSE in %d state",
> +                    balloon->state);
> +        return;
> +    }
> +
> +    if (!hv_balloon_handle_msg_size(req, sizeof(*msgUrR),
> +                                    "DM_UNBALLOON_RESPONSE"))
> +        return;
> +
> +    trace_hv_balloon_incoming_unballoon(msgUrR->hdr.trans_id);
> +
> +    balloon->trans_id++;
> +
> +    HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
> +}
> +
> +static void hv_balloon_handle_balloon_response(HvBalloon *balloon,
> +                                               HvBalloonReq *req,
> +                                               StateDesc *stdesc)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_balloon_response *msgBR = vmreq->msg;
> +
> +    if (balloon->state != S_BALLOON_REPLY_WAIT) {
> +        warn_report("unexpected DM_BALLOON_RESPONSE in %d state",
> +                    balloon->state);
> +        return;
> +    }
> +
> +    if (!hv_balloon_handle_msg_size(req, sizeof(*msgBR),
> +                                    "DM_BALLOON_RESPONSE"))
> +        return;
> +
> +    trace_hv_balloon_incoming_balloon(msgBR->hdr.trans_id, msgBR->range_count,
> +                                      msgBR->more_pages);
> +
> +    if (vmreq->msglen < sizeof(*msgBR) +
> +        (uint64_t)sizeof(msgBR->range_array[0]) * msgBR->range_count) {
> +        warn_report("DM_BALLOON_RESPONSE too short for the range count");
> +        return;
> +    }
> +
> +    if (msgBR->range_count == 0) {
> +        /* The guest is already at its minimum size */
> +        balloon->balloon_diff = 0;
> +        goto ret_end_trans;
> +    } else {
> +        hv_balloon_handle_remove_ranges(balloon,
> +                                        msgBR->range_array,
> +                                        msgBR->range_count);
> +    }
> +
> +    /* More responses expected? */
> +    if (msgBR->more_pages) {
> +        return;
> +    }
> +
> +ret_end_trans:
> +    balloon->trans_id++;
> +
> +    if (balloon->balloon_diff > 0) {
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_RB_WAIT);
> +    } else {
> +        HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
> +    }
> +}
> +
> +static void hv_balloon_handle_packet(HvBalloon *balloon, HvBalloonReq *req,
> +                                     StateDesc *stdesc)
> +{
> +    VMBusChanReq *vmreq = &req->vmreq;
> +    struct dm_message *msg = vmreq->msg;
> +
> +    if (vmreq->msglen < sizeof(msg->hdr)) {
> +        return;
> +    }
> +
> +    switch (msg->hdr.type) {
> +    case DM_VERSION_REQUEST:
> +        hv_balloon_handle_version_request(balloon, req, stdesc);
> +        break;
> +
> +    case DM_CAPABILITIES_REPORT:
> +        hv_balloon_handle_caps_report(balloon, req, stdesc);
> +        break;
> +
> +    case DM_STATUS_REPORT:
> +        hv_balloon_handle_status_report(balloon, req);
> +        break;
> +
> +    case DM_UNBALLOON_RESPONSE:
> +        hv_balloon_handle_unballoon_response(balloon, req, stdesc);
> +        break;
> +
> +    case DM_BALLOON_RESPONSE:
> +        hv_balloon_handle_balloon_response(balloon, req, stdesc);
> +        break;
> +
> +    default:
> +        warn_report("unknown DM message %u", msg->hdr.type);
> +        break;
> +    }
> +}
> +
> +static bool hv_balloon_recv_channel(HvBalloon *balloon, StateDesc *stdesc)
> +{
> +    VMBusChannel *chan;
> +    HvBalloonReq *req;
> +
> +    if (balloon->state == S_WAIT_RESET ||
> +        balloon->state == S_POST_RESET_CLOSED) {
> +        return false;
> +    }
> +
> +    chan = hv_balloon_get_channel(balloon);
> +    if (vmbus_channel_recv_start(chan)) {
> +        return false;
> +    }
> +
> +    while ((req = vmbus_channel_recv_peek(chan, sizeof(*req)))) {
> +        hv_balloon_handle_packet(balloon, req, stdesc);
> +        vmbus_free_req(req);
> +        vmbus_channel_recv_pop(chan);
> +
> +        if (stdesc->state != S_NO_CHANGE) {
> +            break;
> +        }
> +    }
> +
> +    return vmbus_channel_recv_done(chan) > 0;
> +}
> +
> +/* old state handler -> new state transition (potential) */
> +static bool hv_balloon_event_loop_state(HvBalloon *balloon)
> +{
> +    StateDesc state_new = HV_BALLOON_STATE_DESC_INIT;
> +
> +    hv_balloon_handle_state(balloon, &state_new);
> +    return hv_balloon_state_set(balloon, state_new.state, state_new.desc);
> +}
> +
> +/* VMBus message -> new state transition (potential) */
> +static bool hv_balloon_event_loop_recv(HvBalloon *balloon)
> +{
> +    StateDesc state_new = HV_BALLOON_STATE_DESC_INIT;
> +    bool any_recv, state_changed;
> +
> +    any_recv = hv_balloon_recv_channel(balloon, &state_new);
> +    state_changed = hv_balloon_state_set(balloon,
> +                                         state_new.state, state_new.desc);
> +
> +    return state_changed || any_recv;
> +}
> +
> +static void hv_balloon_event_loop(HvBalloon *balloon)
> +{
> +    bool state_repeat, recv_repeat;
> +
> +    do {
> +        state_repeat = hv_balloon_event_loop_state(balloon);
> +        recv_repeat = hv_balloon_event_loop_recv(balloon);
> +    } while (state_repeat || recv_repeat);
> +}
> +
> +static void hv_balloon_vmdev_chan_notify(VMBusChannel *chan)
> +{
> +    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
> +
> +    hv_balloon_event_loop(balloon);
> +}
> +
> +static void hv_balloon_stat(void *opaque, BalloonInfo *info)
> +{
> +    HvBalloon *balloon = opaque;
> +    info->actual = (hv_balloon_total_ram(balloon) - balloon->removed_both_ctr)
> +        << HV_BALLOON_PFN_SHIFT;
> +}
> +
> +static void hv_balloon_to_target(void *opaque, ram_addr_t target)
> +{
> +    HvBalloon *balloon = opaque;
> +    uint64_t target_pages = target >> HV_BALLOON_PFN_SHIFT;
> +
> +    if (!target_pages) {
> +        return;
> +    }
> +
> +    /*
> +     * always set target_changed, even with unchanged target, as the user
> +     * might be asking us to try again reaching it
> +     */
> +    balloon->target = target_pages;
> +    balloon->target_changed = true;
> +
> +    hv_balloon_event_loop(balloon);
> +}
> +
> +static int hv_balloon_vmdev_open_channel(VMBusChannel *chan)
> +{
> +    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
> +
> +    if (balloon->state != S_POST_RESET_CLOSED) {
> +        warn_report("guest trying to open a DM channel in invalid %d state",
> +                    balloon->state);
> +        return -EINVAL;
> +    }
> +
> +    HV_BALLOON_SET_STATE(balloon, S_VERSION);
> +    hv_balloon_event_loop(balloon);
> +
> +    return 0;
> +}
> +
> +static void hv_balloon_vmdev_close_channel(VMBusChannel *chan)
> +{
> +    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
> +
> +    timer_del(&balloon->post_init_timer);
> +
> +    /* Don't report stale data */
> +    balloon->status_report.received = false;
> +
> +    HV_BALLOON_SET_STATE(balloon, S_WAIT_RESET);
> +    hv_balloon_event_loop(balloon);
> +}
> +
> +static void hv_balloon_post_init_timer(void *opaque)
> +{
> +    HvBalloon *balloon = opaque;
> +
> +    if (balloon->state != S_POST_INIT_WAIT) {
> +        return;
> +    }
> +
> +    HV_BALLOON_SET_STATE(balloon, S_IDLE);
> +    hv_balloon_event_loop(balloon);
> +}
> +
> +static void hv_balloon_vmdev_realize(VMBusDevice *vdev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    HvBalloon *balloon = HV_BALLOON(vdev);
> +    int ret;
> +
> +    balloon->state = S_WAIT_RESET;
> +
> +    ret = qemu_add_balloon_handler(hv_balloon_to_target, hv_balloon_stat,
> +                                   balloon);
> +    if (ret < 0) {
> +        /* This also protects against having multiple hv-balloon instances */
> +        error_setg(errp, "Only one balloon device is supported");
> +        return;
> +    }
> +
> +    timer_init_ms(&balloon->post_init_timer, QEMU_CLOCK_VIRTUAL,
> +                  hv_balloon_post_init_timer, balloon);
> +}
> +
> +/*
> + * VMBus device reset has to be implemented in case the guest decides to
> + * disconnect and reconnect to the VMBus without rebooting the whole system.
> + */
> +static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
> +{
> +    HvBalloon *balloon = HV_BALLOON(vdev);
> +
> +    if (balloon->state == S_POST_RESET_CLOSED) {
> +        return;
> +    }
> +
> +    hvb_page_range_tree_destroy(&balloon->removed_guest);
> +    hvb_page_range_tree_destroy(&balloon->removed_both);
> +    hvb_page_range_tree_init(&balloon->removed_guest);
> +    hvb_page_range_tree_init(&balloon->removed_both);
> +
> +    balloon->trans_id = 0;
> +    balloon->removed_guest_ctr = 0;
> +    balloon->removed_both_ctr = 0;
> +
> +    HV_BALLOON_SET_STATE(balloon, S_POST_RESET_CLOSED);
> +    hv_balloon_event_loop(balloon);
> +}
> +
> +static void hv_balloon_vmdev_unrealize(VMBusDevice *vdev)
> +{
> +    HvBalloon *balloon = HV_BALLOON(vdev);
> +
> +    qemu_remove_balloon_handler(balloon);
> +
> +    hvb_page_range_tree_destroy(&balloon->removed_guest);
> +    hvb_page_range_tree_destroy(&balloon->removed_both);
> +}
> +
> +static void hv_balloon_init(Object *obj)
> +{
> +}
> +
> +static void hv_balloon_finalize(Object *obj)
> +{
> +}
> +
> +static Property hv_balloon_properties[] = {
> +    DEFINE_PROP_BOOL("status-report", HvBalloon,
> +                     status_report.enabled, false),
> +
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void hv_balloon_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VMBusDeviceClass *vdc = VMBUS_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, hv_balloon_properties);
> +    qemu_uuid_parse(HV_BALLOON_GUID, &vdc->classid);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    vdc->vmdev_realize = hv_balloon_vmdev_realize;
> +    vdc->vmdev_unrealize = hv_balloon_vmdev_unrealize;
> +    vdc->vmdev_reset = hv_balloon_vmdev_reset;
> +    vdc->open_channel = hv_balloon_vmdev_open_channel;
> +    vdc->close_channel = hv_balloon_vmdev_close_channel;
> +    vdc->chan_notify_cb = hv_balloon_vmdev_chan_notify;
> +}
> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
> index b43f119ea56c..b5be1cbb1a96 100644
> --- a/hw/hyperv/meson.build
> +++ b/hw/hyperv/meson.build
> @@ -2,3 +2,4 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
>   specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>   specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>   specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
> +specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c'))
> diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
> index b4c35ca8e377..86c724ba661b 100644
> --- a/hw/hyperv/trace-events
> +++ b/hw/hyperv/trace-events
> @@ -16,3 +16,16 @@ vmbus_gpadl_torndown(uint32_t gpadl_id) "gpadl #%d"
>   vmbus_open_channel(uint32_t chan_id, uint32_t gpadl_id, uint32_t target_vp) "channel #%d gpadl #%d target vp %d"
>   vmbus_channel_open(uint32_t chan_id, uint32_t status) "channel #%d status %d"
>   vmbus_close_channel(uint32_t chan_id) "channel #%d"
> +
> +# hv-balloon
> +hv_balloon_state_change(const char *tostr) "-> %s"
> +hv_balloon_incoming_version(uint16_t major, uint16_t minor) "incoming proto version %u.%u"
> +hv_balloon_incoming_caps(uint32_t caps) "incoming caps 0x%x"
> +hv_balloon_outgoing_unballoon(uint32_t trans_id, uint64_t count, uint64_t start, uint64_t rempages) "posting unballoon %"PRIu32" for %"PRIu64" @ 0x%"PRIx64", remaining %"PRIu64
> +hv_balloon_incoming_unballoon(uint32_t trans_id) "incoming unballoon response %"PRIu32
> +hv_balloon_outgoing_balloon(uint32_t trans_id, uint64_t count, uint64_t rempages) "posting balloon %"PRIu32" for %"PRIu64", remaining %"PRIu64
> +hv_balloon_incoming_balloon(uint32_t trans_id, uint32_t range_count, uint32_t more_pages) "incoming balloon response %"PRIu32", ranges %"PRIu32", more %"PRIu32
> +hv_balloon_remove_response(uint64_t count, uint64_t start, unsigned int both) "processing remove response range %"PRIu64" @ 0x%"PRIx64", both %u"
> +hv_balloon_remove_response_hole(uint64_t counthole, uint64_t starthole, uint64_t countrange, uint64_t startrange, uint64_t starthpr, unsigned int both) "response range hole %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64", before our start 0x%"PRIx64", both %u"
> +hv_balloon_remove_response_common(uint64_t countcommon, uint64_t startcommon, uint64_t countrange, uint64_t startrange, uint64_t counthpr, uint64_t starthpr, uint64_t removed, unsigned int both) "response common range %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64" with our %"PRIu64" @ 0x%"PRIx64", removed %"PRIu64", both %u"
> +hv_balloon_remove_response_remainder(uint64_t count, uint64_t start, unsigned int both) "remove response remaining range %"PRIu64" @ 0x%"PRIx64", both %u"
> diff --git a/include/hw/hyperv/hv-balloon.h b/include/hw/hyperv/hv-balloon.h
> new file mode 100644
> index 000000000000..c1efe70fc23f
> --- /dev/null
> +++ b/include/hw/hyperv/hv-balloon.h
> @@ -0,0 +1,18 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_HV_BALLOON_H
> +#define HW_HV_BALLOON_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_HV_BALLOON "hv-balloon"
> +OBJECT_DECLARE_SIMPLE_TYPE(HvBalloon, HV_BALLOON)
> +
> +#endif
> diff --git a/meson.build b/meson.build
> index dcef8b1e7911..51a51075db38 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1323,6 +1323,30 @@ if not get_option('glusterfs').auto() or have_block
>     endif
>   endif
>   
> +hv_balloon = false
> +if get_option('hv_balloon').allowed() and have_system
> +  if cc.links('''
> +    #include <string.h>
> +    #include <gmodule.h>
> +    int main(void) {
> +        GTree *tree;
> +
> +        tree = g_tree_new((GCompareFunc)strcmp);
> +        (void)g_tree_node_first(tree);
> +        g_tree_destroy(tree);
> +        return 0;
> +    }
> +  ''', dependencies: glib)
> +    hv_balloon = true
> +  else
> +    if get_option('hv_balloon').enabled()
> +      error('could not enable hv-balloon, update your glib')
> +    else
> +      warning('could not find glib support for hv-balloon, disabling')
> +    endif
> +  endif
> +endif
> +
>   libssh = not_found
>   if not get_option('libssh').auto() or have_block
>     libssh = dependency('libssh', version: '>=0.8.7',
> @@ -2855,7 +2879,8 @@ host_kconfig = \
>     (targetos == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
>     (have_pvrdma ? ['CONFIG_PVRDMA=y'] : []) + \
>     (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
> -  (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : [])
> +  (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
> +  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
>   
>   ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
>   
> @@ -4321,6 +4346,7 @@ if targetos == 'windows'
>   endif
>   summary_info += {'seccomp support':   seccomp}
>   summary_info += {'GlusterFS support': glusterfs}
> +summary_info += {'hv-balloon support': hv_balloon}
>   summary_info += {'TPM support':       have_tpm}
>   summary_info += {'libssh support':    libssh}
>   summary_info += {'lzo support':       lzo}
> diff --git a/meson_options.txt b/meson_options.txt
> index 3c7398f3c683..5c212fcd4570 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -150,6 +150,8 @@ option('gio', type : 'feature', value : 'auto',
>          description: 'use libgio for D-Bus support')
>   option('glusterfs', type : 'feature', value : 'auto',
>          description: 'Glusterfs block device driver')
> +option('hv_balloon', type : 'feature', value : 'auto',
> +       description: 'hv-balloon driver (requires Glib 2.68+ GTree API)')
>   option('libdw', type : 'feature', value : 'auto',
>          description: 'debuginfo support')
>   option('libiscsi', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 7ca4b77eaedf..e9d6d392790d 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -123,6 +123,7 @@ meson_options_help() {
>     printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
>     printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
>     printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
> +  printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
>     printf "%s\n" '  hvf             HVF acceleration support'
>     printf "%s\n" '  iconv           Font glyph conversion support'
>     printf "%s\n" '  jack            JACK sound support'
> @@ -333,6 +334,8 @@ _meson_option_parse() {
>       --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
>       --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
>       --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
> +    --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
> +    --disable-hv-balloon) printf "%s" -Dhv_balloon=disabled ;;
>       --enable-hvf) printf "%s" -Dhvf=enabled ;;
>       --disable-hvf) printf "%s" -Dhvf=disabled ;;
>       --iasl=*) quote_sh "-Diasl=$2" ;;


