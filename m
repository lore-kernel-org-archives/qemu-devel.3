Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E400D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RR-0006dq-Uy; Fri, 09 Jan 2026 01:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Q7-0004wt-Ua
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:28 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Q6-0002tl-Fa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:27 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c0ec27cad8cso1779808a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941785; x=1768546585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZA2w/oxYr+Q1uGgUesLYCh7glRA4PbkOh40jya8E0ng=;
 b=gRR5pONdGct2/3I67wFBmvsZ8BqnehMPIoTlhWOIZ6g97Uxv6JJXlucUH/EjYAL0CP
 DYkPEklaMrowRyOWLqNjpUzTg+Q4Fpm/qYKgIB97sGQrztfiOA7yEt9a1MpsXmIYNS97
 gWvs5hR4ls/1y1rd9HQHeJo6UoQqMG21A1LuEnIkTpzWQn2z0XUHxNY3K3+6y/ThRLS4
 UVowhwzmNJ0HNmhB5tGF0MD9vJNp0MihTetdwr9j2pYZr1XRD/PUcd+42Ft9sJpuPdOp
 4uGR8TnLYi8OXqZc/YuUagtVga9s+kVq5as6SKLKRgYs5wPK6WWbNA4d8gV8UZoYL6z1
 OCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941785; x=1768546585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZA2w/oxYr+Q1uGgUesLYCh7glRA4PbkOh40jya8E0ng=;
 b=QAXxVdvCmXR+TdEk7fLtAdHQyZyPXvgP94Ib8cWgmDTGRfw4BGhBBUevH7xab1aUnu
 FXxq+tjrviXokLf7Fqz4G8rU+E38MjEgzO8HW67+Btds7IyVeTaWUVTzP/+lKJeepDex
 zHnqjt2IqMPhflphjq+9WP1Rx1iE/EzrdD/jcwgH7H+9kcoG8vZbXt2nrNJ1o+AZZvlb
 EglbOKxP3cZU+PKq8dDeLyhDP0HC/b/80tUNhISUJ4TQJ7e3dRtrpvACU7O06+ysMm1F
 pNe06pjnc7l9AJVQ2Yddlc19OBIfBbxqjFFx1mZQ5z/1uVyWVo4xkfSBu+2/+NT7MYIq
 Y6tA==
X-Gm-Message-State: AOJu0Yyj4Lr2e/CnTlgr2SoZItngu/mn5WE4LqEami09nYzm7hfDiYvK
 Kis7y+NiAbPJ5lT8h271BF4Ls7bu3s1h9/6pXXpEL+X0frrpIykru2JXNOgYow==
X-Gm-Gg: AY/fxX772TzQepB7KcRf01qvZBesguRtnjVD0Osrzwk6nfzx8o1yZyibsgF34PNZm84
 xVJqaEFoHFdNTTJcTKRBue7sKD7uyX6jAFBdiFILp1IqFQG10NZKeVlq3AN98z/74TPutN+ZT+f
 518prunl3MTus92kFt1jXcJ+ftcYB0EhXkZ8ZmkwYgkPa8Poy2U2RPn4xYDbOvZER0yjxYubCju
 iONGvQ1QEmKOuTB/bHS9GwoM66rzuU/9e5c6qgBXInC2Tj8IlIbkcb+of4kXi44Us7+zhMdOFMU
 1MbxdHvpdnci9HLlvvJZ6DZWpN5b2393AkqHgzaqU4jqk8TowFkdB0pGfw6fxDWZg33RRIEsvtt
 EN/g7SiyVtA4Csh7dj2W7c4WZgKgzjl9p+rCp5kYCT8pyEkAmEhpknXU+z6nYDadydpLHauwAEg
 a9HeOBM0FHc+H3yG4fBPJJxG6fTfbDOWFmgYbE8zo7avoHZvNNgGMOoQmkFz8KRpzpUV07QJjTq
 hB+klMigUeqXem7REY=
X-Google-Smtp-Source: AGHT+IFCWpbCiHtiyXIPQw8DIoPLQiEFu+8f/F0Oxyc/l4eqnbLGPn9FWqZEx25EDZ0WhWq365qjTA==
X-Received: by 2002:a05:6a21:99a9:b0:33f:df99:11e5 with SMTP id
 adf61e73a8af0-3898f906dadmr7573801637.28.1767941784622; 
 Thu, 08 Jan 2026 22:56:24 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:23 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/34] target/riscv: Add cpu_set_exception_base
Date: Fri,  9 Jan 2026 16:54:48 +1000
Message-ID: <20260109065459.19987-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260108134128.2218102-2-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0939e6f08c..08a6e491f3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -668,6 +668,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f22b504772..c2222228d5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *cpu;
+    CPUState *cs = qemu_get_cpu(vp_index);
+    if (cs == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    cpu = RISCV_CPU(cs);
+    cpu->env.resetvec = address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
 {
 #define BOOL_FIELD(x) dest->x |= src->x;
-- 
2.52.0


