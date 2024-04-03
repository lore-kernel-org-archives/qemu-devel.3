Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A6CCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryYM-0003DU-Of; Wed, 03 Apr 2024 07:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryY6-0002sg-7U
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rryXk-0007St-FD
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:57 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0C15CB89;
 Wed,  3 Apr 2024 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1712142752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40sx95K0HZ08I/8HlcKcvFC8Eq0LzebJzwbI8guOrgc=;
 b=KFYBW5TxQZjQPmf5qULBqYR0wuFtabqzMuofb6M/1+wnqoTM2e5tXLkI9M7pFiUhTAG3As
 q+I3FvpG3eYB1OiMDdsbsZwB10+6AKMGIOXmWDiH88Bm9aknQfaKdbnc712qzrPOiFQ8dW
 DUjYiXz95wDZnlta/x6URtgj443vbEw=
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7351813357;
 Wed,  3 Apr 2024 11:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id gKNoGZ85DWayHQAAn2gu4w
 (envelope-from <roy.hopkins@suse.com>); Wed, 03 Apr 2024 11:12:31 +0000
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
Subject: [PATCH v2 09/10] docs/system: Add documentation on support for IGVM
Date: Wed,  3 Apr 2024 12:11:40 +0100
Message-ID: <985ff6b76ae5cb3ced6b3798a940840ad8d27c76.1712141833.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712141833.git.roy.hopkins@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]; 
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_DKIM_NA(0.00)[]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL1cdfboiju7js16zrknyuzw5d)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 6E0C15CB89
Received-SPF: pass client-ip=195.135.223.131;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
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
 docs/system/igvm.rst                       | 129 +++++++++++++++++++++
 docs/system/index.rst                      |   1 +
 3 files changed, 132 insertions(+)
 create mode 100644 docs/system/igvm.rst

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index e9bc142bc1..a253bf7db1 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -1,3 +1,5 @@
+.. _amd-sev:
+
 AMD Secure Encrypted Virtualization (SEV)
 =========================================
 
diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
new file mode 100644
index 0000000000..b07c11fa6e
--- /dev/null
+++ b/docs/system/igvm.rst
@@ -0,0 +1,129 @@
+Independent Guest Virtual Machine (IGVM) support
+================================================
+
+IGVM files are designed to encapsulate all the information required to launch a
+virtual machine on any given virtualization stack in a deterministic way. This
+allows the cryptographic measurement of initial guest state for Confidential
+Guests to be calculated when the IGVM file is built, allowing a relying party to
+verify the initial state of a guest via a remote attestation.
+
+QEMU supports IGVM files through the Confidential Guest Support object. An igvm
+filename can optionally be passed to the object which will subsequently be
+parsed and used to configure the guest state prior to launching the guest.
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
+that support AMD SEV and SEV-ES running under KVM.
+
+
+Limitations when using IGVM with AMD SEV and SEV-ES
+---------------------------------------------------
+
+IGVM files configure the initial state of the guest using a set of directives.
+Not every directive is supported by every Confidential Guest type. For example,
+AMD SEV does not support encrypted save state regions, therefore setting the
+initial CPU state using IGVM for SEV is not possible. When an IGVM file contains
+directives that are not supported for the active platform, an error is displayed
+and the guest launch is aborted.
+
+The table below describes the list of directives that are supported for SEV and
+SEV-ES.
+
+.. list-table:: SEV & SEV-ES Supported Directives
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
+   * - IGVM_VHT_MEMORY_MAP
+     - The memory map page is populated using entries from the E820 table.
+   * - IGVM_VHT_VP_COUNT_PARAMETER
+     - The guest parameter page is populated with the CPU count.
+   * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
+     - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
+       page.
+
+.. list-table:: Additional SEV-ES Supported Directives
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
+Initial CPU state with SEV-ES VMSA
+----------------------------------
+
+The initial state of guest CPUs can be defined in the IGVM file for AMD SEV-ES.
+The state data is provided as a VMSA structure as defined in Table B-4 in the
+AMD64 Architecture Programmer's Manual, Volume 2 [1].
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
+CR0, CR3, CR4, XCR0, EFER.
+
+When processing the IGVM file, QEMU will check if any fields other than the
+above are non-zero and generate an error if this is the case.
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
+To run a confidential guest configured with IGVM you need to add the
+``igvm-file`` parameter to the "confidential guest support" object:
+
+Example (for AMD SEV)::
+
+    qemu-system-x86_64 \
+        <other parameters> \
+        -machine ...,confidential-guest-support=sev0 \
+        -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1,igvm-file=/path/to/guest.igvm
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


