Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D1BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6S-0001W2-QL; Fri, 07 Aug 2026 01:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6R-0001Vt-In
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6P-0000ky-DQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVetCtGeVGJ+1GSqT1mv6d811spa95Oee+E05wldwxw=;
 b=jW0Mgk6udHNSeqquZ/Tj4+1ACl3rvz37WRhzIXWzcjf8QhfA++7LQCO17HrO+UJrFCVhS9
 lFsTTZyzyNiinGa2tIqZl+4ZpzXTdY9pjf2Lz4RwTCHbX7mgrDfnwc0YvMA3SLUpDnySOO
 M5GG6XVtF2CG3bsTFbLBtLfOYjEny7U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-6fL1ACAOPB6zpXCEMGKErQ-1; Fri, 07 Aug 2026 01:26:34 -0400
X-MC-Unique: 6fL1ACAOPB6zpXCEMGKErQ-1
X-Mimecast-MFC-AGG-ID: 6fL1ACAOPB6zpXCEMGKErQ_1786080393
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso2595897a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080393; x=1786685193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oVetCtGeVGJ+1GSqT1mv6d811spa95Oee+E05wldwxw=;
 b=WoBFAMmwUZl6J/QzFVDGSECX+2J0Ra8hae4buJjXqg7NLYEmll6FOGFDo7IS0vGZFc
 OgpZbz6e9u3n0TY5P94G/aPerFkGQ+iSKdJmaYHPoyu3dhuAK4OlIw7ZpN9wT+Gjzi2R
 7R2DKrYUmRPusXxSFh5+AHNTGESn8nY1I8nOJNmcTA4MndogwtIf+cy9QJs4afuD6UBy
 PLvUG6D/1nTctpiasjq5ceNg5E/T707Cmh5T67aIiSQrUToEQiMozFSe7fs9gPhIvOjm
 ent5aC9+Ypt5A03rgC1BTdSgtkzFYjx/JZiyddy2iL71FR2kBcg9MT4FbKfuPsl6ym9O
 5BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080393; x=1786685193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oVetCtGeVGJ+1GSqT1mv6d811spa95Oee+E05wldwxw=;
 b=gz8KWTortA9TW+kT0EoyNTQ+tz3km8K1b5HbkoO2DXO2KK26Efb8uja9VXqlWuEQQ+
 u7tVhiiyE1aEnRUz6JDyeNWwmbRpYqRHbh2uLBLlGBIGiyK9FLIStbR8nPDdjWz8uNCU
 46A8/ucfKoQUnkz4cq6kCJ9gfc7ddtG0aLeeUXb1axM8OPNV9PIOeMFhR+RkqGrQPKTF
 8+CEQnZzWNgQzuyT2YRhYG8xQJwFg9Tc0tTfuxmgoV3TekIunOWBKYlX61Wh8gUdvZgO
 jlnzkfEtO4MqQ1WURO98iywWVRyicx7ZFWmLGs0Ztt+GCuDAjjiljRy3cGfDaPvvXUwF
 PCUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUb+OUcSVsQT6vs4A05aR5v9ksJQSZ+dfLdchyttrCXVo6GN+ID/FXQ2MbdROspwNvhAG5Wv1Yozlq@nongnu.org
X-Gm-Message-State: AOJu0YzVW5J19IFjA+SYtKu8wgM4VShhrAM8+EYhmjDfBowTVPD6BHk7
 94PFN+AWlZR1GDWj/Olu9CnBPgeIZFN8x0T7wnYaLB7m1Nyfgl9GQwQ5L5Q9NOtjIJ29FWZ7jWe
 Lzt5VS6Av6S82i7VHFRx3e5kdKkFVPZF1R3aMGH/3wYo+grqplSI2zlfavWy64bkGokU=
X-Gm-Gg: AR+sD11I89CxIrRmn1ZFREWBgEpiDnmQpXjSl7LnrDivvNk9JbLhyYVSsfZ2Lz3gAGI
 0l8jiWLetyOuGhxMwaAoRdb45i43qXN2BryA5sPqg7wIy8MaSIujU/doPb3gm9BxDgi6pDK0vXl
 LBPQMtkMbLA8LXRVDZJzTwBbetOWLDIapjEE6hGvcKt25YD4+l4oNasThpNixBhcv15NAw7S/Bw
 mcoDWjrcdW2pdN759PaWBcP5dFlPY5hqimzUwh+f86XDPwJhVdwIoz8BjLcBUU/hmCN1CSoG66p
 LZT8WL+lw7et3onXCkFptEIVbe6CozcX+hXS4C5NghAPnwcMxLN/8PbodzwyuueQq8ye8Y88z7P
 3XGjxgxz1K6y+0zDXtPMwgn+ZYV6xSvma5A==
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-3903c5380f7mr20060632a91.3.1786080392749; 
 Thu, 06 Aug 2026 22:26:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-3903c5380f7mr20060590a91.3.1786080392072; 
 Thu, 06 Aug 2026 22:26:32 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:31 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 08/11] docs/spec: Add a specification document for
 vm-launch-update device
Date: Fri,  7 Aug 2026 10:55:50 +0530
Message-ID: <20260807052559.50643-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

This change adds a specification document and expanation for the
vm-launch-update device.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>

Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/specs/index.rst          |   1 +
 docs/specs/vmlaunchupdate.rst | 197 ++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)
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
index 0000000000..55aaa82fb3
--- /dev/null
+++ b/docs/specs/vmlaunchupdate.rst
@@ -0,0 +1,197 @@
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
+        uint16_t status;
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
+Only IGVM files are supported at present. The ``capabilities`` (line 5) and ``control`` (line 6) both support
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
+``fw_image_addr`` (line 8) is the base guest physical address of the guest memory where the IGVM file of size
+``fw_image_size`` (line 9) is loaded. ``opaque_addr`` (line 10) and ``opaque_size`` (line 12) are used by
+the guest for passing data across resets. The contents of this guest memory are preserved across the
+reset. For confidential guests, this memory region must come from guest shared unencrypted memory.
+
+``status`` (line 4) is written by the hypervisor and it indicates the result of the IGVM loading operation.
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


