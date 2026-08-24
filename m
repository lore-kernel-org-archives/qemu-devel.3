Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EFAC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbk-0006NR-Fq; Mon, 24 Aug 2026 01:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbR-0005LB-SZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbN-00033y-04
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso4262908a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550728; x=1788155528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hFTZ3kapZ8QJtr1bUBz2auegSsuYlFS9xaT6qtKR8oI=;
 b=pfuP7JUzJYdBJ7zurOeRurt5EJf5N4BFPscVIXT4Kn9MsQtcDYxtMnpgT+qWg7tx6E
 mzCYAqYgILkXbLCcO1sxQJ3dDhCT3ZWKeNhGK2i9AEgtMqyxDMWK4KO9nhuWU/YvUibp
 zWVistPrHGd5uVribDdh8ZDQgeqp4586E/38zf8+KdbWs2X3WsTJFF5xS+ljHZ7Og4Jx
 Y+KB9ufAziPv8TWyTPs0ZWvxeUz9JiaRESr3fMRH+hS8wR54s2LkILwhc4dpqJHOVftf
 IqUVbwvmiS2+z9AbfvqyeiXyCf8O0sAq5oPtvf7OE9aVQ6ZENHAZyZ16qnbYq4VHxMmB
 ESnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550728; x=1788155528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hFTZ3kapZ8QJtr1bUBz2auegSsuYlFS9xaT6qtKR8oI=;
 b=E297pOXDcSbTRMLLeXMPmKPn57JVdqqN+kLafw9KDoorLCuHsVh6DycXS6DsIVbEe/
 6Tb2NHbb3XFUiuPqOuinpn5zvN7/7Q+X3z27k6iEL8gOO401X4a6OcayTAD9DfwfzZne
 Vh45Nzsarm29r7Xarp+BV5KuBfvN3u9Ri/5+rGC1I4jYCQfOoUBaXsxJbZMqHEWev++J
 7tXBRf6KdO3q0x4+mG8/8u9kcN0pN63SNxGRuRSauvIZJbEhgwuT3lKlumIJ6+Uh6iC6
 6JINUpgopiAkLUjNVN27jG1sbgQogs8fuuPjWXidiiFS8QaQ/a6xY3rgbHDTXflTk4Ly
 knTw==
X-Gm-Message-State: AFuF++nLFjghrt5HMyanE5fl2HacOPgStyNm344dUU23ymyekCfjABqL
 57ji694Ha3tM0a1riC16/KL8ljL4E8C/tglXxEDFbzVAfqN1Wo2NYmemANLmgQ==
X-Gm-Gg: AR+sD10QvA2OvKEH4iza3+OZ1mKPi+jxL9EfbdB8tucUq+SHpuUMj4rqWOtsGmj+PZK
 XFl42X3hTaIePxScXv1x9rJWUveK4pdCIufECy8jHON9+uIzS+O8WyHesoPkvKLnjBkauW9QEeD
 JYgQSiSZSBleN5GuNXnnTATDrR6CwP2jfPuKsN72+7kW6tjjY52FRSw9uPj0s2d4wRkXyfBXq2X
 PRLrxgQk1HL2yAfh1eiIkggoR/NuSzxPGQ/negiQ+DxpUzpHUKFHt3DEUR0WaUJROTbWVt99ocf
 0tkix1IOrkasFcObt9Gl8M9VeaWBP591FDgllfLTAnmC2DNEpJP0rxXzx4b5THI0qfvO+EpR580
 PX7Yrzy1VVwCshHNh/Oq9wT3YOHEsS0tiPHnXrhvidAXR1GNitZPUXqF7vN9oQMGD0GVG6oZjTV
 1UHvfVgemiWNE1iqrD+bJCda+GvmvJTpRFzcPjV7ScTt6FQB6brqAoaa18s7U6pKtfGJui0LMbY
 fQr9A==
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-395c3566ba6mr48552876a91.6.1787550727532; 
 Sun, 23 Aug 2026 22:52:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 76/96] disas/riscv: Split xthead_opcode_data
