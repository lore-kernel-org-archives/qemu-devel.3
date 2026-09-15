Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED4CC88E73
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6O4i-0005yH-Gl; Tue, 15 Sep 2026 03:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6O4g-0005ud-RS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6O4c-0000mk-SG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789459166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KpEN/V1anesxikKA/1wy43C1Kysj3MTmD28jAl8RzCI=;
 b=QM1ZBapzVgH+XXEPl8LIP9/IER+ss0C8q/df0SBW7rE3HuKCMBxkF58OsW1t5+1ychVSgY
 kJZ34VsUgjW9newTIsCAN66fVIkxFng7L54sR4vYJ6XvG4GXf8qi0T9MMpnNqXK0X6blQs
 b15F+yxZLmH+8inqJy6DgboZH5Vn0TI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-MnKcX17pP2GjAGPVhtW56Q-1; Tue, 15 Sep 2026 03:59:24 -0400
X-MC-Unique: MnKcX17pP2GjAGPVhtW56Q-1
X-Mimecast-MFC-AGG-ID: MnKcX17pP2GjAGPVhtW56Q_1789459163
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso39037415e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789459163; x=1790063963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KpEN/V1anesxikKA/1wy43C1Kysj3MTmD28jAl8RzCI=;
 b=C8ln7zy4qC3WNBvJPJf1B3z+8ZKAQpSJ1+k5gZ3N3FAlxbK0zB0MQe8idq69vcdJ58
 MQeLyvN7BUvmcNxoIBxJqIz4CcXAfquOM/OSsVfBVfwMhWDvNOh8SwBhjBsRvuWMyBVY
 5b9Zwp6PWWwcQX8JBwsREUKk8uIPEHZhf2Mop3bLQJFSq1hWwo7CBjxIcYTCjOVFJQUl
 L+pRVcggs91Tz9KYt63TqT8n1jT+HNpP3Yn/MX2VG6cH/0/EroMHpUcotqg5bSLM5R/f
 ego7pJNuBu0Lvgtpo8XbRs8wB3LFM1kNaGNIk9NPpikcYBW+B88JBVVQ/qCW3/1AWSV8
 cF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459163; x=1790063963;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KpEN/V1anesxikKA/1wy43C1Kysj3MTmD28jAl8RzCI=;
 b=rPlfIcXz8gdMBBMeQQZUxXEGi6XmSI7AjyIwy3izO9DWxigTbUJ3LhDGaR4DBt4Iba
 U2CWtIdFsIzBJ3XtGzuX86dZSuC2AdjlDrEnUHJ5DB0J2K6JRbGM+o0oiHCq+gUAzmjN
 5NwN22hzKhdrOmYYbDzDsyqWFFnS8lLyNLFm4rOYO0m+dyFGq+Ii1dRby7grYX35tQtj
 03Ag96EkB+48Nz2UzeswwRXCIFSARkyQfCDB64MdbTZfQ9MoKrFCk/3Mc8Yc4JFYccpo
 d0iAbozkdzLQpKcCDZNgBPUOhZU/itHRidztbteahmXLgT7q6HhS4S5wqjpt+Ol/MH9z
 B+wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbvdc20XE3NIhHZqtyE92Avp1akLTWTGMrOGS8OgaI7sBE+A4dUGkw9QCCiV36c1M7mNm6rqOWnrUP@nongnu.org
X-Gm-Message-State: AFuF++n0XcvvrGzRGNtUxiaxqQuN+Ur1ygUIerScV7GZLqDHIHPh9JRE
 CG84S9Tvp941dr+E42/fd/U+j1RYFzeA6/si7kXjYIJe0qyIBoWpHDLTds9+8axi65N4zK+FqeW
 D0g9Kcm+P7oeqKAAS+14bbWu0zvmIbty6x9UW4S/dyEr/xt6LTHw9XVPA
