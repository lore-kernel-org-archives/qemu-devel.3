Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA55C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguTX-0005lb-K2; Tue, 29 Jul 2025 20:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFF-0001hL-CW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFD-000437-Oc
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso4194187b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833630; x=1754438430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LkrQY459LX6TuNccjzYkBEjK2nXWQqVf45BTNPct0AE=;
 b=iFgnV95ZD6xA3NTLza8Tbm3fuh6waZwhpameJtt5bPfAEWCG8sKvSOu0yoGvLxZZt2
 npjzPq/oBNMxPGeDintjObwIvfznCV9uWx80FWWspPQW7Pb9k9CHcvHycKdc6+hwCZlm
 8JEI7pKwA434LjVoXeCJ+UJOePuHiAoigrYZUpdNOqM5MrEcwTMfFN5RV7msiyMtxD2s
 z+yqPNyGLsjGlkZvNNh6UPcUQVsOczD9YEP8TFpf0M2McYY9QuxDd0y8HESA2WLomUfb
 yTdjNhXAsbi4PAhdU856dQS7KFJkjGpZzU29xuPOAui6enIH0mmPI2Q43oW5q/tEAiQ7
 mVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833630; x=1754438430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkrQY459LX6TuNccjzYkBEjK2nXWQqVf45BTNPct0AE=;
 b=j9cNiMtE4AONMM42YmOiBKTgi932c6KbA+dTdLHZiVN1XDb85/Oc6VDswK49Aj9crM
 8eMGbsOc8lSB2KewY/zt4PxpIaHZWZTva62+51tUqdH1Nn1QW3WjEu6eIVPSM+LPqoSa
 ryu/EhlS2XiYCh069k9nEobyx0TWnmOKfqTlzSiLQT+4C7XJ0/GCvRRk2eJlyoreH3R7
 kvVCOLUGtXmtziCNml2guihWPYGjR3110XKvFDM6oUwgEYJGzRal3hr5ajBJg8qu6mM9
 hIPHKs5aGkAA8xJ7MUMHrzAO66ZW4qaroFv3QbIZ8osP8O4b7RjsLyo43RWIEX+3DsTP
 iAQQ==
X-Gm-Message-State: AOJu0YxFcZSu3rWGv0BJaWUFQpozYpHSSgqgmDCZEUecWH5hlrb6qZA0
 mlTxmCYtOI1SLTXpoKkzKScYnLw7GQ85MogMpwflfrSGU/m2W+UBDQ8CZtr9ry9+DjuQEDnFN06
 90Xf3
X-Gm-Gg: ASbGnct7sgjOIdq0P9ohlvxFb1um1zCMbDIfsVGgc9/igzxapM2eCoaRfpbKrMJH7k0
 eTrDatitGQj5NaO8meHnzyp80Yud68H9HjrOZK0PDIcHSvQNi/4aEGpwoKRlnKGlaXKpJnHFGHi
 3rg35ZlO2qymnsAdEE5jpDrpoqhZSO76ZQ/hNqEGCdsyo0yabloml83VbMI/fSS5yFZ5DAr4s8K
 219he2tAIVdwfGdYFAnX/Ib3CgBirmplyb+zxtLYP8NwkT5lEEaSn1s1qsmolHc0EU4ee17/Chq
 PWzmOsb9hh4KVZQntggnT5eOmQfD58I2Wfxf5BmnCgQUPH5cRkUaF+SKH6kOKsLTo+tavd6teaj
 l0FJ37tfNaImFEA3HT9HfO33R5xI23df3+KlHXJkpmPUsULNpb404PjUUCwU/MGhKjaHlNEjcTA
 wLOzOMUAx8Nw==
X-Google-Smtp-Source: AGHT+IGN1YaJoASNs4nneZTEpzF2/6XWzxXFHiYvt3dP3gSXTPC9idawfp1O7jzmEdJcmOiRYZXKRA==
X-Received: by 2002:a05:6a00:1394:b0:74d:3a57:81bc with SMTP id
 d2e1a72fcca58-76ab0922669mr1674585b3a.2.1753833629185; 
 Tue, 29 Jul 2025 17:00:29 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/89] linux-user/i386: Return const data from get_elf_platform
Date: Tue, 29 Jul 2025 13:58:47 -1000
Message-ID: <20250730000003.599084-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Rather than modify a static buffer, index into an array
of const data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/elfload.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
index cc75b4f2d9..6a79738786 100644
--- a/linux-user/i386/elfload.c
+++ b/linux-user/i386/elfload.c
@@ -12,13 +12,9 @@ abi_ulong get_elf_hwcap(CPUState *cs)
 
 const char *get_elf_platform(CPUState *cs)
 {
-    static char elf_platform[] = "i386";
+    static const char elf_platform[4][5] = { "i386", "i486", "i586", "i686" };
     int family = object_property_get_int(OBJECT(cs), "family", NULL);
-    if (family > 6) {
-        family = 6;
-    }
-    if (family >= 3) {
-        elf_platform[1] = '0' + family;
-    }
-    return elf_platform;
+
+    family = MAX(MIN(family, 6), 3);
+    return elf_platform[family - 3];
 }
-- 
2.43.0


