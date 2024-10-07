Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B49CFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxo06-0006En-Ls; Mon, 07 Oct 2024 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnzu-00069B-Qd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnzs-0004jV-7W
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728308515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3BMCF7hpRI0O4f6yfc8riymElfRN1PjqlIPcrf/z3w=;
 b=UxYLRskYOZ4r60A2sNMDQagOSy45zapgJgjFLDZEQC5EWOkmSTqgLWWQwj2lMWTJv/jfYm
 fGxQHrLTUz9ma80hUVA/AZvsc5pHWsU08DhncG6CDZ3gEbSTNhnxI0P50jFUhCXeCND9u/
 wHLOd1JgA6DfaoMXvQGfwwkI6BPCSW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-hRFazGQ2OkO_nrn4pZw7yQ-1; Mon, 07 Oct 2024 09:41:54 -0400
X-MC-Unique: hRFazGQ2OkO_nrn4pZw7yQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so39586005e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 06:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728308513; x=1728913313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3BMCF7hpRI0O4f6yfc8riymElfRN1PjqlIPcrf/z3w=;
 b=r/MStdAxK26rEnVKWDZTmkjbO3YgpQo83Sqmz0ykt+zE/T6I+95ij9nDKvIASTg5dY
 +eCxQFwGdDSjz0yfVRO+clzk8FEDjqW+Nr3XC+lo6jliLa4OrfcfKcExy8zOU/D22K/5
 +fgXXLIrl4ZXvbeIxCwUuda1UHPCE7g+ET5JktvIKRPbP5IJRCuq3L/ij7/xVHhj1PmQ
 zbiKULrdxEPxEb86X1bER1CLIDNKcn1hJEgCRwLf5Yd8WtVaxjn16TDvWp/DAusIK29j
 FG2Q6jpYKCRH9yQGM+H5LI0YPYq2Fnrqbnny0L/CpHU/wgCncI3nkg9lCVqHWKcGTCxh
 Xhhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb/d27TyMpOeF80ItNfAB02K52Zdh+CXjUTBAIRld+cltjnpFcsLr8BtsXehRkJh1NiOU1YNaB6Z3y@nongnu.org
X-Gm-Message-State: AOJu0YwqugNbRqXjCMJ9RcdQjqHWWVy3OLGo43eWkud8srX8jozn0F+n
 FB0V4moCtZFnn/bJpP/jMyvDXHylA5lxUaz/wjxkFapIs5B/7erdkh5HyupyPiq6sy0UDK0tmfe
 zIpb6Y9tlRJohj2uaLesMVDX5HXVATLfjcffuEe7WYMcJOJExW+WJ
X-Received: by 2002:a05:600c:510d:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42f85ae90b0mr93811305e9.26.1728308512673; 
 Mon, 07 Oct 2024 06:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrZUa0imetXf+ei7gBPYB7xo/Er+DtJZcgtv3nICR5htLmeFmPEueUy9D78BY4Ve80Iq92Pg==
X-Received: by 2002:a05:600c:510d:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42f85ae90b0mr93811025e9.26.1728308512256; 
 Mon, 07 Oct 2024 06:41:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0a9c9sm93043685e9.3.2024.10.07.06.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 06:41:51 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:41:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [RFC V2 PATCH 00/11] Support ACPI Control Method Sleep button
Message-ID: <20241007154150.6d406a7b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240927183906.1248-1-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 27 Sep 2024 14:38:55 -0400
Annie Li <annie.li@oracle.com> wrote:

> The ACPI sleep button can be implemented as a fixed hardware button
> or Control Method Sleep button.
> 
> The patch of implementing a fixed hardware sleep button was posted
> here 1). More discussions can be found here 2). Essentially, the
> discussion mainly focuses on whether the sleep button is implemented
> as a fixed hardware button or Control Method Sleep button. The latter
> benefits various architectures since the code can be shared among
> them.
> 
> This patch set implements Control Method Sleep button for both x86
> and ARM platform.(The patch set was posted previously here 3). We
> rebase all the patches on QEMU9.1.0 and re-post it).
> 
> For x86, a sleep button GPE event handler is implemented, so a GPE
> event is triggered to indicate the OSPM the sleep button is pressed.
> Tests have been done for Linux guest, and Windows Server guest,
> the sleep button works as expected.
> 
> For ARM, a GED event is triggered to notify the OSPM. With proper
> debug knobs it is possible to see the guest OSPM acknowledges the
> sleep event:

