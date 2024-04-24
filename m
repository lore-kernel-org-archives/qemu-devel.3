Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D63C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYP-0005Tf-8q; Wed, 24 Apr 2024 18:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYK-0005Ph-5f
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:24 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYI-0001oq-Pl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:23 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c730f599abso285706b6e.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999441; x=1714604241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bh4lWnPe+YOgpHGdevl5r/TyXWqM+m5cBerY0p6p+5U=;
 b=gHMWaM+qXHvRo+uYZtJMNwdm5fiwh2UowvoULAI+ApwsTRr/J3f0bS1yeFDrzQaEw9
 rGQo4Q1BqDXdCrWupVV6s0IeeiHP5lSSlHyP8S0l16I6cP4FbyFaKv6TPJM5kkKLNdBc
 f6IpUzqXhzBMznDUkU35kqhQuoVrjZpmcUli1cjF+ZSpwnhTGqB/lgpdibFl29/DxVRl
 KmhGoSMtrgN2+BxzdrBASccE55bgsI8UMb2Alu2FOReGDKsh0WIddO2zlTBcYOOdEbNV
 oqwyb9ur/yg6Wy6YknuvY8xkiscveJQ0IIXY5xofZGwrnHokvg7EAY/nat1l5D3IHu+P
 7dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999441; x=1714604241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh4lWnPe+YOgpHGdevl5r/TyXWqM+m5cBerY0p6p+5U=;
 b=vD+EEmp+kw/84gKPZuKVo/m/WZIj6E4xyRn3x59oPwC9fVgf9iM8dzAyZwS3VJOibL
 91PZ7kCRxMOTFdhd11TVBWdQo3KeSZZh8MDcXq4+pNzlMQgUwZoj/wgQ9lEXtI2iMPG7
 SmVYRZDKyIO5MviRk2AFdTEz/R30bSrWb/D+wtRPzVhqEWackuCV7Fbye0AlhT4Q0/eR
 vQZm6FMWwwGGNQIrKOTYXeQgYWlHerBQUftfOOAVwIs1FlELhXUSQtqVQwKSznHZHyLH
 1A+cLWLHCA2cDRxDod1p8wJwtHyiS5xAG5Fa9oTUOlKBn22xsdhBmmGEUjvEfcZi4p1o
 OEuA==
X-Gm-Message-State: AOJu0YxN5sFkMmu9zoRU21DKWtfz4EsE5j4jXKVitj8yR+x7OIAaWrEH
 yNpQiSjbAk71TunovrgLxZHvD/IUJxBIilkXv4/4vxcgTR4AbDgWiA/D0z6ww5S652ruvzoY/9N
 D
X-Google-Smtp-Source: AGHT+IG2EnTmoFLuwoawGqkHHf8ISHnRxeGIHWfBJmvXBM+NWISnSRVjdZnko78KCAv+G8xNwkTu/w==
X-Received: by 2002:a05:6808:b2c:b0:3c6:e81:4272 with SMTP id
 t12-20020a0568080b2c00b003c60e814272mr3851579oij.10.1713999441420; 
 Wed, 24 Apr 2024 15:57:21 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Date: Wed, 24 Apr 2024 15:57:02 -0700
Message-Id: <20240424225705.929812-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index c9a7ded016..eb8030a3f0 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -26,7 +26,8 @@
 #include "qemu/bswap.h"
 #include "host/cpuinfo.h"
 
-static bool (*buffer_is_zero_accel)(const void *, size_t);
+typedef bool (*biz_accel_fn)(const void *, size_t);
+static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -178,13 +179,15 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
+
+
 static unsigned __attribute__((noinline))
 select_accel_cpuinfo(unsigned info)
 {
     /* Array is sorted in order of algorithm preference. */
     static const struct {
         unsigned bit;
-        bool (*fn)(const void *, size_t);
+        biz_accel_fn fn;
     } all[] = {
 #ifdef CONFIG_AVX2_OPT
         { CPUINFO_AVX2,    buffer_zero_avx2 },
@@ -231,7 +234,7 @@ bool test_buffer_is_zero_next_accel(void)
 #define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
-static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
-- 
2.34.1