Date: Mon, 24 Aug 2026 15:47:46 +1000
Message-ID: <20260824054806.2790041-77-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the table to riscv-xthead-op.c.inc and massage
the lines into OP() form.  Drop th.illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-44-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xthead.c        | 481 +++++++++---------------------------
 disas/riscv-xthead-op.c.inc | 125 ++++++++++
 2 files changed, 243 insertions(+), 363 deletions(-)
 create mode 100644 disas/riscv-xthead-op.c.inc

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index fbc96631fd..387c22c869 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -8,248 +8,13 @@
 #include "disas/riscv.h"
 #include "disas/riscv-xthead.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    /* XTheadBa */
-    rv_op_th_addsl = 1,
-    /* XTheadBb */
-    rv_op_th_srri,
-    rv_op_th_srriw,
-    rv_op_th_ext,
-    rv_op_th_extu,
-    rv_op_th_ff0,
-    rv_op_th_ff1,
-    rv_op_th_rev,
-    rv_op_th_revw,
-    rv_op_th_tstnbz,
-    /* XTheadBs */
-    rv_op_th_tst,
-    /* XTheadCmo */
-    rv_op_th_dcache_call,
-    rv_op_th_dcache_ciall,
-    rv_op_th_dcache_iall,
-    rv_op_th_dcache_cpa,
-    rv_op_th_dcache_cipa,
-    rv_op_th_dcache_ipa,
-    rv_op_th_dcache_cva,
-    rv_op_th_dcache_civa,
-    rv_op_th_dcache_iva,
-    rv_op_th_dcache_csw,
-    rv_op_th_dcache_cisw,
-    rv_op_th_dcache_isw,
-    rv_op_th_dcache_cpal1,
-    rv_op_th_dcache_cval1,
-    rv_op_th_icache_iall,
-    rv_op_th_icache_ialls,
-    rv_op_th_icache_ipa,
-    rv_op_th_icache_iva,
-    rv_op_th_l2cache_call,
-    rv_op_th_l2cache_ciall,
-    rv_op_th_l2cache_iall,
-    /* XTheadCondMov */
-    rv_op_th_mveqz,
-    rv_op_th_mvnez,
-    /* XTheadFMemIdx */
-    rv_op_th_flrd,
-    rv_op_th_flrw,
-    rv_op_th_flurd,
-    rv_op_th_flurw,
-    rv_op_th_fsrd,
-    rv_op_th_fsrw,
-    rv_op_th_fsurd,
-    rv_op_th_fsurw,
-    /* XTheadFmv */
-    rv_op_th_fmv_hw_x,
-    rv_op_th_fmv_x_hw,
-    /* XTheadMac */
-    rv_op_th_mula,
-    rv_op_th_mulah,
-    rv_op_th_mulaw,
-    rv_op_th_muls,
-    rv_op_th_mulsw,
-    rv_op_th_mulsh,
-    /* XTheadMemIdx */
-    rv_op_th_lbia,
-    rv_op_th_lbib,
-    rv_op_th_lbuia,
-    rv_op_th_lbuib,
-    rv_op_th_lhia,
-    rv_op_th_lhib,
-    rv_op_th_lhuia,
-    rv_op_th_lhuib,
-    rv_op_th_lwia,
-    rv_op_th_lwib,
-    rv_op_th_lwuia,
-    rv_op_th_lwuib,
-    rv_op_th_ldia,
-    rv_op_th_ldib,
-    rv_op_th_sbia,
-    rv_op_th_sbib,
-    rv_op_th_shia,
-    rv_op_th_shib,
-    rv_op_th_swia,
-    rv_op_th_swib,
-    rv_op_th_sdia,
-    rv_op_th_sdib,
-    rv_op_th_lrb,
-    rv_op_th_lrbu,
-    rv_op_th_lrh,
-    rv_op_th_lrhu,
-    rv_op_th_lrw,
-    rv_op_th_lrwu,
-    rv_op_th_lrd,
-    rv_op_th_srb,
-    rv_op_th_srh,
-    rv_op_th_srw,
-    rv_op_th_srd,
-    rv_op_th_lurb,
-    rv_op_th_lurbu,
-    rv_op_th_lurh,
-    rv_op_th_lurhu,
-    rv_op_th_lurw,
-    rv_op_th_lurwu,
-    rv_op_th_lurd,
-    rv_op_th_surb,
-    rv_op_th_surh,
-    rv_op_th_surw,
-    rv_op_th_surd,
-    /* XTheadMemPair */
-    rv_op_th_ldd,
-    rv_op_th_lwd,
-    rv_op_th_lwud,
-    rv_op_th_sdd,
-    rv_op_th_swd,
-    /* XTheadSync */
-    rv_op_th_sfence_vmas,
-    rv_op_th_sync,
-    rv_op_th_sync_i,
-    rv_op_th_sync_is,
-    rv_op_th_sync_s,
-} rv_xthead_op;
-
-static const rv_opcode_data xthead_opcode_data[] = {
-    { "th.illegal", rv_codec_illegal, rv_fmt_none },
-    /* XTheadBa */
-    { "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    /* XTheadBb */
-    { "th.srri", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm },
-    { "th.srriw", rv_codec_r2_imm5, rv_fmt_rd_rs1_imm },
-    { "th.ext", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imml },
-    { "th.extu", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imml },
-    { "th.ff0", rv_codec_r2, rv_fmt_rd_rs1 },
-    { "th.ff1", rv_codec_r2, rv_fmt_rd_rs1 },
-    { "th.rev", rv_codec_r2, rv_fmt_rd_rs1 },
-    { "th.revw", rv_codec_r2, rv_fmt_rd_rs1 },
-    { "th.tstnbz", rv_codec_r2, rv_fmt_rd_rs1 },
-    /* XTheadBs */
-    { "th.tst", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm },
-    /* XTheadCmo */
-    { "th.dcache.call", rv_codec_none, rv_fmt_none },
-    { "th.dcache.ciall", rv_codec_none, rv_fmt_none },
-    { "th.dcache.iall", rv_codec_none, rv_fmt_none },
-    { "th.dcache.cpa", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.cipa", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.ipa", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.cva", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.civa", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.iva", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.csw", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.cisw", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.isw", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.cpal1", rv_codec_r, rv_fmt_rs1 },
-    { "th.dcache.cval1", rv_codec_r, rv_fmt_rs1 },
-    { "th.icache.iall", rv_codec_none, rv_fmt_none },
-    { "th.icache.ialls", rv_codec_none, rv_fmt_none },
-    { "th.icache.ipa", rv_codec_r, rv_fmt_rs1 },
-    { "th.icache.iva", rv_codec_r, rv_fmt_rs1 },
-    { "th.l2cache.call", rv_codec_none, rv_fmt_none },
-    { "th.l2cache.ciall", rv_codec_none, rv_fmt_none },
-    { "th.l2cache.iall", rv_codec_none, rv_fmt_none },
-    /* XTheadCondMov */
-    { "th.mveqz", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.mvnez", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    /* XTheadFMemIdx */
-    { "th.flrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.flrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.flurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.flurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.fsrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.fsrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.fsurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    { "th.fsurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm },
-    /* XTheadFmv */
-    { "th.fmv.hw.x", rv_codec_r, rv_fmt_rd_frs1 },
-    { "th.fmv.x.hw", rv_codec_r, rv_fmt_rd_frs1 },
-    /* XTheadMac */
-    { "th.mula", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.mulaw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.mulah", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.muls", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.mulsw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    /* XTheadMemIdx */
-    { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lhib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lhuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lhuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lwia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lwib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lwuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lwuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.ldia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.ldib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.sbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.sbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.shia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.shib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.swia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.swib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.sdia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.sdib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lrb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lrd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.srb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.srh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.srw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.srd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.lurd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.surb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.surh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.surw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    { "th.surd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm },
-    /* XTheadMemPair */
-    { "th.ldd", rv_codec_r_imm2, rv_fmt_rd2_imm },
-    { "th.lwd", rv_codec_r_imm2, rv_fmt_rd2_imm },
-    { "th.lwud", rv_codec_r_imm2, rv_fmt_rd2_imm },
-    { "th.sdd", rv_codec_r_imm2, rv_fmt_rd2_imm },
-    { "th.swd", rv_codec_r_imm2, rv_fmt_rd2_imm },
-    /* XTheadSync */
-    { "th.sfence.vmas", rv_codec_r, rv_fmt_rs1_rs2 },
-    { "th.sync", rv_codec_none, rv_fmt_none },
-    { "th.sync.i", rv_codec_none, rv_fmt_none },
-    { "th.sync.is", rv_codec_none, rv_fmt_none },
-    { "th.sync.s", rv_codec_none, rv_fmt_none },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xthead-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -262,7 +27,7 @@ const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
                 case 0b0000000:
                 case 0b0000001:
                 case 0b0000010:
-                case 0b0000011: op = rv_op_th_addsl; break;
+                case 0b0000011: return &op_th_addsl;
                 }
                 break;
             }
@@ -272,13 +37,12 @@ const rv_opcode_data *decode_xtheadba(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -288,41 +52,41 @@ const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 1:
                 switch ((inst >> 25) & 0b1111111) {
-                case 0b0001010: op = rv_op_th_srriw; break;
+                case 0b0001010: return &op_th_srriw;
                 case 0b1000000:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_tstnbz;
+                        return &op_th_tstnbz;
                     }
                     break;
                 case 0b1000001:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_rev;
+                        return &op_th_rev;
                     }
                     break;
                 case 0b1000010:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_ff0;
+                        return &op_th_ff0;
                     }
                     break;
                 case 0b1000011:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_ff1;
+                        return &op_th_ff1;
                     }
                     break;
                 case 0b1000100:
                 case 0b1001000:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_revw;
+                        return &op_th_revw;
                     }
                     break;
                 case 0b0001000:
                 case 0b0001001:
-                    op = rv_op_th_srri;
+                    return &op_th_srri;
                     break;
                 }
                 break;
-            case 2: op = rv_op_th_ext; break;
-            case 3: op = rv_op_th_extu; break;
+            case 2: return &op_th_ext;
+            case 3: return &op_th_extu;
             }
             break;
             /* custom-0 */
