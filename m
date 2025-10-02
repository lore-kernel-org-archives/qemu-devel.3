Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3216DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ejr-0001NI-S9; Thu, 02 Oct 2025 04:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4Eje-0001IM-EQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4EjS-0004PR-HA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759393923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L/fw0LS6GQgD/pBxmw7g8YNJYQq+ReOzriwQrYjo3/k=;
 b=MzTNK8M2nUoTj9J0FenkYgX8OyYTV96JibGxIQKlkYfkRjAhMO+Owo57zr0GGTsjRUNmi+
 8jfvb0lH7vdIsqYRuSaas+0IiKb2vwkmHHyMVSUnKa31COchqzgHoyg1/l02dJ46ot1D2L
 iqjLig5YepSp6brdmnkyuiC65uo96Mc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-sNCJE-IkOAmWivaHYyTrSg-1; Thu, 02 Oct 2025 04:32:01 -0400
X-MC-Unique: sNCJE-IkOAmWivaHYyTrSg-1
X-Mimecast-MFC-AGG-ID: sNCJE-IkOAmWivaHYyTrSg_1759393920
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so376600f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393920; x=1759998720;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/fw0LS6GQgD/pBxmw7g8YNJYQq+ReOzriwQrYjo3/k=;
 b=UkHf11UOYZO+VDn3K2ayERNGtAT8aaKu7GWQa++jq+CCHKKhptOO7ZlQe6w7gjs2JE
 T/dUdp8xkp44K8h90LGp1duq7k87UocSmWheAO/bLZQuT5xJTAQ8t9QSm8VoAfzFCnUX
 O7qc3fHoLSiGCUNJnw8adDLeSQD0UoIJ2ASMmv/5LE3SNE4g2Jfao0qa33+5o6OHyKHT
 PUzvx2L/bxzvRF/DF44N65ktEx/D1B9k+1Ni1/gIrMLU8K5n96Ky4ooAlsRJFwLZp/oi
 WeOH9C7oSGxRtIWRQmI0OPxuQ1mUBSw6WaJANLdbotdcj1lbHQvQcYijekyZkpYF8Gut
 4vJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj7fyeBwOf50onn9fIFDEA/fG+SdhRbA3XQfAcPHvdNw4oXC+G8W6D8HMNKdpe+6+kGxu2fuMMruqp@nongnu.org
X-Gm-Message-State: AOJu0YwSFmUNP55j6W1Ps+TmVf2pR0K/r3L/oLdeIVAbyXmj+2wi1t4K
 7fgxsNMPRPbrfXkvd/2eZFaDsms5NEChMHb9IXpXlZdgs60wac0OuBqIMKEEOHUAk37yi1BUId6
 DNPcYWVxfcYfw9Hz5mHK5w0M0Mm448X+5L15cdGgdLO0G5hyKkEGdb4iMRljwfPD0
X-Gm-Gg: ASbGncs8aAlWVJbChV+aONdspmX6qlcwJO3tPLGhUKigPxcsKpS7qBWHDTk4qbL8J3c
 o3/ESV6JsQX7NM8rQ/wFkZmOuQs0a+kC1hJybJ/eHJ+/eYYwpM8eYiKDc5q7U1dSPX4YTeGofi8
 G8Mkd+zu/sVYJROs1tl5+UJfhALyeP7QrPDHu8mWNMtpSDdZxOiFvkV7Xm3uefQknytwHaPxMOw
 krLfXBm24xqYxdigub0i1L3OBmTQK7Ur0/HDETJIB+Fi2ryahw57rZ8KfgcxMb6W3yBZ813Uhoz
 hDJ+rvlSGzWUsfq9+3d/wknlttPFsGhoS+IsDN/ry4mUvZgXmtLiW5FNpyFD+NMcyHJhiLVfsO/
 VM5H4ySP2
X-Received: by 2002:a05:6000:4007:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-4255781905cmr4337376f8f.47.1759393920084; 
 Thu, 02 Oct 2025 01:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHboYzge1XMjYqiKlN33LAQQN3W8eLKsHEs3w26cnAhajVG0zFzOu5mus9Ra3W1NTjD6VNh0w==
