Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E1BC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM6-00064z-5W; Wed, 05 Jun 2024 13:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM4-000626-KQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM2-0003sg-SD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso18119a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608197; x=1718212997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pv/is3ik2pgbn45+w62VpQiiH4H5v87F5UfY3vca2so=;
 b=lGpXDOQSE52xiyFjX5q7kbTCeUJkZd1HO0zhm6popZljTU0LFQND3V9xORyZ61TCzR
 3tlN+9J5vDU7FFAMC0Y82BQgeHwqferKIICXYyV/ZPt5sp29PSEcDbPKvrmWdx+lYSf7
 xwzlhWb5hMAYJas/QIrMjXm546MLpgQF0FHAUZ4SC9A72P8vkxnFgY0PE/I4BMVwr023
 c8sKP9FSpkF68hARxA+w/b+lvjacQHHwk1nbJiM1VPS58w/LrWmLT+MutJ+M8eHetp6I
 Q1CJeKvtM7mJ5lOf/Se4zg+Ae8PbKmRc/Xnvz5tY9Aj64ZWWQds4OrUe84oztpm3BKny
 o7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608197; x=1718212997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pv/is3ik2pgbn45+w62VpQiiH4H5v87F5UfY3vca2so=;
 b=t0cqeulCWwOpKn6wVl0bx35Eygc87DTRCxZHtqi+jd1KNqdbMxaBoDhI+X7v5OKnc6
 T+IsFs9Fy6hXXdrE2fE2MBIUIivyRqgHQ8PdkZclx/uaMwnlevAYFd/JDehkgaaveD1u
 ENbLelTdUwfmW0tz8hbsKEapwdb6waHSE4icsN5QD45xr3ayBv/g/T6wYy/86DixjTPy
 SOTKunONlFcBGVsamFIMasDzXMjV5t/uX6A6MgYrVdRfQqliYwdw8P3miFp3H/K1ykCu
 TdaJvp4645U1F8JeyPIxUoWCUt5EKYVZTtTJZSHIN7YSt1GI/gF+ZcV6EhhCmrniK9jV
 00Nw==
X-Gm-Message-State: AOJu0YwiFVoGdd5NBrtUL+qoJG5AilSkTt4vSwHJ6AItIqJMpUN9bYBg
 CIoa30Yg/cGI8T+sGhYw3dcAlCje8xCovzzUaC6YNPZSk9vMzscQ1Ejh87b99O0fqxjLgcnC0hv
 6
X-Google-Smtp-Source: AGHT+IH3RXYrxxnKlLUeAVb44DZHtaSOPQXSmHp9CQ9uXrGOldlQ6wjjvmxl5zU9YpyAMRfqTLSGgw==
X-Received: by 2002:a17:90a:7105:b0:2c2:4129:a2d3 with SMTP id
 98e67ed59e1d1-2c27db5b4a6mr3682295a91.36.1717608197265; 
 Wed, 05 Jun 2024 10:23:17 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/38] target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs,
 MOVxTOd
Date: Wed,  5 Jun 2024 10:22:39 -0700
Message-Id: <20240605172253.356302-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  6 ++++++
 target/sparc/translate.c  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4766964893..e0e9248982 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -498,6 +498,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
 
+    MOVsTOuw    10 ..... 110110 00000 1 0001 0001 .....    @r_r2
+    MOVsTOsw    10 ..... 110110 00000 1 0001 0011 .....    @r_r2
+    MOVwTOs     10 ..... 110110 00000 1 0001 1001 .....    @r_r2
+    MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2
+    MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a12cc9f796..496d490cdd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5401,6 +5401,42 @@ static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
     return advance_pc(dc);
 }
 
+static bool do_movf2r(DisasContext *dc, arg_r_r *a,
+                      int (*offset)(unsigned int),
+                      void (*load)(TCGv, TCGv_ptr, tcg_target_long))
+{
+    TCGv dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    dst = gen_dest_gpr(dc, a->rd);
+    load(dst, tcg_env, offset(a->rs));
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(MOVsTOsw, VIS3B, do_movf2r, a, gen_offset_fpr_F, tcg_gen_ld32s_tl)
+TRANS(MOVsTOuw, VIS3B, do_movf2r, a, gen_offset_fpr_F, tcg_gen_ld32u_tl)
+TRANS(MOVdTOx, VIS3B, do_movf2r, a, gen_offset_fpr_D, tcg_gen_ld_tl)
+
+static bool do_movr2f(DisasContext *dc, arg_r_r *a,
+                      int (*offset)(unsigned int),
+                      void (*store)(TCGv, TCGv_ptr, tcg_target_long))
+{
+    TCGv src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    src = gen_load_gpr(dc, a->rs);
+    store(src, tcg_env, offset(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(MOVwTOs, VIS3B, do_movr2f, a, gen_offset_fpr_F, tcg_gen_st32_tl)
+TRANS(MOVxTOd, VIS3B, do_movr2f, a, gen_offset_fpr_D, tcg_gen_st_tl)
+
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-- 
2.34.1


