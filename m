Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37256FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0T-0000VO-Lp; Mon, 27 Apr 2026 04:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0S-0000V0-94
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0Q-00018w-MB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso72855255e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277269; x=1777882069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sWl7zs+vJ9KpTPK00MmmqNspBBmxXNXt2EwW/Xoq1YA=;
 b=ihtqIyzX/zmP3zCYbDdD/mpwPienK56+V9On06wBVDw/0Y4/VfGKrqSB27kx9yegOM
 1mU8K2aJvaLolek6pTeV+FlMGQuk/LtzxkN0ftsonF96e81jFSggDSZ9hGuYofJO3QJv
 qV7pYt/L5Wf61jj2zH/aqF428T2JHs+0ffKhcYkdCo1RDPsZ2WIpToUN+SwZJORqKTmr
 20Wce5NwoxNGHmDner7xzyvL4ROZOkk8uiczav1LcgFAjyW6yUkKKPHMmvli/uJS7UBr
 +OeNaTHubAGIxhh+ZfUAUoFdV8P/Jv2jlP6cw81d5eeWbNgdyDl6drDZ5lmeeDhUn8hx
 Fygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277269; x=1777882069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sWl7zs+vJ9KpTPK00MmmqNspBBmxXNXt2EwW/Xoq1YA=;
 b=SnNtZPXOIL42RDppzTuJ/WJjnR52m8Qot7GJeJaSla13NPvUyW9hRIzjh9eKE/xDYy
 3utOf+o5CSu5ORjKKKHhNsheajsqYBiL/B02ibZCJOpve6e9ei0vbJpXEDG/m5SCLvvf
 /rOkuKF65x8uxQfPEGXRBMzFeAlT0Hz5okGhX3OC0aPdOlwqEZDIhOYGsGWfE6FF/RFC
 +jXEktMj6+sORUO/A+bdeiyNUnNLS24/BD715oNZJ4p/rCPlH2EmCr4m4YT/gePoT/Qz
 JneMR/tDXKvm/ivhQ03NdFrTeRCIT2D8OIXXHit8nqTEclQkH8i9kSFHQzMyFy1Us+P1
 UGRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bFjygr4wwsFsaMAfYXQKywABgZ7gAx2i0VeABFfZwVVxyAIF2qfyCIfnsoGMKxOusELVCUzhjiVse@nongnu.org
X-Gm-Message-State: AOJu0YzkBlTPnJTSIo2qMlvF0Hb7TIshyhPPpSr2vBCKxpC6cLNAa6Ej
 5LSe4Zl4jfMFI+uAm+thoCIjYniqV1zb0CT/xZqlY6x9JngjW/4YhxhnErGxwlz46Is=
X-Gm-Gg: AeBDietwv89tqn7+Rn/1EYS9VRWaHwuQZ0sHEDvF52xjsjf1l3jlVciar3cs2z0RdZ4
 dgUGsYQLsCJR6VWikmmAKmg1xtChf1Yicqw+9NAaU8jNOt4wLN/MkY/CKyou9aw47hzOE2AVJvF
 4gsuwqRQxf5ZZCG2lDpR+lZqtCRQPLDuTEX3hbSoYY+vQVUMYWIa9vtJbR0Z9A3i8phTRWj8fNu
 q9uf98kLhrHWyPbi0YLbWDA8I46p6QfsMHwqKg7jnDQ1dxGsVB9bxG2uDix2Aqb2wivBzrZLC7L
 7ZfG/LNdr4PB7DsXS8nHNDf3mOcugMuibLhcsl+98kFXQQvJt7cDJOkc9ZpIEpWSsgDRYC2Kcsr
 UXvieyWXJ69jEy/UaPVDrKSw3oIDKsKqpjDvRVoskJZ+fdvA9E1Bl6VEiY1Y7AnnbCK5xg1SFEP
 9lg/AptlbgseJwCwtHFsOviHIbjkiSaO0CkGkxsOCXF/V2ubKf29tf6awr/bnpKU+TLpwgXQ+lO
 6JpozxgoMo=
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-488fb739cd9mr492990015e9.1.1777277268956; 
 Mon, 27 Apr 2026 01:07:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm391196425e9.2.2026.04.27.01.07.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 01/32] monitor/hmp: : Include missing 'exec/target_long.h'
 header
Date: Mon, 27 Apr 2026 10:07:07 +0200
Message-ID: <20260427080738.77138-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The "exec/target_long.h" header is indirectly included, pulled
via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
we'd get when removing the latter:

  monitor/hmp-target.h:35:5: error: type name requires a specifier or qualifier
     35 |     target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/monitor/hmp-target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 5167d17d41d..898473b3ed0 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -28,7 +28,7 @@
 typedef struct MonitorDef MonitorDef;
 
 #ifdef COMPILING_PER_TARGET
-#include "cpu.h"
+#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-- 
2.53.0


