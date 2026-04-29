Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8F2FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsK-00058n-5f; Wed, 29 Apr 2026 00:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsI-000501-E6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsG-0000PC-0v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so72267465ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438211; x=1778043011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMpS+oxPJGbRpex+VelLT6bbUjNH9wP4CLelzYLvWOg=;
 b=rmD0JejQu8AW2AthOjFd6LgOkAMBv8tsp/2BFseC3dwGbpKE6eiZDx+ZaNznBXaDyX
 VrpXdZbmZdVCYaLw2gXwtV5eeoVhYSeVJXzoJX0WBVpBXx8sHzky6qGL+Ss156WZvfQe
 Wv27oaCsAOQiPazRLI0y+pNl8KaymTMIBSLwScOVciSysdVwg3TVy3jsjjuSnHgnxQq2
 ZsJ/omd6zo1sLgMCAlU5RiIP94FvcjUhluPJUv1y9UCsmwsw2czHscMuyy2dd+RmhGvI
 TOxX22077jRT5EHilXBZjEw6acFKaW4duCE+cgKv3xjygNwQOZmpEHxEN8Tzp046JTxd
 j5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438211; x=1778043011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMpS+oxPJGbRpex+VelLT6bbUjNH9wP4CLelzYLvWOg=;
 b=USTQA5Exb/WwEFo1cMBITsomm01Q8f4/MhRzUL6MFLXyJtggRWxulHYHJHuObpb+ie
 Saj8/zmg6AoqlybLZA0R5culyHfhDMwxb294y7vYiccr9H9I1hU3HNSTQD2lcys9SxLh
 shEsYYprP3NNNJLifszgHefIgl6P9PWeV9wMbZUuBZG3YiMfWUfrvaxAxQJSYjEsQLhO
 A1R6i6CjzvuHDjV00APNSePSXNxgdlxSWx27If7ui8ci93k9+S7HfjyqVPZnqnZhs+KL
 MDz6dcWrcUIOZr5kAPr0mITwUoi05/63vfyXTPh+cJIoE5nSQVNwDKv6gTrmrsST7hFt
 Mk3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5ncJ8ql+TVGcQvJp4650fdGOlvSNWy4vyYkLyqGVmhuGlmIzbuRKHJJ1bypMvHNRrl7fUwQQk6Vn8@nongnu.org
X-Gm-Message-State: AOJu0YzWJOyWpNB8jE5CJEnmaKJKoetsJ4ES+q17yuL1XjyAtdq5EZAd
 Py3cYpQkbWTzXwGgEG/D0aiZrsW/6xbE3gc3AI694EcdPpNKwP6ZJJT1
X-Gm-Gg: AeBDiesEU0aNx6nxPXU3rrwlwt1w1af0BF0QyIJE2pcM866/Igu6V3J2pYKBc3jtBJ7
 nWLLN+kgH3LAfri6lZn5ipW1dnF6s8b16TYCLinY7BfWQ6jKeGRFQJMxEqbsriDsDTnbjI02RXR
 x0HlRvjtHnN1IZyKZ426B/CkvkuqogLud1G7s7iIkMA7MeHI7Th3ezY/jtvnfLJkNNHbTYMW5R6
 NQ2Tx/8XiPH0nUWZuN4FtEHKiWwl3LNbIfCAKxYqHz+ghfkJTGrm9xDyOISpQCYxRqMxQnOmWE6
 x0I45AavT/pKYLhiR04yCa7RhGUwIsARoMGU4WP5qj2fV08PrBvo10FZqcIAfiPAZWSewsviuj0
 H9FsaK4MPExlzIQMBoX/d6Wcg+m4leO4x6HS6gnK1e0iprlmZ0dsLoQr0WyGlOtOh25ypbnW9uW
 VFboMqN0rCSY/hbcv/+4gYT2kV8kXdEehnvKuseMX5bc0dvuTMyAq8xR3kDQLaQZU=
X-Received: by 2002:a17:903:2a8b:b0:2b9:8e63:71c8 with SMTP id
 d9443c01a7336-2b98e63730amr751005ad.29.1777438210678; 
 Tue, 28 Apr 2026 21:50:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
 qemu-security@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/51] hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
Date: Wed, 29 Apr 2026 14:47:25 +1000
Message-ID: <20260429044752.4176397-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

The MMIO read/write handlers index timecmp[] with the absolute hartid
(hartid_base + offset) but the array is allocated with num_harts
elements. In multi-socket configurations with hartid_base > 0 this
causes heap OOB access in the QEMU process.

Fix by using the relative offset for array indexing.

Cc: qemu-security@nongnu.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260401053853.10473-2-sebasjosue84@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 9c1491bd04..e27e5fb394 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -131,6 +131,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
+        size_t hartid_offset = hartid - mtimer->hartid_base;
         CPUState *cpu = cpu_by_arch_id(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
@@ -138,11 +139,11 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
                           "aclint-mtimer: invalid hartid: %zu", hartid);
         } else if ((addr & 0x7) == 0) {
             /* timecmp_lo for RV32/RV64 or timecmp for RV64 */
-            uint64_t timecmp = mtimer->timecmp[hartid];
+            uint64_t timecmp = mtimer->timecmp[hartid_offset];
             return (size == 4) ? (timecmp & 0xFFFFFFFF) : timecmp;
         } else if ((addr & 0x7) == 4) {
             /* timecmp_hi */
-            uint64_t timecmp = mtimer->timecmp[hartid];
+            uint64_t timecmp = mtimer->timecmp[hartid_offset];
             return (timecmp >> 32) & 0xFFFFFFFF;
         } else {
             qemu_log_mask(LOG_UNIMP,
@@ -174,6 +175,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
+        size_t hartid_offset = hartid - mtimer->hartid_base;
         CPUState *cpu = cpu_by_arch_id(hartid);
         CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
@@ -182,7 +184,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else if ((addr & 0x7) == 0) {
             if (size == 4) {
                 /* timecmp_lo for RV32/RV64 */
-                uint64_t timecmp_hi = mtimer->timecmp[hartid] >> 32;
+                uint64_t timecmp_hi = mtimer->timecmp[hartid_offset] >> 32;
                 riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
                     timecmp_hi << 32 | (value & 0xFFFFFFFF));
             } else {
@@ -193,7 +195,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else if ((addr & 0x7) == 4) {
             if (size == 4) {
                 /* timecmp_hi for RV32/RV64 */
-                uint64_t timecmp_lo = mtimer->timecmp[hartid];
+                uint64_t timecmp_lo = mtimer->timecmp[hartid_offset];
                 riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu), hartid,
                     value << 32 | (timecmp_lo & 0xFFFFFFFF));
             } else {
-- 
2.53.0


