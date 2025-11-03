Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C3CCCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprS-0000vS-Uw; Mon, 03 Nov 2025 03:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprO-0000uV-7s
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprE-0006jy-FC
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHIcOIaZdETLaT84uMIiUEtijsBpK25NYeGvdIOX8w0=;
 b=GcQtp7Rkr5o+QQu2e6MSqRjMyInQM+xfDXhyJo7LKzeEmXqvCp/tEQBB6HRccAggvCx2BA
 TPMimyFwHeclsFS7Hx7xiQQ8XIlUnwkhVawcG057+c0d8nA+J829ypO+kGacPmMLQgM0iJ
 vku55d5yFW7Ku3gSF7EnYWXoIkfxImo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-LCiM8VyIMQ2p-jcnL2cT8A-1; Mon,
 03 Nov 2025 03:24:03 -0500
X-MC-Unique: LCiM8VyIMQ2p-jcnL2cT8A-1
X-Mimecast-MFC-AGG-ID: LCiM8VyIMQ2p-jcnL2cT8A_1762158242
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ED101800D89; Mon,  3 Nov 2025 08:24:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388D31956056; Mon,  3 Nov 2025 08:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F13021E6774; Mon, 03 Nov 2025 09:23:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 6/9] docs/interop: Refill QAPI doc comments to conform to
 conventions
Date: Mon,  3 Nov 2025 09:23:51 +0100
Message-ID: <20251103082354.3273027-7-armbru@redhat.com>
In-Reply-To: <20251103082354.3273027-1-armbru@redhat.com>
References: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For legibility, wrap text paragraphs so every line is at most 70
characters long.  Consistently separate sentences with two spaces.
Consistently separate member descriptions with a blank line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/interop/firmware.json   | 440 +++++++++++++++++------------------
 docs/interop/vhost-user.json |  57 +++--
 2 files changed, 252 insertions(+), 245 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index ccbfaf828d..7ffa7697e4 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -27,18 +27,18 @@
 # Lists the firmware-OS interface types provided by various firmware
 # that is commonly used with QEMU virtual machines.
 #
-# @bios: Traditional x86 BIOS interface. For example, firmware built
-#        from the SeaBIOS project usually provides this interface.
+# @bios: Traditional x86 BIOS interface.  For example, firmware built
+#     from the SeaBIOS project usually provides this interface.
 #
 # @openfirmware: The interface is defined by the (historical) IEEE
-#                1275-1994 standard. Examples for firmware projects that
-#                provide this interface are: OpenBIOS and SLOF.
+#     1275-1994 standard.  Examples for firmware projects that provide
+#     this interface are: OpenBIOS and SLOF.
 #
 # @uboot: Firmware interface defined by the U-Boot project.
 #
-# @uefi: Firmware interface defined by the UEFI specification. For
-#        example, firmware built from the edk2 (EFI Development Kit II)
-#        project usually provides this interface.
+# @uefi: Firmware interface defined by the UEFI specification.  For
+#     example, firmware built from the edk2 (EFI Development Kit II)
+#     project usually provides this interface.
 #
 # Since: 3.0
 ##
@@ -50,21 +50,21 @@
 #
 # Defines the device types that firmware can be mapped into.
 #
-# @flash: The firmware executable and its accompanying NVRAM file are to
-#         be mapped into a pflash chip each.
+# @flash: The firmware executable and its accompanying NVRAM file are
+#     to be mapped into a pflash chip each.
 #
-# @kernel: The firmware is to be loaded like a Linux kernel. This is
-#          similar to @memory but may imply additional processing that
-#          is specific to the target architecture and machine type.
+# @kernel: The firmware is to be loaded like a Linux kernel.  This is
+#     similar to @memory but may imply additional processing that is
+#     specific to the target architecture and machine type.
 #
 # @memory: The firmware is to be mapped into memory.
 #
 # @igvm: The firmware is defined by a file conforming to the IGVM
-#        specification and mapped into memory according to directives
-#        defined in the file. This is similar to @memory but may
-#        include additional processing defined by the IGVM file
-#        including initial CPU state or population of metadata into
-#        the guest address space. Since: 10.1
+#     specification and mapped into memory according to directives
+#     defined in the file.  This is similar to @memory but may include
+#     additional processing defined by the IGVM file including initial
+#     CPU state or population of metadata into the guest address
+#     space.  Since: 10.1
 #
 # Since: 3.0
 ##
