Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C848E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPey-0000Dt-L0; Thu, 02 Jan 2025 13:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeY-0007MW-8y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeV-0006EF-Vz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166022c5caso139894325ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841434; x=1736446234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zicf6xd6rh+BcesBv/WVW3pknCrfkT1VH51Jlj16asg=;
 b=tax+yYs1OAKmyJkMXJ51Kd3Sb+9wOI1WW+Xt4emIGwTOp/iapcpZ6Hg7ioyxz310yA
 pcTnNrdVQDknA2aq4CpKyADoObEA++oBu1gh4IbnYuMid9ill/72Z2Hkv2KXknHu2uUT
 wFzNhv8B89QoNa3jZdDFSg4lSKIvTftX84Z40HgpCLXpVMrexS4mjyK9fio8lE/lIhio
 hqcaaEdkf4tGooEzyxmiSzCkYss055Zd85SXTD6WrKxJWjknDlN4GtdHkpMJHJty91Rz
 CXDMFt8SGWhAiGBw+tpwynZ6CGqCefmYdLHwPjt04fV++CZPcco525upN73dEN7BpAlR
 q2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841434; x=1736446234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zicf6xd6rh+BcesBv/WVW3pknCrfkT1VH51Jlj16asg=;
 b=WfhhN1D5xT8luvP3ECztryPWwg7H3+syIyQfHN9byMXEYHQRlh1Bq2VRNnBAwGZoIo
 7pFsV34Uh7xZLJo8yKhEmSC8s+UcooakAF83RQg+bzcD3NVYMHYJYdMSH06DUIv/z6jb
 OcIOzmj7rjH7rmn6YtPbWjFnGu8fw9kH5Pv6tc8RpC5WX432mG9gWm2tCw17x9s8VsKS
 Xcf4cgDm8njOYzGOIyn+6EW9Yk0A1GNTR+qbCrbk8Ix0Bls4L4AfYBWd3JpeuvSClK6o
 MUHhjbNBxoMBs3qgr44pgys7qfX5nIt+Db4gVlkjK9kgkRBx5JQGnG4wEVUAgjN1Dq8N
 +g8Q==
X-Gm-Message-State: AOJu0Ywy8dxKmCjzzuoQ1XtKfy0IQnRD1FYula6cnLkh5HyN7nfx7nYL
 Cltj/HDhC36o/ioNt0g/9KYVdQ2jBpKePFaXSJM3iuAepA4okznxB7jw2SbfWVn+7uXqo0TnSmu
 F
X-Gm-Gg: ASbGncsEYRXk0e1iIrw1Qv6szsKyoKtON3q42f6F6w5N43PZPA0r2LUm+6LgrufAoM+
 HAVXYteLfPoApUhwWHhXobguz95zre1Zi7A7AJU688I+Rq1V1qwusV7lnmGUgABt8M4BdiVAkRT
 9l48OWWZtkb7h5tTGux64EYpLKgFY8+lM3VgdFDDUxJqs2mFDbxB+fwyA/OrQzihvcEooeaBa4G
 ckhWta6gEn7fCfbVk+pMv51unY8VBS2GUx1gUmbFEGxih34cYzbf9qvOuKkKw==
X-Google-Smtp-Source: AGHT+IFlMBMimB1FYPDe3cjoNTxB2YKA+DxltC19eQFNt++SQGKSKd8IKRpSeHZ0tCPlpko2OsCG2A==
X-Received: by 2002:a05:6a00:3910:b0:726:41e:b314 with SMTP id
 d2e1a72fcca58-72abde8286bmr66046529b3a.19.1735841434623; 
 Thu, 02 Jan 2025 10:10:34 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/73] tcg: Constify tcg_op_defs
Date: Thu,  2 Jan 2025 10:06:31 -0800
Message-ID: <20250102180654.1420056-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Now that we're no longer assigning to TCGOpDef.args_ct,
we can make the array constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg-common.c  | 2 +-
 tcg/tcg.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 412d6d119c..b5ef89a6a9 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -712,7 +712,7 @@ typedef struct TCGOpDef {
     uint8_t flags;
 } TCGOpDef;
 
-extern TCGOpDef tcg_op_defs[];
+extern const TCGOpDef tcg_op_defs[];
 extern const size_t tcg_op_defs_max;
 
 bool tcg_op_supported(TCGOpcode op, TCGType type);
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 0f30e5b3ec..e98b3e5fdd 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -26,7 +26,7 @@
 #include "tcg/tcg.h"
 #include "tcg-has.h"
 
-TCGOpDef tcg_op_defs[] = {
+const TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
          { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg/tcg-opc.h"
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b8be62934c..7871e349d4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3324,7 +3324,7 @@ static void process_op_defs(TCGContext *s)
     }
 
     for (TCGOpcode op = 0; op < NB_OPS; op++) {
-        TCGOpDef *def = &tcg_op_defs[op];
+        const TCGOpDef *def = &tcg_op_defs[op];
         const TCGConstraintSet *tdefs;
         unsigned con_set;
         int nb_args;
@@ -3355,7 +3355,7 @@ static void process_op_defs(TCGContext *s)
 
 static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
 {
-    TCGOpDef *def = &tcg_op_defs[op->opc];
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
     unsigned con_set;
 
     if (def->nb_iargs + def->nb_oargs == 0) {
-- 
2.43.0


