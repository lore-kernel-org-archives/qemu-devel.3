Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD0C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJBK-0003gO-F0; Sun, 11 Aug 2024 20:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBI-0003a4-QA
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:04 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBH-0001ev-5O
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-710bdddb95cso2127070b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 17:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723423502; x=1724028302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG6Wn5JGKqOVYo7oiDwgDKG/Csj9cM6r0yseNWt8qsc=;
 b=Il7YuguIHrWFNDEpQjhmPZVqKbKblsY5aE47NOGJjkgSSzYsxPX34nuKQbdTQcQkH/
 WRsY6Fj1qqUWjNOEN/5R/HpKcU8VRV92Tv4IRhMNfePo5ESvbacb0sbXYGNUl76S0ksf
 WKTUo5C3f8KlmcbniIL/QCgKMx3HhvtpBB+4Pq7A5gk3or0I0egZl3Q826ykMslukpuK
 C10XyVwrsVNjcxqg2LllM0vqEZAZhYaQo8ZQPBwRT7Rj4Bwrhj4xcGQhnFmR5YODjieT
 QPhkknI3jaTT1VYCGVuQ5fBrikb6+B5FkHvs9WIqD/CSEfJqP4JmHYKWqYNNsps6F1uH
 GQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423502; x=1724028302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG6Wn5JGKqOVYo7oiDwgDKG/Csj9cM6r0yseNWt8qsc=;
 b=LpysB25hxep4+6ObhTa3ZysgZrPo6UUvYBqk3ArFIVCUISB/SRcPbSkT9woZcj2DNb
 Xd6lMqkDBV31ETLQJAhbPZxRMlXE/T+V8QzrkBSSP3PXLIknD7e0f9E4EXaKLsqW0BD7
 jjAZPVEg/mM3x/0EszYj0Anc9mV3U78IOg9q8fJNuuaZJdfm0aqh3qkCX70uRb2PcHFW
 hc3BWuzMxOMr7SShhH73+jF86/QF3ZryVMT73SIFYkU37BGismgfGI42TxDAOrchPhF5
 5eoFapBK4ZfFttDNlC5ZaIolm4JqyFB4pPzaRrARjfqGKsdH/GuNoBjR7m5vDbuGtksG
 3m5g==
X-Gm-Message-State: AOJu0YyiLmNdecLKRWE3l3gQBK6BFKd8ljdg8muFLiLSHBpK+WTQsPI4
 CsItpWTWAzFzx8rSWaPjpaLjmejkDFvP7TvwDmQAiSCDgBQNMAKzsNbnRL5Ycqqph8EJmdFybZd
 H4xQ=
X-Google-Smtp-Source: AGHT+IHeow8Yi+zSQV4Vu8N5MmUbeeT/MdKcq8/nw7auLPn8Q26aylgotDXYvb0Kmoo25Z/zj7z4zA==
X-Received: by 2002:a05:6a20:438c:b0:1c0:eba5:e192 with SMTP id
 adf61e73a8af0-1c89fd220damr6173779637.27.1723423501556; 
 Sun, 11 Aug 2024 17:45:01 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bbb3b758sm27089435ad.257.2024.08.11.17.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 17:45:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v2 1/4] target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Mon, 12 Aug 2024 10:44:48 +1000
Message-ID: <20240812004451.13711-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812004451.13711-1-richard.henderson@linaro.org>
References: <20240812004451.13711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Set for 68020 and 68030, but does nothing so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h | 2 ++
 target/m68k/cpu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..7114324e4d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -553,6 +553,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* FPU supports packed decimal real format */
+    M68K_FEATURE_FPU_PACKED_DECIMAL,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb23..65058dd052 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -182,6 +182,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
 }
 
 /*
@@ -224,6 +225,7 @@ static void m68040_cpu_initfn(Object *obj)
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
+    m68k_unset_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
-- 
2.43.0


