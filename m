Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53706CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 07:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwbHr-0001gB-Ah; Thu, 11 Sep 2025 03:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwbHo-0001f5-LW
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 03:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwbHm-0006RI-9c
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757573998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a3LX9j+iYUbS5u2AF7Spyao1BmPC1PeWZVhBwNw2rI=;
 b=WoXxiFPIWx+inkQn0uV10ArOOICZITJyXsRGdb9zKDidWXCDdS0MUcVzJLpKb2tkEPyq1I
 YkOg5QbMs/WebBj/R/ea7a0aaxTwRWGC76BM6WcfHFkjn2tn8l3Wd4yUNyE4QbwL7oAZOP
 Jd9ZpYRaFcoPhRPSr40C6nPPvnVQM/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-qUH7z6aLOji-73ybnIKOhQ-1; Thu, 11 Sep 2025 02:59:57 -0400
X-MC-Unique: qUH7z6aLOji-73ybnIKOhQ-1
X-Mimecast-MFC-AGG-ID: qUH7z6aLOji-73ybnIKOhQ_1757573996
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so2049075e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 23:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757573996; x=1758178796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0a3LX9j+iYUbS5u2AF7Spyao1BmPC1PeWZVhBwNw2rI=;
 b=k7KTlj1um+AVYDX0YImqJPwz3fjEuDvhBMAelbY0mMnJJnDC6PLQG2NpuBCa0TuA+O
 QyvjYOguDEvqMUGkD5MsVUT9O9UvP4zVw9cWE3onkgruYd17Xn/694bNKKZ1UsaN04Qr
 qku0DbhiUKxuwt1QJbeE8lkKxdetpwgTRoQyJBDyG0tWrQyXx8K1NwFYeUUiWCWxvTjL
 6eoQ6eqR4iwWPFNAFC/R9HVule8BXu6pPZIf73Dt9jhDKepa1eXGT9eERnjHgnKKMrvI
 B2tJl/FVE8qgfoK4SZn06bD8MXn2ropgVHjz2PQKO5rNMSwbK+gsM7XcGJtmS+0X0nfn
 j0Lw==
X-Gm-Message-State: AOJu0Yx/bQ63L57J8H6qdbVdPo76Pp17bttSsSSgl89XIS62AtJMU5uK
 aDFEGJ3KTsJMZpNiTiJ5xnqJ+1HSPzKkt9K6o4sy1tCM7xPC5lzSemnEBi8An8npmBkggpI0ztP
 kI+/tsvH7J6JLsJRHFf6q2L8fKDcMbOdmMprSLqb5v3QNU0pdHwaoteyS
X-Gm-Gg: ASbGncvmIxAK78ypHGdlDJ+a0qz73eHFNjK5VXUbduOEYYqURwhGOFQSIAxBslhsbgt
 EvvwY4G0eWFKlCKPSsi3jQY6FO0oC59I5ToZgtDp9NC96+ZjSwzF/jfcB4pOV8lVpiS6YYCdA1v
 Xx0biXEnkVsrfgDK14ZgwouifrBBYXJFLWX9V99TBTwG/UC/+HIHT9Uj4t+C9sFzU1Dauj7S8zd
 KyTUzKIj6ZaBw4I3EO5S7qTx9CkKa7yUG8qLO3PVUOTeb1cUC30nBN9dBNwi/Up/FvJNa1DsQFK
 Uwx/eY4GrOCfRW3dzLoShlzZINxO25im
X-Received: by 2002:a05:600c:3b8b:b0:45d:d356:c358 with SMTP id
 5b1f17b1804b1-45dddec3b92mr211069835e9.16.1757573995892; 
 Wed, 10 Sep 2025 23:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcslQCb/9kUpL7mo/p06fktSJqcLTfgFWtg04D8p5/EqZLVpAI02q2PC+LrwneEv8WIWEeYQ==
X-Received: by 2002:a05:600c:3b8b:b0:45d:d356:c358 with SMTP id
 5b1f17b1804b1-45dddec3b92mr211069405e9.16.1757573995460; 
 Wed, 10 Sep 2025 23:59:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037186e5sm11784755e9.5.2025.09.10.23.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:59:54 -0700 (PDT)
