Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DC8CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZJ-00074V-Qo; Wed, 24 Jun 2026 01:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZH-00073G-7u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZD-000671-7y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADh+O37DTAktIcZ73zzXhpRrNLuHeLwq4/clgPng32A=;
 b=M7enAKzM58IIjeviKz9Yw9WUIi1YW/sayh/rrR78KRJvgMWmnFLIyEeF4ARIk16GlOYFdM
 EQDNeBljUPtE3msNxvuyH20mYYikEkNpUG64I5EEEZSbnqTS0Q5QBEKFGPhf/dlG77yMAx
 OnA6hgfxlvfs7ROfzhjYE20+6EMYqSs=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-8gZJVO3YN4-w6In-sezdqg-1; Wed, 24 Jun 2026 01:54:27 -0400
X-MC-Unique: 8gZJVO3YN4-w6In-sezdqg-1
X-Mimecast-MFC-AGG-ID: 8gZJVO3YN4-w6In-sezdqg_1782280467
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so379865eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280467; x=1782885267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADh+O37DTAktIcZ73zzXhpRrNLuHeLwq4/clgPng32A=;
 b=mGX8OziLXXZERpMhPrEQci+U9EoLGEaMjOuZ1A1wq4lsWfboGd8LhRRrwlQ9+sglQG
 wjWFSvhXmht3xyBunHqNmDXBTTCjg0xUUi5jvyHu20nUfMwofYbkKJRFreXdswPDehGQ
 jPchLv5maSn4XLa3htD+JBnjvcvuDwgwvBIkJ16P49P1wjLlPTOyesgO8fpcI6ldL5J4
 TN/uwLZwpYqSTgcNMBfVwRZzEgthbHi4PQM5EZtxPGgOBqNI1H/fKqHUZEip34Sr/WHN
 rNBTYv+I2s4usLX/peiVNdG7e+S3BmNyFYhIWj4mDNyHDVV4ugPSBycV8g6XoszhgylN
 fHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280467; x=1782885267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ADh+O37DTAktIcZ73zzXhpRrNLuHeLwq4/clgPng32A=;
 b=DrEeLUvFXxto6Vn9x6VC+FsdLRJwxfeHHt8CKxiF7uvyTm7lMb8Pjp7NNlmrjCm4kN
 Chawy6cv5w3Y2gybE1s75RgH+oV4v8/SgwNgafSHlNGGl6bl8vRlzx8Adktgu4z39+yZ
 1sx6wc3Zl5eYR42cDykRm2wD9f9uXYdQj02+JCQnAKq7sUtvDAGCjUIDnEFiMGYsLsWR
 EgrokQsg0L/2QoHffhiWHbFKZTyh6zNznunTJZSiTLdvCkLH7EByaygnXFQSb6UiM6IJ
 0VAOkxVS66dW7DZuqbPbQ1+3cWWBK/d+ZPR9AGLIt03k1PbMkMzO6Ovv5+iQ49dA1AnO
 OXYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIUUsQiHFY6HbazypJdPlxAIQYTMNN1m4OiPTsbSYIe6kNtatrJnCq5Dgmx6G/+eZlkoH/BJwUP5za@nongnu.org
X-Gm-Message-State: AOJu0Yz/nWMbNwwZiuBLxvPCi9KyekTr2i3kjeHMnjfCF8q/0WXNE+wk
 OYOUGDQ/UY79TtsGbIts87x6+gBjMyKOVR7Pz29o4qdYUC0XBrCAfgsqPdQ5YDhU8Q3ELQ1y32i
 8Zm7ZLJsGmCWoc5la0DeUegTFyhp/eHZJNaxx5dwruGdt6vaQjm1MtQMy
X-Gm-Gg: AfdE7cmhl/ctDvgi1OR2X4JohPUZc+s2KS3FANQp6xbEgjgJX5Zzx9zVeewn9GLJL3y
 kHguqdD46qmA5xu6mBXTcGnU560fLt/g0DLTYy+248pZfzi+1PUYStMmhksqvr4bFPYyThjehaI
 fDRuZ3YwNQUVbWJ9UEjZxuh3okbMp34oeV7WBkHVMn8oWSJMDEjLI1jaMa0SCaWZ4n6p0DySCh8
 8n3i6Pmq3Z1wK7SN1HoD0DlwmNQXVgZK7mna+lEAJxNEUHoOTjbi1t42igHtVfCqshs8vscxXT8
 3LKvtW6MKmlbInx/HDNi72HbWbTD0rgYqkaVFfvV9TspjY8fBgh5eBdzwhC2AMTVZIxP9XUoRNL
 MeQux59ynd8qWzvOKLDesk7nCHnslcouDTauoGwaJRets
