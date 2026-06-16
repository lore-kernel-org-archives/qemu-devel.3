Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8704CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhy-0002kx-H9; Tue, 16 Jun 2026 06:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhu-0002FP-PR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:46 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQht-0003Wp-5I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:46 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso2619588a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604464; x=1782209264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4qtZkwrlgnvUjXfrU2XfaUYkQ/M2t4pWQ1LP8LHX5k=;
 b=DCEyai0qFlCcf00dheIuqO4bG1WJUuyBbgA4HYJ3BW8PjCmv65EL6+72dx517iyrTx
 pjte+8Aaz3CCD0qnhEhF24tEhD2B2hxzkFXB1ib+Ow4WhBPcHkOrUqe7Pgs28HnJEMP7
 slgSRT+REYhPMQp2rmlNPsqtzO+PryZ0hJf7I4rWKqDhLKLxLlrKwB9nYb18C2vvde1F
 V6y9B+IaXkAhzy/jNhJfiuQhWqW+FDLhmYHyFngzKUgvVLcDufm8+CHcBRw2ajSBmHj7
 s5vNOefyoIFua0OswKVfPCclcclvMzFElPl3Rhr92PnuesL9mEXBqVqrynAwaq6P5YOv
 3hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604464; x=1782209264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t4qtZkwrlgnvUjXfrU2XfaUYkQ/M2t4pWQ1LP8LHX5k=;
 b=c8fmnYIEc1ovGp4uC0m9i60XFgh92HdgnzUSbXuAZDZHPuJ0slEwX2DjTtrw6DYRdd
 bcSYGBH8Uwq8I+lO3LRl3kPddYgo6i/XYICAy6xq+Zxep7McKX0Uz3HK8gbwqIpTpk8Q
 pVRs2Xhl4qdBrCZrg4NL8n1IuEuNY4v7g6ZceEDdUdzDS9VTe8bHyaKcYsUroY+cN8+5
 kA+PHqwS1oRq5q5e4e7PquENFUcna0OownUu27+FnWWo8f1S2d8ykF3+H2OYvMPfqxoX
 nw+4+INhj9JZulKKMc61HC23hXbrc4XfOAwnpK+wNvNqaEOehWAhr8Ca8Ke751T4Igx9
 p/pw==
X-Gm-Message-State: AOJu0YxxHLvdiB6xIJbk8OVtFJVme3OaeyTgEol7kfegQVotyxjOlzju
 70vYfSHVaqiX+EPbkSekO6UInY8m9tnEMyo9Y9bK8nK19r2wZ+zQ34sGTnMaK2Jw
X-Gm-Gg: Acq92OEu5/7FGokYx6GOe8e2onWUkpD6jlyae+qFsDzLqAEmF4qlJdBIgyNoQz779GV
 xUJCPKX+M0AcONxPaxVf6uVpGg28gBJCc1xkWGNs+yvInjtXHLjkiGqlB3tgJ2UprR1OO1xcynU
 rjgk6favUxYduJzHMZJf/grJp9AHvx8KUBtCn7ZonUqZrE3ZlWKHgq/2b767lvY11+iP0Sa3BIW
 47DkC9KO5vuVe5t1nNNzjzvmPgJ8aoiBor9UuI9AvQ2TVa6ebPNyevQjvK+sPRJfEYWtCvCiwad
 7IxvgVOV5sQHE1LWjmD6SVJ0iUrR3h4Z7bMOOLgX3VmGHq0IWnEYL5qUoJlvK7RdQ8CuAw6yHW/
 dxeyIYHNILolMC5XlDXBBLYTf49vHtj0iiyJNWCGuFc/AHLwBCdYjTnNMeNng8Uz3XwzWfXpJbg
 zu55xH1HPg1t5xj2XcFMOzNwc+rG9lCJj7LT8K+neq
X-Received: by 2002:a05:6a20:d808:b0:3b4:68c1:237b with SMTP id
 adf61e73a8af0-3b7962d74f0mr16096795637.19.1781604463758; 
 Tue, 16 Jun 2026 03:07:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/83] target/riscv: Pass address as uint64_t in
 cpu_set_exception_base()
Date: Tue, 16 Jun 2026 20:04:40 +1000
Message-ID: <20260616100527.1939565-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The corresponding field CPUArchState::resetvec is uint64_t anyway, no
need to use target_ulong.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-27-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e7ecc02b64..3e33efdc60 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -681,7 +681,7 @@ uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
 
 #ifndef CONFIG_USER_ONLY
-void cpu_set_exception_base(int vp_index, target_ulong address);
+void cpu_set_exception_base(int vp_index, uint64_t address);
 #endif
 
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bcc8a6bcb1..65bf931296 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -76,7 +76,7 @@ bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname)
 
 #ifndef CONFIG_USER_ONLY
 /* This is used in runtime only. */
-void cpu_set_exception_base(int vp_index, target_ulong address)
+void cpu_set_exception_base(int vp_index, uint64_t address)
 {
     RISCVCPU *cpu;
     CPUState *cs = qemu_get_cpu(vp_index);
-- 
2.54.0


