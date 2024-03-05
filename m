Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AA8C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 23:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rheNr-0006lk-TM; Tue, 05 Mar 2024 18:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNo-0006dZ-SG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:41 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rheNn-0001W7-0y
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 18:39:40 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29ae4c7da02so4105213a91.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 15:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709681975; x=1710286775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cNrt0Wl61cfd1qXgT4oVr/IuvLTx/2WAS0L17LlfJ9g=;
 b=LroM5vnFfZ1DiD6HMe0ijeveZZ6g9FJ5z6813QztpJm90HmkmKpMbzuS/zuaU7mUxY
 DMjxfLDLTP3fcvFLy6KoesPNuc7vPUm/4e2sQOP/eFyHcellJqAtOXPoGfPzUKzwib23
 ycsowtsFxcJJebtVi+FzdZ7vwWoA8ZR0w9JkvAwOb7zv+dWLSs1Wm5T2DRnJvKdDr9h1
 TR32rH9ukGQ+ahHagiXq2RG5cLqG8gAJdF4sjgtXPP/dxNcrUd6bEpG0WWZywRYGOYAN
 TVTa532mLICxabhFn2tCH5W1FawvKOgvsb5TI5vOlVfIPTmMHyQutcV9djT6z3D6VO8W
 4NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709681975; x=1710286775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNrt0Wl61cfd1qXgT4oVr/IuvLTx/2WAS0L17LlfJ9g=;
 b=iUd02nVnsaWIOTYB2KtSMvm8SYCrp1w7T2PANHwtaeahqkB7Mv2f0Ts7QQcCXS0ooi
 PvQrIAVR3qajUw5hasD2jbaupM66uqHOwf8sbvq21qqIWUsmf67gCzhv4z7qEWB2Syf9
 zo1y/MoR/wiZq2iD0VQEUylgZ5YtESzvbMk0WrmlDOaUTvG9GdUQH+ywghL5IGLLskJk
 hVI0Wk4R+BAbgztWGjh0p20+sgqb/94wSzggiAHHXDPP3yG6vgZpeW7TvAD3xrlt3a7j
 TXN8SwGdBaGq8BDxHUor6IDQjMvfaJk5Gn+AfSnsKPL5quRPks8O+wbfws42689iV7Wb
 QyyA==
X-Gm-Message-State: AOJu0YzTjf5oF/wrldTFNinLH5xp7quRySgVy9TAK+ZivQ1uogIthHVk
 rgfMD1p2TTwKdjl5desZM/gtu4OxhAPJuPRClJMHb6Jssp3w8aQTgLUtVMafNlq+7GpWdQ1tUDV
 7
X-Google-Smtp-Source: AGHT+IGKBgZLbDHQf2z1qhqxo44HpmWlW9OkGpZ+Sm2wEcL6uXdJsasMDn5V/xrdjrhcCV5PVhw37Q==
X-Received: by 2002:a17:90b:78a:b0:299:3efe:8209 with SMTP id
 l10-20020a17090b078a00b002993efe8209mr10122967pjz.4.1709681975546; 
 Tue, 05 Mar 2024 15:39:35 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a17090ad48c00b0029aac9c523fsm10047291pju.47.2024.03.05.15.39.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 15:39:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user/elfload: Don't close an unopened file
 descriptor
Date: Tue,  5 Mar 2024 13:39:30 -1000
Message-Id: <20240305233931.283629-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305233931.283629-1-richard.henderson@linaro.org>
References: <20240305233931.283629-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes Coverity CID: 1534964
Fixes: 106f8da664 ("linux-user/elfload: Open core file after vma_init")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0c299a7c15..8565b9520a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4522,7 +4522,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     ret = -errno;
     mmap_unlock();
     cpu_list_unlock();
-    close(fd);
+    if (fd >= 0) {
+        close(fd);
+    }
     return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
-- 
2.34.1