@@ -330,13 +94,12 @@ const rv_opcode_data *decode_xtheadbb(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -346,7 +109,7 @@ const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 1:
                 switch ((inst >> 26) & 0b111111) {
-                case 0b100010: op = rv_op_th_tst; break;
+                case 0b100010: return &op_th_tst;
                 }
                 break;
             }
@@ -356,13 +119,12 @@ const rv_opcode_data *decode_xtheadbs(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -374,55 +136,55 @@ const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
                 switch ((inst >> 20 & 0b111111111111)) {
                 case 0b000000000001:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_dcache_call;
+                        return &op_th_dcache_call;
                     }
                     break;
                 case 0b000000000011:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_dcache_ciall;
+                        return &op_th_dcache_ciall;
                     }
                     break;
                 case 0b000000000010:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_dcache_iall;
+                        return &op_th_dcache_iall;
                     }
                     break;
-                case 0b000000101001: op = rv_op_th_dcache_cpa; break;
-                case 0b000000101011: op = rv_op_th_dcache_cipa; break;
-                case 0b000000101010: op = rv_op_th_dcache_ipa; break;
-                case 0b000000100101: op = rv_op_th_dcache_cva; break;
-                case 0b000000100111: op = rv_op_th_dcache_civa; break;
-                case 0b000000100110: op = rv_op_th_dcache_iva; break;
-                case 0b000000100001: op = rv_op_th_dcache_csw; break;
-                case 0b000000100011: op = rv_op_th_dcache_cisw; break;
-                case 0b000000100010: op = rv_op_th_dcache_isw; break;
-                case 0b000000101000: op = rv_op_th_dcache_cpal1; break;
-                case 0b000000100100: op = rv_op_th_dcache_cval1; break;
+                case 0b000000101001: return &op_th_dcache_cpa;
+                case 0b000000101011: return &op_th_dcache_cipa;
+                case 0b000000101010: return &op_th_dcache_ipa;
+                case 0b000000100101: return &op_th_dcache_cva;
+                case 0b000000100111: return &op_th_dcache_civa;
+                case 0b000000100110: return &op_th_dcache_iva;
+                case 0b000000100001: return &op_th_dcache_csw;
+                case 0b000000100011: return &op_th_dcache_cisw;
+                case 0b000000100010: return &op_th_dcache_isw;
+                case 0b000000101000: return &op_th_dcache_cpal1;
+                case 0b000000100100: return &op_th_dcache_cval1;
                 case 0b000000010000:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_icache_iall;
