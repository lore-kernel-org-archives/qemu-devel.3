Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB574C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIv-0000LY-IG; Sat, 11 May 2024 07:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIu-0000Ko-Aw
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:16 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIs-0006yx-5a
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:15 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so36033161fa.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428452; x=1716033252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCWM57OHz2JIAYU8qBsg/sKiTEv/cPu3ovotF6RL+Z8=;
 b=kfWURy32Zi2yAYisiVAsgy741USynyaBZnMAnSUKuxo1eAfBA8GsRjMVCz+7nvK6GZ
 B8tg6XW7EH5UsWBbL8wOB9k39lVSoUSWPxSow/OIZ5y4cjz3PLfVxtx7s6aQcaglbL+x
 OHNjQ3y4TOwii3jTQ/s5s9f+gOv1vp3OnobafJ6dtG/QmOxU51WH8A2g/hmPq7HAq6rj
 SuMwrHDn/JS9frG5TI0XPcilNdtJOpW6i0evtLoj9iRY7C90ujQQf1piSuxOtKDSAFs1
 Ijkw/7AykcD3m7G7iLChcjvgWn2dB6Kjmh8LVIHCEw1I9lmM5BVOB4Fe6tOZlaBG1Q3y
 0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428452; x=1716033252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCWM57OHz2JIAYU8qBsg/sKiTEv/cPu3ovotF6RL+Z8=;
 b=IQkzETg+5Kn707cUV3tnU9kunQjemzf9wmF2h4V40aLSj/lVFh1H4mEbTs6dXNMs67
 8o92FLQm8trX/TgFr1maTIpYp9P8OvrtC+SdDpvM6KxchL1Z/ULRXHJzTSkcZWJuYVpF
 g+A8AC4inNVex8o2AUooJfnqwlcyXDgj5mOjebxV+2LLUAZzRrMlbXQH3TYHoJcJV6Dq
 JnZ1mh58hBHattqyIKTudUDKd/WC6/or+4WcP+DZvre0RirHI4I3EPYBSUNN3z/Vq5/t
 VPIJU4gqnlSHqzVWPu1J89qI+QYzsGXVvH5entAzK/fYfYMJrUHywz9mTTt4FXoxkybb
 cunA==
X-Gm-Message-State: AOJu0Ywx/ELUFj1/LdQRcD2F0rSPw3Uab8umcnJBhJf3XsivZirpwUZI
 MtOT22F/rbbd6Gv9uCDckW27XxgcRGeY9ytZnsAAzViylWM8/5XceCkHW11dEFGK1gs5SZNq1+x
 E8vI=
X-Google-Smtp-Source: AGHT+IF3gseo0zQlzpUdlDtgdnibkTBQluOCJVlesMeJydhNK0HKiM3UOHhZtgQKr9KrAO5cHbNZYQ==
X-Received: by 2002:a05:6512:308f:b0:51a:c21b:73fb with SMTP id
 2adb3069b0e04-5221007498fmr3804932e87.44.1715428452385; 
 Sat, 11 May 2024 04:54:12 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 10/17] aarch64: Tidy reginfo dumping ahead of ZA state
Date: Sat, 11 May 2024 13:53:53 +0200
Message-Id: <20240511115400.7587-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
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

A misalignment for sve_vl, plus add a bit more space
on the left for the ZA[n] field name.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 0161044..86e70ab 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -183,6 +183,18 @@ static int sve_preg_is_eq(int vq, const void *p1, const void *p2)
     return memcmp(p1, p2, vq * 2) == 0;
 }
 
+static void sve_dump_zreg(FILE *f, int vq, const uint64_t *z)
+{
+    const char *pad = "";
+    int q;
+
+    for (q = 0; q < vq; q++) {
+        fprintf(f, "%s[%-2d] %016" PRIx64 "%016" PRIx64 "\n",
+                pad, q, z[2 * q + 1], z[2 * q]);
+        pad = "           "; /* 11 spaces */
+    }
+}
+
 static void sve_dump_preg(FILE *f, int vq, const uint16_t *p)
 {
     int q;
@@ -211,10 +223,10 @@ static void sve_dump_zreg_diff(FILE *f, int vq, const uint64_t *za,
         uint64_t zb0 = zb[2 * q], zb1 = zb[2 * q + 1];
 
         if (za0 != zb0 || za1 != zb1) {
-            fprintf(f, "%sq%-2d: %016" PRIx64 "%016" PRIx64
+            fprintf(f, "%s[%-2d]: %016" PRIx64 "%016" PRIx64
                     " vs %016" PRIx64 "%016" PRIx64"\n",
                     pad, q, za1, za0, zb1, zb0);
-            pad = "      ";
+            pad = "           "; /* 11 spaces */
         }
     }
 }
@@ -237,19 +249,14 @@ void reginfo_dump(struct reginfo *ri, FILE * f)
 
     if (ri->sve_vl) {
         int vq = sve_vq_from_vl(ri->sve_vl);
-        int q;
 
         fprintf(f, "  vl     : %d\n", ri->sve_vl);
 
         for (i = 0; i < SVE_NUM_ZREGS; i++) {
             uint64_t *z = reginfo_zreg(ri, vq, i);
 
-            fprintf(f, "  Z%-2d q%-2d: %016" PRIx64 "%016" PRIx64 "\n",
-                    i, 0, z[1], z[0]);
-            for (q = 1; q < vq; ++q) {
-                fprintf(f, "      q%-2d: %016" PRIx64 "%016" PRIx64 "\n",
-                        q, z[q * 2 + 1], z[q * 2]);
-            }
+            fprintf(f, "  Z%-2d    : ", i);
+            sve_dump_zreg(f, vq, z);
         }
 
         for (i = 0; i < SVE_NUM_PREGS + 1; i++) {
@@ -312,7 +319,7 @@ void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
     }
 
     if (m->sve_vl != a->sve_vl) {
-        fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
+        fprintf(f, "  vl     : %d vs %d\n", m->sve_vl, a->sve_vl);
     }
 
     if (m->sve_vl) {
@@ -323,7 +330,7 @@ void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
             uint64_t *za = reginfo_zreg(a, vq, i);
 
             if (!sve_zreg_is_eq(vq, zm, za)) {
-                fprintf(f, "  Z%-2d ", i);
+                fprintf(f, "  Z%-2d    : ", i);
                 sve_dump_zreg_diff(f, vq, zm, za);
             }
         }
-- 
2.34.1


