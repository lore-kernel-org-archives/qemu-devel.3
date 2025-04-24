Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1450C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGv-0005EJ-3i; Wed, 23 Apr 2025 21:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFT-0002lU-2w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:33 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFQ-0007AK-IF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:30 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso403721b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457566; x=1746062366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oOPlOdbDbguknjepjxusIV42ybLDvwlv6HjsVhp9s/A=;
 b=XrAW8oSeJEtOiKrsWSui6N4omM/rDcpmAlKvRudF5u2rThZZXbAO8T/9/liFcPgg4X
 qtyawjlwY+iR3KKtFnqnlHRguI0/aOkB33YnGz0jQejXPuVmUxEFK+x23EMYWJDlN41F
 iagPf+xVlZKuRfxkclQTDO+6JfpLnNKOsxKx1nAXPZEnb11QC9RIThx4vhteMlcoDEWQ
 z/Tlx/wr9NcbKWhHAb7mlOkaHiv43Vj8lvUEmTklPoebZWmT8Ef3kXtQ71DjDIzpwbKP
 nWPCh1yUIqTZas+skPwsRKbG0ymiGN5H9OUzsUHSdlxRUFFmQJN06C/TXDco4Ahdn/u/
 stRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457566; x=1746062366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOPlOdbDbguknjepjxusIV42ybLDvwlv6HjsVhp9s/A=;
 b=LxCPktGILhI6mqO5GEefvLioQfhCmfUnVwU0ORPhoYiGBAa9bXrTBUKv7JbtVB1Rji
 m6JWksY0hldQM0J31rq/i/HxBgzQpX34e6bpDG+jAU0lndLjbzzW5TP+iIBgcsipbl3r
 0/sORBIX17f1C/iYlQbCCeKcec+4mV8c/5A+h67KMdaSuY2Y17TYVzTQVPkYTKiQaNJn
 57wNHlKaepJ9DBpZt/i8/lWG3a/WPoAA6L7FWoFVCla0BRe7DCEJxw5CfK/KDm+T6tEK
 4TBioKJzbXWlWbbElW8S9V+Us4BuLmR8zf9v4bWFcBjgnNO+TAgHv+beSZI3XrX12Qwe
 0BYg==
X-Gm-Message-State: AOJu0YwbOqf3LZcVP1dMyQ1l1rScOIIdxSVFFxqfGao7WUUBYln88IUj
 CsVQAAHbTxoymhooy0+REFYthoQjoYAHh7IU+Y0GPPBKgVo2SUdYbIXkAlORJQBUdmLqYXWGu6l
 i
X-Gm-Gg: ASbGncvNj7wJRlm9MGoZyvorepk0ONkOvGQCku+ndL+YMK2VgAnqFN+2scvsYHtwpQf
 F0JvOXjN+PcyGJra88HSPVtzJaJAtlGpyz9/q15LysTdF2kZwhha6QGpsp1uS7/zCntbSuSCRnp
 pw7jc5vFmvltp+gHuQtqSMijGcS2jHshLxeO5n6d0j2RV+4+MfEEN23mdkOMfxywJlg74hvEk+o
 iqOmzQ+3Un55NAzNKq/G7XshrVi8llhAsbtoNYKnw6P8vmIdT3QDDdauLgk0PbUWhUzcdWUzoC8
 ziljff62hugAADlNPEIZJDPK7zd3SzUo7IwoTGeXqymT9dPH9I+Ty2SH2q5eDmsBi1T72ioBHhU
 =
X-Google-Smtp-Source: AGHT+IG7a7M15twHMxDKWKI8TNj5+RYtX/BtkRYdFAI1j5y1wVAfu3pkKpQD+PZeRhg6zUcP4nTuHg==
X-Received: by 2002:a05:6a21:78a3:b0:1f5:839e:ece8 with SMTP id
 adf61e73a8af0-20444e6fad7mr908316637.2.1745457566491; 
 Wed, 23 Apr 2025 18:19:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] accel/tcg: Reduce scope of tb_phys_invalidate,
 tb_set_jmp_target
Date: Wed, 23 Apr 2025 18:19:14 -0700
Message-ID: <20250424011918.599958-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Move the declarations of these functions out of exec/exec-all.h
to accel/tcg/internal-common.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 3 +++
 include/exec/exec-all.h     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 573e8438c3..98c702422f 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -137,4 +137,7 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
+void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
+void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bee3416e7e..24383b6aba 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -121,10 +121,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* CONFIG_TCG */
 
 /* TranslationBlock invalidate API */
-void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
                               tb_page_addr_t last);
-void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
 #if !defined(CONFIG_USER_ONLY)
 
-- 
2.43.0


