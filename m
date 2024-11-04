Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821FD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krp-0007ry-HK; Sun, 03 Nov 2024 19:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krN-0006jU-AV; Sun, 03 Nov 2024 19:22:21 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krL-0002mJ-LL; Sun, 03 Nov 2024 19:22:21 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso3273851b3a.2; 
 Sun, 03 Nov 2024 16:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679738; x=1731284538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO8rc0AL2JsckP0Oo9U10hDIi/2TOJ1ZcNhDVDLVnL0=;
 b=KN2L9S4WAQ4EVzSVWwAhqO6wh/PC5ykxXltyQhDBMqZCe/e3gWfmQpB4fZ4M023Mz2
 9PAsln3WVEFF+puSyWkI1ko1Qr3fRdBc/djCzxMvxMR5VsHY9UwZvbBFGr7VyZ2gW+aW
 ye61pnm1JNy1xL6MjuMFUry5f9z0s+gQsBn4MnVSZAy/TJIU1EeYCCKSqAfTaLZrsaGi
 FY9kiKM9PLSBMaToCUxET9t+m/nwKapPcOKr2+Lssgzoi32XhffVO/PKKP7zEGsOfVvs
 AJn+ipuDYFO99fh3xDiKBVerNUU49Q4NQWuKRVqrWAnVKmtQ9QIhX3kA4nhQwjDaA6fF
 kcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679738; x=1731284538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO8rc0AL2JsckP0Oo9U10hDIi/2TOJ1ZcNhDVDLVnL0=;
 b=pwlrjsjN8O2DZmRAV1JGchkDW1Jkf9R6C90Jx94fyfhGVWPzO++nunKO2tA71H5Egu
 3A7o3nSAW85BBQo9QuX1VHBqHE276p8lLzgsh5AOxZE9OoU1Ah6mKKX1EQvdnrufgXSG
 CFikyC0RZ4JXsltZir8GubQWCJENPP5i4AZ1w0y1VwMI9YoBuS92QlJpW1KEyiFXFBCY
 prvNvSe7jyTnPR12qN7FeZRxNh2i+yktv9UzdjUVZqEKTzTUSAFev1zEk/X3h2caHraq
 a3CMZ9mfDO4mWpFfz6lczDen092u7hAKQokR2Sx3fwaLmRt403f8Cfz/7ww6UOhvfoSz
 41Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGsawjighk7I1YjRnB2mAfBBmpRu5fx/AogtuI4ReCdSQy5PmMpgn7vkQjkZRDJ6IyYih+C+q48Q==@nongnu.org
X-Gm-Message-State: AOJu0YypDS9EJEMoOUjQZPzmfXaEPDqVokqoal50WuKDvfkeEm8JJlcG
 gscc8ELOGdu3hGsC0t2418Bk7mmKilIEGl+q2tu4wdxL1fPTKGeTT0zyEw==
X-Google-Smtp-Source: AGHT+IEPJCzPyna2b8fd41adWUeFIeVvICtgUmwrW+oTBIJt1dBwajKV4PdC1+E0fpOd/6XbpVLzVw==
X-Received: by 2002:a05:6a21:1690:b0:1d9:3456:b794 with SMTP id
 adf61e73a8af0-1d9a84bcdd6mr45311652637.38.1730679737737; 
 Sun, 03 Nov 2024 16:22:17 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 52/67] ppc/xive2: Dump more NVP state with 'info pic'
Date: Mon,  4 Nov 2024 10:18:41 +1000
Message-ID: <20241104001900.682660-53-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The 'PGoFirst' field of a Notify Virtual Processor tells if the NVP
belongs to a VP group.

Also, print the Reporting Cache Line address, if defined.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c             | 10 ++++++++--
 include/hw/ppc/xive2_regs.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fbd05aa9f5..ac581fa195 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -161,14 +161,20 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
 {
     uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
     uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
+    uint64_t cache_line = xive2_nvp_reporting_addr(nvp);
 
     if (!xive2_nvp_is_valid(nvp)) {
         return;
     }
 
-    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x",
+    g_string_append_printf(buf, "  %08x end:%02x/%04x IPB:%02x PGoFirst:%02x",
                            nvp_idx, eq_blk, eq_idx,
-                           xive_get_field32(NVP2_W2_IPB, nvp->w2));
+                           xive_get_field32(NVP2_W2_IPB, nvp->w2),
+                           xive_get_field32(NVP2_W0_PGOFIRST, nvp->w0));
+    if (cache_line) {
+        g_string_append_printf(buf, "  reporting CL:%016"PRIx64, cache_line);
+    }
+
     /*
      * When the NVP is HW controlled, more fields are updated
      */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 7acf7dccf3..d71a54f9ff 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -151,6 +151,7 @@ typedef struct Xive2Nvp {
 #define NVP2_W0_VALID              PPC_BIT32(0)
 #define NVP2_W0_HW                 PPC_BIT32(7)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
+#define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
 #define NVP2_W1_CO                 PPC_BIT32(13)
 #define NVP2_W1_CO_PRIV            PPC_BITMASK32(14, 15)
-- 
2.45.2


