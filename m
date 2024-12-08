Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D428E77181
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5R-0007DM-5k; Sun, 08 Dec 2024 17:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5K-0007CX-MA
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:06 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5I-0006Fv-QF
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:06 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71d40003870so1003039a34.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698144; x=1734302944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l91xWhho4J5dS14PUrzWIvB5MRYtKAuibtsdCvv9Iy0=;
 b=ZsXhEviFBXLSqWxruIYSJ5SfPWVzfrpw+4ehagkuGgDTYxgrXzNDmveimRfu5Vx62l
 HpdoqbKF5+PFsXix4r1Xc5QHHL7PdEMvv3GIGatsvdKpTQGQx3XKjZUHQe84hN8sg9iv
 uHUUN7KQsARkl+vKYAEUMcW6N2GhT8oEDMS6cEMec+5l/wdlVYQkelSF7mrm5dTu81lu
 vII+z7uESLjtm0dynWV8ZdGG86EpN2LCNJBGCHud9OR8sGeLu939Q6SCSQjv50e0XY/q
 TYnSo83WnSpb0l3LmMZDW7uojlcyHZpblGNAdAPbxeTVX1MsHr5e7yvRDwmqPCFGz6Yo
 gajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698144; x=1734302944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l91xWhho4J5dS14PUrzWIvB5MRYtKAuibtsdCvv9Iy0=;
 b=dsvXrlfsMeYfCXi7ahel59eb3UiVfnh68fv3uUaTr06zWvWE6hbkcV8WTlIO9o7gJ7
 eNS1hfXVdsXWgaZ50zZXN+q6noqMho8G7J7Hlbpb9KCL96jB4b/o+YzyuSmnzYBQdnF4
 cDSl0yvp1ZwbbcILpqdw0x19fYsR4w7iAwP4qhMRa7wuZtHfduNE8xVbfjS9/YKdUbGS
 Jmg97s4Vfdk9YBSBt9fxDycLJEoXbgbVizXJ0CxAjF4iTUKrKJhE8yZ/NF872eLr0sdU
 ZnReff8Pw4PwP1av2EMy3pS54rXSZd+Mq/4CKdPh7OD8E+w5K5JhQzF/Seglbi45hdwk
 4vPA==
X-Gm-Message-State: AOJu0YyFTuJRnoX2wx/xdAAoZS1Ohuthnq9DUOj9HNnWbGrvUyQ15pKt
 A2YFptUguc+W/+xpsrzhenweIg8Wo1gKPQosvnWXbgWO6inmIa7fq2NfKU6j8E5HWkKA1zKZrF9
 fkAl2NQ==
X-Gm-Gg: ASbGnctr8M+DG6eKecUM/3HQNKfW1sxwODVTW50Ak6yBRij98Db8EhPkughPpLTqZa4
 oCeNOuCNA4DS6JPlPjPe7kIG/52hxOhupPcCGxhKmedSP5r2CHT8armU/T9wMkd7/BDm+0K1FiA
 UYKhnk7UyL/wyAgZjyNc22YwLppbAQFQYwJhhvSTjhzYaz9Tbcn5/gXPLR4Dtjb6OyqlpjDkTnm
 9t/wq4Ufm3yhCSgSJ6Zq/oEzWqCDDK051+EPRH0T0yPEOs6YLlHCu6IKa2pW7AG2CxlgwVI/b6q
 xT3D16ahWgTlKyUqDp+TIEIQIKchejsUMEbx
X-Google-Smtp-Source: AGHT+IGume6tr7LhVC7h/llzYttciQhohmXOeRIevghu4dxhHK7sv1EcumgOslgwj3SJV9j7YbhOFA==
X-Received: by 2002:a05:6830:1504:b0:71d:eee3:fd24 with SMTP id
 46e09a7af769-71deee3fe4dmr1530980a34.0.1733698143780; 
 Sun, 08 Dec 2024 14:49:03 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 14/17] target/hexagon: Remove Float
Date: Sun,  8 Dec 2024 16:48:41 -0600
Message-ID: <20241208224844.570491-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

This structure, with bitfields, is incorrect for big-endian.
Use the existing float32_getexp_raw which uses extract32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index bce3bd4dfb..c359eecffd 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -53,16 +53,6 @@ typedef union {
     };
 } Double;
 
-typedef union {
-    float f;
-    uint32_t i;
-    struct {
-        uint32_t mant:23;
-        uint32_t exp:8;
-        uint32_t sign:1;
-    };
-} Float;
-
 static uint64_t float64_getmant(float64 f64)
 {
     Double a = { .i = f64 };
@@ -92,12 +82,12 @@ int32_t float64_getexp(float64 f64)
 
 int32_t float32_getexp(float32 f32)
 {
-    Float a = { .i = f32 };
+    int exp = float32_getexp_raw(f32);
     if (float32_is_normal(f32)) {
-        return a.exp;
+        return exp;
     }
     if (float32_is_denormal(f32)) {
-        return a.exp + 1;
+        return exp + 1;
     }
     return -1;
 }
-- 
2.43.0


