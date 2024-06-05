Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDD5C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMC-0006A8-1C; Wed, 05 Jun 2024 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMA-00069X-DE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM8-0003uU-Fp
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:25 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c1a99b75d8so42619a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608203; x=1718213003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKLlurCk3a7fDEEShEp1/NLNYQNqm9T9FFFurFG/dow=;
 b=XB85yZ+70rmBmjCBy+8LQGX0dbd601ceE3feATdviCOnELzKZN89LitIMje4rvByIc
 okeX6yyThNArGOX7hr4BrVQQcQ9ICXjD0aMcO2b1+2+EaXv8BkD1uyv2NrkPf5PIjuPs
 aNMck8DgMDtAmAXJ9GyAEL+yDjWWiHFhdlJVIARTh5Y2aZBAEd23Rkx0muAPONiK1L/W
 AQvECnBUAJW8gy1hA0ubskmiVWKB+vhA3p8Q2wiCYC1rwA4Hw9qrr5Y1GY05roUnVEHo
 6cpne9wLNCBfqdqyqOO7Y+DKl2wq9nA5oIZH1Pl2ThYSXFsinj+Oz5lIR0dKNA9l8LpT
 mDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608203; x=1718213003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKLlurCk3a7fDEEShEp1/NLNYQNqm9T9FFFurFG/dow=;
 b=ZOo1sl5G/VuyJ89OnedRSzB/atwCW0LGWEIDHSc5qvcgl1WL4CcQTEclLNZOcY8t3u
 CUoQakuG7pLYBtZi66K+OnyOHRjNRq1PB2nTBszpd1ICTN/eMgaUV5QWova/InM6FLvo
 Zhq5hpGBzdxTqLpkXTP+h/kbxAK9YQo6rUQpf8sv3Q+PiarnsExCA3FK09ecgcjBdclm
 nBhnAE+Jb37UATNvB9VbUNptkdTcADwpKcCMfdt07jtpimR+bNeLrkqPeI+iev9nN/Ca
 nbWFNwsmaLA/QH4SyaM9BtbAtx4a8y8RP//QNpqcZNWzRlcmlNxpRjXrxm04Nb9hpkmR
 a9Tw==
X-Gm-Message-State: AOJu0YwWnYwKcgJjkgF8fPbhcJatxeXpz1tV5L7LwXAxkJ1H3DvgO6By
 N6E59mybPNpTt+KmpkvQk7xS/B1PqLNX31KjgDmzrYpkMp79m/3Tn1cSJ1arAdXkM9dPAIBS+Dj
 2
X-Google-Smtp-Source: AGHT+IHxOOnTOT8/FkPrvp3Bfo2/F/y4O8L115RdZGdrSCJchIIQghi2FfExiwnJl5Ov9ubI8e4gMg==
X-Received: by 2002:a17:90b:4012:b0:2b9:a7bf:8701 with SMTP id
 98e67ed59e1d1-2c27db19108mr3482264a91.21.1717608203091; 
 Wed, 05 Jun 2024 10:23:23 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/38] target/sparc: Add feature bit for VIS4
Date: Wed,  5 Jun 2024 10:22:45 -0700
Message-Id: <20240605172253.356302-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu-feature.h.inc | 1 +
 target/sparc/translate.c       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index e2e6de9144..be81005237 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -15,3 +15,4 @@ FEATURE(CASA)
 FEATURE(FMAF)
 FEATURE(VIS3)
 FEATURE(IMA)
+FEATURE(VIS4)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 640406570d..6fa0bb6ff5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2430,6 +2430,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
 # define avail_VIS3B(C)   avail_VIS3(C)
+# define avail_VIS4(C)    ((C)->def->features & CPU_FEATURE_VIS4)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2446,6 +2447,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS2(C)    false
 # define avail_VIS3(C)    false
 # define avail_VIS3B(C)   false
+# define avail_VIS4(C)    false
 #endif
 
 /* Default case for non jump instructions. */
-- 
2.34.1


