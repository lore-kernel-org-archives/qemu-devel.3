Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6115C5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRq3-0006ao-5V; Fri, 21 Aug 2026 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpu-0006VZ-Qz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRps-0001Yc-D3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfbONaxa0yS3q1QeVM9oaKCkGpU1oU9TEtuSmszrRSc=;
 b=YyyPCMHkyQUQ1v7mPE+eqzpxgzeASXVozPAUH0Isnf0BgnBbu6Os2Ki2ZwidsN8tpvV2KH
 imgNpvu0RCKXBzJGrK1WJppWXF8CGqnvjWOasGFy6kZ5YnpJBFOBJk4prb0qBZV1ESR8Rh
 i2byAA5mhLnZhfQpSucUB5mwp6s693E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-oJlJHhrwOp-T31fhH3bnTQ-1; Fri,
 21 Aug 2026 12:11:12 -0400
X-MC-Unique: oJlJHhrwOp-T31fhH3bnTQ-1
X-Mimecast-MFC-AGG-ID: oJlJHhrwOp-T31fhH3bnTQ_1787328671
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD68819539A7; Fri, 21 Aug 2026 16:11:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9616A1800346; Fri, 21 Aug 2026 16:11:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3C2F180103A; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Graf <graf@amazon.com>
Subject: [PULL 09/12] docs/spec: Add a specification document for
 vm-launch-update device
Date: Fri, 21 Aug 2026 18:10:57 +0200
Message-ID: <20260821161103.3489298-10-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

This change adds a specification document and expanation for the
vm-launch-update device.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>

Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260817142010.80693-9-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/index.rst          |   1 +
 docs/specs/vmlaunchupdate.rst | 198 ++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 docs/specs/vmlaunchupdate.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108ab9..3cdf242661b4 100644
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
index 000000000000..2f1e95afbffa
--- /dev/null
+++ b/docs/specs/vmlaunchupdate.rst
@@ -0,0 +1,198 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+VMLAUNCHUPDATE Interface Specification
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
+        uint16_t status;
+
+        uint32_t _padding;
+
+        uint64_t capabilities;
+        uint64_t control;
+
+        uint64_t fw_image_addr;
+        uint64_t fw_image_size;
+
+        uint64_t opaque_addr;
+        uint64_t opaque_size;
+
+ } VMLaunchUpdate;
+
+
+Currently, the ``version`` number (line 2 above) is initialized to the value ``1``.
+Only IGVM files are supported at present. The ``capabilities`` (line 7) and ``control`` (line 8) both support
+the following single value:
+
+* ``VM_LAUNCHUPDATE_FORMAT_IGVM``
+
+  This value is used by the hypervisor to indicate that only IGVM container files are supported.
+  This is set  as a part of ``capabilities`` parameter (line 7) in the above structure. This same value
+  is passed by the guest to the hypervisor in the ``control`` parameter (line 8) in the above structure
+  to indicate that the guest passed IGVM file in memory to the hypervisor. The starting guest physical
+  address of the IGVM file in memory is specified in ``fw_image_addr`` and it's length is specified in
+  ``fw_image_size`` by the guest. If any other value is passed by the guest in the ``control`` parameter,
+  the write is ignored by the hypervisor.
+
+Following  ``control`` parameters are supported:
+
+* ``VM_LAUNCHUPDATE_CTL_DISABLE``
+
+  This value is set in the ``control`` parameter by the guest in order to disable this ``fw-cfg``
+  hypervisor interface from further updating the guest launch state with a new IGVM file.
+
+* ``VM_LAUNCHUPDATE_CTL_HOST_IGVM``
+
+  This value is set in the ``control`` parameter by the guest in order to send request to the
+  hypervisor to initialize the guest using the original host provided IGVM file.
+  It is useful if the guest wanted to update the UKIs present in the ESP and upon
+  reset, use one of the updated UKIs present there. If the guest passed addresses in memory
+  where its own IGVM file is loaded (see below) while also setting this control value, the next
+  reset will load the guest provided IGVM file and a subsequent second reset will restore the original
+  host IGVM. If the guest did not provide any addresses of its own IGVM (the address values are
+  cleared) while setting this control parameter, the immediate next guest reset will load the
+  original host provided IGVM file.
+
+  The combination of the above two ctl interfaces work as
+  follows:
+
+  A) ``CTL_HOST_IGVM`` = off ``CTL_DISABLE`` = off
+
+    Supplied IGVM file replaces the firmware permanently.  Updating the
+    firmware again is possible.
+
+  B) ``CTL_HOST_IGVM`` = off ``CTL_DISABLE`` = on
+
+    Supplied IGVM file replaces the firmware permanently.  Updating the
+    firmware again is not possible.
+
+  C) ``CTL_HOST_IGVM`` = on ``CTL_DISABLE`` = off
+
+    Supplied IGVM file replaces the firmware for one reset.  Resetting
+    again will switch back to the original firmware.  Updating the
+    firmware again is possible.
+
+  D) ``CTL_HOST_IGVM`` = on ``CTL_DISABLE`` = on
+
+    Supplied IGVM file replaces the firmware for one reset.  Resetting
+    again will switch back to the original firmware.  Updating the
+    firmware again is NOT possible.
+
+``fw_image_addr`` (line 10) is the base guest physical address of the guest memory where the IGVM file of size
+``fw_image_size`` (line 11) is loaded. ``opaque_addr`` (line 13) and ``opaque_size`` (line 14) are used by
+the guest for passing data across resets. The contents of this guest memory are preserved across the
+reset. For confidential guests, this memory region must come from guest shared unencrypted memory.
+
+``status`` (line 3) is written by the hypervisor and it indicates the result of the IGVM loading operation.
+A success indicates status code 0. Otherwise a non-zero status code indicates failure. The nature of the
+failure is indicated by the value of the code.
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
+guest can throw error and abort rebooting to new IGVM boot state. Alternatively, the guest can
+also check the ``status`` code from the ``fw-cfg`` file. A status code of 0 indicates success
+of the operation. Non-zero status code indicates failure. Exact nature of the failure is
+indicated by the value of the code. Currently, only two error values are supported:
+
+* ``VM_LAUNCHUPDATE_LOAD_FAIL`` - defined as value 1 and is set when loading of the IGVM file failed.
+* ``VM_LAUNCHUPDATE_NOT_IGVM_INIT`` - defined as value 2 and is set when the guest was not started with
+  IGVM file.
+
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
+guest memory is preserved (this is the default behaviour today - QEMU does not reset/clear
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
-- 
2.55.0