@@ -74,8 +74,8 @@
 ##
 # @FirmwareArchitecture:
 #
-# Enumeration of architectures for which Qemu uses additional
-# firmware files.
+# Enumeration of architectures for which Qemu uses additional firmware
+# files.
 #
 # @aarch64: 64-bit Arm.
 #
@@ -83,7 +83,7 @@
 #
 # @i386: 32-bit x86.
 #
-# @loongarch64: 64-bit LoongArch. (since: 7.1)
+# @loongarch64: 64-bit LoongArch.  (since: 7.1)
 #
 # @riscv64: 64-bit RISC-V.
 #
@@ -100,17 +100,16 @@
 # Defines the machine types that firmware may execute on.
 #
 # @architecture: Determines the emulation target (the QEMU system
-#                emulator) that can execute the firmware.
+#     emulator) that can execute the firmware.
 #
 # @machines: Lists the machine types (known by the emulator that is
-#            specified through @architecture) that can execute the
-#            firmware. Elements of @machines are supposed to be concrete
-#            machine types, not aliases. Glob patterns are understood,
-#            which is especially useful for versioned machine types.
-#            (For example, the glob pattern "pc-i440fx-*" matches
-#            "pc-i440fx-2.12".) On the QEMU command line, "-machine
-#            type=..." specifies the requested machine type (but that
-#            option does not accept glob patterns).
+#     specified through @architecture) that can execute the firmware.
+#     Elements of @machines are supposed to be concrete machine types,
+#     not aliases.  Glob patterns are understood, which is especially
+#     useful for versioned machine types.  (For example, the glob
+#     pattern "pc-i440fx-*" matches "pc-i440fx-2.12".) On the QEMU
+#     command line, "-machine type=..." specifies the requested
+#     machine type (but that option does not accept glob patterns).
 #
 # Since: 3.0
 ##
@@ -124,115 +123,104 @@
 # Defines the features that firmware may support, and the platform
 # requirements that firmware may present.
 #
-# @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as defined
-#           in the ACPI specification. On the "pc-i440fx-*" machine
-#           types of the @i386 and @x86_64 emulation targets, S3 can be
-#           enabled with "-global PIIX4_PM.disable_s3=0" and disabled
-#           with "-global PIIX4_PM.disable_s3=1". On the "pc-q35-*"
-#           machine types of the @i386 and @x86_64 emulation targets, S3
-#           can be enabled with "-global ICH9-LPC.disable_s3=0" and
-#           disabled with "-global ICH9-LPC.disable_s3=1".
+# @acpi-s3: The firmware supports S3 sleep (suspend to RAM), as
+#     defined in the ACPI specification.  On the "pc-i440fx-*" machine
+#     types of the @i386 and @x86_64 emulation targets, S3 can be
+#     enabled with "-global PIIX4_PM.disable_s3=0" and disabled with
+#     "-global PIIX4_PM.disable_s3=1".  On the "pc-q35-*" machine
+#     types of the @i386 and @x86_64 emulation targets, S3 can be
+#     enabled with "-global ICH9-LPC.disable_s3=0" and disabled with
+#     "-global ICH9-LPC.disable_s3=1".
 #
 # @acpi-s4: The firmware supports S4 hibernation (suspend to disk), as
-#           defined in the ACPI specification. On the "pc-i440fx-*"
-#           machine types of the @i386 and @x86_64 emulation targets, S4
-#           can be enabled with "-global PIIX4_PM.disable_s4=0" and
-#           disabled with "-global PIIX4_PM.disable_s4=1". On the
-#           "pc-q35-*" machine types of the @i386 and @x86_64 emulation
-#           targets, S4 can be enabled with "-global
-#           ICH9-LPC.disable_s4=0" and disabled with "-global
-#           ICH9-LPC.disable_s4=1".
+#     defined in the ACPI specification.  On the "pc-i440fx-*" machine
+#     types of the @i386 and @x86_64 emulation targets, S4 can be
+#     enabled with "-global PIIX4_PM.disable_s4=0" and disabled with
+#     "-global PIIX4_PM.disable_s4=1".  On the "pc-q35-*" machine
+#     types of the @i386 and @x86_64 emulation targets, S4 can be
+#     enabled with "-global ICH9-LPC.disable_s4=0" and disabled with
+#     "-global ICH9-LPC.disable_s4=1".
 #
 # @amd-sev: The firmware supports running under AMD Secure Encrypted
