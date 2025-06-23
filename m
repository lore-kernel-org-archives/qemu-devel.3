Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25C5C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiXw-0001i3-Bv; Mon, 23 Jun 2025 10:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTiXt-0001hM-Tv
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:53:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTiXs-0006hk-Ht
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:53:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234bfe37cccso55353875ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750690394; x=1751295194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dfCrlB613XHLXaiBnmlAyq29ZwPiHDfdEyZtwAXAqyU=;
 b=PQ79JTMgxPPczdX+AoGMNU+L+Yfcqvo1E3zt1bt4XGYrIFufAhuXYSqi9TUf0xIdWS
 zxvygaNPCsUUQk/6btE4j5QOp4OXDAYTAnUeWsqotcMPz3QYP29/V9kuQIO/f6ZzqXjz
 35N059dzUq92UutEygFMA3EuecepWmC6Y4A3CWng6n7wsDn7ruAnP55ggM/90U4EsePd
 p3xbREAQrjyyvN9TtcnaMgZbgz91g8WnK7I9mQfFdDdZGhHapIxt0rz/hSOBElcassk/
 jXsudsz9Nxw4xlEdUU91fi/pr5MkvxQGFEXLYnfFv+PTrYdx2QwlyZLvu6KLmhKMUb2Z
 VArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750690394; x=1751295194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfCrlB613XHLXaiBnmlAyq29ZwPiHDfdEyZtwAXAqyU=;
 b=tn7r8lLz77HYXDkYHdseI+/A7eMoy+UrPo73V4w2juyA1LvayDiZr5F5GGPJ9ExYvw
 L8mMbVicLvPhiJKT1w+5eyIHoWYachl3WQn/7XjN84sTnPwYYyM/CG4lmbBDGF4bDXYx
 InskwgzuEiVkGWonEwAweLYuKY2QF+IDpI1hDLq/+49zjWXscbjrAspupl6vV2bvWq5q
 lMOexNyG3znVLXShENbpgDPSD4z88vYnn5uXEnS6wTVnxduc/+WsMGtPH2rmyq2cy6t8
 eFCHYmdGhUBk54BKiPnqt4STLc/x+13jw/R49Qe6diQaqDCJSUK7Sog0U6xnedA0qFwK
 rsBA==
X-Gm-Message-State: AOJu0Yy0xgABjpo4JJZ4kH7z1ddXLoj35PfElNDTd1LQ0JTPOYaLxrgZ
 Sz8ItZkrFF1S1rmpKsx6S81LFLz1oyjKgmJQdge270uC/nXWaL0QJbOarY4OYSHD9nFDTF9VrBs
 7Rtll0lM=
X-Gm-Gg: ASbGncszKTmvap1BaywIryfDkrJSfK0kdqFcEh8cMFpI17Oh1PdNGvOuB/BaJgK9rjt
 TxAh1CgLKv21lsOfpX71i/8ayBlhxnxXd0TChlU9ks0K93ATEtUco0K1xSioG3ZiG+wujT1Y8T0
 Xw4e+aWs/kt/Nl6iC0ZKwaLr+Cj0NM+3wLW4fIKhzogru3C1KXdr2H4tDWQHmrqEWWbZlbPcNVc
 6kTLo9BV9DYSd/RS91cQiTNM6DYAQz81k0f98ZCYHGp5VPArUd1ioi9tfNEA5BEXVdOy4oDsx/R
 6uiAzurH9XpsOm6MyXfoRlC37sAIR5SC6cqObwTK5Dd2X3jNMJLmmKNu/mkkEuMbHeBF2Mjn4VQ
 =
X-Google-Smtp-Source: AGHT+IGZNi6xw2HTAnx+uH3O7QPM1TVdg8eR4dAamYB1/q/0DYY2cICcg3G85LhADy54F/QJ+Crbtg==
X-Received: by 2002:a17:903:3201:b0:237:d734:5642 with SMTP id
 d9443c01a7336-237d9a4165bmr198814965ad.41.1750690393768; 
 Mon, 23 Jun 2025 07:53:13 -0700 (PDT)
Received: from grind.. ([191.255.35.152]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867df7asm84069315ad.178.2025.06.23.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 07:53:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hmp-cmds-target.c: add CPU_DUMP_VPU in hmp_info_registers()
Date: Mon, 23 Jun 2025 11:53:06 -0300
Message-ID: <20250623145306.991562-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

Commit b84694defb added the CPU_DUMP_VPU to allow vector registers to be
logged by log_cpu_exec() in TCG. This flag was then used in commit
b227f6a8a7 to print RISC-V vector registers using this flag. Note that
this change was done in riscv_cpu_dump_state(), the cpu_dump_state()
callback for RISC-V, the same callback used in hmp_info_registers().

Back then we forgot to change hmp_info_registers(), and 'info registers'
isn't showing RISC-V vector registers as a result. No other target is
impacted since only RISC-V is using CPU_DUMP_VPU.

There's no reason to not show VPU regs in info_registers(), so add
CPU_DUMP_VPU to hmp_info_registers(). This will print vector registers
for all RISC-V machines and, as said above, has no impact in other
archs.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 monitor/hmp-cmds-target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 8eaf70d9c9..e982061146 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -102,7 +102,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
     if (all_cpus) {
         CPU_FOREACH(cs) {
             monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-            cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
         }
     } else {
         cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
@@ -117,7 +117,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
         }
 
         monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
+        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
     }
 }
 
-- 
2.49.0


