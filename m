Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D297CC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPH-0006J5-PF; Sat, 02 Aug 2025 19:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPF-0006BM-GN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:50 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPE-0001w8-3P
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:49 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-433f78705feso215198b6e.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176367; x=1754781167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v+oHh5NI/CAD3fUn3WO/NvcFU8grJSwgg1nXQ9k+uE=;
 b=XeimjJJ4ewTiMRDKLOpbW2otdUdISfqogiaQoJtySTh75vzSoYHWSeDDNHGBBJOWkG
 X7FAIluastjpRmqM/MFksj8OMpIfqwE12jLobB7maAYWQtlwFREBtdt5tAiBDLGEfT9+
 xMPOIesnTDq9berRRtZKulctWEYsIcoAeU1UlPp2yDNq92Nqneg/oxMYMnek/0wJBUJV
 uH61e9aJryrJ52n0X/ZYy4gfU71MI1vo4hGy3mpC1u+oqSyEQFqA9au6GXv+fQH6i/Em
 DUofI2frQ/N2Yo2VGOJCvzN45wqzBII0otu1PuAWwYAIjhEdZYoKNciPWegoeP9UM4fI
 b2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176367; x=1754781167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1v+oHh5NI/CAD3fUn3WO/NvcFU8grJSwgg1nXQ9k+uE=;
 b=BHuEM4nGMhFqzsVtVvguHyLVY6cXTLFxQnijE+dtluPs/2cVERmH4PyPGcwCYtaiWI
 eP+QoQayIWFvyBQxF8kImEFYkh/8baWi4C66kQ0QOfQ/AwTXdE/YDyF4LQycf95x27jS
 Fak3LktFqAI45PfMGWBqyriFwf0pTuAgIe0Q+8g26DUT0CAIBN0x0Ot30Q96EQJ/3mtS
 MxN5C3mAfSBfapefujGKLxIoIWDtr7u0ADuv+PngraZrBvEhWClbnW1Xiv6xGUU38i0O
 nswwXfXLq+ANSXP1YYdykOGMKjgC2/qDh1YfMzTgC5ZRa/V+6LGb8IQQcqz2/RgJl9Ki
 U5pA==
X-Gm-Message-State: AOJu0YyOOfORaDaWpXYtfexVGI0A6D7hrqYPvpigHmhNTnDAIRaVIz9c
 s7alSwZwzPvUX7wpdVHPSVpfTbCSUYLJlupGQxCG3AmAZIF9Da+wymh5H7rJOSsZcYiOrSWs8BF
 bR+fw4NI=
X-Gm-Gg: ASbGncvtd4PK6vpWPMA42c6DjoNScozDXpTXhuzVauYEvf1d3S5bhI17rr3zaQvEh0c
 zwytZ9ilEP57DxN9GBmd3QOBUoifmpH1Jm/BHshxC6V/IvoaWfsxEz3kW12KSbh5uqRorHkkL49
 8mkrDSOZItArOIKb7Z7hpGD5GC6l2S9DKxA7pS5YOup4olUXLu69SgsuDcU+lNR+GnIrvnGgTDS
 vvuFTOxeUsxVSO5sSMWr2b8PL/6HuRjHusFKE6rwO/+xk9uO13PdORusarxjAxsixJ2Rh2AsmjH
 p69hGKNo7sWCa6CstOM1vMe6JuXzC0FYT4oipJoaTrzg6b9gMf1cPwcAazYoR961fYcELYD37M5
 cHE3TeRseLQa7yGSX4WFJODrG7pPZXSPYL4FuQh4gbwWc8WDd9o13
X-Google-Smtp-Source: AGHT+IGlflxpTRet0YHulrLculCceiY8HjOQv3U6hbDQa2KpJSZ13EzjAvtEeUlIrcfKXq78C6j73w==
X-Received: by 2002:a05:6808:4f62:b0:408:e6e0:910a with SMTP id
 5614622812f47-433f0343a37mr3218925b6e.22.1754176366914; 
 Sat, 02 Aug 2025 16:12:46 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 78/95] linux-user: Move elf parameters to m68k/target_elf.h
Date: Sun,  3 Aug 2025 09:04:42 +1000
Message-ID: <20250802230459.412251-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 3 +++
 linux-user/elfload.c         | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index b721687d3e..568b7be389 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_68K
+
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG                20
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fd3bdfe9c6..8c908db2df 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_M68K
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_68K
-
-#endif
-
 #ifdef TARGET_ALPHA
 
 #define ELF_CLASS      ELFCLASS64
-- 
2.43.0


