Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A1FC7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZHE-0001Lr-Fq; Tue, 17 Jun 2025 12:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG5-0000lQ-M7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG0-0000d6-K5
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so36920995e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178035; x=1750782835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKHVjbEZEAlGzEnK1mT5V15dOYDZALJJ9P4ZN2AdSHE=;
 b=vjOqLM4vNS0Lacmf4nB+l3uVgl5UZ/wJqJ+G8Xfu1u4pyrRFX45dzwXX74K9BFEfUk
 kem2uO0mjam3j9xFFvUG7gtfEDLMEGgMomL5O/VdXY98RxbpQ3J7JHR7mqlRe5xLKAdv
 cfxUZXDVPw1eVhMXIM7cADXw1hdBfN9GGvWi5ISs8XV95klaEe3zv3THqNT7dt5JQE80
 jR6iQa9NFK63Ir5bTWHEbC6Zf711861irRHIw3pcKFglvnw9hej12rHFiXvd/zQoeZEW
 OXGbomsa+OnbK9ljMHctDsF5HqyfioQSR0eXg5sUSSu4z0lC+ZJfPl3zuBSl9vbshkYo
 hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178035; x=1750782835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKHVjbEZEAlGzEnK1mT5V15dOYDZALJJ9P4ZN2AdSHE=;
 b=MaQGq3R7Rj+QQ1D6YH9kwCzNWy+luU+8Zv0wNCwd36p5V3qiSt/cfcuhT86SpA/II5
 Q2JqJXrP0jeSfH1wzjsxUKaki05ukIcNzb6zP4/dR+AtLY+G+H8Fuxq0Wwww3hLEbaOJ
 y3/0JFcZwB7DANueVq+PtEuymG64T/nysOg2RGJrtwOQJgC1b7vnfwWiCPHeVWanoqrb
 oHcRqEeHKUl4rSr0dM8L8X7iV8jlR0AhfkkwktVP5xvVQX6A2u+styYUAT8At+bWIBSf
 gDRa/fEBMvRD6lVBNhAvoF0j7d0R8IS2cVEi+RchuN5lNbNL7QOiNAZ4+LY4awp7TPYG
 JwwA==
X-Gm-Message-State: AOJu0YzrbTXIuBI98DobomV+dl2rmWJ6L2zJnF2AsnS7s5LM6ltpadoF
 OUw9Qe1dsYK47ojhPqdB84/1RsVnXHCjb3fmIRTsN+8r7F/xWfGpkxEjXERgADKInkM=
X-Gm-Gg: ASbGncsrnxdkZIrFHfd3Hui69QpGRy5WgZr1H3Q+tgRawqy3ty0EwkoNrHyq0siLu/t
 UciDrS/ayf0940oARIu9UkQK2xZzkysbZUXQh3elRuWg7nxGej3PcsyOtcIZxlzJalxMX2vErUL
 17YVMpfvVxLO81Yx2mCiwKCmGAGjoa+iP6XrgypE4fsJLVD4lDRqaLrZf9hqzJZyyx4CY9tsV+m
 hiV4Jp5I5m3H0U3Akahb+1ARJi2J+uoe68iXRX+geVcGWai/zDmMdR1qan3fmK3+3CSO4zmdXUX
 T7tu6DXUM296Bz1K3RVJo70Gro9WWaOugO9Bwzintuvr6xX627G1HWZRtd1orYo=
X-Google-Smtp-Source: AGHT+IEcabvh7yBYNUgPCbH5qrmXiMx66xje3D7cTPVNv24ZJ3XnrP+Kpx0AQ2nGH2YgxABhGdC5jA==
X-Received: by 2002:a05:600c:1d06:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4533c9bf9e2mr148215485e9.0.1750178034971; 
 Tue, 17 Jun 2025 09:33:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7e980sm14106592f8f.41.2025.06.17.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E6FE5F878;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 03/11] linux-headers: Update to Linux 6.15.1 with
 trap-mem-harder (WIP)
Date: Tue, 17 Jun 2025 17:33:43 +0100
Message-ID: <20250617163351.2640572-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Import headers for trap-me-harder, based on 6.15.1.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/standard-headers/linux/virtio_pci.h | 1 +
 linux-headers/linux/kvm.h                   | 8 ++++++++
 linux-headers/linux/vhost.h                 | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 91fec6f502..09e964e6ee 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -246,6 +246,7 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_ADMIN_CMD_LIST_USE	0x1
 
 /* Admin command group type. */
+#define VIRTIO_ADMIN_GROUP_TYPE_SELF	0x0
 #define VIRTIO_ADMIN_GROUP_TYPE_SRIOV	0x1
 
 /* Transitional device admin command. */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 99cc82a275..bb51fb179b 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_ARM_TRAP_HARDER  40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -439,6 +440,12 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_ARM_TRAP_HARDER */
+		struct {
+			__u64 esr;
+			__u64 elr;
+			__u64 far;
+		} arm_trap_harder;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -645,6 +652,7 @@ struct kvm_enable_cap {
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
+#define KVM_VM_TYPE_ARM_TRAP_ALL        0x10000ULL
 /*
  * ioctls for /dev/kvm fds:
  */
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index b95dd84eef..d4b3e2ae13 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -28,10 +28,10 @@
 
 /* Set current process as the (exclusive) owner of this file descriptor.  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
 
 /* Set up/modify memory layout */
-- 
2.47.2