Series also missed 'microvm', that uses GED
(it's likely the same amount of work as for arm/virt board)

also test all boards you are touching, to make sure you
didn't break them.

Note: commit messages should be more verbose explaining why and what
patches are doing.

PS:
Also keep  changelog in cover letter, for a short list of changes
between series revisions,
see '[PATCH v3 0/1] hw/nvme: add atomic write support' for an example

> 
> (qemu) system_sleep
> (qemu) [6.744138] exregion-0179 ex_system_memory_space: System-Memory (width 32) R/W 0 Address=0000000009080000
> [6.746003] evmisc-0132 ev_queue_notify_reques: Dispatching Notify on [SLPB] (Device) Value 0x80 (Status Change) Node 00000000f0e6819e
> [6.802873] PM: suspend entry (s2idle)
> [6.806201] Filesystems sync: 0.002 seconds
> [6.807580] Freezing user space processes
> [6.809478] Freezing user space processes completed (elapsed 0.001 seconds)
> [6.810602] OOM killer disabled.
> [6.811111] Freezing remaining freezable tasks
> [6.812953] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [6.814126] printk: Suspending console(s) (use no_console_suspend to debug)
> 
> But that seems to be all, depicting that sleep/wakeup for ARM is broken
> and there are still missing some pieces of the puzzle.
> 
> Nonetheless, we would like to take this RFC as an opportunity for updates
> on this subject as possible roadmaps.
> 
> 1) https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html
> 2) https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961
> 3) https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/
> 
> 
> Annie Li (6):
>   acpi: hmp/qmp: Add hmp/qmp support for system_sleep
>   acpi: Implement control method sleep button
>   test/acpi: allow DSDT table changes
>   acpi: Support Control Method sleep button for x86
>   tests/acpi: Update DSDT tables for Control method sleep button
>   acpi: Send the GPE event of suspend and wakeup for x86
> 
> Miguel Luis (5):
>   hw/acpi: Add ACPI GED support for the sleep event
>   tests/acpi: allow FACP and DSDT table changes for arm/virt
>   hw/arm: enable sleep support for arm/virt
>   tests/acpi: Update FACP and DSDT tables for sleep button
>   arm/virt: enable sleep support
> 
>  hmp-commands.hx                               |  14 +++++
>  hw/acpi/control_method_device.c               |  54 ++++++++++++++++++
>  hw/acpi/core.c                                |  17 ++++--
>  hw/acpi/generic_event_device.c                |   9 +++
>  hw/acpi/meson.build                           |   1 +
>  hw/arm/virt-acpi-build.c                      |  13 +++++
>  hw/arm/virt.c                                 |  14 ++++-
>  hw/core/machine-hmp-cmds.c                    |   5 ++
>  hw/core/machine-qmp-cmds.c                    |  11 ++++
>  hw/i386/acpi-build.c                          |   9 +++
>  include/hw/acpi/acpi.h                        |   1 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/control_method_device.h       |  25 ++++++++
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/arm/virt.h                         |   1 +
>  include/monitor/hmp.h                         |   1 +
>  qapi/machine.json                             |  18 ++++++
>  qapi/pragma.json                              |   1 +
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5278 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5364 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6639 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7761 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5480 bytes
>  tests/data/acpi/aarch64/virt/FACP             | Bin 276 -> 276 bytes
>  tests/data/acpi/x86/pc/DSDT                   | Bin 6830 -> 7012 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 6741 -> 6923 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 8155 -> 8337 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 13701 -> 13883 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 7294 -> 7476 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 8484 -> 8666 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 6781 -> 6963 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 3337 -> 3519 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 6902 -> 7084 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 8189 -> 8371 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 6688 -> 6870 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 6836 -> 7018 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 10623 -> 10805 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8537 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8554 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9862 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8816 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8583 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12150 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 13095 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33952 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 9001 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 9714 -> 9896 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10191 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8612 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8625 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8554 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9896 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9667 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13390 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8417 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8395 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8543 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8638 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 13095 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33952 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9143 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9169 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18771 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 9464 -> 9646 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35900 bytes
>  65 files changed, 191 insertions(+), 5 deletions(-)
>  create mode 100644 hw/acpi/control_method_device.c
>  create mode 100644 include/hw/acpi/control_method_device.h
> 


