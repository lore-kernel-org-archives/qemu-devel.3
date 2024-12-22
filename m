Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A0DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOls-0002uw-OF; Sun, 22 Dec 2024 11:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0002ao-8Q
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlJ-0002zO-2X
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2163dc5155fso30200855ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884700; x=1735489500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCm15DE2qtNbKxdOHIXv3FqNquf+1a5gHmhQWuS932Q=;
 b=gV4LJjHhI1l/mdy2b1nNL4ELQSaIN1p2crEEtsaA+s8U6IBVlvAavaNEFsAkbaGAgO
 GOf0J9qBh9e1GcjsZRFy5APKoa0I9FuJoI6yaLP0Q78Z2RLRvExH97rETSXHILT+Wwni
 q1AM0ILPUWVUQ+/xBSjqjLnhfiomNwMkXao96gnSCukc+EW/ax8pGfgciiQWnRqbnuRW
 GMssGQDovzdHUEjh6ZHYEMbVApyrAAgfDx9N2KxO59W7CfEpU4wBj5IEpfkHn3jjxD+R
 Jkjw31z0Uyt3VcKxbpbccWyst7XFfz6bJO0zxNrJIdRyORHJR5bXdV3rRMkaN6B7/Oe7
 2H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884700; x=1735489500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCm15DE2qtNbKxdOHIXv3FqNquf+1a5gHmhQWuS932Q=;
 b=xI1gqItgIQVAhOLiMrdIvXN0hTYfJI1VnsJQwD7ZWywe3txKRKP+bAyMbyKeqIGMg2
 dqoflu2/oOkrQjtR2ufCkI+mBdGhAJtuplSqLhxhRVVO0eCYjlMW/HYjb40g5G4V2Cfy
 GkoqQxMuE7zjysj6JPp2VydOhKBY6dm+7wrbtY2cdPQUWJ5+QaZJmsKpnOlf5TXcSbjH
 3XLAvJJgLohNjuImMQWkB70/uNxC3eabUHgJO/d7I6A62SAFv8mNdDmh3LvSUWAZKs2I
 VFNsyLYaJACBZYKex50UOWzAABDVEjYr/k7jIdiTDSpXFHLQUyxX9vDew72uThwmKXja
 wjuw==
X-Gm-Message-State: AOJu0YxAtKQuVL5VAZ9CtgujOmhfRLfgJ9BF4szzLfhbaEdW+S++6k/A
 2Uphxu/ahPGrWPg5/Lx4OwIOyRk29GJI5ctfLMDLuCg6yj10FkoBhipTkTv0PIuDM+WCmXn7zu/
 2xsY=
X-Gm-Gg: ASbGnctuln0x6ZCuoHCbZX68Fsca7h4H0BupFpaM1EqPQcl/YAT31vUwCEKmKMhLOvX
 m7D7/DyhfKJ8doEi34HbG1/XEZwahYiLldiKDRLGiTqI+1HKGPdgZ/NWUPVWC7zIjPTjTUh7jii
 qvuhZPRbSybarRJEfkEIinQ0vzkssVpbXAGELuJ8gIWgSx7zBU28NNV2kfhEhXRXcEqnSM40M43
 i+H/riMayoN9fRI6mjbnR/Rl0AnBro/f7554K6BZA5b6rPL+Dv0Z6Je279rui4=
X-Google-Smtp-Source: AGHT+IEvMNNCjYSBH15pV8uUzEmUPKgGPSbeiEp58ekwfGOSHPDek+HlzntN7AJLAwkLUV8WZFvJvw==
X-Received: by 2002:a17:902:d2cc:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-219e6f12dbemr132085575ad.35.1734884699746; 
 Sun, 22 Dec 2024 08:24:59 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 19/51] tcg/optimize: Use finish_folding in fold_extract2
Date: Sun, 22 Dec 2024 08:24:14 -0800
Message-ID: <20241222162446.2415717-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5aca1b3c38..f05110cb9f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1756,7 +1756,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
-- 
2.43.0


