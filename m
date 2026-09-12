Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E2C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1p-0005LB-3s; Sat, 12 Sep 2026 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1B-0004ln-Im
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:34 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L19-0007EF-UD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:33 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469e25187so515352b3a.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209090; x=1789813890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BFdwlpBUb/ld5iaXCqigYzlB5i82jNLi2haiV8Iolgw=;
 b=cCczvxebV30Idhc0yB1SWYTDdACWIY7R31lchxfSV5cxsjpZGAWzQlsjyQ06Cap2g/
 kgKM4gHHNS6ADQu4SGSupS/W5Oc43+1ne76hGeyVLNgZ/GnQJwy4X8/unoX0+q8BfDV8
 2rbo+2374d3Gk598R48QWB2qennI8UgCLPHIOZ3PqXaaBvbARfGPVsgQ4dqgyMlrhC1d
 FQmh6nEP6pMNW/KppdgLoG2pxNXksgbADDHPpwrQLHe48rGN8WduqB3aAgdVXY4syUNn
 JlN1nPsIxz0x4VxCE5lxr15hjNvfpfg7POkWHyDCPqejIST5iVtU7cwZz51Fx8HPWAvr
 IOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209090; x=1789813890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BFdwlpBUb/ld5iaXCqigYzlB5i82jNLi2haiV8Iolgw=;
 b=EP0PyCBVwLsBL7c5rEoXs5xPy3EB6KVRAsYwgVv8bax6NA/h+TysLENYas/2tctp/p
 689hgVKLAOyPW9xa8yJrnevVt4s9pegBSkz3CBCG81sj6ZYBBv8BrS8dyvgR0RKmObml
 KU7qFjXdz3c38KOsJco7W0zh9KT6qnmRV8zEkjraDkZoPU9mHpniArwRQCttuw3rw8fj
 5sRHltkefLpHeWc3twUKafow+EJpaZb9FPYsZBrQETCLHgGpoA+aapBbUUNlZ/Hia2kA
 uNoC85G/+mzC8O7Y32RsGE3ZQ6w23FdX5uQ5t9WiNPmO9uVCu7UsU7706ySBVzd51sZL
 5gVA==
X-Gm-Message-State: AFuF++m8KXObwG6Khzk9sSuaORsF2kc/SZ70xQwLooYRDKoT5Z0yFaWd
 C0MODysVqTTpx+nssKjRssdYH4Z21748BKw989pTNTYkAcYM1AO4JnASiSsFu0Ty6zSIG2lZKVh
 kdHLNsDo=
X-Gm-Gg: AYBFou0llXjjuNADNYYaezBSAuXtMZp8Wcn3xJ67R5M7LuNWPZG4ms+mABffeVX4zvO
 MZmSg2r9XU3b+vvGBrOWKukYM1yOBHAZ9aXDDtmUO1J+HeBQ1Bm3GpGU4a94hwXqkBYb7hrh4tH
 gcRf7KBdBf2PM0hfgpfr9xHD0EFozdlxDcbSTHDgufy2LIuId6zZ8TdTs7WEnFwSH8J0qbX7yW5
 RGRrJFz8cvOGH/aCez7oZXufsPE03W0rBFd/Cd1tn3oEtYOF+MKY3qRfO8H/2d0nBB5dED5kvAt
 JiLxupHNwGcqlynwkYgzAhUToZZ/y9n9ef0rv8/hmXpR3/sIREbUVFt0SLO81FA7WvuXKjiQpYU
 smk2zHCXiixLFKxcGBwua3CmvdC3cQMMgnqcOA0p6RhEF8vr3XQ3WPzxNY51NrMGinQX/9Nx1v8
 2ZTzpVyBzm7MS+V5Tk6vWc6ZdONzh+KPtGwB1BuFVT3tcDraUWOeepbEHn36X0rxfMTyVnepeR0
 ik0qNo=
X-Received: by 2002:a05:6a20:be8f:b0:3d3:adbf:7782 with SMTP id
 adf61e73a8af0-3daed4a71damr18993990637.23.1789209090114; 
 Sat, 12 Sep 2026 03:31:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/82] include/qemu: Define QEMU_ALIAS
Date: Sat, 12 Sep 2026 00:30:05 -1000
Message-ID: <20260912103126.598030-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/qemu/compiler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb07..614a0bfd295 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -222,6 +222,13 @@
 # define QEMU_UNINITIALIZED
 #endif
 
+/*
+ * Alias the current function definition to another.
+ */
+
+#define QEMU_ALIAS(N) \
+    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.53.0


