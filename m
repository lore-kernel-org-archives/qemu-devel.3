Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BACC3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 07:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF6fb-0003O8-5A; Wed, 14 May 2025 03:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uF6fZ-0003Ny-Cu
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uF6fW-0007V2-Lm
 for qemu-devel@nongnu.org; Wed, 14 May 2025 03:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747208204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uq+GuLSPa2gzkBizk4uuD+tjfIaIPHH+bu/j50cdDkk=;
 b=cD3Ot0xbu+4tlNORCLJ51O4i0q5CATQy8YPdOblqkmKRg0S+enKo5+ezcB0xNVtSdWq9/+
 18bxrVLyPVXrOYZs5B5ncE+YrVkLCKVXYgZQ3eT6uJz5OUXIdZ7InmfqWkpNAN7uNauN75
 qZR5s9TXX+lmVBuw3HGkDLUrTsOjlXQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-J7TU3qAxO-GDUOu7-UgL3g-1; Wed, 14 May 2025 03:36:42 -0400
X-MC-Unique: J7TU3qAxO-GDUOu7-UgL3g-1
X-Mimecast-MFC-AGG-ID: J7TU3qAxO-GDUOu7-UgL3g_1747208202
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a344910d0dso272612f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208202; x=1747813002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uq+GuLSPa2gzkBizk4uuD+tjfIaIPHH+bu/j50cdDkk=;
 b=nAFTi3t5NYgUkUHwCfwCsUt47hEzHIEtnecrcjBngu3cGQOizmavlnVXFqam7/+L95
 AJotuiqwXJ8Ja7PG2LbpbUzBwhO4VUWH4q4rKavTCXJ0CmuGVrKt2UULOhMXM+qfTESb
 VukKtfDct6rQ9nKJAECGde8S4eFT5Ti83AqTTjAvbQ6dlg9HReAa46R9InvK/md2gLPE
 WgY0ofbFygpxAoI78flA61FUFVz/979n5kKNMsqovoBkCj8byyihcHLE8igw7m79fofw
 NxFr1vDNwI/nH1ee3jpkDAipgO6FX64nnV6HbZDbuPznEXWSMZX8DHI3plGYXTEmbQ3D
 oE1Q==
X-Gm-Message-State: AOJu0YzSzpnA16kxGx+qsFhAd7qLsIIYv1Uh84blSw08Vi9Gm8S40x6F
 JLMvEnjYQfEEBMvcWqtcNtjgGrfiSBfu5invOcaieoqAmFkyxQewtFzpq1rstDL+80xk1YzXrK5
 7ee82pZuJdmqhxkuBtEY2m5H/+6IgiNf9CCdxlPKqPAsEbJGmneLQ
X-Gm-Gg: ASbGncvREbbGAKjm+bOJT/HFoewjSZ47kzLbcrY3/p6PfJ8+XA1NDIe7kmu8+qf57Ms
 N55swTivY7gyHcl2BCRKoyIk2gntkSyKm6XluHZEtgv1WWliEpCWJwIPYtq0755Bvy/khnlwwnM
 G6nkKm1sXGEsC38tk7b45LmPq4DUzrt2cbaHuAAwk1Q/RSE+a+BWSpDNjD7mGJWZwnfbosRH9Ht
 VrZOidllGfROyRVm1Uzc1bMl5QBckPNIb1EsBR4JUfkNgMwABWA5VWYNVrU5OzQJAaHVjGlzue2
 MZXY/g==
X-Received: by 2002:a5d:5f88:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3a348d6a4cfmr2087841f8f.8.1747208201694; 
 Wed, 14 May 2025 00:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHounzE39CEQm0eKyg7Nv7NPsHMElFPu+dZV+bKkvpbNEEEJLx630bTkG7JHkCsMlljQGWIKw==
X-Received: by 2002:a5d:5f88:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3a348d6a4cfmr2087812f8f.8.1747208201233; 
 Wed, 14 May 2025 00:36:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c599sm19043011f8f.94.2025.05.14.00.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 00:36:40 -0700 (PDT)
Date: Wed, 14 May 2025 03:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>
Subject: Re: [PATCH v4 14/19] atc: Add unit tests
Message-ID: <20250514033538-mutt-send-email-mst@kernel.org>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
 <20250227105339.388598-15-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227105339.388598-15-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 27, 2025 at 10:54:47AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>



Causes build failures.

https://gitlab.com/mstredhat/qemu/-/jobs/10024906541

I tried to fix it up but got this:

https://gitlab.com/mstredhat/qemu/-/jobs/10028844303


pls fix and repost.


