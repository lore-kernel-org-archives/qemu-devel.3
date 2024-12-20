Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAAFE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjc-0006c8-Cf; Fri, 20 Dec 2024 11:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjQ-0005oD-2a
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:06 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjO-0008L1-Cm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1586246f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711600; x=1735316400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igXVq9mHKJYGFhSJ/gMBUb0qBjttUIOYNiO0oS/Sxg0=;
 b=zaBwUMKJeUR9v/vN3yafdn418S73yp4X3YOgDCOrfAW0Nzyh5Yc3YqtanfDLd77NbI
 BbOBv18HoLy6b8fyVBaNHwBC2cRR7cslm/SUQvW+xURnD2BnMW6AK1fvaZgi/Y+iubIM
 UYkL1bmxFwbDlMdvv23SRi7l4i2Ur0WnjxzN43Ry16tLofLCN64i7P+Nuug1EmxXANKe
 0sABjlSHPmAFkaoXb4PN3Xb/YjfL0hAm7S7xjxAOiM8Adzgsr/kKIcCfjN67Xqkee6G+
 kdQfoWI2Da+aPfsq1JVrdnwK1gCDCQZNT05YbyeYQbGW/Bu3NeE/o3p+PFMRzoYL/y9v
 BmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711600; x=1735316400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igXVq9mHKJYGFhSJ/gMBUb0qBjttUIOYNiO0oS/Sxg0=;
 b=dSrcRQz/aWItv/WVyCKQkIE9vL04agokwbiLppnHe9oe3LJVQqTc9pTfnx9Z0TDCpP
 0rh15zr8L35Y1Fgp2pgAxZ0/r7ORFq/1nppWre+WGHc0bfSWYN184DMnlYYDaP0DMP7R
 n0oUxsrl/6ItXw5/Xk8+lj6fQhKVctvvo07QzHzx6ji2lfVi93R3Tdk0Ec25s/i75H60
 9WLalU63IDtNZJvdP1kikWqQnmp+qwirSJxCz9NmV2A9LPvbBftqheqAPk88uw9OQwCn
 8Xt1Bq0+8q2NS8R9w7bnFBQMVTrYl7FGbvoaLHraFNeBbNMN4+uf1hy0ZBsVvrbm8wXF
 yCSw==
X-Gm-Message-State: AOJu0YzD+5AGYqs4TPzRaD7sumgOJbaVw5h2prvFAr7NU2vTa0k737k2
 Ju90XPHeysMac04oEhVrLJYXc/yEeGjYA4o4sMz9ysthY/JycAV6jaEEkcAmmsXuxSIVJKULryO
 S
X-Gm-Gg: ASbGncvjtoSgnWSwO1aLVDvdghmAkZcn8fpHKhij4pKGAzE6Igm19Sv4zzg+KdgXVDp
 xm+sjx6bZhdN7nhMRxxqv+fp66cBGreRkjwdA8ZRA++zzXf0hp5xJWaFjodPtQ+jjz/bNb+jHa6
 zoRBDJJQd1Pzy+0bp7NnikQcw/CHLIG2n/fAwjKc3o0zG6F64QXpEwvc0K4hVHk42MripLsN/WD
 kouOLQ4KV6nTEbC5NLIMyMfXUCIsXxwUMCVGVxnNP7ks96sFNpolbovJPGH+4T9XiuMUYFHJ8A=
X-Google-Smtp-Source: AGHT+IFvoBVar9lM1WXqT9hhX105NCmkFZryKPUMJ3LkjGE+BEssNmzUEuO6pEHSKc369ze3t0sApg==
X-Received: by 2002:a5d:6d84:0:b0:385:f1d9:4b90 with SMTP id
 ffacd0b85a97d-38a221ea720mr3450937f8f.13.1734711600280; 
 Fri, 20 Dec 2024 08:20:00 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea40csm49674045e9.1.2024.12.20.08.19.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 54/59] target/mips: Drop left-over comment about Jazz machine
Date: Fri, 20 Dec 2024 17:15:45 +0100
Message-ID: <20241220161551.89317-55-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Commit 3803b6b427 ("target/mips: Fold jazz behaviour into
mips_cpu_do_transaction_failed") removed update on TCGCPUOps
and commit 119065574d ("hw/core: Constify TCGCPUOps") made
it const. Remove the now irrelevant comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241115152053.66442-2-philmd@linaro.org>
---
 target/mips/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 441067060fd..270611ce96d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -546,10 +546,6 @@ static const Property mips_cpu_properties[] = {
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
-/*
- * NB: cannot be const, as some elements are changed for specific
- * mips hardware (see hw/mips/jazz.c).
- */
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
-- 
2.47.1


