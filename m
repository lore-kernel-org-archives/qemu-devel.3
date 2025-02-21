Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDCDC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTrm-0002OW-JW; Fri, 21 Feb 2025 09:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTre-0002LF-Hv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTrb-00071l-CA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:49 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-221057b6ac4so40191535ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740147525; x=1740752325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XI0IvlQEH5O6ddnnlohPtfuIzpvfe1Je8XQOQkMl6nI=;
 b=Ey+kw4+piUZdaB3C+2qDurTps5SlvucEAXPo/tih9Xe/sQecBjt9rjhItmIOfBoULZ
 gC5pt/4IvBau3bcxzCPZkQI+H33AGBp6brfKMvVjQtlHjqQGWDtHlgWq2UDz405TEt7c
 MvAjGe7Gn0Q9yO+Eut7zlANrmcMyMxlrH3JT7EppUMscloVmadxlQicsaiGlRZuGiqO9
 6mfBj1fSARqX1obcU3dxo894Cp/lYE2jDArIXl3ZXzPaMnJJsLfTPbQdqDgFp6JlBF2q
 p/BrRMeIFvL7CwScJw33+Nyqb44DK0Pzj5sK/PJUh3eK9QVyDzfdyFKj94X2bszn2DBL
 7zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147525; x=1740752325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XI0IvlQEH5O6ddnnlohPtfuIzpvfe1Je8XQOQkMl6nI=;
 b=TVqng5ksx2cg30LOqa0SlkIpmOVkrB1YZXzG/TTt19/ZmU23bGGgk7JYIx+Xi1Ft+D
 zx+K5KOI7exoyuvCesjlIWFia818aXBuzYKUZ5v/1xoZm6WmcwI8bxW6am6PFpKqMa72
 p6p6Wl7sgPPYttU1u1IT6x79SSuPf0m7EsCm1TUa5KbIkbmYa6eDQWrAZBg1GzG+D3Zc
 p8nhcLvE5vwZ+ISdAsX63HVfmM8u0Y0/52dOPjThepCLNY0XHWeStRyF/jBM73P1GKdK
 Bwqp5Q/VxNCu+SVxMr3+px4xsGy13Kz28LvUKw+0EK75q+b4dj1KBvroCnjUynrFUtiC
 EwVQ==
X-Gm-Message-State: AOJu0YyNEAJxLTZp3XbNOwnykwU670+K3pyeMaAyb2k+d0Y/b1+peaPW
 zb7w9OKBmBtzJvMHiOFVxEidNFcGuPW8LgaOU+KWyfWJ/uWjdVbM+lDy90E2UI+xy9mLdZ2fJHP
 j
X-Gm-Gg: ASbGncuTYaFlrf9zDDJYcxq0A+rLdQocccNRgcM32Ug32vhdOXr06QxzSimjgljnnCJ
 xRe0E6ZDNohzq9bbwVKEyzpQI/XZ8lvV2r43i07pyo+AzTWBDc12n2oc9jVwwPVbBdlsz0UJ6Lq
 DryYJn5oaeLxKJ/6nAt7OMjlONosr+MMingZwcmfG3+Ibj9E3B9zXAUUbxTbU8RumSiLmIOwmNu
 RbpwKoB8B5BmF+S2zXtD+bsFFNrkuvs1fVXeydkgy74vdWSalbuc6yBb7cXmJ9sra99T1n6rAXq
 2bMkbiaQnuTrEwXsvR4tOZ6F645zCbv7wBjoNGl1Ol6bOozB2feSYQ==
X-Google-Smtp-Source: AGHT+IH1u8vNQJ3mgTYPQabk4ushS5D2rsNcfc3ObLV8LmKw9F4Ker88pDeZjRyTiArgRrPWEfNkzw==
X-Received: by 2002:a05:6a00:928f:b0:732:23ed:9470 with SMTP id
 d2e1a72fcca58-73426d9549bmr4968304b3a.23.1740147524692; 
 Fri, 21 Feb 2025 06:18:44 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734300da098sm1150290b3a.129.2025.02.21.06.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 06:18:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/3] linux-headers: Update to Linux v6.14-rc3
Date: Fri, 21 Feb 2025 11:18:32 -0300
Message-ID: <20250221141834.626722-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221141834.626722-1-dbarboza@ventanamicro.com>
References: <20250221141834.626722-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Update headers to retrieve the latest KVM caps for RISC-V.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/standard-headers/linux/ethtool.h      |  4 +
 include/standard-headers/linux/fuse.h         | 76 ++++++++++++++++++-
 .../linux/input-event-codes.h                 |  1 +
 include/standard-headers/linux/pci_regs.h     | 16 ++--
 include/standard-headers/linux/virtio_pci.h   | 14 ++++
 linux-headers/asm-arm64/kvm.h                 |  3 -
 linux-headers/asm-loongarch/kvm_para.h        |  1 +
 linux-headers/asm-riscv/kvm.h                 |  7 +-
 linux-headers/asm-x86/kvm.h                   |  1 +
 linux-headers/linux/iommufd.h                 | 35 ++++++---
 linux-headers/linux/kvm.h                     |  8 +-
 linux-headers/linux/stddef.h                  | 13 +++-
 linux-headers/linux/vduse.h                   |  2 +-
 13 files changed, 146 insertions(+), 35 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 67c47912e5..e83382531c 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -681,6 +681,8 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