Date: Thu, 11 Sep 2025 02:59:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <20250911025906-mutt-send-email-mst@kernel.org>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Aug 07, 2025 at 04:39:25PM +0200, Magnus Kulke wrote:
> Hey all,
> 
> This is the third revision of a patch set implementing an accelerator
> for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in various
> scenarios. Thank you for the feedback so far. Since the last revision we
> incorporated feedback from the last review and identified further areas for
> performance fixes, notably in the irqfd handling. I'm looking forward to your
> comments.
> 
> Best regards,
> 
> magnus


So regarding merging plans. Did you guys get in touch
with Sunil? That's the easiest smoothest path, through
an existing maintainer.


> Changelog:
> 
> v2 => v3
> 
> - Addressed code review comments (style)
> - Reserve GSI 01-23 for IO-APIC pins (this resolved a problem in which MSI
>   routes would be overwritten with interrupts from legacy devices, breaking
>   irqfd notification for virtio-blk queues)
> - Guard memory slot table with mutex and RCU mechanism (multiple threads
>   might access the memory slot table, and in the event of an UNMAPPED_GPA
>   exit we need to query the table for an unmapped region covering that GPA)
> - Include memory slot manager in MshvState
> - Produce mshv.h kernel header with ./scripts/update-linux-headers.sh from
>   linux 6.16 (not all UAPI definitions are defined in the upstream kernel,
>   hence we ship hw/hyper/hvgdk*.h and hw/hyperv/hvhdk*.h headers)
> - Added a QMP command query-mshv (a requirement for integration into
>   higher-level tooling)
> - Removed handling of HALT vm exit, since this is not a supported HV
>   message any more.
> - Added 2 maintainers from Microsoft for the respective file hierarchy
> - Added mshv as accelerator option in the documentation
> 
> RFC (v1) => v2
> 
> - Addressed code review comments (style, consilidation).
> - Rewrote the logic that handles overlap-in-userspace mappings to use
>   a static list of slots, inspired by the HVF accelerator code.
> - Fixed a bug that wrote corrupt payload in a MSHV_SET_MSI_ROUTING
>   call, preventing vhost=on to work on tap network devices.
> - Removed an erronous truncation of guest addresses to 32bit when
>   registering ioeventfd's using MSHV_IOEVENTFD. This resulted in
>   shadowing of low memory when ioevents were registered with
>   addresses beyond the 4gb barrier and thus unexpected "unmapped gpa"
>   vm exits in lower mem regions (impacting io performance).
> - Fixed problem in which the MSI routing table was committed for KVM
>   KVM instead of MSHV in virtio-pci bus initialization.
> - Added handler for HLT vm exits.
> - The above fixes removed a few limitation present in the previous
>   revision:
>   - Guest with machine type "pc" are booting (testing is still mostly
>     performed with q35)
>   - Tap network devices can be used with vhost=on option.
>   - Seabios can be used with >2.75G memory and multiple virtio-pci
>     devices
>   - I/O performance improvement as extranous MMIO vm exits are avoided
>     by registering ioevents with a correct address.
> 
> Notes:
> 
> - A discrete kernel ioctl "set_immediate_exit" (to avoid a race condition
>   when handling terminiation signals like ctrl-a x) has been tested and
>   proven to mitigate the problem. Since other consumers of /dev/mshv have
>   simular requirements as QEMU, we opted to iterate a bit more on the
>   respective kernel interface.
> 
> Magnus Kulke (25):
>   accel: Add Meson and config support for MSHV accelerator
>   target/i386/emulate: Allow instruction decoding from stream
>   target/i386/mshv: Add x86 decoder/emu implementation
>   hw/intc: Generalize APIC helper names from kvm_* to accel_*
>   include/hw/hyperv: Add MSHV ABI header definitions
>   linux-headers/linux: Add mshv.h headers
>   accel/mshv: Add accelerator skeleton
>   accel/mshv: Register memory region listeners
>   accel/mshv: Initialize VM partition
>   accel/mshv: Add vCPU creation and execution loop
>   accel/mshv: Add vCPU signal handling
>   target/i386/mshv: Add CPU create and remove logic
>   target/i386/mshv: Implement mshv_store_regs()
>   target/i386/mshv: Implement mshv_get_standard_regs()
>   target/i386/mshv: Implement mshv_get_special_regs()
>   target/i386/mshv: Implement mshv_arch_put_registers()
>   target/i386/mshv: Set local interrupt controller state
>   target/i386/mshv: Register CPUID entries with MSHV
>   target/i386/mshv: Register MSRs with MSHV
>   target/i386/mshv: Integrate x86 instruction decoder/emulator
>   target/i386/mshv: Write MSRs to the hypervisor
>   target/i386/mshv: Implement mshv_vcpu_run()
>   accel/mshv: Handle overlapping mem mappings
>   docs: Add mshv to documentation
>   MAINTAINERS: Add maintainers for mshv accelerator
> 
> Praveen K Paladugu (1):
>   qapi/accel: Allow to query mshv capabilities
> 
>  MAINTAINERS                      |   15 +
>  accel/Kconfig                    |    3 +
>  accel/accel-irq.c                |  106 ++
>  accel/meson.build                |    3 +-
>  accel/mshv/irq.c                 |  397 +++++++
>  accel/mshv/mem.c                 |  562 ++++++++++
>  accel/mshv/meson.build           |    9 +
>  accel/mshv/mshv-all.c            |  726 +++++++++++++
>  accel/mshv/msr.c                 |  373 +++++++
>  accel/mshv/trace-events          |   30 +
>  accel/mshv/trace.h               |   14 +
>  docs/devel/codebase.rst          |    2 +-
>  hw/core/machine-qmp-cmds.c       |   14 +
>  hw/intc/apic.c                   |    8 +
>  hw/intc/ioapic.c                 |   20 +-
>  hw/virtio/virtio-pci.c           |   21 +-
>  include/hw/hyperv/hvgdk.h        |   19 +
>  include/hw/hyperv/hvgdk_mini.h   |  864 +++++++++++++++
>  include/hw/hyperv/hvhdk.h        |  164 +++
>  include/hw/hyperv/hvhdk_mini.h   |  105 ++
>  include/system/accel-irq.h       |   37 +
>  include/system/mshv.h            |  195 ++++
>  linux-headers/linux/mshv.h       |  291 ++++++
>  meson.build                      |   11 +
>  meson_options.txt                |    2 +
>  qapi/accelerator.json            |   29 +
>  qemu-options.hx                  |   16 +-
>  scripts/meson-buildoptions.sh    |    3 +
>  scripts/update-linux-headers.sh  |    2 +-
>  target/i386/cpu.h                |    4 +-
>  target/i386/emulate/meson.build  |    7 +-
>  target/i386/emulate/x86_decode.c |   27 +-
>  target/i386/emulate/x86_decode.h |    9 +
>  target/i386/emulate/x86_emu.c    |    3 +-
>  target/i386/emulate/x86_emu.h    |    2 +
>  target/i386/meson.build          |    2 +
>  target/i386/mshv/meson.build     |    8 +
>  target/i386/mshv/mshv-cpu.c      | 1674 ++++++++++++++++++++++++++++++
>  target/i386/mshv/x86.c           |  297 ++++++
>  39 files changed, 6038 insertions(+), 36 deletions(-)
>  create mode 100644 accel/accel-irq.c
>  create mode 100644 accel/mshv/irq.c
>  create mode 100644 accel/mshv/mem.c
>  create mode 100644 accel/mshv/meson.build
>  create mode 100644 accel/mshv/mshv-all.c
>  create mode 100644 accel/mshv/msr.c
>  create mode 100644 accel/mshv/trace-events
>  create mode 100644 accel/mshv/trace.h
>  create mode 100644 include/hw/hyperv/hvgdk.h
>  create mode 100644 include/hw/hyperv/hvgdk_mini.h
>  create mode 100644 include/hw/hyperv/hvhdk.h
>  create mode 100644 include/hw/hyperv/hvhdk_mini.h
>  create mode 100644 include/system/accel-irq.h
>  create mode 100644 include/system/mshv.h
>  create mode 100644 linux-headers/linux/mshv.h
>  create mode 100644 target/i386/mshv/meson.build
>  create mode 100644 target/i386/mshv/mshv-cpu.c
>  create mode 100644 target/i386/mshv/x86.c
> 
> -- 
> 2.34.1


