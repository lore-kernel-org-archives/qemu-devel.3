Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73520EDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTd-0007jh-2E; Wed, 11 Feb 2026 22:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTZ-0007iG-Nz
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:45 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTY-0008HO-9G
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:45 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d18dd2adf7so4491731a34.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867282; x=1771472082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdmJlwbRbC2WjvwLByVwTDU+h5jmM+h5HfgvxvCTvmM=;
 b=TNonaCeLv0sz0LCE+lp26ymLkyR8VnTe0byOgPIpsDD701saiIlH/YLT/Ewc7ioiVO
 iVknFQUbIlALX3KJYcKyQmjUlCjMmBOsT8tGiIuFHAVmdd1l6W24l00QYcUIMbpvJVJk
 tQ1u6U6MZPSGu/bJHigQMJ++fJvGYlwpvXSlR8/yFzC9+ty9e6/shbqeuMn2bPuuSvMH
 RRt8zUXPhnVdcBHKDY4Y+L0bNva7w8zG0rMgC1Ms9GAwNNLmdHqNjaKXrXn2X9GJcLIh
 gmLJLyYJC5JfT+WQcGlflM7NooAlebCkilwcqHNqAv7ZVIj9uk3t4c7u+Q8xa7yGEHg3
 1cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867282; x=1771472082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fdmJlwbRbC2WjvwLByVwTDU+h5jmM+h5HfgvxvCTvmM=;
 b=T8SlLVwgwMp+iAX5fb5h4Vt0cHTrI0uQ0VhriUfterTzmixMmFS+ncLsn1pU9lJ6JJ
 9MjQJMwuL7MaZ7mU9yGOKk3F1zZxLWMJJI25JjB1lM6fZa1PuefRoig8zEQPLAl2T+c6
 4+xosYc1hwgHUOxcsfJYwwNxjJ36W5wd4XL9ZbPCTc++6iauaKhnHkbga3GGBAsGo120
 oYWeiAcXvqb85Q2UPQd8nXjF9nASu2xkduc7LoigGq+cRwYhizw25z1vGCFAT5SR0f5D
 NJSu499rnqWQY7jgB6+6He0VejJI4WtP72+5tgVjUQ1YJd47jsLVBNBuf9FwRvj047is
 ByCQ==
X-Gm-Message-State: AOJu0YxZ3MS93QalqjthJG+8ap0JbsL0ut+BRqv46yHtjTEIsguUYvXM
 F9gO1xyzOuUYgnjqY6jA24YwUulhqS1gBA6veYUoo1n4F3uzvbYK5W7Ri58fWw==
X-Gm-Gg: AZuq6aIGDmrEnHboxV5fGEZbHMeGgKaEJU0BWOpOhR1E/SqSL44FsRheg9bcnaitFCX
 m9Qm85gJazVGsImddUtAVl0XWdB1I3HJaWzKiqwyz6UBl4+eYyGu6dpIVq8QoJxLnbDJKOQFh/K
 m+jRSSj6LzC4ATvlwzUEuD1YTOwk/KUWI2e3YLZg+61ku2Vv8GI/z1YaoK7TtmuUyVTudwkdAxA
 42aAf1NvD/cnD463kwrr/HNfdf21+jYi0wlmAXWLyfiL2Ars9qabdIz8/3DM3UL24AuC3nq5jkm
 jiqvJUGgTa4t7Fvs0pzqN0aMfl+IpCXANsmG223pslBIWjPYJ3Sfc2eRVNMibd0eFUqz4vP3a5R
 6nouCz4N2eT9bvd3GSE/7AYzADLqPwGSwvGaIjIgg6BUU88z3LAcV1Lz15R0LMRlScZQ72ndOE2
 Cr97bXFDiIRmYKzdZ6JeKcHlw807eF8IX4v4+MRDLaVcG2iZL6VknaHgtklCPeLlQvabjEo2EC6
 XjtcH7+nkZWh4hK
X-Received: by 2002:a05:6830:9c5:b0:7cf:e4e6:2ce9 with SMTP id
 46e09a7af769-7d4b29df1famr784694a34.9.1770867282580; 
 Wed, 11 Feb 2026 19:34:42 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:42 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 3/8] Hexagon (target/hexagon) Add Hexagon version field to
 DisasContext
Date: Wed, 11 Feb 2026 20:34:30 -0700
Message-ID: <20260212033435.3598-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x329.google.com
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

Initialize the field in hexagon_tr_init_disas_context

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 1 +
 target/hexagon/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index a0102b6cbd..7d4236b8b7 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -30,6 +30,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     Packet *pkt;
     Insn *insn;
+    HexagonVersion hex_version;
     uint32_t next_PC;
     uint32_t mem_idx;
     uint32_t num_packets;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index e88e19cc1a..9498cd4502 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -968,6 +968,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->hex_version = HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.43.0


