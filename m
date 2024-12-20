Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA5BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkbP-0005dv-KN; Fri, 20 Dec 2024 16:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkat-00051j-Rz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:45 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkas-00075i-4S
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso25419455e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730290; x=1735335090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5uOCTnfptaobXEglt5cStPbt9vyDRGLhNNrWNvGhsU=;
 b=U2/Br1r2hfUYi7lsGqJ1X9F2qPFqbG2+oATygC1AJTnOy124azbuHFRCSxjc7KPRtl
 Adiqj9K+5+0KmR0bc0cLLKymBa7agjy/2yF2B/x7ts/U9NpwpxbgloMm07tFSJ80UGii
 fThjcFTxNGu1JHZRTLWLNlm7NxnhoV/7NTN8tdEiz1iVM42BqFPx3lkenVR5Lo2IVZyY
 F4x9ObbQ3veUsdNGvnmNSk1OUhyAt6w6zF4IrXXwYxPJcD4N12wG/Uif1IkEBMAol/Yo
 eWxOSLjhNRLRP7buBa2kj7eHZOXP5nP0fFBggZHAsDJiCuTZNGuwOijw3Rzb1BiDPI+3
 DSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730290; x=1735335090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5uOCTnfptaobXEglt5cStPbt9vyDRGLhNNrWNvGhsU=;
 b=Hjz99EAU+womYyMc4pE3axMVUQKhh+/J8onkxjX+0H4uTzbcHIZj3k2MFhgfgRYVSg
 i7xDFgyk/Zy6CUxg5Cmn+VheJJeu6LoDwiXqMf07WHDEq3CFPf3PSLhfqnkdm/eoLVXO
 ImDufbYQuAWK17uMBeeIJoQht39+Bqlfkq+cwzxtiA9KxRSTPyNBced4J6qTGFMRDm9s
 K/gOiRcmm+GM9Xllqn/dualcohR4WxxC9nKuV1ic3TG9wJI/z1XLpXrXLyKoQeT7sCgF
 bb5KC3R4UAerXlQDK4dIk/g1gtlgR2MeMaxX7hljzV47y5UpZLGmYLVi0klz+aArZaU7
 H35g==
X-Gm-Message-State: AOJu0Yz9h2EWFJyCX1nkB/WtyrVkZZaVzWCj7z++He2diguzihKem7F4
 yzU8dcb3IlkeSaKebYDx81jj6628phAUTtvabJcVPEOphUkERKp/56iWqDoz32JpOw7xRYNLZKP
 1
X-Gm-Gg: ASbGncuWE06cKMUGA8y9w2fDe5OL75g6S6rj6JSNHoWxF5kgNgE5YcJhUyhRXvozoYU
 aC569sRsFlgmhaYj4Ebl3eTeaZQGUKO8B3gfr11pVSYEgCG6JL/QaB8xl88UvwLBM3s2SUW4BWh
 yMpi4hfg2QCfWIPqNuUZQfR3tpUKGXySWGhaHWWmItgBsPdBEfkzXFkhInYNnw4uwoAtvj2uRkC
 OKNU4rYoOr/jtHCavkizlie4eQdsGnPmauDCULYHlgBYgfosgqnajgzq6oerLO05sMCmh9N7wQ=
X-Google-Smtp-Source: AGHT+IGnmY2UiuFVMNv3LgvgikWxiAkTFg3eCUgPM74DjA4Iv1VX7TaEdoezu2I885pay3fjAzfcYw==
X-Received: by 2002:a05:600c:1c1a:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-43668646aebmr44268215e9.15.1734730290287; 
 Fri, 20 Dec 2024 13:31:30 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm56226125e9.19.2024.12.20.13.31.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 5/6] hw/ppc/spapr: Convert DIRTY_HPTE() macro as
 hpte_set_dirty() method
Date: Fri, 20 Dec 2024 22:31:02 +0100
Message-ID: <20241220213103.6314-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
References: <20241220213103.6314-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert DIRTY_HPTE() macro as hpte_set_dirty() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e68e8c320f4..d318ce2a350 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1422,7 +1422,11 @@ static void hpte_set_clean(SpaprMachineState *s, unsigned index)
              ldq_be_p(hpte_get_ptr(s, index)) & ~HPTE64_V_HPTE_DIRTY);
 }
 
-#define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
+static void hpte_set_dirty(SpaprMachineState *s, unsigned index)
+{
+    stq_be_p(hpte_get_ptr(s, index),
+             ldq_be_p(hpte_get_ptr(s, index)) | HPTE64_V_HPTE_DIRTY);
+}
 
 /*
  * Get the fd to access the kernel htab, re-opening it if necessary
@@ -1633,7 +1637,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         spapr->htab_shift = shift;
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(hpte_get_ptr(spapr, i));
+            hpte_set_dirty(spapr, i);
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
-- 
2.47.1


