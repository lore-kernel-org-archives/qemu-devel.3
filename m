Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E79C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIB-0002MP-2i; Tue, 22 Apr 2025 15:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI8-0002M6-LY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI6-00068w-J2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so5230141b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350101; x=1745954901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOXb/HC4BV8O7xeI6J7gLNVlc4Uon6AIhH5cPrLF7Cw=;
 b=MrZQUbE9Hy8vGPPpwsQ65SKZ6qPNgijIZnXow720adB+/weHMEHEBV3cSHCpWkmgxi
 DoQ1MaC//9j61ts8Nyw+Zt4ODwlK7PAQUug5tCk70v7a8bmx82ga2fHcNHH+CMFjckDt
 80+nMUkUpL65P4+/lSC5hV4hOY8HF/6UKWcNRIF7x91xXwjv3Y48n4uawbmtI0/RWT67
 fvQNp9WSxV4Z1WsSt6oWivdmjB6N+bVhpX/WqkThR//JUWrDP1+N8kVjfK+mRybnO1Rx
 A9kmm5zD1K4VM+jolDx+JmmE3M7ChNmmuIwETQcXqROjhcJDc0QcbAOoOPyuP9shdjpO
 GCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350101; x=1745954901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOXb/HC4BV8O7xeI6J7gLNVlc4Uon6AIhH5cPrLF7Cw=;
 b=S2p8o9FpvF8eEQTIITuyqEdkSxCIjlcIQbsSlJn3P0qKoWoNPs7H/04ZKv4R5QF6z5
 qk/EQsRfffeUMrI+EYZzc81hVtIbGKsChYnYyfbYbrqdX8aIpK4GqdxNEC3jGsATYQmm
 Sr60aX/1KEFFAubvIsEeA0HoYbVqlA+aBtsBydUyKGHsGE2TNvFh5f259+uVW13g1UKO
 foGqdAMRL1OfjG740LhbS1LY+tTMb4EhHSuRnSffuiVffn+26AAeYz975EyrRuko2uO6
 5MXN7JBDaBYe+X1MSZ4lSj0oYmyAEBnEcw1JZGhVGOqqWN7bOGF8jpnAuuQqsBLPUG8D
 gW0A==
X-Gm-Message-State: AOJu0Yw98DBNLrdr4wBDKW+wtMhipP4jJzVw9z9l2ap5uQWKwNR0SoTV
 IRPFGzUA8PRpPG5G9BhhQUtSDtH2zKa+e+ERcgfvuhHDKP8+oD5HgpTkP9BbtcdAhimE+XDReqN
 h
X-Gm-Gg: ASbGnctDDQelXxZMo1CComBiTQehP8GU5fd9xrNHI0yf0fIv99OWEPICgJpIJFvWaL/
 B1tivphQXmrDY8ITXhDPpsxdKj6mxurTyt2Rub0evu+ktU5gTaIdix12lW3sR2VX49gTOkEiQgP
 DsrLzDmrIU7qe61/K4eWRvXTkUeFhvxQ6U6OXPkgJ+oX2YGrMUPezkW6SyLDsS42I6etJXwOk8q
 ltlP4mBosXfZ69UHdB7YCiVMXRqhtgl6nGg1mtlg+5vy1XzmGlyCmF3DrrzcYIbIhZ1o+y81gNO
 tF1RFE7HRKaJ2WZCfPr2hAGMV6uCAqj/NlSoOtEh5aq2xNvNkrUigPKZC6xwFUUy/q+pBopc0xs
 =
X-Google-Smtp-Source: AGHT+IG+JqAivi5FuRZlxNM8RB0hycSEQHQMnDsgUXG9HEUEXLSERihRdceNl0ZUZVen3UTrUI6kcw==
X-Received: by 2002:a17:90b:5646:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3087bcc8a9dmr27042451a91.33.1745350101084; 
 Tue, 22 Apr 2025 12:28:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 001/147] exec/tswap: target code can use TARGET_BIG_ENDIAN
 instead of target_words_bigendian()
Date: Tue, 22 Apr 2025 12:25:50 -0700
Message-ID: <20250422192819.302784-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-2-pierrick.bouvier@linaro.org>
---
 include/exec/tswap.h | 11 ++++++-----
 cpu-target.c         |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index ecd4faef01..2683da0adb 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -13,13 +13,14 @@
 /**
  * target_words_bigendian:
  * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
+ * false otherwise. Common code should normally never need to know about the
+ * endianness of the target, so please do *not* use this function unless you
+ * know very well what you are doing!
  */
 bool target_words_bigendian(void);
+#ifdef COMPILING_PER_TARGET
+#define target_words_bigendian()  TARGET_BIG_ENDIAN
+#endif
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
diff --git a/cpu-target.c b/cpu-target.c
index cae77374b3..519b0f8900 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -155,6 +155,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
+#undef target_words_bigendian
 bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
-- 
2.43.0


