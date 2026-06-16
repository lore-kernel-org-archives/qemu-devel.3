Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81172CD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiR-00050s-1E; Tue, 16 Jun 2026 06:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiP-0004vR-PT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiO-0003bl-3R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:17 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85893bce34so1813190a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604495; x=1782209295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4OxOYo/AGR6vOtP7Q8aQq8DU0Ortkt82PJXFt1tv7g=;
 b=ThlSwzufZTwk6+qXFVWRGctINxGWTszIrqDKte3/hmN/PrkHK5OqeD0IkPg8HayTpt
 Eg+21ZKSaXySYrX0reJ8jnnWjQ28lQzy6q4fq71E5JYEDrW1ZT5ygGfo97xMxo1z2pbp
 Q81uneQ1QTgAjc2oq88jyWt2HNw+Qkyo/MFdCrzQSetQddNXrBNIS8Hw2B2OGZi+0QWS
 ab1dYJgxnE5hSumTGSXXAK2Jv+ID/t3LWq2AFmO6C030Yu9tC1jA+jZDa4NsICEFmhe7
 eRdhR7fOWktbpw6shqOjBKYH/JwWDKmUAzzvSlGFcTLvu9+JDPkYdBBMuxQ4zzC0GXch
 VRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604495; x=1782209295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j4OxOYo/AGR6vOtP7Q8aQq8DU0Ortkt82PJXFt1tv7g=;
 b=MyL6R9BzTTTpujScpDuBKvTw9ORfBaIZGb7kehukm0QcEkoyC5U1Qou/5c+P58prim
 dbibjrkVwYT7iQ+pUSGgnSV7hT3hKY+QXFrhjjSMqLdYOZT2WJ3bwXvjpu0hvcsQWAWQ
 pjGuWK0NtODNQA/kmcqSx725PWvbOOedEuZAa7geTpXC7tvcYZ8Rb5eudehzDnZOJrmE
 OFm2f4ad1UvEa0PBYufJBUoD9wnj/NB/YFmmyv7Ru+34mpqw8bzZTd97iXe1bw5fB5yr
 pza9Ts7IVRnKsePj3a32nGe5tUrGRoOB8mdWzq8aeURKmNryDD+hC6MpZyzyCS0OTZfh
 S4xA==
X-Gm-Message-State: AOJu0YyqjyRuh1G9dYjZ2KU8vqFCGAEko6Wb2kUR+wCX334YbM9960Th
 qK6Vev6qcUJz5Q37O3A1HfWK6Iyk0+nAqDWQS04hge+poSl0GscO4YQ4I4zogEJq
X-Gm-Gg: Acq92OGgEFQFstJ2Qwi393a0IZa7wggJS8jagiTR7c6u3OvZagqkzCommUgdthDmk4J
 phWvboic9lN1dh07bgi6gIcxb+W89kYLtMNKqtbS4eLsdLze1ao5nyE/Q3KFyvjAXZmxT44moCz
 Xu3PNe+TphsW8yeecFkbZ1phgbp9xuZOgbIekmeCu+tO60jr1pqqCLZEPlFUnMgdf9V4M0l3hHQ
 tGlNFUCRfl5I9P2fWebMuJh7MFaTe133O6lRXkqmYPKVXMelDE3R2FtU69earRqJGLKd0GL0GiK
 8pFJ2hgwGHBoPSANWiE1QdofPEdF6yJoPPISUMl7qbESNyM4smUobqfF9i59lUMrAn/dxSDNsCF
 KcPOHL2rPljWN+kgcii05lwu/tMwjsunJkBkXBORjH8t1quzhYMyzzsenqCFbN3XU4Bmb4bIAM7
 GLG5wUitg+kT4bDvsMA9tMD1lGzaoZATiekKEh79Yo
X-Received: by 2002:a05:6a21:4d8e:b0:3a3:17f8:bedd with SMTP id
 adf61e73a8af0-3b7962bc4b9mr17033785637.17.1781604494540; 
 Tue, 16 Jun 2026 03:08:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 46/83] target/riscv: Fix page table walk endianness for
 big-endian harts
Date: Tue, 16 Jun 2026 20:04:49 +1000
Message-ID: <20260616100527.1939565-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

The page table walker reads PTEs using address_space_ldl/ldq which use
compile-time native endianness (always LE for RISC-V). However, when a
big-endian kernel writes PTEs via normal store instructions, they are
stored in big-endian byte order. The walker then misinterprets the PTE
values, causing page faults and a hang when the kernel enables the MMU.

The RISC-V privileged specification states that implicit data memory
accesses to supervisor-level memory management data structures follow
the hart's endianness setting (MSTATUS SBE/MBE bits).

Fix both PTE reads and atomic A/D bit updates to use the explicit _le
or _be memory access variants based on the hart's runtime endianness.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-7-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 430378490f..e5653a5730 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1370,6 +1370,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     target_ulong pte;
     hwaddr pte_addr;
     const hwaddr base_root = base;
+    const bool be = mo_endian_env(env) == MO_BE;
     int i;
 
  restart:
@@ -1418,9 +1419,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
+            pte = be ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
+                     : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
-            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
+            pte = be ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
+                     : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }
 
         if (res != MEMTX_OK) {
@@ -1679,15 +1682,15 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         uint64_t old_pte;
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
-            uint32_t cmp = cpu_to_le32(pte);
-            uint32_t val = cpu_to_le32(updated_pte);
+            uint32_t cmp = be ? cpu_to_be32(pte) : cpu_to_le32(pte);
+            uint32_t val = be ? cpu_to_be32(updated_pte) : cpu_to_le32(updated_pte);
             old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cmp, val);
-            old_pte = le32_to_cpu(old_pte);
+            old_pte = be ? be32_to_cpu(old_pte) : le32_to_cpu(old_pte);
         } else {
-            uint64_t cmp = cpu_to_le64(pte);
-            uint64_t val = cpu_to_le64(updated_pte);
+            uint64_t cmp = be ? cpu_to_be64(pte) : cpu_to_le64(pte);
+            uint64_t val = be ? cpu_to_be64(updated_pte) : cpu_to_le64(updated_pte);
             old_pte = qatomic_cmpxchg((uint64_t *)pte_pa, cmp, val);
-            old_pte = le64_to_cpu(old_pte);
+            old_pte = be ? be64_to_cpu(old_pte) : le64_to_cpu(old_pte);
         }
         if (old_pte != pte) {
             goto restart;
-- 
2.54.0