-#           Virtualization, as specified in the AMD64 Architecture
-#           Programmer's Manual. QEMU command line options related to
-#           this feature are documented in
-#           "docs/system/i386/amd-memory-encryption.rst".
+#     Virtualization, as specified in the AMD64 Architecture
+#     Programmer's Manual.  QEMU command line options related to this
+#     feature are documented in
+#     "docs/system/i386/amd-memory-encryption.rst".
 #
-# @amd-sev-es: The firmware supports running under AMD Secure Encrypted
-#              Virtualization - Encrypted State, as specified in the AMD64
-#              Architecture Programmer's Manual. QEMU command line options
-#              related to this feature are documented in
-#              "docs/system/i386/amd-memory-encryption.rst".
+# @amd-sev-es: The firmware supports running under AMD Secure
+#     Encrypted Virtualization - Encrypted State, as specified in the
+#     AMD64 Architecture Programmer's Manual.  QEMU command line
+#     options related to this feature are documented in
+#     "docs/system/i386/amd-memory-encryption.rst".
 #
-# @amd-sev-snp: The firmware supports running under AMD Secure Encrypted
-#               Virtualization - Secure Nested Paging, as specified in the
-#               AMD64 Architecture Programmer's Manual. QEMU command line
-#               options related to this feature are documented in
-#               "docs/system/i386/amd-memory-encryption.rst".
+# @amd-sev-snp: The firmware supports running under AMD Secure
+#     Encrypted Virtualization - Secure Nested Paging, as specified in
+#     the AMD64 Architecture Programmer's Manual.  QEMU command line
+#     options related to this feature are documented in
+#     "docs/system/i386/amd-memory-encryption.rst".
 #
 # @intel-tdx: The firmware supports running under Intel Trust Domain
-#             Extensions (TDX).
+#     Extensions (TDX).
 #
 # @enrolled-keys: The variable store (NVRAM) template associated with
-#                 the firmware binary has the UEFI Secure Boot
-#                 operational mode turned on, with certificates
-#                 enrolled.
+#     the firmware binary has the UEFI Secure Boot operational mode
+#     turned on, with certificates enrolled.
 #
 # @requires-smm: The firmware requires the platform to emulate SMM
-#                (System Management Mode), as defined in the AMD64
-#                Architecture Programmer's Manual, and in the Intel(R)64
-#                and IA-32 Architectures Software Developer's Manual. On
-#                the "pc-q35-*" machine types of the @i386 and @x86_64
-#                emulation targets, SMM emulation can be enabled with
-#                "-machine smm=on". (On the "pc-q35-*" machine types of
-#                the @i386 emulation target, @requires-smm presents
-#                further CPU requirements; one combination known to work
-#                is "-cpu coreduo,nx=off".) If the firmware is marked as
-#                both @secure-boot and @requires-smm, then write
-#                accesses to the pflash chip (NVRAM) that holds the UEFI
-#                variable store must be restricted to code that executes
-#                in SMM, using the additional option "-global
-#                driver=cfi.pflash01,property=secure,value=on".
-#                Furthermore, a large guest-physical address space
-#                (comprising guest RAM, memory hotplug range, and 64-bit
-#                PCI MMIO aperture), and/or a high VCPU count, may
-#                present high SMRAM requirements from the firmware. On
-#                the "pc-q35-*" machine types of the @i386 and @x86_64
-#                emulation targets, the SMRAM size may be increased
-#                above the default 16MB with the "-global
-#                mch.extended-tseg-mbytes=uint16" option. As a rule of
-#                thumb, the default 16MB size suffices for 1TB of
-#                guest-phys address space and a few tens of VCPUs; for
-#                every further TB of guest-phys address space, add 8MB
-#                of SMRAM. 48MB should suffice for 4TB of guest-phys
-#                address space and 2-3 hundred VCPUs.
+#     (System Management Mode), as defined in the AMD64 Architecture
+#     Programmer's Manual, and in the Intel(R)64 and IA-32
+#     Architectures Software Developer's Manual.  On the "pc-q35-*"
+#     machine types of the @i386 and @x86_64 emulation targets, SMM
+#     emulation can be enabled with "-machine smm=on".  (On the
+#     "pc-q35-*" machine types of the @i386 emulation target,
+#     @requires-smm presents further CPU requirements; one combination
+#     known to work is "-cpu coreduo,nx=off".) If the firmware is
+#     marked as both @secure-boot and @requires-smm, then write
+#     accesses to the pflash chip (NVRAM) that holds the UEFI variable
+#     store must be restricted to code that executes in SMM, using the
+#     additional option "-global
+#     driver=cfi.pflash01,property=secure,value=on".  Furthermore, a
+#     large guest-physical address space (comprising guest RAM, memory
+#     hotplug range, and 64-bit PCI MMIO aperture), and/or a high VCPU
+#     count, may present high SMRAM requirements from the firmware.
+#     On the "pc-q35-*" machine types of the @i386 and @x86_64
+#     emulation targets, the SMRAM size may be increased above the
+#     default 16MB with the "-global mch.extended-tseg-mbytes=uint16"
+#     option.  As a rule of thumb, the default 16MB size suffices for
+#     1TB of guest-phys address space and a few tens of VCPUs; for
+#     every further TB of guest-phys address space, add 8MB of SMRAM.
+#     48MB should suffice for 4TB of guest-phys address space and 2-3
+#     hundred VCPUs.
 #