X-Gm-Gg: AYBFou0nYkXAfJ+rxffcibuGBw/pOyCjFCJCz5/9M9/9OV02OydONeJFxvHHPWFzwRA
 ABHfbfSYBVYSVGXQVbBS93jg39ljDilYjtz0f67oKJTAEhlh6c9T4psqnBFuxbdNtbdni46Q+Pp
 jtSRMjo9WdIqfJBzS7X48/zwcKHb49rOKqhsf4KBddDfweV9UeY4KpGNIQtTK+NaB+XLS7ztzGh
 OvmTeh5hA4ezzu/qcc/dAJs4MIofVHT1HNQ/hKBHYaeFDWD45Sv8vmvjhVeo6GxiJLALXXT8Z87
 Y4hOwpuJ9ZBhvzBOgjNpS7G0ctrleXX779tV7MDM/5ndwybikpJkqgbNK1BUa5LGnAMDYCx5RP4
 1px8IY53JF5h82SidyiuQkvZQyXCgel9biWT56SetGw==
X-Received: by 2002:a05:600c:1993:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49e8221252dmr1202725e9.10.1789459162594; 
 Tue, 15 Sep 2026 00:59:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-49e8221252dmr1202325e9.10.1789459161992; 
 Tue, 15 Sep 2026 00:59:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef80010sm43175475e9.11.2026.09.15.00.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 00:59:21 -0700 (PDT)
Message-ID: <f3e4fe26-d9cf-4ff8-8899-aeb398478199@redhat.com>
Date: Tue, 15 Sep 2026 09:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 9/9] docs: Add igb VF migration testing setup guide
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-10-clg@redhat.com>
 <6c1b17a8-d9a5-4238-89af-d121838c525b@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6c1b17a8-d9a5-4238-89af-d121838c525b@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/26 10:39, Akihiko Odaki wrote:
