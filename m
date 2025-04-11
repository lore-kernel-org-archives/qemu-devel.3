Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989B2C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39I9-00028R-2T; Fri, 11 Apr 2025 03:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39I7-00027a-1v
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39I3-0003qV-0G
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1317786b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358345; x=1744963145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXkC4Hvzc9PeqtT8O4ys++/d9+qIRbhGt3tOfu/KF7Y=;
 b=FnUp1CZm0y0Y0kyTjEtK5Cp22D4JoPj09XL6EI7Iqh8L3pq8bqFp1r1xaZInMxr2ZH
 Tt2OC7es4pBqK7n+oFK/7r5opRebEmyoTcRxHapAC8bpaC4GxNfxoz8vlZCRMfbixwne
 bqMuGsqDAZOjXKdi0Fsp6OWzcAa4UJD339AJzFpPKKdQwFegpms3gUj3LG0yJT30DEqd
 B8ROpkt3l1V8217r4qsYBN3t1Vr8yXaplp1i3lNpOAEY1LPNNYhG24gsBGOTgfE5HH8V
 hJpj5nnc1BHd19TbaL89ns3hFlSwQYVMYs2JpY0xVYeeGJAmGMgiF6k5YX+2/uCIFzSQ
 8FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358345; x=1744963145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXkC4Hvzc9PeqtT8O4ys++/d9+qIRbhGt3tOfu/KF7Y=;
 b=bU5oZcaEFMuaXHQTtOoswuf8lF7uDLE9fAk8jrEOVU93FQc0cQaLCaXbH61unj7Jnr
 2Lrrr/d0vkaOPJ3cFp1T7m6FT1kLtbAW+fKZowHSpTYl54FkaoQBzXtCREkOow5XrUB/
 xtkYUneWjx3hllD8zBIZbjqosfjvolS54uuV+KB1wllAhQRltU07Zk/8yN7D3xh16PFh
 7fjImS0/gtLGmzEWtjXU1HFp8uPloASCzlnx3WjrUJ9msOjMtcuKmlwniLfiEyGoJ/qh
 vnkmnK56o0qmeNSc9OYJJfaUbhhM4fZtJZ5BiWpwyInkRSf25Lj3KZKpqHkZnANdySxF
 J18A==
X-Gm-Message-State: AOJu0Yxiz4/rchN1Qoihq6wYsK31OZPRu8GTERLvCVYalMEGNN8FUjyt
 2jnQQW0JHjj99Fw6fBXlVEKauu09K5FOnau1n1C3PswgXDdTuGg+wGCDrA==
X-Gm-Gg: ASbGncvbf8iCxF3vP+eVNE3eWA0u0WDP/u5V3BMjJp071XdJUlQUml05sHB2MK9jCmC
 qzS8Cpk9UaawTLH39kqUJz/t3GqXuzVIPh3WH2yKbPuZAlMgoswRFl/3vY3zE1GJiKsuITwUnc5
 siQ0ugnfTqyIaET9ddyTNAvfxFGuKd4SgrHqRuOQTw8gDs1zPBcfh3Fg3kGbBdgAk27TQP9bdc8
 L6M4DX7NspLN6EhZyuzaJ2iAl8VzO2P8JtbRbcQA+92kxMKvdfQZPTRV047LBVq10uoQAZF+Tlh
 DhfVQKx3q9s/aaZ8Fzh/SesiIRJhJCt+orBTVN1YyBq1
X-Google-Smtp-Source: AGHT+IHy7wfDJzInE+3jmsbf3DbqxkmRjrGf6fVht120D80Ra7lEuLNDmZPZIes7KFhKarprgVVXZg==
X-Received: by 2002:a05:6a00:1897:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-73bd11e1207mr2538340b3a.10.1744358344870; 
 Fri, 11 Apr 2025 00:59:04 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/8] hw/usb/xhci: Move HCD constants to a header and add
 register constants
Date: Fri, 11 Apr 2025 17:58:43 +1000
Message-ID: <20250411075851.206995-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
 hw/usb/hcd-xhci.h | 214 ++++++++++++++++++++++
 hw/usb/hcd-xhci.c | 450 +++++++++++++++-------------------------------
 2 files changed, 360 insertions(+), 304 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 9c3974f1489..ee364efd0ab 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -115,6 +115,220 @@ typedef enum TRBCCode {
     CC_SPLIT_TRANSACTION_ERROR
 } TRBCCode;
 
