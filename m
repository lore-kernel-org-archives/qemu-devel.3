Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356FACCA476
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 00:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Yos-0000Fh-ME; Sun, 05 Oct 2025 20:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5Yoa-0000CR-Fk
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:10:58 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v5YoW-0004EA-L0
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 20:10:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32ed19ce5a3so3947341a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759709450; x=1760314250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/93bmDUusvGPtBSWOQh6Rq5pqOuM8kQWpxAeUIhgpQ=;
 b=YNAL57wOuuLon9xddhZb0GfqxbcCplNkV7AdrDtiJaUTmNbFFyLOPCCAENgZlBlp26
 u5iSVjfsZu8RSMRsGxQ0sZebMNGfsHa5yjL1xu+TgEjjjH5Hsp3LOyDoHWWRHs3qERSK
 woBU0/Mm/VfJMB1xlo1tF3jiKNIxTldwEVy0e4ZdF5LP1NwK2sQdsuHbgORr9n5EGkNc
 IGYm4OGUQ7145p2SSXuwSiyK+v1dyWVZbhMGugDC7yGCIOp7CGYPjNKzrUtEjZzp0Erl
 EUBWW7y+8106pE6HFsk8VRzYejXgjhQ0d1ewnH8I4dNJZNzN81fonLXaVcfvBRvQJoCv
 kd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759709450; x=1760314250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/93bmDUusvGPtBSWOQh6Rq5pqOuM8kQWpxAeUIhgpQ=;
 b=XKlViRVUqP81A5YFq1HaXv9ZcZHAq+dMhAQTls9cnm3T+STqAYVVR9Bxc4ouiJ9Uf+
 8bo+6HHKoPTy5viHVzPN6YbWKL6TOC79P5CcW5hJ31G3zDv7CzpizLUi6J4QN4UMl4wM
 0HeR9Y2nS9ODZ3RJPwPCgyirwaer5wk7ulvD7Ij9sZaL7n3rSmUBlUPo6m8f/3phZR+M
 iIf03oUbwE09RNoo8tsakP+y1JZGKRAx83U+ePqEI3RgAQuh11bmVlk5GUjTjCChXc6T
 luiVl0iBj+rOFuDYLptbO0MN56IfOhARrXoOD2hhVpH+Z1C8gyKG8YZsPNQZX+W0rD/w
 FvAw==
X-Gm-Message-State: AOJu0YwxD2+50QSRmflDzdHKtpCC9TeRnBz3ZpILLeMLzbvk2kP0zJfx
 aIXWqgh1k19F8E/FBAJsXDhOE9HjzNHRNRqlXJZrweSI8kOhh2aSMCx+Kso8YXJK0Mu5U5WYKxG
 LeSoM
X-Gm-Gg: ASbGncspVUoprT4I+WhOkTjdolGCYUwU4fCuJtlBTJgG+7Vqx996eDXUSh/9as6sCEA
 Syfd6FMYkk0VnzNTX9inUnkbjuTOgyFgcjH1NS8mX4WaWk6qXkEKvDGm2fuU0s8PUgzuahYc3pg
 rXrs7HV6qqM/v0G+IWKTyjU9hfvFmrnFpWBX7KXAYttEnlsk/Kwov4kxzgxFEqEmAUf3QIOml+3
 uoDyEjGrrHiI2CwHVvcCVNCvYBjDDgo8yyLcnKhuq0S75a4Gi0V2+VMeXUOIA3sThJwQlMpWpO0
 XqVMGGZkRv5XP4q3R5tiBMbNgjgnT+Sanw/v96S9CQACgTeYEOcLyiK5cLgIvuQDT+M3xTBTjOJ
 0kQuN2DukOb2VS0/mePEhOrEjKXyFfHSViNCkT0YfeTdITUqpG3mU//N9HAivt1oueVQ=
X-Google-Smtp-Source: AGHT+IEpDFex5TWeNxkxhX6gA+0YmZOzHqrcpG0SjJiQVPmhJxlkMJHxJ4VxFIr9rgfp7qlewoSgsA==
X-Received: by 2002:a17:90b:3b41:b0:32d:dffc:7ad6 with SMTP id
 98e67ed59e1d1-339c27b94demr12136386a91.33.1759709450337; 
 Sun, 05 Oct 2025 17:10:50 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a48584sm8804881a91.23.2025.10.05.17.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 17:10:49 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v10 1/3] target/arm: Add a cpreg flag to indicate no trap in NV
Date: Mon,  6 Oct 2025 00:10:16 +0000
Message-Id: <20251006001018.219756-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006001018.219756-1-gustavo.romero@linaro.org>
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1032.google.com
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

Add a new flag, ARM_CP_NV_NO_TRAP, to indicate that a CP register, even
though it has opc1 == 4 or 5, does not trap when nested virtualization
is enabled (FEAT_NV/FEAT_NV2).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpregs.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 57fde5f57a..abee72c9bf 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -136,6 +136,7 @@ enum {
      * identically to the normal one, other than FGT trapping handling.)
      */
     ARM_CP_ADD_TLBI_NXS          = 1 << 21,
+    ARM_CP_NV_NO_TRAP            = 1 << 22,
 };
 
 /*
@@ -1158,10 +1159,14 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
      *
      * In particular, note that the released sysreg XML defines that
      * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
-     * trapping rule, so we will need to add an ARM_CP_* flag to indicate
-     * "register does not trap on NV" to handle those if/when we implement
-     * FEAT_MEC.
+     * trapping rule, so a register flagged as ARM_CP_NV_NO_TRAP indicates
+     * the register does not trap on NV even if opc1 == 4 or 5.
      */
+
+    if (ri->type & ARM_CP_NV_NO_TRAP) {
+        return false;
+    }
+
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
-- 
2.34.1