-# @secure-boot: The firmware implements the software interfaces for UEFI
-#               Secure Boot, as defined in the UEFI specification. Note
-#               that without @requires-smm, guest code running with
-#               kernel privileges can undermine the security of Secure
-#               Boot.
+# @secure-boot: The firmware implements the software interfaces for
+#     UEFI Secure Boot, as defined in the UEFI specification.  Note
+#     that without @requires-smm, guest code running with kernel
+#     privileges can undermine the security of Secure Boot.
 #
 # @verbose-dynamic: When firmware log capture is enabled, the firmware
-#                   logs a large amount of debug messages, which may
-#                   impact boot performance. With log capture disabled,
-#                   there is no boot performance impact. On the
-#                   "pc-i440fx-*" and "pc-q35-*" machine types of the
-#                   @i386 and @x86_64 emulation targets, firmware log
-#                   capture can be enabled with the QEMU command line
-#                   options "-chardev file,id=fwdebug,path=LOGFILEPATH
-#                   -device isa-debugcon,iobase=0x402,chardev=fwdebug".
-#                   @verbose-dynamic is mutually exclusive with
-#                   @verbose-static.
+#     logs a large amount of debug messages, which may impact boot
+#     performance.  With log capture disabled, there is no boot
+#     performance impact.  On the "pc-i440fx-*" and "pc-q35-*" machine
+#     types of the @i386 and @x86_64 emulation targets, firmware log
+#     capture can be enabled with the QEMU command line options
+#     "-chardev file,id=fwdebug,path=LOGFILEPATH -device
+#     isa-debugcon,iobase=0x402,chardev=fwdebug".  @verbose-dynamic is
+#     mutually exclusive with @verbose-static.
 #
-# @verbose-static: The firmware unconditionally produces a large amount
-#                  of debug messages, which may impact boot performance.
-#                  This feature may typically be carried by certain UEFI
-#                  firmware for the "virt-*" machine types of the @arm
-#                  and @aarch64 emulation targets, where the debug
-#                  messages are written to the first (always present)
-#                  PL011 UART. @verbose-static is mutually exclusive
-#                  with @verbose-dynamic.
+# @verbose-static: The firmware unconditionally produces a large
+#     amount of debug messages, which may impact boot performance.
+#     This feature may typically be carried by certain UEFI firmware
+#     for the "virt-*" machine types of the @arm and @aarch64
+#     emulation targets, where the debug messages are written to the
+#     first (always present) PL011 UART.  @verbose-static is mutually
+#     exclusive with @verbose-dynamic.
 #
 # @host-uefi-vars: The firmware expects the host to provide an uefi
-#                  variable store.  qemu supports that via
-#                  "uefi-vars-sysbus" (aarch64, riscv64, loongarch64)
-#                  or "uefi-vars-x64" (x86_64) devices.  The firmware
-#                  will not use flash for nvram.  When loading the
-#                  firmware into flash the 'stateless' setup should be
-#                  used.  It is recommened to load the firmware into
-#                  memory though.
+#     variable store.  qemu supports that via "uefi-vars-sysbus"
+#     (aarch64, riscv64, loongarch64) or "uefi-vars-x64" (x86_64)
+#     devices.  The firmware will not use flash for nvram.  When
+#     loading the firmware into flash the 'stateless' setup should be
+#     used.  It is recommened to load the firmware into memory though.
 #
 # Since: 3.0
 ##
