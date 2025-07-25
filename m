Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5EC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGod-0007kE-3S; Fri, 25 Jul 2025 07:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoX-0005px-VW
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoT-0000N5-Fm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d54214adso13750545e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443727; x=1754048527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZEFIdbzTt66Z0GDvBuvIvGOawOMu7/fBFc8ZGYNejWk=;
 b=DkbmE6Jjq4l3IANnOUPp8o+7hGIaQv7Q7/utVY84qmz+Un0rv6M0V5dejIzZmgUJM8
 Q9uPVn53cz7P7JPwtuHaSffj+tMAaEjj4hE0Gfbx72gn+TJ6r8pL+XyTZfXll6uAv6A1
 /4MyGoZw5aMqrCxz0ea0oxghwbFLxznIzFlHQXnE5+ovlzBIeANFIs2gJBxGQscn0YF0
 VD5Z996TIglDZioXbn3he/o12CcGb1pyipCD3Dp1eWSaJThf36wMm8IScEcsGc732rnf
 256X1CoiIP99r1ojwKyKO3B3tx4Mdx2Lbx36ThCuv8fgX95vmcMFw+7fXDNaMS6scWoL
 XOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443727; x=1754048527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEFIdbzTt66Z0GDvBuvIvGOawOMu7/fBFc8ZGYNejWk=;
 b=ZMfXaztNlOGzRjlBXWPoc3BBDi7RawKmKLHZlAPAbf+ywSi+B9sEFvZUMNTqf0THkp
 /QZHOTHaNeijP9zz97ZneA77emRWY3T3KGdAjXv4BqYI/DGIzqynh6CZJpZ3Csfcybdo
 nTYVM7zztWM7DgnDjthlrI/aReeoj2TvTg9mzJwWEtEEgTateZuJGdG0UsxvaH8krFzy
 bfs18Bq36DTfgGzM71xvHujPeYNSuPWWGOQJEa2shMBLXMWWp6EE1FVadV0hq6TU8ueQ
 FqZGQmUhrsuW5zDhJ5xolQzEC+M7C7WuD93wMNTYDHcO4V2NMLBtCpeoG05n6daorGr/
 JlGQ==
X-Gm-Message-State: AOJu0YwuXmH7Xpk9apVfm6wVMWbdwA/RN6abdwnDzFfxhsK43BH4EnpQ
 Z6x5ESjAqOj+hCIYHt2fi98t+pCAXAZck+qq49OcgHvZ9gx8Cr1LhZ6tk5zmdY1j46ysPY7Beiy
 QGHC8
X-Gm-Gg: ASbGncv2Ej6IBTL08XFS71O2D/cSm9IylQKP7H9WKdPUHp5Nz4ZWYdwDWPVq3pdUAas
 jcRhnRJg2n4ZRD6YWf57eMTjiMRefmGfaoJc/85Oy5DH+UFHXwoIETwj9B3at1rp5KqcRnTbst4
 m9SV4VPL+djqgBljxbQ/yIYLbYPsJRlYGwsIb3fUjkxgREeRCnf+sJMnsQvMXgcNzcyJPxd+h/Y
 TcEoJSWUFyXkGxz+abNglg/WPv6dzf8YF3x0sut7L/P1rUZl1XcnscUW9WEYh9Uvwb2ZxTOsW4n
 wgHQTF8Wru2STDKldNWBbOzT3Hb1Aema+C57+FRavq0YUF+fHxZMh7uNb4B3z8rV54MIxzppdWq
 IOAFolKbhVQBSh+T+OOKzL0HGweey
X-Google-Smtp-Source: AGHT+IG1xNCy5Q6Svpxj/yN5yK26sWDZBUmKeXD/XtexJJL1J0dVl/9jZYbLLzCeuKWshSBf//y1Ow==
X-Received: by 2002:a05:600c:4f51:b0:456:2020:166a with SMTP id
 5b1f17b1804b1-4587911e6bbmr2627525e9.20.1753443726927; 
 Fri, 25 Jul 2025 04:42:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] target/arm: Pass correct esize to sve_st1_z() for LD1Q,
 ST1Q
Date: Fri, 25 Jul 2025 12:41:55 +0100
Message-ID: <20250725114158.3703254-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Our implementation of the helper functions for the LD1Q and ST1Q
insns reused the existing DO_LD1_ZPZ_D and DO_ST1_ZPZ_D macros.  This
passes the wrong esize (8, not 16) to sve_ldl_z().

Create new macros DO_LD1_ZPZ_Q and DO_ST1_ZPZ_Q which pass the
correct esize, and use them for the LD1Q and ST1Q helpers.

Fixes: d2aa9a804ee ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250723165458.3509150-6-peter.maydell@linaro.org
---
 target/arm/tcg/sve_helper.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d0fb4138d21..c4aaf0cc45f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7219,6 +7219,20 @@ void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
                   off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
 }
 
+#define DO_LD1_ZPZ_Q(MEM, OFS, MSZ)                                          \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint64_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 16, 1 << MSZ,         \
+              off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+}                                                                            \
+void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint64_t desc)                              \
+{                                                                            \
+    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 16, 1 << MSZ,        \
+                  off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
+}
+
 DO_LD1_ZPZ_S(bsu, zsu, MO_8)
 DO_LD1_ZPZ_S(bsu, zss, MO_8)
 DO_LD1_ZPZ_D(bdu, zsu, MO_8)
@@ -7283,8 +7297,8 @@ DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
 DO_LD1_ZPZ_D(dd_be, zss, MO_64)
 DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
-DO_LD1_ZPZ_D(qq_le, zd, MO_128)
-DO_LD1_ZPZ_D(qq_be, zd, MO_128)
+DO_LD1_ZPZ_Q(qq_le, zd, MO_128)
+DO_LD1_ZPZ_Q(qq_be, zd, MO_128)
 
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
@@ -7632,6 +7646,20 @@ void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
                   off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
 }
 
+#define DO_ST1_ZPZ_Q(MEM, OFS, MSZ)                                     \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
+                                 void *vm, target_ulong base, uint64_t desc) \
+{                                                                       \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 16, 1 << MSZ,    \
+              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
+}                                                                       \
+void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint64_t desc)                         \
+{                                                                       \
+    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 16, 1 << MSZ,   \
+                  off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
+}
+
 DO_ST1_ZPZ_S(bs, zsu, MO_8)
 DO_ST1_ZPZ_S(hs_le, zsu, MO_16)
 DO_ST1_ZPZ_S(hs_be, zsu, MO_16)
@@ -7668,8 +7696,8 @@ DO_ST1_ZPZ_D(sd_be, zd, MO_32)
 DO_ST1_ZPZ_D(dd_le, zd, MO_64)
 DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
-DO_ST1_ZPZ_D(qq_le, zd, MO_128)
-DO_ST1_ZPZ_D(qq_be, zd, MO_128)
+DO_ST1_ZPZ_Q(qq_le, zd, MO_128)
+DO_ST1_ZPZ_Q(qq_be, zd, MO_128)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
-- 
2.43.0


