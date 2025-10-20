Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611CBCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoAk-0002S0-Pb; Mon, 20 Oct 2025 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAi-0002Q1-42
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoAg-00015U-3d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:35:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so39462805e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960123; x=1761564923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzhPWMtAsbDZTthftO9YhohXMbNw1TnHtRaGw5lyOng=;
 b=RlPiz0dvHrGZl9unpTNQimY2sUJh65W7F4p28OTavgzro/IeOMGHXuS7aAlxB7Syt/
 9VRpIQZZrUYbnBGg0k5MsOs5aLb5KfbSyhaAXVvpy70HiZscX5L2SxSmI4rdkulVbel4
 kQeBHkKzFdF2e+Fo5sF/8XrFsreiiwG12jAmaWDt4y/FShJNq2OoAEsp2+NOKqIdarbl
 wA0birrGLIPFTmrCxP9AOwBEUdLuZfhTBMHHnN95QcgszcMUfKSFOyZeOa5oecHaJrIc
 iPTZ0UNb6fFjQn+Kh0hbjSwVAYIuXzsF8sf+rDEE/reVIJHHnAm+9YSP/T84DFW7wJaW
 RlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960123; x=1761564923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzhPWMtAsbDZTthftO9YhohXMbNw1TnHtRaGw5lyOng=;
 b=je5KScmiy61EFPcbECo/o70pDSl1MiMHOt3Osk+qAgDr7oFNH0R0oMSJ6Pdfs/WmMW
 NzRiJpwGALRrQUKAGRoduKkoCtsSCo1ze5wLYwIPoIe8Z/wBFS2GdWvQn3nx/LMtxOGI
 THah9M5IPuXYzET9ZJJHtHscdKcsT5rQx9XeOSZd+KIk45UpqLgbmMnc8g/1zbhVMbhx
 lYN5w+GWL32cQyc0weFiMSoC3iWupo12ZWRGcTYRQgcmKQCL688C+41uyKR/kXGhSLyE
 w58kmJKXX5g5N4n57EN/aH8gRkCcEsW58bfZeDBxhPRwLAEthnnpwJndwyGF1kK6v/lC
 37BA==
X-Gm-Message-State: AOJu0YzXdHtMhbpzvE9tUYKQKBUyn7AyXNAfGvLbnDe1oNMJpAJWG0lg
 jXDf1C+s7ORhbSNEtt8lSzXnVW6NtnKyjHkL0FnV+mqnfpbuY+T8M/zC5l21iVu1Xxp66NNqfy5
 jtqhQHkc=
X-Gm-Gg: ASbGncslUzSCKSKGsIwtz7hco7QyE/W6sX9Z2/NPgipfGyEz0/ZrYyGASyAOiueMt9n
 37cQ3GKKsuEYoa1DooKZe4rH2i1jYSbYSd3IqbP02LyU65KUH5UrsxGHwFFO54VNyG9N1QWGMhR
 PTQEx3bxRte3wEwGys//PaA86RtHayK3e/8V7A7WFAVFXzR5O9WVjM26B0PZ7dt/ofgGHmYlbVe
 fuLvxj5XqFBbON6Rfv5LgNXfWfciFuU44yDNtPOo+99WThMQ/6PEn6GcjGUC0yGTZz/qVf0PkYP
 QEcH4PVn8U79NOXG1PBz2xI7DdAz+9R+o8S+recq/TBEOZhYACrPzWw2Yy+iVNXgcKrtwS1zui7
 ESk0ojMpCAjV0vzRhFbkja7gPoRkz0LKUWANnF5jeYrp5UCFEB057XUkI7h4kCGbC8CvGPU7I8D
 89DvL5FEdHIPOKIgWm1VO1tlg49HiyVJQgzAUasGhkKVEABF4iC8fHoQdNI6ZsiQSnw4NPzy0=
X-Google-Smtp-Source: AGHT+IGx8/bW0BfFog+BbHV+wdKKj9MN2FMI8wIhdy1epDQbm/zZcQw4pC1e+iagJ9rBjrQOXHtOEA==
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id
 ffacd0b85a97d-42704daed04mr9705653f8f.38.1760960123281; 
 Mon, 20 Oct 2025 04:35:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3d4csm14554230f8f.19.2025.10.20.04.35.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 04:35:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/18] hw/ppc/spapr: Remove deprecated pseries-4.1 machine
Date: Mon, 20 Oct 2025 13:35:17 +0200
Message-ID: <20251020113521.81495-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 200e68b8bc2..546e100c9cd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4944,26 +4944,6 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 2);
 
-/*
- * pseries-4.1
- */
-static void spapr_machine_4_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        /* Only allow 4kiB and 64kiB IOMMU pagesizes */
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
-    };
-
-    spapr_machine_4_2_class_options(mc);
-    smc->linux_pci_probe = false;
-    smc->smp_threads_vsmt = false;
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(4, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