@@ -262,16 +250,16 @@
 # @FirmwareFlashFile:
 #
 # Defines common properties that are necessary for loading a firmware
-# file into a pflash chip. The corresponding QEMU command line option is
-# "-drive file=@filename,format=@format". Note however that the
+# file into a pflash chip.  The corresponding QEMU command line option
+# is "-drive file=@filename,format=@format".  Note however that the
 # option-argument shown here is incomplete; it is completed under
 # @FirmwareMappingFlash.
 #
 # @filename: Specifies the filename on the host filesystem where the
-#            firmware file can be found.
+#     firmware file can be found.
 #
 # @format: Specifies the block format of the file pointed-to by
-#          @filename, such as @raw or @qcow2.
+#     @filename, such as @raw or @qcow2.
 #
 # Since: 3.0
 ##
@@ -286,22 +274,20 @@
 # Describes how the firmware build handles code versus variable
 # persistence.
 #
-# @split: the executable file contains code while the NVRAM
-#         template provides variable storage. The executable
-#         must be configured read-only and can be shared between
-#         multiple guests. The NVRAM template must be cloned
-#         for each new guest and configured read-write.
+# @split: the executable file contains code while the NVRAM template
+#     provides variable storage.  The executable must be configured
+#     read-only and can be shared between multiple guests.  The NVRAM
+#     template must be cloned for each new guest and configured
+#     read-write.
 #
-# @combined: the executable file contains both code and
-#            variable storage. The executable must be cloned
-#            for each new guest and configured read-write.
-#            No NVRAM template will be specified.
+# @combined: the executable file contains both code and variable
+#     storage.  The executable must be cloned for each new guest and
+#     configured read-write.  No NVRAM template will be specified.
 #
-# @stateless: the executable file contains code and variable
-#             storage is not persisted. The executable must
-#             be configured read-only and can be shared
-#             between multiple guests. No NVRAM template
-#             will be specified.
+# @stateless: the executable file contains code and variable storage
+#     is not persisted.  The executable must be configured read-only
+#     and can be shared between multiple guests.  No NVRAM template
+#     will be specified.
 #
 # Since: 7.0.0
 ##
@@ -315,39 +301,36 @@
 # and its accompanying NVRAM file, when @FirmwareDevice is @flash.
 #
 # @mode: Describes how the firmware build handles code versus variable
-#        storage. If not present, it must be treated as if it was
-#        configured with value @split. Since: 7.0.0
+#     storage.  If not present, it must be treated as if it was
+#     configured with value @split.  Since: 7.0.0
 #
-# @executable: Identifies the firmware executable. The @mode
-#              indicates whether there will be an associated
-#              NVRAM template present. The preferred
-#              corresponding QEMU command line options are
-#                  -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
-#                  -machine pflash0=pflash0
-#              or equivalent -blockdev instead of -drive. When
-#              @mode is @combined the executable must be
-#              cloned before use and configured with readonly=off.
-#              With QEMU versions older than 4.0, you have to use
-#                  -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
+# @executable: Identifies the firmware executable.  The @mode
+#     indicates whether there will be an associated NVRAM template
+#     present.  The preferred corresponding QEMU command line options
+#     are
+#         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
+#         -machine pflash0=pflash0
+#     or equivalent -blockdev instead of -drive.  When @mode is
+#     @combined the executable must be cloned before use and
+#     configured with readonly=off.  With QEMU versions older than
+#     4.0, you have to use
+#         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
 #
 # @nvram-template: Identifies the NVRAM template compatible with
-#                  @executable, when @mode is set to @split,
-#                  otherwise it should not be present.
-#                  Management software instantiates an
-#                  individual copy -- a specific NVRAM file -- from
-#                  @nvram-template.@filename for each new virtual
-#                  machine definition created. @nvram-template.@filename
-#                  itself is never mapped into virtual machines, only
-#                  individual copies of it are. An NVRAM file is
-#                  typically used for persistently storing the
-#                  non-volatile UEFI variables of a virtual machine
-#                  definition. The preferred corresponding QEMU
-#                  command line options are
-#                      -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
-#                      -machine pflash1=pflash1
-#                  or equivalent -blockdev instead of -drive.
-#                  With QEMU versions older than 4.0, you have to use
-#                      -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
+#     @executable, when @mode is set to @split, otherwise it should
+#     not be present.  Management software instantiates an individual
+#     copy -- a specific NVRAM file -- from @nvram-template.@filename
+#     for each new virtual machine definition created.
+#     @nvram-template.@filename itself is never mapped into virtual
+#     machines, only individual copies of it are.  An NVRAM file is
+#     typically used for persistently storing the non-volatile UEFI
+#     variables of a virtual machine definition.  The preferred
+#     corresponding QEMU command line options are
+#         -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
+#         -machine pflash1=pflash1
+#     or equivalent -blockdev instead of -drive.  With QEMU versions
+#     older than 4.0, you have to use
+#         -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
 #
 # Since: 3.0
 ##
