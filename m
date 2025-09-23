Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBEECAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z0E-0004Md-EX; Tue, 23 Sep 2025 05:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0z0C-0004Li-K3
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:08:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0z03-00005J-Ed
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:08:00 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b54a588ad96so3978702a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758618465; x=1759223265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVUbUh+p0V/TFtbOwMijOTMj5DCFHWZt7c1UjlK2bdk=;
 b=dIxMOlHPIjbLFbnl0JF8zB6xIpRI/ZmD1xWyQAB2mWnDSNDe1l7I5HEsiIfLQZWxcS
 JxelFE7jAY6O0NaYa6erZFivTycn8TasFAzY1hw+xvytrvYKnhMZ7e9DIpaEn3KBdiJz
 r/N4MgQCnDyjyX1Ncl94WEClzL8p0i7Tj4N05O85E6cUHAe8cMKkSX85etWtHaEwK/p7
 JBauzsTHZgc6OVBXAO1UsJ8c3pmXIClLAeCqMPnq4DnIPmKLozCD0GauRHMSzxzqa1nC
 apyS2D6AKiyNlkQGcDa1ptev7+pLebhaWFE5yFBl5b0ZgKzNjG+0lA7d7rnBwwZho/2Y
 KBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618465; x=1759223265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVUbUh+p0V/TFtbOwMijOTMj5DCFHWZt7c1UjlK2bdk=;
 b=bRYQoESgiMYSL096CwatsDvwmpG4izCa5dJOGiawfcFVwtAXVllaugUFWwlbygm/9c
 EKK2TBaqgAZuUowiKUu2N0vM+fVadZ1DfO8y9yQE4Emr6nYUDR6quFMZw6TBESEbLCAY
 dZEpd/CrwZdNtgLSYPXHwSnsvRxmo0UPQ5S31WmrOtJvpbNFN+E91XyQbLcZQUnfT4td
 d7+EoBT7NDVqSxjwaMRnM9XJp8fkGR8TXi/bgnpfuKuhQ5EuuH9PnxnUfsHDSzrakUrc
 k60zESGgvNC5xbigjh+zvqo/upDiqutwT1VIYzGVPBDykFJwHqzR0Vm55SxB83/Vwn//
 1Rhw==
X-Gm-Message-State: AOJu0YzNpX4lGY2tMJ45TbeM/cNVCoN29eaNkHysd8n9w/A9jMoTm9+1
 evYZZ5n66cF2v6fq9gJ0DAg4PKNaCHU/dlhwPqkBTysTXVbV2jzPUwfEU8rM/cUuM2A40i78yuv
 Y0vzI5hQXQ8+eoHdQsmrysU+CXcZymiE/WyOiZSNeSY2QhAoHKgqlzPzDdHseCec0nCJtQ0FKCH
 BGU5gRvPsuBFcKkn4qCtipSSDUfsw8OfXI3ueFJ1wCTQ==
X-Gm-Gg: ASbGncto0AcQmM22XimaXA0yC5EvsKPShg/h8rgKVoWDgQjkj14xEiWTncTnH/SDJhk
 EXW1TjOSvAYqQUyswuNRtBTHsumvAVSvKP2kO+9fYqEiT1ENtG/XG/WUq1NrB5gcMhyNdvxtnyY
 HJls+rJ0ghjTYwuvlEvFUM/AzXiEgpVnKh0/tcdTLFdKdbZISBE4d+w2+7sANAvL42bbz6Bdn9G
 4RXcVg1Y4OXfOiHjjRP18gMu8IHONlZh6qfeOpO6QnO9Jq2vVb7/8MgSQPOjbL54LzXJ96+60xR
 ZsxALwwhdM1CBB6CMBM0w7k5y0rGG9rECmLxJe24JciRp/zLgexybUTZ4hqhqrrehn5Zo/+wJJa
 tLqdJtFPjDKvyq6sDUrGFbFgkdj4DAamDZ2GJ26XqmXLzGanq0HEXp/pVoM/4HpDQ6Po=
X-Google-Smtp-Source: AGHT+IH0HGYt0OLrYmtk36qbGMZhiHT4q4BbXeAsHwFLTf4BeZps/s1OP3xsgpappQTpRTIPnHGIGQ==
X-Received: by 2002:a17:903:32cd:b0:279:b2cf:26b0 with SMTP id
 d9443c01a7336-27cdaa73cf8mr23390985ad.14.1758618464657; 
 Tue, 23 Sep 2025 02:07:44 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269800530b7sm157486245ad.18.2025.09.23.02.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 02:07:44 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 1/2] target/riscv: rvv: Replace checking V by checking
 Zve32x
Date: Tue, 23 Sep 2025 17:07:28 +0800
Message-ID: <20250923090729.1887406-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923090729.1887406-1-max.chou@sifive.com>
References: <20250923090729.1887406-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52d.google.com
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

The Zve32x extension will be applied by the V and Zve* extensions.
Therefore we can replace the original V checking with Zve32x checking for both
the V and Zve* extensions.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c            | 2 +-
 target/riscv/csr.c            | 3 ++-
 target/riscv/machine.c        | 3 ++-
 target/riscv/riscv-qmp-cmds.c | 2 +-
 target/riscv/tcg/tcg-cpu.c    | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf4623..a877018ab0c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -604,7 +604,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             }
         }
     }
-    if (riscv_has_ext(env, RVV) && (flags & CPU_DUMP_VPU)) {
+    if (riscv_cpu_cfg(env)->ext_zve32x && (flags & CPU_DUMP_VPU)) {
         static const int dump_rvv_csrs[] = {
                     CSR_VSTART,
                     CSR_VXSAT,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8842e07a735..5824928d954 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2004,7 +2004,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     if (riscv_has_ext(env, RVF)) {
         mask |= MSTATUS_FS;
     }
-    if (riscv_has_ext(env, RVV)) {
+
+    if (riscv_cpu_cfg(env)->ext_zve32x) {
         mask |= MSTATUS_VS;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 51e0567ed30..18d790af0d0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -131,7 +131,8 @@ static bool vector_needed(void *opaque)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    return riscv_has_ext(env, RVV);
+    return kvm_enabled() ? riscv_has_ext(env, RVV) :
+                           riscv_cpu_cfg(env)->ext_zve32x;
 }
 
 static const VMStateDescription vmstate_vector = {
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index b63de8dd457..c499f9b9a7d 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -342,7 +342,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
     }
 
     if (reg_is_vreg(name)) {
-        if (!riscv_has_ext(env, RVV)) {
+        if (!riscv_cpu_cfg(env)->ext_zve32x) {
             return -EINVAL;
         }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb2791847..a6f60f55ceb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -660,7 +660,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (riscv_has_ext(env, RVV)) {
+    if (cpu->cfg.ext_zve32x) {
         riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.43.0


