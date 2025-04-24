Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB8C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kuT-0007I8-UO; Wed, 23 Apr 2025 20:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktU-0005pM-3j
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktQ-00055N-2K
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so6680375ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456201; x=1746061001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMFyoxMcqEJbFer+UYr/caW6q12pnT/2IbFSElSLN88=;
 b=I/CjQchSeBPEi7NiO8slyH9sTHhEvPn0iWqJ04XmN5RKf9T4bsHClSxwbskNGlzVS7
 yRy0/DSrsvvFOezye4GlFZj5Sz5P+kiu0XTKeJK7501MGXHGCQEHxWT33ShXMB3BBOqK
 eMXwftERAKn5bmQIdqDWJwh1p70Gb9/pTbz/QTv/z7vXVPh5/C0GT7U+VxvQn5EojYcK
 v+5oB37aM4EXV6C2NAwY15z8hW9yQHST+MO0TogzZd/GsmhdMMxxCHoHC7mgc2sp2UDV
 hV6IcMDCPivhIrB6fmidGOFZdz1vyLouH9k29i0gtIRMpfiw96tdSrtnbCrBg/Fpd0+p
 C6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456201; x=1746061001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMFyoxMcqEJbFer+UYr/caW6q12pnT/2IbFSElSLN88=;
 b=CEHiDGzEESxr4SMQ/iRLZYggMn3VodYo0DwYzApaOlx/Kr2lA5nFMAqr9iHdlrCYds
 iiSDl+D4xR3jVkHnsJPlZA6SW7VXWE6MOgF7I8SvH+betJySfMfbYFon0nUFqyzYHfHq
 gFGDeg9VHQO/WiW91/31SFM1Ftx4JTtUI5RrMNI6DdLbt6f0jkjyiFM35PLd9r7PpbZW
 TKaoZ02064wA+DMfMruQuwiA8KfdO7O5cO2ynyABE3nklP5nS9DTcp485LQnKqdRDwyi
 zZeWPddZDlUnQLcCIM5NlavFIkOieqFmoTLJILouGdLR9y4GQgs2P7yvrvTfRAM73NfY
 NhYA==
X-Gm-Message-State: AOJu0YwhKTtkYu0nLqjfhTG4Kta7whkqbQGR7CXUMw8qtVAYAtVfyGFD
 XVDisuMyr3M4UZ7JGPhLp69py/8R+gLlG/hAnCkegPfAN5zqayP5+fYwKHE+Tg2aNNJhXf9iw/X
 s
X-Gm-Gg: ASbGncs9q/ieOFIv/jPRPW1Z2jb1t+RWPkVJzEQLBSSmadmNkF+7okAQgUABEbYNz85
 Q0ZxZbPVdKu7S2p6C2HARdBykzhaE1sjvOKAyFramzIMnLBM9DyCHJmbvz+6vyFTAjf2PjTycEy
 E+MtCdI7COYBf8Sj3+8PyyLfne9gp90/R6Fn4qVBMQxtYxD6jxWM0met8pXdwPMaSt5z5d72vIU
 pzl3Czb4dJVgGstllMYF2rogXytyEvN3BCkeXJY0xCl3BhFLFI8NjJzaYKVCroV+PYAX6gIxZRp
 R7vTppTqm/6nXDygwPLeWnlq86/sv069uFWjOuZa+Q6nR05L8RCkKUeAHK1UZ2HcVFiS09Tj7EI
 =
X-Google-Smtp-Source: AGHT+IH+90lcR+I4/DdHnEIfDncCD+VdjMwENuNnwv9iOtQ2NvaEMpvUp+DVaFfwgEnYyxpMKJe/bw==
X-Received: by 2002:a17:902:cccf:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22db3c0e0b3mr9065535ad.22.1745456201098; 
 Wed, 23 Apr 2025 17:56:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 090/148] target/sh4: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:35 -0700
Message-ID: <20250424004934.598783-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-20-philmd@linaro.org>
---
 target/sh4/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539..df093988cb 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -266,6 +266,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
+    .mmu_index = sh4_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
@@ -291,7 +292,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
-- 
2.43.0


