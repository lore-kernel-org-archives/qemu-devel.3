Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675ADC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pl-0002OB-9L; Wed, 19 Jun 2024 17:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pi-0002Lf-4Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pc-0000ec-Nx
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f9c2847618so1793665ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830811; x=1719435611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NO9QAgtpGX3Q9btoKo0syeXWtnXyKqXnE75euESvqBE=;
 b=U92gdv6wYtNhSlke6ii51S1tn3AKUR7ts6eNxFiAoI9dr6TPA2QYGw4ir5d/gmKvqR
 qsIKNrfwmljqlWDsnvt1wrCkecX0MNL55ZFwG/Fr5VO/wPcQGxouSWNOKY0QMdi69eD3
 7o4+K6gHcYjTeeqkIio1+WuGhQVY9Ydumyr6d6no65F11j/rbF/TcubHwCuyTcDj/0Xh
 lXmW7KDNjwokBchR2GtKPk4SjOieQBin+vILuU2YS+n9ERVOUNHe5GXRmiiDAksvGDuC
 mLJ0HpoUyrb9CjwQtD9rxExbitb8hzKin6ZXvU/CKEILCuIyMS8TDynVQ+9fQqVJp7TH
 zBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830811; x=1719435611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NO9QAgtpGX3Q9btoKo0syeXWtnXyKqXnE75euESvqBE=;
 b=P7KWk92Ra+Saq8sxWN4Z0MNLdZfVbrvBlpd6ghNiFjXJ1KFzDvXcNmSbc6KFWm+p6p
 2/vzq1xv1FZtah1TwlGSJGlVIPnNLsEFry4ExZpic1JKcmbKvBT3MT6gXKadnzbvTxIy
 LQoLYbNpTksyeINLAVwSvPUYS3Zb/fIHrt5mzFs7UtYIye2BNMVpgpVEdqGe04s4ajkL
 daJNWAqu/pt2RUlM2NCrMpD7fuT44IV+3znWia9vo2mrS9XUsPAh2N31TGvswe0IdQcA
 jzdrxbdwClynBKH8CE4a/gc7gzflwZgH290fW5Ayb1oOxVSCD/mBHLU9/57L7UYZgmFS
 zAcw==
X-Gm-Message-State: AOJu0YwgHKajEGCId9S0+L0nzzdX9qZ1a6cMT6wmlKJz+vF9GYq1ot8S
 eSkWtksMGiPv052PEV8QFh5l+b746IpfKgEZ1c+15vlX9pD0zPxte+qVEQrmFr9KidW0TtHWlJq
 M
X-Google-Smtp-Source: AGHT+IEZkiC7b8I+ifCIwVcey225qGh0zoNRyfsVLz4B4FH5JT54VF+X5oIdNMXn5x9IL0cdKQ3rgQ==
X-Received: by 2002:a17:902:eccc:b0:1f7:42de:e7e5 with SMTP id
 d9443c01a7336-1f9aa45a7d2mr47291025ad.45.1718830810848; 
 Wed, 19 Jun 2024 14:00:10 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/24] tcg/loongarch64: Enable v256 with LASX
Date: Wed, 19 Jun 2024 13:59:46 -0700
Message-Id: <20240619205952.235946-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 990bad1d51..58bd7d258e 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -173,7 +173,7 @@ typedef enum {
 
 #define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
 
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dff966c395..1c4dc4decb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2487,6 +2487,9 @@ static void tcg_target_init(TCGContext *s)
     if (cpuinfo & CPUINFO_LSX) {
         tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+        if (cpuinfo & CPUINFO_LASX) {
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
+        }
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V26);
-- 
2.34.1


