Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99966C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSb-0001Wm-AJ; Mon, 30 Jun 2025 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SC-8N
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:26 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRX-0008DF-I2
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:22 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72bc3987a05so2807962a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297348; x=1751902148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrC9y1MRX+O18Fhj9PQjZIyYMT4ErGepHphLgADpIME=;
 b=KJJI8khfSp/TddwRHGY9dEyh1ebmzX5qhKP8b2qwjNzPwxnrsnkBadF4foscL0WJSP
 8R0A3C4A2191P69w22ooIe9OK6XsFsaHGMepifKS9kKfP+IpY31MnGteUC4UFEgqlWgY
 R+Wr7hNbJ2oc5enlnap/mkUiv5c+v6YcaIeaaJIt+wkMflot6HCjE3BgVv/CQSaW7z7J
 9LlXjCIwR8SSnKZYhvWQJ876zBVCT3Y0AuV9zMYyqkdXZYgWe+8PjBu4oUVr52PGjl4k
 q6q6MrFA4dYjwQwBZp01/4XAMLG4NmDAsjl+TlZlaYK5hsc8MEudA9UIuO1Jh60lTCxF
 d7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297348; x=1751902148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrC9y1MRX+O18Fhj9PQjZIyYMT4ErGepHphLgADpIME=;
 b=xBmLxjmSjLUsgWueShwvL0jqa68CKOEgSvLMRDzu1HoIeDJQvPNfaX9zWzDYVb0eR9
 KaBQaYjAIdFjwMavrICSjbNePBrWV9Ff9tdAQHRSvqSVZ+34f14q9Q93lnRNdWJTrDIR
 y6R/G0cse1WnkuEm0B5QcJsYNyEC0catl+VMi5hwT7va1BlFv3rtLkTz1ZTL2vk41Hn0
 p3aOAIEnF+PTBJHsyxjSKouS7ZaeuCKrB3GhLPMol5ULOSdO3A5+QiW1W5BlH0MAjmlo
 A8sS/gbmWGqdoPWp1mD1xbh9DvkN5WeGyNkLuIlOzHllTJLxcZkZFo3c0C/X6/3ioFt5
 08ng==
X-Gm-Message-State: AOJu0YyxdFo/cpn0fJFpn8+2s1tFk8vuKHAXnxt0OrOHiezgs9tGqrAJ
 NJ6lljx/U5KYu4XqC9+pZIn5990kPamGoLWJ/Imb9s4WQtwrie2shzImotWXnIIc/H1p4RNHf5G
 Lt4b7
X-Gm-Gg: ASbGnctexaV63lDcdpxzY1HuT88HqdhQDPu4ltZ6rVGqLKlMVrD1uSD8NeMWzyjSw2P
 Bl6128zOXj3VQ0FmFxogUozXFRGs32eah+4Bhp3if6azYtcP0M1+gP+K5JlE2rE8loE67/Ea2op
 lMI6PrJE/s8T8phmL0MsrNtIqzAifJj6w87lAU/TMdb3AlWAyqpVwL5HNbWVOBwvirfOqORijcY
 S5SvVjp/m5fUhpBz3NbsQAIaZ8ua2paD66pgEUWrDznVifg27nv+P3FY4pOSR2rXZPEs5p9Qlo0
 w4LkgMS0aLqkiZ2JIDNQJciNtQ7qG00fuQINHubK/DC0ygKSXCVkS5zvege6ROD78vqlzw==
X-Google-Smtp-Source: AGHT+IG0xNzhxt7UrY7HZq+ScBmwwqGVF+3mChlCw3vStPo10QbUDtAdUP2g2BtXzXyVdjQU8nOWjw==
X-Received: by 2002:a05:6830:2b23:b0:72a:1222:9e8a with SMTP id
 46e09a7af769-73afc8e7176mr9473278a34.14.1751297347862; 
 Mon, 30 Jun 2025 08:29:07 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/29] tcg/optimize: Build and use o_bits in fold_xor
Date: Mon, 30 Jun 2025 09:28:38 -0600
Message-ID: <20250630152855.148018-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 795f1c900e..572d314578 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3039,7 +3039,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -3051,9 +3051,12 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z_mask = t1->z_mask | t2->z_mask;
+
+    z_mask = (t1->z_mask | t2->z_mask) & ~(t1->o_mask & t2->o_mask);
+    o_mask = (t1->o_mask & ~t2->z_mask) | (t2->o_mask & ~t1->z_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


