Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B099C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXn-00078K-Ow; Sat, 25 Jan 2025 12:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXY-0006aQ-Py
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXX-0000PQ-Ar
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:48 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361c705434so21793705e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824505; x=1738429305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPivNFM2ePYvU+OXN+1pyPQF43zn33Cj2yHAkQlRhv0=;
 b=VE034kJuU0KdJi/HKmm9P9Nvz5C/Pz8cX2DZQ3gwQxu/VM2aA20Bjoikf7BHveQGF6
 0tXPuA7KbZxTA4i8uV4m9rTEGkzFhPnleaI6w+4q1fJVA9pGCsP12qAD/Rx9TwMsZWpL
 ab37T+FAlycV6rC2uPuwb3JevjNt8MCOzPvrjyiPldg7ZpJbO2DD/lIx3o3JkmtnWl5N
 nmpipy9evYNaP/QYuO8rXnDL5/eAJgmjZoQzsqQCrzEu7JfJE5hCJyk37tc8aPlE2662
 6vb/1Of9zMMmxONu9T81fqJa0m7yofb6VBbKuXh0VzsfcTomumPcEVvdAzqn3Gg4njdg
 LOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824505; x=1738429305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPivNFM2ePYvU+OXN+1pyPQF43zn33Cj2yHAkQlRhv0=;
 b=mkVa1D5gw+tPlwRtxxfMhef+v79VDYbokmYxUtL+XkyXcXDkfaC19++PeisqDUMxHn
 rkl0x4vcXKt1XfYKt+KN/tdUA83QP8eNccprAtCzjNzS90OMMBa3LS++qxw2KzKV6Zn3
 U5xU3mjwAG/ls8PGfgzTG3H/KVIBlfEQHarofYJN+/6TBV9Hp3wNoTxZmxq4yvqncKah
 BpBhgLb3rLBP9isQwoqSFcoFX0yKspFkpxdTLzUJJg15QroVGoAJOwdCRsswWOaLDbMW
 nShqHgUEzMoN+XTfcuhcGO9wfqxGmD0hm6/SmVSru5AmklKrFT0WjF9OaV6KAXX3btkd
 vsxQ==
X-Gm-Message-State: AOJu0YxXeF0H/37hhPSktJjDrxtKTE/3RV/Xr2V1yfh1vdbPFcvHaWQN
 X1VyDCTAiXZ/ua1oLC47Fxr3V89KZucLY8fDh2FTMyYGm7lHFley5RIQISFL9TCifze44pcwd13
 oWZE=
X-Gm-Gg: ASbGncvkUDVhHA+XFPrFPS/8tQ8xrVHM36d/vOqGuWHRiFP5l3nYhETCGBToxuE/UpK
 S5Ju3z9nU/K9nssGweKEisN6hZbQpfq0IwMM6HZXtIZgbFi7K3yjir2Pnzfntz4zEMQI6t/2yci
 bCIv9EgVyGacNdB1m8Vzw/M2RrHs4otABe0cA/6j1lb55axfLUfBdwpeBLPBrRrjyi+nZSyt3IB
 lTRnk77wZ8HvsQIJNXBK0wWxey/iNd0lQ8q47Izib23XCJE5ymV7c+MuDPhTy8JnUbXLEQdl8zE
 bn3JQ/I1Z/WX0HedCMaw3ASk6X9qThVTbHsviT1FOHgxKy7HE3dlwYA=
X-Google-Smtp-Source: AGHT+IFnoYc3M2vSnDVe+amJ0biKu7BVS/elw5Q0ZlX1hddE/60yvPS6YumrP7Uz7KT1dh8aCzzWuw==
X-Received: by 2002:a05:600c:4511:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-438914388e5mr359128085e9.29.1737824505505; 
 Sat, 25 Jan 2025 09:01:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa57csm69991295e9.4.2025.01.25.09.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/24] target/alpha: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:05 +0100
Message-ID: <20250125170125.32855-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e1b898e5755..83164a694d8 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -63,6 +63,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool alpha_cpu_has_work(CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
@@ -77,6 +78,7 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_SMP
                                     | CPU_INTERRUPT_MCHK);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -216,6 +218,7 @@ static void alpha_cpu_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps alpha_sysemu_ops = {
+    .has_work = alpha_cpu_has_work,
     .get_phys_page_debug = alpha_cpu_get_phys_page_debug,
 };
 #endif
@@ -251,7 +254,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->has_work = alpha_cpu_has_work;
     cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
-- 
2.47.1


