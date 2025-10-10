Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B6CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77EO-0001s6-0g; Fri, 10 Oct 2025 03:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EM-0001py-Am
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EI-0007zp-3n
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1230527f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080071; x=1760684871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d30YYNmHwarOg/r+JSVSyGJ5zYVaQZ1NNhtRlQ3t2ms=;
 b=mWWFjDrH0j5nAbSpqTV4qZWvp4Al15SW1HNyZI52c2sjZWusqD1ZR6xZGVD/8SDSzq
 S+IU+QDE01tN8S5BF6xwtRuhdTJcrvo53tdzXLaQ+Nqwbl1mAj2EELX2TRHOZsbNb+2o
 NAnDxxkLSOHZ/0MehhefypIDjtxJzxokqFiJGcYHfti1lv2WAcZPocZ2OsL7E/n1gBbl
 qctknURWtUR87TaTA9aXqle9MHFiRbrcbKMApWfR5sYfiIlafrNPbb2z6iOarXdHB04D
 ZkE6zte7s/KmZDxdRYjul6UrdNgMgTxYgDlUtEgjPkdFWvPC7eWCmIx7ESUolilvfcjt
 fYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080071; x=1760684871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d30YYNmHwarOg/r+JSVSyGJ5zYVaQZ1NNhtRlQ3t2ms=;
 b=W3IbdhwgYNP98oK8LTG6RA2OlN6zZuV3ejy/Qtv9s/MbMkeuqO3v314yXYby5edoju
 7VZ9au7dCc7S1WkziE/QR/zdxl9ENGYejqbOLr07NDXFHEF2EwztP6s9e0BBvqd4OCld
 hDIjTLz4ZuzRtVHFHtE/jPo+L+BZ/+muim4bKNm1AGUv9Qtgls1pH8HGrTvyfWoipw1z
 Y9suixF7PToxPTtfMv3VN4cq94wTjF1WLfb3HrWMjqscZN2nV8azL3Epbv5yyg3B/rLW
 q8u3Fau3ouQ7uftO7vdT89jtLh5RkSBS9ooUfieydAm1T6GbzaOT/oEXVfcROPNFPDUl
 pMOw==
X-Gm-Message-State: AOJu0YzFIqcscR1fI6srmvyvEVqxu//XgjAy7Uick1ZLqIcXfHIFJ82f
 D24lIDpNxR94ndfzV2s4xktkOlT4Ymf/G4SpFsRf0c9cL1G34Te7Jrbk8HryXG9a+otq3F3lMel
 G8qC5i2WRew==
X-Gm-Gg: ASbGncsKu2lsE/KTKvHwMn5N0HWWg9cpcH1YX6Ym45rvzlpTrBKlrVoccR+ZZqPeJNs
 G9+uJ/JTB0SY4ZLRTSs9ZsWHqvJE5amcquiN/Pq6NeooLnC132wBHsmGY7fOpNpK41lKR0IwgF3
 9qHEHgAm1/AYAAOPCTfeTSHUsH8qIPDkMzBB5v+YKNSHCTb1X48jbkJCtEWfaME88IQVYeaTAlD
 Z14nd5CVsX00esx3+DwGrxKKu3QLhP5BM0wbnaoYk3LmWXtQVavwmN1Mx2inv6U1XQXBpkM8iY6
 Dj+emUFVGmyYe9/IBiTDUb0Ye4bp8FVay60TZw2H73TThfIsDNvAqhggFimpOm5If4OzWA++87r
 vPGQ9AoqdR5o6+daHGX726rWzKI2poKjKqzeHgmKLlEPowWrt6ptn0GsmqqoLB3eEOy2lvM81bd
 c0I9pHpHFHKB31nkSYyVGKbfSu2i+8OIm9/XQ=
X-Google-Smtp-Source: AGHT+IFg33Gpc5ZWlDCKoSmDKPB+XGvib0cDFQAc5Ab7IgaQ1CEZFA4n7YaoDQtTbSy2GBv+pJN7CQ==
X-Received: by 2002:a05:6000:2408:b0:3eb:9447:b97a with SMTP id
 ffacd0b85a97d-4266e8de12bmr6411352f8f.54.1760080071585; 
 Fri, 10 Oct 2025 00:07:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm34780305e9.10.2025.10.10.00.07.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/13] target/openrisc: Introduce mo_endian() helper
Date: Fri, 10 Oct 2025 09:06:58 +0200
Message-ID: <20251010070702.51484-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

mo_endian() returns the target endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7363c45425e..6879a0cff80 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -59,6 +59,11 @@ typedef struct DisasContext {
     TCGv zero;
 } DisasContext;
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 static inline bool is_user(DisasContext *dc)
 {
 #ifdef CONFIG_USER_ONLY
@@ -622,7 +627,8 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx,
+                       mo_endian(dc) | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -633,7 +639,7 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
     TCGv ea;
 
     check_r0_write(dc, a->d);
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
@@ -689,7 +695,8 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
+                              cpu_R(dc, a->b), dc->mem_idx,
+                              mo_endian(dc) | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -706,7 +713,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
     TCGv t0 = tcg_temp_new();
 
-    mop |= MO_TE;
+    mop |= mo_endian(dc);
     tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
 }
-- 
2.51.0


