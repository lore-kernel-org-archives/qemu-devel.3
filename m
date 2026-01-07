Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF74D0D16F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZpk-0002q6-H3; Wed, 07 Jan 2026 15:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZpC-0002XL-VL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:08:12 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZpB-0002HC-4w
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:08:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so18407935e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816487; x=1768421287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iItJ0aNB9FO1EI6E9PzkONwwdwGsq32voTruVa/n7o=;
 b=V7mBY/9/IhLDT51eTfekeYrSVaZFOyMrVzW9pe+q4QMUSaZm8tp62K6uHKP/nQeUVs
 fSHQ6l7Vd95cXtG+m84YhVFn3B7DJwmon81sAjrCRHkpP7WHkdYgvLpgf1AXxeeAX/Y8
 ZxzXiywl/qYB8a6JcvH91JvSJXsRIHyeKgb/YOC9lE4Mizg0PkK+bdIYb8LhC0z9we/A
 BqXv4ogmW95TPv4W2ds4Qh93GhUQPACD9E6xsV/dRp+j7B9tf1ZjgYr3ZaikntKyZDHE
 7qiP3RkhmJfZZwZDbFiYIwl+rACJycaz7K0O465ISGr95Wd71pHpIXdyU6IByZ7qfv9n
 cWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816487; x=1768421287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5iItJ0aNB9FO1EI6E9PzkONwwdwGsq32voTruVa/n7o=;
 b=uiW5X79z+sb741Qul1pDtAwtMxyDESBlwFigmYyI84UignZVC43MPgZwcUT+kki6Eu
 JFA79jcbjdwmfgAbnh33tY4WFL5oLG439zgHEvW2EckTOnJiAF904k2/OtG9P02EsS2C
 yQYsjok8sCVAC6DrYNLaYywSNYF+G4tCR23+QD4dr1dcdgLmd/NHUIVjaBqWzHxiezMx
 KhhJQTI+E6Mfe9+yA//fTYPeRujgZ6KgeN+4O2rbpzxBaeCy544BQ1B7svN1P7x/uqKD
 ya/qn6colwv9izLnDfFyQt8f8dK5BV5j02X6MqLuc/6WJ833IGIBPOh/gQkVnJcXWwQ4
 +4fA==
X-Gm-Message-State: AOJu0Ywh96ovE8tf4rxVJXk0V5T0Dh/r5OvwNYhRksroXYCbJNp6rgtL
 X1sL5OcQ++K846FYvbiI0XJQ59Zv/W8Rctd1jrR9MD46lJIuQUU+Keo4lba+5HnoJ7Yu9fdbTEo
 iaWQK3jw=
X-Gm-Gg: AY/fxX6IioA4/SScGeFd6m5oHK9YkONwPewSSAxffSBbmABy75wJ8/9w9M5aSf0benJ
 iox934uAa39ehr8DWa54y6akyu4CJfg/WZgrzrlj5d+yeARqK5RmpOU0/SZpWzsMquGVeHqyWMK
 lsA5sAiU4wesqy6O6HCwsnq1NOAnFsFTkRSROeWG0S/NEBgG+pgpTBPf6PD86NstGD99uH9ATIA
 3v1/Wj72vZ3VmHSvHBgFKu1968YZgWpTqVjM9u7mI3nCW0+VOJ6uJtm/VMieSwV71AfQiosMmgz
 +zYOGHmaIXeWIk0DtWaO0Yf2MJD/IhLD4tHT4KYRpqMTgPwRabXB2goV6MPPF73B/ec4hDB6sO/
 W7md60sXzRKONa3Nr/ZunFMm49xMMJu+OssyKdPkwgjBZnwkGYapVSbXPLoiSc0V7g7IKx9QGaG
 vTtsSvQCL82lY3qZfphroEjhkGNtnV1grapdpFPuvLNC1OChX6xrRHRht3tIzB
X-Google-Smtp-Source: AGHT+IGxkzcD2untQl3FisMXX8HQ9tKuPqCIASx199WBoQYsJ5dsoXDFpAHYGLNRGBzITS91gi/8eQ==
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id
 5b1f17b1804b1-47d84b3476fmr49874335e9.24.1767816487370; 
 Wed, 07 Jan 2026 12:08:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636c610sm20729075e9.0.2026.01.07.12.08.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:08:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/m68k: Replace MD_TLONG -> MD_I32 in monitor.c
Date: Wed,  7 Jan 2026 21:07:02 +0100
Message-ID: <20260107200702.54582-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
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

m68k's monitor_defs[] array implicitly uses type=MD_TLONG for
all its entries. Since we only build this target as 32-bit,
use the explicit MD_I32 type to avoid an indirect target_long
use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/monitor.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 784f5730919..6d101c75df0 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -24,36 +24,36 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "d0", offsetof(CPUM68KState, dregs[0]) },
-    { "d1", offsetof(CPUM68KState, dregs[1]) },
-    { "d2", offsetof(CPUM68KState, dregs[2]) },
-    { "d3", offsetof(CPUM68KState, dregs[3]) },
-    { "d4", offsetof(CPUM68KState, dregs[4]) },
-    { "d5", offsetof(CPUM68KState, dregs[5]) },
-    { "d6", offsetof(CPUM68KState, dregs[6]) },
-    { "d7", offsetof(CPUM68KState, dregs[7]) },
-    { "a0", offsetof(CPUM68KState, aregs[0]) },
-    { "a1", offsetof(CPUM68KState, aregs[1]) },
-    { "a2", offsetof(CPUM68KState, aregs[2]) },
-    { "a3", offsetof(CPUM68KState, aregs[3]) },
-    { "a4", offsetof(CPUM68KState, aregs[4]) },
-    { "a5", offsetof(CPUM68KState, aregs[5]) },
-    { "a6", offsetof(CPUM68KState, aregs[6]) },
-    { "a7", offsetof(CPUM68KState, aregs[7]) },
-    { "pc", offsetof(CPUM68KState, pc) },
-    { "sr", offsetof(CPUM68KState, sr) },
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
+    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
+    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
+    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
+    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
+    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
+    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
+    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
+    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
+    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
+    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
+    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
+    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
+    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
+    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
+    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
+    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
+    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
+    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
+    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
+    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
+    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_I32 },
+    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_I32 },
+    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_I32 },
+    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_I32 },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_I32 },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_I32 },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_I32 },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_I32 },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_I32 },
     { NULL },
 };
 
-- 
2.52.0


