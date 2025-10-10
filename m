Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7CBCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpP-0006NL-Le; Fri, 10 Oct 2025 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpL-0006KN-BC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coq-0003sY-6k
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so1589636f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101554; x=1760706354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Y++lkUnJh0nNy/sLg43P+iw17GG3NjiUgzOyrg7o1A=;
 b=anelHLhcwlwINSGdBNF180B1dGRLKyYVthispgFOw1mdZ2QfbMiz6Stg15lF4/cq24
 eWny+hjSipC4bo1/hdI9L/lr+dF0a7rf/zI7pNcW6xVHz8FrmCw1C4PSAR4ov7lkzBIE
 02aIyrySXCEkyw4pxHhbxyh+r490z+9ksZgBvGmWNymc9hV96MVywCYxHB4pO4qihwl8
 rMU15u0oyyOBzfj582rpvuXJ7/ogFi/VwI9CCi38o3ZMOivN0EUkacR84MMO3v+RSpeN
 RbO6A0uNCKcfa/qqueiGuC0cD7m1VgWKOidSseVzTb1KmH7nBvSLafFUXQkjkSJvfGMo
 UULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101554; x=1760706354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Y++lkUnJh0nNy/sLg43P+iw17GG3NjiUgzOyrg7o1A=;
 b=HhC9qTmXTaAf76PaXk9l80RbqxsktD/x8iyU8/JEGOMsECniiEZ+y2/JC9h9vCwNHM
 YtJxn/XIMsG0X45RJY6DsFz01iZaeghUwQqT8/Ahw7c/tgiEUCEP/jRgyeZu09KhSRkr
 v+VnWdRmJzUfOsBO40T/zv2zDrw30WZOeCKHJuDmpXerrfwSrzlEh/dWlA0d5lrOJ5xL
 GsQda+xUfk69KNGdZeCOoHXH7JMnyzIclNgGeg+zKNJAE1tw/tje3HQOLigFsHO/LOVB
 mQyP7+ZwQvk2pE3joLIro77hPSbPQtusVzg6bjW8+IuMdQIEwyYa3dmGtRQwyiyqmJlt
 RR+Q==
X-Gm-Message-State: AOJu0YxuLO/fA4IcZvCExu/8H+2kyaARC2m7TpIbr26gSVFrukUw+EYn
 qst8adOHEmHNOZwBh7l8BP48SfCCZyBcnW+YErelf59kgCsjEU+tc0/veYFm7kQO69SvYfeuIyW
 UfhbB
X-Gm-Gg: ASbGnctFa5p15b8VBFX9Z74nh/OEukODqGQFLtWWCu/jz1xiQEr3i7VwJE0FXgDl/bV
 liN2nDiLjJ90+vJsP1sK8uaZVHqJPV5ZtxV5QnlWqGweDfg97kD7ed34DDQ8eyR+673qyu6ji1I
 0Y1gs7uG2nkbYJdM+zHF8UiDK2pH3RzXpsOs+n87JDu6mrGNVgSxfyPY3Wpf9NMJrIGjs/g13M9
 J0FW7j9uycWSECCPXlanM3GK0VJqNAEHahrINUiCqUSG4Lm0dCAG/OBlX1TCIoffLlqLU2zEapU
 dbbrSRIBmmGZPJAXaR5MxqqplyldSoAG+Jy/jhTB/b+xzWXe83QDBk1wLaie7zpZwgxCjUE3gck
 CpmmAnN1HbVSrG8CXzou60yNyEqRm6E2ab5RhaFeO+2uUqsD/xNM=
X-Google-Smtp-Source: AGHT+IGMShX+1YA+fXcbIQWbz0xD0F1LTph8cyVDdyur4+HGpi4L6nQSWrHqngSj56ba0KNwAHdV3w==
X-Received: by 2002:a05:6000:1a8b:b0:425:8bd1:fbb4 with SMTP id
 ffacd0b85a97d-4266e7df95cmr7741013f8f.50.1760101554325; 
 Fri, 10 Oct 2025 06:05:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/76] target/arm: Remove unused env argument from regime_is_pan
Date: Fri, 10 Oct 2025 14:04:32 +0100
Message-ID: <20251010130527.3921602-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/ptw.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 061472a9439..cb2ffeff59c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,7 +1027,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9c89ffe8a54..1080b6d69d4 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1429,10 +1429,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
          * We make the IMPDEF choices that SCR_EL3.SIF and Realm EL2&0
          * do not affect EPAN.
          */
-        if (user_rw && regime_is_pan(env, mmu_idx)) {
+        if (user_rw && regime_is_pan(mmu_idx)) {
             prot_rw = 0;
         } else if (cpu_isar_feature(aa64_pan3, cpu) && is_aa64 &&
-                   regime_is_pan(env, mmu_idx) &&
+                   regime_is_pan(mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
         }
@@ -1571,7 +1571,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
             p_perm &= ~(PAGE_RWX | PAGE_GCS);
             u_perm &= ~(PAGE_RWX | PAGE_GCS);
         }
-        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(env, mmu_idx)) {
+        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
         perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
-- 
2.43.0


