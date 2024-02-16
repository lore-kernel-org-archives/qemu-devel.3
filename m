Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3720BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawOK-0006UL-RW; Fri, 16 Feb 2024 06:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawOI-0006Tr-OS
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:26 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rawOH-0005ql-2Q
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:28:26 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7354ba334so17068385ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708082903; x=1708687703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUW4y+sVEbMZE51fAwATSVNurT+QNFpidOYUiPbmWtc=;
 b=E11l5Bsv4YJLb0cHioEx+uSaRXjiLUSz/1RNwaZXJAKpoi5JESpVuRFi6v/37uujHv
 JrGjsduzbehTy9rg2BSRVJYXmLHP/ugbPjb6a+3U1NkflMLCDm9s1PA1m9fcmlkO/KCP
 KdiuyOb60qnvwOZC6RNhGuF4qovqA8C1ukZVCFdQN5a/hQR/NPk//hNYKvAU12dWOD2y
 uyW5VFljNz3x9nGrTjF8EmOZuLv763kJDqPp8vjKhN7gLBKh9jTkdrltz/f4YUUQ0xGP
 VfNv4fbeyWFL/qamS+DhKpu1A0B2BBAbKT+Vs6vo/WNTkOqSrlTIv5OoF0OA5nADvu0h
 vIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708082903; x=1708687703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUW4y+sVEbMZE51fAwATSVNurT+QNFpidOYUiPbmWtc=;
 b=hr518JP1mfig9Vdt2MeanB1wrXd2JhpZAppohCN3S/Mjt7nt0rspS+eOtRfVbU7n+q
 IyK58V1tRRfAGJ0ATgwsPhAwC+qtzWMq/H8QLe9VOxODnIc4QMps2KuNbdVGDRL+44vk
 e+Y8CF8WFFIGEkN5PDCVjo9I3S2c8z63On8ilFjatU9luzim2yZWIwXv2/+ibM6r8WzD
 u8QdY69VEN5fOdvhVuO/D56F4rnM/7Tsai0SFpAKzgwtp6rAj3pAnNikVyiBBUl4I1G4
 q5LKAi54CtqUwe6Q7zPjnLdDb1G4c3ycRP3ZZIrPmOGd06/NCYQ7j5Z/FsxnI9/1YCtq
 ijRA==
X-Gm-Message-State: AOJu0YwdqFD0i4PTRir1m5E1x8o7V+j3Q8NmN+PrqvLgwimr5iCLAO1S
 YZZNCmxExm3nahhIo+u1X+fihejKwoYMTZhJPwEiGOVjc8UT7l9IMdK3RFYXiPThFFZt+EN+DTL
 k
X-Google-Smtp-Source: AGHT+IF0srGgsFtTapvYCV3qfp9HifG87Iq8D4TbUbTZVvf7iarE6GYYQADx4xKgSwz2aOYmZSDXcQ==
X-Received: by 2002:a17:902:fc50:b0:1d8:f016:cfaf with SMTP id
 me16-20020a170902fc5000b001d8f016cfafmr5380211plb.47.1708082903518; 
 Fri, 16 Feb 2024 03:28:23 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 z10-20020a1709028f8a00b001db7709b322sm2774053plo.298.2024.02.16.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:28:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/3] target/riscv/translate.c: set vstart_eq_zero in
 mark_vs_dirty()
Date: Fri, 16 Feb 2024 08:28:06 -0300
Message-ID: <20240216112806.997948-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216112806.997948-1-dbarboza@ventanamicro.com>
References: <20240216112806.997948-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The 'vstart_eq_zero' flag which is used to determine if some insns, like
vector reductor operations, should SIGILL. At this moment the flag is
being updated only during cpu_get_tb_cpu_state(), at the start of each
translation block.

This cadence isn't enough and we're facing situations where a vector
instruction successfully updated 'vstart' to zero, but the flag was
still marked as 'false', resulting in a SIGILL because instructions are
checking the flag.

mark_vs_dirty() is called after any instruction changes Vector CSR
state, making it a good place to update 'vstart_eq_zero'.

Fixes: 8e1ee1fb57 ("target/riscv: rvv-1.0: add translation-time vector context status")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1976
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/translate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..9943538894 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -652,9 +652,13 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
  */
 static void mark_vs_dirty(DisasContext *ctx)
 {
+    TCGLabel *vstart_zero, *done;
     TCGv tmp;
 
     if (ctx->mstatus_vs != EXT_STATUS_DIRTY) {
+        vstart_zero = gen_new_label();
+        done = gen_new_label();
+
         /* Remember the state change for the rest of the TB.  */
         ctx->mstatus_vs = EXT_STATUS_DIRTY;
 
@@ -668,6 +672,24 @@ static void mark_vs_dirty(DisasContext *ctx)
             tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS);
             tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
         }
+
+        /*
+         * We can safely make 'vl_eq_vlmax = false' if we marked
+         * VS as dirty with non-zero 'vstart', i.e. there's a fault
+         * to be handled. If 'vstart' is zero then we should retain
+         * the existing 'vl_eq_vlmax' - it'll be recalculated on the
+         * start of the next TB or during vset{i}vl{i} (that forces a
+         * TB end).
+         */
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vstart, 0, vstart_zero);
+        ctx->vstart_eq_zero = false;
+        ctx->vl_eq_vlmax = false;
+        tcg_gen_br(done);
+
+        gen_set_label(vstart_zero);
+        ctx->vstart_eq_zero = true;
+
+        gen_set_label(done);
     }
 }
 #else
-- 
2.43.0


