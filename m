Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07AEC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5V-0005lR-Rt; Wed, 24 Apr 2024 19:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5S-0005k3-6r
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:39 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Q-0003Q6-GD
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:37 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so374485a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001495; x=1714606295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72opLZMRAnTWHZuSokDnzsmDpQQDFnMJLSYqW0AMFXA=;
 b=wa5bX4kOl33pknmSF+8zBEZW2xIxIYq8j++dQfI/D8IhtJuCk9Lh50Y5553HeA230I
 X/SG0GlVzi3G84PsFX/ZD5iW7I2q4Fv720zow8XN/gxHWUY95QVezWVyXrHVLVGIH62W
 a4POuJDxDsJLVau8kS6mR9iU+C1UuzIETDO2RnygaWKZWFU48sHJgVJQL6tWEEhIWoAq
 sF6RkNegf75Me/UdXNRmiTGJNFBkbTEXlizNjiOjj2O1aWs+6ffPa8L9+CmDe57Rl2Ip
 jfAqXH90BaUxzW1/AY/Rdr678GLX9YP+AqHz9mJLPPTw5QABWUu2juriTV1/6sxPNM7G
 dVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001495; x=1714606295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72opLZMRAnTWHZuSokDnzsmDpQQDFnMJLSYqW0AMFXA=;
 b=RfRI2vDuOcgJdhScVl7rsb8NJfBiqo/53f5ji1biU/xXXAGhiLC/ezYcroY2PSfaQM
 C866Jnk8yA8Cb2558jXtxa89o2+XjluOxKZBgEvdDLPp6cmi9pgg9Y4HTpd0vsccPsEL
 PbsM7sprnpygykwDTxqpUD79bRg6DbBxw/S/Kx3foGSIDPmvHB4iwM3ubzNzMtYxL9Eo
 0/7Wxch0MH3V41J/KsZ6NObY55xZl7x687uC1mEwhN54Fps22DALcvVocwXvcQVbWmin
 cUA9tbwgKGVl8ojpvVn0aoegz7g7Ni+sv7cVeV1vkNkT4wqHKQ/Dkt3PIFx8RyYdNkwl
 rNig==
X-Gm-Message-State: AOJu0YwcgLdaGAX5eyi8ZFCtuf4ong+BbP8yPsdKAB7AHX9Svrkyry7D
 6dLp0OICt4Ry04J27nN7mX/B6lHVV76X/lfo2ykhxknHpPyJoxS/66RCf4dFgyyoUUqteMrPoTJ
 2
X-Google-Smtp-Source: AGHT+IFkDbeonZ4CKpSY6Eia8WU2xOGEIwVz205H2pqI9tAI0yG0HNl2lWMky7gJMpcgpehp8iAGCw==
X-Received: by 2002:a05:6a20:d80f:b0:1ad:7e4a:d681 with SMTP id
 iv15-20020a056a20d80f00b001ad7e4ad681mr4715309pzb.25.1714001495117; 
 Wed, 24 Apr 2024 16:31:35 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/33] accel/tcg: Hide in_same_page outside of a
 target-specific context
Date: Wed, 24 Apr 2024 16:31:00 -0700
Message-Id: <20240424233131.988727-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

While there are other methods that could be used to replace
TARGET_PAGE_MASK, the function is not really required outside
the context of target-specific translation.

This makes the header usable by target independent code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51489c181c..c6a9e4b69a 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -232,6 +232,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  */
 void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
+#ifdef NEED_CPU_H
 /*
  * Return whether addr is on the same page as where disassembly started.
  * Translators can use this to enforce the rule that only single-insn
@@ -241,5 +242,6 @@ static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
+#endif
 
 #endif /* EXEC__TRANSLATOR_H */
-- 
2.34.1


