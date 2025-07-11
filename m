Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F372CC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaERX-0007LF-5F; Fri, 11 Jul 2025 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQr-00064w-QA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaEQp-0005ta-Rk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:08:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74b50c71b0aso1303930b3a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752242933; x=1752847733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4NtslpW3/Kf+pVoZt/RQCZrcDXFq6jIs8FEoGRVG5I=;
 b=PWSd11nyLOJinWXw42mWiMTvAVrqr1spfB9zSlFoI3MHqaSwwSzKqFXwk6NBPUOlY1
 5RB11sMp0FA72cBXFYmY4QQ/66LKauZDHbLWF0KCy557gnf3M3WUnzlz1s/lKUkICcYS
 vMqsnTS2kpXWxMYcCY08IUTFa10Zt7VhqCZ5fW2uqSZQSiCkP6HimEpzK4p8petsyT6X
 7TY1Xwhzb2Pw4pl4CBZJrL2hJsghZWU4JWqa9FbpTvaT1fjCOQ7PUj2IQ5sTCSndNIYq
 10GW6+ORrx+XESfW5PoUyKb1MWOBPwtYTShHTJH3mYnzmAXO+0QT72f2wLmmTeawjo0v
 TKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752242933; x=1752847733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4NtslpW3/Kf+pVoZt/RQCZrcDXFq6jIs8FEoGRVG5I=;
 b=cM0A854R0TfU0O3zq/3Ty7E15tc1aP7aug4+0neWOltK2ML/7B21qXyPfcRp0JyE1b
 00t8C2xbMVsnKzOZTG4FSw+MtqgMj5IBUnLfwbhDI9ix4aNo4qnaFvGhvUwN6MLJK/25
 tGofuZvbAuWjF3cDdDKsR+cHMHndE70GubJs8a75CSI9rz66pttGzWOgnzXkWA6uUi8D
 8fVRDWe8VbeLsq8PRkcTQXNoyc57ve/QZ9On9JB9ZHuo2aKPluoFyDfBlurKk42jBbYk
 nk+y+UcGoT1OT/WwJHSOT6v2cTFsoErnpJVJB6aia10fmScG3kR9g7e5CYkSHq65njg/
 xFjA==
X-Gm-Message-State: AOJu0Ywsz/bK1ba8qkcAUCr1SLVngYpz/SqY0e+MStpgvZtcZEzrZyOA
 zL68utEWUOICjOjuNoXulpXqOIf/D+driuOxP9wyN7A5G2LKUW356txuu3UAw1hpE2Qbs1xx5V1
 un7qaDSg=
X-Gm-Gg: ASbGncvmlBSpnlF+31E5wPnBL/S+CgJZUD3UqpuW/Yg8e9U++990Go9ICfsnne0wWCq
 3TC4E339CkCu0kXYrefGUMsVFYGlKxeyvuji0DlHRBlUJsKj71A9Jz9ehXf//ONwhiJZ/1wjREc
 lgbbTLuh7Y3Mnm5HsS+XUpsc/yOl4C4/Coo4OZwZII3NgnVPskgMwyLub6ZV2Y542MASAErD2pt
 SHlBj3dASf0NTH75yRftCDv8dMYnNjpXFpaY/6KHmFdRq4IWtLE3U0+o5DyhMxg02Zp6GJYlTCW
 smG/EITzVcPTuiV+3SZg6gnout0gzxiiyYCceO0Q0hww/XyMfX8X9qFJmA72M4miq2Igtn+llF+
 o8WUqFo9CpJnY9PTNbQMqHNSsXvv1w9SvPXj3UlhUUBrFFog+ZkT7MPpMmueZifhnUXGT
X-Google-Smtp-Source: AGHT+IFdBNGkIuSKOcgoVq5GvRCfnqUAbEHJSyD5Y+sBp/uxsISi7Wrp3JUCrhMtb4j7PJmO+6EmFA==
X-Received: by 2002:a05:6a00:b90:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-74ee07a860amr4510965b3a.7.1752242933238; 
 Fri, 11 Jul 2025 07:08:53 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5d3esm5702280b3a.4.2025.07.11.07.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:08:52 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v7 1/6] target/arm: Add the MECEn SCR_EL3 bit
Date: Fri, 11 Jul 2025 14:08:23 +0000
Message-Id: <20250711140828.1714666-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711140828.1714666-1-gustavo.romero@linaro.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
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

The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
EL2, so add it to the SCR mask list to use it later on.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c..ffc91d6b49 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1713,6 +1713,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
-- 
2.34.1


