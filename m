Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5BFC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ysl-0007fi-68; Fri, 04 Sep 2026 14:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2Ysc-0007ba-QE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:15 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x2YsY-0007FQ-VE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:43:14 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-9392aa26b25so119653185a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788547390; x=1789152190; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxmRkSNwe28Owu3zn38AwK3jEgeKY6PGeVmRV+GhjYQ=;
 b=CIq/un1X9xSy+EfsLi3z6qOZfhcOJR4+IefigYxb0q93eWV87LzoAZWmI5vmLiq4tS
 dxbB88jY0iKvKS49Chz9DiPpZySFmcUKSjkmtDYCjxrxLw121LxDnQ1gcoS3cBzrm489
 MXYLC9jUZeOC/FWCjad18NJW72Kzx4kot+BzZODjWSLVAel2BL73km6xNaPrRQrggNou
 jgfi+VX8+dMTGRHgPwqbtmujV36oNwqkjr3WR2JL8fEHbLT/A00L03iuRDnj2vbGDAen
 s4rw2bRIG8H6xZsXypIrv93c0j+DQ3SdT6yavVXYxwX0sbK71RgY0i8Yu8lz9QlKZJHA
 Cq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788547390; x=1789152190;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PxmRkSNwe28Owu3zn38AwK3jEgeKY6PGeVmRV+GhjYQ=;
 b=F1Sxy0/vn+PQUUcHAUnofOsOXz5uGpbzqbHv/PDgo99zsT+Hb22yMBGMZJn0L9yApU
 1O5KTPXl2X0noXkldHqdZgI9fO2HQ9I5TqJcSUuQOgymUYiUnRlcj4eBn8q1wv1IbTVN
 45AEcA/bECNpfeDSViF+ZB6aZPOYT95gmQu58d9aj7C2yMZqwjQD/5vYVsByXuZwLMVa
 K8VktxVZki2LSdLECkYuW8VwvK2iXANteXYfVTjmuJYxhtV6BvyaZkEiLz5g9kUjOQ2S
 PQhoHW/TP3NTQmAtMzMqb0GPb7vd8jurJrJdbxKYAYUWC8CQmw/ETB77CsvgZwQr1MfW
 Ltbw==
X-Gm-Message-State: AFuF++mp+dCs6kupoPEaEvk+J5MrAbbpHUZEcI8z27Fm5nnJQgBVGdHo
 Y3Rrwotm2/V+Z314u2D4WVmpzgmS09Pcd/kw8B5EgCdHX1MBOvhsVEUVmkJ+ayh5sQU=
X-Gm-Gg: AYBFou1MUsJ7KFJcDNQMTGoyz2Yh9P+VH0eqdSRzxRn2H3x55Rh8LgF8ewuKK+AKrvY
 VwnE/scuMa1AArqD/VHDuy/Sg77D4rCk4ehEzmCJ+BYEVTAtWB5FS+t2ciipXxkNDKU+PVzswGb
 uo9fPB2lYJzpsMi1hk5Pa36X/2gi0nmhiSif5Df2hpmyUMjzyMGKOV6bX3gTBZaf0Gn24zFHi6B
 MgSi/n9o3w2FOIQ3TkrIDuI4mzkSUqnaOYAvDOmfb8V4dqQRtJre8RLrzFked+4uRBA0sPSegIu
 79YDgTCd3POYi7uvFZBGlnDF/XhjUUGWWCVnQDYislXnq/wz6dcgX8WPd99ZYR29iC9/0F1/sMl
 /ulXYQ03WUgXqrjKAVOUNVenbZjReHsw/JoeSRQnyfjYvkC5173xBH3tk+Fpv95jo9xpULE2u4A
 KK/hmdqapmtBzxRczK4/PaIj2D+IGhBBVzJFyd3RUqv7aa++nJyFKj5iJSEHIxhwQxjhlq99B2Z
 2inKdRhWTk=
X-Received: by 2002:a05:620a:831b:b0:92e:5fe2:fd35 with SMTP id
 af79cd13be357-939804070f6mr649303885a.32.1788547389901; 
 Fri, 04 Sep 2026 11:43:09 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb36129sm277111985a.19.2026.09.04.11.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:43:09 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Fri, 04 Sep 2026 14:43:05 -0400
Subject: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=tgamblin@baylibre.com; helo=mail-qk1-x736.google.com
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

sfence.vma unconditionally called helper_tlb_flush(), regardless of the
rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
next access. Create a page-level counterpart to helper_tlb_flush()
called helper_tlb_flush_page(), and use it whenever rs1 != 0, falling
back to the existing full flush for rs1 == 0. This makes RISC-V
behaviour more similar to ARM's equivalent (tlbi_aa64_vae1_write), which
already does tlb_flush_page_by_mmuidx() instead of a full flush.

Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
than get_gpr(), so that the address being passed matches the current
addr_xl width regardless of '-cpu' input. Otherwise, the raw register
value can carry garbage above that width and never match the address the
TLB entry was actually filled under, so the flush silently misses and a
stale mapping survives.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 target/riscv/helper.h                              | 1 +
 target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
 target/riscv/tcg/op_helper.c                       | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4fc2d3a155..652f85a5c7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -137,6 +137,7 @@ DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
+DEF_HELPER_2(tlb_flush_page, void, env, tl)
 DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..8655fa332e 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
-    gen_helper_tlb_flush(tcg_env);
+    if (a->rs1 == 0) {
+        gen_helper_tlb_flush(tcg_env);
+    } else {
+        gen_helper_tlb_flush_page(tcg_env, get_address(ctx, a->rs1, 0));
+    }
     return true;
 #endif
     return false;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 7f63f3ada5..178b4d271b 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -607,6 +607,12 @@ void helper_tlb_flush(CPURISCVState *env)
     tlb_flush(cs);
 }
 
+void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
+{
+    check_sfence_vma(env, GETPC());
+    tlb_flush_page(env_cpu(env), addr);
+}
+
 void helper_tlb_flush_all(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.55.0


