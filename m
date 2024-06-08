Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74365C27C5E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 05:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGB9d-0005xR-3M; Sun, 09 Jun 2024 01:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brzakbranislav@gmail.com>)
 id 1sG3tB-0005kG-MK; Sat, 08 Jun 2024 17:46:23 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brzakbranislav@gmail.com>)
 id 1sG3t8-0005Im-B1; Sat, 08 Jun 2024 17:46:17 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6f11a2d18aso34453166b.2; 
 Sat, 08 Jun 2024 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717883169; x=1718487969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/alHFJfcIZYSqhMXs3UYaKvWveN8iKEwTM/iShxLUsg=;
 b=c+w/BxvMYAYpjzZIFxp2ZOTreyQI8YBRxiuSo2m6P0btl2UvOkPA2VQep2a36FTQMd
 inH7+/pFHROWVlwYOHUwt4e/7XhSdS8+AzCHuY2xMd3ktVOoR7c5H2T/2vdL9J8QXgz6
 p6fcRnqTvlLfGsS78HaISng01S4IpU7DWzqzLUKKlxPVeZjZrqKjAGmYr7wL8z7yMVIa
 e6b+9elLumDRjk5qxGTHQxVz4PJdJr88QqY81AUauKSa0D+zpxU+U1zgGlOP3doflEoG
 95+HlBRfMZyzCBA7idksIXUkxd2SyCgA9zqfDsLeye0nPr1bWP7GtRf4hVlrtYE/Y2yk
 2QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717883169; x=1718487969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/alHFJfcIZYSqhMXs3UYaKvWveN8iKEwTM/iShxLUsg=;
 b=Dnj/Ujxj87tbI6Qv4LgXPdsA7UueApBWt09/lmEsnUra0jn07KESSColwo1lU+b7xx
 poHsHkyRNnlnBnEq6weeYp4l1+RhIAi1l8ts20766ufIoGRBRRmvfQGryjZtPQNL//WY
 NenAJJIcsumyJ7VgiPdlCYAIcFvLwAtT6x0g0jKJwL5KdUDAPuymNyRjI1exddXrXj6v
 aK9A0vpbx1cODqsz0U0MDzGxrunaEvEx+NeO5nti4D6fkSoF+wGyOVD+iHf9ow5GM3lm
 dn39LAncRsoUrieAEeqWu0N8m4Qy/Q60aQDaJvpbrpUZAcq69MrOadr5MUmg6YpVp7Bp
 7rrQ==
X-Gm-Message-State: AOJu0YzJGu6UddUe5Qz9r7hgIguvtAfqefQBvdg87Qm63RQrTmIAdrix
 Rt9AFRiBcd+0FZgbrkiyyxprEUN7M1tyH+Ut4vc2y1nM9GDWKKZVrLxyCjbH
X-Google-Smtp-Source: AGHT+IFDc959GklOTTLFsf6Mu1A3Ua3KYJQxk184/tpJxyRTH7ZFRq4AftkT4IY/NzJ/iYwEh1hMrg==
X-Received: by 2002:a17:906:ad87:b0:a68:ec11:4561 with SMTP id
 a640c23a62f3a-a6cdc0e3a63mr374459366b.76.1717883169193; 
 Sat, 08 Jun 2024 14:46:09 -0700 (PDT)
Received: from localhost.localdomain (178-221-109-16.dynamic.isp.telekom.rs.
 [178.221.109.16]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c806eab0asm432951766b.134.2024.06.08.14.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 14:46:08 -0700 (PDT)
From: Branislav Brzak <brzakbranislav@gmail.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Branislav Brzak <brzakbranislav@gmail.com>
Subject: [PATCH] target/riscv: Fix froundnx.h nanbox check
Date: Sat,  8 Jun 2024 23:45:46 +0200
Message-Id: <20240608214546.226963-1-brzakbranislav@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=brzakbranislav@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 09 Jun 2024 01:31:43 -0400
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

helper_froundnx_h function mistakenly uses single percision nanbox
check instead of the half percision one. This patch fixes the issue.

Signed-off-by: Branislav Brzak <brzakbranislav@gmail.com>
---
 target/riscv/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 871a70a316..91b1a56d10 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -676,7 +676,7 @@ uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
 {
-    float16 frs1 = check_nanbox_s(env, rs1);
+    float16 frs1 = check_nanbox_h(env, rs1);
     frs1 = float16_round_to_int(frs1, &env->fp_status);
     return nanbox_h(env, frs1);
 }
-- 
2.34.1


