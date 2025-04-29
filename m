Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE47C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ozY-0006nk-9v; Tue, 29 Apr 2025 13:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozT-0006mJ-UI
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozN-0006eD-M5
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so94949055ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745948603; x=1746553403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6RffWNiSHtCqsSFyIEcnkoAwVr3p00N7Ef5Yz/c2S8=;
 b=fy/23aqCob7kWH0FckGtBOUYK/wlxDX1168GCNvZF3X4tTXy5UjIS83CjsPGcCIH91
 NIYcQqTwwc/xN7vAqxpzXHWM/bUGECmu5xjIcNzioL8vH34ba6xje6uqN2O7RuapebVZ
 utDuDSOAf6ahFBlxrTCMWGF0ouMS+5zlbtExW2FM0KBgrFbfiSUBeChkUipYqaiV1KuV
 znPR7HGEVXS1RTrxhzW5GPXL7vLNl1BjPJhvlPbYy/lGsIsCcBAfkJi/DhvJjCUcHcoU
 HFdgIGomKv3C1+QkiR9QV+H4+5GcAc/27egxrWO+K/qg+2TsAMsh6iuXykwSvII7Wjz2
 JdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745948603; x=1746553403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6RffWNiSHtCqsSFyIEcnkoAwVr3p00N7Ef5Yz/c2S8=;
 b=t2sQ8qG1n1Qczbk206ui3IqZY9psvMsKMbkcafNJSZJADcNrp+c+MbNWoxYUaGCT8/
 piqmrP9L+GhwxrvrA8ySpcTBDUVgoTpGX0J0S3mFgKeoXa1rwPv98hkJuovpV/AnZ8Q6
 Trn8qP/XHARM0SwU+Xee0zvTMP8fQBi2R7fjS6mYo5TaT4cnRmznZFJk53Ff9ZvvLd6o
 IcagZnVVcw8FqDqEWu/ycWJsF6aSIGf0EZCRsto/3DumVJ3fwBBD77SqH7qD92iunndZ
 LOdShZZGaIbHTbm6nCkDYcTC8LV93M94hCHKKN7sAyGJd1xafTO20QoSDsB8oqNayXXl
 aNOQ==
X-Gm-Message-State: AOJu0YzmcSgLq4/CSD3EmH38vBlKJUAWF89iDr4tJNQ8aJYhkdh2tBnS
 iQT/GzlLeuNiqktVaVlNpeLXgUeRX0nnb1xfl7BoNjWBlQa86huy+BVNDmwxifLlTDM/H6DRGOo
 Z
X-Gm-Gg: ASbGnctxecup/bBowp4tZWsRAWFBMq6R1mkdqvPZOI6PVqL7snPxTtYl9XDzxWgsSUi
 FNuGlsLzHtnIZ0fkot0nWoCf12julZipPem7IFF40jQPwLgZ2NdeIP+k1GofGf4lwHD1S+mkdSo
 aTJeRB/dWJeL3t8RT6f+cmyS4OvBA8sf3GwBxVy251vi9WwzKTFC84O2G5RpHnvAi1UGCPbFC6Z
 Nvm7pyGtZkFMr8RkfL4rLSC7hwmZ6PjAbPkthdMy/lIjsGfyWifuMg51s0lLm+eEGjVmekTHkWJ
 KhlwjiXVigQWsxLXfqBRmGOE7MBw0hHsw5+b5KLexocn7VmHDTYDnOlnH3XdkMl6dUs1ca3tHq4
 =
X-Google-Smtp-Source: AGHT+IEEFZZ8lGqpuz4AWJnpn13ZvRfQwJOPlRZOBnhTctfH7fVTilkh1J1RBBPiRpvF8jJdaMbTww==
X-Received: by 2002:a17:903:2283:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22df34a9f70mr3925745ad.1.1745948602757; 
 Tue, 29 Apr 2025 10:43:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4e0c385sm105795955ad.105.2025.04.29.10.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:43:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 160/161] tcg/sparc64: Unexport use_vis3_instructions
Date: Tue, 29 Apr 2025 10:43:19 -0700
Message-ID: <20250429174320.1841700-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429174320.1841700-1-richard.henderson@linaro.org>
References: <20250429174320.1841700-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This variable is no longer used outside tcg-target.c.inc.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-has.h | 6 ------
 tcg/sparc64/tcg-target.c.inc | 6 ++++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index af6a949da3..b29fd177f6 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -7,12 +7,6 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#if defined(__VIS__) && __VIS__ >= 0x300
-#define use_vis3_instructions  1
-#else
-extern bool use_vis3_instructions;
-#endif
-
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 83167aa29d..260dd461bd 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -274,8 +274,10 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define STW_LE     (STWA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 #define STX_LE     (STXA  | INSN_ASI(ASI_PRIMARY_LITTLE))
 
-#ifndef use_vis3_instructions
-bool use_vis3_instructions;
+#if defined(__VIS__) && __VIS__ >= 0x300
+#define use_vis3_instructions  1
+#else
+static bool use_vis3_instructions;
 #endif
 
 static bool check_fit_i64(int64_t val, unsigned int bits)
-- 
2.43.0


