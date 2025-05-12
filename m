Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB7DC3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZd-0006vY-Ht; Sun, 11 May 2025 23:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZb-0006tx-Mm; Sun, 11 May 2025 23:11:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZZ-0006iH-Tx; Sun, 11 May 2025 23:11:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so51490475ad.0; 
 Sun, 11 May 2025 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019480; x=1747624280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX/ruiZHXDJYpQuBAh+eIidVDvs+sAH/A+6Z5+f4vwE=;
 b=b+Q8GlcecZNE3HFIr03MA8vmrYYgtTYitywC0LfCAV3Jmd5/UcfKnPgY8EeVuJL6CR
 0TSQsgjsqXZqDCHe3/az3Fua734kws0AIgNXv6Qk9pm00HQpIxBdyObkthYuQJFHhE+n
 3/vBhHoE8TZ5AH0FRGXBR/b9GXSemEL/OVPim6UVFpzwFUElZs8sgtTfAftYDkRmpYwq
 v273wvb7KpAKhwqd3x0JqdpCR8pccVKx6XUEbRXcAqRPLpBh0YcRNoi46mI5DlUrMxqx
 KOsK0eoE55RTdw7q2H1aBaZfUAfGYtaDIvVns1rE6hzwEfjTKApCBybnEUwtby9cUu0k
 Ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019480; x=1747624280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sX/ruiZHXDJYpQuBAh+eIidVDvs+sAH/A+6Z5+f4vwE=;
 b=lZe4IiHdiI3+EW0oOqUzsd1K2m/Tl39pOEohVMHARPN+WxMtQdevubGiRKkX7bJUiQ
 VzkUXul+QjaMSB2K5Wr8EKWLsJsfWygoje7tNfZzShmwj1u7Jpey9Diw1pTmpNnMa0LP
 l9nkDFPPlZj0vVJM629G0ehGie452Oucm6zJ2uHIMmksTzW9VqjdakHZtxcmBhYCle8u
 UBX5cdAxkflUK44mfXEWTKiT9Q0v3rVQJP4TiDGPFg0li2nSj6hcAlDpdmsYe4J8ICxU
 ske/51phSw4/Xow6FrWgEE8JEazckSOt3dTRiT4ugiiO59OMcOHmQ9MPREU7XAOLUFU0
 Yu7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkBMsG0PsKofUllUfWDlQ4VBkPZ+nO2/c0Zds+eDz2ouoiVowS1oK5noWlKiezBH3RtjhS1H1uWOiT@nongnu.org
X-Gm-Message-State: AOJu0Yxm852TNMGq0cIXWfLGxB6K4HQbhtc09YPZx8VtAD2wFQ9DSBr2
 7JsCJCjGGnjAntzhNJAGPM+O/dk4TuwZQQ/523ozWozKIniNMo4ts7xMhQ==
X-Gm-Gg: ASbGncvNgI/+f8u8eD3XW1caerPb0g/jnzCAizYu5xpdoX3rvcnxE8hEGLcXCRBoyQD
 OMIHnHfIByliqFTEVmmegwP+Zcv7enRBPO8GxboOxyf/cmDrBPNakL9u2BR5/jP/Z1FxJpf7JVd
 5Xcj4vDy57wJCC/tYWJuNfyWlG/lKI2JY3H6dLTNpeBO1Rc4VCsYF93ewj/zhVm8lK5G+9X0RdP
 qkrknDrdRFwsztAC6WyZLWFkijg1K06sSVLJOLB5LKw0xQYApEJ5OkjLnYXAIn86l4ZYn98aeJI
 /fxxxld1wYVTDR2Vo69Dc1dlBHQMxdBHMTwGXdPlDWTeJ6SwM1cU8kKV4Q==
X-Google-Smtp-Source: AGHT+IFs7HAD/oTXxEaFHV1bKVEIyq6QReF7VoqbClirIVlzVIk5JvpL0qrtDYyYUPoZ/yaQ/fITrg==
X-Received: by 2002:a17:902:cccc:b0:223:4d5e:7592 with SMTP id
 d9443c01a7336-22e847b0172mr226388585ad.21.1747019479708; 
 Sun, 11 May 2025 20:11:19 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 03/50] ppc/xive2: Fix calculation of END queue sizes
Date: Mon, 12 May 2025 13:10:12 +1000
Message-ID: <20250512031100.439842-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

The queue size of an Event Notification Descriptor (END)
is determined by the 'cl' and QsZ fields of the END.
If the cl field is 1, then the queue size (in bytes) will
be the size of a cache line 128B * 2^QsZ and QsZ is limited
to 4.  Otherwise, it will be 4096B * 2^QsZ with QsZ limited
to 12.

Fixes: f8a233dedf2 ("ppc/xive2: Introduce a XIVE2 core framework")
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c             | 25 +++++++++++++++++++------
 include/hw/ppc/xive2_regs.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 7d584dfafa..790152a2a6 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -188,12 +188,27 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
                            (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
 }
 
+#define XIVE2_QSIZE_CHUNK_CL    128
+#define XIVE2_QSIZE_CHUNK_4k   4096
+/* Calculate max number of queue entries for an END */
+static uint32_t xive2_end_get_qentries(Xive2End *end)
+{
+    uint32_t w3 = end->w3;
+    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, w3);
+    if (xive_get_field32(END2_W3_CL, w3)) {
+        g_assert(qsize <= 4);
+        return (XIVE2_QSIZE_CHUNK_CL << qsize) / sizeof(uint32_t);
+    } else {
+        g_assert(qsize <= 12);
+        return (XIVE2_QSIZE_CHUNK_4k << qsize) / sizeof(uint32_t);
+    }
+}
+
 void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
     int i;
 
     /*
@@ -223,8 +238,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     uint64_t qaddr_base = xive2_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
     uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
 
     uint32_t nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
     uint32_t nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
@@ -341,13 +355,12 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
 static void xive2_end_enqueue(Xive2End *end, uint32_t data)
 {
     uint64_t qaddr_base = xive2_end_qaddr(end);
-    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
     uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
 
     uint64_t qaddr = qaddr_base + (qindex << 2);
     uint32_t qdata = cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
-    uint32_t qentries = 1 << (qsize + 10);
+    uint32_t qentries = xive2_end_get_qentries(end);
 
     if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qdata),
                          MEMTXATTRS_UNSPECIFIED)) {
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b11395c563..3c28de8a30 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -87,6 +87,7 @@ typedef struct Xive2End {
 #define END2_W2_EQ_ADDR_HI         PPC_BITMASK32(8, 31)
         uint32_t       w3;
 #define END2_W3_EQ_ADDR_LO         PPC_BITMASK32(0, 24)
+#define END2_W3_CL                 PPC_BIT32(27)
 #define END2_W3_QSIZE              PPC_BITMASK32(28, 31)
         uint32_t       w4;
 #define END2_W4_END_BLOCK          PPC_BITMASK32(4, 7)
-- 
2.47.1


