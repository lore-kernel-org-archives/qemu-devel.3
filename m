Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB22D31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoB-0004tf-T2; Tue, 13 Jan 2026 23:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnx-0004ay-Q9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:28 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnw-0003r4-DN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so47288055ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366103; x=1768970903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CotJR1Z3l8Bpy1C6R68fyNJ4Hc80/eynZMelGXfH+B0=;
 b=KXJ15O2pra4lK9wQ5ATVm5imY+IRKyx7IxBUdf/k2efp1VM+97U/oADwlsR22YvPqY
 M+xjutrHnmiImExz0Bn/OYxzRa3U81o/Y/danNBb1M3nTOkVCyqz1nGh+IWs5ZE2dmE8
 RECE0ER34iNz9DO2vCRkCy5d4MUua5vYcHi7t2BJN19wT4Upow2qkLU8ngoglJxkXrHJ
 Nj00dLlvKygK6GSNLRQWSESrZm7jVmNVPih50LfAmms0oW2pFb6NYGXivgP6/18ekzt8
 NNl2qGjX9gga4WrWYkrd1zdvWYkTROPI3UKLx9egarhhPq6umYzJjYa0DFSPv/Qb6lZR
 6x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366103; x=1768970903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CotJR1Z3l8Bpy1C6R68fyNJ4Hc80/eynZMelGXfH+B0=;
 b=AhApnsOonpZoYkVMs73iWtWWKsSHzbha7YJm3YFZkAc6aKFuDXWStSNNhdz9PLcA3H
 6agAaBvY+QwNWHNBHmuGPdX8kDF0fbsT6ZQUkLQ1LMM3w+pBQe2gXsL//9KQKm07lfMU
 jlaXXqIkICtOLmQPWenzp9ZFgmQy8i2eHEMIJKwKX5oqeVHHm1Jame9866sv6j80zmYZ
 K67W5vZ5omXZKV6UNZN53dprhroUehm7IJYMr9NSp/HY8nmQgU9tLndOWRhd0eZWi3jZ
 3kpBDy+91LFdE1zVaax1wU82KzRvfKJvZQbbXVZuFYS7FTrxcJ7SvI1T3wLVExpyXQtj
 gz/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQvYpDZ/C8R1UBNLZVaUM8wenD4P2QIgvGQqyXcjBjr69JON87iRJvgBWtX/xrzTEilhhf9YPE/OcK@nongnu.org
X-Gm-Message-State: AOJu0YxfPjZzQIAtpOLc3riS2ubLMNM8t4oogCtNaGUGd8FXR8VHUNzK
 VxfvJTU1E5Xg/Dn59xmNUPvWCIBA22MipeEPVhMpqid5mbZtdC5g4MIE
X-Gm-Gg: AY/fxX419IkFq7M5cHok+9uetWtIrWHJKkmDA/2Ow7xipL0GyqD+g9JBAwsypb322NE
 wHkzXgiEi9zx8fpv1qA+mKgfLXDl5Stu6CI5JfaNSSvVotuO2cDHosUvMYXKw35VNa27RRJjEzp
 cWMD6pTmAJotCEZ7vQRVNheYs/wtqOGZGJfSuPAxLIuO+EkYlOwQE69cYdhL1RK5klAYf6d+aWN
 oU51c33usDAajAcgs/unc2ht5MRKOukdOicdnp20Uz7xWUfi4c/NcBHxWvWS7zRgcWT1UJ/gM39
 4iVMSbXfATc3oNYhY5uAISPJLBXTZZLe0TxfifCH40vQKyJ7WnjpxQ9zIEGqK5BkOuUjhPysqlw
 7EK6KbaRRRqdpigV4ffZn5EaRhDkQ/jJLcoUX7LSY9mWjvcRHViKjTMlmjFFVTO88Oj4fb5KFz2
 RqOybT3Uzxh2w9lg4hW2PadYuGnQuTOiun4XPYDlxh0SNESMUzFL8R0fjQ9udMDu5PbUXqdg==
X-Received: by 2002:a17:902:d552:b0:2a0:f46a:b842 with SMTP id
 d9443c01a7336-2a599e76f97mr14835745ad.28.1768366103039; 
 Tue, 13 Jan 2026 20:48:23 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 12/25] target/riscv/debug: Put mcontrol load/store match
 address into tval
Date: Wed, 14 Jan 2026 14:46:45 +1000
Message-ID: <20260114044701.1173347-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

When an mc/mc6 trigger triggers on a load/store and raises a breakpoint
exception, put the matching memory address into tval, as is already
done for exec addresses matching.

Tval for breakpoint exceptions is optional in the spec, but it seems
more consistent to implement it for load/store if exec is implemented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index bd61b7ff02..19c45fb13c 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1075,6 +1075,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
                 if (do_trigger_action(env, i)) {
+                    env->badaddr = wp->vaddr;
                     return true;
                 }
             }
@@ -1093,6 +1094,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
                 if (do_trigger_action(env, i)) {
+                    env->badaddr = wp->vaddr;
                     return true;
                 }
             }
-- 
2.51.0


