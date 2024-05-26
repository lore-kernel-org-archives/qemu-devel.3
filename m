Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE4CC25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmF-0000Tg-0Z; Sun, 26 May 2024 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm5-0000D7-Kb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm4-0007kp-1U
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f48b825d8cso3469145ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752598; x=1717357398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2jVhYHBRn12F1/nF34lAzP9rRGex3+gOE8jz3RmZzU=;
 b=Whc4Bn6kkZBEU2E6k2IECguXOmzTILRQDdKm8LbV/zZoQVp39OsJ0rtLXaigv9uKyb
 B1lXEVjA4KVfYCbIqn94QNHGGvw6iAxLCnFR40n3cnQoI3oGcN9w3fbrgx5W91OD1g4C
 JiCxfn8SAywcRD4FGHvGAFba3THifO6GQK3TmKFjXCTpad3Q/PQx+hCAnMUPVB0ny1Lg
 eupxm5Ze4y3PhWIkRrhqeFqCvmUX6Xwod0KjFI457HuucSBDkeEF0o6lsrJb+0zo1cv3
 qtkvJPKTpdoA8SKx4oU/vNynf7olSaDFLPf1IseB0nwNi97VVYB6Vsm1IvDdROKyepGp
 VwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752598; x=1717357398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2jVhYHBRn12F1/nF34lAzP9rRGex3+gOE8jz3RmZzU=;
 b=TikxcsDzU9VmlDg9wvDvomvB9vt3O6a7jZfajUYKLkSwZBtxCbzY6ScB/gSFmb5sS8
 SAtb0E3/N3WRVpdnVwYdfgDPA6Rme08RyHs4SWU0nI4VclS7wpu5eR4zu1Nc+Pdr7Ltw
 TT0FW8rAwiZPSix3DM/skhw8LXj1hlJogJyvOhkocs6dnCKPAV762PCR0Jvqt1tsjs8r
 esk1lJS1JhhcR8z3AD2VmYhx45iI0DxP7w+7AmHV4UKIsziAbxYWSZHB01YySjioHN6J
 ol5zoVb7OKTBLIB+VuWSfHyVn6cnKu5aCy+FLi7yl/XBquz+iaezxe/CR47hr7bbbQRU
 eahg==
X-Gm-Message-State: AOJu0YxE3Ue9Ba0Hh+cWbWCw5UMYbJj9upvbZCZZFbIhcNTgm/5sD4yv
 P+AqJJfb6P/JRHsu2OgTipObHAkGPU9R2KZqv55T3ji89Ke7ItqWYmtsM1vgH6Amtw9yNm2TL/t
 o
X-Google-Smtp-Source: AGHT+IFB2whW/rhWYTsZP+TVXgPsOGXpkX2tEh57xv9+/xpztgfP90w1mELPkPcockLQHoXyEY7XaA==
X-Received: by 2002:a17:903:32c9:b0:1f4:8bb9:9ab8 with SMTP id
 d9443c01a7336-1f48bb99ea6mr25263295ad.14.1716752598279; 
 Sun, 26 May 2024 12:43:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 29/37] target/sparc: Add feature bit for VIS4
Date: Sun, 26 May 2024 12:42:46 -0700
Message-Id: <20240526194254.459395-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index d47e1defc1..88e6da4f8b 100644
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