X-Received: by 2002:a05:6000:4007:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-4255781905cmr4337342f8f.47.1759393919544; 
 Thu, 02 Oct 2025 01:31:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf38sm2606840f8f.20.2025.10.02.01.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:31:59 -0700 (PDT)
Message-ID: <9d328a5e-119b-494b-9f9e-9a2fe2da4cfe@redhat.com>
Date: Thu, 2 Oct 2025 10:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] system/physmem: Extract API out of
 'system/ram_addr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20251001175448.18933-1-philmd@linaro.org>
 <20251001175448.18933-19-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251001175448.18933-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/1/25 19:54, Philippe Mathieu-Daudé wrote:
> Very few files use the Physical Memory API. Declare its
> methods in their own header: "system/physmem.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   MAINTAINERS                 |  1 +
>   include/system/physmem.h    | 54 +++++++++++++++++++++++++++++++++++++
>   include/system/ram_addr.h   | 40 ---------------------------
>   accel/kvm/kvm-all.c         |  2 +-
>   accel/tcg/cputlb.c          |  1 +
>   hw/vfio/container-legacy.c  |  2 +-
>   hw/vfio/container.c         |  1 +
>   hw/vfio/listener.c          |  1 -
>   migration/ram.c             |  1 +
>   system/memory.c             |  1 +
>   system/physmem.c            |  1 +
>   target/arm/tcg/mte_helper.c |  2 +-
>   12 files changed, 63 insertions(+), 44 deletions(-)
>   create mode 100644 include/system/physmem.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 406cef88f0c..9632eb7b440 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3213,6 +3213,7 @@ S: Supported
>   F: include/system/ioport.h
>   F: include/exec/memop.h
>   F: include/system/memory.h
> +F: include/system/physmem.h
>   F: include/system/ram_addr.h
>   F: include/system/ramblock.h
>   F: include/system/memory_mapping.h
> diff --git a/include/system/physmem.h b/include/system/physmem.h
> new file mode 100644
> index 00000000000..879f6eae38b
> --- /dev/null
> +++ b/include/system/physmem.h
> @@ -0,0 +1,54 @@
> +/*
> + * QEMU physical memory interfaces (target independent).
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_SYSTEM_PHYSMEM_H
> +#define QEMU_SYSTEM_PHYSMEM_H
> +
> +#include "exec/hwaddr.h"
> +#include "exec/ramlist.h"
> +
> +#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> +#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
> +
> +bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
> +
> +bool physical_memory_is_clean(ram_addr_t addr);
> +
> +uint8_t physical_memory_range_includes_clean(ram_addr_t start,
> +                                             ram_addr_t length,
> +                                             uint8_t mask);
> +
> +void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
> +
> +void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
> +                                     uint8_t mask);
> +
> +/*
> + * Contrary to physical_memory_sync_dirty_bitmap() this function returns
> + * the number of dirty pages in @bitmap passed as argument. On the other hand,
> + * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
> + * weren't set in the global migration bitmap.
> + */
> +uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +                                            ram_addr_t start,
> +                                            ram_addr_t pages);
> +
> +void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
> +
> +bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> +                                          ram_addr_t length,
> +                                          unsigned client);
> +
> +DirtyBitmapSnapshot *
> +physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
> +                                         hwaddr length, unsigned client);
> +
> +bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> +                                        ram_addr_t start,
> +                                        ram_addr_t length);
> +
> +#endif
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 3894a84fb9c..683485980ce 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -19,7 +19,6 @@
>   #ifndef SYSTEM_RAM_ADDR_H
>   #define SYSTEM_RAM_ADDR_H
>   
> -#include "exec/ramlist.h"
>   #include "system/ramblock.h"
>   #include "exec/target_page.h"
>   #include "exec/hwaddr.h"
> @@ -133,43 +132,4 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
>       qemu_ram_msync(block, 0, block->used_length);
>   }
>   
> -#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> -#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
> -
> -bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
> -
> -bool physical_memory_is_clean(ram_addr_t addr);
> -
> -uint8_t physical_memory_range_includes_clean(ram_addr_t start,
> -                                                 ram_addr_t length,
> -                                                 uint8_t mask);
> -
> -void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
> -
> -void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
> -                                         uint8_t mask);
> -
> -/*
> - * Contrary to physical_memory_sync_dirty_bitmap() this function returns
> - * the number of dirty pages in @bitmap passed as argument. On the other hand,
> - * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
> - * weren't set in the global migration bitmap.
> - */
> -uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> -                                                ram_addr_t start,
> -                                                ram_addr_t pages);
> -
> -void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
> -
> -bool physical_memory_test_and_clear_dirty(ram_addr_t start,
> -                                              ram_addr_t length,
> -                                              unsigned client);
> -
> -DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
> -    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
> -
> -bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> -                                            ram_addr_t start,
> -                                            ram_addr_t length);
> -
>   #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index a7ece7db964..58802f7c3cc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -32,13 +32,13 @@
>   #include "system/runstate.h"
>   #include "system/cpus.h"
>   #include "system/accel-blocker.h"
> +#include "system/physmem.h"
>   #include "system/ramblock.h"
>   #include "accel/accel-ops.h"
>   #include "qemu/bswap.h"
>   #include "exec/tswap.h"
>   #include "exec/target_page.h"
>   #include "system/memory.h"
> -#include "system/ram_addr.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/main-loop.h"
>   #include "trace.h"

