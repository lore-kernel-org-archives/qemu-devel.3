Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848A0C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTl9-0000I8-Ji; Tue, 05 Mar 2024 07:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTkz-0008Oo-UK
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTks-0003Da-Bp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412e4619e5eso14088275e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641124; x=1710245924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1lN+fUrX1yI6hMkThPuuG28B1/LgsqaW0mrtGfmT/8=;
 b=JggpSdqGJPnsOvVpGO/8SEOliK6if/zOBmGhPpah1ogblTql9c1em+2Nj///He7RMj
 wFsEqrg9g9rARWf4GGaNNhPwipcLwEsy1Abs+rHDAp0g9NL4jlXrQdR8ffCDZM7Wjc2l
 RCJWk+4r+g8HHjv76RK1dXCqonf/tv2P573HTL92fkwYyTKQt756j+tvsvNEy7jv0A6I
 ZKwtCozlnJ78c8KJ57CHgc35gCvCIlxi72GUfXdumUw0cpFxYh4fCD+/5N0iuVu5Uj8i
 SsNaj1GvslAoNkkCBgNQi3/WdjObyQ9JRiQmuCg7VLFKJ3bqRtFwN00RLL0PaDPyDK6r
 cYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641124; x=1710245924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1lN+fUrX1yI6hMkThPuuG28B1/LgsqaW0mrtGfmT/8=;
 b=t/+rZ5PqySVRDISg3LQ6DtB5sqlsOQTh20mW10QhMwfefUx7ZiQjAWSi7gHusjXed+
 UoK3mJMIxxdfmtCTG4iEWptkfkENcMbkbWO+xk/JSQsx8ZD1b0Yyew8pG1/cDVWNoK6/
 bLIblzuCKUFuKZ4BvCdbgYlgSzG+Qaq9cZ9pzphmOOYedSDfWFoZVY7nDFWQsJI3IMBI
 vQSoCkTDgANwt0UZAacpRzwH8FayllUp0qGhTMKBwAQOun/Ln4X2NdUTUUA1Ygh0Lq69
 tOVRSVoC6eKNB5pEZ5k8xZ5lAJe8bVMO2dUixh1FNJLxZ5MxVRfTkEXvtm9zYWdb3mTt
 qljQ==
X-Gm-Message-State: AOJu0YwaXkoHTSDTx0kcBRQgR9Scx/+otsNo6y2kG1/2FKRNeGLJqxIi
 wRtjJhqHMI+8bV+aTvH1ZiRNON8r8lbMJvZqZ68z9I+HD7DkeDZpL3B1S20MZx4=
X-Google-Smtp-Source: AGHT+IFIxNu71j7Y2KVErvOFS2FGyXwefyeOtJLrmxDxFA0pddvyB2e6Oh1Znch+jL/wsSubC4XxIw==
X-Received: by 2002:a05:600c:4f0d:b0:412:beee:36b3 with SMTP id
 l13-20020a05600c4f0d00b00412beee36b3mr9351811wmq.7.1709641124451; 
 Tue, 05 Mar 2024 04:18:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l21-20020a05600c4f1500b004101543e843sm20823499wmq.10.2024.03.05.04.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 239F45FA03;
 Tue,  5 Mar 2024 12:10:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 29/29] target/riscv: honour show_opcodes when disassembling
Date: Tue,  5 Mar 2024 12:10:05 +0000
Message-Id: <20240305121005.3528075-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This makes the output suitable when used for plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 disas/riscv.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a546d5ea53..9dec8fa966f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5192,19 +5192,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
     }
 
-    switch (len) {
-    case 2:
-        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
-        break;
-    case 4:
-        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
-        break;
-    case 6:
-        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
-        break;
-    default:
-        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
-        break;
+    if (!info->show_opcodes) {
+        switch (len) {
+        case 2:
+            (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
+            break;
+        case 4:
+            (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
+            break;
+        case 6:
+            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
+            break;
+        default:
+            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
+            break;
+        }
     }
 
     disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
-- 
2.39.2