+/* Register definitions */
+#define XHCI_HCCAP_REG_CAPLENGTH            0x00
+#define XHCI_HCCAP_REG_HCIVERSION           0x02
+#define XHCI_HCCAP_REG_HCSPARAMS1           0x04
+#define XHCI_HCCAP_REG_HCSPARAMS2           0x08
+#define XHCI_HCCAP_REG_HCSPARAMS3           0x0C
+#define XHCI_HCCAP_REG_HCCPARAMS1           0x10
+#define   XHCI_HCCPARAMS1_AC64              0x00000001
+#define   XHCI_HCCPARAMS1_XECP_SHIFT        16
+#define   XHCI_HCCPARAMS1_MAXPSASIZE_SHIFT  12
+#define XHCI_HCCAP_REG_DBOFF                0x14
+#define XHCI_HCCAP_REG_RTSOFF               0x18
+#define XHCI_HCCAP_REG_HCCPARAMS2           0x1C
+#define XHCI_HCCAP_EXTCAP_START             0x20 /* SW-defined */
+
+#define XHCI_PORT_PR_SZ                     0x10
+#define XHCI_PORT_REG_PORTSC                0x00
+#define   XHCI_PORTSC_CCS                   (1 << 0)
+#define   XHCI_PORTSC_PED                   (1 << 1)
+#define   XHCI_PORTSC_OCA                   (1 << 3)
+#define   XHCI_PORTSC_PR                    (1 << 4)
+#define   XHCI_PORTSC_PLS_SHIFT             5
+#define   XHCI_PORTSC_PLS_MASK              0xf
+#define   XHCI_PORTSC_PP                    (1 << 9)
+#define   XHCI_PORTSC_SPEED_SHIFT           10
+#define   XHCI_PORTSC_SPEED_MASK            0xf
+#define   XHCI_PORTSC_SPEED_FULL            (1 << 10)
+#define   XHCI_PORTSC_SPEED_LOW             (2 << 10)
+#define   XHCI_PORTSC_SPEED_HIGH            (3 << 10)
+#define   XHCI_PORTSC_SPEED_SUPER           (4 << 10)
+#define   XHCI_PORTSC_PIC_SHIFT             14
+#define   XHCI_PORTSC_PIC_MASK              0x3
+#define   XHCI_PORTSC_LWS                   (1 << 16)
+#define   XHCI_PORTSC_CSC                   (1 << 17)
+#define   XHCI_PORTSC_PEC                   (1 << 18)
+#define   XHCI_PORTSC_WRC                   (1 << 19)
+#define   XHCI_PORTSC_OCC                   (1 << 20)
+#define   XHCI_PORTSC_PRC                   (1 << 21)
+#define   XHCI_PORTSC_PLC                   (1 << 22)
+#define   XHCI_PORTSC_CEC                   (1 << 23)
+#define   XHCI_PORTSC_CAS                   (1 << 24)
+#define   XHCI_PORTSC_WCE                   (1 << 25)
+#define   XHCI_PORTSC_WDE                   (1 << 26)
+#define   XHCI_PORTSC_WOE                   (1 << 27)
+#define   XHCI_PORTSC_DR                    (1 << 30)
+#define   XHCI_PORTSC_WPR                   (1 << 31)
+/* read/write bits */
+#define   XHCI_PORTSC_RW_MASK               (XHCI_PORTSC_PP |    \
+                                             XHCI_PORTSC_WCE |   \
+                                             XHCI_PORTSC_WDE |   \
+                                             XHCI_PORTSC_WOE)
+/* write-1-to-clear bits*/
+#define   XHCI_PORTSC_W1C_MASK              (XHCI_PORTSC_CSC |   \
+                                             XHCI_PORTSC_PEC |   \
+                                             XHCI_PORTSC_WRC |   \
+                                             XHCI_PORTSC_OCC |   \
+                                             XHCI_PORTSC_PRC |   \
+                                             XHCI_PORTSC_PLC |   \
+                                             XHCI_PORTSC_CEC)
+#define XHCI_PORT_REG_PORTPMSC              0x04
+#define XHCI_PORT_REG_PORTLI                0x08
+#define XHCI_PORT_REG_PORTHLPMC             0x0C
+
+#define XHCI_OPER_REG_USBCMD                0x00
+#define   XHCI_USBCMD_RS                    (1 << 0)
+#define   XHCI_USBCMD_HCRST                 (1 << 1)
+#define   XHCI_USBCMD_INTE                  (1 << 2)
+#define   XHCI_USBCMD_HSEE                  (1 << 3)
+#define   XHCI_USBCMD_LHCRST                (1 << 7)
+#define   XHCI_USBCMD_CSS                   (1 << 8)
+#define   XHCI_USBCMD_CRS                   (1 << 9)
+#define   XHCI_USBCMD_EWE                   (1 << 10)
+#define   XHCI_USBCMD_EU3S                  (1 << 11)
+#define XHCI_OPER_REG_USBSTS                0x04
+#define   XHCI_USBSTS_HCH                   (1 << 0)
+#define   XHCI_USBSTS_HSE                   (1 << 2)
+#define   XHCI_USBSTS_EINT                  (1 << 3)
+#define   XHCI_USBSTS_PCD                   (1 << 4)
+#define   XHCI_USBSTS_SSS                   (1 << 8)
+#define   XHCI_USBSTS_RSS                   (1 << 9)
+#define   XHCI_USBSTS_SRE                   (1 << 10)
+#define   XHCI_USBSTS_CNR                   (1 << 11)
+#define   XHCI_USBSTS_HCE                   (1 << 12)
+/* these bits are write-1-to-clear */
+#define   XHCI_USBSTS_W1C_MASK              (XHCI_USBSTS_HSE |    \
+                                             XHCI_USBSTS_EINT |   \
+                                             XHCI_USBSTS_PCD |    \
+                                             XHCI_USBSTS_SRE)
+#define XHCI_OPER_REG_PAGESIZE              0x08
+#define XHCI_OPER_REG_DNCTRL                0x14
+#define XHCI_OPER_REG_CRCR_LO               0x18
+#define   XHCI_CRCR_RCS                     (1 << 0)
+#define   XHCI_CRCR_CS                      (1 << 1)
+#define   XHCI_CRCR_CA                      (1 << 2)
+#define   XHCI_CRCR_CRR                     (1 << 3)
+#define XHCI_OPER_REG_CRCR_HI               0x1C
+#define XHCI_OPER_REG_DCBAAP_LO             0x30
+#define XHCI_OPER_REG_DCBAAP_HI             0x34
+#define XHCI_OPER_REG_CONFIG                0x38
+
+#define XHCI_DBELL_DB_SZ                    0x4
+
+#define XHCI_INTR_REG_MFINDEX               0x00
+#define XHCI_INTR_REG_IR0                   0x20
+#define XHCI_INTR_IR_SZ                     0x20
+
+#define XHCI_INTR_REG_IMAN                  0x00
+#define   XHCI_IMAN_IP                      (1 << 0)
+#define   XHCI_IMAN_IE                      (1 << 1)
+#define XHCI_INTR_REG_IMOD                  0x04
+#define XHCI_INTR_REG_ERSTSZ                0x08
+#define XHCI_INTR_REG_ERSTBA_LO             0x10
+#define XHCI_INTR_REG_ERSTBA_HI             0x14
+#define XHCI_INTR_REG_ERDP_LO               0x18
+#define   XHCI_ERDP_EHB                     (1 << 3)
+#define XHCI_INTR_REG_ERDP_HI               0x1C
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
+#define TRB_TYPE_SHIFT      10
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
+#define TRB_TR_TBC_SHIFT    7
+#define TRB_TR_TBC_MASK     0x3
+#define TRB_TR_BEI          (1 << 9)
+#define TRB_TR_TLBPC_SHIFT  16
+#define TRB_TR_TLBPC_MASK   0xf
+#define TRB_TR_FRAMEID_SHIFT    20
+#define TRB_TR_FRAMEID_MASK 0x7ff
+#define TRB_TR_SIA          (1 << 31)
+
+#define TRB_TR_DIR          (1 << 16)
+
+#define TRB_CR_SLOTID_SHIFT 24
+#define TRB_CR_SLOTID_MASK  0xff
+#define TRB_CR_EPID_SHIFT   16
+#define TRB_CR_EPID_MASK    0x1f
+
+#define TRB_CR_BSR          (1 << 9)
+#define TRB_CR_DC           (1 << 9)
+
+#define TRB_LK_TC           (1 << 1)
+
+#define TRB_INTR_SHIFT      22
+#define TRB_INTR_MASK       0x3ff
+#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) & TRB_INTR_MASK)
+
+#define EP_TYPE_MASK        0x7
+#define EP_TYPE_SHIFT       3
+
+#define EP_STATE_MASK       0x7
+#define EP_DISABLED         (0 << 0)
+#define EP_RUNNING          (1 << 0)
+#define EP_HALTED           (2 << 0)
+#define EP_STOPPED          (3 << 0)
+#define EP_ERROR            (4 << 0)
+
+#define SLOT_STATE_MASK     0x1f
+#define SLOT_STATE_SHIFT    27
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
index 64c3a23b9b7..b57db309b8d 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -47,8 +47,8 @@
 #define TRANSFER_LIMIT  256
 
 #define LEN_CAP         0x40
