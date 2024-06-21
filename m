Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCA5C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfHC-0001Ho-HD; Fri, 21 Jun 2024 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH4-0001Cr-Jc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH2-0005hG-AH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12F7121B39;
 Fri, 21 Jun 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXUj576ZH/UAwIpbetG+KVFn3ezXsW0jAcicO9dSYKc=;
 b=Bd92MUKlZaEgTbWNW5wv+1f+1asWdJTIMbqqoo49UZvGgCkE+CMB4yZ0a3OqRPBf9wyG8M
 MJdaLhwYTjOqBHQ8G9ELSMOtIraMpdmeSfoLBxj14l8eEwtMfa/GhONr9dbUu2zyNilxrm
 m5mYoLDT3dqJ7POd+7BZychyYqGj8Tk=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=tVBYBpJN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXUj576ZH/UAwIpbetG+KVFn3ezXsW0jAcicO9dSYKc=;
 b=tVBYBpJNLr3AfmduunYECgrpjXcLomP07/AYwDIpaUoP+/QqrFFwJvrcMzVl7BRYpu1sCE
 ucvB4BJmLRdWsBF/P5h1t1YX627nqiMKN9SlqfYmP/4OexAOl/DBRa5EszVcnb0mfcxdDC
 6fOh75VdcXAeQdxlEeqSIElyXo8IS/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5074F13ABD;
 Fri, 21 Jun 2024 14:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6M2cEWGOdWbwKQAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Fri, 21 Jun 2024 14:29:53 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v3 09/15] docs/system: Add documentation on support for IGVM
Date: Fri, 21 Jun 2024 15:29:12 +0100
Message-ID: <b666f4e30e8785de3dc944ac8dbefd0a23f49f5d.1718979106.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979106.git.roy.hopkins@suse.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12F7121B39
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLgjcjk3igk5en59wt86eb8xw3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

IGVM support has been implemented for Confidential Guests that support
AMD SEV and AMD SEV-ES. Add some documentation that gives some
background on the IGVM format and how to use it to configure a
confidential guest.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 157 +++++++++++++++++++++
 docs/system/index.rst                      |   1 +
 3 files changed, 160 insertions(+)
 create mode 100644 docs/system/igvm.rst

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index 748f5094ba..6c23f3535f 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -1,3 +1,5 @@
+.. _amd-sev:
+
 AMD Secure Encrypted Virtualization (SEV)
 =========================================
 
diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
new file mode 100644
index 0000000000..b6e544a508
--- /dev/null
+++ b/docs/system/igvm.rst
@@ -0,0 +1,157 @@
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
+     -
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
+Running a Confidential Guest configured using IGVM
+--------------------------------------------------
+
+To run a confidential guest configured with IGVM you need to add an
+``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
+
+Example (for AMD SEV)::
+
+    qemu-system-x86_64 \
+        <other parameters> \
+        -machine ...,confidential-guest-support=sev0,igvm-cfg=igvm0 \
+        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \
+        -object igvm-cfg,id=igvm0,file=/path/to/guest.igvm
+
+References
+----------
+
+[1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
+  Rev 3.41
+  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
\ No newline at end of file
diff --git a/docs/system/index.rst b/docs/system/index.rst
index c21065e519..6235dfab87 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -38,4 +38,5 @@ or Hypervisor.Framework.
    security
    multi-process
    confidential-guest-support
+   igvm
    vm-templating
-- 
2.43.0


