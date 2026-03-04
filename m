Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95328EF8FE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEo-00077z-A7; Wed, 04 Mar 2026 08:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEV-0006mr-6t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:49 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEN-00024a-Vt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:43 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8274936d2c0so6708794b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630736; x=1773235536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwo2mGlgucBzz/3KcYV+Wa701gredCNw/WgnkGdXA5Y=;
 b=mYNLNtcpoknYB3ecmT372Qyce8LNFwaAAzpWHH0pHnmHJ/ebXp5yruIOmWYSFXOoAA
 AAOqg9fLWsYvldQC9WKLCJWIMqfOHIZYW0NkTSXRouuIRzde+Rwae5Bbhl/0pnC1uKHK
 F5QUVwAll3/VA0Jmxcb0nPmUYWqOgCanbLM/l3scU6m6RoOJGrx35OljsxUFsbGKDNlC
 cOZbjegdwCgqpMqQqoxJwYFJPm32R1aLw4jUvDqICdJRpraiAZwfIdAjstaofSfCXlHu
 yXLU4PaVkT8arQlM4U/3jWhZMZVaoX7Jqdy9L96s8rvYidFg3sg2sKbUZYAUOmuanxlc
 meRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630736; x=1773235536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zwo2mGlgucBzz/3KcYV+Wa701gredCNw/WgnkGdXA5Y=;
 b=iXju7FG4v3KJh+yCtktR1xWOnnmYPL0Fr++Ekr1WRfgIjcJd0nyi2xtbyBH+VKMsXd
 7JhWnurAxVcLSfJUPBKYJcXBRB3FB3YjT7RVaCeKoEgIGh54a+LXI+yRRlD1F/o8UOTu
 1HKKckKLt7ANkgHpxrR2ozZ+BsVz4jVhmjpfdglzj6bJefBzgoRmn4HqWESsVwC+/KOy
 Shk3Ean+jVPv3SYNMusros9dfdUP2YENsbWIy0TtW9NB1vuysJ5+4nwFSmuGXjJJ9lzi
 soo+SGoayq974ykHLJFJASPHLOLCvgWeNrqs0nVSasHA84FHV1SSINh7TAq8fdgOy97V
 /dGw==
X-Gm-Message-State: AOJu0YxTHpIk56fczoslJuCFmxfwCc1RAlp6eUmsCxKD1Cgn9F1ZTkz/
 OZ1NoPUPFxXnB9EnnSrCxETfUiyxI88Qp9Y5ojY73HMFHMw1H8YV0cS8MnrduAzijSCE6UbH/VF
 CkOn/xvfJ1OaUirLRzG11ZowruypUbCWD/bay5U8BoXE149i3TFGShj4HHTx6gP3QNdIlDSRgbG
 mC/ucb8Hz7cVOGqhyOI9DpcGhuYq6YXz6DScsFQEaPzw==
X-Gm-Gg: ATEYQzwbDh+ueg+vOjXbs1Xu7+q2YhXs53+ESa2E5x9rcDkCD1Rug1rZEmM+FXxHE7x
 75DPhWwd/WCEQev1nzVw/NoUfX3GCfBkuvVOYkEJVNXm1031UODViD6Px4fUfYnCAWjDHEqSOm/
 169ExRZqH7ccU3GszXluy2mFxuP/s4OQWoZloOGKJYXLIu857UG0H/GdsK4RV/9pNtOqk53c72r
 DK8GncYEi+4LAHEDOnRsZhXYfnDseqZQlur1RPtruxGbcW3dkEVHYryALMajSsZ14NLcWq+vGVP
 GTBoSZqGRY7K98YSJOKCX63rctHiU7y5E9sk/aDzVL1z5i7AotG8MZCrmsUVuSsullnuy28rc+o
 rRHq05T6hjtQqQD2mmoFjZifcYug0UlNueuVnbsnr7WGNrXw8tbIP2voMnC+GjyPpNvF+caUygW
 bfnXOYZqG4zXz0Qyax/WQH8WSPm+a9AfQRIOjRnmQmWyBHs8ZamVu11LpW8yH/1LdyVTUHLBcU/
 9z1b7T+HamvQzP814BKvBuYkBc=
X-Received: by 2002:a05:6a00:10c3:b0:81a:857b:f944 with SMTP id
 d2e1a72fcca58-82972b78330mr2073900b3a.26.1772630735639; 
 Wed, 04 Mar 2026 05:25:35 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:35 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 7/9] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Wed,  4 Mar 2026 21:25:11 +0800
Message-ID: <20260304132514.2889449-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
f-register operands must substitute the BF16 canonical NaN instead of
the FP16 canonical NaN for some vector floating-point instructions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 target/riscv/translate.c                |  8 ++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..03ae85796a 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2319,17 +2319,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  */
 static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
 {
-    switch (s->sew) {
-    case 1:
-        gen_check_nanbox_h(out, in);
-        break;
-    case 2:
+    if (s->sew == MO_16) {
+        if (s->altfmt) {
+            gen_check_nanbox_h_bf16(out, in);
+        } else {
+            gen_check_nanbox_h(out, in);
+        }
+    } else if (s->sew == MO_32) {
         gen_check_nanbox_s(out, in);
-        break;
-    case 3:
+    } else if (s->sew == MO_64) {
         tcg_gen_mov_i64(out, in);
-        break;
-    default:
+    } else {
         g_assert_not_reached();
     }
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 89d4f6fe67..d9df6a35ca 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
 }
 
+static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_constant_i64(0xffffffffffff0000ull);
+    TCGv_i64 t_nan = tcg_constant_i64(0xffffffffffff7fc0ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+}
+
 static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 {
     TCGv_i64 t_max = tcg_constant_i64(0xffffffff00000000ull);
-- 
2.52.0


