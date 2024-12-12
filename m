Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLegC-0006p5-Iw; Thu, 12 Dec 2024 03:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefr-0006l5-DY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:56 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefn-00052b-Gf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:54 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so292100a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992550; x=1734597350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBPTyr+TozmsNLBY7c67priDhmeDgbccIVy6qyyd/o0=;
 b=PRoB8cHmYHsh5pjCa6BmUOwYfHbl+xzVr521uNSk7sFt1GhgI9GVwHZFJ9UlMkeiYH
 ri36tauPfxfTrUUIafq8SP+udnQ8sm2RSH/1D8qyUG/tfhbILnQ3USEnrF/yPQpJ8PiA
 PM3ob3w5cKSzEbgQdOYLjwUdap2P/14zwX1XNOZ6FWBDrvxadYAFemqkS1wgjkKEnmtN
 41QhJXg/8coBep/c/VcH/EKb6D6KA4Mq8O3lGnR3UYkjUjqGWGpkiiR2+aZV0r0UTT9C
 1lRyZ/+kGDtPoQ1WDHaUQ6Db40OF9mkLFMkGJcNpDd5bnXkQh954V9S6okudOeL32gmT
 QHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992550; x=1734597350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBPTyr+TozmsNLBY7c67priDhmeDgbccIVy6qyyd/o0=;
 b=nGq38lR1sUd45Z7V0uAuyPFKZEdVCrC8HFEHUvPWn0y4y8qJNHfi8Mzu3DK1EBDiLM
 yPGOPjJTloPHaTAjhdiEwW0manRPC3hXXRmu67n/9RIzG7BtDhAelQK75u1Az0ZIY3Zm
 UpHS9H+qjywZO3jT20vMJ0K+enscdeL4bWu8T0HHuyAFr1S6SvDaR2p3iwuDXaQgoWmu
 EuzSdfgTe5TKUxDA/jaDv8LAzxLwcdF5cxH8nxbYR/EIk1G7eGmnI9XRr9rGlt3IjUXK
 T4uEcSY0zJzueb5hngMBf5Wk/P6NvGo8vuvbaG0YFaVM/n7vbUoa3e0/9JxnJCM5wXAM
 mIVg==
X-Gm-Message-State: AOJu0YwFK9IKcsoZ6R+bbEkt6Bytss/vjO9KnysXcqWBz1EyCZOSxfE9
 s0nf3CX+89Q9QAthHnqX8AW6u1p6hp1uTOgysIH86gVYSBKijX8l2Q/hxg==
X-Gm-Gg: ASbGncsf69jSK4nFhJkhrvmv+FeJLi2eWJ7ZcUVTCAWekSAeDSQCtKrpzXKQacEDoFT
 QK0TwwnenwaHDTvcY5W32Ph2XdU8YeGh5lo/DXujDXeRAoakaNb/pAZKfu6MFS3zi1lx6dMjJCa
 mZ51LG7ywM9Os0Y11YIyzGaAOPlEdZnNfZ7eEGLbuUYPf0Gh5KxO3CnS92wLow+8GFUoEud7Pr4
 ToBvDxH7mKpGvo2l4wm4pbnXazJCvxc6JkYkFIYFXWPOhmY53U9sDQP9po=
X-Google-Smtp-Source: AGHT+IHFFoGiQYPsUnFrj1Xx2zpStpVx4hCOL/00sxiaiQYk1o57sGY3tff+wVzyRg40z3dxrzmm9Q==
X-Received: by 2002:a17:90b:3c4f:b0:2ee:a744:a4fe with SMTP id
 98e67ed59e1d1-2f13930c26bmr4472795a91.25.1733992549765; 
 Thu, 12 Dec 2024 00:35:49 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 5/8] hw/usb/xhci: Move HCD constants to a header and add
 register constants
Date: Thu, 12 Dec 2024 18:34:58 +1000
Message-ID: <20241212083502.1439033-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Prepare to use some of these constants in xhci qtest code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.h | 190 +++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.c | 283 ++++++++++------------------------------------
 2 files changed, 250 insertions(+), 223 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index fe16d7ad055..5781542f40e 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -115,6 +115,196 @@ typedef enum TRBCCode {
     CC_SPLIT_TRANSACTION_ERROR
 } TRBCCode;
 