@@ -359,13 +342,13 @@
 ##
 # @FirmwareMappingKernel:
 #
-# Describes loading and mapping properties for the firmware executable,
-# when @FirmwareDevice is @kernel.
+# Describes loading and mapping properties for the firmware
+# executable, when @FirmwareDevice is @kernel.
 #
-# @filename: Identifies the firmware executable. The firmware executable
-#            may be shared by multiple virtual machine definitions. The
-#            corresponding QEMU command line option is "-kernel
-#            @filename".
+# @filename: Identifies the firmware executable.  The firmware
+#     executable may be shared by multiple virtual machine
+#     definitions.  The corresponding QEMU command line option is
+#     "-kernel @filename".
 #
 # Since: 3.0
 ##
@@ -375,13 +358,13 @@
 ##
 # @FirmwareMappingMemory:
 #
-# Describes loading and mapping properties for the firmware executable,
-# when @FirmwareDevice is @memory.
+# Describes loading and mapping properties for the firmware
+# executable, when @FirmwareDevice is @memory.
 #
-# @filename: Identifies the firmware executable. The firmware executable
-#            may be shared by multiple virtual machine definitions. The
-#            corresponding QEMU command line option is "-bios
-#            @filename".
+# @filename: Identifies the firmware executable.  The firmware
+#     executable may be shared by multiple virtual machine
+#     definitions.  The corresponding QEMU command line option is
+#     "-bios @filename".
 #
 # Since: 3.0
 ##
@@ -391,15 +374,15 @@
 ##
 # @FirmwareMappingIgvm:
 #
-# Describes loading and mapping properties for the firmware executable,
-# when @FirmwareDevice is @igvm.
+# Describes loading and mapping properties for the firmware
+# executable, when @FirmwareDevice is @igvm.
 #
-# @filename: Identifies the IGVM file containing the firmware executable
-#            along with other information used to configure the initial
-#            state of the guest. The IGVM file may be shared by multiple
-#            virtual machine definitions. This corresponds to creating
-#            an object on the command line with "-object igvm-cfg,
-#            file=@filename".
+# @filename: Identifies the IGVM file containing the firmware
+#     executable along with other information used to configure the
+#     initial state of the guest.  The IGVM file may be shared by
+#     multiple virtual machine definitions.  This corresponds to
+#     creating an object on the command line with "-object igvm-cfg,
+#     file=@filename".
 #
 # Since: 10.1
 ##
@@ -413,7 +396,7 @@
 # loading / mapping properties.
 #
 # @device: Selects the device type that the firmware must be mapped
-#          into.
+#     into.
 #
 # Since: 3.0
 ##
@@ -428,46 +411,49 @@
 ##
 # @Firmware:
 #
-# Describes a firmware (or a firmware use case) to management software.
+# Describes a firmware (or a firmware use case) to management
+# software.
 #
 # It is possible for multiple @Firmware elements to match the search
-# criteria of management software. Applications thus need rules to pick
-# one of the many matches, and users need the ability to override distro
-# defaults.
+# criteria of management software.  Applications thus need rules to
+# pick one of the many matches, and users need the ability to override
+# distro defaults.
 #
 # It is recommended to create firmware JSON files (each containing a
-# single @Firmware root element) with a double-digit prefix, for example
-# "50-ovmf.json", "50-seabios-256k.json", etc, so they can be sorted in
-# predictable order. The firmware JSON files should be searched for in
-# three directories:
+# single @Firmware root element) with a double-digit prefix, for
+# example "50-ovmf.json", "50-seabios-256k.json", etc, so they can be
+# sorted in predictable order.  The firmware JSON files should be
+# searched for in three directories:
 #
