Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D9CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQfz-00053E-Bo; Tue, 16 Jun 2026 06:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQfy-000536-NB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:46 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQfx-00031J-4Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:46 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1812272a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604344; x=1782209144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uj7+crvaZbvdM+fFWGaMWIFUrfucfAhCYwxhtK+khng=;
 b=XOFOsIz3NaWufyemKJdE/9IzkspSclO9EMZNk3wlVdp4b/1p8OhEv46lBXR/rgqQeI
 LLpQvcIo4yC5jkeBdxHQzho4+Nz/RlhX0ULEXxmoCCl/KQAq3OvKy6I9jONgYTp/Tyhw
 vJfXNKiCP4f8Ab6ZNUsfsxti8fl+Z+IeMGn+Ak3rHtcqknsTFCipWVj3v4ZXUNJnEx1l
 ZSZM3YZe5Bq1rtW66MbnT3526I3XWUuQbB7bg8Dvg68leZzZ8VgYEs2zx7T++NzyIOEa
 iEFald6R2GO3z2lK2WPXmHa488VanRJlzaeGEVyyJZ1OosqiTEk6akmug8SFPNkug7MU
 UUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604344; x=1782209144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uj7+crvaZbvdM+fFWGaMWIFUrfucfAhCYwxhtK+khng=;
 b=UzyXViH95xWPrdLcpKcGmHejxVW1TRAWD5Bf217KOxDUgvmv/nm6DWQaL71kl4XIFh
 Jl95P89Y/lsW4Z+6g9JfhJ4EIdDDic+p1zpYDMNfRtF1mf6+gEWaVqHeFQqsV5mFSQsI
 I7QnrDiqflLEofji1EBQiiFqiUDw04s5CbTPHv8bBnbHr1PM7ZUWwD0FbKluY1DqTF00
 hdDHRUVDIUMHDT2a6RJXFHvKbntmdJ5R1+gDyY4+sFpraJd1NFEObBkc8DCetdAig34s
 JEdfB9jy+Dp9g6LbuOF5ljssFtv4iFDLUbpxcuSISK8xn6IsmyO64oK5/8NiPor9zmos
 E6MQ==
X-Gm-Message-State: AOJu0YybJjlsfNOqmXr56z8/a7t73CQCTo3Y3n7RMu/Lg9qtR4DzHE1E
 e7oeYhlmkODF2wX6IrE/Cw5eJsLx1M/AIFB4v1TV1VS0y/q0icuafuM2+9v1kf02
X-Gm-Gg: Acq92OGU0nU3kt6sNIj1/7iiosnQrIfqDQMVnSlcjyjQU2JTmCPLqHHEv/GLvx9/VLE
 thPAgx1wcypYK8Zcu2GL3Ijzz0ARPTV5wIGCPGHC6ePkCG+1/6BuxwMQIHzQF5gG/zPIJH8z4VE
 qpVzjIpH0F+Kyg25mwXQDCkKmr5H/Z3fxvPQmf/ua+ZUXRt5LDQfXZbcAls4yPKvbSMVRejv5ni
 LAqItWxRZhTS+CXbpahaPAOSuL0kfYOzfL4wiLJbzlWR2iFz26PFO2GvLCbiVtqYUigkeAfofpT
 cq7lGOMrZ2FUFicj4d8NPWRtu+a2hk6Azg+GuL6Ull2UjVWKb+0LMtzKSR4Wx0Zb78/6dzzxP4A
 wRWB9RMk6yBzm7irWQtfF8dj3BPttoBSIGsQ52VwRiZc7QnIPd34lCs4jHHXz580VzjrlMccMug
 GO3g6vDbUDGDkk02MtO+9lnDmMLXmfzU/euP30+Han
X-Received: by 2002:a05:6a20:e68e:b0:3b4:e4f6:4f15 with SMTP id
 adf61e73a8af0-3b7962509fdmr16705914637.5.1781604343506; 
 Tue, 16 Jun 2026 03:05:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/83] target/riscv: Align pmp size to pmp-granularity
Date: Tue, 16 Jun 2026 20:04:05 +1000
Message-ID: <20260616100527.1939565-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Jay Chang <jay.chang@sifive.com>

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260520063606.36600-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index a71091a316..8adf7c9719 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -179,11 +179,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             }
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
-             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
+             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
              */
             if ((riscv_cpu_cfg(env)->pmp_granularity >
                 MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
-                    return false;
+                    val |= PMP_AMATCH;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
@@ -263,6 +264,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Bits [g-2:0] need to be all one to align pmp granularity */
+        if (g >= 2) {
+            this_addr = deposit64(this_addr, 0, g - 1, -1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.54.0


