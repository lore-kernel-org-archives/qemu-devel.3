Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EBFE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFu-0000oD-GJ; Thu, 19 Dec 2024 20:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFj-0008J6-Q2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFh-0004b8-Vn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:31 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd2ff40782so1212934a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659788; x=1735264588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpxyP5OtZx1/7mNrIEtgT3kG1pw2Ci9w2qc+YV9JYFc=;
 b=f5+gR97jY/rDRbXsnWxLUD7ijdEuS1joGXBtXY6fXcZJ+yin6lZNu/on7RTwJYk4Se
 XNMpTLcxl6ZQcys2/q+snZf/xh1B9ZQIIvPzM80i7OoM4LoZEP3MAzH9QD1fsMOW92dN
 eWjFO2WzGZqopG3Z5UEBE5cu8C/PmVFZRehy2y+cSoozWpW06zUXp6YpadV1V1Dxz3G1
 DT4qsgcL6cFlU20endNj4etnW+mmSmxgcRDdtKItGMT3Pu5RLj06RhDMsq1/Ij5DqBfN
 7minn8TY5FspuqxfxBgfX2X4OJTzueUy9rq2e2hONQlynXkVO0F4yLEHd5CUg6qsIYUY
 ZT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659788; x=1735264588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpxyP5OtZx1/7mNrIEtgT3kG1pw2Ci9w2qc+YV9JYFc=;
 b=pyG4IB8PKMMydBbt5FLmghF6iF+LJ7khOnsmzx1B2wBAuZuP6sESWuDdJoCiQ4Eaq4
 JDzboXpdIRBW2qdT46sKLd33Nkb+MRk+FUIzZqpDuMLnjxSRP5KWD8yaXz6wDzKMPODl
 nQyWSG8uBUA/+i24L1sHgQpPRPaVbrB+aFYR/6Cbf9VKkNn4I71lSA279IIDz6iq997Y
 5+iQh2V9ot6wxrNEZzIH0ZRJ7+vFmXXAYjtPmornHA49dqCZZ+XBnc/buImWOw4GY/Kb
 6cbT9ealcoEZWE2qMhQcthw08h3R1sngo6UqA5Flxhr+JZJ4OYzZ9DER/6VGw/mbfjxV
 S+qw==
X-Gm-Message-State: AOJu0Ywm65C17wZQasYYTNZbwggiSaGiapn6z8GKSuGm7w3J3ZmgnHsA
 GB54kFFvtHLO5HuL0cgOxAqzkdNpJm3ZaXr5mLXhmCQmnX5A/f7kABpg8MJ4
X-Gm-Gg: ASbGncvpLvv7ncAJRmemjPzuGzGFOmVw3OUwSCjh3DMuRvlq2oBJIqrXi0JBrle+bDL
 H/qE8u+tIQvVhI1UYa9tUQ2VvICqBvxsWqCW6/T7J/XZwziGGCkdWeEDaCtj/LpPxKz37spdl43
 60BswRYIcE+z8A/4ZMONCniNQfi+FLRw4m59rrQXafeAshvezTjHfxvT15ebVi0ZK9QcdISwGU6
 y8uR9qfCBq5He3kHDPIgV0zikWiw1B+xGH5UhtNgKXEPfQ+nilUyQHL0Gjf3fNWJpY+vBt/L9kf
 XhjBv2g0n5Ys8UCqKaoB68hnW/ZMc6/uFQuJdK7CUZEtMd7mnQaMF8Tmfxb5PeQ=
X-Google-Smtp-Source: AGHT+IGyIQG2FfK6u80cuJJDQLC/tzoFQeLTTSwCZwKxEpIwul6Fz4TAuK7tJurT2wAfKYQK0nzNww==
X-Received: by 2002:a05:6a21:3a44:b0:1e0:d6d5:39c3 with SMTP id
 adf61e73a8af0-1e5e043f6b3mr2407423637.8.1734659788117; 
 Thu, 19 Dec 2024 17:56:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 31/39] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Fri, 20 Dec 2024 11:54:31 +1000
Message-ID: <20241220015441.317236-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
value will be masked when the svukte extension is not enabled.

When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
do svukte check.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-4-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4b9f899217..fe4e34c64a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -604,6 +604,7 @@ typedef enum {
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTW          0x00200000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HUKTE        0x01000000
 #define HSTATUS_VSXL         0x300000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1936a6f32a..b6fa8ae53f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3540,6 +3540,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    if (!env_archcpu(env)->cfg.ext_svukte) {
+        val = val & (~HSTATUS_HUKTE);
+    }
     env->hstatus = val;
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
-- 
2.47.1


