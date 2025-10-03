Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E3ACCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTg-0007KT-41; Thu, 02 Oct 2025 23:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTa-0007Gs-CN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:59 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTK-0001I9-LK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3352018dfbcso1548663a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462117; x=1760066917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0riEgKAhZ2Tj4OdOkweDZUA2Gpqfb/brOq+0ojNKrY=;
 b=J4lLga/moW5zwnBwLVtn/R8arUbmT04si0Yfe7xzIVjLdrw17vu+B431etKCIJCCab
 jOwPrLx5KmVCt6GcfsDYT2ih3HJX6iCWpzVAnOCvIsWin/cK6SpNfkOP1LfpzTQLPaWC
 FrlSmjlL6IGxJ/aAnQlIef1NxRH+nrfraEl/JqXQQs3sPe2RFu7VG5WJCXzY2khapIXa
 9gyx5M6zS2j6EfC40HM+UqdAG2dxs7hF3P15iNta55QUMFnBhwEXR7GHUbKySjFBssTc
 T+q6p+ftQTlrfL8No2o9cTGqEIvtP6FaMZxH4eo+NXxL3CYegjhxs7uHx5/RUg7jZk/w
 1hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462117; x=1760066917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0riEgKAhZ2Tj4OdOkweDZUA2Gpqfb/brOq+0ojNKrY=;
 b=sWQhd/7f1OQuaSUokXyiOCEK5k3FuSc4l2ueJQYOmsYi4x8ESQRD35ByEV33S+6Ox7
 wyVB9FMlYEkBtKgFomgFONPTTmyNrQQ6SUdlkjPz+EBDGEWV4XNd9YgK6lfIWeyI1RHv
 t4uCrQt8NpyxKp48R8LKfX1ddaUKJW3fess0bb3bB/TRhq2hGnd1OpfT9FQ4K2NOLg3C
 KRghk5rGGR03Shje/bXL5koE/D1wkoRDqb1rvXoK6C7H++RGDWFUTqhf1c2O5hxyYHI0
 e1qCIwwCYsRfGpmcw6abt+XqO5HWGKvs6jJ+gTAT9p/X4LMGf39bySP0dmvADB32ncuC
 HXiQ==
X-Gm-Message-State: AOJu0YwMePg9nvAVgjGOCP3lhmuXlWi2s1H0btkATf2WbWesOwQ/YJsc
 Mg1LqxAIct8xJzw8NQ+q2DzaEf9+BciIOx0Z34hhyJM7Tn4GOS7SH9g54Axx3Q==
X-Gm-Gg: ASbGnctch+kNNZih3hS+cWm1pNDtbwDknykXoMQGLpulFOpAWmOydyRQscTXbYTfL4Q
 B90Ew+UaE3DSNg4X24AWuI4Tp8OgFWvde3mK66kiy+7gqT2G1zAZFC1CZ8WHoIyDhpGE7SCMkCd
 D0AfEgiQ1eDE+fTbOUVVQ/ZwushPxFpMvyWqCkIJXovjWy3H+N93M92TnngOW36Qv0gz7UI5+5E
 c03LJkG6QLpvlB9BC+8wlVrJjTvxTkeoQ1EUeJVRqZZpSSUYvWhfg20XKHaYeZZyvZ1wbosuFiK
 obSNjwRTTJyMXpxsq7whjvnuPdL3NCkkNPouTlpVqGXbyj3TVoK5Ac7LRziXdgMZpD3Y03mXpym
 Dlwc0F35ttJstliqkM7xpBu/VR4ly7n/yDqEE42zUbqgUtovKwjxt25537KuqBcGdI2c2FGK03l
 hED8ePOtLuXU0Ju9p4p6Kp0geZTV9UdW9m7VrhSPNF3RGU/CY1fbir
X-Google-Smtp-Source: AGHT+IG2gB9sk9i5DQKx2nikAewjXTszZ/Smue7Nh3pXu99WAtPO1RRQ5uDp7xsUMoHwUf5r89dMqw==
X-Received: by 2002:a17:90b:4b08:b0:32f:98da:c397 with SMTP id
 98e67ed59e1d1-339c27db05dmr1800965a91.24.1759462117473; 
 Thu, 02 Oct 2025 20:28:37 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/26] target/riscv: Fix the mepc when sspopchk triggers the
 exception
Date: Fri,  3 Oct 2025 13:27:10 +1000
Message-ID: <20251003032718.1324734-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Jim Shu <jim.shu@sifive.com>

When sspopchk is in the middle of TB and triggers the SW check
exception, it should update PC from gen_update_pc(). If not, RISC-V mepc
CSR will get wrong PC address which is still at the start of TB.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250924074818.230010-2-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index b0096adcd0..45686af4d6 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -40,6 +40,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                   tcg_env, offsetof(CPURISCVState, sw_check_code));
+    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.51.0


