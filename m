Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3EAC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafez-0000pm-96; Thu, 15 Feb 2024 12:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeU-00085e-48
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-000413-EX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:00 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d0d799b55cso13873231fa.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018552; x=1708623352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aymWm/ic6X17CiHjurov6BZsHrDsTLcxuJ5B3FGdVYY=;
 b=zaQouyacFK+5qZX6ILm07IguujCiz9GFWthOfM4ZAMdKaX4eJGK7apydcB7OGdHQV0
 Sd4yoLUaSLyjtlXC91IQ1lY2n2oR+R3i4dWSFrwMCMKlNOS4xd0EnnTjOcAxl25gDnRz
 uXB1eUtwsozoLbadxQcFjYlhKRJIPhqK+uILNUT7GpoaQKbidukkkNisfAIuvRa6uEdf
 WbInfPSHHA4+DRrV1n2Yni0jaoSmkkdKn7TE/FARfHy3Xwtg2wn3rata/sHCkGB4dh5X
 JWPj6HpzIE3zLnue3bMMWI+5ZQpiEkeYDbDd6irI3bZtqFk6Jx7Q6+mlD4KjtKp/bz1T
 w5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018552; x=1708623352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aymWm/ic6X17CiHjurov6BZsHrDsTLcxuJ5B3FGdVYY=;
 b=Dg6HLZ4kclLxnMpiASNUI6qq4eAnV4QqB03jb1Gn2+T1/zPf5wZSCogdS7edXHkCwL
 ZdBVj0rJnQedBOxpI21JSoOff6CqGfQkqZQMHC8nMO9vemJ0Qmw0eZMb4XCNYEuqwV0+
 ODAbQPeVQ+adVXnxJRsE64R4tU72xXa3+pYY/ZSu4RdfbPbE6sG+cDJZQCSpLYmu9j5T
 nDuFAzOGIyl0Pa5MoxkhYXOkGDjWWt4v36HouWqBBLMfVs1o2Y01BdVndhrigsV4pYKF
 a6YyFoFR8g5gBnbhj1E2HDI6+KtLoUaDUbXfQIboLj5KUJcNl9o9XjTjTfzsT7EOWIxl
 4XrA==
X-Gm-Message-State: AOJu0YyMrCgeD17luBE+uyzvj/KtstPtygDnwIOxrJADVLDyr1s5aXWa
 5vwt3b9Mpf9eBN07hI0mOEb5ivm1VLuUlysKZSNpBRh877652puc5tFXMhYqwOylIgswFQUs2fY
 u
X-Google-Smtp-Source: AGHT+IGoSeb00t9mwf4gx5NGmoxsNZAXiM5MVOOIE+Hi4NgutEvH79wtQfSconx3cgSW+3E5U+6ftw==
X-Received: by 2002:a05:651c:151:b0:2d0:d02e:26d8 with SMTP id
 c17-20020a05651c015100b002d0d02e26d8mr1930077ljd.32.1708018551735; 
 Thu, 15 Feb 2024 09:35:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/35] hw/misc/mps2-scc: Factor out which-board conditionals
Date: Thu, 15 Feb 2024 17:35:31 +0000
Message-Id: <20240215173538.2430599-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

The MPS SCC device has a lot of different flavours for the various
different MPS FPGA images, which look mostly similar but have
differences in how particular registers are handled.  Currently we
deal with this with a lot of open-coded checks on scc_partno(), but
as we add more board types this is getting a bit hard to read.

Factor out the conditions into some functions which we can
give more descriptive names to.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240206132931.38376-7-peter.maydell@linaro.org
---
 hw/misc/mps2-scc.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6c1b1cd3795..02a80bacd71 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -59,6 +59,30 @@ static int scc_partno(MPS2SCC *s)
     return extract32(s->id, 4, 8);
 }
 
+/* Is CFG_REG2 present? */
+static bool have_cfg2(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+}
+
+/* Is CFG_REG3 present? */
+static bool have_cfg3(MPS2SCC *s)
+{
+    return scc_partno(s) != 0x524 && scc_partno(s) != 0x547;
+}
+
+/* Is CFG_REG5 present? */
+static bool have_cfg5(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524 || scc_partno(s) == 0x547;
+}
+
+/* Is CFG_REG6 present? */
+static bool have_cfg6(MPS2SCC *s)
+{
+    return scc_partno(s) == 0x524;
+}
+
 /* Handle a write via the SYS_CFG channel to the specified function/device.
  * Return false on error (reported to guest via SYS_CFGCTRL ERROR bit).
  */
@@ -111,15 +135,13 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg1;
         break;
     case A_CFG2:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG2 reserved on other boards */
+        if (!have_cfg2(s)) {
             goto bad_offset;
         }
         r = s->cfg2;
         break;
     case A_CFG3:
-        if (scc_partno(s) == 0x524 || scc_partno(s) == 0x547) {
-            /* CFG3 reserved on AN524 */
+        if (!have_cfg3(s)) {
             goto bad_offset;
         }
         /* These are user-settable DIP switches on the board. We don't
@@ -131,15 +153,13 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg4;
         break;
     case A_CFG5:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG5 reserved on other boards */
+        if (!have_cfg5(s)) {
             goto bad_offset;
         }
         r = s->cfg5;
         break;
     case A_CFG6:
-        if (scc_partno(s) != 0x524) {
-            /* CFG6 reserved on other boards */
+        if (!have_cfg6(s)) {
             goto bad_offset;
         }
         r = s->cfg6;
@@ -202,24 +222,21 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case A_CFG2:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG2 reserved on other boards */
+        if (!have_cfg2(s)) {
             goto bad_offset;
         }
         /* AN524: QSPI Select signal */
         s->cfg2 = value;
         break;
     case A_CFG5:
-        if (scc_partno(s) != 0x524 && scc_partno(s) != 0x547) {
-            /* CFG5 reserved on other boards */
+        if (!have_cfg5(s)) {
             goto bad_offset;
         }
         /* AN524: ACLK frequency in Hz */
         s->cfg5 = value;
         break;
     case A_CFG6:
-        if (scc_partno(s) != 0x524) {
-            /* CFG6 reserved on other boards */
+        if (!have_cfg6(s)) {
             goto bad_offset;
         }
         /* AN524: Clock divider for BRAM */
-- 
2.34.1


