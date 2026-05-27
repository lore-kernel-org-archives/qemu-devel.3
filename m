Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A51CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKei-0007IN-Ko; Wed, 27 May 2026 16:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeh-0007Ds-9M
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKee-0005UO-96
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so63868455e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912903; x=1780517703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk3lZmLUM148KRJytCSWPjv/9H9/R4UDf3r1IZOQ7wI=;
 b=a0QP1rluNDFD3qbiqURROT3IoJLqDDQmDfbHCDUKqtR/uiKcOkM6hNM7cpW1YOgqHC
 cyfyt71sdTBHh6PsVTfa6n/kMdLYfYP4xqYJmamOUJ+K0zboo/X5NMjXmZV+yT75wrLl
 PwErSs9h4rq1paHG1u5+BT/h0N/1kN0ntcYK2URINbZQvM1XXOQyy0ZJu85a6w7y6hwL
 EbOKgbuXTgtolS8Q7Y9BTiXzLc9nKxaDa6hElCUCvXRsanCiaU8z0K+zDx2h0Q4vYVCN
 zb+9ykGH+MQHFgp8YHLoHNW8DjvGtMHpU5XyfEtpL8sKJYBzJyuli+3oZ6Vm+Mxn0zOg
 iLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912903; x=1780517703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hk3lZmLUM148KRJytCSWPjv/9H9/R4UDf3r1IZOQ7wI=;
 b=g9F8whbAvXevnY374wLycDH4UlMiA+ZKIFaCwrvn6K2z2dYHuw24H/s4mxY+3gZURk
 SuFGQDemFlnYiEfzVyKEDM8kNdVvjZ8zjpCdQbpkV+l7Plm/aFNa1hXAyxOuf1la3zvn
 xmQFZjMqq9rG8Fd7BG45PhwyiDV9L1PW85M8DHqtsQrnxREd7l6dTiekFKaSvQ2zWl7B
 QlVLF0DxmmyExvyrmk3v/gJBoAM9n2Oy6ziozWZOa/mLv1AjfUGo+lUXwIGwfatvMgYY
 yk8wReheG5/aBCtq92X/jX3qNZ7gY9nBz5iawgqlctX6L6+4bm+X1LE1rsobyH1Mw9Ry
 rjxQ==
X-Gm-Message-State: AOJu0YwKpWMPz9Reqk11FEIQPem4cFCpsbTMDwNu9UDke/6yXXBgefWi
 SsqTMErvSqZAIMSVFTbdOA57hrzU8r7UPX72th0AWtbOuFIeD+ftn9aSnDadvCI+Z77TBbrC3Gj
 SjCCTRZMn+w==
X-Gm-Gg: Acq92OERYfBEJS//jsOb/8atnZsLmd6gVnq18vGznSdbCwdIXTBk9TznS+R3uOFoQfk
 pU7RKeu7qZSO8tCgEk2P9pMofAKYq5zJHtYCC9uYEDNGODQD6LlITUOfZcgpVuAYQjU2ISMlz7i
 Q04JCZc6rR5hKPu3dGCPP6oZjulkepIdcnwvFKMepMkdK/LR5UsbhUzkico+3n30JQPC2MVZHHh
 6zfwGnPZc1YHvcA0CDmKc4O2DYJHI27S5wL2o2NdRzzbZaL38hRrGOIfprSbUdyE9ODXAO2wPo1
 hEhWNYucbLI1fVL8QLbqFaNb6+9py9MKt1KANygnYZimU+6B3MNjMukHpRDsBt9IEw0ukHCRZHx
 OQd5qpQN1Q6PQ7Vu9pDa2bWdtebRtEmvamuxwsu2KxXDi9fi0xCknrREAvRXqTyG/9J/8gXPFL0
 /7m5BpqU6mGjX9mFO+QtWBYoolQ7YeWy8f5ZVB9T39yDorbM/iXivykkrzP8UDq87JpjBJL9M1x
 vzE
X-Received: by 2002:a05:600c:1992:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-4904245f54cmr327778735e9.7.1779912902617; 
 Wed, 27 May 2026 13:15:02 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908eab248csm259365e9.14.2026.05.27.13.15.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:15:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 09/12] target/riscv: Add big-endian CPU configuration
 field and reset logic
Date: Wed, 27 May 2026 22:13:45 +0200
Message-ID: <20260527201348.29511-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add a big_endian field to RISCVCPUConfig and wire it into the CPU
reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
otherwise it writes 0. This makes the reset value deterministic on
both cold and warm reset.

This models fixed-endian harts, not mixed-endian implementations where
the guest can toggle MBE/SBE/UBE at runtime. The MBE/SBE/UBE bits are
not included in the writable mask of any mstatus/mstatush/sstatus CSR
write path (unchanged by this series), so the value chosen at reset is
effectively hardwired per section 3.1.6.5 of the RISC-V Privileged
Specification.

The user-facing property and documentation are added in a later patch,
once the full endianness support is in place.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/cpu.c                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f28..9eb47af0a76 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -157,6 +157,7 @@ BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
 
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 52f143f1cd4..fef424f2bf9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -739,6 +739,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    /*
+     * Model fixed-endian harts: MBE/SBE/UBE are initialized from the
+     * CPU configuration and are intentionally not writable via status CSRs.
+     */
+    env->mstatus = set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_endian);
+    env->mstatus = set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_endian);
+    env->mstatus = set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_endian);
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
     env->pc = env->resetvec;
-- 
2.53.0


