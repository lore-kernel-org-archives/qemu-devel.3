Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9BC52D7B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 06:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd1fw-0001p8-9I; Sun, 11 Aug 2024 02:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1fv-0001oC-35
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:31 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1ft-0003Js-Hr
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:30 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3db1657c0fdso2382545b6e.1
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 23:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723356208; x=1723961008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG6Wn5JGKqOVYo7oiDwgDKG/Csj9cM6r0yseNWt8qsc=;
 b=QLd88T+zwnKINYetrJd1utXJT1JhDHbL+cASaooMERPTE6Kd1cB9+KrsC8cnac4rkj
 gySqF6xNIgYx0nllP6yr4qUL/hqm/rG3cimTMJsdtKoVJJsuUkbwMF9hFXhSKwrd871D
 HIkKb5VQ1Z8t442SnX9bsb2BjvKWxQW8tQG5gl7qx8pCrzluR5UNTUIZDUpGqKVIU9qF
 pRDgrHC2ST6gngdjVK+tDLUC1z+Q8j+WbVg6dUVqCf9+YHU+PnI31Iq6sev9EgK1gxMi
 r2mihPR3XW+1y8a6be4OHLlrifbSsUVVcZFjcXuXml061e/4VSnDEIC034tZQ4EL8tYI
 I6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723356208; x=1723961008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG6Wn5JGKqOVYo7oiDwgDKG/Csj9cM6r0yseNWt8qsc=;
 b=R+SbP7dryCRxzP7/uMHHWwjn1SKnNL4HqLIqb4n9zbCPd5UVR27rFZaGMEQFSd8I+d
 9K8oFFRgRwoSZ+pTkfSlKKt2BO/nZ8ecPkQI1dsKjRI9im2h3LUFstEq533pIroxDJGd
 ksXMlMVcMX9NJqvMX9AgQ33TmK++2ibbXCNWJXblYnen8Nv8jN05ykjqG+vWw4bZbkJG
 4JiVz+FSK0D3xOiq3OyEdIn4ZluFj0zOtr/WVnhW2EiGdxd5zwLp1MyrEXyZo2KGE2XS
 zZgRW33mPznX15roh7sFIR6wWtbsXk+rP5G6KR9YWyVmuegzOh/9flsqJnyiyek0K46O
 PsjQ==
X-Gm-Message-State: AOJu0Yy/6ha6G032GM33VkCBSwWicolCH8SFeuRTG3bI8v86BjxYbLcr
 OLeEtLREgNLpVJlkcl7qEwNPgS21+HPAm3dTaYTeQEotKrlSlTkPljyYFOvfa4Xh/pctKaiBhqb
 5dKFxEQ==
X-Google-Smtp-Source: AGHT+IGf64F9ZThs7xHxoG80IvGuO2h4TLyt+as2TJuI5DMdwP6xdg3sBjOOtPFdQEDn5lOP6c1PyQ==
X-Received: by 2002:a05:6808:1993:b0:3da:b341:bbbb with SMTP id
 5614622812f47-3dc41691784mr7637931b6e.26.1723356207651; 
 Sat, 10 Aug 2024 23:03:27 -0700 (PDT)
Received: from stoup.. ([172.58.106.160]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060b5388sm835591b6e.43.2024.08.10.23.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 23:03:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 1/4] target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Sun, 11 Aug 2024 16:03:10 +1000
Message-ID: <20240811060313.730410-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240811060313.730410-1-richard.henderson@linaro.org>
References: <20240811060313.730410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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


