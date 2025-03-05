Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4040CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdya-0006Nz-On; Tue, 04 Mar 2025 20:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyS-0005lf-Bh
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:05 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyP-0000AK-AY
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22349dc31bcso110909385ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139700; x=1741744500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibhnpkmuVp9eXDuKrzAQioC6/yCyg6gSMoQoNDKUnis=;
 b=U6hlA5i8rvIdNl+Rx9nHwL/MIYRZB6/tpdoxSlQDJLJQV0UV+A8K3iVny6ohta+bfO
 X19G3X/H8yzEDYrqn97ywk1YsDflcPO7SMf66uWvtcPlzoGt4iN2Pi5F9qyvDRwXHUTe
 aAknrbPEsErJzvslywLT/sCYlLpuKJE8mnftaU0RWAGW6h2j75XpJ2mj+9ggyyBghVZ2
 kMps076Ob+kRCvHsYEskydaE7oneWlAAeZxK+TWGKK/fdExMebteGTJs9sdVTDTY6vgu
 bS2QUzd7gmO8eUWwCOfAuHwNjrQAFGhv4fe9WsACZJGGQ5QLSt4wG2a9GF7185fjch0L
 sF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139700; x=1741744500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibhnpkmuVp9eXDuKrzAQioC6/yCyg6gSMoQoNDKUnis=;
 b=JCTDMSzjk/pZ1xnZkOMxyMjU4EIoiSr2FdDfmQAGDrA6EcDNfWjEGq9B10VGxiAlrk
 /jN6WkMsWjr9kQEJ4DXb+S3ewg06fG6H5oiwYEVCHlTQGGbsi5D4fej7wpXEMqD73EOa
 CCsPFUOBybN2qfYvZd2lbvXcOjmBIUXBnHM0yCikd21MHBgn7l2DXddGXrbIP5lv5PYW
 fhvobQYkVlR8m550osiULZ4jvdrQHYg3PT0PEjKIO0QCHQorQ3DGs5klCCI+6Vv8HN14
 tOyiyWTUPuYlvBoJG/P3F1kcWeE+itjG5vTH2v59Qf1HFXZF/iOvaSJ6kzH73mWfDLmV
 DNkw==
X-Gm-Message-State: AOJu0YwB0QCbBuyFcAicJ+y8Mma5YLOv2TlKNHeOi7y3bAgbXY0CpxuY
 x+pDmxZA/FgCxNCiIhGRMk3SorvleGlmSm1j6cXGNIFwMofm8q/3ARLvwF++lFs=
X-Gm-Gg: ASbGncuIofH1TIz48DTgtX/j3sowhP5/C+kbpmC6fgfn4KBwHZWGtsnVtRm0+vgiK+Q
 inn0Fy91Wv/GQBoKB1anAlDeaa3pgOAYYz98e9PQTB/oJr3u7/Ewj5U5CN7aO1ljhdV2i0MkYn3
 RQEzlypmjGw7yREw4jpYX4fw3f54/KyK93Td2S/I8PLBMd0FK2Qgxy6mLi8BIGUrOxI0gLH3NoI
 KSn03iHLqzI2uHYH7pI2XciaXLCZSQHo4taYYuq8rVfr5NMna3Hb4HUBsyFVDXqccDsw5SgAKml
 NFZVU5ipyxDDPX5bDSyRIugaHQ2rBqYkOM57L1uSBKMCjxzVLuwROdMLUR+bGxBUBcbogxNB9/k
 GtN+DVwwNddHjYRLM2fNY3gCzmkuxeA62zfB3AA+/l86XlmCdoME=
X-Google-Smtp-Source: AGHT+IHSroadFcml7NhExpJfz/VcglpTmAIJrFQ+4cxRxX1F1YOSeUPPeh0Xv6svqFsJkokns+FsmQ==
X-Received: by 2002:a17:903:32c8:b0:21f:4144:a06f with SMTP id
 d9443c01a7336-223f1c8097emr23135475ad.13.1741139699476; 
 Tue, 04 Mar 2025 17:54:59 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/59] linux-headers: Update to Linux v6.14-rc3
Date: Wed,  5 Mar 2025 11:52:44 +1000
Message-ID: <20250305015307.1463560-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Update headers to retrieve the latest KVM caps for RISC-V.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250221153758.652078-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