X-Received: by 2002:a05:693c:2d82:b0:30c:a0f:3bd0 with SMTP id
 5a478bee46e88-30c555dc677mr5660879eec.13.1782280466365; 
 Tue, 23 Jun 2026 22:54:26 -0700 (PDT)
X-Received: by 2002:a05:693c:2d82:b0:30c:a0f:3bd0 with SMTP id
 5a478bee46e88-30c555dc677mr5660869eec.13.1782280465725; 
 Tue, 23 Jun 2026 22:54:25 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:25 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>
Cc: Alex Graf <graf@amazon.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v1 5/8] docs/spec: Add a specification document for
 vm-launch-update device
Date: Wed, 24 Jun 2026 11:23:27 +0530
Message-ID: <20260624055339.46862-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

This change adds a specification document and expanation for the
vm-launch-update device.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/specs/index.rst          |   1 +
 docs/specs/vmlaunchupdate.rst | 147 ++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 docs/specs/vmlaunchupdate.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..3cdf242661 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -34,6 +34,7 @@ guest hardware that is specific to QEMU.
    virt-ctlr
    vmcoreinfo
    vmgenid
+   vmlaunchupdate
    rapl-msr
    rocker
    riscv-iommu
diff --git a/docs/specs/vmlaunchupdate.rst b/docs/specs/vmlaunchupdate.rst
new file mode 100644
index 0000000000..ee6e7599bd
--- /dev/null
+++ b/docs/specs/vmlaunchupdate.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+VMLAUNCHUPDATE INTERFACE SPECIFICATION
+######################################
+
+Introduction
+************
+
+``VmLaunchUpdate`` is an extension to ``fw-cfg`` that allows guests to replace
+boot state in their virtual machine using IGVM file container. Through a combination
+of this ``fw-cfg`` hypervisor interface, an IGVM file containing specific directives
+and with hypervisor stack knowledge, guests can deterministically replace the launch
+state for guests. This is useful for environments like SEV-SNP where the
+launch payload becomes the launch digest. Guests can use vm-launch-update device to
+provide a measured, full guest payload (BIOS image, kernel, initramfs, kernel
+command line) to the virtual machine which enables them to easily reason about
+integrity of the resulting system.
+It is also to be noted that this mechanism currently works only when the guest was
+already started with an IGVM file defining its initial launch state. Subsequent
+guest resets will use the launch state as defined in the guest provided IGVM file,
+not the file with which the guest was initially started. If the guest was not started
+with IGVM, writing a new bundle through the ``fw-cfg`` interface has no effect.
+
+For more information, please see the `KVM Forum 2024 presentation <KVMFORUM_>`__
+about this work.
+
+
+.. _KVMFORUM: https://www.youtube.com/watch?v=VCMBxU6tAto
+
+Base Requirements
+*****************
+
+#. **fw-cfg**:
+     The target system must provide a ``fw-cfg`` interface. For x86 based
+     environments, this ``fw-cfg`` interface must be accessible through PIO ports
+     0x510 and 0x511. The ``fw-cfg`` interface does not need to be announced as part
+     of system device tables such as DSDT. The ``fw-cfg`` interface must support the
+     DMA interface. It may only support the DMA interface for write operations.
+
+#. **IGVM support**:
+     The hypervisor must provide support for parsing and executing the IGVM file bundle.
+
+#. **Confidential guests**:
+     For confidential guests, the hypervisor must support guest reset. Otherwise, the new
+     boot state provided through IGVM will not be applied.
+
+The Fw-cfg File
+***************
+
+Guests drive vmlaunchupdate through special ``fw-cfg`` files that control its flow
+followed by a standard system reset operation. When the ``vm-launch-update`` device
+is available, it provides the following ``fw-cfg`` file:
+
+* ``etc/vmlaunchupdate`` - It exposes a structure of the following type, all in
+  little-endian format:
+
+.. code-block:: c
+ :linenos:
+
+ typedef struct {
+        uint16_t version;
+
+        uint64_t capabilities;
+        uint64_t control;
+
+        uint64_t fw_image_addr;
+        uint32_t fw_image_size;
+
+        uint64_t opaque_addr;
+        uint64_t opaque_size;
+
+ } VMLaunchUpdate;
+
+
+Currently, the ``version`` number (line 2 above) is initialized to the value ``1``.
+Only IGVM files are supported at present. The ``capabilities`` (line 4) and ``control`` (line 5) both support
+the following single value:
+
+* ``VM_LAUNCHUPDATE_FORMAT_IGVM``
+
+  This value is used by the hypervisor to indicate that only IGVM container files are supported.
+  This is set  as a part of ``capabilities`` parameter (line 4) in the above structure. This same value
+  is passed by the guest to the hypervisor in the ``control`` parameter (line 5) in the above structure
+  to indicate that the guest passed IGVM file in memory to the hypervisor. The starting guest physical
+  address of the IGVM file in memory is specified in ``fw_image_addr`` and it's length is specified in
+  ``fw_image_size`` by the guest. If any other value is passed by the guest in the ``control`` parameter,
+  the write is ignored by the hypervisor.
+
+One additional ``control`` parameter is supported in order to disable the interface:
+
+* ``VM_LAUNCHUPDATE_CTL_DISABLE``
+
+  This value is set in the ``control`` parameter by the guest in order to disable this ``fw-cfg``
+  hypervisor interface from further updating the guest launch state with a new IGVM file.
+
+``fw_image_addr`` (line 7) is the base guest physical address of the guest memory where the IGVM file of size
+``fw_image_size`` (line 8) is loaded. ``opaque_addr`` (line 10) and ``opaque_size`` (line 11) are used by
+the guest for passing data across resets. The contents of this guest memory are preserved across the
+reset. For confidential guests, this memory region must come from guest shared unencrypted memory.
+
+Triggering the Launch State Update using IGVM
+*********************************************
+
+To initiate the launch update process, the guest issues a standard system reset
+operation through any of the means implemented by the machine model.
+
+On a write to the ``etc/vmlaunchupdate`` interface, the hypervisor evaluates whether this
+hypervisor interface is disabled. If it is, it ignores any writes to this ``fw-cfg`` file
+by the guest. No updates to initial launch state is performed.
+
+If the hypervisor interface is enabled, upon write to the ``etc/vmlaunchupdate`` interface,
+the hypervisor parses the IGVM file bundle passed to it in memory, with starting guest physical
+address at ``fw_image_addr`` and length ``fw_image_size``. If parsing is successful, it creates
+a context handle to the IGVM file. If parsing and context loading is successful and there are no
+errors, ``fw_image_addr`` and ``fw_image_size`` are cleared. The guest can check this in order
+to determine if the IGVM was successfully parsed and the new context was loaded. If not, the
+guest can throw error and abort rebooting to new IGVM boot state.
+Upon guest reset, the hypervisor executes the IGVM bundle using
+the context handle, setting the initial launch state of the guest accordingly.
+If an invalid IGVM file is passed, parsing the file fails and the hypervisor ignores it
+when ``fw-cfg`` files are written. In this case, the initial launch state
+is not modified. If invalid addresses are passed, the hypervisor ignores them as well and no
+new launch state is set.
+
+The launch state update mechanism works both for confidential and non-confidential
+guests. In confidential guests, as a part of the reset operation, all existing
+guest shared memory (shared with the hypervisor) as well as the guest memory region
+starting with ``opaque_addr`` and length ``opaque_size`` are preserved.
+The reset causes recreation of the VM context which triggers a fresh
+measurement of the replaced BIOS region and reset CPU state.
+
+For non-confidential guests, there is no concept of guest private memory and all the existing
+guest memory is preserved (this is the default behavior today - QEMU does not reset/clear
+guest memory upon reset).
+
+In both confidential and non-confidential cases, CPU and device state are reset to
+the reset states specified in IGVM. In confidential environments, the guest
+always resumes operation in the highest privileged mode available to it (VMPL0 in SEV-SNP).
+
+Closing Remarks
+***************
+The exact content of the memory region specified by starting address ``opaque_addr``
+and length ``opaque_size`` is guest specific and is hypervisor agnostic. The hypervisor does
+not care about the contents of this memory region. Therefore, it is not included in this
+specification. As of writing this document, TDX guests on QEMU does not support IGVM.
+Therefore, this mechanism cannot be used to change launch state of TDX guests.
+
-- 
2.42.0