+                        return &op_th_icache_iall;
                     }
                     break;
                 case 0b000000010001:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_icache_ialls;
+                        return &op_th_icache_ialls;
                     }
                     break;
-                case 0b000000111000: op = rv_op_th_icache_ipa; break;
-                case 0b000000110000: op = rv_op_th_icache_iva; break;
+                case 0b000000111000: return &op_th_icache_ipa;
+                case 0b000000110000: return &op_th_icache_iva;
                 case 0b000000010101:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_l2cache_call;
+                        return &op_th_l2cache_call;
                     }
                     break;
                 case 0b000000010111:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_l2cache_ciall;
+                        return &op_th_l2cache_ciall;
                     }
                     break;
                 case 0b000000010110:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_l2cache_iall;
+                        return &op_th_l2cache_iall;
                     }
                     break;
                 }
@@ -434,13 +196,12 @@ const rv_opcode_data *decode_xtheadcmo(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -450,8 +211,8 @@ const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 1:
                 switch ((inst >> 25) & 0b1111111) {
-                case 0b0100000: op = rv_op_th_mveqz; break;
-                case 0b0100001: op = rv_op_th_mvnez; break;
+                case 0b0100000: return &op_th_mveqz;
+                case 0b0100001: return &op_th_mvnez;
                 }
                 break;
             }
