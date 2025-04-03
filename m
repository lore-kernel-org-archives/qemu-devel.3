Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE32C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKs-0002LY-Ch; Thu, 03 Apr 2025 19:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKZ-0001ti-JY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKY-0000lC-30
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1244140f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724239; x=1744329039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7HWbrR6pSrG3MMm4hLTyMzjRQ5jngvWPZkeMnLWwj4=;
 b=aPxd1UBs26e5nbNnm70Ky2ASu7Gfth5bn2pnwSAM0nhOngQ8zp8xmmygWDyOl3nFjF
 qEmFdLFV00JKF8Q7NHlVJ/8ld1fXyX3PaM4rz1d9JTvIJMjEE6W+SlJU9o5xDVfVjzCo
 Mnh//qX6ucdhGKsXq/dsyd/kz1QdTE+I+yCy7P4jZyRj7ssOzIgcZ6Wd8UrwoTH1mS59
 NZ9kbZAyzJpR9/WoGLLnPjGaGzOsgu76K2x++YuyD4PfkuNN4iH3qWjSOfIwPiLM/YNo
 nLnMVn6UUKwk2leJJo81SBk05aKgnoWEVBUf2xzV5rzEifcRcfFMapnYBnqBk3CRH5gj
 1hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724239; x=1744329039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7HWbrR6pSrG3MMm4hLTyMzjRQ5jngvWPZkeMnLWwj4=;
 b=jG/5dHJC9dA7lUBm/imqaR1dywM2J3MJDaezRs8JJHEutOMpipRo5HM/ThqsCknLa/
 ATZR+eMvz3jUzR5xBWFdrboN3ZI1N4afrb2JzRy3pX1Lnz/8a+VWTrAvpykHXj2Zz91b
 9/s3r1Z4dEQTsOHsvA7XrbmRxHC93Wrfvv57/jFsICp3kyLrk0hk35dK9O9MRwsTbyVg
 jKbriSVrKeJyftXgV4daqifnWAUji5Zcm4axoWTWu0LpYORzkqR+WE89XgrSRxonTjMw
 xMVtUTYYvMHyvz1cEmgqSY+leEWNWA+kf2ZKDIMh+oaERsrEh+Q3Ki5KXaGGTEpVUY8i
 0vKg==
X-Gm-Message-State: AOJu0Ywn1neXvHG5OUQD7n/0IE6tNOqzbDQe4eZ4uamPtlz43ENwbrHp
 f0SzHRjOzjzLPyXss28gzTr+9Qn6a6goeplyCzXaFTNjoRSncr7zhTTiq377+5SlBw+kMMWV2FB
 8
X-Gm-Gg: ASbGncs8N+pe3/lzDEsXK7F/6FRqc22kudZN6a757erR3GuRWqQzHCEKSYMK3i1AiQS
 rsJhKCeBJeRc35fgF1GGeLC7/2fEZ8TMmzIel6qjV0BSB0AS+YajMxNoXFQfMoCvyWqb+Jjo1Yf
 G/VQIEaoj/bxd7tVlXbhPWY/Q3bZUn730vYZmo/NPdbQTbmuQTWVLbzqbYWI8M2PaKATuMEYS6f
 x2IIYOyHGKsTAqL3C0yh0OJWhdR3SsfAYgXRPr4kojLKC/sSGqFpmKeAX51xg5dPwCqUEXyZeFI
 EMD6yK6hK/S4m+IUdo0FUsLPro8pZeX+uoQykYlHPKnMCJvdQx85iwwC+tTwh4/QzeldCVAIcwj
 4PO0bx2LiCbBJ1+Voqu8=
X-Google-Smtp-Source: AGHT+IHPurURK90gNwzkCULqNdfv7zWleFIwaCrH4RDDVFIXOeQLpuoL1xkRenVm6eqCGBu1CBqm7g==
X-Received: by 2002:a05:6000:381:b0:39c:1257:cc27 with SMTP id
 ffacd0b85a97d-39cbbcb3b96mr712222f8f.58.1743724239372; 
 Thu, 03 Apr 2025 16:50:39 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968cfsm3012407f8f.16.2025.04.03.16.50.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 13/19] accel: Replace CPU_RESOLVING_TYPE ->
 target_cpu_type()
Date: Fri,  4 Apr 2025 01:49:08 +0200
Message-ID: <20250403234914.9154-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 33a539b4cbb..9e9e70be876 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/target_info.h"
 
 #include "cpu.h"
 #include "accel/accel-cpu-target.h"
@@ -88,17 +89,18 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
     const char *ac_name; /* AccelClass name */
     char *acc_name;      /* AccelCPUClass name */
     ObjectClass *acc;    /* AccelCPUClass */
+    const char *cpu_resolving_type = target_cpu_type();
 
     ac_name = object_class_get_name(OBJECT_CLASS(ac));
     g_assert(ac_name != NULL);
 
-    acc_name = g_strdup_printf("%s-%s", ac_name, CPU_RESOLVING_TYPE);
+    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
     acc = object_class_by_name(acc_name);
     g_free(acc_name);
 
     if (acc) {
         object_class_foreach(accel_init_cpu_int_aux,
-                             CPU_RESOLVING_TYPE, false, acc);
+                             cpu_resolving_type, false, acc);
     }
 }
 
-- 
2.47.1


