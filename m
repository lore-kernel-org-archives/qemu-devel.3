Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8CCC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl9-0005zV-AK; Fri, 05 Apr 2024 06:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl2-0005xb-W2
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:17 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgky-0004cr-Bc
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:16 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-369ec1fbadfso8275825ab.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312711; x=1712917511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lHKXiNca9oh0uRGWThBshA56THsn/2RKbVVfZBx6X0o=;
 b=pFMDqKKlhGoRJqbGL+gOlltjb9scPN3rF8RYsL9xUWjnP9wXuBZsYDYpDSCVnBwgi5
 Vjdy2gAyxe2kCI91CwMreBcpt88p7QJQrmhN7lgcDqSGMsoZ79HvR+1fWS13jsjpN3T5
 zQIbtXWo6eAsQCFLHcBkVIS96CRHRqig+nXphi2aw+3ClErpcSLO88L2t6y/AIVezoIA
 KGht5/d1HGQBs+tUrnEeuuTPptLprj84mlUJrew0+nfS6sfND9awvtOq9XkeobEoEhXC
 NqrI18zCKiAXxb1p2ryl9TdybdZmiAG7DbQRBZGB9xjNXM45aVpRnz5Jxpe2Y7d84M7V
 kwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312711; x=1712917511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHKXiNca9oh0uRGWThBshA56THsn/2RKbVVfZBx6X0o=;
 b=p4ti2jQ1O0gUStkxKd4MOPpHFzFngexjhL7zUimgFH2E0iyNamcbUIL1ExU6tHIKYE
 0ZcOt73Lc0UfLUsctOYdjlIBVX8VBOOw3+WGj4NHCNeFtGt7WQl0KUFxTzq+W7c9g6WH
 WnTfDTkRcHse7N98mzP4xBbZPFS/9x45EEYGNVAa3Gwwlg2lvyjO3Ov3FfF+Tg0MF/T+
 28NehEMw0210Ec41DnYQ44Sq75ApV3mHO2VHNxzgLQFiShIpW/Dp2Zqr3M/N9y4chtTr
 SaEwAvxR2rI65ro4qCOTjHZ6u7fqyBH1zqyyuLEIA27jmqloThximaosyDe71+hkiKWn
 VCxw==
X-Gm-Message-State: AOJu0YymJyeBjZcobfs7QluG2P9VIbpJ/zW57BYi4sDs6dmtlijibXcl
 gWHXV/AXSauiAwAlZu/SqwULlM5xMok2cqQdmpLYugdltDGqpRup5EoPSgNQNnlSK9tYHZKxfj4
 G
X-Google-Smtp-Source: AGHT+IFwxIN0f+TCc6gxMJpW6S4lFItPT8n4MGkHXUYxhhsBJwxLQp5hdHAdh6rbYBPMim0mIq3pHQ==
X-Received: by 2002:a05:6e02:1fe1:b0:368:953a:1735 with SMTP id
 dt1-20020a056e021fe100b00368953a1735mr906180ilb.9.1712312711063; 
 Fri, 05 Apr 2024 03:25:11 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/32] accel/tcg: Record when translator_fake_ldb is used
Date: Fri,  5 Apr 2024 00:24:34 -1000
Message-Id: <20240405102459.462551-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 2 ++
 accel/tcg/translator.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index b341dfbf02..2d42a4e7ed 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -74,6 +74,7 @@ typedef enum DisasJumpType {
  * @singlestep_enabled: "Hardware" single stepping enabled.
  * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @fake_insn: True if translator_fake_ldb used.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -87,6 +88,7 @@ typedef struct DisasContextBase {
     bool singlestep_enabled;
     int8_t saved_can_do_io;
     bool plugin_enabled;
+    bool fake_insn;
     void *host_addr[2];
 
     /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 401c0ca30c..4a1c98cb63 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -141,6 +141,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->saved_can_do_io = -1;
+    db->fake_insn = false;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
     db->record_start = 0;
@@ -430,6 +431,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
     assert(pc >= db->pc_first);
+    db->fake_insn = true;
     record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1