+/* Register definitions */
+#define XHCI_HCCAP_CAPLENGTH     0x00
+#define XHCI_HCCAP_HCIVERSION    0x02
+#define XHCI_HCCAP_HCSPARAMS1    0x04
+#define XHCI_HCCAP_HCSPARAMS2    0x08
+#define XHCI_HCCAP_HCSPARAMS3    0x0C
+#define XHCI_HCCAP_HCCPARAMS1    0x10
+#define XHCI_HCCAP_DBOFF         0x14
+#define XHCI_HCCAP_RTSOFF        0x18
+#define XHCI_HCCAP_HCCPARAMS2    0x1C
+#define XHCI_HCCAP_EXTCAP_START  0x20 /* SW-defined */
+
+#define XHCI_PORT_PORTSC         0x00
+#define   PORTSC_CCS             (1 << 0)
+#define   PORTSC_PED             (1 << 1)
+#define   PORTSC_OCA             (1 << 3)
+#define   PORTSC_PR              (1 << 4)
+#define   PORTSC_PLS_SHIFT           5
+#define   PORTSC_PLS_MASK        0xf
+#define   PORTSC_PP              (1 << 9)
+#define   PORTSC_SPEED_SHIFT        10
+#define   PORTSC_SPEED_MASK      0xf
+#define   PORTSC_SPEED_FULL      (1 << 10)
+#define   PORTSC_SPEED_LOW       (2 << 10)
+#define   PORTSC_SPEED_HIGH      (3 << 10)
+#define   PORTSC_SPEED_SUPER     (4 << 10)
+#define   PORTSC_PIC_SHIFT          14
+#define   PORTSC_PIC_MASK        0x3
+#define   PORTSC_LWS             (1 << 16)
+#define   PORTSC_CSC             (1 << 17)
+#define   PORTSC_PEC             (1 << 18)
+#define   PORTSC_WRC             (1 << 19)
+#define   PORTSC_OCC             (1 << 20)
+#define   PORTSC_PRC             (1 << 21)
+#define   PORTSC_PLC             (1 << 22)
+#define   PORTSC_CEC             (1 << 23)
+#define   PORTSC_CAS             (1 << 24)
+#define   PORTSC_WCE             (1 << 25)
+#define   PORTSC_WDE             (1 << 26)
+#define   PORTSC_WOE             (1 << 27)
+#define   PORTSC_DR              (1 << 30)
+#define   PORTSC_WPR             (1 << 31)
+#define XHCI_PORT_PORTPMSC       0x04
+#define XHCI_PORT_PORTLI         0x08
+#define XHCI_PORT_PORTHLPMC      0x0C
+
+#define XHCI_OPER_USBCMD         0x00
+#define   USBCMD_RS              (1 << 0)
+#define   USBCMD_HCRST           (1 << 1)
+#define   USBCMD_INTE            (1 << 2)
+#define   USBCMD_HSEE            (1 << 3)
+#define   USBCMD_LHCRST          (1 << 7)
+#define   USBCMD_CSS             (1 << 8)
+#define   USBCMD_CRS             (1 << 9)
+#define   USBCMD_EWE             (1 << 10)
+#define   USBCMD_EU3S            (1 << 11)
+#define XHCI_OPER_USBSTS         0x04
+#define   USBSTS_HCH             (1 << 0)
+#define   USBSTS_HSE             (1 << 2)
+#define   USBSTS_EINT            (1 << 3)
+#define   USBSTS_PCD             (1 << 4)
+#define   USBSTS_SSS             (1 << 8)
+#define   USBSTS_RSS             (1 << 9)
+#define   USBSTS_SRE             (1 << 10)
+#define   USBSTS_CNR             (1 << 11)
+#define   USBSTS_HCE             (1 << 12)
+#define XHCI_OPER_PAGESIZE       0x08
+#define XHCI_OPER_DNCTRL         0x14
+#define XHCI_OPER_CRCR_LO        0x18
+#define   CRCR_RCS              (1 << 0)
+#define   CRCR_CS               (1 << 1)
+#define   CRCR_CA               (1 << 2)
+#define   CRCR_CRR              (1 << 3)
+#define XHCI_OPER_CRCR_HI        0x1C
+#define XHCI_OPER_DCBAAP_LO      0x30
+#define XHCI_OPER_DCBAAP_HI      0x34
+#define XHCI_OPER_CONFIG         0x38
+
+#define XHCI_OPER_MFINDEX        0x00
+#define XHCI_OPER_IR0            0x20
+#define XHCI_OPER_IR_SZ          0x20
+
+#define XHCI_INTR_IMAN           0x00
+#define   IMAN_IP                (1 << 0)
+#define   IMAN_IE                (1 << 1)
+#define XHCI_INTR_IMOD           0x04
+#define XHCI_INTR_ERSTSZ         0x08
+#define XHCI_INTR_ERSTBA_LO      0x10
+#define XHCI_INTR_ERSTBA_HI      0x14
+#define XHCI_INTR_ERDP_LO        0x18
+#define   ERDP_EHB               (1 << 3)
+#define XHCI_INTR_ERDP_HI        0x1C
+
+#define TRB_SIZE 16
+typedef struct XHCITRB {
+    uint64_t parameter;
+    uint32_t status;
+    uint32_t control;
+    dma_addr_t addr;
+    bool ccs;
+} XHCITRB;
+
+enum {
+    PLS_U0              =  0,
+    PLS_U1              =  1,
+    PLS_U2              =  2,
+    PLS_U3              =  3,
+    PLS_DISABLED        =  4,
+    PLS_RX_DETECT       =  5,
+    PLS_INACTIVE        =  6,
+    PLS_POLLING         =  7,
+    PLS_RECOVERY        =  8,
+    PLS_HOT_RESET       =  9,
+    PLS_COMPILANCE_MODE = 10,
+    PLS_TEST_MODE       = 11,
+    PLS_RESUME          = 15,
+};
+
+#define CR_LINK TR_LINK
+
+#define TRB_C               (1 << 0)
+#define TRB_TYPE_SHIFT          10
+#define TRB_TYPE_MASK       0x3f
+#define TRB_TYPE(t)         (((t).control >> TRB_TYPE_SHIFT) & TRB_TYPE_MASK)
+
+#define TRB_EV_ED           (1 << 2)
+
+#define TRB_TR_ENT          (1 << 1)
+#define TRB_TR_ISP          (1 << 2)
+#define TRB_TR_NS           (1 << 3)
+#define TRB_TR_CH           (1 << 4)
+#define TRB_TR_IOC          (1 << 5)
+#define TRB_TR_IDT          (1 << 6)
+#define TRB_TR_TBC_SHIFT        7
+#define TRB_TR_TBC_MASK     0x3
+#define TRB_TR_BEI          (1 << 9)
+#define TRB_TR_TLBPC_SHIFT      16
+#define TRB_TR_TLBPC_MASK   0xf
+#define TRB_TR_FRAMEID_SHIFT    20
+#define TRB_TR_FRAMEID_MASK 0x7ff
+#define TRB_TR_SIA          (1 << 31)
+
+#define TRB_TR_DIR          (1 << 16)
+
+#define TRB_CR_SLOTID_SHIFT     24
+#define TRB_CR_SLOTID_MASK  0xff
+#define TRB_CR_EPID_SHIFT       16
+#define TRB_CR_EPID_MASK    0x1f
+
+#define TRB_CR_BSR          (1 << 9)
+#define TRB_CR_DC           (1 << 9)
+
+#define TRB_LK_TC           (1 << 1)
+
+#define TRB_INTR_SHIFT          22
+#define TRB_INTR_MASK       0x3ff
+#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) & TRB_INTR_MASK)
+
+#define EP_TYPE_MASK        0x7
+#define EP_TYPE_SHIFT           3
+
+#define EP_STATE_MASK       0x7
+#define EP_DISABLED         (0 << 0)
+#define EP_RUNNING          (1 << 0)
+#define EP_HALTED           (2 << 0)
+#define EP_STOPPED          (3 << 0)
+#define EP_ERROR            (4 << 0)
+
+#define SLOT_STATE_MASK     0x1f
+#define SLOT_STATE_SHIFT        27
+#define SLOT_STATE(s)       (((s) >> SLOT_STATE_SHIFT) & SLOT_STATE_MASK)
+#define SLOT_ENABLED        0
+#define SLOT_DEFAULT        1
+#define SLOT_ADDRESSED      2
+#define SLOT_CONFIGURED     3
+
+#define SLOT_CONTEXT_ENTRIES_MASK 0x1f
+#define SLOT_CONTEXT_ENTRIES_SHIFT 27
+
+typedef enum EPType {
+    ET_INVALID = 0,
+    ET_ISO_OUT,
+    ET_BULK_OUT,
+    ET_INTR_OUT,
+    ET_CONTROL,
+    ET_ISO_IN,
+    ET_BULK_IN,
+    ET_INTR_IN,
+} EPType;
+
 typedef struct XHCIRing {
     dma_addr_t dequeue;
     bool ccs;
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0dc..df0421ec326 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -65,154 +65,6 @@
 # error Increase XHCI_LEN_REGS
 #endif
 
-/* bit definitions */
-#define USBCMD_RS       (1<<0)
-#define USBCMD_HCRST    (1<<1)
-#define USBCMD_INTE     (1<<2)
-#define USBCMD_HSEE     (1<<3)
-#define USBCMD_LHCRST   (1<<7)
-#define USBCMD_CSS      (1<<8)
-#define USBCMD_CRS      (1<<9)
-#define USBCMD_EWE      (1<<10)
-#define USBCMD_EU3S     (1<<11)
-
-#define USBSTS_HCH      (1<<0)
-#define USBSTS_HSE      (1<<2)
-#define USBSTS_EINT     (1<<3)
-#define USBSTS_PCD      (1<<4)
-#define USBSTS_SSS      (1<<8)
-#define USBSTS_RSS      (1<<9)
-#define USBSTS_SRE      (1<<10)
-#define USBSTS_CNR      (1<<11)
-#define USBSTS_HCE      (1<<12)
-
-
-#define PORTSC_CCS          (1<<0)
-#define PORTSC_PED          (1<<1)
-#define PORTSC_OCA          (1<<3)
-#define PORTSC_PR           (1<<4)
-#define PORTSC_PLS_SHIFT        5
-#define PORTSC_PLS_MASK     0xf
-#define PORTSC_PP           (1<<9)
-#define PORTSC_SPEED_SHIFT      10
-#define PORTSC_SPEED_MASK   0xf
-#define PORTSC_SPEED_FULL   (1<<10)
-#define PORTSC_SPEED_LOW    (2<<10)
-#define PORTSC_SPEED_HIGH   (3<<10)
-#define PORTSC_SPEED_SUPER  (4<<10)
-#define PORTSC_PIC_SHIFT        14
-#define PORTSC_PIC_MASK     0x3
-#define PORTSC_LWS          (1<<16)
-#define PORTSC_CSC          (1<<17)
-#define PORTSC_PEC          (1<<18)
-#define PORTSC_WRC          (1<<19)
-#define PORTSC_OCC          (1<<20)
-#define PORTSC_PRC          (1<<21)
-#define PORTSC_PLC          (1<<22)
-#define PORTSC_CEC          (1<<23)
-#define PORTSC_CAS          (1<<24)
-#define PORTSC_WCE          (1<<25)
-#define PORTSC_WDE          (1<<26)
-#define PORTSC_WOE          (1<<27)
-#define PORTSC_DR           (1<<30)
-#define PORTSC_WPR          (1<<31)
-
-#define CRCR_RCS        (1<<0)
-#define CRCR_CS         (1<<1)
-#define CRCR_CA         (1<<2)
-#define CRCR_CRR        (1<<3)
-
-#define IMAN_IP         (1<<0)
-#define IMAN_IE         (1<<1)
-
-#define ERDP_EHB        (1<<3)
-
-#define TRB_SIZE 16
-typedef struct XHCITRB {
-    uint64_t parameter;
-    uint32_t status;
-    uint32_t control;
-    dma_addr_t addr;
-    bool ccs;
-} XHCITRB;
-
-enum {
-    PLS_U0              =  0,
-    PLS_U1              =  1,
-    PLS_U2              =  2,
-    PLS_U3              =  3,
-    PLS_DISABLED        =  4,
-    PLS_RX_DETECT       =  5,
-    PLS_INACTIVE        =  6,
-    PLS_POLLING         =  7,
-    PLS_RECOVERY        =  8,
-    PLS_HOT_RESET       =  9,
-    PLS_COMPILANCE_MODE = 10,
-    PLS_TEST_MODE       = 11,
-    PLS_RESUME          = 15,
-};
-
-#define CR_LINK TR_LINK
-
-#define TRB_C               (1<<0)
-#define TRB_TYPE_SHIFT          10
-#define TRB_TYPE_MASK       0x3f
-#define TRB_TYPE(t)         (((t).control >> TRB_TYPE_SHIFT) & TRB_TYPE_MASK)
-
-#define TRB_EV_ED           (1<<2)
-
-#define TRB_TR_ENT          (1<<1)
-#define TRB_TR_ISP          (1<<2)
-#define TRB_TR_NS           (1<<3)
-#define TRB_TR_CH           (1<<4)
-#define TRB_TR_IOC          (1<<5)
-#define TRB_TR_IDT          (1<<6)
-#define TRB_TR_TBC_SHIFT        7
-#define TRB_TR_TBC_MASK     0x3
-#define TRB_TR_BEI          (1<<9)
-#define TRB_TR_TLBPC_SHIFT      16
-#define TRB_TR_TLBPC_MASK   0xf
-#define TRB_TR_FRAMEID_SHIFT    20
-#define TRB_TR_FRAMEID_MASK 0x7ff
-#define TRB_TR_SIA          (1<<31)
-
-#define TRB_TR_DIR          (1<<16)
-
-#define TRB_CR_SLOTID_SHIFT     24
-#define TRB_CR_SLOTID_MASK  0xff
-#define TRB_CR_EPID_SHIFT       16
-#define TRB_CR_EPID_MASK    0x1f
-
-#define TRB_CR_BSR          (1<<9)
-#define TRB_CR_DC           (1<<9)
-
-#define TRB_LK_TC           (1<<1)
-
-#define TRB_INTR_SHIFT          22
-#define TRB_INTR_MASK       0x3ff
-#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) & TRB_INTR_MASK)
-
-#define EP_TYPE_MASK        0x7
-#define EP_TYPE_SHIFT           3
-
-#define EP_STATE_MASK       0x7
-#define EP_DISABLED         (0<<0)
-#define EP_RUNNING          (1<<0)
-#define EP_HALTED           (2<<0)
-#define EP_STOPPED          (3<<0)
-#define EP_ERROR            (4<<0)
-
-#define SLOT_STATE_MASK     0x1f
-#define SLOT_STATE_SHIFT        27
-#define SLOT_STATE(s)       (((s)>>SLOT_STATE_SHIFT)&SLOT_STATE_MASK)
-#define SLOT_ENABLED        0
-#define SLOT_DEFAULT        1
-#define SLOT_ADDRESSED      2
-#define SLOT_CONFIGURED     3
-
-#define SLOT_CONTEXT_ENTRIES_MASK 0x1f
-#define SLOT_CONTEXT_ENTRIES_SHIFT 27
-
 #define get_field(data, field)                  \
     (((data) >> field##_SHIFT) & field##_MASK)
 
@@ -223,17 +75,6 @@ enum {
         *data = val_;                                           \
     } while (0)
 
-typedef enum EPType {
-    ET_INVALID = 0,
-    ET_ISO_OUT,
-    ET_BULK_OUT,
-    ET_INTR_OUT,
-    ET_CONTROL,
-    ET_ISO_IN,
-    ET_BULK_IN,
-    ET_INTR_IN,
-} EPType;
-
 typedef struct XHCITransfer {
     XHCIEPContext *epctx;
     USBPacket packet;
@@ -2736,56 +2577,55 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* HCIVERSION, CAPLENGTH */
+    case XHCI_HCCAP_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
         ret = 0x01000000 | LEN_CAP;
         break;
-    case 0x04: /* HCSPARAMS 1 */
+    case XHCI_HCCAP_HCSPARAMS1:
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
             | (xhci->numintrs<<8) | xhci->numslots;
         break;
-    case 0x08: /* HCSPARAMS 2 */
+    case XHCI_HCCAP_HCSPARAMS2:
         ret = 0x0000000f;
         break;
-    case 0x0c: /* HCSPARAMS 3 */
+    case XHCI_HCCAP_HCSPARAMS3:
         ret = 0x00000000;
         break;
-    case 0x10: /* HCCPARAMS */
-        if (sizeof(dma_addr_t) == 4) {
-            ret = 0x00080000 | (xhci->max_pstreams_mask << 12);
-        } else {
-            ret = 0x00080001 | (xhci->max_pstreams_mask << 12);
+    case XHCI_HCCAP_HCCPARAMS1:
+        ret = (XHCI_HCCAP_EXTCAP_START >> 2) | (xhci->max_pstreams_mask << 12);
+        if (sizeof(dma_addr_t) == 8) {
+            ret |= 0x00000001; /* AC64 */
         }
         break;
-    case 0x14: /* DBOFF */
+    case XHCI_HCCAP_DBOFF:
         ret = OFF_DOORBELL;
         break;
-    case 0x18: /* RTSOFF */
+    case XHCI_HCCAP_RTSOFF:
         ret = OFF_RUNTIME;
         break;
 
     /* extended capabilities */
-    case 0x20: /* Supported Protocol:00 */
+    case XHCI_HCCAP_EXTCAP_START + 0x00: /* Supported Protocol:00 */
         ret = 0x02000402; /* USB 2.0 */
         break;
-    case 0x24: /* Supported Protocol:04 */
+    case XHCI_HCCAP_EXTCAP_START + 0x04: /* Supported Protocol:04 */
         ret = 0x20425355; /* "USB " */
         break;
-    case 0x28: /* Supported Protocol:08 */
+    case XHCI_HCCAP_EXTCAP_START + 0x08: /* Supported Protocol:08 */
         ret = (xhci->numports_2 << 8) | (xhci->numports_3 + 1);
         break;
-    case 0x2c: /* Supported Protocol:0c */
+    case XHCI_HCCAP_EXTCAP_START + 0x0c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
         break;
-    case 0x30: /* Supported Protocol:00 */
+    case XHCI_HCCAP_EXTCAP_START + 0x10: /* Supported Protocol:00 */
         ret = 0x03000002; /* USB 3.0 */
         break;
-    case 0x34: /* Supported Protocol:04 */
+    case XHCI_HCCAP_EXTCAP_START + 0x14: /* Supported Protocol:04 */
         ret = 0x20425355; /* "USB " */
         break;
-    case 0x38: /* Supported Protocol:08 */
+    case XHCI_HCCAP_EXTCAP_START + 0x18: /* Supported Protocol:08 */
         ret = (xhci->numports_3 << 8) | 1;
         break;
-    case 0x3c: /* Supported Protocol:0c */
+    case XHCI_HCCAP_EXTCAP_START + 0x1c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
         break;
     default:
@@ -2803,14 +2643,13 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* PORTSC */
+    case XHCI_PORT_PORTSC:
         ret = port->portsc;
         break;
-    case 0x04: /* PORTPMSC */
-    case 0x08: /* PORTLI */
+    case XHCI_PORT_PORTPMSC:
+    case XHCI_PORT_PORTLI:
         ret = 0;
         break;
-    case 0x0c: /* reserved */
     default:
         trace_usb_xhci_unimplemented("port read", reg);
         ret = 0;
@@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwaddr reg,
     trace_usb_xhci_port_write(port->portnr, reg, val);
 
     switch (reg) {
-    case 0x00: /* PORTSC */
+    case XHCI_PORT_PORTSC:
         /* write-1-to-start bits */
         if (val & PORTSC_WPR) {
             xhci_port_reset(port, true);
@@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwaddr reg,
             xhci_port_notify(port, notify);
         }
         break;
-    case 0x04: /* PORTPMSC */
-    case 0x08: /* PORTLI */
     default:
         trace_usb_xhci_unimplemented("port write", reg);
     }
@@ -2893,31 +2730,31 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* USBCMD */
+    case XHCI_OPER_USBCMD:
         ret = xhci->usbcmd;
         break;
-    case 0x04: /* USBSTS */
+    case XHCI_OPER_USBSTS:
         ret = xhci->usbsts;
         break;
-    case 0x08: /* PAGESIZE */
+    case XHCI_OPER_PAGESIZE:
         ret = 1; /* 4KiB */
         break;
-    case 0x14: /* DNCTRL */
+    case XHCI_OPER_DNCTRL:
         ret = xhci->dnctrl;
         break;
-    case 0x18: /* CRCR low */
+    case XHCI_OPER_CRCR_LO:
         ret = xhci->crcr_low & ~0xe;
         break;
-    case 0x1c: /* CRCR high */
+    case XHCI_OPER_CRCR_HI:
         ret = xhci->crcr_high;
         break;
-    case 0x30: /* DCBAAP low */
+    case XHCI_OPER_DCBAAP_LO:
         ret = xhci->dcbaap_low;
         break;
-    case 0x34: /* DCBAAP high */
+    case XHCI_OPER_DCBAAP_HI:
         ret = xhci->dcbaap_high;
         break;
-    case 0x38: /* CONFIG */
+    case XHCI_OPER_CONFIG:
         ret = xhci->config;
         break;
     default:
@@ -2937,7 +2774,7 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
     trace_usb_xhci_oper_write(reg, val);
 
     switch (reg) {
-    case 0x00: /* USBCMD */
+    case XHCI_OPER_USBCMD:
         if ((val & USBCMD_RS) && !(xhci->usbcmd & USBCMD_RS)) {
             xhci_run(xhci);
         } else if (!(val & USBCMD_RS) && (xhci->usbcmd & USBCMD_RS)) {
@@ -2959,19 +2796,19 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
         xhci_intr_update(xhci, 0);
         break;
 
-    case 0x04: /* USBSTS */
+    case XHCI_OPER_USBSTS:
         /* these bits are write-1-to-clear */
         xhci->usbsts &= ~(val & (USBSTS_HSE|USBSTS_EINT|USBSTS_PCD|USBSTS_SRE));
         xhci_intr_update(xhci, 0);
         break;
 
-    case 0x14: /* DNCTRL */
+    case XHCI_OPER_DNCTRL:
         xhci->dnctrl = val & 0xffff;
         break;
-    case 0x18: /* CRCR low */
+    case XHCI_OPER_CRCR_LO:
         xhci->crcr_low = (val & 0xffffffcf) | (xhci->crcr_low & CRCR_CRR);
         break;
-    case 0x1c: /* CRCR high */
+    case XHCI_OPER_CRCR_HI:
         xhci->crcr_high = val;
         if (xhci->crcr_low & (CRCR_CA|CRCR_CS) && (xhci->crcr_low & CRCR_CRR)) {
             XHCIEvent event = {ER_COMMAND_COMPLETE, CC_COMMAND_RING_STOPPED};
@@ -2984,13 +2821,13 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
         }
         xhci->crcr_low &= ~(CRCR_CA | CRCR_CS);
         break;
-    case 0x30: /* DCBAAP low */
+    case XHCI_OPER_DCBAAP_LO:
         xhci->dcbaap_low = val & 0xffffffc0;
         break;
-    case 0x34: /* DCBAAP high */
+    case XHCI_OPER_DCBAAP_HI:
         xhci->dcbaap_high = val;
         break;
-    case 0x38: /* CONFIG */
+    case XHCI_OPER_CONFIG:
         xhci->config = val & 0xff;
         break;
     default:
@@ -3004,9 +2841,9 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     uint32_t ret = 0;
 
-    if (reg < 0x20) {
+    if (reg < XHCI_OPER_IR0) {
         switch (reg) {
-        case 0x00: /* MFINDEX */
+        case XHCI_OPER_MFINDEX:
             ret = xhci_mfindex_get(xhci) & 0x3fff;
             break;
         default:
@@ -3014,28 +2851,28 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
             break;
         }
     } else {
-        int v = (reg - 0x20) / 0x20;
+        int v = (reg - XHCI_OPER_IR0) / XHCI_OPER_IR_SZ;
         XHCIInterrupter *intr = &xhci->intr[v];
-        switch (reg & 0x1f) {
-        case 0x00: /* IMAN */
+        switch (reg & (XHCI_OPER_IR_SZ - 1)) {
+        case XHCI_INTR_IMAN:
             ret = intr->iman;
             break;
-        case 0x04: /* IMOD */
+        case XHCI_INTR_IMOD:
             ret = intr->imod;
             break;
-        case 0x08: /* ERSTSZ */
+        case XHCI_INTR_ERSTSZ:
             ret = intr->erstsz;
             break;
-        case 0x10: /* ERSTBA low */
+        case XHCI_INTR_ERSTBA_LO:
             ret = intr->erstba_low;
             break;
-        case 0x14: /* ERSTBA high */
+        case XHCI_INTR_ERSTBA_HI:
             ret = intr->erstba_high;
             break;
-        case 0x18: /* ERDP low */
+        case XHCI_INTR_ERDP_LO:
             ret = intr->erdp_low;
             break;
-        case 0x1c: /* ERDP high */
+        case XHCI_INTR_ERDP_HI:
             ret = intr->erdp_high;
             break;
         }
@@ -3054,15 +2891,15 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
 
     trace_usb_xhci_runtime_write(reg, val);
 
-    if (reg < 0x20) {
+    if (reg < XHCI_OPER_IR0) {
         trace_usb_xhci_unimplemented("runtime write", reg);
         return;
     }
-    v = (reg - 0x20) / 0x20;
+    v = (reg - XHCI_OPER_IR0) / XHCI_OPER_IR_SZ;
     intr = &xhci->intr[v];
 
-    switch (reg & 0x1f) {
-    case 0x00: /* IMAN */
+    switch (reg & (XHCI_OPER_IR_SZ - 1)) {
+    case XHCI_INTR_IMAN:
         if (val & IMAN_IP) {
             intr->iman &= ~IMAN_IP;
         }
@@ -3070,13 +2907,13 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         intr->iman |= val & IMAN_IE;
         xhci_intr_update(xhci, v);
         break;
-    case 0x04: /* IMOD */
+    case XHCI_INTR_IMOD:
         intr->imod = val;
         break;
-    case 0x08: /* ERSTSZ */
+    case XHCI_INTR_ERSTSZ:
         intr->erstsz = val & 0xffff;
         break;
-    case 0x10: /* ERSTBA low */
+    case XHCI_INTR_ERSTBA_LO:
         if (xhci->nec_quirks) {
             /* NEC driver bug: it doesn't align this to 64 bytes */
             intr->erstba_low = val & 0xfffffff0;
@@ -3084,11 +2921,11 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             intr->erstba_low = val & 0xffffffc0;
         }
         break;
-    case 0x14: /* ERSTBA high */
+    case XHCI_INTR_ERSTBA_HI:
         intr->erstba_high = val;
         xhci_er_reset(xhci, v);
         break;
-    case 0x18: /* ERDP low */
+    case XHCI_INTR_ERDP_LO:
         if (val & ERDP_EHB) {
             intr->erdp_low &= ~ERDP_EHB;
         }
@@ -3103,7 +2940,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             }
         }
         break;
-    case 0x1c: /* ERDP high */
+    case XHCI_INTR_ERDP_HI:
         intr->erdp_high = val;
         break;
     default:
-- 
2.45.2


