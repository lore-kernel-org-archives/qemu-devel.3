Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34844C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0px-0002Nd-Av; Mon, 17 Feb 2025 08:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0pu-0002Mb-PU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0ps-0004oU-2c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:58 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220ca204d04so56797655ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797614; x=1740402414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0UWINckwcSYd7NHNQigdFexck5lWKOcbh3yCa7cb0=;
 b=ke3/3RieAy5QBQzHEn5NMU2IIfeNj1RI1fZFg2+UFwVuoxQb5cUNKSD56Hpg1OVjV4
 qMCDMZepFeyXW7yRDlEinV6WJHbFeYKm6AezoiZ4Pgbwj8OjiKZvJKPGoNH1x7SHKcMM
 fpoJxATCmVPy7KgAxKAC8d5jRJsuqwUDlUT8FF9Fk60NawQSGj/iEIVUSD41HR8/J8vR
 zLcmOul5gqWSSHht35J1452gxsvplBbgSa6fsPK6qixBa0tmjpAVfTpBpHlCmbeySpK5
 nes7aqvOyv7wXS4VwQ0UFtQJAM1cKgWn7SkYZ1Emdl3szbtHeiTLvDhoMoUuOtD8BIKH
 +99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797614; x=1740402414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7O0UWINckwcSYd7NHNQigdFexck5lWKOcbh3yCa7cb0=;
 b=Sb7z9oM3xWfaGx/WGg6R50NxufMe3fhMfi71A8iIYQO+4YTyK/io9JcWwa5GdAmIfG
 QXn5SLAZuE1KAxQpc+JEoff6fmD4wC9JV0CMJ2wDkqTtNeDp4+grH/QTUMfapnQ9B6oS
 MhTWqrl/cVhYNv/KEDlkVp4jAasUvdMR5i36vYX/wgxy7FVQSNKSnBFllVArUPGlW1cE
 EeSWv03ur1fO8xRKOjvLK/LanoKVZC03C/o+Ujg2gTlVZ5Xvsu72Mag7T5a0mcpMoSyj
 jW6JEwX1sn0tKbqiFqdzragjy9kzbW4B0KALtDFrSNT0KobAr9ALwU/80jE+O7Qzd+oT
 Gp2Q==
X-Gm-Message-State: AOJu0YzCZjpJquRJS8MLT75Djq+G8Ld+z5i6lpXo+xSEy18NaCrKYbIY
 9ZI1V1CcLOtu5exX7Ug78Fb0IpvCM/iwGLaf7EK1w5NNnwymQKTfAkHCp9H8lUGquB5KL2jSaw5
 c+bM=
X-Gm-Gg: ASbGncvDNrntD6eiGJlVhvO0phoBM9bP7A8hYCZK+QKUh1medf1yuJUf8tfPwlSLXF0
 pun3vkUWC+sRt6CdpWxUWTcnRb1BuBsrcLrAQzU0vbQXt8UlumwujGw7ogEun8qBIzO2/I3JxfB
 Z+9t+4XE/ejKXRKp+zslGUItAFnKaqbRAopKsTE+Tf7IwbTyVaxwhB7TwklqBvotxST+Zxq13tv
 7HCt5OJm2pbC1snP2T6a8DvNd0VDz6mWlPQdyhSstPn48C7am9zLT331XJDExW0WDsBEZKofFAW
 FnLUgG3o9Cnheahx83c56A407vMV3CDl0VPSLdsG7RI=
X-Google-Smtp-Source: AGHT+IHNpLdbC7JJNI0xd+b7ktdHbHeBChauQsr6IBEYGduSzv32MYUVq4aMNsxYr+pM/3ooBCYfxw==
X-Received: by 2002:a05:6a00:1408:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-732617bf52cmr15434269b3a.11.1739797612678; 
 Mon, 17 Feb 2025 05:06:52 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425463ebsm8306546b3a.19.2025.02.17.05.06.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:06:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] accel/tcg: Include missing bswap headers in user-exec.c
Date: Mon, 17 Feb 2025 14:06:07 +0100
Message-ID: <20250217130610.18313-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
References: <20250217130610.18313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

Commit 35c653c4029 ("tcg: Add 128-bit guest memory
primitives") introduced the use of bswap128() which is
declared in "qemu/int128.h", commit de95016dfbf ("accel/tcg:
Implement helper_{ld,st}*_mmu for user-only") introduced the
other bswap*() uses, which are declared in "qemu/bswap.h".
Include the missing headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index c4454100ad7..9d53c9440ea 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -30,6 +30,8 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
+#include "qemu/bswap.h"
+#include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
-- 
2.47.1


