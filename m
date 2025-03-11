Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81728C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCv-0002iX-3p; Tue, 11 Mar 2025 08:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCV-0001cG-QP; Tue, 11 Mar 2025 08:59:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCT-0007ud-KF; Tue, 11 Mar 2025 08:59:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so10436509a91.2; 
 Tue, 11 Mar 2025 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697948; x=1742302748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLC1n3HVZL5UFr7qSjs7PdPNKDKAAkSwrr+MO1MH/MU=;
 b=MCv8mRME+VlXfNIlUkk+VgeJ8WAR9LtZs8zOrTw61HXN7/obSY2AqgAQuHXuJgOAoN
 dRhxvyAFH7vmAQCWny3Evy2zZmWrTUA+ICzzG8Nakvd4X9Xia4i97FzNaATsdxIGnTo+
 7mt60q1xpUVSjOq4AnaIQVRxk+RChG0lKvVDYtjRlxEwpopr3YuZ2N5EMKdypoaJcmOZ
 51tC28k3eKuiEECTmioAFT9RXcyvqaz5c1Mo3O5B/caKpCKRlylBEE93YyEqnBDHhHy1
 5a40TU3HHg/TnkNV787saQrsVMOMhUJXliwxF1X+AqAX7XpOBSGQKZvrf60bP6++0nay
 ZK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697948; x=1742302748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLC1n3HVZL5UFr7qSjs7PdPNKDKAAkSwrr+MO1MH/MU=;
 b=LvMERcXiphMBumjc/PormHToedyDz9THUkpDBNN5F5RZBQSYyCrfNTu20hRvvwaUo9
 MS7WcWYD7ow7aMsXmAAWPfFFys6oLZw3VXVwCSKnhc58zwwHZxQGMvWkM6GWsdIvFOSU
 kAE+J7+0RTsmgb1nC0Cf3s57ABKlfhYZnE9pB8R9USM72KkizpvO/DsWq6kei9Tv1rol
 AkYLySyxVBPFQ4YwMMx9qPkk5lpNGzLIh1KQPdYu9CuDlOW1Nl3Ad5adMtMaVzOFsEjt
 Jpus6DF7WtuzJalR1ObqbUvRJc13EWHquP+eg0QQOCOhSqMCPlXbLQeYLa9kZhuhlI91
 Ft1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwpNyk31GEOJMnMZ10uqaHPeo18qPbHmhj9I+WLjcy0Ytvu58yNGeNdzx8Q8uGrRHQSeHbnbmvYA==@nongnu.org
X-Gm-Message-State: AOJu0YyOD2a7F/pJnxbGXIhHOpG+WwmNkHCUVqMFxDDgfwg8gKuSaaeG
 6OUuLeADwJc5BqifuZHTFBBYKCZDttuu20iQMexY/vk8LvcgJskT7elSDA==
X-Gm-Gg: ASbGncvw+/0YK4HzErRo7nag9CM7Ao2zXskfujfqtiLmBkmRV0T4rzdf11r/i/ZLiCc
 vs1OsX3MZdByIfcWPqqAnQFhMA/p84wXJfHpLMIDd8uMl4wPgqCDcx+zeJYG4AE0fBA0bMG7NZP
 vJ+6evQY1vnPE8v1Mm266rVxg5R02B9YfdVNgyiUrV+Th9ae54TOMyZadAmajq+Xc1nFnUGGJsq
 tAW0ZKmD66xJKpibFK8vGARoqJ05yQatGD86hZ+wUDc4Ax71VU67rIxJAZfEcbKLMT0mcsuz3FA
 ejvnQyU0gwWlVpolKAp+ihzEKNfTdKRAxfk8SIEWZ02i9VLn6pw=
X-Google-Smtp-Source: AGHT+IGvY8ozC/uQAizW8zsb53sHUauiNE6F8zgr5Qr3Ie/PuiDWspaTTXP6IdA7QV3HomRrGRzFuw==
X-Received: by 2002:a17:90b:3887:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2ff7cef99c2mr31715649a91.33.1741697947928; 
 Tue, 11 Mar 2025 05:59:07 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 11/72] ppc/pnv/occ: Better document OCCMISC bits
Date: Tue, 11 Mar 2025 22:57:05 +1000
Message-ID: <20250311125815.903177-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

Use defines for the OCCMISC register bits, and add a comment about the
IRQ request bit, which QEMU may not model quite correctly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index c6681a035a..5424d87ee9 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -30,6 +30,7 @@
 #define OCB_OCI_OCCMISC         0x4020
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
+#define   OCCMISC_PSI_IRQ       PPC_BIT(0)
 
 /* OCC sensors */
 #define OCC_SENSOR_DATA_BLOCK_OFFSET          0x0000
@@ -50,13 +51,16 @@
 
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
-    bool irq_state;
-
-    val &= 0xffff000000000000ull;
+    val &= PPC_BITMASK(0, 18); /* Mask out unimplemented bits */
 
     occ->occmisc = val;
-    irq_state = !!(val >> 63);
-    qemu_set_irq(occ->psi_irq, irq_state);
+
+    /*
+     * OCCMISC IRQ bit triggers the interrupt on a 0->1 edge, but not clear
+     * how that is handled in PSI so it is level-triggered here, which is not
+     * really correct (but skiboot is okay with it).
+     */
+    qemu_set_irq(occ->psi_irq, !!(val & OCCMISC_PSI_IRQ));
 }
 
 static uint64_t pnv_occ_power8_xscom_read(void *opaque, hwaddr addr,
-- 
2.47.1


