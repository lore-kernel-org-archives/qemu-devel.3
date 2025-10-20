Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5844CCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnJ5-0001k5-6E; Mon, 20 Oct 2025 06:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnIK-0000uy-GO
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnII-0000Hw-9b
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so2732044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956752; x=1761561552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZHEWfyw9nXdEX4o90awyf1j98q0YkzoZ7smAeZYw1c=;
 b=N/7orSYzHzXMcSiG8kpsa7MTkEDu48TQQBZtS8i7xOTzQ6Nfky3seeNaXs/bPKCQb0
 WMXNt5lV1auUfV2PL8rDBjZWQzQFR8B+YNdeFw3UIH1qoAVA54AUiu4rF1hE9kEF6TqU
 CWQkgcQEj3sd4CrLze6jLdj08nvvnqAEzjMHrfZarGfKrYQV8c3I7+0fhPW86OJfMGeC
 iRDlEMUzNcKi3QUMb7alak31cjCccUvmmIBHJYuKwd0hiOUNfesO3WI+rvkPBV9pktzg
 HG7LHYaDL2eR/Wqo8KQx55KvszopFzPoteMgH7Uo6NBRXIBzfo5Oa81VyGpvV2LzKa0U
 hQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956752; x=1761561552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZHEWfyw9nXdEX4o90awyf1j98q0YkzoZ7smAeZYw1c=;
 b=aipZMCU12P9ADo+4eCM33xG22ubT2EC8VNwaVkdI7c6ICdysuJYOn/SpiH6aPj7H+a
 ZBZbD0rbov0CLDeLNhbTmJpiTD3xRg5faiaYj7QiCCPDPUy7irRqRj3GMlDcVw1882NT
 rNZO3Aw0o1qaVO6Ha3gdmMyvJInhMLC13ZBIa5jbJMh84AGtBWUchhSMVJlqBvS0MbvG
 K47nOiyC11GLlbktkF7Co8U3HSWElxLz1bF7CFYL7qunRJaIq0/XhmjasHX78sfJsPFE
 awQr/HjQUHIPC3XcjCTZYNJVEj3DnqGDRrXaQRj6XmIy7VCLq8exTAPiUWmVAZn/MemH
 OQSw==
X-Gm-Message-State: AOJu0Yy7wiSFf5qlG5Dc07t19FNLF8pFuDQfbPsWra8Jrqp8V2vyQSP/
 k1CAp6lmPJb3UvTBvhpLX+EmEjuy9O52TNYxjjIdmPgL3bJXay3tznlb9VRf1KlDi9ccxGJSz23
 lt3lLzzw=
X-Gm-Gg: ASbGncuPa9gKgKA9vmgBHIq0OifFd2igQLrq1LCPEAtd8FMToaQSIWqcSxcq5isU0Pv
 Q+orCnhuOetcP7HNeSOr+0ZBQVIghVqPA7EOPGwiSdcRKcNDtstuOYrv3BhhXqXxZkBqgQ/Q6+0
 Nxgu3+j3acUIgPto8sTRxkt2sifNjYT0rp9bPDVLV/7ltRaVHd2OxZ+rRl6bYcqQaK8EbZSSOxx
 A4QLkbHETF8xK3jRocTdH3HdQR0+BMwTxCbx9N8shxBJaTn0OUALw6RPVdGc+7K6+j+L4C4dZHo
 ZmG1lpbzMXgpeKF4ekxnqlb7urmTtecp8d9UjnjaWCiWB19/gMArm/7orU+zUfcSK/Rpe9NYokg
 wl1bGbwboDJ7Yhz69jfaWYGqfzs5GagMgqugWimkhG01aTqgAMmXdH8rD2fWUqlHVw51u9vJ6tP
 /8pQ7KN35L7Hh5SS9vfXGiDDVB6sIqbrsD2CbrG4tRGpeTypAQ1g==
X-Google-Smtp-Source: AGHT+IHt0NJvsiUGxeAB/Y5QARjE5h0PkET3wK8rookKp/FSOl9qyNOKlATuA3hZTZ2on/J37dayhQ==
X-Received: by 2002:a05:6000:2c09:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-42704daececmr10159066f8f.36.1760956752274; 
 Mon, 20 Oct 2025 03:39:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c65sm14592118f8f.15.2025.10.20.03.39.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:39:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/18] hw/ppc/spapr: Remove deprecated pseries-4.0 machine
Date: Mon, 20 Oct 2025 12:38:07 +0200
Message-ID: <20251020103815.78415-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
 hw/ppc/spapr.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index feb1e78b7c0..e861a2e7466 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4968,33 +4968,6 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 1);
 
-/*
- * pseries-4.0
- */
-static bool phb_placement_4_0(SpaprMachineState *spapr, uint32_t index,
-                              uint64_t *buid, hwaddr *pio,
-                              hwaddr *mmio32, hwaddr *mmio64,
-                              unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    if (!spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma,
-                             liobns, errp)) {
-        return false;
-    }
-    return true;
-}
-static void spapr_machine_4_0_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-    smc->phb_placement = phb_placement_4_0;
-    smc->irq = &spapr_irq_xics;
-    smc->pre_4_1_migration = true;
-}
-
-DEFINE_SPAPR_MACHINE(4, 0);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.51.0


