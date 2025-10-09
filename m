Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90E1CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsQ-0005Sc-R0; Thu, 09 Oct 2025 04:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsP-0005SU-NE
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsM-00089r-6D
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so9744455e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997986; x=1760602786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZDnAdJCuM7z/8L8oCUhOHfHNKctPA6ZwCdk+fww2/4=;
 b=ZVRxfw3kHV/cRcMMOXwf30+q5ot6lY+0pIFtdqnommnaZrnFlhKBpKH6wr0LqxPhNd
 4zTTORsDlwSzJJfAHRzxAqasft05gMeBb1a76xe6vlUdmAXb6sHZIlF0SrHWzCoAKDrW
 WSug3u8dTnN7X/sVKeNy50lriKU7YlMV/wa8UnbbqCtmwwf2uoxCDwgpMnpDv6Z4fEtp
 rjYJ2oUt4tQSn9Q5SB+wtFOM5mZAPWZv+erRI0D/F1bbUJ+VkAPCd7XtHQ/pUWQebYaL
 K/LBsXNiKJYJffPxKDXwCVJPv3pVDMLgmDBGYoaMpyfe+ZzMS0nWgSZrw21OCVZz3Ukd
 GKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997986; x=1760602786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZDnAdJCuM7z/8L8oCUhOHfHNKctPA6ZwCdk+fww2/4=;
 b=vlOB0Wt0zdW76x2H8CIoYJQ05exi5vq5DL9LUu6v9LR/PWVCrZOX6QhAhzNDFUVHLD
 J6eFcYGo7xJ2r/cWZcCPr+w6pFqpMYkP2fmW32+fuk6EZECHEE0OHvJJdm7d4WE9XPlk
 Ou27DsHPzUvTs+rrwr3UEkrakzxJ7Jl25ZAQLNJ1r91WGG/3/RThKu0MI/EgjMynhy/9
 fg8ak4wVKuf6iNpx3YB/q2OcrlEGEfdiPuiVNs366cvMc5eYahM8v4H/4g+uC1wWDSxV
 Lc+V1n/bySnMTVMp0L68EiYz1mUR1VYgVF7ogtddZaH7IbnTZ/QC2ps3heyklIfpedjE
 IH6A==
X-Gm-Message-State: AOJu0YxXtYD2Cr7VzBEHwPJAHhFNRcNCJUbspOSofUp6qZqG2nChURhr
 9OorGLNid0CRH2P36/iv0B5CkkpVIqPr4wZlWClil5osO3VMJ7wsbpu6gM8yRLUSgpvLvi52t7K
 rJm8Supm5OA==
X-Gm-Gg: ASbGncv5k+QNewTX915YJXodXx+AjH77X6pQhh64QxRlYwcWaNSM2FxMw2iDF2COtFp
 keEl31seRzfOtGq/ExhYxzWxHlqr5+TpWfvLoqQFZQL40jcO0o7nkhDJtWE0BSJ4jHJAsdQr5l+
 kUPO3VTM4rpY1ayfiQPbYets3jDrW2hbOc7ZftSEhA0rQIa+T1nmShoP21FfkBKpW0QVadU3Xxf
 TWB6ojvvz4wY07i3rQyi8zaKBx1/UOsYiVWFVIrO7fjliWoN2qW3FSLM2RTen+QvdNzZcxA3sPg
 07qGLI558N6bq9a/S3oYewnJi8xkCxE+PecQOibgwgcQ5Iq0OxqL73x04rmZFhc4kwKwGN5v82c
 DySqzjHHTEz4QnONUAWBYE4W1Do7b8pvvhnGpR1QIBsd+Ry52KJk6vgzKkrdTIlpTwFTcP6mcUH
 43f2Mkwb0ye0rsSEmuc/uuBMm8
X-Google-Smtp-Source: AGHT+IGoROhh4BC3hfvbI989ju2E674SL4lzchi6exC/2HdSQyhoucR6hU4gs793jPpLHWQkPKfxBQ==
X-Received: by 2002:a05:600c:c10f:b0:46e:33ed:bca4 with SMTP id
 5b1f17b1804b1-46fa29f3f12mr51833415e9.15.1759997986533; 
 Thu, 09 Oct 2025 01:19:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d629casm72028125e9.16.2025.10.09.01.19.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/10] target/openrisc: Inline tcg_gen_trunc_i64_tl()
Date: Thu,  9 Oct 2025 10:19:01 +0200
Message-ID: <20251009081903.13426-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The OpenRISC targets are only built as 32-bit, so tcg_gen_trunc_i64_tl
expands to tcg_gen_extrl_i64_i32(). Use the latter to simplify the
next commit mechanical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index dd93cfd6074..7cb4152e357 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -345,7 +345,7 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during addition stage.  */
     tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
     tcg_gen_setcond_i64(TCG_COND_LTU, t1, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t1);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t1);
 
     gen_ove_cy(dc);
 }
@@ -386,7 +386,7 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during subtraction stage.  */
     tcg_gen_setcond_i64(TCG_COND_LTU, t2, cpu_mac, t1);
     tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t2);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t2);
 
     gen_ove_cy(dc);
 }
@@ -904,7 +904,7 @@ static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_trunc_i64_tl(cpu_R(dc, a->d), cpu_mac);
+    tcg_gen_extrl_i64_i32(cpu_R(dc, a->d), cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
     return true;
 }
-- 
2.51.0


