Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA361C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEi-0008Mc-Em; Mon, 14 Jul 2025 07:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzt-00018T-LO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzr-0001tB-5M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tb8HqmQk65s0sIuIYN8//M0WKbWp4Ar0Piw+k8limuE=;
 b=cRqCmLgVTIebHnmAASXnQaKM3DIgAgfTi7+3jK+rtFNhJa1lub6D+OVHiDirUjNmuPV5Zy
 xTswTDyIBjyMqL7du23ojhCMu9iVHCnWF1ez0nQZqTWpYs3imSUClK5m++vdFkgYMSp6eS
 ZxzMTpLNIc4KqtF/pZN3RfBaIywLbfM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-_nyjgxP5MzOLaAh_XvwWfw-1; Mon, 14 Jul 2025 07:05:20 -0400
X-MC-Unique: _nyjgxP5MzOLaAh_XvwWfw-1
X-Mimecast-MFC-AGG-ID: _nyjgxP5MzOLaAh_XvwWfw_1752491120
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a579058758so1669263f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491118; x=1753095918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb8HqmQk65s0sIuIYN8//M0WKbWp4Ar0Piw+k8limuE=;
 b=aiDXHgLczdgTNxaC6cd0P+7sELWR+vhUXqGh4/Me2ji+15VFx0oj3OFqfbNmedaO+w
 Mf+49qGfHYuQWEE2SQMz/39tz/ZXSqdAwmiafnDj5eGQAQoIF0mpzhI6wfMQ0dtUbPKS
 ddjJmiojgHrdQQmY81M2a/BFZ0UoA2NkQuFV8WL8/NI6Ue3Ur8iHkalzVBHtB9NLhWcl
 YF1hNw+9rshlgFs4iRKUz8bxkAWt6LUAD0/3HiFdYKoXWT2X8B5S3YzxSXgJJBk1oOQw
 Jn3/AyoDdR/nU5HWFm4a6H3krY3aaaJaHfyaV8ZvfA9goUDzMcqLNBWgN/62CgxgbrV4
 EZOw==
X-Gm-Message-State: AOJu0YyCgX5bI1Sg1GdFT6QgWgDpQSV4ejsMeIxfnIGpYrpQL0tU1hVo
 B6JUJBSW/vlRrGx8ywifC3FhmQI5plvhJxEff52yP8338xJtqkTxJ+Zl0TISo/JM9T/9L/RV1aP
 epQqfUD+e0w5817ANxudlRxf5DYBFISejSFzf6+gMRYt6aR70HNTchdb30J8pnvnE0sTY1Xnyex
 1mUYJtgNvI2wFnI/MKE4WBKU7wTuHzmuI8/dJ8u2xv
X-Gm-Gg: ASbGncvsjtzC6oJ4GhOqvrBzLsTjCD2vS3yTd+kCwkx4DPsUQPoFk+JAKg3fojJy5Eu
 yVZHWlBwpFRCtGEv3rC6dYt0SPK8q+HV3IAtNh7SVo73lMf9j10UDFzmJoUzKQlt6UP85DTAi/V
 xRYWZgjgacngH8uDf7S422GPa+sytxFiFgvIyKRMAa8O8swT7Kw3B1XJeZGBogxuCT2qy/1dJQ2
 DOU0VJK8ITi+GPkR0cNVaWufcXpA0Z/Lxa5Q46RKpL8H6xv3E6nKQJxkURNfuj989f9305cj1Bh
 PSEABM07YubQd/CbSiBSz6Ulexh+iLjwczjna5MvmqM=
X-Received: by 2002:a05:6000:43d8:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3b5f18eb539mr7587540f8f.45.1752491118012; 
 Mon, 14 Jul 2025 04:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLxe6Pv/JAq/DYpkZ9Ch0HlrtQArZruWL1hai16doCi9lEvmYo5lsLITD8YKLLtQj9syEWDg==
X-Received: by 2002:a05:6000:43d8:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3b5f18eb539mr7587509f8f.45.1752491117369; 
 Mon, 14 Jul 2025 04:05:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8cfsm11756831f8f.80.2025.07.14.04.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 26/77] docs/system: Add documentation on support for IGVM
