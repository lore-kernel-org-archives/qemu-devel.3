Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D964AC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmd-00058D-OT; Wed, 23 Apr 2025 20:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmb-00057o-TY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmZ-0004I6-Us
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so300626b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455776; x=1746060576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWNW8eV1ZyPSVnus8GAP7nXIvpDAS5XtdbvHuSNPFs4=;
 b=DuywlF9+K67nwe5vufjfOZQbfHJ/5TfffewQfZePOoCVWg7qQl1gYirJYWRJzLRPMR
 EJTQ59Nf6GT8OkCLFey5TS2WLlDNCPToEFDJW5H69JhnlXhDJMCErqdy03fSvWUxgy3C
 BHdLcHQkfqdX7F3A0LfTznIJFme9thgX/maDzETe9Ba+1/YKBsiYVE/ULmEMh32hoPm7
 F6WvN/qeXs6+Yk4aB6uMG0LfMYqFZQHJaqVonRXk2g09uc5wedJB0/E9R5H8fT+oSfMM
 sVtNubjO+bRaSQgozhTW7E0Xlk8PmAbZ7AUD030JnOGkDrIkhALVGWotetL1rXQfj0aL
 4bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455776; x=1746060576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWNW8eV1ZyPSVnus8GAP7nXIvpDAS5XtdbvHuSNPFs4=;
 b=Mmqdlkk1AE37ID4m6MEKb9Kzha9VbGWm6pqQf76kdcP4fXDthFIqhGvHkih1kLmcM0
 RaWFjqb7tWutXzPyE8lg5WLTNpnIG31l0zTx4SnZGmYF1w0DhCs0nHqcwuEhDvbUYb2R
 dnVSj924sNnOuAMT2WCm9jTdcSNra1k1uf3Rj+JXMnNB4fVCA1mws0+Kd+RYni80J1Ys
 qDW9TecAFEWmAdwVK4b9YV7yhSjjgwAoHH7e0i5KHZUyOgmtGvn/H7+kR9iC9HDY9x89
 7Ms/jUNtxAR86r6KyqEJ89mEGGlqz26EShqmwDMq4yZ6LTUUu3R3l048Z+WvUDiK2NCl
 s1uA==
X-Gm-Message-State: AOJu0Yz+k5g1UH55QfuIM3ZLxXjxhh1L0pMWyP8q6Mz04Wn2UmOpzY7g
 ReSSnn3SmpNWuZEaLal46J/2SXd9ENT7oXW6p4Vc3rN2a2bbXtnA6dr7Ggle4XZxaSPpQFckMCC
 Q
X-Gm-Gg: ASbGncvT3iyD8eHBA+37Ez5mDmSHSOzZswWkTxGBI6zPyy6FeVH6I3zHD/xfvRKwn5Y
 Fl/MdwbIGXo5ADmbvNK0oBzu5PqZl2rLt4JN17yy3n0FKXPiwuajSyk4okLqwNoL00BrdOtO6pr
 kuDOZqW32AR4nDvHOoh3VoITJR4fo+Y5U91xgvg2qZg/zlNGLA9xcnc+Lczwg5anUVXKI+MUZdb
 iV966CCR4Hr3bvYheXjPYnwOcKl1Cr7GagmjTz95ruXxOht7+FMd4RMCKQisTa7dgZbdbw1q+CA
 mXAlhJdVDnDt1MNgrNbwPmCxBSHCHTqfqjRXzEOIstDCi41mji3lKh3AkJCDvmEa5E9fYLu2B+W
 ARqrh8bR7BQ==
X-Google-Smtp-Source: AGHT+IGXpXUTFHq7zXiZ/umt1sqTyTgJQPRq6GNie69jRK59AFQofvnC9YlEhhe7848oFQ0SRheoDQ==
X-Received: by 2002:a05:6a00:a8a:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-73e245bb0bamr898131b3a.5.1745455775941; 
 Wed, 23 Apr 2025 17:49:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 001/148] exec/tswap: target code can use TARGET_BIG_ENDIAN
 instead of target_words_bigendian()
Date: Wed, 23 Apr 2025 17:47:06 -0700
Message-ID: <20250424004934.598783-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


