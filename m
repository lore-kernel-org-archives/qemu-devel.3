Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFBCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swh-0004Pg-PO; Mon, 22 Sep 2025 22:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swY-0004Hq-BE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swL-0003hT-DG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso4173033b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595171; x=1759199971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=39nNiJA/IKE7T/FfjUB4iuqZYKXZFDWxmUchhyElphg=;
 b=hMmX0bIDwo2UK07xb7K3quqntSvsQqhz5Ba3KNzcPDQn2fZ51O2+b46Q8OMZwpM1dy
 FN9BNmnmJBvfcA+vAdnPryq9uAxXLIfLbVphLn9jcC1hvRjcG8oX/cwSx9GIWzOBZ7aW
 VenhZ5mSBwW9xCzTOLtZABJTsTo8HQFz8A3Ay9j3AiVfI/WtXHGc8YG8wjNjp90SZYcZ
 BG3sM9/Iof7Ayyc1WIolpSQi7/xGUklpXGJC8nxpfAiI3qbNMCA6WwNAJ3vgWEfx/JkY
 sYYJOvS7BdC7WEfQtJzUR+lioEKhITSHGUA31r/XmSB2lh2Zl6EevByY0xLcCP7judfE
 fVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595171; x=1759199971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39nNiJA/IKE7T/FfjUB4iuqZYKXZFDWxmUchhyElphg=;
 b=SMByEHRbe8HVMOaapbZgvPx+V1s4jo3fdmpOIYLI8/o8ddy4pWnhg/Z/D/5VZPEy9R
 ep3+4rWuBYE9W0xQjqiIIxD1B3xrC6rIoTcEUV2NHmRlC0FLWIlg8dIy5P2g6C75wuId
 KHWIxQ6SgQq+e9RSiOkS46DZvJ70x1pgaXn5Og5W0efMb+XpgV2NbIzfknLn2im/t0lo
 b6wCRLAmmxpp+DzxiLpiTd12t5vmxnxy/QM3B8uHq4Dg8U8dBoY4B0sl4xGliATgb1RG
 SE1++yntDs70BSW4T/RLFirE+j8qhSpxB5bZ8MeYq+aNyR5IqUSWR5MtCP2ahFyBeJ7q
 j/wQ==
X-Gm-Message-State: AOJu0YzUf1dA2OqAHoyJMp5L0CIIKdCtT8mX0VuH81IoveGVbIpXMHR0
 l9V/a3eim0l2e0yWNAZltrVabrOL7rnKBkVRpLoYHbmgnWxkjTNa85qqcIX+DfEP8wffnct4Zw6
 BRBZs
X-Gm-Gg: ASbGncvqVN6PDx2Hm8j7fnToZiK3J6QvEpdh47/w6+rzWhxqPutd4Yg9Ln9FM6D6+wk
 uoFXsdqtXOi1bJDTWwP10j6BZtnAQQEMKNfRDQt9rnTd/1CJv0Ggb37JPaQmjYl7GRFb1UKrXE8
 sDGbPxcFww+T1xgLnrhNa6b+1vh8dm06fiwN2i3cEkxvHoMthI5j0jUEx0ZxUvkx5iXp2/8thi4
 KL61Qe/5Yr5i8XPLWbnbd9U3pcFVkyjrpz/XO/0bWCmtefJmSmhoz6QQWWRrXKMwygVxtCHF2Ss
 2omYZnAm5E+vRwhMHbL02PmhR8h+okvFk39c0OszhV6DAMTgwdhv2m4L7oHtOBzWQ04I70Cqg5c
 u+UchuXGE2FMJ/3knKBgSnjjjJIQL
X-Google-Smtp-Source: AGHT+IFqL908kSwQXCKStyPKrdopq3GTS4fKCTDkUZHLUIWN5lmJB2Nj7dQP/CyCSX52SF6oMm8Now==
X-Received: by 2002:a05:6a00:3904:b0:77f:1ef8:8acb with SMTP id
 d2e1a72fcca58-77f538ffa10mr1444568b3a.13.1758595171130; 
 Mon, 22 Sep 2025 19:39:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
Date: Mon, 22 Sep 2025 19:39:14 -0700
Message-ID: <20250923023922.3102471-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 accel/tcg/translate-all.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d468667b0d..d7cc346414 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -288,11 +288,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     assert_no_pages_locked();
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
-        /* flush must be done */
-        tb_flush(cpu);
         mmap_unlock();
-        /* Make the execution loop process the flush as soon as possible.  */
-        cpu->exception_index = EXCP_INTERRUPT;
+        cpu->exception_index = EXCP_TB_FLUSH;
         cpu_loop_exit(cpu);
     }
 
-- 
2.43.0