-#   - /usr/share/qemu/firmware -- populated by distro-provided firmware
-#                                 packages (XDG_DATA_DIRS covers
-#                                 /usr/share by default),
+# - /usr/share/qemu/firmware -- populated by distro-provided firmware
+#                               packages (XDG_DATA_DIRS covers
+#                               /usr/share by default),
 #
-#   - /etc/qemu/firmware -- exclusively for sysadmins' local additions,
+# - /etc/qemu/firmware -- exclusively for sysadmins' local additions,
 #
-#   - $XDG_CONFIG_HOME/qemu/firmware -- exclusively for per-user local
-#                                       additions (XDG_CONFIG_HOME
-#                                       defaults to $HOME/.config).
+# - $XDG_CONFIG_HOME/qemu/firmware -- exclusively for per-user local
+#                                     additions (XDG_CONFIG_HOME
+#                                     defaults to $HOME/.config).
 #
 # Top-down, the list of directories goes from general to specific.
 #
 # Management software should build a list of files from all three
 # locations, then sort the list by filename (i.e., last pathname
-# component). Management software should choose the first JSON file on
-# the sorted list that matches the search criteria. If a more specific
-# directory has a file with same name as a less specific directory, then
-# the file in the more specific directory takes effect. If the more
-# specific file is zero length, it hides the less specific one.
+# component).  Management software should choose the first JSON file
+# on the sorted list that matches the search criteria.  If a more
+# specific directory has a file with same name as a less specific
+# directory, then the file in the more specific directory takes
+# effect.  If the more specific file is zero length, it hides the less
+# specific one.
 #
 # For example, if a distro ships
 #
-#   - /usr/share/qemu/firmware/50-ovmf.json
+# - /usr/share/qemu/firmware/50-ovmf.json
 #
-#   - /usr/share/qemu/firmware/50-seabios-256k.json
+# - /usr/share/qemu/firmware/50-seabios-256k.json
 #
-# then the sysadmin can prevent the default OVMF being used at all with
+# then the sysadmin can prevent the default OVMF being used at all
+# with
 #
 #   $ touch /etc/qemu/firmware/50-ovmf.json
 #
@@ -484,29 +470,29 @@
 #   $ vim /etc/qemu/firmware/99-ovmf.json
 #
 # @description: Provides a human-readable description of the firmware.
-#               Management software may or may not display @description.
+#     Management software may or may not display @description.
 #
-# @interface-types: Lists the types of interfaces that the firmware can
-#                   expose to the guest OS. This is a non-empty, ordered
-#                   list; entries near the beginning of @interface-types
-#                   are considered more native to the firmware, and/or
-#                   to have a higher quality implementation in the
-#                   firmware, than entries near the end of
-#                   @interface-types.
+# @interface-types: Lists the types of interfaces that the firmware
+#     can expose to the guest OS.  This is a non-empty, ordered list;
+#     entries near the beginning of @interface-types are considered
+#     more native to the firmware, and/or to have a higher quality
+#     implementation in the firmware, than entries near the end of
+#     @interface-types.
 #
-# @mapping: Describes the loading / mapping properties of the firmware.
+# @mapping: Describes the loading / mapping properties of the
+#     firmware.
 #
 # @targets: Collects the target architectures (QEMU system emulators)
-#           and their machine types that may execute the firmware.
+#     and their machine types that may execute the firmware.
 #
 # @features: Lists the features that the firmware supports, and the
-#            platform requirements it presents.
+#     platform requirements it presents.
 #
 # @tags: A list of auxiliary strings associated with the firmware for
-#        which @description is not appropriate, due to the latter's
-#        possible exposure to the end-user. @tags serves development and
-#        debugging purposes only, and management software shall
-#        explicitly ignore it.
+#     which @description is not appropriate, due to the latter's
+#     possible exposure to the end-user.  @tags serves development and
+#     debugging purposes only, and management software shall
+#     explicitly ignore it.
 #
 # Since: 3.0
 #
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index 095eb99cf7..cd3a768615 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -21,19 +21,33 @@
 # List the various vhost user backend types.
 #
 # @9p: 9p virtio console
+#
 # @balloon: virtio balloon
+#
 # @block: virtio block
+#
 # @caif: virtio caif
+#
 # @console: virtio console
+#
 # @crypto: virtio crypto
+#
 # @gpu: virtio gpu
+#
 # @input: virtio input
+#
 # @net: virtio net
+#
 # @rng: virtio rng
+#
 # @rpmsg: virtio remote processor messaging
