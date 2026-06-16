Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9172CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhm-0001iW-VZ; Tue, 16 Jun 2026 06:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhZ-0001a8-QP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:27 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhY-0003Sr-2c
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so2907900a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604443; x=1782209243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4niY5r5fgwLd4NzvX3v5BZyv3X55J8xjoqPGbl4BPcw=;
 b=OITyXillDWuydd16qwsb7szITdWJrvvvrCBC0OenGVn3mh1OeAomIEW98Pwuoeb489
 ZI8LlL2VJgVeDp9KZdi8rdOFBuD3IgXE4Ttng/k6J7FM+n9sU/riZr4a7216/Cimlkcr
 zVUz8ALLLdZvzkmJwdOi3KP0PEEiUfzAHO9HCGytBDd1lwUJimVTJETfs6e2iJrUi8e6
 jtWSgDjBmFjXtGsiNWdZyuGo9YCv3+c6DRwf7gj6i/X2EBYn6HfxNe1Lk8OrMW9rVdTr
 K247YbasIqsMIT0DfH1mN0ZXiqeaFe62Vbl0biHHSAJbRcRwvehqVmqLjA7OmbfydoQD
 4Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604443; x=1782209243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4niY5r5fgwLd4NzvX3v5BZyv3X55J8xjoqPGbl4BPcw=;
 b=jsQjIL3IpJf4Sv75CkatQcWmvJ96bp3Y9Y4cOFw1Us/0z9iHBz+BwVqeqHHxn4bFQ4
 mdHoxAD9GhVianO/PqDgIG0KMiDy6TtogdBc0xqfXmmz/Qy7XsiCAk61SaRS7bx916eO
 rS059EIm3ew9kILHttYGnU3VX1OxvxBTqSXMq+NquKPEV2Z1sfwlEs7g1Bv11DanoXxr
 f37/deN90r93eDaV607SQJh7yH28lUkCAOrEBmYgvB5lrIgPBPpCY1VCkDmaBLmmErDc
 rQ5UUW/aEHdYxiTnFGHWCHjaQBSzqOz80oVGbdvJj0g3Fg6Dzwil1/elu30s59F0TNDH
 Mmmw==
X-Gm-Message-State: AOJu0YyYwt6EY7srb0F14TXsLbRcscuVzMjxyoOwAWeg8I5GyTnunJKe
 kwpYK3DIvjaIg5dfJ24oqzOoIxrLzIRRM6ohvIn9JTtmXXy6ygg+EVn+acgceAQ+
X-Gm-Gg: Acq92OE6carFDa6COg1eFeGERiWiHXFqoehGPytwXYcomdSGGz6R0sy7DY/xVz9bzGT
 kyzdvBxMp5oIDDXYu0EOgE4ghDFWjGZ+qeqme36E43y0DiisQ2ycMnznbnlgmNJGluTIwICA2yB
 K38i67/BlxM2kVf60tGAZSqnTAjKxMj2IzaMTi2aUt9tFMXBxZxC3s5rmHC2zoocQBnuo3lX/vp
 T4a/0Hn3h0lOrjAChSwM5NRDcL4efAI0x5boq+GKjZmi2gl5jZOKdOjx8k8KFP52zqV7840uMob
 v3Xb9LQWc3JkYqL6sb1DTvPeMVVAs2Y6wNF87qKx9fPKbT0JbX8bNPjZsE7JGld4HaVNQ099PJW
 YS/lJ8nI3cEeWpmYFr/k9f76wHbg4scOpHTrjJwWzYl8XRDrpPgFNCRl9mc+2+5QlL417DIUzf4
 xCI9fQ/LFvgrIMQzA97s8BiAelapsLcKuLEz7tzj08
X-Received: by 2002:a05:6a20:729a:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3b79629990emr16135796637.15.1781604442640; 
 Tue, 16 Jun 2026 03:07:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/83] target/riscv: Fix size of trigger data
Date: Tue, 16 Jun 2026 20:04:34 +1000
Message-ID: <20260616100527.1939565-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Anton Johansson <anjo@rev.ng>

mcontext is at most 14 bits in size with the H extension, fix to 16
bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
elements, fix to 8 bits.

This patch also adds a migration entry for mcontext which is used in
tandem with other debug data that is already migrated.

Note, the cpu/debug VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-21-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 10 +++++-----
 target/riscv/machine.c | 13 +++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 48d5c769f1..45dc0393f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -468,11 +468,11 @@ struct CPUArchState {
     target_ulong mseccfg;
 
     /* trigger module */
-    target_ulong trigger_cur;
-    target_ulong tdata1[RV_MAX_TRIGGERS];
-    target_ulong tdata2[RV_MAX_TRIGGERS];
-    target_ulong tdata3[RV_MAX_TRIGGERS];
-    target_ulong mcontext;
+    uint16_t mcontext;
+    uint8_t trigger_cur;
+    uint64_t tdata1[RV_MAX_TRIGGERS];
+    uint64_t tdata2[RV_MAX_TRIGGERS];
+    uint64_t tdata3[RV_MAX_TRIGGERS];
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 45fd39994e..78ca607b48 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -240,15 +240,16 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT16(env.mcontext, RISCVCPU),
+        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
+        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.54.0


