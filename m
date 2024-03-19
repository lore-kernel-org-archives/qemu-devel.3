Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC47C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyF-00053K-Pe; Tue, 19 Mar 2024 02:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyE-00052t-CZ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSy9-0005cE-LU
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4146172fb7eso8502275e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829744; x=1711434544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ob9p1550HNpZVGfZEzfCR7AGiyEKvTVPMJN9EmG2s0=;
 b=vzDqpreD66K6NJnqr1M9le42pTHHgLvlcyNXh3pa++DyQZZFtSsHINXGd7Gp5TKSzS
 GhAcasSABzjEcCfzdOIOl/iT+af+D5tKVSiUnWCuzIW/odjMdZVZG/qhlIbs4Xhcb8Lx
 lGiy+B4BgazQaWE1X2EDKXq7C84Jp/o2lZihjEKHk8G6QFEcRLG7Fk7SAgHBXvmiig3M
 Qkj6syj+S/EpUtg1x89CFdemu9YpfZfUkydYvMBWyoFDehnR/bEaiXnA34wQ6XnvWdTG
 D30p79wgMq2ManseWAK7rT9REh3XK38u41674WAhcDEXt+VhXBrABaL1x0Ifbmjl+rhs
 1MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829744; x=1711434544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ob9p1550HNpZVGfZEzfCR7AGiyEKvTVPMJN9EmG2s0=;
 b=rp8geKI5vFWe7iqRJOu39AqQPahYjb1DpxIK7b0uvtSKmjxbMMBRF/eBq+WJpU/BLw
 Jn0KL/KRBxQDJ/C/eoC7gp3vdOfh3wDpubqPNSHIHYMTmzy+ebhF+v+nS0k2PhY3zMKr
 FrQDvb8vCMSf83JXmxVrTUCJ7tuZwwtU0oI/Ud5jXX9fLRqBEhRWbYOEf902uY6/rrU0
 iqucnxh5sStqekTPqzRcgDF8kTGd0CK4COS0e7+/LiP+gUr/2QlOFgRvSv3CSqjBqFPE
 F1P0N1gXFHL2OvBIcT0CDvqxJHhxVgZRkhvrp43DvbREZmfRc7Ongy1haGdWYRQarcXq
 tstg==
X-Gm-Message-State: AOJu0YxAupwdMKxJbvuGw1kocLah3bkLJordJJh/tNLbZa8Cb8Gel4Dz
 1C9WZvfxERhwgA86hlZKviEdkDtWHsIBKgPPRGVK7d9pfjBuzhl2fy+jHN5dONHzrlMGtug3wBA
 U
X-Google-Smtp-Source: AGHT+IEjnqEUlNURVey1aOE5055K+aMav+7H9x6mLZbfKzt6r/i54rrpymfDix6Jevsmh9WLAb+g9g==
X-Received: by 2002:a05:600c:1914:b0:413:ff13:cd8e with SMTP id
 j20-20020a05600c191400b00413ff13cd8emr8004849wmq.5.1710829743802; 
 Mon, 18 Mar 2024 23:29:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 fl25-20020a05600c0b9900b004140a3d34fasm8493344wmb.41.2024.03.18.23.29.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 1/8] target/microblaze: Use correct string format in
 do_unaligned_access()
Date: Tue, 19 Mar 2024 07:28:48 +0100
Message-ID: <20240319062855.8025-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

'addr' is of type 'vaddr'; no need to cast, use the
corresponding format string.

Fixes: ab0c8d0f5b ("target/microblaze: Use cc->do_unaligned_access")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index d25c9eb4d3..0a12c4ea94 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -279,8 +279,8 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     iflags = cpu->env.iflags;
 
     qemu_log_mask(CPU_LOG_INT,
-                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
-                  (target_ulong)addr, cpu->env.pc, iflags);
+                  "Unaligned access addr=0x%"VADDR_PRIx" pc=0x%x iflags=0x%x\n",
+                  addr, cpu->env.pc, iflags);
 
     esr = ESR_EC_UNALIGNED_DATA;
     if (likely(iflags & ESR_ESS_FLAG)) {
-- 
2.41.0


