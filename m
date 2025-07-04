Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846E7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLx-0002J7-OJ; Fri, 04 Jul 2025 07:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLS-0001jL-Gg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLO-0002No-VV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-235ea292956so8653545ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627556; x=1752232356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKUA7rS+V68gRLJioO3r9xBRT/IbDhtTsq6XxI77XCU=;
 b=Z5bBEyhupzVhwVCegi4HxVbNR6B87P/LivX96BWp4Y+T8yY6CSQxyypqu7qmSl1ngZ
 0OwnVpATtjeUZLYU3UC8GgiPiAHSv4dMeFPjn/yOX4pCMOwywNLAkB8vfApSrCQJoLev
 MtURjUD14GqtXhCt+zTOk/Vf4dnkICWraz+aMB+h/NQx8EHiEsWFl+5RJWOuUYpcNGik
 bQuTITWruLUCHGB3xzb7pFWO1Y8nQgWWfp0dXf0UQXMR9a6zzZzsnA1V3SEPcotLbZdy
 prOFTlNF/TIo9MgXOfMBCIM4EdisiXRYVDkibEW87aInSz3n0xUVbepOoH++kLCCI/L3
 N9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627556; x=1752232356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKUA7rS+V68gRLJioO3r9xBRT/IbDhtTsq6XxI77XCU=;
 b=caKX2G9+58Nog8mpTrSsZ3NCAShcpZNCV6PFpaXJHW7j58bO+gkbyKNuItyMWxLLLX
 LyqhSPwuoPZCXfGEHc7tIKvBCsyM6b0R3w6F4olEthBgys0jVz7ic4JMi/BhOO7am9YU
 7mlWMbrdapHtih1jr6KBMG58Pf3WnynLjXQYSMKueqDIaBfQn1kJYPMyWhCSGN/EsKWT
 xbcmaj1twOFGYy6V6O5NNjFQSK/0y5FIsvJS1j0dHaJkPzb5CRdl3YS2OMF0ljri5wp1
 bqztxFa4rieVO0bIfXwuvR3Hj50G6d7ANMAQItCNDy0+X+5l/GL/zIMgK/FZKrpOWdjY
 m8Sg==
X-Gm-Message-State: AOJu0Yxy14sIQciCJfdH0weLH0zCCAlnYG4EfodPMWsnGLGEvXh/EFHK
 SJpUDQj87VMfQa3CsD+yAVgONlAg4Bc8LpDkp2W9I9HME+9Tq4XQGi+WHAzkLA==
X-Gm-Gg: ASbGncvnHiMKgGng4JqT3HimY1R4WpS/YJKbJuoj+BVhIb91GjcvC1r58avUTLXdp47
 HlbMA9Xb0ds+fU61MM4yZqPfIBeKL3o9klieQhBNMk/Niad8SM2Ua5iAg+q1+Bva3UX8AQQvC91
 ysbas9LjfYsXVb2v/kD+uqjrAo4dHOlbn9EIMASwPlA26VlJ0eGrv2Ps9XTzH95AYPLRBqpnMxg
 LQCNVIWrWqK7Uz0tqLCH5ryJDvLkEvpU7l0O6vz7iaCw7Ew1mZUVWdliLxCWgLa3oDj1BrmMDjn
 BiZKZzLA5ssUKS3TEBhvEN4mPsNyUuFUUHJKHEgrlgb+CV5GzhYrekU7zaATlwqN9SO+z+Glt8o
 sFp9XLvW+Za/F5Dxm7k6+rcWP5jw+e6roKOH1DgX1V400Y9jiuPshHSTKk7yIyv9GY+A=
X-Google-Smtp-Source: AGHT+IEjaMLXvWeq69POXg5nwvVMAIvEpwB27XVAeCyIm26TsFOO6NC0hEUWH9KOy+IVcHtyfCqq2A==
X-Received: by 2002:a17:903:3c4c:b0:236:9d66:ff24 with SMTP id
 d9443c01a7336-23c874661aamr26851695ad.8.1751627556505; 
 Fri, 04 Jul 2025 04:12:36 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/40] hw/intc: riscv_aclint: Fix mtime write for sstc extension
Date: Fri,  4 Jul 2025 21:11:29 +1000
Message-ID: <20250704111207.591994-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

When changing the mtime value, the period of [s|vs]timecmp timers
should also be updated, similar to the period of mtimecmp timer.

The period of the stimecmp timer is the time until the next S-mode
timer IRQ. The value is calculated as "stimecmp - time". [1]
It is equal to "stimecmp - mtime" since the time CSR is a read-only
shadow of the memory-mapped mtime register.
Thus, changing mtime value will update the period of stimecmp timer.

Similarly, the period of vstimecmp timer is calculated as "vstimecmp -
(mtime + htimedelta)" [2], so changing mtime value will update the
period of vstimecmp timer.

[1] RISC-V Priv spec ch 9.1.1. Supervisor Timer (stimecmp) Register
A supervisor timer interrupt becomes pending, as reflected in the STIP
bit in the mip and sip registers whenever time contains a value
greater than or equal to stimecmp.
[2] RISC-V Priv spec ch19.2.1. Virtual Supervisor Timer (vstimecmp) Register
A virtual supervisor timer interrupt becomes pending, as reflected in
the VSTIP bit in the hip register, whenever (time + htimedelta),
truncated to 64 bits, contains a value greater than or equal to
vstimecmp

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250519143518.11086-3-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..4623cfa029 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "target/riscv/time_helper.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aclint.h"
 #include "qemu/timer.h"
@@ -240,6 +241,10 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
             riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
                                               mtimer->hartid_base + i,
                                               mtimer->timecmp[i]);
+            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                      env->htimedelta, MIP_VSTIP);
+
         }
         return;
     }
-- 
2.50.0