+ * @ETH_SS_TS_FLAGS: hardware timestamping flags
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +708,8 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_STATS_PHY,
+	ETH_SS_TS_FLAGS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 889e12ad15..d303effb2a 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -220,6 +220,15 @@
  *
  *  7.41
  *  - add FUSE_ALLOW_IDMAP
+ *  7.42
+ *  - Add FUSE_OVER_IO_URING and all other io-uring related flags and data
+ *    structures:
+ *    - struct fuse_uring_ent_in_out
+ *    - struct fuse_uring_req_header
+ *    - struct fuse_uring_cmd_req
+ *    - FUSE_URING_IN_OUT_HEADER_SZ
+ *    - FUSE_URING_OP_IN_OUT_SZ
+ *    - enum fuse_uring_cmd
  */
 
 #ifndef _LINUX_FUSE_H
@@ -251,7 +260,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 41
+#define FUSE_KERNEL_MINOR_VERSION 42
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -421,6 +430,7 @@ struct fuse_file_lock {
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
+ * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -467,6 +477,7 @@ struct fuse_file_lock {
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
+#define FUSE_OVER_IO_URING	(1ULL << 41)
 
 /**
  * CUSE INIT request/reply flags
@@ -1202,4 +1213,67 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+/**
+ * Size of the ring buffer header
+ */
+#define FUSE_URING_IN_OUT_HEADER_SZ 128
+#define FUSE_URING_OP_IN_OUT_SZ 128
+
+/* Used as part of the fuse_uring_req_header */
+struct fuse_uring_ent_in_out {
+	uint64_t flags;
+
+	/*
+	 * commit ID to be used in a reply to a ring request (see also
+	 * struct fuse_uring_cmd_req)
+	 */
+	uint64_t commit_id;
+
+	/* size of user payload buffer */
+	uint32_t payload_sz;
+	uint32_t padding;
+
+	uint64_t reserved;
+};
+
+/**
+ * Header for all fuse-io-uring requests
+ */
+struct fuse_uring_req_header {
+	/* struct fuse_in_header / struct fuse_out_header */
+	char in_out[FUSE_URING_IN_OUT_HEADER_SZ];
+
+	/* per op code header */
+	char op_in[FUSE_URING_OP_IN_OUT_SZ];
+
+	struct fuse_uring_ent_in_out ring_ent_in_out;
+};
+
+/**
+ * sqe commands to the kernel
+ */
+enum fuse_uring_cmd {
+	FUSE_IO_URING_CMD_INVALID = 0,
+
+	/* register the request buffer and fetch a fuse request */
+	FUSE_IO_URING_CMD_REGISTER = 1,
+
+	/* commit fuse request result and fetch next request */
+	FUSE_IO_URING_CMD_COMMIT_AND_FETCH = 2,
+};
+
+/**
+ * In the 80B command area of the SQE.
+ */
+struct fuse_uring_cmd_req {
+	uint64_t flags;
+
+	/* entry identifier for commits */
+	uint64_t commit_id;
+
+	/* queue the command is for (queue index) */
+	uint16_t qid;
+	uint8_t padding[6];
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 50b2b7497e..09ba0ad878 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -519,6 +519,7 @@
 #define KEY_NOTIFICATION_CENTER	0x1bc	/* Show/hide the notification center */
 #define KEY_PICKUP_PHONE	0x1bd	/* Answer incoming call */
 #define KEY_HANGUP_PHONE	0x1be	/* Decline incoming call */
+#define KEY_LINK_PHONE		0x1bf   /* AL Phone Syncing */
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 1601c7ed5f..3445c4970e 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -533,7 +533,7 @@
 #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
 #define PCI_EXP_LNKCAP		0x0c	/* Link Capabilities */
-#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
+#define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Max Link Speed (prior to PCIe r3.0: Supported Link Speeds) */
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
@@ -665,6 +665,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX	0x00c00000 /* Max End-End TLP Prefixes */
 #define PCI_EXP_DEVCTL2		0x28	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
@@ -789,10 +790,11 @@
 	/* Same bits as above */
 #define PCI_ERR_CAP		0x18	/* Advanced Error Capabilities & Ctrl*/
 #define  PCI_ERR_CAP_FEP(x)	((x) & 0x1f)	/* First Error Pointer */
-#define  PCI_ERR_CAP_ECRC_GENC	0x00000020	/* ECRC Generation Capable */
-#define  PCI_ERR_CAP_ECRC_GENE	0x00000040	/* ECRC Generation Enable */
-#define  PCI_ERR_CAP_ECRC_CHKC	0x00000080	/* ECRC Check Capable */
-#define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
+#define  PCI_ERR_CAP_ECRC_GENC		0x00000020 /* ECRC Generation Capable */
+#define  PCI_ERR_CAP_ECRC_GENE		0x00000040 /* ECRC Generation Enable */
+#define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
+#define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
+#define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
 #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
@@ -808,6 +810,7 @@
 #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
+#define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes) */
 
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
@@ -1001,9 +1004,6 @@
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
 
-#define PCI_VSEC_HDR		4	/* extended cap - vendor-specific */
-#define  PCI_VSEC_HDR_LEN_SHIFT	20	/* shift for length field */
-
 /* SATA capability */
 #define PCI_SATA_REGS		4	/* SATA REGs specifier */
 #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index b177ed8972..91fec6f502 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -116,6 +116,8 @@
 #define VIRTIO_PCI_CAP_PCI_CFG		5
 /* Additional shared memory capability */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* PCI vendor data configuration */
+#define VIRTIO_PCI_CAP_VENDOR_CFG	9
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -130,6 +132,18 @@ struct virtio_pci_cap {
 	uint32_t length;		/* Length of the structure, in bytes. */
 };
 
+/* This is the PCI vendor data capability header: */
+struct virtio_pci_vndr_data {
+	uint8_t cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	uint8_t cap_next;		/* Generic PCI field: next ptr. */
+	uint8_t cap_len;		/* Generic PCI field: capability length */
+	uint8_t cfg_type;		/* Identifies the structure. */
+	uint16_t vendor_id;	/* Identifies the vendor-specific format. */
+	/* For Vendor Definition */
+	/* Pads structure to a multiple of 4 bytes */
+	/* Reads must not have side effects */
+};
+
 struct virtio_pci_cap64 {
 	struct virtio_pci_cap cap;
 	uint32_t offset_hi;             /* Most sig 32 bits of offset */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index dccd5d965f..ec1e82bdc8 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -43,9 +43,6 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_DIRTY_LOG_PAGE_OFFSET 64
 
-#define KVM_REG_SIZE(id)						\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
 struct kvm_regs {
 	struct user_pt_regs regs;	/* sp = sp_el0 */
 
diff --git a/linux-headers/asm-loongarch/kvm_para.h b/linux-headers/asm-loongarch/kvm_para.h
index 4ba4ad8db1..fd7f40713d 100644
--- a/linux-headers/asm-loongarch/kvm_para.h
+++ b/linux-headers/asm-loongarch/kvm_para.h
@@ -17,5 +17,6 @@
 #define  KVM_FEATURE_STEAL_TIME		2
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
+#define  KVM_FEATURE_USER_HCALL		25
 
 #endif /* _ASM_KVM_PARA_H */
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 3482c9a73d..f06bc5efcd 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -179,6 +179,9 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_SSNPM,
 	KVM_RISCV_ISA_EXT_SVADE,
 	KVM_RISCV_ISA_EXT_SVADU,
+	KVM_RISCV_ISA_EXT_SVVPTC,
+	KVM_RISCV_ISA_EXT_ZABHA,
+	KVM_RISCV_ISA_EXT_ZICCRSE,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
@@ -198,6 +201,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_VENDOR,
 	KVM_RISCV_SBI_EXT_DBCN,
 	KVM_RISCV_SBI_EXT_STA,
+	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
@@ -211,9 +215,6 @@ struct kvm_riscv_sbi_sta {
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
 
-#define KVM_REG_SIZE(id)		\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_RISCV_TYPE_MASK		0x00000000FF000000
 #define KVM_REG_RISCV_TYPE_SHIFT	24
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 96589490c4..86f2c34e7a 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -923,5 +923,6 @@ struct kvm_hyperv_eventfd {
 #define KVM_X86_SEV_VM		2
 #define KVM_X86_SEV_ES_VM	3
 #define KVM_X86_SNP_VM		4
+#define KVM_X86_TDX_VM		5
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 37aae16502..ccbdca5e11 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -297,7 +297,7 @@ struct iommu_ioas_unmap {
  *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
- *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
+ *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
  *    based accounting. Global option, object_id must be 0
  * @IOMMU_OPTION_HUGE_PAGES:
  *    Value 1 (default) allows contiguous pages to be combined when generating
@@ -390,7 +390,7 @@ struct iommu_vfio_ioas {
  * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
  *                          domain can be attached to any PASID on the device.
  *                          Any domain attached to the non-PASID part of the
- *                          device must also be flaged, otherwise attaching a
+ *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
@@ -558,16 +558,25 @@ struct iommu_hw_info_vtd {
  * For the details of @idr, @iidr and @aidr, please refer to the chapters
  * from 6.3.1 to 6.3.6 in the SMMUv3 Spec.
  *
- * User space should read the underlying ARM SMMUv3 hardware information for
- * the list of supported features.
+ * This reports the raw HW capability, and not all bits are meaningful to be
+ * read by userspace. Only the following fields should be used:
  *
- * Note that these values reflect the raw HW capability, without any insight if
- * any required kernel driver support is present. Bits may be set indicating the
- * HW has functionality that is lacking kernel software support, such as BTM. If
- * a VMM is using this information to construct emulated copies of these
- * registers it should only forward bits that it knows it can support.
+ * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
+ * idr[1]: SIDSIZE, SSIDSIZE
+ * idr[3]: BBML, RIL
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
  *
- * In future, presence of required kernel support will be indicated in flags.
+ * - S1P should be assumed to be true if a NESTED HWPT can be created
+ * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
+ *   true.
+ * - ATS is a per-device property. If the VMM describes any devices as ATS
+ *   capable in ACPI/DT it should set the corresponding idr.
+ *
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * important that VMMs do not read bits outside the list to allow for
+ * compatibility with future kernels. Several features in the SMMUv3
+ * architecture are not currently supported by the kernel for nesting: HTTU,
+ * BTM, MPAM and others.
  */
 struct iommu_hw_info_arm_smmuv3 {
 	__u32 flags;
@@ -766,7 +775,7 @@ struct iommu_hwpt_vtd_s1_invalidate {
 };
 
 /**
- * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cache invalidation
  *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
  * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
  *       Must be little-endian.
@@ -859,6 +868,7 @@ enum iommu_hwpt_pgfault_perm {
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @__reserved: Must be 0.
  * @addr: Fault address
  * @length: a hint of how much data the requestor is expecting to fetch. For
  *          example, if the PRI initiator knows it is going to do a 10MB
@@ -874,7 +884,8 @@ struct iommu_hwpt_pgfault {
 	__u32 pasid;
 	__u32 grpid;
 	__u32 perm;
-	__u64 addr;
+	__u32 __reserved;
+	__aligned_u64 addr;
 	__u32 length;
 	__u32 cookie;
 };
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3bcd4eabe3..27181b3dd8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -609,10 +609,6 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
-#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
-                                              KVM_X86_DISABLE_EXITS_HLT | \
-                                              KVM_X86_DISABLE_EXITS_PAUSE | \
-                                              KVM_X86_DISABLE_EXITS_CSTATE)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
@@ -1062,6 +1058,10 @@ struct kvm_dirty_tlb {
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
+
+#define KVM_REG_SIZE(id)		\
+	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
+
 #define KVM_REG_SIZE_U8		0x0000000000000000ULL
 #define KVM_REG_SIZE_U16	0x0010000000000000ULL
 #define KVM_REG_SIZE_U32	0x0020000000000000ULL
diff --git a/linux-headers/linux/stddef.h b/linux-headers/linux/stddef.h
index 96aa341942..e1416f7937 100644
--- a/linux-headers/linux/stddef.h
+++ b/linux-headers/linux/stddef.h
@@ -8,6 +8,13 @@
 #define __always_inline __inline__
 #endif
 
+/* Not all C++ standards support type declarations inside an anonymous union */
+#ifndef __cplusplus
+#define __struct_group_tag(TAG)		TAG
+#else
+#define __struct_group_tag(TAG)
+#endif
+
 /**
  * __struct_group() - Create a mirrored named and anonyomous struct
  *
@@ -20,13 +27,13 @@
  * and size: one anonymous and one named. The former's members can be used
  * normally without sub-struct naming, and the latter can be used to
  * reason about the start, end, and size of the group of struct members.
- * The named struct can also be explicitly tagged for layer reuse, as well
- * as both having struct attributes appended.
+ * The named struct can also be explicitly tagged for layer reuse (C only),
+ * as well as both having struct attributes appended.
  */
 #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
 	union { \
 		struct { MEMBERS } ATTRS; \
-		struct TAG { MEMBERS } ATTRS NAME; \
+		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
 #ifdef __cplusplus
diff --git a/linux-headers/linux/vduse.h b/linux-headers/linux/vduse.h
index 6d2ca064b5..f46269af34 100644
--- a/linux-headers/linux/vduse.h
+++ b/linux-headers/linux/vduse.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 #ifndef _VDUSE_H_
 #define _VDUSE_H_
 
-- 
2.48.1


