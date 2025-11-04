Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 22:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGPTY-0005Bv-HZ; Tue, 04 Nov 2025 17:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTR-0005AV-JO
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:57 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGPTO-0002hj-SG
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:25:57 -0500
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-940d327df21so260645939f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762295153; x=1762899953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ne+KlfGH9wk2z4bZd3mvdd2WbCMDPCWdJHP7tFuYY0E=;
 b=N0mQ98yQQaMy1nIyyu4IVc60hbIqZ4zhGjcF11KFtbnTmrFpio1edkavokaC73fLD5
 EzGfBhJwm7N/raGA3HKhnnevHDfJinUL2cW2/rLJxcRXP5FB/VKCObOEQlEpzfgmu6y1
 fJRqA581VPZrdBG6eP0zaP0BzuV4hwoKYdTnFVSC+vWpe5LOPlyFXsQE+M93SOJeLD8Q
 1w4hOcyYfkUq3q4u123dYhdZ+ygPbN6NZXCFohVCIfpiuayG9+GRl3L3e55Cvpq3CPI5
 XR5fxS1RtI9AWJTxN6UCSM+j6/pUDZX/AzDvdxZeaqH7EcSgjXRF5oxkNPBsjZReENcA
 8pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762295153; x=1762899953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ne+KlfGH9wk2z4bZd3mvdd2WbCMDPCWdJHP7tFuYY0E=;
 b=Vr866jjquSP/2nb8eyjpfDrtufg21Fiu8bvzDYOmXy4IjH5glfGorOiOxt2t4UOzcJ
 r1XNr1G/jhNjHJ9t0cJQtM2rk9ggsTLth1d8rKbIgX7ka/ntqT172cQxsGdhrsKFNVU2
 26CwVUwGBh+mU5ccOemxCUnwBjARJla+yM3E2+gD65/xWI1P6o3zKU80hWad1H4xCNSE
 E3eYOgLm2+iRz8bvIdQw3eL5Es7BJDs6qrioqnVJpCTg2L2wOlnMR1TRe9nWyDrzGMtM
 pLjdTk/v9VcIlKkl1UwNXpPu+fkEfT08BJDEv/vVw4opzkMGXUAeugaEWOymhd50RvTI
 a/IQ==
X-Gm-Message-State: AOJu0YzOsSLm3Fhxy0wMJwssFMMtNrilSMmX8ysJIHudh7CTegAh1gCK
 39TmVTihKMxt22C43qtRkIJhPrAip3YgDmM3R9O7TAvLh5pSrG2xPkH3JnkzCiu50bc=
X-Gm-Gg: ASbGncv6espeFf0xW2SK6WHvNoslMXg2gOw0G7iab5iSzEN8ZP5g7fTS7JBaDkiivB0
 52oXjsD7iIkuYrVSIugXBHFXfSpVlG0g7YrZrNXDjnAvPxT8RI4941dom+HJbMTNeVDg3HTZMXJ
 HUHstPfqhsFytAYek8PDuEgAabcaZ6F/zyOxpTbGR8VN6o5FEbuDhzqlduWH0boomlDgtm9d2xf
 25fer6dvmS55t8ExfcD5gsx/RR+1aU4Y5x8zYsNGRg/6LvsHx+2tJehBulfD/gjMDV3rZyZRh2L
 2ENBc6p/GyY8xr9KMHfcTLN94XlzT3f1p1/DudkEqy9BFXCqJH9HVRz0aSHMpbOxKEnixILzGba
 RsESSArsVpJlRlpoo0f/dskaIvliq2wZqXYbYKVVD+a/O4TaCuXbTHFQpTrAr0D0TB+SKS5Ez3X
 ZIE8oKJY1Jl/XIfw/BgA/MYhQhth8XXjsbSFKbtNIbc1x/rLx5Yi0tCMDUdHTO9xDsew==
