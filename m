Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9DCD18153
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0T8j-0003jQ-Du; Mon, 14 Oct 2024 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t0T8i-0003iU-5f
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:02:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t0T8d-0006UP-NR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:02:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so3522552f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1728943319; x=1729548119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JdDoRc6lQKD0tC2G2LkGtaHLsrOMaDAUB7oKyb4cqs=;
 b=eZXOYL5471YL3YwUoBTRrkITet266peYDLRMI33MEl//FANF4tI5GP5PnQYSIpTXJZ
 8pIEvSKYLzf/Pgx822B6kqgxjMfMRaNvqJjvaibR+ZUApCfM2kfMCS5h9uaavgGF2n0L
 WssMWqCn5relt5xddzh7J/tztCh/g+JQ4pjkZ/Bj58f0mgWO9ycE9GYLECwA1O+b8u+P
 CIK6igkc9ni2Nm+dwOVhTcCqG+4bC4hv9CQn/2OFezPkn6HexCzhB8A92B1u8pbqirlC
 h+hc1dWyj3tflB1A2NOt/c4aX+yYOvVMhUYm8tr8B2Z8aRFf+qyIvcJ8zRMIDr6d+0Xu
 GXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728943319; x=1729548119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JdDoRc6lQKD0tC2G2LkGtaHLsrOMaDAUB7oKyb4cqs=;
 b=SOIEy05RDpKTmcecYG4RKfTlm4Ws/SpXequE7EG/GH615x5HAveP2RP625vOEfU7MU
 gFY8zhtji3PeGwaZs1FXIkbxcMK9hHIn5EKbQyeuC9I7l9CtpS81uwoL+1BO8upupqCe
 hjgemkfeX1fzbfPDAOxCxP/9CLs4RGNqGGyEyhtNZ8jbnsu3uBqEnkXE6xz4Hs8xvS8B
 3SGJGWFfT7J0OwffqrDhaTyx1I0nHYlE61FZ/rot4dOEFbJmnByaOt52QltfgNcmhG8P
 O5xYJm1w4CZgQSCp9OcEdjs334yOEzBBIz9zybXEmivmmz4RulRItm4fdY7URMVgNq5S
 DnYw==
X-Gm-Message-State: AOJu0Yx4kfVzLXWZ2HBDzjp6dqqmGNzxk6L+aLaKfO5V+HJWazXsj7BA
 bGWoObv7fmSIAqR2UFXpkKBzNE06DzBrKHUkJ8jrsje9GE08KvSCXD/rKLAfXXk9JiMyw/4XVkX
 5CVE=
X-Google-Smtp-Source: AGHT+IHKvqkygu2mhti3SKjm2nAri/XQh526pSaaHfjmbjO8WNj5rySGeWAbbQxJ/80FKD9lN+DMXg==
X-Received: by 2002:a5d:4fc8:0:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-37d5529bc9fmr9030781f8f.49.1728943318859; 
 Mon, 14 Oct 2024 15:01:58 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:8971:afed:16dc:a06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a09dsm22769f8f.23.2024.10.14.15.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:01:58 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC v3 1/2] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector unit-stride loads and stores
Date: Mon, 14 Oct 2024 23:01:52 +0100
Message-ID: <20241014220153.196183-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014220153.196183-1-paolo.savini@embecosm.com>
References: <20241014220153.196183-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x42a.google.com
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

From: Helene CHELIN <helene.chelin@embecosm.com>

This patch improves the performance of the emulation of the RVV unit-stride
loads and stores in the following cases:

- when the data being loaded/stored per iteration amounts to 8 bytes or less.
- when the vector length is 16 bytes (VLEN=128) and there's no grouping of the
  vector registers (LMUL=1).

The optimization consists of avoiding the overhead of probing the RAM of the
host machine and doing a loop load/store on the input data grouped in chunks
of as many bytes as possible (8,4,2,1 bytes).

Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
---
 target/riscv/vector_helper.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4479726acf..75c24653f0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -635,6 +635,53 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
+#if defined(CONFIG_USER_ONLY) && !HOST_BIG_ENDIAN
+    /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
+     * better performance by doing a simple simulation of the load/store
+     * without the overhead of prodding the host RAM */
+    if ((nf == 1) && ((evl << log2_esz) <= 8 ||
+	((vext_lmul(desc) == 0) && (simd_maxsz(desc) == 16)))) {
+
+	uint32_t evl_b = evl << log2_esz;
+
+        for (uint32_t j = env->vstart; j < evl_b;) {
+	    addr = base + j;
+            if ((evl_b - j) >= 8) {
+                if (is_load)
+                    lde_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 8;
+            }
+            else if ((evl_b - j) >= 4) {
+                if (is_load)
+                    lde_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 4;
+            }
+            else if ((evl_b - j) >= 2) {
+                if (is_load)
+                    lde_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 2;
+            }
+            else {
+                if (is_load)
+                    lde_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                else
+                    ste_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
+                j += 1;
+            }
+        }
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+#endif
+
     vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
                             log2_esz, false);
     /* Probe the page(s).  Exit with exception for any invalid page. */
-- 
2.34.1