+#
 # @rproc-serial: virtio remoteproc serial link
+#
 # @scsi: virtio scsi
+#
 # @vsock: virtio vsock transport
+#
 # @fs: virtio fs (since 4.2)
 #
 # Since: 4.0
@@ -65,6 +79,7 @@
 # List of vhost user "block" features.
 #
 # @read-only: The --read-only command line option is supported.
+#
 # @blk-file: The --blk-file command line option is supported.
 #
 # Since: 5.0
@@ -96,6 +111,7 @@
 # List of vhost user "input" features.
 #
 # @evdev-path: The --evdev-path command line option is supported.
+#
 # @no-grab: The --no-grab command line option is supported.
 #
 # Since: 4.0
@@ -127,6 +143,7 @@
 # List of vhost user "gpu" features.
 #
 # @render-node: The --render-node command line option is supported.
+#
 # @virgl: The --virgl command line option is supported.
 #
 # Since: 4.0
@@ -177,36 +194,39 @@
 # Describes a vhost user backend to management software.
 #
 # It is possible for multiple @VhostUserBackend elements to match the
-# search criteria of management software. Applications thus need rules
-# to pick one of the many matches, and users need the ability to
+# search criteria of management software.  Applications thus need
+# rules to pick one of the many matches, and users need the ability to
 # override distro defaults.
 #
 # It is recommended to create vhost user backend JSON files (each
 # containing a single @VhostUserBackend root element) with a
 # double-digit prefix, for example "50-qemu-gpu.json",
 # "50-crosvm-gpu.json", etc, so they can be sorted in predictable
-# order. The backend JSON files should be searched for in three
+# order.  The backend JSON files should be searched for in three
 # directories:
 #
 #   - /usr/share/qemu/vhost-user -- populated by distro-provided
 #                                   packages (XDG_DATA_DIRS covers
 #                                   /usr/share by default),
 #
-#   - /etc/qemu/vhost-user -- exclusively for sysadmins' local additions,
+#   - /etc/qemu/vhost-user -- exclusively for sysadmins' local
+#                             additions,
 #
-#   - $XDG_CONFIG_HOME/qemu/vhost-user -- exclusively for per-user local
-#                                         additions (XDG_CONFIG_HOME
-#                                         defaults to $HOME/.config).
+#   - $XDG_CONFIG_HOME/qemu/vhost-user -- exclusively for per-user
+#                                         local additions
+#                                         (XDG_CONFIG_HOME defaults to
+#                                         $HOME/.config).
 #
 # Top-down, the list of directories goes from general to specific.
 #
 # Management software should build a list of files from all three
 # locations, then sort the list by filename (i.e., basename
-# component). Management software should choose the first JSON file on
-# the sorted list that matches the search criteria. If a more specific
-# directory has a file with same name as a less specific directory,
-# then the file in the more specific directory takes effect. If the
-# more specific file is zero length, it hides the less specific one.
+# component).  Management software should choose the first JSON file
+# on the sorted list that matches the search criteria.  If a more
+# specific directory has a file with same name as a less specific
+# directory, then the file in the more specific directory takes
+# effect.  If the more specific file is zero length, it hides the less
+# specific one.
 #
 # For example, if a distro ships
 #
@@ -214,7 +234,8 @@
 #
 #   - /usr/share/qemu/vhost-user/50-crosvm-gpu.json
 #
-# then the sysadmin can prevent the default QEMU GPU being used at all with
+# then the sysadmin can prevent the default QEMU GPU being used at all
+# with
 #
 #   $ touch /etc/qemu/vhost-user/50-qemu-gpu.json
 #
@@ -233,15 +254,15 @@
 # @type: The vhost user backend type.
 #
 # @description: Provides a human-readable description of the backend.
-#               Management software may or may not display @description.
+#     Management software may or may not display @description.
 #
 # @binary: Absolute path to the backend binary.
 #
 # @tags: An optional list of auxiliary strings associated with the
-#        backend for which @description is not appropriate, due to the
-#        latter's possible exposure to the end-user. @tags serves
-#        development and debugging purposes only, and management
-#        software shall explicitly ignore it.
+#     backend for which @description is not appropriate, due to the
+#     latter's possible exposure to the end-user.  @tags serves
+#     development and debugging purposes only, and management software
+#     shall explicitly ignore it.
 #
 # Since: 4.0
 #
-- 
2.49.0