-#define LEN_OPER        (0x400 + 0x10 * XHCI_MAXPORTS)
-#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * 0x20)
+#define LEN_OPER        (0x400 + XHCI_PORT_PR_SZ * XHCI_MAXPORTS)
+#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * XHCI_INTR_IR_SZ)
 #define LEN_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)
 
 #define OFF_OPER        LEN_CAP
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
@@ -440,7 +281,7 @@ static uint64_t xhci_mfindex_get(XHCIState *xhci)
 
 static void xhci_mfwrap_update(XHCIState *xhci)
 {
-    const uint32_t bits = USBCMD_RS | USBCMD_EWE;
+    const uint32_t bits = XHCI_USBCMD_RS | XHCI_USBCMD_EWE;
     uint32_t mfindex, left;
     int64_t now;
 
@@ -465,7 +306,7 @@ static void xhci_mfwrap_timer(void *opaque)
 
 static void xhci_die(XHCIState *xhci)
 {
-    xhci->usbsts |= USBSTS_HCE;
+    xhci->usbsts |= XHCI_USBSTS_HCE;
     DPRINTF("xhci: asserted controller error\n");
 }
 
@@ -557,51 +398,51 @@ static void xhci_intr_update(XHCIState *xhci, int v)
     int level = 0;
 
     if (v == 0) {
-        if (xhci->intr[0].iman & IMAN_IP &&
-            xhci->intr[0].iman & IMAN_IE &&
-            xhci->usbcmd & USBCMD_INTE) {
+        if (xhci->intr[0].iman & XHCI_IMAN_IP &&
+            xhci->intr[0].iman & XHCI_IMAN_IE &&
+            xhci->usbcmd & XHCI_USBCMD_INTE) {
             level = 1;
         }
         if (xhci->intr_raise) {
             if (xhci->intr_raise(xhci, 0, level)) {
-                xhci->intr[0].iman &= ~IMAN_IP;
+                xhci->intr[0].iman &= ~XHCI_IMAN_IP;
             }
         }
     }
     if (xhci->intr_update) {
         xhci->intr_update(xhci, v,
-                     xhci->intr[v].iman & IMAN_IE);
+                     xhci->intr[v].iman & XHCI_IMAN_IE);
     }
 }
 
 static void xhci_intr_raise(XHCIState *xhci, int v)
 {
-    bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
+    bool pending = (xhci->intr[v].erdp_low & XHCI_ERDP_EHB);
 
-    xhci->intr[v].erdp_low |= ERDP_EHB;
-    xhci->intr[v].iman |= IMAN_IP;
-    xhci->usbsts |= USBSTS_EINT;
+    xhci->intr[v].erdp_low |= XHCI_ERDP_EHB;
+    xhci->intr[v].iman |= XHCI_IMAN_IP;
+    xhci->usbsts |= XHCI_USBSTS_EINT;
 
     if (pending) {
         return;
     }
-    if (!(xhci->intr[v].iman & IMAN_IE)) {
+    if (!(xhci->intr[v].iman & XHCI_IMAN_IE)) {
         return;
     }
 
-    if (!(xhci->usbcmd & USBCMD_INTE)) {
+    if (!(xhci->usbcmd & XHCI_USBCMD_INTE)) {
         return;
     }
     if (xhci->intr_raise) {
         if (xhci->intr_raise(xhci, v, true)) {
-            xhci->intr[v].iman &= ~IMAN_IP;
+            xhci->intr[v].iman &= ~XHCI_IMAN_IP;
         }
     }
 }
 
 static inline int xhci_running(XHCIState *xhci)
 {
-    return !(xhci->usbsts & USBSTS_HCH);
+    return !(xhci->usbsts & XHCI_USBSTS_HCH);
 }
 
 static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
@@ -846,15 +687,15 @@ static void xhci_er_reset(XHCIState *xhci, int v)
 static void xhci_run(XHCIState *xhci)
 {
     trace_usb_xhci_run();
-    xhci->usbsts &= ~USBSTS_HCH;
+    xhci->usbsts &= ~XHCI_USBSTS_HCH;
     xhci->mfindex_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
 
 static void xhci_stop(XHCIState *xhci)
 {
     trace_usb_xhci_stop();
-    xhci->usbsts |= USBSTS_HCH;
-    xhci->crcr_low &= ~CRCR_CRR;
+    xhci->usbsts |= XHCI_USBSTS_HCH;
+    xhci->crcr_low &= ~XHCI_CRCR_CRR;
 }
 
 static XHCIStreamContext *xhci_alloc_stream_contexts(unsigned count,
@@ -2480,7 +2321,7 @@ static void xhci_process_commands(XHCIState *xhci)
         return;
     }
 
-    xhci->crcr_low |= CRCR_CRR;
+    xhci->crcr_low |= XHCI_CRCR_CRR;
 
     while ((type = xhci_ring_fetch(xhci, &xhci->cmd_ring, &trb, &addr))) {
         event.ptr = addr;
@@ -2632,32 +2473,32 @@ static void xhci_port_update(XHCIPort *port, int is_detach)
     uint32_t pls = PLS_RX_DETECT;
 
     assert(port);
-    port->portsc = PORTSC_PP;
+    port->portsc = XHCI_PORTSC_PP;
     if (!is_detach && xhci_port_have_device(port)) {
-        port->portsc |= PORTSC_CCS;
+        port->portsc |= XHCI_PORTSC_CCS;
         switch (port->uport->dev->speed) {
         case USB_SPEED_LOW:
-            port->portsc |= PORTSC_SPEED_LOW;
+            port->portsc |= XHCI_PORTSC_SPEED_LOW;
             pls = PLS_POLLING;
             break;
         case USB_SPEED_FULL:
-            port->portsc |= PORTSC_SPEED_FULL;
+            port->portsc |= XHCI_PORTSC_SPEED_FULL;
             pls = PLS_POLLING;
             break;
         case USB_SPEED_HIGH:
-            port->portsc |= PORTSC_SPEED_HIGH;
+            port->portsc |= XHCI_PORTSC_SPEED_HIGH;
             pls = PLS_POLLING;
             break;
         case USB_SPEED_SUPER:
-            port->portsc |= PORTSC_SPEED_SUPER;
-            port->portsc |= PORTSC_PED;
+            port->portsc |= XHCI_PORTSC_SPEED_SUPER;
+            port->portsc |= XHCI_PORTSC_PED;
             pls = PLS_U0;
             break;
         }
     }
-    set_field(&port->portsc, pls, PORTSC_PLS);
+    set_field(&port->portsc, pls, XHCI_PORTSC_PLS);
     trace_usb_xhci_port_link(port->portnr, pls);
-    xhci_port_notify(port, PORTSC_CSC);
+    xhci_port_notify(port, XHCI_PORTSC_CSC);
 }
 
 static void xhci_port_reset(XHCIPort *port, bool warm_reset)
@@ -2673,20 +2514,20 @@ static void xhci_port_reset(XHCIPort *port, bool warm_reset)
     switch (port->uport->dev->speed) {
     case USB_SPEED_SUPER:
         if (warm_reset) {
-            port->portsc |= PORTSC_WRC;
+            port->portsc |= XHCI_PORTSC_WRC;
         }
         /* fall through */
     case USB_SPEED_LOW:
     case USB_SPEED_FULL:
     case USB_SPEED_HIGH:
-        set_field(&port->portsc, PLS_U0, PORTSC_PLS);
+        set_field(&port->portsc, PLS_U0, XHCI_PORTSC_PLS);
         trace_usb_xhci_port_link(port->portnr, PLS_U0);
-        port->portsc |= PORTSC_PED;
+        port->portsc |= XHCI_PORTSC_PED;
         break;
     }
 
-    port->portsc &= ~PORTSC_PR;
-    xhci_port_notify(port, PORTSC_PRC);
+    port->portsc &= ~XHCI_PORTSC_PR;
+    xhci_port_notify(port, XHCI_PORTSC_PRC);
 }
 
 static void xhci_reset(DeviceState *dev)
@@ -2695,12 +2536,12 @@ static void xhci_reset(DeviceState *dev)
     int i;
 
     trace_usb_xhci_reset();
-    if (!(xhci->usbsts & USBSTS_HCH)) {
+    if (!(xhci->usbsts & XHCI_USBSTS_HCH)) {
         DPRINTF("xhci: reset while running!\n");
     }
 
     xhci->usbcmd = 0;
-    xhci->usbsts = USBSTS_HCH;
+    xhci->usbsts = XHCI_USBSTS_HCH;
     xhci->dnctrl = 0;
     xhci->crcr_low = 0;
     xhci->crcr_high = 0;
@@ -2741,56 +2582,56 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* HCIVERSION, CAPLENGTH */
+    case XHCI_HCCAP_REG_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
         ret = 0x01000000 | LEN_CAP;
         break;
-    case 0x04: /* HCSPARAMS 1 */
+    case XHCI_HCCAP_REG_HCSPARAMS1:
         ret = ((xhci->numports_2+xhci->numports_3)<<24)
             | (xhci->numintrs<<8) | xhci->numslots;
         break;
-    case 0x08: /* HCSPARAMS 2 */
+    case XHCI_HCCAP_REG_HCSPARAMS2:
         ret = 0x0000000f;
         break;
-    case 0x0c: /* HCSPARAMS 3 */
+    case XHCI_HCCAP_REG_HCSPARAMS3:
         ret = 0x00000000;
         break;
-    case 0x10: /* HCCPARAMS */
-        if (sizeof(dma_addr_t) == 4) {
-            ret = 0x00080000 | (xhci->max_pstreams_mask << 12);
-        } else {
-            ret = 0x00080001 | (xhci->max_pstreams_mask << 12);
+    case XHCI_HCCAP_REG_HCCPARAMS1:
+        ret = (XHCI_HCCAP_EXTCAP_START / 4) << XHCI_HCCPARAMS1_XECP_SHIFT;
+        ret |= xhci->max_pstreams_mask << XHCI_HCCPARAMS1_MAXPSASIZE_SHIFT;
+        if (sizeof(dma_addr_t) == 8) {
+            ret |= XHCI_HCCPARAMS1_AC64;
         }
         break;
-    case 0x14: /* DBOFF */
+    case XHCI_HCCAP_REG_DBOFF:
         ret = OFF_DOORBELL;
         break;
-    case 0x18: /* RTSOFF */
+    case XHCI_HCCAP_REG_RTSOFF:
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
@@ -2808,14 +2649,18 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* PORTSC */
+    case XHCI_PORT_REG_PORTSC:
         ret = port->portsc;
         break;
-    case 0x04: /* PORTPMSC */
-    case 0x08: /* PORTLI */
+    case XHCI_PORT_REG_PORTLI:
         ret = 0;
         break;
-    case 0x0c: /* PORTHLPMC */
+    case XHCI_PORT_REG_PORTPMSC:
+        ret = 0;
+        qemu_log_mask(LOG_UNIMP, "%s: read from port register PORTHPMSC",
+                      __func__);
+        break;
+    case XHCI_PORT_REG_PORTHLPMC:
         ret = 0;
         qemu_log_mask(LOG_UNIMP, "%s: read from port register PORTHLPMC",
                       __func__);
@@ -2840,37 +2685,35 @@ static void xhci_port_write(void *ptr, hwaddr reg,
     trace_usb_xhci_port_write(port->portnr, reg, val);
 
     switch (reg) {
-    case 0x00: /* PORTSC */
+    case XHCI_PORT_REG_PORTSC:
         /* write-1-to-start bits */
-        if (val & PORTSC_WPR) {
+        if (val & XHCI_PORTSC_WPR) {
             xhci_port_reset(port, true);
             break;
         }
-        if (val & PORTSC_PR) {
+        if (val & XHCI_PORTSC_PR) {
             xhci_port_reset(port, false);
             break;
         }
 
         portsc = port->portsc;
         notify = 0;
-        /* write-1-to-clear bits*/
-        portsc &= ~(val & (PORTSC_CSC|PORTSC_PEC|PORTSC_WRC|PORTSC_OCC|
-                           PORTSC_PRC|PORTSC_PLC|PORTSC_CEC));
-        if (val & PORTSC_LWS) {
+        portsc &= ~(val & XHCI_PORTSC_W1C_MASK);
+        if (val & XHCI_PORTSC_LWS) {
             /* overwrite PLS only when LWS=1 */
-            uint32_t old_pls = get_field(port->portsc, PORTSC_PLS);
-            uint32_t new_pls = get_field(val, PORTSC_PLS);
+            uint32_t old_pls = get_field(port->portsc, XHCI_PORTSC_PLS);
+            uint32_t new_pls = get_field(val, XHCI_PORTSC_PLS);
             switch (new_pls) {
             case PLS_U0:
                 if (old_pls != PLS_U0) {
-                    set_field(&portsc, new_pls, PORTSC_PLS);
+                    set_field(&portsc, new_pls, XHCI_PORTSC_PLS);
                     trace_usb_xhci_port_link(port->portnr, new_pls);
-                    notify = PORTSC_PLC;
+                    notify = XHCI_PORTSC_PLC;
                 }
                 break;
             case PLS_U3:
                 if (old_pls < PLS_U3) {
-                    set_field(&portsc, new_pls, PORTSC_PLS);
+                    set_field(&portsc, new_pls, XHCI_PORTSC_PLS);
                     trace_usb_xhci_port_link(port->portnr, new_pls);
                 }
                 break;
@@ -2883,22 +2726,21 @@ static void xhci_port_write(void *ptr, hwaddr reg,
                 break;
             }
         }
-        /* read/write bits */
-        portsc &= ~(PORTSC_PP|PORTSC_WCE|PORTSC_WDE|PORTSC_WOE);
-        portsc |= (val & (PORTSC_PP|PORTSC_WCE|PORTSC_WDE|PORTSC_WOE));
+        portsc &= ~XHCI_PORTSC_RW_MASK;
+        portsc |= val & XHCI_PORTSC_RW_MASK;
         port->portsc = portsc;
         if (notify) {
             xhci_port_notify(port, notify);
         }
         break;
-    case 0x04: /* PORTPMSC */
-    case 0x0c: /* PORTHLPMC */
+    case XHCI_PORT_REG_PORTPMSC:
+    case XHCI_PORT_REG_PORTHLPMC:
         qemu_log_mask(LOG_UNIMP,
                       "%s: write 0x%" PRIx64
                       " (%u bytes) to port register at offset 0x%" HWADDR_PRIx,
                       __func__, val, size, reg);
         break;
-    case 0x08: /* PORTLI */
+    case XHCI_PORT_REG_PORTLI:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Write to read-only PORTLI register",
                       __func__);
         break;
@@ -2917,31 +2759,31 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr reg, unsigned size)
     uint32_t ret;
 
     switch (reg) {
-    case 0x00: /* USBCMD */
+    case XHCI_OPER_REG_USBCMD:
         ret = xhci->usbcmd;
         break;
-    case 0x04: /* USBSTS */
+    case XHCI_OPER_REG_USBSTS:
         ret = xhci->usbsts;
         break;
-    case 0x08: /* PAGESIZE */
+    case XHCI_OPER_REG_PAGESIZE:
         ret = 1; /* 4KiB */
         break;
-    case 0x14: /* DNCTRL */
+    case XHCI_OPER_REG_DNCTRL:
         ret = xhci->dnctrl;
         break;
-    case 0x18: /* CRCR low */
+    case XHCI_OPER_REG_CRCR_LO:
         ret = xhci->crcr_low & ~0xe;
         break;
-    case 0x1c: /* CRCR high */
+    case XHCI_OPER_REG_CRCR_HI:
         ret = xhci->crcr_high;
         break;
-    case 0x30: /* DCBAAP low */
+    case XHCI_OPER_REG_DCBAAP_LO:
         ret = xhci->dcbaap_low;
         break;
-    case 0x34: /* DCBAAP high */
+    case XHCI_OPER_REG_DCBAAP_HI:
         ret = xhci->dcbaap_high;
         break;
-    case 0x38: /* CONFIG */
+    case XHCI_OPER_REG_CONFIG:
         ret = xhci->config;
         break;
     default:
@@ -2961,60 +2803,60 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
     trace_usb_xhci_oper_write(reg, val);
 
     switch (reg) {
-    case 0x00: /* USBCMD */
-        if ((val & USBCMD_RS) && !(xhci->usbcmd & USBCMD_RS)) {
+    case XHCI_OPER_REG_USBCMD:
+        if ((val & XHCI_USBCMD_RS) && !(xhci->usbcmd & XHCI_USBCMD_RS)) {
             xhci_run(xhci);
-        } else if (!(val & USBCMD_RS) && (xhci->usbcmd & USBCMD_RS)) {
+        } else if (!(val & XHCI_USBCMD_RS) && (xhci->usbcmd & XHCI_USBCMD_RS)) {
             xhci_stop(xhci);
         }
-        if (val & USBCMD_CSS) {
+        if (val & XHCI_USBCMD_CSS) {
             /* save state */
-            xhci->usbsts &= ~USBSTS_SRE;
+            xhci->usbsts &= ~XHCI_USBSTS_SRE;
         }
-        if (val & USBCMD_CRS) {
+        if (val & XHCI_USBCMD_CRS) {
             /* restore state */
-            xhci->usbsts |= USBSTS_SRE;
+            xhci->usbsts |= XHCI_USBSTS_SRE;
         }
         xhci->usbcmd = val & 0xc0f;
         xhci_mfwrap_update(xhci);
-        if (val & USBCMD_HCRST) {
+        if (val & XHCI_USBCMD_HCRST) {
             xhci_reset(DEVICE(xhci));
         }
         xhci_intr_update(xhci, 0);
         break;
 
-    case 0x04: /* USBSTS */
-        /* these bits are write-1-to-clear */
-        xhci->usbsts &= ~(val & (USBSTS_HSE|USBSTS_EINT|USBSTS_PCD|USBSTS_SRE));
+    case XHCI_OPER_REG_USBSTS:
+        xhci->usbsts &= ~(val & XHCI_USBSTS_W1C_MASK);
         xhci_intr_update(xhci, 0);
         break;
 
-    case 0x14: /* DNCTRL */
+    case XHCI_OPER_REG_DNCTRL:
         xhci->dnctrl = val & 0xffff;
         break;
-    case 0x18: /* CRCR low */
-        xhci->crcr_low = (val & 0xffffffcf) | (xhci->crcr_low & CRCR_CRR);
+    case XHCI_OPER_REG_CRCR_LO:
+        xhci->crcr_low = (val & 0xffffffcf) | (xhci->crcr_low & XHCI_CRCR_CRR);
         break;
-    case 0x1c: /* CRCR high */
+    case XHCI_OPER_REG_CRCR_HI:
         xhci->crcr_high = val;
-        if (xhci->crcr_low & (CRCR_CA|CRCR_CS) && (xhci->crcr_low & CRCR_CRR)) {
+        if (xhci->crcr_low & (XHCI_CRCR_CA | XHCI_CRCR_CS) &&
+           (xhci->crcr_low & XHCI_CRCR_CRR)) {
             XHCIEvent event = {ER_COMMAND_COMPLETE, CC_COMMAND_RING_STOPPED};
-            xhci->crcr_low &= ~CRCR_CRR;
+            xhci->crcr_low &= ~XHCI_CRCR_CRR;
             xhci_event(xhci, &event, 0);
             DPRINTF("xhci: command ring stopped (CRCR=%08x)\n", xhci->crcr_low);
         } else {
             dma_addr_t base = xhci_addr64(xhci->crcr_low & ~0x3f, val);
             xhci_ring_init(xhci, &xhci->cmd_ring, base);
         }
-        xhci->crcr_low &= ~(CRCR_CA | CRCR_CS);
+        xhci->crcr_low &= ~(XHCI_CRCR_CA | XHCI_CRCR_CS);
         break;
-    case 0x30: /* DCBAAP low */
+    case XHCI_OPER_REG_DCBAAP_LO:
         xhci->dcbaap_low = val & 0xffffffc0;
         break;
-    case 0x34: /* DCBAAP high */
+    case XHCI_OPER_REG_DCBAAP_HI:
         xhci->dcbaap_high = val;
         break;
-    case 0x38: /* CONFIG */
+    case XHCI_OPER_REG_CONFIG:
         xhci->config = val & 0xff;
         break;
     default:
@@ -3028,9 +2870,9 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
     XHCIState *xhci = ptr;
     uint32_t ret = 0;
 
-    if (reg < 0x20) {
+    if (reg < XHCI_INTR_REG_IR0) {
         switch (reg) {
-        case 0x00: /* MFINDEX */
+        case XHCI_INTR_REG_MFINDEX:
             ret = xhci_mfindex_get(xhci) & 0x3fff;
             break;
         default:
@@ -3038,28 +2880,28 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr reg,
             break;
         }
     } else {
-        int v = (reg - 0x20) / 0x20;
+        int v = (reg - XHCI_INTR_REG_IR0) / XHCI_INTR_IR_SZ;
         XHCIInterrupter *intr = &xhci->intr[v];
-        switch (reg & 0x1f) {
-        case 0x00: /* IMAN */
+        switch (reg & (XHCI_INTR_IR_SZ - 1)) {
+        case XHCI_INTR_REG_IMAN:
             ret = intr->iman;
             break;
-        case 0x04: /* IMOD */
+        case XHCI_INTR_REG_IMOD:
             ret = intr->imod;
             break;
-        case 0x08: /* ERSTSZ */
+        case XHCI_INTR_REG_ERSTSZ:
             ret = intr->erstsz;
             break;
-        case 0x10: /* ERSTBA low */
+        case XHCI_INTR_REG_ERSTBA_LO:
             ret = intr->erstba_low;
             break;
-        case 0x14: /* ERSTBA high */
+        case XHCI_INTR_REG_ERSTBA_HI:
             ret = intr->erstba_high;
             break;
-        case 0x18: /* ERDP low */
+        case XHCI_INTR_REG_ERDP_LO:
             ret = intr->erdp_low;
             break;
-        case 0x1c: /* ERDP high */
+        case XHCI_INTR_REG_ERDP_HI:
             ret = intr->erdp_high;
             break;
         }
@@ -3078,29 +2920,29 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
 
     trace_usb_xhci_runtime_write(reg, val);
 
-    if (reg < 0x20) {
+    if (reg < XHCI_INTR_REG_IR0) {
         trace_usb_xhci_unimplemented("runtime write", reg);
         return;
     }
-    v = (reg - 0x20) / 0x20;
+    v = (reg - XHCI_INTR_REG_IR0) / XHCI_INTR_IR_SZ;
     intr = &xhci->intr[v];
 
-    switch (reg & 0x1f) {
-    case 0x00: /* IMAN */
-        if (val & IMAN_IP) {
-            intr->iman &= ~IMAN_IP;
+    switch (reg & (XHCI_INTR_IR_SZ - 1)) {
+    case XHCI_INTR_REG_IMAN:
+        if (val & XHCI_IMAN_IP) {
+            intr->iman &= ~XHCI_IMAN_IP;
         }
-        intr->iman &= ~IMAN_IE;
-        intr->iman |= val & IMAN_IE;
+        intr->iman &= ~XHCI_IMAN_IE;
+        intr->iman |= val & XHCI_IMAN_IE;
         xhci_intr_update(xhci, v);
         break;
-    case 0x04: /* IMOD */
+    case XHCI_INTR_REG_IMOD:
         intr->imod = val;
         break;
-    case 0x08: /* ERSTSZ */
+    case XHCI_INTR_REG_ERSTSZ:
         intr->erstsz = val & 0xffff;
         break;
-    case 0x10: /* ERSTBA low */
+    case XHCI_INTR_REG_ERSTBA_LO:
         if (xhci->nec_quirks) {
             /* NEC driver bug: it doesn't align this to 64 bytes */
             intr->erstba_low = val & 0xfffffff0;
@@ -3108,16 +2950,17 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             intr->erstba_low = val & 0xffffffc0;
         }
         break;
-    case 0x14: /* ERSTBA high */
+    case XHCI_INTR_REG_ERSTBA_HI:
         intr->erstba_high = val;
         xhci_er_reset(xhci, v);
         break;
-    case 0x18: /* ERDP low */
-        if (val & ERDP_EHB) {
-            intr->erdp_low &= ~ERDP_EHB;
+    case XHCI_INTR_REG_ERDP_LO:
+        if (val & XHCI_ERDP_EHB) {
+            intr->erdp_low &= ~XHCI_ERDP_EHB;
         }
-        intr->erdp_low = (val & ~ERDP_EHB) | (intr->erdp_low & ERDP_EHB);
-        if (val & ERDP_EHB) {
+        intr->erdp_low = (val & ~XHCI_ERDP_EHB) |
+                         (intr->erdp_low & XHCI_ERDP_EHB);
+        if (val & XHCI_ERDP_EHB) {
             dma_addr_t erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
             unsigned int dp_idx = (erdp - intr->er_start) / TRB_SIZE;
             if (erdp >= intr->er_start &&
@@ -3127,7 +2970,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             }
         }
         break;
-    case 0x1c: /* ERDP high */
+    case XHCI_INTR_REG_ERDP_HI:
         intr->erdp_high = val;
         break;
     default:
@@ -3156,8 +2999,7 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
         return;
     }
 
-    reg >>= 2;
-
+    reg /= XHCI_DBELL_DB_SZ;
     if (reg == 0) {
         if (val == 0) {
             xhci_process_commands(xhci);
@@ -3250,11 +3092,11 @@ static void xhci_wakeup(USBPort *usbport)
     XHCIPort *port = xhci_lookup_port(xhci, usbport);
 
     assert(port);
-    if (get_field(port->portsc, PORTSC_PLS) != PLS_U3) {
+    if (get_field(port->portsc, XHCI_PORTSC_PLS) != PLS_U3) {
         return;
     }
-    set_field(&port->portsc, PLS_RESUME, PORTSC_PLS);
-    xhci_port_notify(port, PORTSC_PLC);
+    set_field(&port->portsc, PLS_RESUME, XHCI_PORTSC_PLS);
+    xhci_port_notify(port, XHCI_PORTSC_PLC);
 }
 
 static void xhci_complete(USBPort *port, USBPacket *packet)
@@ -3341,7 +3183,7 @@ static void usb_xhci_init(XHCIState *xhci)
     XHCIPort *port;
     unsigned int i, usbports, speedmask;
 
-    xhci->usbsts = USBSTS_HCH;
+    xhci->usbsts = XHCI_USBSTS_HCH;
 
     if (xhci->numports_2 > XHCI_MAXPORTS_2) {
         xhci->numports_2 = XHCI_MAXPORTS_2;
@@ -3429,10 +3271,10 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < xhci->numports; i++) {
         XHCIPort *port = &xhci->ports[i];
-        uint32_t offset = OFF_OPER + 0x400 + 0x10 * i;
+        uint32_t offset = OFF_OPER + 0x400 + XHCI_PORT_PR_SZ * i;
         port->xhci = xhci;
         memory_region_init_io(&port->mem, OBJECT(dev), &xhci_port_ops, port,
-                              port->name, 0x10);
+                              port->name, XHCI_PORT_PR_SZ);
         memory_region_add_subregion(&xhci->mem, offset, &port->mem);
     }
 }
-- 
2.47.1


