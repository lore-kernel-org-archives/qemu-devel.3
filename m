Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4017CC56201
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZQS-0000mo-I8; Wed, 05 Aug 2026 07:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snambakam@linux.microsoft.com>)
 id 1wrZQO-0000jX-9q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:40 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <snambakam@linux.microsoft.com>) id 1wrZQL-0000CA-Vg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:39 -0400
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8876620B716B;
 Wed,  5 Aug 2026 04:04:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8876620B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785927855;
 bh=04q3RI9A0fv9Xv+CMnIW2+ug2+E5td90cLNjC3O338o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cf09I0XR8R2W07hl3fGLpXOq8j1M18pEWCZofQxc9vmvmSLxgtUn+ohS7Ly05r0k5
 +7J6dgvhRxSV9AglW/1olZyReiSLgZXYcNMVByExMl164o5vbtXAF2ZsCBiqmHGEIQ
 lAj+OnfnXZ9OHS2TG1RcsFqokEsXpA7J62eI3n2o=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 2/5] vm_planes: Add VBS VTL call handling and plane
 memory sealing
Date: Wed,  5 Aug 2026 04:04:29 -0700
Message-ID: <20260805110432.25167-3-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=snambakam@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Wire up the VBS inter-plane communication and memory protection
infrastructure on the QEMU side.

Memory sealing (plane activate path):
  After plane-1 boots and its vCPU threads are running, seal
  plane-1's memory from plane-0 access:
  1. Issue KVM_SET_PLANE_MEMORY_ATTRIBUTES to set NO_WRITE|NO_EXEC
     on plane-0's EPT for the GPA range occupied by plane-1.
  2. Clear ps->host_addr so QEMU userspace can no longer access
     the region.

VBS VTL hypercall handler:
  Handle KVM_HC_VBS_VTL_CALL (hypercall 15) exits from the guest.
  The plane-0 VBS subsystem passes the GPA of a shared calling-area
  (CAA) page; QEMU reads the call_id from the page, logs it, and
  returns -ENOSYS for now (plane-1 responder not yet implemented).
  Enable the hypercall in kvm_enable_hypercall() alongside the
  existing VM planes hypercalls.

Header sync:
  - linux-headers/linux/kvm.h: Add KVM_MEMORY_ATTRIBUTE_NO_WRITE,
    KVM_MEMORY_ATTRIBUTE_NO_EXEC, struct kvm_plane_memory_attributes,
    and KVM_SET_PLANE_MEMORY_ATTRIBUTES ioctl definition.
  - include/standard-headers/linux/kvm_para.h: Add KVM_HC_VBS_VTL_CALL.

(cherry picked from commit 414016c40ec8226b0f5d4cbd5eed0589b7c1689e)
---
 linux-headers/linux/kvm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index d66ce6d272..9dbd3824e9 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1653,6 +1653,19 @@ struct kvm_memory_attributes {
 };
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+#define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
+#define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
+
+/* Set memory attributes on a specific plane's address space. */
+struct kvm_plane_memory_attributes {
+	__u32 plane;
+	__u32 flags;
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+};
+
+#define KVM_SET_PLANE_MEMORY_ATTRIBUTES	_IOW(KVMIO, 0xd6, struct kvm_plane_memory_attributes)
 
 #define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
 #define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
-- 
2.55.0


