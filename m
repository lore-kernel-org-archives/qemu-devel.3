Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE4C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qh-0001mn-IM; Thu, 09 Jul 2026 22:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QH-0001Va-MT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:07 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QF-0008US-19
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:04 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so285143a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652221; x=1784257021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/1A6XopDIO5frhdvaV0+entXYW56QIkn4T7CUwO/g7U=;
 b=rse1sLwhb/lCxm+SiAsBCCRnR6od1LYsjTJGP3HcwU1ArGhFDZXt1qKd1oRzd1nV2X
 UOJV9qMePPQrhSZDvy/qnX+PMCr78pG5DUgCyg5qrbaNaf2bfvTyguzZv0adLuy0A7dQ
 olHdK4BSLDj6rZNX0pbkRtdqFSSrhZbI0A4I3NE84FP1/7/ajNeuhj3Jf5pYLaDIkaZp
 8TbrIR9j2bBNd7wxCqeffA4JmHrvuuHLl11Onte8WD8vxxoY/g7+zwK3uy9gw5O0kAkC
 70Z+gGb97cf5MrohB5ua+TVBQ0J4ifK095XSw83Asn3D15eHMN64ICLssd/KmsbkGtYu
 Q6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652221; x=1784257021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/1A6XopDIO5frhdvaV0+entXYW56QIkn4T7CUwO/g7U=;
 b=nLwfAZzzjgGPKkHSnyWV+25EnZrxuipSUH/8kcK+ClZCGyPrSXxhZLNkGdhrkQ9Jol
 gMomX29kRoDaeoUn4SFrST+jOZLMccc+AQS40xQjJTSkN2d50x/jwycNNJhOaUGJ5+jK
 XCCLzsFWJTh/TlrDI4lwmfCsyWFCBMpi4C6855IxRWn2CT6uzHW5wIKYoShB+CW/JTo8
 rDf0jgCq6L+V8cPBij9Cj+81ciu1HJZez40p5wPOBijMydSzFsKYW5nYsjNA1In2xmd/
 2fuZZLOhV0sy24UtNXmtB8JmxkvOVk7PTffsj+omHHZ7uwoX34rjzSn3Wl2qzPZmG6W3
 mEyQ==
X-Gm-Message-State: AOJu0Yz/p8R8Ik2gl3yBmuXDwYi9xBGZH4tF7/xpF1Ho4kZDP//0MCJI
 ZgRAJ5eAgVo+/UTflnogUAPMnBsw8jgoHMf22VQi2HKHARmuBOagzeIsHRcahw==
X-Gm-Gg: AfdE7ckXLvetku4e7lH/WreOcdf21eydipHLwTzXgov0lELzLRRK52ckjNd26XkADRO
 JZVk4+nZ5oPX5Jg3DswPm0jPoyZ1nTPdwP6aylhvgA9FdgKbvW5pEHPAbaHXv0+Tm1pejxeCRwO
 t0DfkrTJA5DDaPpWSvrRyHIibUgSFUFxyGfUCx27pQSxx6IohP8oTfGriNJrpEVvYzuUwqkvkG8
 NddkjCG8WDP0QZKom8pJhJaB3arESHXwKsNHM8C3X+DpgYSoanTkNDWYLUlk0m3O04L0BSzrWi7
 0ZGt5R984saL5Io5/5hUIfW8UA/ITZLnk+y7lLyMIcFEOmq0f74x9zmDyudpT4El641jCEk1I73
 udPuL1wDedI3ylqDIkqnqNausMHqn2ebFh0L5KrFZKmtf69zUcCKoW3R81/eCHsWWDARBXcqCC2
 jSliUT04rBNKbxkw5uiqdI1W6JzSPXHkc=
X-Received: by 2002:a05:6a20:c996:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3c0bcb7f203mr12225850637.39.1783652221606; 
 Thu, 09 Jul 2026 19:57:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/40] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Date: Fri, 10 Jul 2026 12:55:11 +1000
Message-ID: <20260710025525.1704417-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

There's no need for it to be in cpu_helper since riscv_aclint is the
only caller.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-21-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            | 2 --
 hw/intc/riscv_aclint.c        | 8 ++++++++
 target/riscv/tcg/cpu_helper.c | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 396d9253e6..d6c5d6c1db 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -682,8 +682,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e27e5fb394..361a8d1bcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
     int num;
 } riscv_aclint_mtimer_callback;
 
+static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
+                                    uint64_t (*fn)(void *),
+                                    void *arg)
+{
+    env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
+}
+
 static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index aded995a7f..7a1ea53ae7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
-- 
2.54.0


