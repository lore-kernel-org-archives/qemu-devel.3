Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F449D2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 13:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAU4w-0006go-Gt; Mon, 11 Nov 2024 08:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAU4t-0006fj-Af
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:03:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAU4q-0006Hu-2e
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 08:03:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so35867105e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 05:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1731330210; x=1731935010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8yDKyWbmtFqQm/1q6UNx7fp/2A/xfLVE88F3Uo7oZw=;
 b=SCavKtul7SSZuMKRpZwuvl3dpAlkzX5Q7yEk2Jw/OKS6mNtnv0mFmrGISCTtp67Qug
 wcOtmnGJAlnIOHGrufiI3tPiLfuW44GX8hQSnFQvdqB6nOvVkbOHQX305XNUvNQ9hGH3
 tX1zkZ6fyGl9dzztYYdz9r0Ca/kUQxNmmwOs8UH62E0nPcXf2sHIYl54Vdj7yuZD4wGa
 mh0NSG5yQHxu9zcvukITtVRD2nms/GsIPTKzSMBp6/z1KppqSUTHqlkVaVYNUAo5pLcD
 iG1VQJQyplIcZkccmvSUgFffFNs6x71Jvn58MprQpPkk7NXIv9qVmZuNqauvgu3xOFGh
 slpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330210; x=1731935010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8yDKyWbmtFqQm/1q6UNx7fp/2A/xfLVE88F3Uo7oZw=;
 b=ZN8YU6gGZ/ItYF4Ca5IUgCb4J341gOTnLfaCTPW+hkPTotB9nWKRZoTZuTZdcOb2tn
 p90MMduKo87pg8bepFXZmWOatrXq0v1lvQeDHkZw4UbDUly7SEsiVfcAh+9GsMZYqEW/
 rRALX8b+NNjP8h25y4s1rX3MZo3xqce7YZgaZJfI4qW15HmUjCzZ5RnbIYIJ3heG25nS
 W7MloQXJBe6fyqATjqic2g9ub2C53qBImUrEcACDrUCoHRHgrdLER2CFACAgboHakDAT
 yaEhAWn5pjhgilQevIGS282wgCLBkVmO9lXkqDt2HHAT2TkzGKaituHr/+h3rsHbCMRh
 Nr6w==
X-Gm-Message-State: AOJu0YwaqHxi4nIYnfCso6g9P0OT1fYdgDryHxJRvav6vIgJTp4cgGCB
 DeCWbbC4Y0DldLMFBesANwlQCls1LGTMez9QUeKlWWpNhmQ0VffZvXeEyafukRJQNOuUwlk3qIz
 vl9c=
X-Google-Smtp-Source: AGHT+IE1kZQhXD/1pNVPJ1rk7eJ9wv2mv2SAxobLM0OhJ9iiV9q7t/XFjb3rNkZ3Had9gtIuv8C+aQ==
X-Received: by 2002:a05:600c:3584:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-432b7501fd3mr107860165e9.13.1731330210035; 
 Mon, 11 Nov 2024 05:03:30 -0800 (PST)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5d1bsm178611505e9.40.2024.11.11.05.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:03:29 -0800 (PST)
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
Subject: [RFC v5 1/1] target/riscv: rvv: reduce the overhead for simple RISC-V
 vector unit-stride loads and stores
Date: Mon, 11 Nov 2024 13:03:24 +0000
Message-ID: <20241111130324.32487-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111130324.32487-1-paolo.savini@embecosm.com>
References: <20241111130324.32487-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x332.google.com
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
Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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