> On 2026/09/03 4:20, Cédric Le Goater wrote:
>> Document the igb VF migration interface: DVSEC register layout, dirty
>> page tracking, testing setup with nested virtualization.
>>
>> AI-used-for: docs
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                           |   1 +
>>   docs/system/device-emulation.rst      |   1 +
>>   docs/system/devices/igb-migration.rst | 417 ++++++++++++++++++++++++++
>>   docs/system/devices/igb.rst           |   6 +
>>   4 files changed, 425 insertions(+)
>>   create mode 100644 docs/system/devices/igb-migration.rst
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f88b526be238..4a2f1357e936 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2820,6 +2820,7 @@ igb VF migration
>>   M: Cédric Le Goater <clg@redhat.com>
>>   S: Maintained
>>   F: hw/net/igb_migration.*
>> +F: docs/system/devices/igb-migration.rst
>>   eepro100
>>   M: Stefan Weil <sw@weilnetz.de>
>> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
>> index 40054bb7dfcc..75f423b795cd 100644
>> --- a/docs/system/device-emulation.rst
>> +++ b/docs/system/device-emulation.rst
>> @@ -90,6 +90,7 @@ Emulated Devices
>>      devices/cxl.rst
>>      devices/emmc.rst
>>      devices/igb.rst
>> +   devices/igb-migration.rst
>>      devices/ivshmem-flat.rst
>>      devices/ivshmem.rst
>>      devices/keyboard.rst
>> diff --git a/docs/system/devices/igb-migration.rst b/docs/system/devices/igb-migration.rst
>> new file mode 100644
>> index 000000000000..d72f14f5fe63
>> --- /dev/null
>> +++ b/docs/system/devices/igb-migration.rst
>> @@ -0,0 +1,417 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +.. _igb-migration:
>> +
>> +igb VF Migration
>> +----------------
>> +
>> +Live migration of VFIO-passthrough devices (SR-IOV VFs, vGPUs) is a
>> +growing requirement, but real hardware with migration support is scarce
>> +and hard to debug. An emulated device provides a fully controlled
>> +testbed for developing and validating the entire software stack --
>> +vfio-pci variant drivers, VFIO core migration v2 framework, QEMU,
>> +libvirt -- and for tuning complex migration policies such as downtime
>> +convergence. It also serves as an educational reference for
>> +understanding VFIO migration end-to-end, from device state
>> +serialization to dirty page tracking.
>> +
>> +The igb device supports an experimental VF migration interface that allows
>> +the `igb-vfio-pci`_ variant driver to migrate VF state during live
>> +migration using the standard VFIO migration v2 protocol with stop-copy
>> +and pre-copy support.
>> +
>> +This is enabled with the ``x-vf-migration`` property::
>> +
>> +  -device igb,x-vf-migration=on,...
>> +
>> +Each emulated VF then advertises a DVSEC discovered by the
>> +`igb-vfio-pci`_ variant driver at bind time. This feature is
>> +experimental (``x-`` prefix, default off).
>> +
>> +Architecture
>> +~~~~~~~~~~~~
>> +
>> +The target scenario is nested virtualization::
>> +
>> +  L0 QEMU
>> +    igb PF with x-vf-migration=on
>> +    └── VFs with migration DVSEC
>> +
>> +  L1 kernel
>> +    igb-vfio-pci variant driver
>> +    translates VFIO migration v2 ioctls → DVSEC config writes
>> +
>> +  L1 QEMU (stock, unmodified)
>> +    vfio-pci device model, standard migration fd
>> +
>> +  L2 guest
>> +    standard igbvf driver, unaware of migration
>> +
>> +The L1 QEMU is completely unmodified -- it sees a standard VFIO
>> +migratable device and uses the normal migration fd path. The
>> +`igb-vfio-pci`_ variant driver handles the translation between
>> +VFIO migration v2 ioctls and DVSEC config writes.
>> +
>> +Design
>> +~~~~~~
>> +
>> +The migration interface is exposed through a DVSEC at offset 0x160
>> +in VF extended config space (see `DVSEC register layout`_ below for
>> +the full register map).
>> +
>> +Device state is serialized as a versioned blob of per-VF register
>> +(offset, value) pairs covering control, interrupt, RX/TX queue,
>> +receive address (RA/RA2), etc. plus TX context descriptors and
>> +VFRE/VFTE enable bits. The buffer address is a guest physical address
>> +(GPA) written by the driver via ``virt_to_phys``; the device accesses
>> +guest RAM directly through the system address space.
>> +
>> +Dirty page tracking is implemented with per-range bitmaps maintained
>> +in IGBCore. All VF DMA paths in ``igb_core.c`` (TX data, RX data,
>> +descriptor writeback) are instrumented to record touched pages. The
>> +`igb-vfio-pci`_ variant driver registers tracked IOVA ranges and
>> +queries dirty bitmaps through a shared buffer. Buffer structures
>> +include len, flags, and reserved fields for future extensibility.
>> +
>> +The dirty bitmaps are maintained inside the device, which is not
>> +realistic for discrete NICs without on-chip DRAM.
>> +
>> +DVSEC register layout
>> +~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The migration DVSEC (36 bytes at offset ``0x160``) uses a command
>> +doorbell model. All commands are synchronous -- the device completes
>> +the operation before the config write returns::
>> +
>> +  Offset  Name          Access  Description
>> +  +0x00   ExtCap Hdr    RO      PCIe extended cap (id=0x23, ver=1)
>> +  +0x04   DVSEC Hdr 1   RO      length[31:20] | rev[19:16] | vendor_id[15:0]
>> +  +0x08   DVSEC Hdr 2   RO      DVSEC ID (1)
>> +  +0x0A   Reserved      -       Padding for DWORD alignment
>> +  +0x0C   CAPS          RO      F_STATE[0], F_DIRTY[1], max_ranges[11:8], pgsize[16:12]
>> +  +0x10   CTRL          WO      Doorbell: cmd[7:0], arg[31:8]
>> +  +0x14   STATUS        RO      state[7:0], error_code[15:8], quiesced[16]
>> +  +0x18   BUF_ADDR_LO   RW      Shared DMA buffer GPA (low 32 bits)
>> +  +0x1C   BUF_ADDR_HI   RW      Shared DMA buffer GPA (high 32 bits)
>> +  +0x20   DATA_SIZE     RO      State blob size in bytes
>> +
>> +CTRL commands::
>> +
>> +  Cmd  Name            Arg             Description
>> +  1    SET_STATE       state[31:8]     Set migration state
>> +  2    SAVE            -               DMA-write state to buffer
>> +  3    LOAD            size[31:8]      DMA-read state from buffer
>> +  4    DIRTY_ENABLE    -               Enable dirty tracking (params in DMA buffer)
>> +  5    DIRTY_DISABLE   -               Disable dirty tracking
>> +  6    DIRTY_QUERY     -               Query dirty bitmap (via DMA buffer)
>> +  7    GET_STATS       -               Query statistics (via DMA buffer)
>> +
>> +The driver sets ``BUF_ADDR_LO/HI`` before issuing commands that use a
>> +DMA buffer (SAVE, LOAD, DIRTY_ENABLE, DIRTY_QUERY, GET_STATS). The
>> +buffer address is latched per CTRL write, so the driver can use
>> +different buffers for different commands. The buffer address is a
>> +guest physical address (GPA).
>> +
>> +State transitions follow the VFIO migration v2 state machine. The
>> +driver issues ``SET_STATE`` with the target state in the arg field and
>> +reads ``STATUS`` to confirm the transition. Device states::
>> +
>> +  0  ERROR       1  STOP       2  RUNNING
>> +  3  STOP_COPY   4  RESUMING   5  PRE_COPY
>> +
>> +``DATA_SIZE`` reflects the state blob size. At reset and in ``STOP``
>> +state it holds the maximum size the driver should allocate. After
>> +``SET_STATE(STOP_COPY)`` or ``SAVE`` it holds the actual serialized
>> +size. The driver reads it after entering ``STOP_COPY`` to allocate an
>> +exact-sized DMA buffer before issuing ``SAVE``.
>> +
>> +The state blob is a versioned sequence of register (offset, value)
>> +pairs with magic ``0x4D494742`` ("MIGB").
>> +
>> +When ``STATUS`` state is ``ERROR`` (0), bits [15:8] contain an error
>> +code identifying the failure::
>> +
>> +  1   UNK_CMD           Unknown CTRL command
>> +  2   BAD_STATE         Command issued in wrong migration state
>> +  3   NO_BUFFER         Command requires buffer but BUF_ADDR not set
>> +  4   DMA_FAILED        DMA transfer to/from buffer failed
>> +  5   BAD_SIZE          State blob too large or empty
>> +  6   BAD_MAGIC         State blob magic mismatch
>> +  7   BAD_VERSION       State blob version mismatch
>> +  8   TOO_MANY_RANGES   Exceeds max_ranges from CAPS
>> +  9   BAD_RANGE         Invalid range (zero size, misaligned, not contained)
>> +  10  BAD_PGSIZE        Invalid or misaligned page size
>> +  11  NOT_ENABLED       Dirty query without prior enable
>> +
>> +Dirty page tracking
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +The migration interface supports per-VF dirty page tracking, advertised
>> +by the ``F_DIRTY`` flag (bit 1) in ``CAPS``. This allows the variant
>> +driver to enter ``PRE_COPY`` state while the VM continues to run,
>> +iterating on dirty pages to reduce the final stop-and-copy window.
>> +
>> +The device maintains one dirty tracking engine per range, each with its
>> +own bitmap scoped to the range boundaries. The ``CAPS`` register
>> +advertises the maximum number of ranges in bits [11:8].
>> +
>> +Dirty tracking is controlled through CTRL commands:
>> +
>> +- **DIRTY_ENABLE** (4): the driver fills an ``igb_mig_dirty_enable_req``
>> +  struct in the DMA buffer with the page size, range IOVA, and range
>> +  size, then issues the command. The device allocates a bitmap for the
>> +  range and begins recording pages touched by DMA. Supported page sizes
>> +  are advertised in ``CAPS`` bits [16:12] (bit N = 2^N bytes). The driver
>> +  checks ``STATUS`` for errors after the command completes.
>> +- **DIRTY_DISABLE** (5): tears down all ranges and stops tracking.
>> +- **DIRTY_QUERY** (6): the driver writes (iova, size) into the
>> +  ``igb_mig_dirty_query`` DMA buffer, then issues the command. The
>> +  device validates the range, copies the dirty bitmap into the buffer,
>> +  and clears the tracked bits after successful DMA. The driver checks
>> +  ``STATUS`` for errors after the command.
>> +
>> +Dirty enable DMA buffer
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The ``DIRTY_ENABLE`` command reads its parameters from the DMA buffer.
>> +The ``len`` field holds the total structure size (including reserved
>> +bytes) so the device can detect newer formats. ``flags`` and
>> +``reserved`` must be zero::
>> +
>> +  Offset  Field        Type      Description
>> +  0x00    len          uint32    Structure size in bytes
>> +  0x04    flags        uint32    Reserved, must be 0
>> +  0x08    pgsize       uint64    Page granularity (must match a CAPS pgsize bit)
>> +  0x10    range_iova   uint64    Tracked range start address
>> +  0x18    range_size   uint64    Tracked range size in bytes
>> +  0x20    reserved[4]  uint32    Reserved, must be 0
>> +
>> +Dirty query DMA buffer
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The ``DIRTY_QUERY`` command uses a shared DMA buffer for both request
>> +and response. The ``len`` field holds the total buffer size (header +
>> +bitmap). ``flags`` and ``reserved`` must be zero::
>> +
>> +  Offset  Field              Written by  Description
>> +  0x00    len                driver      Total buffer size in bytes
>> +  0x04    flags              driver      Reserved, must be 0
>> +  0x08    iova               driver      Query range start
>> +  0x10    size               driver      Query range size
>> +  0x18    bitmap_size        device      Bytes written to bitmap
>> +  0x1C    dirty_page_count   device      Number of set bits
>> +  0x20    dma_writes         device      DMA write count (diagnostic)
>> +  0x28    reserved[6]        -           Reserved, must be 0
>> +  0x40    bitmap[]           device      Dirty page bitmap
>> +
>> +Migration statistics
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +The ``GET_STATS`` command DMA-writes a statistics response into the
>> +driver-provided buffer. The driver sets ``BUF_ADDR_LO/HI`` and issues
>> +the command; the device writes the response and returns::
>> +
>> +  Offset  Field                Type      Description
>> +  0x00    dma_writes           uint64    DMA write operations tracked
>> +  0x08    dma_bytes            uint64    DMA bytes written
>> +  0x10    dirty_pages_set      uint32    Dirty pages marked since enable
>> +  0x14    dirty_pages_cleared  uint32    Dirty pages cleared by queries
>> +  0x18    dirty_page_count     uint32    Current dirty pages (set - cleared)
>> +  0x1C    dirty_query_count    uint32    Number of QUERY operations
>> +
>> +The variant driver exposes these via debugfs at
>> +``/sys/kernel/debug/vfio/<device>/migration/dirty/stats``.
>> +
>> +Testing setup
>> +~~~~~~~~~~~~~
>> +
>> +The target scenario is nested virtualization: L0 runs QEMU with an
>> +igb PF (``x-vf-migration=on``), L1 runs the `igb-vfio-pci`_ variant
>> +driver and an unmodified QEMU, and L2 runs a standard igbvf driver.
>> +See `Architecture`_ above for the full stack diagram.
>> +
>> +NetworkManager configuration
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In a nested setup, the L1 VMs (source and destination) have emulated
>> +igb PFs connected to the L0 bridge. By default, NetworkManager
>> +acquires DHCP leases on those PF interfaces and on any igb VFs created
>> +later. This causes the VF MAC address to be learned on the L0 bridge,
>> +which can misdirect iperf3 traffic after migration.
>> +
>> +To prevent this, configure NetworkManager on **both L1 VMs** and on the
>> +**L2 guest disk image**.
>> +
>> +L1 VMs (source and destination)
>> +...............................
>> +
>> +1. Prevent NetworkManager from managing igbvf interfaces:
>> +
>> +.. code-block:: bash
>> +
>> +   cat > /etc/NetworkManager/conf.d/99-no-igbvf.conf <<EOF
>> +   [keyfile]
>> +   unmanaged-devices=driver:igbvf
>> +   EOF
>> +
>> +2. Disable IP on the igb PF connections (keep the interfaces UP for
>> +   bridging, but with no DHCP lease):
>> +
>> +.. code-block:: bash
>> +
>> +   # Identify the NM connections for the igb PFs (NOT the virtio management NIC)
>> +   nmcli -t -f NAME,DEVICE connection show
>> +
>> +   # For each igb PF connection:
>> +   nmcli connection modify "<igb-pf-connection>" ipv4.method disabled ipv6.method disabled
>> +
>> +3. Reload NetworkManager:
>> +
>> +.. code-block:: bash
>> +
>> +   nmcli general reload
>> +
>> +L2 guest disk image
>> +...................
>> +
>> +Use ``virt-customize`` to add the igbvf unmanaged config to the guest
>> +image (offline, before any test run):
>> +
>> +.. code-block:: bash
>> +
>> +   virt-customize -a /srv/migration/rhel10.qcow2 \
>> +     --write /etc/NetworkManager/conf.d/99-no-igbvf.conf:'[keyfile]
>> +   unmanaged-devices=driver:igbvf'
>> +
>> +Network diagram
>> +^^^^^^^^^^^^^^^
>> +
>> +The diagram below shows the nested setup where the source and
>> +destination hosts are themselves VMs (L1) running on a physical
>> +host (L0) that emulates the igb NIC::
>> +
>> +  ┌────────────────────────────────────────────────────────────────────────────┐
>> +  │  L0: physical host                                                         │
>> +  │                                                                            │
>> +  │  virbr0  192.168.199.1/24                                                  │
>> +  │  ├── NFS server: /srv/migration                                            │
>> +  │  └── iperf3 client: iperf3 -c 192.168.199.200 -t 60 -i 1                   │
>> +  │      │                                                                     │
>> +  │      │  L0 virbr0 bridge (192.168.199.0/24)                                │
>> +  │  ────┼──────────┬──────────────────┬──────────────────────────────         │
>> +  │      │          │                  │                                       │
>> +  │      │     ┌────┴────┐        ┌────┴────┐                                  │
>> +  │      │     │ virtio  │        │ emulated│                                  │
>> +  │      │     │c0:ff:ee:│        │  igb PF │    L0 QEMU (vm6)                 │
>> +  │      │     │ :00:06  │        │ + igbvf │    tracks DMA dirty pages        │
>> +  │      │     └────┬────┘        └────┬────┘                                  │
>> +  │      │          │                  │                                       │
>> +  │  ┌───┼──────────┼──────────────────┼──────────────────────────────────┐    │
>> +  │  │   │  L1: vm6 (source)           │                                  │    │
>> +  │  │   │  enp1s0: 192.168.199.6      │                                  │    │
>> +  │  │   │  (management)               │                                  │    │
>> +  │  │   │                        enp8s0 (igb PF, no IP)                  │    │
>> +  │  │   │                             │                                  │    │
>> +  │  │   │                        igb VF0 ──► igb-vfio-pci (VFIO)         │    │
>> +  │  │   │                             │      dirty_sync → L0 igbvf       │    │
>> +  │  │   │                             │                                  │    │
>> +  │  │   │   virbr0                    │ VFIO passthrough                 │    │
>> +  │  │   │   192.168.200.1/24          │                                  │    │
>> +  │  │   │       │                     │                                  │    │
>> +  │  │   │  ┌────┼─────────────────────┼───────────────────────────┐      │    │
>> +  │  │   │  │    │  L2: rhel10 guest   │                           │      │    │
>> +  │  │   │  │    │                     │                           │      │    │
>> +  │  │   │  │  virtio NIC           igb VF (enp7s0)                │      │    │
>> +  │  │   │  │  192.168.200.130/24   192.168.199.200/24             │      │    │
>> +  │  │   │  │  (SSH login)          (iperf3 data path)             │      │    │
>> +  │  │   │  │                          │                           │      │    │
>> +  │  │   │  │            iperf3 -s -D  │ (listens on 0.0.0.0)      │      │    │
>> +  │  │   │  └──────────────────────────┼───────────────────────────┘      │    │
>> +  │  │   │                             │                                  │    │
>> +  │  │   │  virsh migrate --live ──────┼──────────────────► vm7           │    │
>> +  │  │   │                             │                                  │    │
>> +  │  └───┼─────────────────────────────┼──────────────────────────────────┘    │
>> +  │      │                             │                                       │
>> +  │      │          iperf3 traffic     │                                       │
>> +  │      └─────────────────────────────┘                                       │
>> +  │                                                                            │
>> +  │  ────────────────────────────────────────────────────────────────          │
>> +  │      │                  │                                                  │
>> +  │      │     ┌────────┐   │   ┌─────────┐                                    │
>> +  │      │     │ virtio │   │   │emulated │    L0 QEMU (vm7)                   │
>> +  │      │     │c0:ff:ee│   │   │ igb PF  │                                    │
>> +  │      │     │ :00:07 │   │   │ + igbvf │                                    │
>> +  │      │     └────┬───┘   │   └────┬────┘                                    │
>> +  │  ┌──────────────┼───────┼────────┼────────────────────────────────────┐    │
>> +  │  │   L1: vm7 (destination)       │                                    │    │
>> +  │  │   enp1s0: 192.168.199.7       │                                    │    │
>> +  │  │   (management)           enp8s0 (igb PF, no IP)                    │    │
>> +  │  │                               │                                    │    │
>> +  │  │                          igb VF0 ──► igb-vfio-pci (VFIO)           │    │
>> +  │  │                               │                                    │    │
>> +  │  │   virbr0                      │ VFIO passthrough                   │    │
>> +  │  │   192.168.200.1/24            │                                    │    │
>> +  │  │       │                       │                                    │    │
>> +  │  │  ┌────┼───────────────────────┼────────────────────────────┐       │    │
>> +  │  │  │    │  L2: rhel10 (after migration)                      │       │    │
>> +  │  │  │    │                       │                            │       │    │
>> +  │  │  │  virtio NIC             igb VF (enp7s0)                 │       │    │
>> +  │  │  │  192.168.200.130/24     192.168.199.200/24              │       │    │
>> +  │  │  │                            │                            │       │    │
>> +  │  │  │              iperf3 -s -D  │ (connection survives)      │       │    │
>> +  │  │  └────────────────────────────┼────────────────────────────┘       │    │
>> +  │  └───────────────────────────────┼────────────────────────────────────┘    │
>> +  │                                  │                                         │
>> +  │      iperf3 traffic resumes ─────┘                                         │
>> +  │      (same IP, same MAC, same L2 segment → transparent to client)          │
>> +  └────────────────────────────────────────────────────────────────────────────┘
>> +
>> +Migration under iperf3 load works correctly: dirty page tracking
>> +converges (from ~2000 pages per PRE_COPY iteration down to ~280 at
>> +STOP_COPY), and STOP_COPY stays under 250ms.
>> +
>> +Todo
>> +~~~~
>> +
>> +1. Add migration blocker when ``x-vf-migration=on`` (no VMState yet) or
>> +   add VMState support for L0 migration (dirty bitmaps, tracking
>> +   engines, DVSEC registers, stats)
>> +2. Add PRE_COPY state transfer to validate device INIT data (magic,
>> +   version, etc.)
>> +3. Add qtests for migration state machine transitions, dirty page
>> +   tracking
>> +
>> +Ideas
>> +~~~~~
>> +
>> +1. **RX bandwidth throttle** (``x-mig-rx-limit``, uint32, default 0)
>> +
>> +   Return false from ``can_receive`` when the per-VF packet count in the
>> +   current tracking interval exceeds the limit. Reduces DMA writes and
>> +   dirty pages realistically.
>> +
>> +2. **Migration phase timing** (GET_STATS extension)
>> +
>> +   Add per-VF timestamps: ``precopy_start_ns``, ``stopcopy_start_ns``,
>> +   ``precopy_duration_ns``, ``stopcopy_duration_ns``,
>> +   ``state_transition_count``. Expose via GET_STATS.
>> +
>> +3. **Hot page simulation** (``x-mig-hot-pages``, uint32, default 0)
>> +
>> +   Re-set the first N bitmap bits after each DIRTY_QUERY, simulating
>> +   workloads with hot pages that prevent convergence.
>> +
>> +4. **Error injection** (``x-mig-inject-error``, uint32, default 0)
>> +
>> +   One-shot error code injection before command dispatch. A separate
>> +   ``x-mig-inject-dma-fail`` (bool) for persistent DMA failure testing.
>> +
>> +AI disclaimer
>> +~~~~~~~~~~~~~
>> +
>> +Claude was used to analyze the IGB PF and VF internal state and
>> +identify the pain points of a working live migration of such devices.
>> +The generated code served as a starting point but *significant* time
>> +was then spent cleaning up, reworking, and shaping it into a clear,
>> +reviewable IGB model extension.
> 
> I don't think it's really a good idea to keep this "AI disclaimer" in the documentation.

Agree. No need.

Thanks,

C.

> 
>> +
>> +.. _igb-vfio-pci: https://github.com/legoater/vfio-pci-extras
>> diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
>> index 50f625fd77e4..00271dbc92c3 100644
>> --- a/docs/system/devices/igb.rst
>> +++ b/docs/system/devices/igb.rst
>> @@ -64,6 +64,12 @@ command:
>>     pyvenv/bin/meson test --suite thorough func-x86_64-netdev_ethtool
>> +VF Migration (experimental)
>> +===========================
>> +
>> +See :ref:`igb-migration` for details on the experimental VF live migration
>> +interface.
>> +
>>   References
>>   ==========
> 