> ---
>  tests/unit/meson.build |   1 +
>  tests/unit/test-atc.c  | 527 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 528 insertions(+)
>  create mode 100644 tests/unit/test-atc.c
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d5248ae51d..810197d5e1 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -48,6 +48,7 @@ tests = {
>    'test-qapi-util': [],
>    'test-interval-tree': [],
>    'test-fifo': [],
> +  'test-atc': [],
>  }
>  
>  if have_system or have_tools
> diff --git a/tests/unit/test-atc.c b/tests/unit/test-atc.c
> new file mode 100644
> index 0000000000..0d1c1b7ca7
> --- /dev/null
> +++ b/tests/unit/test-atc.c
> @@ -0,0 +1,527 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "util/atc.h"
> +
> +static inline bool tlb_entry_equal(IOMMUTLBEntry *e1, IOMMUTLBEntry *e2)
> +{
> +    if (!e1 || !e2) {
> +        return !e1 && !e2;
> +    }
> +    return e1->iova == e2->iova &&
> +            e1->addr_mask == e2->addr_mask &&
> +            e1->pasid == e2->pasid &&
> +            e1->perm == e2->perm &&
> +            e1->target_as == e2->target_as &&
> +            e1->translated_addr == e2->translated_addr;
> +}
> +
> +static void assert_lookup_equals(ATC *atc, IOMMUTLBEntry *target,
> +                                 uint32_t pasid, hwaddr iova)
> +{
> +    IOMMUTLBEntry *result;
> +    result = atc_lookup(atc, pasid, iova);
> +    g_assert(tlb_entry_equal(result, target));
> +}
> +
> +static void check_creation(uint64_t page_size, uint8_t address_width,
> +                           uint8_t levels, uint8_t level_offset,
> +                           bool should_work) {
> +    ATC *atc = atc_new(page_size, address_width);
> +    if (atc) {
> +        g_assert(atc->levels == levels);
> +        g_assert(atc->level_offset == level_offset);
> +
> +        atc_destroy(atc);
> +        g_assert(should_work);
> +    } else {
> +        g_assert(!should_work);
> +    }
> +}
> +
> +static void test_creation_parameters(void)
> +{
> +    check_creation(8, 39, 3, 9, false);
> +    check_creation(4095, 39, 3, 9, false);
> +    check_creation(4097, 39, 3, 9, false);
> +    check_creation(8192, 48, 0, 0, false);
> +
> +    check_creation(4096, 38, 0, 0, false);
> +    check_creation(4096, 39, 3, 9, true);
> +    check_creation(4096, 40, 0, 0, false);
> +    check_creation(4096, 47, 0, 0, false);
> +    check_creation(4096, 48, 4, 9, true);
> +    check_creation(4096, 49, 0, 0, false);
> +    check_creation(4096, 56, 0, 0, false);
> +    check_creation(4096, 57, 5, 9, true);
> +    check_creation(4096, 58, 0, 0, false);
> +
> +    check_creation(16384, 35, 0, 0, false);
> +    check_creation(16384, 36, 2, 11, true);
> +    check_creation(16384, 37, 0, 0, false);
> +    check_creation(16384, 46, 0, 0, false);
> +    check_creation(16384, 47, 3, 11, true);
> +    check_creation(16384, 48, 0, 0, false);
> +    check_creation(16384, 57, 0, 0, false);
> +    check_creation(16384, 58, 4, 11, true);
> +    check_creation(16384, 59, 0, 0, false);
> +}
> +
> +static void test_single_entry(void)
> +{
> +    IOMMUTLBEntry entry = {
> +        .iova = 0x123456789000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 5,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 48);
> +    g_assert(atc);
> +
> +    assert_lookup_equals(atc, NULL, entry.pasid,
> +                         entry.iova + (entry.addr_mask / 2));
> +
> +    atc_create_address_space_cache(atc, entry.pasid);
> +    g_assert(atc_update(atc, &entry) == 0);
> +
> +    assert_lookup_equals(atc, NULL, entry.pasid + 1,
> +                         entry.iova + (entry.addr_mask / 2));
> +    assert_lookup_equals(atc, &entry, entry.pasid,
> +                         entry.iova + (entry.addr_mask / 2));
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_single_entry_2(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xabcdef200000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, 0xabcdef201000ULL);
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_page_boundaries(void)
> +{
> +    static const uint32_t pasid = 5;
> +    static const hwaddr page_size = 4096;
> +
> +    /* 2 consecutive entries */
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x123456789000ULL,
> +        .addr_mask = page_size - 1,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = e1.iova + page_size,
> +        .addr_mask = page_size - 1,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x900df00dULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    /* creating the address space twice should not be a problem */
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova - 1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova + e1.addr_mask);
> +    g_assert((e1.iova + e1.addr_mask + 1) == e2.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova + e2.addr_mask);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova + e2.addr_mask + 1);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid + 10, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid + 10, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_huge_page(void)
> +{
> +    static const uint32_t pasid = 5;
> +    static const hwaddr page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x123456600000ULL,
> +        .addr_mask = 0x1fffffULL,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    hwaddr addr;
> +
> +    ATC *atc = atc_new(page_size, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    for (addr = e1.iova; addr <= e1.iova + e1.addr_mask; addr += page_size) {
> +        assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    }
> +    /* addr is now out of the huge page */
> +    assert_lookup_equals(atc, NULL, e1.pasid, addr);
> +    atc_destroy(atc);
> +}
> +
> +static void test_pasid(void)
> +{
> +    hwaddr addr = 0xaaaaaaaaa000ULL;
> +    IOMMUTLBEntry e1 = {
> +        .iova = addr,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 8,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = addr,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xb001ULL,
> +    };
> +    uint16_t i;
> +
> +    ATC *atc = atc_new(4096, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    for (i = 0; i <= MAX(e1.pasid, e2.pasid) + 1; ++i) {
> +        if (i == e1.pasid || i == e2.pasid) {
> +            continue;
> +        }
> +        assert_lookup_equals(atc, NULL, i, addr);
> +    }
> +    assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    atc_destroy(atc);
> +}
> +
> +static void test_large_address(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaaaaaaaaa000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 8,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0x1f00baaaaabf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = e1.pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 57);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_bigger_page(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccdde000ULL,
> +        .addr_mask = 0x1fffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    hwaddr i;
> +
> +    ATC *atc = atc_new(8192, 43);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    i = e1.iova & (~e1.addr_mask);
> +    assert_lookup_equals(atc, NULL, e1.pasid, i - 1);
> +    while (i <= e1.iova + e1.addr_mask) {
> +        assert_lookup_equals(atc, &e1, e1.pasid, i);
> +        ++i;
> +    }
> +    assert_lookup_equals(atc, NULL, e1.pasid, i);
> +    atc_destroy(atc);
> +}
> +
> +static void test_unknown_pasid(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccfff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 48);
> +    g_assert(atc_update(atc, &e1) != 0);
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_invalidation(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccddf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xffe00000ULL,
> +        .addr_mask = 0x1fffffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xb000001ULL,
> +    };
> +    IOMMUTLBEntry e3;
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    atc_invalidate(atc, &e1);
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +
> +    /* invalidate a huge page by invalidating a small region */
> +    for (hwaddr addr = e2.iova; addr <= (e2.iova + e2.addr_mask);
> +         addr += page_size) {
> +        atc_update(atc, &e2);
> +        assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +        e3 = (IOMMUTLBEntry){
> +            .iova = addr,
> +            .addr_mask = page_size - 1,
> +            .pasid = e2.pasid,
> +            .perm = IOMMU_RW,
> +            .translated_addr = 0,
> +        };
> +        atc_invalidate(atc, &e3);
> +        assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    }
> +    atc_destroy(atc);
> +}
> +
> +static void test_delete_address_space_cache(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccddf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = e1.iova,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    atc_invalidate(atc, &e2); /* unkown pasid : is a nop*/
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e1);
> +    /* e1 has been removed but e2 is still there */
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_delete_address_space_cache(atc, e2.pasid);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_invalidate_entire_address_space(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x1000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xfffffffff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xbeefULL,
> +    };
> +    IOMMUTLBEntry e3 = {
> +        .iova = 0,
> +        .addr_mask = 0xffffffffffffffffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e3);
> +    /* e1 has been removed but e2 is still there */
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_reset(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x1000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xfffffffff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_reset(atc);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_get_max_number_of_pages(void)
> +{
> +    static uint64_t page_size = 4096;
> +    hwaddr base = 0xc0fee000; /* aligned */
> +    ATC *atc = atc_new(page_size , 48);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size / 2) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size + 1) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, 1) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size - 10) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         page_size - 10 + 1) == 2);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         page_size - 10 + 2) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 1) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 2) == 2);
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 3) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size * 20) == 21);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         (page_size * 20) + (page_size - 10))
> +                                          == 21);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         (page_size * 20) +
> +                                         (page_size - 10 + 1)) == 22);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/atc/test_creation_parameters", test_creation_parameters);
> +    g_test_add_func("/atc/test_single_entry", test_single_entry);
> +    g_test_add_func("/atc/test_single_entry_2", test_single_entry_2);
> +    g_test_add_func("/atc/test_page_boundaries", test_page_boundaries);
> +    g_test_add_func("/atc/test_huge_page", test_huge_page);
> +    g_test_add_func("/atc/test_pasid", test_pasid);
> +    g_test_add_func("/atc/test_large_address", test_large_address);
> +    g_test_add_func("/atc/test_bigger_page", test_bigger_page);
> +    g_test_add_func("/atc/test_unknown_pasid", test_unknown_pasid);
> +    g_test_add_func("/atc/test_invalidation", test_invalidation);
> +    g_test_add_func("/atc/test_delete_address_space_cache",
> +                    test_delete_address_space_cache);
> +    g_test_add_func("/atc/test_invalidate_entire_address_space",
> +                    test_invalidate_entire_address_space);
> +    g_test_add_func("/atc/test_reset", test_reset);
> +    g_test_add_func("/atc/test_get_max_number_of_pages",
> +                    test_get_max_number_of_pages);
> +    return g_test_run();
> +}
> -- 
> 2.48.1


