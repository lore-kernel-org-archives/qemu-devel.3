Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32E7CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMzP-0003JP-4x; Wed, 24 Jun 2026 08:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMz2-00038A-11
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMyx-0006Ml-F0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46caaa805b2so297272f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782305130; x=1782909930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CUGXCgJ/v0R7ibNkHtL3TbwmGCixpAdTMGatt/6hsY=;
 b=f6Yl6lyfbi2BfybLNoUeTjeqc10DptNOCMp2pClvFmrhL66ee17ySARaHLVdWdy5E3
 ejaUQysVEkHjkVP/e+xKaR1SI3e5bve4UpNA8AE2z4qhx5FUF3zxm6tdaepwj+DQ2uUU
 6+s9Z96ChvX4o9LCbsQaG3CQjrNASnysKlPBvmyJXjdANjcYgFtYxZRxLqPEmas6fzlw
 mfTTEuhPld4QfeWbSVzIn8pkOK/7aXj3UDIzQZj2L44Yk8DgoZpzcY7jBoqqXWfzgn+3
 umQxsJeSOkkZoNkCx63OLJMQS0PEwM1wng6wUfGa/UBgsX8CmJlCIpn9NEXfJioipg3L
 Yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782305130; x=1782909930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3CUGXCgJ/v0R7ibNkHtL3TbwmGCixpAdTMGatt/6hsY=;
 b=KpXIO6OoMWJSOURi3jPo63gjOHLLnMBd4w25yZqH9XecS2Sd6K0l+rJxcGVlDYgNXB
 4x12O4LUvuTC7nTzlnC4EuVig/8j68w8PEYJv3RZ/aFqptIXdvyZQF88BH03k9DQXdB3
 c1ckkWdb6N+P1Zic71+rhaZk8BbITFXgfUVhyWS1tUmlfRTJI77ASck6eZHJMTe2T68v
 PNinNuSM8PgIHXO3Rd2WYwVmzTax4pXH72Nko9D8QGUP7bZtSQ3pP0czPzMnQnlpP61p
 sog83/nHs/Ewj+G9QhdIyU9RMttaOflF6rzREPCS0AG4H0A3LD9HfPsSLEAYEDZxTPrL
 vXPg==
X-Gm-Message-State: AOJu0YwcEmHHm4deBrLz8IWfbeoWdnQL64Rtl2j71VMr7fNPHiAo3Ank
 ACjq5pUfRZXDk5Uj5f17JaO6xJZQLaYXy7P/7C1CLpKeCDwgvYPejKEr5hpdEGZDNhg=
X-Gm-Gg: AfdE7cnCX0Xx57qV6tKHVxoP1xiftizIPoZNfbHMir4vLJpr65vh2dFYXAzIH52Jvsq
 YP1ZKHzD6Mekx4E7rLa1x8gsLY7K60UDoeXzvHnBT8lbP2Sgu57k8jgfR6WUX1SwVJwUyXqbIPC
 AqiZiF6rgCD6jOZfDKM6h15Xx2fqUivUBXACNpQA84csEDBbXF8MU32B+sZkPtE1NbFS3M/tMXU
 67ZiNeH1925gm2Ma7xRwM1xOI9+Y48kDQ730cwXEzaUxdk4KD5xQGgezzN++PldmpTXIj7r3S5T
 6k/IgGx5wNbN6ilk5vkFLkjyUVkfpskKQ92cBLGZ7dCbDrIutVr/sYiQkV4fP1wvQpnsxvvdzgE
 UFf/Yb9shfACAeo6cp6ajaDSrXwnJvEM5VrizJ9U4OuX15Dj1w7zQU+4kBLRacm62FHv70JLu64
 VTXxn8posQK8VE
X-Received: by 2002:a05:6000:188a:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-46c0c90c335mr5299150f8f.40.1782305129863; 
 Wed, 24 Jun 2026 05:45:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93d8sm11792299f8f.23.2026.06.24.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:45:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E8785F9CD;
 Wed, 24 Jun 2026 13:45:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/6] target/arm: trigger timer recalc on SCR:ECVEN change
Date: Wed, 24 Jun 2026 13:45:24 +0100
Message-ID: <20260624124527.1018912-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624124527.1018912-1-alex.bennee@linaro.org>
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Toggling the ECVEN state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f0707126b5..9b843857e5d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -37,6 +37,9 @@
 #include "qemu/plugin.h"
 
 static void switch_mode(CPUARMState *env, int mode);
+#ifndef CONFIG_USER_ONLY
+static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
+#endif
 
 int compare_u64(const void *a, const void *b)
 {
@@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     changed = env->cp15.scr_el3 ^ value;
     env->cp15.scr_el3 = value;
 
+#ifndef CONFIG_USER_ONLY
+    if (changed & SCR_ECVEN) {
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+    }
+#endif
+
     /*
      * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
      * we must invalidate all TLBs below EL3.
-- 
2.47.3


