Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC255CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjh-0000mk-GF; Thu, 23 Oct 2025 00:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjf-0000mA-Il
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjd-0007M3-KL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso376214b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192932; x=1761797732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qx6kJuJ+y2uonSR6j062ZvpEMgL6rrm991VyMn6kDgk=;
 b=JJGdcNOOG50vs1oBs/4zBwKIbsqm2YI0h/Bzfh+SC2yOcOZP5mYyFRavXgKUjZRnWw
 GkwHAPCcW7O13L8ST2X8xmL2Hh6p5IJx3tVe7AizPc7UX5DVPiFgu1sMm32moF4ed3Yy
 1MuPkKKimHZ3ErNV/K4cfPYqgrkxnp83UuJAh3RmuFbBSQxZtGaLbL56/Ln8xIQKsCE/
 Ch0qyz+KN3hrDvQT50YewjKM4bvGwBn80QTu2MwER2dXx1DgY2ow52m4MDJn35exXHao
 jOoQmL44jBmWimFJXMBsmOiJ4oFOOcMcK0TpVs7EYf6WeUUJWjImzfwcanmc0lMYygXP
 Gljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192932; x=1761797732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qx6kJuJ+y2uonSR6j062ZvpEMgL6rrm991VyMn6kDgk=;
 b=Wu5nRrNTgRawO5dDEiCf6/0JZwdDfak8qANGjTmEGTY8SeFAWK/MoKp0ACg0H4tcEW
 RFRLlEd9mkZSG2PCmJ6+eUTWC7v0XA6JTU5If4MgZ4z5TOx74EE1hdrLYOtwN3BDYfG7
 CJWh1dubpto2jc30IOoiiJWJsU4hs6iEyCaSaUoSY7k5yRDG/Yl3tC1sl2myfNxygbN3
 TKAampI+o08oo7UnmrH4Ylyckx1u1nrQvE32JB3Kusgl3Xz+rjWvwEkA5PDdTKQ8e58O
 1RugQ7BEIvevlpiWcrWNFzZ3IIUUAQLveGpBsQt1PLDh3y+x5qcJNwGK9qg4hK3XTpcQ
 pusg==
X-Gm-Message-State: AOJu0YwSRE0ExHq3LVcrPcP+k1k5g2s/7MwBrzprZjlKNcd+IvtZK/Mb
 yFHGqmyDViWkQvKOF1UhhTvxVQrqK9YtTgoXb16uYELre/F6/fzvD7daz2kQwA==
X-Gm-Gg: ASbGnctlROeJKidfsELRt0myGekYLZuBNKnVkhUq16NFaGeq0Li2m3qxfFDiu916BMD
 d8mZedbmmy3Pluu44CynuiHsRoP1d9QurwQAYbNXLMcLQbfgVCjzWri/GUSpFG61Vm7f5dPFJaq
 vC5XNXZyPZ+onom5/2VCBZ3krkx6Z4l/omHmWncDe8Xd0KNacDgk4Hx1/IZD5YndKgGu6oozC+X
 aQGZf0Unlyzr0P42IMkBdZ+jrxysd06yGVav75Eilq+YJkrKbMzOekXQhgnM3gZ8zjt95SS8nCi
 zgoAzm8OcBQ8nKgME+ynffDfGmyCIcSzDxI5jPnoU3uYrWBo7P0fzvJ1rXceb2fkyJd1X4WAFqp
 Znk+xxEA+G0jAzo3eh4CyDnu4J58sYDjK1JdBbOoxZ+G6I6d44bdbfmAHQi3M9kJf9QGfMPmCxg
 mBk/PUSF9ArvRJNLjqVkn8r8g5HkyCt1yGN2mNOszAtGAV2riLyElYDiWhb3kE4MAkpYTGykhO/
 WmC9nAiixH2lEW4jK7W
X-Google-Smtp-Source: AGHT+IFyAdO43IMfZJ0857VHszrdF6aaThr5V7sOwn1Bf3XhZU3raksQr4RqDZY21HNz3cjyo+gJIw==
X-Received: by 2002:a05:6a00:855:b0:7a2:6fce:19bf with SMTP id
 d2e1a72fcca58-7a26fce2ee4mr3996216b3a.17.1761192931850; 
 Wed, 22 Oct 2025 21:15:31 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/37] target/riscv: Introduce mo_endian_env() helper
Date: Thu, 23 Oct 2025 14:14:11 +1000
Message-ID: <20251023041435.1775208-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

mo_endian_env() returns the target endianness from CPUArchState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-14-philmd@linaro.org>
[ Changes by AF:
 - Only define mo_endian_env() for softmmu
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c486f771d3..6ccc127c30 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,6 +28,20 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
+#ifndef CONFIG_USER_ONLY
+static inline MemOp mo_endian_env(CPURISCVState *env)
+{
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return MO_TE;
+}
+#endif
+
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       RISCVException exception,
@@ -633,7 +647,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -642,7 +656,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -651,7 +665,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
@@ -669,7 +683,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -678,7 +692,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -687,7 +701,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
 
     cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
@@ -703,7 +717,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UW, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
 
     return cpu_ldw_code_mmu(env, addr, oi, GETPC());
 }
@@ -712,7 +726,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL, mmu_idx);
+    MemOpIdx oi = make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
 
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
-- 
2.51.0