Date: Mon, 14 Jul 2025 13:03:15 +0200
Message-ID: <20250714110406.117772-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

IGVM support has been implemented for Confidential Guests that support
AMD SEV and AMD SEV-ES. Add some documentation that gives some
background on the IGVM format and how to use it to configure a
confidential guest.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/b4dc920a30717e19cd79bbbe2cc769f3b9ff3d37.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 173 +++++++++++++++++++++
 docs/system/index.rst                      |   1 +
 3 files changed, 176 insertions(+)
 create mode 100644 docs/system/igvm.rst

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index 748f5094baf..6c23f3535f4 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -1,3 +1,5 @@
+.. _amd-sev:
+
 AMD Secure Encrypted Virtualization (SEV)
 =========================================
 
diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
new file mode 100644
index 00000000000..79508d95880
--- /dev/null
+++ b/docs/system/igvm.rst
@@ -0,0 +1,173 @@
+Independent Guest Virtual Machine (IGVM) support
+================================================
+
+IGVM files are designed to encapsulate all the information required to launch a
+virtual machine on any given virtualization stack in a deterministic way. This
+allows the cryptographic measurement of initial guest state for Confidential
+Guests to be calculated when the IGVM file is built, allowing a relying party to
+verify the initial state of a guest via a remote attestation.
+
+Although IGVM files are designed with Confidential Computing in mind, they can
+also be used to configure non-confidential guests. Multiple platforms can be
+defined by a single IGVM file, allowing a single IGVM file to configure a
+virtual machine that can run on, for example, TDX, SEV and non-confidential
+hosts.
+
+QEMU supports IGVM files through the user-creatable ``igvm-cfg`` object. This
+object is used to define the filename of the IGVM file to process. A reference
+to the object is added to the ``-machine`` to configure the virtual machine
+to use the IGVM file for configuration.
+
+Confidential platform support is provided through the use of
+the ``ConfidentialGuestSupport`` object. If the virtual machine provides an
+instance of this object then this is used by the IGVM loader to configure the
+isolation properties of the directives within the file.
+
+Further Information on IGVM
+---------------------------
+
+Information about the IGVM format, including links to the format specification
+and documentation for the Rust and C libraries can be found at the project
+repository:
+
+https://github.com/microsoft/igvm
+
+
+Supported Platforms
+-------------------
+
+Currently, IGVM files can be provided for Confidential Guests on host systems
+that support AMD SEV, SEV-ES and SEV-SNP with KVM. IGVM files can also be
+provided for non-confidential guests.
+
+
+Limitations when using IGVM with AMD SEV, SEV-ES and SEV-SNP
+------------------------------------------------------------
+
+IGVM files configure the initial state of the guest using a set of directives.
+Not every directive is supported by every Confidential Guest type. For example,
+AMD SEV does not support encrypted save state regions, therefore setting the
+initial CPU state using IGVM for SEV is not possible. When an IGVM file contains
+directives that are not supported for the active platform, an error is generated
+and the guest launch is aborted.
+
+The table below describes the list of directives that are supported for SEV,
+SEV-ES, SEV-SNP and non-confidential platforms.
+
+.. list-table:: SEV, SEV-ES, SEV-SNP & non-confidential Supported Directives
+   :widths: 35 65
+   :header-rows: 1
+
+   * - IGVM directive
+     - Notes
+   * - IGVM_VHT_PAGE_DATA
+     - ``NORMAL`` zero, measured and unmeasured page types are supported. Other
+       page types result in an error.
+   * - IGVM_VHT_PARAMETER_AREA
+     -
+   * - IGVM_VHT_PARAMETER_INSERT
+     -
+   * - IGVM_VHT_VP_COUNT_PARAMETER
+     - The guest parameter page is populated with the CPU count.
+   * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
+     - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
+       page.
+
+.. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
+   :widths: 25 75
+   :header-rows: 1
+
+   * - IGVM directive
+     - Notes
+   * - IGVM_VHT_MEMORY_MAP
+     - The memory map page is populated using entries from the E820 table.
+   * - IGVM_VHT_REQUIRED_MEMORY
+     - Ensures memory is available in the guest at the specified range.
+
+.. list-table:: Additional SEV-ES & SEV-SNP Supported Directives
+   :widths: 25 75
+   :header-rows: 1
+
+   * - IGVM directive
+     - Notes
+   * - IGVM_VHT_VP_CONTEXT
+     - Setting of the initial CPU state for the boot CPU and additional CPUs is
+       supported with limitations on the fields that can be provided in the
+       VMSA. See below for details on which fields are supported.
+
+Initial CPU state with VMSA
+---------------------------
+
+The initial state of guest CPUs can be defined in the IGVM file for AMD SEV-ES
+and SEV-SNP. The state data is provided as a VMSA structure as defined in Table
+B-4 in the AMD64 Architecture Programmer's Manual, Volume 2 [1].
+
+The IGVM VMSA is translated to CPU state in QEMU which is then synchronized
+by KVM to the guest VMSA during the launch process where it contributes to the
+launch measurement. See :ref:`amd-sev` for details on the launch process and
+guest launch measurement.
+
+It is important that no information is lost or changed when translating the
+VMSA provided by the IGVM file into the VSMA that is used to launch the guest.
+Therefore, QEMU restricts the VMSA fields that can be provided in the IGVM
+VMSA structure to the following registers:
+
+RAX, RCX, RDX, RBX, RBP, RSI, RDI, R8-R15, RSP, RIP, CS, DS, ES, FS, GS, SS,
+CR0, CR3, CR4, XCR0, EFER, PAT, GDT, IDT, LDTR, TR, DR6, DR7, RFLAGS, X87_FCW,
+MXCSR.
+
+When processing the IGVM file, QEMU will check if any fields other than the
+above are non-zero and generate an error if this is the case.
+
+KVM uses a hardcoded GPA of 0xFFFFFFFFF000 for the VMSA. When an IGVM file
+defines initial CPU state, the GPA for each VMSA must match this hardcoded
+value.
+
+Firmware Images with IGVM
+-------------------------
+
+When an IGVM filename is specified for a Confidential Guest Support object it
+overrides the default handling of system firmware: the firmware image, such as
+an OVMF binary should be contained as a payload of the IGVM file and not
+provided as a flash drive or via the ``-bios`` parameter. The default QEMU
+firmware is not automatically populated into the guest memory space.
+
+If an IGVM file is provided along with either the ``-bios`` parameter or pflash
+devices then an error is displayed and the guest startup is aborted.
+
+Running a guest configured using IGVM
+-------------------------------------
+
+To run a guest configured with IGVM you firstly need to generate an IGVM file
+that contains a guest configuration compatible with the platform you are
+targeting.
+
+The ``buildigvm`` tool [2] is an example of a tool that can be used to generate
+IGVM files for non-confidential X86 platforms as well as for SEV, SEV-ES and
+SEV-SNP confidential platforms.
+
+Example using this tool to generate an IGVM file for AMD SEV-SNP::
+
+    buildigvm --firmware /path/to/OVMF.fd --output sev-snp.igvm \
+              --cpucount 4 sev-snp
+
+To run a guest configured with the generated IGVM you need to add an
+``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
+
+Example (for AMD SEV)::
+
+    qemu-system-x86_64 \
+        <other parameters> \
+        -machine ...,confidential-guest-support=sev0,igvm-cfg=igvm0 \
+        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \
+        -object igvm-cfg,id=igvm0,file=/path/to/sev-snp.igvm
+
+References
+----------
+
+[1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
+  Rev 3.41
+  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+
+[2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
+  https://github.com/roy-hopkins/buildigvm
\ No newline at end of file
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 718e9d3c56b..427b0204831 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -38,5 +38,6 @@ or Hypervisor.Framework.
    security
    multi-process
    confidential-guest-support
+   igvm
    vm-templating
    sriov
-- 
2.50.0