hmm, I am seeing build errors :

../accel/kvm/kvm-all.c:1596:41: error: invalid use of incomplete typedef ‘RAMBlock’
  1596 |         mem->guest_memfd = mr->ram_block->guest_memfd;


May be this is my tree. Can you check ?

C.

> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a721235dea6..7214d41cb5d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -25,6 +25,7 @@
>   #include "accel/tcg/probe.h"
>   #include "exec/page-protection.h"
>   #include "system/memory.h"
> +#include "system/physmem.h"
>   #include "accel/tcg/cpu-ldst-common.h"
>   #include "accel/tcg/cpu-mmu-index.h"
>   #include "exec/cputlb.h"
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index eb9911eaeaf..755a407f3e7 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -25,7 +25,7 @@
>   #include "hw/vfio/vfio-device.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
> -#include "system/ram_addr.h"
> +#include "system/physmem.h"
>   #include "qemu/error-report.h"
>   #include "qemu/range.h"
>   #include "system/reset.h"
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3fb19a1c8ad..9ddec300e35 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -20,6 +20,7 @@
>   #include "qemu/error-report.h"
>   #include "hw/vfio/vfio-container.h"
>   #include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
> +#include "system/physmem.h"
>   #include "system/reset.h"
>   #include "vfio-helpers.h"
>   
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index b5cefc9395c..c6bb58f5209 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -30,7 +30,6 @@
>   #include "hw/vfio/pci.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
> -#include "system/ram_addr.h"
>   #include "hw/hw.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> diff --git a/migration/ram.c b/migration/ram.c
> index d09591c0600..12122dda685 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -53,6 +53,7 @@
>   #include "qemu/rcu_queue.h"
>   #include "migration/colo.h"
>   #include "system/cpu-throttle.h"
> +#include "system/physmem.h"
>   #include "system/ramblock.h"
>   #include "savevm.h"
>   #include "qemu/iov.h"
> diff --git a/system/memory.c b/system/memory.c
> index dd045da60c0..80656c69568 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -25,6 +25,7 @@
>   #include "qemu/target-info.h"
>   #include "qom/object.h"
>   #include "trace.h"
> +#include "system/physmem.h"
>   #include "system/ram_addr.h"
>   #include "system/kvm.h"
>   #include "system/runstate.h"
> diff --git a/system/physmem.c b/system/physmem.c
> index 1a075da2bdd..ec3d8027e86 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -43,6 +43,7 @@
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "system/qtest.h"
> +#include "system/physmem.h"
>   #include "system/ramblock.h"
>   #include "qemu/timer.h"
>   #include "qemu/config-file.h"
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 077ff4b2b2c..b96c953f809 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -27,7 +27,7 @@
>   #include "user/cpu_loop.h"
>   #include "user/page-protection.h"
>   #else
> -#include "system/ram_addr.h"
> +#include "system/physmem.h"
>   #endif
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"


