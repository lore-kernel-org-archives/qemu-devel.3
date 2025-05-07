Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC512C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ5-0000e3-Ko; Wed, 07 May 2025 19:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPo-0008SM-5X
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPm-0002Wl-Fg
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:03 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e5df32197so5421375ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661381; x=1747266181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKk8/QkUIjT9lIUpEMWVh2Ot+bgJ9+GR50UCxP/rL4M=;
 b=eyUdSPmFatyMUN/Iv7zjp1p/oSHExkU1hK7hdIgxdwTwzwGffdoJwFX+k3ka/QHZqd
 xS933SlaYKSNMdb1+I4acVeq8apEfOrD/kQ7uFXftpyz+XSkVk9hZlFN1hlNiyp1xwbQ
 Mb09doDomQSmD93Qh7X03Y9DOaFk8vHK0AUvWTcCEXnZQHKgmn3JSJi08dIopgyT4Jii
 WP/I/WyrcJAMuH/GFAFX/Y25BCZ01ltly6ILHpG5cr7OzQcPZpLZPbh3mDjuI73hG+fp
 7aa+uwcRuB75lck1uijSavHXcvPsSSo3z+bMDhp1GMOCXIZb2zKaRl4CBZL36FHTT84V
 BInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661381; x=1747266181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKk8/QkUIjT9lIUpEMWVh2Ot+bgJ9+GR50UCxP/rL4M=;
 b=thOlOSPgYLQosaOQbcEsCs3XGR+OSqchmj4UeYupe+WnLcsXqtlhkbfpTu18rETOe5
 e+dUgTFw925lgI12RKoTGD68A29FHKJqf2fD0zA9Yv+l9TMj/kucud3gWhFL9oBPIquX
 3KOedt5TLOLAANqGtlJqVd4l2QOzaY1FKy4HyffdJmynpb/9EZwDjPV/kPyqQ9MhXq6p
 P6PeUu5hHIMcXVkzZ5+gHF3TglQO7qpXEz7gGyTA2bOehGCBDNAobwJzZbGryYl9tAOZ
 UPzFeZwnHMObqfBWKfiAfLd3fv6aqUCOBI6nrqHTyYchcnG+4fhEO3ARrf8J29hNYiHu
 miYg==
X-Gm-Message-State: AOJu0Yx0MyX+CqrIa9skqhiCfX9oG+FHhfaejToLWqHpvqqMJj60KdEI
 mE8ZktBvT9DL2r18pn/W/PAeN9Cq+Iqz2T0DzYaYs1jjuuo6wQgFbG8YYfSRpnZT0rf5Z7eqBui
 f7s2fCQ==
X-Gm-Gg: ASbGncteaqQ57m0bhQ3FclWTj4G5hJ5T+g1rJQGDN0ucusuN8TlMFdYaQPOHfeIleOk
 4uTZ7Ii5SwwZd4l3CGwQPXKCaWRxXiLgYKC2FkFEvYwNcJwJNdT0L9MSmgos3N9LntrLsM8KnX3
 bkhsaVX6eb+Xx/w3/zplCfiBRrjsntAvO/0A6qXi1ObFYwVyESPmhM0AQpfr3XkaNuu5JeF02Ab
 H78FNnaD828KTUJ7LgDrEC2beme9ytBuwGkElJSD58WzGTjlgrL8M1BVOsZLz7HW4U2lg3Hjz4H
 mfkoRPffF7PSO7zzuWnVPyLJdgzF4Pa9YFtOQQgUBq9hit4Bi1s=
X-Google-Smtp-Source: AGHT+IEtrmABkvFcC0wwODWJ4uGeFDWgLJSjaesR2JBWITN0CKAaHlEB2/gwVjupmJwkGzAEZulBew==
X-Received: by 2002:a17:903:2352:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22e5eded337mr89643515ad.34.1746661380896; 
 Wed, 07 May 2025 16:43:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 20/49] target/arm/helper: restrict include to common helpers
Date: Wed,  7 May 2025 16:42:11 -0700
Message-ID: <20250507234241.957746-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 360e6ac0f59..941fc35d24d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,9 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


