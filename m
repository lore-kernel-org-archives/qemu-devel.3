Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965D2CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjH-00065R-EW; Tue, 16 Jun 2026 06:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQix-0005zr-1v
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:52 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiv-0003jP-Ku
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:50 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so2126835a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604528; x=1782209328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCtqoJPvTEM7pcYWllSHBKBt50VMDfpPmDLSixCvOHY=;
 b=onMKhC6DEDwQVfr/VGSt60cVffLaAysx8ILUClsSqFpuFJ5AOxOsroXlM5+3LysUEg
 ivVpHmuPFmpWleurYL7l9DJci8/SZAySHj3wxTbKV8SpzrP3eJnKUwtxzNtdErP+mCvS
 D2vHvkriZVLWsyo1CzpsE0ITAeYDxS8KwMv7y+PZtt/eb90VhEWVCaeX0SVBif9PXlSr
 29fGoIbbokom0blZLkKINZffrJCAsLOUELKDTay/6WQgq1lN4/cVjXdiyP0VjEeW30BF
 Bt5AcTfQC1Gf49UEaj+6+oSbKJKgxM/istO58LSxpVrx4RpDm29mpEuDbaJQe4MUl8pu
 PDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604528; x=1782209328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aCtqoJPvTEM7pcYWllSHBKBt50VMDfpPmDLSixCvOHY=;
 b=PkOvVb2BSQBVc8cm2rO4Km1taf+hDOLo552izgz19TMDW16kPkHyXO+yMJeln+TdKj
 2qsV8xiPOeW4N5gI8Qp4SQFco2XQqZK9+u+IZax+Yz8FHN5DS/fQutGjndTxwQN97ALQ
 8szGhmWsVTLxCsx11w4yhsaEh5XxYT9SQW2etEUH030D6KxkobOd1woZqmRe4eec7t3b
 TbJlNL9Q0PlonVV9UCICpXOU9VQ6f+w4ixmzaemThrbWHyq5o+UORJfRUdzTbEKyGIS3
 VM/amtgXbJwKHj+PYwvvZ9iQ5RZMp+aJX3h9Y+08dedUDa1LbdbzF5nKP0CptqYfmibI
 FjuA==
X-Gm-Message-State: AOJu0YxDjJiDZkNUhlvNgRuxJtyq+YhfJnlMIpLUu1D2igLuIBP0k07t
 6YH7TJP46IsUJ2V1ZtYDeYKilo8n1WFZLchPAQ5UJwNe01X45Phq/MiiMmv2CS71
X-Gm-Gg: Acq92OEh0H+bZlVlIcXMgwMpwc9W4NsLx5xB8Jld0MwHta13rPZh+rQ2GZAai/p4Aze
 PlR2TPZutZQFeYuWCSruR1VmpuDFMJS1xSvxXMXgZ2nHvbbpenyHpXIxAQruHuCZuQlTNJdFc25
 vjalD0LtMz+LMu4c3q364uJIgJd4Jay3W8uVxOYtKR2e5I9YZAho2RNK9CElwksA7YMhUuKEa3Q
 ARLU0X3AOCao6aVKNadU4JytguP5CM17f7g0x4Oqu66O5cUo7ofmeun3DVXdgY1/UQHOy1Hrx4J
 5haDZRaqLJTLSEQIjQFzgTZTLleVE6ckVJlQRvlUD3ORk1GW0BTzwq4Sc5TOCb0sbasOFmUbsPg
 yNj5M1vGns1CFlqZTqKG7gqIbVOt/PBQACkdDl8DxLEG8mT+MXZXzu6HHD3z0fuEG8w4+1+xXU7
 Tup+tB5LIYdvX+gNOWgokHJ0ikK7IBn5vYEQVvN2ze
X-Received: by 2002:a17:90b:17cb:b0:36d:b818:f848 with SMTP id
 98e67ed59e1d1-37c5280311amr3047968a91.5.1781604528026; 
 Tue, 16 Jun 2026 03:08:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/83] target/riscv: Print privilege level and ELP in
 riscv_cpu_dump_state
Date: Tue, 16 Jun 2026 20:04:58 +1000
Message-ID: <20260616100527.1939565-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

The privilege level and ELP are implicit state (like virt), so print them
out.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260529053519.1224019-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index df101b1213..a5b1c2ba62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -577,6 +577,22 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
     }
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static const char *riscv_priv_str(uint32_t priv)
+{
+    switch (priv) {
+    case PRV_M:
+        return "M";
+    case PRV_S:
+        return "S";
+    case PRV_U:
+        return "U";
+    }
+
+    return "?";
+}
+#endif
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -585,9 +601,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint8_t *p;
 
 #if !defined(CONFIG_USER_ONLY)
+    qemu_fprintf(f, " %s %s\n", "priv   =  ", riscv_priv_str(env->priv));
+
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
     }
+
+    if (cpu->cfg.ext_zicfilp) {
+        qemu_fprintf(f, " %s %d\n", "elp    =  ", env->elp);
+    }
 #endif
     qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
-- 
2.54.0


