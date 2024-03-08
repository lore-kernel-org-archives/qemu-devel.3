Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815F8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAv-0002FH-CR; Fri, 08 Mar 2024 06:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAl-0001za-Cd
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:55 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAj-0001nr-Sg
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:55 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd4bc7a87aso3332925ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896431; x=1710501231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mh4Cluhyk7eCO/+CZvVG6s2g2zmheEHhi69RmkvalhA=;
 b=SIFperr1YmlbiWpSBdJt6AaQmkbGesr2hPFKQ2pn5uxyZggPrlpUAPQgWIfWlCg3lA
 MBFAfkcHeF9nPaq90fw2vOearxcKAtm3evcAs/ZcC1MxCx+vKjeXYguUKnHTL78oz6ht
 aS2zdoDfo+Pz80EOf4lbz0V+d2JW4iXp5qGJIf+wA7z9fAjH0gMiPQ8+Q15IzfMpgXR3
 3FYpJIbF2komgEvHRv5yRvXdLoT7NCkbq9DBRd2TuWOyurIOURsNwH11GrGR+bCE+uqL
 BAHb4x/J/KaEEfKS6f/67oPH8Vx0+AgZDzev6+tiS71PR9aQCQ+kbmY28C/VbsjdvLUp
 H9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896431; x=1710501231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mh4Cluhyk7eCO/+CZvVG6s2g2zmheEHhi69RmkvalhA=;
 b=MHT/fFYBOvPEI/h1AKsMaC4MTMtKdUmBw/BJF8jdj5PYcaqwe6lHdTBNwPtv/+1KAP
 wyl4NNnntGDIdgEu8oMn3MItjPClvfwKcCCrqvQ09ApERaaeTeVYnyws5dh8/uGnxc7Z
 2EaLFwSrBsCY4tqB+OD8Ubf/CW2wLIgWP/rllTlULpK9hCxguH2AtZenEmKgzRxjdqx9
 OYWuhXVTtfaWNumVXqdkhc7IrxjU2MgNkJfzf17+FHmPRfStje9Jj/y9R0KEKdgd/npv
 MSRn6NZmVszdZq2zrkc+5C/JpP8/jfq6n8EaZd2xU13fakkm9dnf1s4uakOpnqZcrlT5
 36lg==
X-Gm-Message-State: AOJu0YwjWxJavvLG77teVMJMuhovWu5+XVIdckPapFLDQT+lxe7pKn0S
 zyp2znWIv648TebOLPGEcq1/Re7d0ay50Lowg0eoy97z+V2/WeonHO/LwKItvo5yBA==
X-Google-Smtp-Source: AGHT+IE2d9Qg/vb/Cgag9uGIxJByERANiXEwS4th2yYGOnLRNFmJHBsi1q4bE5RYuxipwOyvDQfPvQ==
X-Received: by 2002:a17:902:930c:b0:1dc:b7d2:3fc3 with SMTP id
 bc12-20020a170902930c00b001dcb7d23fc3mr9627354plb.68.1709896430605; 
 Fri, 08 Mar 2024 03:13:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:50 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Hiroaki Yamamoto <hrak1529@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/34] target/riscv: Fix privilege mode of G-stage translation
 for debugging
Date: Fri,  8 Mar 2024 21:11:51 +1000
Message-ID: <20240308111152.2856137-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hiroaki Yamamoto <hrak1529@gmail.com>

G-stage translation should be considered to be user-level access in
riscv_cpu_get_phys_page_debug(), as already done in riscv_cpu_tlb_fill().

This fixes a bug that prevents gdb from reading memory while the VM is
running in VS-mode.

Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240228081028.35081-1-hrak1529@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c994a72634..ce7322011d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1223,7 +1223,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
-                                 0, mmu_idx, false, true, true)) {
+                                 0, MMUIdx_U, false, true, true)) {
             return -1;
         }
     }
-- 
2.44.0