@@ -461,13 +222,12 @@ const rv_opcode_data *decode_xtheadcondmov(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -477,18 +237,18 @@ const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 6:
                 switch ((inst >> 27) & 0b11111) {
-                case 8: op = rv_op_th_flrw; break;
-                case 10: op = rv_op_th_flurw; break;
-                case 12: op = rv_op_th_flrd; break;
-                case 14: op = rv_op_th_flurd; break;
+                case 8: return &op_th_flrw;
+                case 10: return &op_th_flurw;
+                case 12: return &op_th_flrd;
+                case 14: return &op_th_flurd;
                 }
                 break;
             case 7:
                 switch ((inst >> 27) & 0b11111) {
-                case 8: op = rv_op_th_fsrw; break;
-                case 10: op = rv_op_th_fsurw; break;
-                case 12: op = rv_op_th_fsrd; break;
-                case 14: op = rv_op_th_fsurd; break;
+                case 8: return &op_th_fsrw;
+                case 10: return &op_th_fsurw;
+                case 12: return &op_th_fsrd;
+                case 14: return &op_th_fsurd;
                 }
                 break;
             }
@@ -498,13 +258,12 @@ const rv_opcode_data *decode_xtheadfmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -516,12 +275,12 @@ const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
                 switch ((inst >> 25) & 0b1111111) {
                 case 0b1010000:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_fmv_hw_x;
+                        return &op_th_fmv_hw_x;
                     }
                     break;
                 case 0b1100000:
                     if (((inst >> 20) & 0b11111) == 0) {
-                        op = rv_op_th_fmv_x_hw;
+                        return &op_th_fmv_x_hw;
                     }
                     break;
                 }
@@ -533,13 +292,12 @@ const rv_opcode_data *decode_xtheadfmv(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -549,12 +307,12 @@ const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 1:
                 switch ((inst >> 25) & 0b1111111) {
-                case 0b0010000: op = rv_op_th_mula; break;
-                case 0b0010001: op = rv_op_th_muls; break;
-                case 0b0010010: op = rv_op_th_mulaw; break;
-                case 0b0010011: op = rv_op_th_mulsw; break;
-                case 0b0010100: op = rv_op_th_mulah; break;
-                case 0b0010101: op = rv_op_th_mulsh; break;
+                case 0b0010000: return &op_th_mula;
+                case 0b0010001: return &op_th_muls;
+                case 0b0010010: return &op_th_mulaw;
+                case 0b0010011: return &op_th_mulsw;
+                case 0b0010100: return &op_th_mulah;
+                case 0b0010101: return &op_th_mulsh;
                 }
                 break;
             }
