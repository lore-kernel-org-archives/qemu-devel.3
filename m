Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D474C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 07:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfx0l-0003Os-8A; Mon, 19 Aug 2024 03:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfx0j-0003Ng-Of
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:41:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfx0e-0004LL-L9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:41:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20219a0fe4dso13609995ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724053259; x=1724658059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8HC5xX2RS5vhAXN7obJucV/pCAXzmZwlnRs+P8vxQ10=;
 b=LrtsIr7RUbG4b+Oovy3eZjDH9mnR72f4ozkBvUGq4mF9xdhyZNCB+FBYPwHq20sHSU
 s0UYOlWtAOZSkp4A7r10UzHNzYk7eD7XGY1u6TwdV6QToFaUZcxAVeNNfcTIeeO7Vfkl
 WNEEghRpNYgs2i5mfr5IRefJeINiVSUE7CWq4AIDpHJVgGYTicu469+bMQBlqvLBn0WR
 gGx0F56o/fG/MOKIpnvp6EORjH1uLuWe8NL7Py/BAFhiAFwwOE8tW+o4l/QAT/brQjnO
 fqrWRkCkn0FXPdya0SzpIXU6xutnwKVxKcE2wPl7TYLiPqG56V8CkoRqGxdr903E2RAo
 RUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724053259; x=1724658059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8HC5xX2RS5vhAXN7obJucV/pCAXzmZwlnRs+P8vxQ10=;
 b=SX2rzjSm1znVgyjwxx7AQljjC7NaIXVFSyj666H4yyPe4tzdZO+YeU4K9iNZyO7K+e
 fFkrDrt5jIaMP0B6KMKVKkKrcYybDCqOsS5mBGLvJMBcHyFvbeTFDSUgA6qxc8r/u4hM
 6j/DcVjDW30dQTi75VkSvgKLg8XnkouKpRzXZ87KFTmG5srCD5g5YUivs3ToHDAO7EfX
 Cy7jDSukoHFz8d6O1xIcV1KNlFL8A3/B8hfYr79pGh+EwK7P35BlE/jOwJUg0+fkwysh
 rsEnfiVlxbdMeoGONQH8ZKFmDXGLsxqBcheHquxDiGJwoiLSe9XhKz4Z8illIynAWFie
 SY/g==
X-Gm-Message-State: AOJu0YwkREuKNQCUqxq/qZ4JvusJvIKzMKbjBZlsgnBM+mKfkZXdOopg
 bOVBKRYblRbW/wZYYhTSYJQVdTzcx9zyag7BSzcY0QrBQh/LBMqqtyIxe+bJFCq2h04Ps9RoHYH
 Sblo=
X-Google-Smtp-Source: AGHT+IFfLYXvb3ZsnIbmQu4pYaC2roE9pYYMMBeF/TgPpQdLtoVY5QHefIzfqulKAeaOMHPzJIOphQ==
X-Received: by 2002:a17:902:ea10:b0:1fd:a7a7:20b7 with SMTP id
 d9443c01a7336-202195eb41fmr81675895ad.30.1724053258442; 
 Mon, 19 Aug 2024 00:40:58 -0700 (PDT)
Received: from stoup.. ([203.30.4.109]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f030202dsm58399945ad.34.2024.08.19.00.40.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 00:40:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1] target/i386: Fix tss access size in switch_tss_ra
Date: Mon, 19 Aug 2024 17:40:52 +1000
Message-ID: <20240819074052.207783-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The two limit_max variables represent size - 1, just like the
encoding in the GDT, thus the 'old' access was off by one.
Access the minimal size of the new tss: the complete tss contains
the iopb, which may be a larger block than the access api expects,
and irrelevant because the iopb is not accessed during the
switch itself.

Fixes: 8b131065080a ("target/i386/tcg: use X86Access for TSS access")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2511
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/seg_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index bab552cd53..3b8fd827e1 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -378,7 +378,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
 
     /* X86Access avoids memory exceptions during the task switch */
     mmu_index = cpu_mmu_index_kernel(env);
-    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
+    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max + 1,
                        MMU_DATA_STORE, mmu_index, retaddr);
 
     if (source == SWITCH_TSS_CALL) {
@@ -386,7 +386,8 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         probe_access(env, tss_base, 2, MMU_DATA_STORE,
                      mmu_index, retaddr);
     }
-    access_prepare_mmu(&new, env, tss_base, tss_limit,
+    /* While true tss_limit may be larger, we don't access the iopb here. */
+    access_prepare_mmu(&new, env, tss_base, tss_limit_max + 1,
                        MMU_DATA_LOAD, mmu_index, retaddr);
 
     /* save the current state in the old TSS */
-- 
2.43.0


