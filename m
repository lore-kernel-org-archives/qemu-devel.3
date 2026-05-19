Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B1BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPC9l-0001vr-0y; Tue, 19 May 2026 00:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wPC9j-0001vH-A1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:34:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wPC9h-0006qB-QK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:34:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so1187544a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165248; x=1779770048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+rjXee4hWUkMvb3epRCHq9thVc/JeapX6uJbIY3dtQ=;
 b=l0xZUrO2vErtLH1KtA/1G50dQOHQC5MtZt5Eoq+FENyo4WGq5fA5439U10iluEh70c
 EfCNzEXbjfihVMpPrpoxNKuMpf5kedNXXZQ+SkROkOgSBFT0SFDWz1iZvvj+aDr0+XYY
 kxr6ddBmDvwUuQAGL0dWM0bjmC0af0Z1PsUn5kWdpd6PKp3F5SapB8/eZbUo3LjSoPAz
 0WIAluOg4QSXuSVC4RmJDs7iAN8pdcQpvZpy/M8MYlAJNwFVnSa3ix60rO2cLA1IRG09
 HcHPyxQ68lWwEr3061BQVhr430ZiF1nxojNHbWH0Ibd7kOUN07q9mI1DFiEtAajEWwyl
 fg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165248; x=1779770048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+rjXee4hWUkMvb3epRCHq9thVc/JeapX6uJbIY3dtQ=;
 b=Mv1EPhZQGy8CVf8L2+KTtk4A/Q0kJXC1TDlhx/CdMJD2apwEymDU714p7pR8Dd2Ksm
 kRxioLH/kX2qu5ACRT3nJdqZp2AOySFe0q4LAexVebTmkTf3z9JxRMKEZyE8RA/VssOE
 q+kvZwpHWq+4b071kOebS0lfigfAnjpJearb+URbX8x2PK/bkECK3rmbzJKGSI2U6fQL
 siZHYsBDBf8vn1pQoALeLm6TbhOGI+VGmyB4cDmx87JxJ6dOhbS+RmqbJrH/poU9dJW/
 JUECEZ9cBg6aM3G9TessR5HrPrN9P1zQPqvO4gjvhCkpviENkHRYxGx1V0xHsyasQd2E
 6XxA==
X-Gm-Message-State: AOJu0YyLeUavhT9diPBve5deAPql0OxcxeIsrd7wy5LpOysi/qGzZPdl
 LTwIP46Yb8JjF6fFVBvt3DK8nf8zCzwsFFfIFpuRQtZ0ttFvoMpqRqcwt7ibaVOK
X-Gm-Gg: Acq92OHEs4J3sOBW/4xaDQrH6lq2JYyJ3aO3zecjnjIMa5d41+HkWg8BJffz0bpBK9h
 EQriuzZzXY8G1AxO3WsgpqPFB3Ne8piWLekXPPK1BBhnEQoGrgiDfVzZcfdaLZvkydvlZklB305
 0Kr1UQVyh3GZb6sMx0RDg6YTsqyEfibuN0tE7agymWa2m/9fK+uxXtzDXHPAM3WSQkm6BY+TwuP
 s03p/xWJPCK7Sxsr+bocBVZF2lCniZM1ZyRo5pcyAbqJybDtv4LyLGsVUtZ2IFzcOru3dwG2rfe
 R0fGOq4RIBnv8YYW4O2ALUTJNKylcJPqGrZzT3z8Tq2sZ6JqjEiPAiPXI7i6IpjraHhM7jyYQCs
 mgIEk7S/EG9vBBIpxvoySeVOe/4yGJwIMlzJmiNwL3/irPTgyw6aub1tJ7iWQGY3+nZ8HxpDsvm
 VV15Z+97Gq2vL0nbjZIlkczCmdT7sAgqhrXn2ihUSl9cRVBKjn5Vg0pwCgATDUrDJuce64
X-Received: by 2002:a05:6a20:7f9b:b0:3a2:d838:bfe7 with SMTP id
 adf61e73a8af0-3b22ecd4939mr20851988637.45.1779165247893; 
 Mon, 18 May 2026 21:34:07 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb062a2bsm19023955a12.7.2026.05.18.21.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 21:34:07 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] target/riscv: Make hpmcounterh return the upper 32-bits
Date: Tue, 19 May 2026 14:33:52 +1000
Message-ID: <20260519043352.3685866-1-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=stephensportia@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The counter value was not being bitshifted for a hpmcounterh read
resulting in hpmcounterh returning the bottom 32-bits.

Fixes:  cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3498
Cc: qemu-stable@nongnu.org
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cfd076b368..c522533807 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1389,8 +1389,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                    ctr_prev + ctr_val;
+        uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
+                                                             ctr_prev + ctr_val;
+        *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
     }
-- 
2.43.0


