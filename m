Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F1ECCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NFS-0000sP-7j; Wed, 08 Oct 2025 02:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFA-0000rB-Ic
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NF8-0000aP-FO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso34916475e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903300; x=1760508100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU/Z9f8hQK2W+I5bFCKgqWvOzfwEaQk014ZzzMuXKdk=;
 b=f7vysyrPrA/lK4MfIlZ5Xz+gK5cR/Ng8F4fTWCPTk1UhZAsBrBqd97wVE8aNlVKIzi
 vAixn/Iz3RKZG0eFKz3q6j2mS0O1loP39ODYDRAmObDgAwcwm4NdUHrA9RONRTDxvBY6
 fdxUpBsghRVOKwW3S81WfzQuyQBKhyN1g65K8lOiLD//2XbaFEssIX8mxNimDr2rRQSO
 rKZWNkmZEAMoG5/b8Ium94U8Th6an/l1JLsT/yJBacP7tWc7UXqucqRzcELr8+CrvJuC
 PifsFi1dpZQd9L1ysxmXuVtKMzwiexHSGmEAZA7DXo0/RoKQyAbhNsX1gsp4GK3vJ/DK
 9emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903300; x=1760508100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cU/Z9f8hQK2W+I5bFCKgqWvOzfwEaQk014ZzzMuXKdk=;
 b=uq88g4mPvU1sdNUfEakHMMbKJoqaG/KyneIg/A7YeBDhA7uSPAuCANeRLgdrwei5KJ
 wNmP10Cg6G12Trh/AB9YwABGP/pJk4wjJfgQ1gOGmZfPDYKZzeZSWUpHrELObkf+qNOd
 GNPsBqaSEZQLJk7GYFEtN2M0H11OCsVc+a8vPnDcbAVHcVzaZl8b4oAaBXgTNXurdyWj
 W+OFaxUhT+4VxRW7Ucth3aE+VRHZ3hs6LfsqI7gNSkUT3WQXNIEddZD69ZxnDh8kQhRL
 Xb24Vz53wqtYhVonZjNTV2+V7f7URhhYm675RKmmIPgzwejCgp0ekAUSqam6y915ypJ0
 QbTw==
X-Gm-Message-State: AOJu0YzKcVGQcVWsC9hMLQGzmXyd1Qa8ZBVbkL+yVUW455TFU+AWmkPo
 5N2YJr4AU45FnllaLmVe1nijht664tOaMko4f/gTWZpzAQrlP2SWxC9Y4nReZxhVZflk9ZmMOH/
 Hl4KUiEwI8g==
X-Gm-Gg: ASbGncuwyIAUrjF4AXH8a1iFcSVYapWZlv2oJFAbjHzq8gcik+gOi9I+H5g1eQt9xgQ
 3PMXbpgH03bylJxZidQO2gZYIIHfKDOsP3wGDJTxNpDetkeUJT0/yOpmFRxmcDtbgRFsNITuuai
 6dJiuYeAlFf51iiqQGwb7cUiH4GMm9cQOwiU4Inb9SwiqZ11Xnp5jXTsaqZInrbzyGid+M4Cb0l
 8ozXueuJ7ZMWfgxX9nuCFyKfw+7DKtHY678c7O6f6ALNxUAGbA1n4k/OqqFpihgRgnTMomgrreY
 2QLPtsU/Nn3R2qxCV4E8GuOOWcB35j2k+Hlx069StgYySNH7Izo546+BA1c4Ww1rypluQn9dhi0
 5cIQ806pO7HPsJcYGyaIxHEk7AITF4CMsgOKlPETKeyDBOSkYdNMQxFXlerRGEMQiaB0uACdVWg
 SwiZjmahKiIghmvzOTjLUIaPpp
X-Google-Smtp-Source: AGHT+IGe+M0Ewh7DUN0zDgrjRz377UolvuDev5/vJHg7PdcpbLPsJC4Mct/o7S4AkO4yoOfR8HuovQ==
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-46fa9af364bmr10987205e9.23.1759903300533; 
 Tue, 07 Oct 2025 23:01:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm22137655e9.20.2025.10.07.23.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
Date: Wed,  8 Oct 2025 08:01:26 +0200
Message-ID: <20251008060129.87579-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008060129.87579-1-philmd@linaro.org>
References: <20251008060129.87579-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
cpu_get_phys_page_debug() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ef0e2f973fa..cf577a72268 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -274,7 +274,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    target_ulong vaddr, paddr = 0;
+    vaddr vaddr;
+    hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
-- 
2.51.0