X-Google-Smtp-Source: AGHT+IFTjvcsReEHQN+St6B0Xnie65vdXXXsQIYfDpsqmZdQU0Ih0PtDyLSV2ONQV+Kxq3gWMUR/BA==
X-Received: by 2002:a05:6e02:380b:b0:42d:7dea:1e04 with SMTP id
 e9e14a558f8ab-433407c7e37mr14284385ab.25.1762295152965; 
 Tue, 04 Nov 2025 14:25:52 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7224a84c3sm1755789173.0.2025.11.04.14.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:25:52 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/3] Hexagon (target/hexagon) Implicit writes to USR don't
 force packet commit
Date: Tue,  4 Nov 2025 15:25:47 -0700
Message-ID: <20251104222548.108264-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
References: <20251104222548.108264-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implicit writes to USR are only to specific fields of USR to indicate
side effects (e.g., saturation overflow, floating point status).
In these cases, we don't force a packet commit. This will allow more
packets to be short-circuited (avoid writing the results to temporaries).

When there is a packet commit with an implicit write to USR, we initialize
new_value_usr during gen_start_packet and write to USR in gen_reg_writes.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h |  1 +
 target/hexagon/translate.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d251e2233f..a0102b6cbd 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -39,6 +39,7 @@ typedef struct DisasContext {
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
+    bool implicit_usr_write;
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0d..f3240953b5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -272,12 +272,7 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
 {
     uint16_t opcode = ctx->insn->opcode;
     if (GET_ATTRIB(opcode, attrib)) {
-        /*
-         * USR is used to set overflow and FP exceptions,
-         * so treat it as conditional
-         */
-        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC) ||
-                             rnum == HEX_REG_USR;
+        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC);
 
         /* LC0/LC1 is conditionally written by endloop instructions */
         if ((rnum == HEX_REG_LC0 || rnum == HEX_REG_LC1) &&
@@ -291,6 +286,14 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
     }
 }
 
+static void mark_implicit_usr_write(DisasContext *ctx, int attrib)
+{
+    uint16_t opcode = ctx->insn->opcode;
+    if (GET_ATTRIB(opcode, attrib)) {
+        ctx->implicit_usr_write = true;
+    }
+}
+
 static void mark_implicit_reg_writes(DisasContext *ctx)
 {
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_FP,  HEX_REG_FP);
@@ -300,8 +303,9 @@ static void mark_implicit_reg_writes(DisasContext *ctx)
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA0, HEX_REG_SA0);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_LC1, HEX_REG_LC1);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA1, HEX_REG_SA1);
-    mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_USR, HEX_REG_USR);
-    mark_implicit_reg_write(ctx, A_FPOP, HEX_REG_USR);
+
+    mark_implicit_usr_write(ctx, A_IMPLICIT_WRITES_USR);
+    mark_implicit_usr_write(ctx, A_FPOP);
 }
 
 static void mark_implicit_pred_write(DisasContext *ctx, int attrib, int pnum)
@@ -351,11 +355,6 @@ static bool need_commit(DisasContext *ctx)
         }
     }
 
-    /* Floating point instructions are hard-coded to use new_value */
-    if (check_for_attrib(pkt, A_FPOP)) {
-        return true;
-    }
-
     if (ctx->read_after_write || ctx->has_hvx_overlap) {
         return true;
     }
@@ -467,6 +466,12 @@ static void gen_start_packet(DisasContext *ctx)
         }
     }
 
+    /* Preload usr to new_value_usr */
+    if (ctx->need_commit && ctx->implicit_usr_write &&
+        !test_bit(HEX_REG_USR, ctx->regs_written)) {
+        tcg_gen_mov_tl(hex_new_value_usr, hex_gpr[HEX_REG_USR]);
+    }
+
     /*
      * Preload the predicated pred registers into ctx->new_pred_value[pred_num]
      * Only endloop instructions conditionally write to pred registers
@@ -587,6 +592,10 @@ static void gen_reg_writes(DisasContext *ctx)
             ctx->is_tight_loop = false;
         }
     }
+
+    if (ctx->implicit_usr_write && !test_bit(HEX_REG_USR, ctx->regs_written)) {
+        tcg_gen_mov_tl(hex_gpr[HEX_REG_USR], hex_new_value_usr);
+    }
 }
 
 static void gen_pred_writes(DisasContext *ctx)
-- 
2.43.0


