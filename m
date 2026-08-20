Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA16DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtij-0007bS-6y; Wed, 19 Aug 2026 23:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtib-0007IR-Vx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:30 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiY-0003rZ-GJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:29 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso1545625a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197525; x=1787802325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=InDjCg2L0Bovh8ca/Rz0G2mpdBtxcIk8gJadCrq3EA0=;
 b=XkZq9l7HvlYJ6WMK2Z2SbrHUTA50GwW/CczINI80FNW+0jfhLSj3Gpmkx71+N2LCj4
 ynQ80VLIHhlvT2xmJbtTQHwEyXMlcjS7E8hNnOBqJxfL5fWPflESekyGmdMAWQUuLGtA
 Iyugi9Ic7zsDsu/35imDtM04upOhW/80KyuON5GONMCBNdWW4WomVD7AI5IjSbJ8TR79
 XPqlCHoAwWTRUlZqE+XPRlIHQfHRF1sH94pQPJ7GlJPDN/qF/6yYveqYUeh4ujkLNAoc
 mwCH9nnrahn65BbT6LBLacjKE2YLz9mQBXE2pffJ9S6VaAQILE7ryP59fScdObSW/5d2
 4qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197525; x=1787802325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=InDjCg2L0Bovh8ca/Rz0G2mpdBtxcIk8gJadCrq3EA0=;
 b=gUWU5rARKrqe6xxjF7N4lGMUKt1YvJ25EmL+WDdP+gzhmXCuwe0HXI2cZfDS+j9enz
 uzzIomujVTv4BIkkUWi9xaEUG5SlxD2RKaSpKSpVVy3WmbwBjNQMWNvtSPN9pw/7Vkhu
 BsJTaJoL80V53UoMRXpI6jWN+7PKJEKzD+Af5cza+O6cgNhAaMTFcUZauFSJ03zgA4+k
 ogeW2rofEUa8tIVKImIly4xGTbhIIFiWL0dJBH3vfiwKQRS8C7f9iShXelAkhr5Q7deW
 Sk8SZhHafFg84kihTXrKt7y5fGVfusDgrno/VTmyZDGoltPQozCvRdyaTJm7S+9RxRfr
 KWVQ==
X-Gm-Message-State: AFuF++lVzSr8o8rhcbUdCY1PpS4Z8QKx4wE+oblSREdqhalxyehTMQVH
 5hYmKoxZJ2mQXtIyyE3/pGeSsdzcu2sdNi+g+tnIMAPJodmCdHf8tIZ7Q1zVxA==
X-Gm-Gg: AR+sD11VZlo688DVy6qawBgk6OBYixPk/LGFx8vYSN0VkCvn7Sl355Mpz3jVconBnzK
 rt5nyok1Y71+VrKcnSUh/fa1fWMXN6S9QFxtKLpptAXFN1AuhqFg+FRIfmMGV4Ty+F7vxAUlFlI
 hydzpFX2MyJomU3HBwNrbbVDg2fdGQyv0ARQpWf8juHkIo3l5dNrCDry2RFz4YS4bw/GdGyI2fS
 ZSr6IhLRdt+0dqhjQwUzYyuBy9AaCtAPADj671Gv+Rm8HKBcc8PxQwnUB5uZ+YfxVGn8qsNCWqW
 llBiVZAcpdWzu9PwfsuXuhouPmd3xEs0yrckAzNQ+uCOvxOU6B6aoqjqftroVsxN+WwT5f7U+bR
 mh3plXkq+rspX8ZD2MmEaLo9UtAHV0CQyCcDJ/zeUlO02y/YwqbMRcA8enyUMJHMgYvC/Os+DXC
 e9O95UEqGoCh4wBCj+EqWz0TzdUPvk1YctpnsdH+oKlbGid/9Xcop5xdq4iY/uyc7fERKTMD7j2
 flJtQ==
X-Received: by 2002:a17:90b:1e53:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-39580ecefbemr16926273a91.1.1787197525118; 
 Wed, 19 Aug 2026 20:45:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/93] target/riscv: use SXL instead of MXL for read_sstatus
Date: Thu, 20 Aug 2026 13:43:11 +1000
Message-ID: <20260820034430.1186695-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Abhigyan Kumar <314abh@gmail.com>

According to the RISC-V spec, a 64-bit system can have M-mode in 64-bit
with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In this
case, read_sstatus should use SXL.

QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This was
because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
the SXL field in mstatus can be safely modified in M-mode and
read_sstatus correctly uses SXL not MXL.

Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260723142254.1683113-1-314abh@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc5..a90449b87f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2067,6 +2067,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
+        if ((val & MSTATUS64_SXL) != 0) {
+            mask |= MSTATUS64_SXL;
+            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
+        }
+
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
             val = riscv_write_uxl(env, val, MSTATUS64_UXL);
@@ -4014,8 +4019,8 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mask |= SSTATUS_SDT;
     }
-    /* TODO: Use SXL not MXL. */
-    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
+
+    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.54.0