@@ -564,13 +322,12 @@ const rv_opcode_data *decode_xtheadmac(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -580,54 +337,54 @@ const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 4:
                 switch ((inst >> 27) & 0b11111) {
-                case 0: op = rv_op_th_lrb; break;
-                case 1: op = rv_op_th_lbib; break;
-                case 2: op = rv_op_th_lurb; break;
-                case 3: op = rv_op_th_lbia; break;
-                case 4: op = rv_op_th_lrh; break;
-                case 5: op = rv_op_th_lhib; break;
-                case 6: op = rv_op_th_lurh; break;
-                case 7: op = rv_op_th_lhia; break;
-                case 8: op = rv_op_th_lrw; break;
-                case 9: op = rv_op_th_lwib; break;
-                case 10: op = rv_op_th_lurw; break;
-                case 11: op = rv_op_th_lwia; break;
-                case 12: op = rv_op_th_lrd; break;
-                case 13: op = rv_op_th_ldib; break;
-                case 14: op = rv_op_th_lurd; break;
-                case 15: op = rv_op_th_ldia; break;
-                case 16: op = rv_op_th_lrbu; break;
-                case 17: op = rv_op_th_lbuib; break;
-                case 18: op = rv_op_th_lurbu; break;
-                case 19: op = rv_op_th_lbuia; break;
-                case 20: op = rv_op_th_lrhu; break;
-                case 21: op = rv_op_th_lhuib; break;
-                case 22: op = rv_op_th_lurhu; break;
-                case 23: op = rv_op_th_lhuia; break;
-                case 24: op = rv_op_th_lrwu; break;
-                case 25: op = rv_op_th_lwuib; break;
-                case 26: op = rv_op_th_lurwu; break;
-                case 27: op = rv_op_th_lwuia; break;
+                case 0: return &op_th_lrb;
+                case 1: return &op_th_lbib;
+                case 2: return &op_th_lurb;
+                case 3: return &op_th_lbia;
+                case 4: return &op_th_lrh;
+                case 5: return &op_th_lhib;
+                case 6: return &op_th_lurh;
+                case 7: return &op_th_lhia;
+                case 8: return &op_th_lrw;
+                case 9: return &op_th_lwib;
+                case 10: return &op_th_lurw;
+                case 11: return &op_th_lwia;
+                case 12: return &op_th_lrd;
+                case 13: return &op_th_ldib;
+                case 14: return &op_th_lurd;
+                case 15: return &op_th_ldia;
+                case 16: return &op_th_lrbu;
+                case 17: return &op_th_lbuib;
+                case 18: return &op_th_lurbu;
+                case 19: return &op_th_lbuia;
+                case 20: return &op_th_lrhu;
+                case 21: return &op_th_lhuib;
+                case 22: return &op_th_lurhu;
+                case 23: return &op_th_lhuia;
+                case 24: return &op_th_lrwu;
+                case 25: return &op_th_lwuib;
+                case 26: return &op_th_lurwu;
+                case 27: return &op_th_lwuia;
                 }
                 break;
             case 5:
                 switch ((inst >> 27) & 0b11111) {
-                case 0: op = rv_op_th_srb; break;
-                case 1: op = rv_op_th_sbib; break;
-                case 2: op = rv_op_th_surb; break;
-                case 3: op = rv_op_th_sbia; break;
-                case 4: op = rv_op_th_srh; break;
-                case 5: op = rv_op_th_shib; break;
-                case 6: op = rv_op_th_surh; break;
-                case 7: op = rv_op_th_shia; break;
-                case 8: op = rv_op_th_srw; break;
-                case 9: op = rv_op_th_swib; break;
-                case 10: op = rv_op_th_surw; break;
-                case 11: op = rv_op_th_swia; break;
-                case 12: op = rv_op_th_srd; break;
-                case 13: op = rv_op_th_sdib; break;
-                case 14: op = rv_op_th_surd; break;
-                case 15: op = rv_op_th_sdia; break;
+                case 0: return &op_th_srb;
+                case 1: return &op_th_sbib;
+                case 2: return &op_th_surb;
+                case 3: return &op_th_sbia;
+                case 4: return &op_th_srh;
+                case 5: return &op_th_shib;
+                case 6: return &op_th_surh;
+                case 7: return &op_th_shia;
+                case 8: return &op_th_srw;
+                case 9: return &op_th_swib;
+                case 10: return &op_th_surw;
+                case 11: return &op_th_swia;
+                case 12: return &op_th_srd;
+                case 13: return &op_th_sdib;
+                case 14: return &op_th_surd;
+                case 15: return &op_th_sdia;
                 }
                 break;
                 break;
@@ -638,13 +395,12 @@ const rv_opcode_data *decode_xtheadmemidx(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -654,15 +410,15 @@ const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 4:
                 switch ((inst >> 27) & 0b11111) {
-                case 28: op = rv_op_th_lwd; break;
-                case 30: op = rv_op_th_lwud; break;
-                case 31: op = rv_op_th_ldd; break;
+                case 28: return &op_th_lwd;
+                case 30: return &op_th_lwud;
+                case 31: return &op_th_ldd;
                 }
                 break;
             case 5:
                 switch ((inst >> 27) & 0b11111) {
-                case 28: op = rv_op_th_swd; break;
-                case 31: op = rv_op_th_sdd; break;
+                case 28: return &op_th_swd;
+                case 31: return &op_th_sdd;
                 }
                 break;
             }
@@ -672,13 +428,12 @@ const rv_opcode_data *decode_xtheadmempair(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
 
 const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch (((inst >> 0) & 0b11)) {
     case 3:
@@ -688,13 +443,13 @@ const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0:
                 switch ((inst >> 25) & 0b1111111) {
-                case 0b0000010: op = rv_op_th_sfence_vmas; break;
+                case 0b0000010: return &op_th_sfence_vmas;
                 case 0b0000000:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0b11000: op = rv_op_th_sync; break;
-                    case 0b11010: op = rv_op_th_sync_i; break;
-                    case 0b11011: op = rv_op_th_sync_is; break;
-                    case 0b11001: op = rv_op_th_sync_s; break;
+                    case 0b11000: return &op_th_sync;
+                    case 0b11010: return &op_th_sync_i;
+                    case 0b11011: return &op_th_sync_is;
+                    case 0b11001: return &op_th_sync_s;
                     }
                     break;
                 }
@@ -706,5 +461,5 @@ const rv_opcode_data *decode_xtheadsync(rv_decode *dec, rv_isa isa)
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xthead_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xthead-op.c.inc b/disas/riscv-xthead-op.c.inc
new file mode 100644
index 0000000000..1e4e0557cd
--- /dev/null
+++ b/disas/riscv-xthead-op.c.inc
@@ -0,0 +1,125 @@
+/* XTheadBa */
+OP(th_addsl, "th.addsl", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+
+/* XTheadBb */
+OP(th_srri, "th.srri", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm)
+OP(th_srriw, "th.srriw", rv_codec_r2_imm5, rv_fmt_rd_rs1_imm)
+OP(th_ext, "th.ext", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imml)
+OP(th_extu, "th.extu", rv_codec_r2_immhl, rv_fmt_rd_rs1_immh_imml)
+OP(th_ff0, "th.ff0", rv_codec_r2, rv_fmt_rd_rs1)
+OP(th_ff1, "th.ff1", rv_codec_r2, rv_fmt_rd_rs1)
+OP(th_rev, "th.rev", rv_codec_r2, rv_fmt_rd_rs1)
+OP(th_revw, "th.revw", rv_codec_r2, rv_fmt_rd_rs1)
+OP(th_tstnbz, "th.tstnbz", rv_codec_r2, rv_fmt_rd_rs1)
+
+/* XTheadBs */
+OP(th_tst, "th.tst", rv_codec_r2_imm6, rv_fmt_rd_rs1_imm)
+
+/* XTheadCmo */
+OP(th_dcache_call, "th.dcache.call", rv_codec_none, rv_fmt_none)
+OP(th_dcache_ciall, "th.dcache.ciall", rv_codec_none, rv_fmt_none)
+OP(th_dcache_iall, "th.dcache.iall", rv_codec_none, rv_fmt_none)
+OP(th_dcache_cpa, "th.dcache.cpa", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_cipa, "th.dcache.cipa", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_ipa, "th.dcache.ipa", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_cva, "th.dcache.cva", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_civa, "th.dcache.civa", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_iva, "th.dcache.iva", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_csw, "th.dcache.csw", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_cisw, "th.dcache.cisw", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_isw, "th.dcache.isw", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_cpal1, "th.dcache.cpal1", rv_codec_r, rv_fmt_rs1)
+OP(th_dcache_cval1, "th.dcache.cval1", rv_codec_r, rv_fmt_rs1)
+OP(th_icache_iall, "th.icache.iall", rv_codec_none, rv_fmt_none)
+OP(th_icache_ialls, "th.icache.ialls", rv_codec_none, rv_fmt_none)
+OP(th_icache_ipa, "th.icache.ipa", rv_codec_r, rv_fmt_rs1)
+OP(th_icache_iva, "th.icache.iva", rv_codec_r, rv_fmt_rs1)
+OP(th_l2cache_call, "th.l2cache.call", rv_codec_none, rv_fmt_none)
+OP(th_l2cache_ciall, "th.l2cache.ciall", rv_codec_none, rv_fmt_none)
+OP(th_l2cache_iall, "th.l2cache.iall", rv_codec_none, rv_fmt_none)
+
+/* XTheadCondMov */
+OP(th_mveqz, "th.mveqz", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_mvnez, "th.mvnez", rv_codec_r, rv_fmt_rd_rs1_rs2)
+
+/* XTheadFMemIdx */
+OP(th_flrd, "th.flrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_flrw, "th.flrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_flurd, "th.flurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_flurw, "th.flurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_fsrd, "th.fsrd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_fsrw, "th.fsrw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_fsurd, "th.fsurd", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+OP(th_fsurw, "th.fsurw", rv_codec_r_imm2, rv_fmt_frd_rs1_rs2_imm)
+
+/* XTheadFmv */
+OP(th_fmv_hw_x, "th.fmv.hw.x", rv_codec_r, rv_fmt_rd_frs1)
+OP(th_fmv_x_hw, "th.fmv.x.hw", rv_codec_r, rv_fmt_rd_frs1)
+
+/* XTheadMac */
+OP(th_mula, "th.mula", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_mulaw, "th.mulaw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_mulah, "th.mulah", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_muls, "th.muls", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_mulsw, "th.mulsw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(th_mulsh, "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2)
+
+/* XTheadMemIdx */
+OP(th_lbia, "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lbib, "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lbuia, "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lbuib, "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lhia, "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lhib, "th.lhib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lhuia, "th.lhuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lhuib, "th.lhuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lwia, "th.lwia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lwib, "th.lwib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lwuia, "th.lwuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lwuib, "th.lwuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_ldia, "th.ldia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_ldib, "th.ldib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_sbia, "th.sbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_sbib, "th.sbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_shia, "th.shia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_shib, "th.shib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_swia, "th.swia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_swib, "th.swib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_sdia, "th.sdia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_sdib, "th.sdib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr)
+OP(th_lrb, "th.lrb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrbu, "th.lrbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrh, "th.lrh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrhu, "th.lrhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrw, "th.lrw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrwu, "th.lrwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lrd, "th.lrd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_srb, "th.srb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_srh, "th.srh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_srw, "th.srw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_srd, "th.srd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurb, "th.lurb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurbu, "th.lurbu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurh, "th.lurh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurhu, "th.lurhu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurw, "th.lurw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurwu, "th.lurwu", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_lurd, "th.lurd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_surb, "th.surb", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_surh, "th.surh", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_surw, "th.surw", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+OP(th_surd, "th.surd", rv_codec_r_imm2, rv_fmt_rd_rs1_rs2_imm)
+
+/* XTheadMemPair */
+OP(th_ldd, "th.ldd", rv_codec_r_imm2, rv_fmt_rd2_imm)
+OP(th_lwd, "th.lwd", rv_codec_r_imm2, rv_fmt_rd2_imm)
+OP(th_lwud, "th.lwud", rv_codec_r_imm2, rv_fmt_rd2_imm)
+OP(th_sdd, "th.sdd", rv_codec_r_imm2, rv_fmt_rd2_imm)
+OP(th_swd, "th.swd", rv_codec_r_imm2, rv_fmt_rd2_imm)
+
+/* XTheadSync */
+OP(th_sfence_vmas, "th.sfence.vmas", rv_codec_r, rv_fmt_rs1_rs2)
+OP(th_sync, "th.sync", rv_codec_none, rv_fmt_none)
+OP(th_sync_i, "th.sync.i", rv_codec_none, rv_fmt_none)
+OP(th_sync_is, "th.sync.is", rv_codec_none, rv_fmt_none)
+OP(th_sync_s, "th.sync.s", rv_codec_none, rv_fmt_none)
-- 
2.54.0


