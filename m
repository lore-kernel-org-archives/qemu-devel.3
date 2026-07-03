Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BEBC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYX3-0007XF-HY; Fri, 03 Jul 2026 03:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfYX1-0007X5-IG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 03:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wfYWz-0003vd-3w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 03:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783064507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=15FO/MUPQvuB2QB4oOqtUJ++z6e/t02/gydVOJLFg+U=;
 b=BW5BD5wm9/OMQQNoyP+uDD/Y78yME1R4EVD+Y9Ff+vgIfOWxRkGG2LQGWdbLCEszy32gw8
 xMa+2LucweFMXKFTItOzUP5JAPcyrqXnW5oEVcnPfNrttE3QSHgAaHi93i88prFpjFNYv3
 BHv0TjAIHOfZlaGhvZbBbmgssTUI7ac=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-0NIIkfGVPnGr7mjnuCLRPw-1; Fri, 03 Jul 2026 03:41:45 -0400
X-MC-Unique: 0NIIkfGVPnGr7mjnuCLRPw-1
X-Mimecast-MFC-AGG-ID: 0NIIkfGVPnGr7mjnuCLRPw_1783064504
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-492714d002cso1798345e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783064504; x=1783669304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=15FO/MUPQvuB2QB4oOqtUJ++z6e/t02/gydVOJLFg+U=;
 b=X+te8EtdB4nJV3XYGnsn5cRn7GavtmGmkw5ulmYBwbLiDWKOUB908uBH8D5at/HV9T
 ZF7Iz9kUoMDFe73ljhC+nWriin9Eue7CLVVNROnV9H+R8HHIovs94BgrwbZpmU5/AOPf
 Soz0R62Z+DAVuO1EW7yQQq/xZHl3pv5tJz65rphzY7KX6QehzWP+nWaGL/3RLWRAwo8U
 4WpsHkML0SirMF96NKVNaD0JJbGcTwp7nJj78EWECKzN7EsM7kmpFlcEezRdLNw394Gj
 GDZiY36CMixUSVlRFPoC962AKCc7myar8BRyNwJNP+bWo+XZJ8E9dn4rqL7/cjsYic1F
 JwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783064504; x=1783669304;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15FO/MUPQvuB2QB4oOqtUJ++z6e/t02/gydVOJLFg+U=;
 b=p+L5leCPULrz5g/fWxbdi15W3X+kJiM3NRzH79/vTegpA1gxzxmKKOGMiSUfzuAm5f
 yu7xipePheKlpnTJU0zheuz9x204f8lGUWazxCrv79pe8PYMVELD4t2SFAIHMynMpEMf
 JWvPEGKo545h95U65IAG5U2sswnmT51tdERx+d2undKBdgZXh1/Rsi/CgxG4xdX3HdzE
 3+Bka2+eDNBbV5XebZGjIqgL4rmGOOl+ac0Y+lvtrMMw6GgaD6/khvdovvSiQTpBv5uz
 h64UuaMHtJu3zRcTJHo6qiDW9cVI75xNKdmkJ5ia7XTibcLdWwNYG6nm0wIhGwVn/kjr
 f9Zg==
X-Gm-Message-State: AOJu0YyTABXbObQ6odAPrXmfoztSKxqVydYpn2Pdi8ZthgvUOJUM9Zgr
 wjVIobqORbKpL3qX8USZazzM7I4ipcL8vw/GMY1Qz8VeXeFawCsC08qxAGYC/eeM7zJ2CG6+G9s
 6P8pFdFREMd4PvcegF2gnkZy0z8QLMM6BjijZSjqYL8We/XMoWnMuzEh7
X-Gm-Gg: AfdE7cmOg4eaTMBS/cvuEkMFw8I75Qh8r1R+FHmxSLfWPRnyOOXR2KzpYEq09wLSfrZ
 wUc3oO3bFpNZQ0qpHb16VI06t3DIB6D63zLwpPPXGVN/4k98CKHkY4iQ0HI5Bi9xnVIXrUY7WOJ
 XMkETve/edww0zXXvniquUqYFkaIfZ91C0jODgccWqlz3Bn5TU8gMhBraIRH8h6GYV5h9lRc2uJ
 sVxlvu217qtt61shn/z6DrxR89GkZgQMZa6qlR0dsS+GmNwzee8F+/76G+st0gFcq7gYKcpNTEq
 /uhoyptXw1rQEQsqVJ6akq/kYbQBj+SjkpgEjee7pgZygRkqGOlRGQ/mfg4FwwdsJGXuSJsiBaT
 eH7+t9NghaE3rNVMkMSx8kXX+n4/w+aNOCheyBXH14DZ5BFoA2Q==
X-Received: by 2002:a05:600c:3e83:b0:492:7019:caca with SMTP id
 5b1f17b1804b1-493cb5eefe7mr25221315e9.26.1783064504345; 
 Fri, 03 Jul 2026 00:41:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3e83:b0:492:7019:caca with SMTP id
 5b1f17b1804b1-493cb5eefe7mr25220995e9.26.1783064503832; 
 Fri, 03 Jul 2026 00:41:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm173634925e9.7.2026.07.03.00.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 00:41:43 -0700 (PDT)
Message-ID: <f8e76cd6-ca8f-4e44-8458-c228c96c6064@redhat.com>
Date: Fri, 3 Jul 2026 09:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] vfio queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260630043107.1511076-1-clg@redhat.com>
 <CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/2/26 21:24, Stefan Hajnoczi wrote:
> On Tue, Jun 30, 2026 at 6:33 AM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:
>>
>>    Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-vfio-20260630
>>
>> for you to fetch changes up to afe79bb7bf7fe16f418d6e10522946e13da04384:
>>
>>    vfio/listener: Fix translated_addr for non-identity-mapped RAM sections (2026-06-30 05:35:56 +0200)
> 
> Hi Cedric,
> This pull request breaks the migration test in the
> ubuntu-24.04-s390x-all-system CI job:
> https://gitlab.com/qemu-project/qemu/-/jobs/15157007316#L3078

Oh. Sorry about that. I didn't see that when I ran CI.

Thanks,

C.


> 
>>>> RUST_BACKTRACE=1 PYTHON=/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=./qemu-img MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_VNC_BINARY=./tools/qemu-vnc/qemu-vnc MALLOC_PERTURB_=226 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/tests/dbus-daemon.sh QTEST_QEMU_BINARY=./qemu-system-s390x ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon /home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k --full
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> Memory content inconsistency at 48b7000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48b8000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48b9000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48ba000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48bb000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48bc000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48bd000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48be000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48bf000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> Memory content inconsistency at 48c0000 first_byte = b5 last_byte = b4
> current = b5 hit_edge = 1
> and in another 6975 pages**
> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram:
> assertion failed: (bad == 0)
> (test program exited with status code -6)
> 
> Please take a look and resend the pull request with a fix.
> 
> Thanks,
> Stefan
> 
>>
>> ----------------------------------------------------------------
>> vfio queue:
>>
>> * Fixes ROM read issues in vfio/pci: information leak, error
>>    propagation, and uninitialized state
>> * Validates VERSION replies in vfio-user and updates the spec
>>    for DMA access mode bits
>> * Merges .dma_map_file() into .dma_map() in the iommufd backend
>> * Reworks switchover-ack to be re-usable and implements the
>>    VFIO_PRECOPY_INFO_REINIT feature for additional pre-copy
>>    iterations before switchover
>> * Adds ATS support for passthrough devices via iommufd
>> * Fixes translated_addr for non-identity-mapped RAM sections in
>>    the VFIO listener
>>
>> ----------------------------------------------------------------
>> Avihai Horon (14):
>>        migration: Propagate errors in migration_completion_precopy()
>>        migration/ram: Use migration_bitmap_sync_precopy() for postcopy discard
>>        migration: Run final save_query_pending at switchover
>>        migration: Log the approver in qemu_loadvm_approve_switchover()
>>        migration: Replace switchover_ack_needed SaveVMHandler
>>        migration: Rename switchover-ack code to legacy
>>        migration: Make switchover-ack re-usable
>>        migration: Fail migration if switchover-ack is requested after switchover decision
>>        vfio/migration: Extract VFIO_MIG_FLAG_DEV_INIT_DATA_SENT sending to helper
>>        vfio/migration: Add Error ** parameter to vfio_migration_init()
>>        vfio/migration: Add new switchover-ack mechanism
>>        vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
>>        vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
>>        migration: Enable new switchover-ack
>>
>> Cédric Le Goater (3):
>>        vfio/pci: Fix information leak in vfio_rom_read()
>>        vfio/iommufd: Merge .dma_map_file() into .dma_map()
>>        vfio/listener: Fix translated_addr for non-identity-mapped RAM sections
>>
>> GuoHan Zhao (1):
>>        vfio-user: validate VERSION replies
>>
>> Mario Casquero (2):
>>        vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
>>        vfio/pci: Propagate errors in vfio_pci_load_rom() using Error API
>>
>> Mattias Nissler (1):
>>        docs: Update vfio-user spec to describe DMA access mode bits
>>
>> Nathan Chen (2):
>>        iommufd: Introduce handler for device ATS support
>>        vfio/pci: Add ats property
>>
>>   docs/devel/migration/vfio.rst      |  17 +++-
>>   docs/interop/vfio-user.rst         |  82 +++++++++------
>>   qapi/migration.json                |  14 ++-
>>   hw/vfio/pci.h                      |   1 +
>>   hw/vfio/vfio-migration-internal.h  |   2 +
>>   include/hw/vfio/vfio-container.h   |  15 ---
>>   include/migration/client-options.h |   1 +
>>   include/migration/misc.h           |   2 +
>>   include/migration/register.h       |  56 +++++-----
>>   include/system/host_iommu_device.h |   9 ++
>>   migration/migration.h              |  34 ++++++-
>>   migration/savevm.h                 |   9 +-
>>   backends/iommufd.c                 |   8 ++
>>   hw/core/machine.c                  |   1 +
>>   hw/s390x/s390-stattrib.c           |   2 +-
>>   hw/vfio-user/proxy.c               |  21 ++--
>>   hw/vfio/container.c                |  38 -------
>>   hw/vfio/iommufd.c                  |  50 ++++++---
>>   hw/vfio/listener.c                 |   5 +-
>>   hw/vfio/migration.c                | 204 +++++++++++++++++++++++++++++--------
>>   hw/vfio/pci.c                      | 129 +++++++++++++++++++----
>>   migration/block-dirty-bitmap.c     |  11 +-
>>   migration/migration.c              |  73 ++++++++++---
>>   migration/options.c                |   9 ++
>>   migration/ram.c                    |  40 ++++----
>>   migration/savevm.c                 | 173 +++++++++++++++++++++----------
>>   hw/vfio/trace-events               |   7 +-
>>   migration/trace-events             |   9 +-
>>   28 files changed, 709 insertions(+), 313 deletions(-)
>>
>>
> 


