Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D28C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJTr-0004BV-J1; Wed, 12 Mar 2025 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJTn-0004B2-Cp
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:38:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJTl-0002e5-L1
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:38:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a823036so55737005e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741775902; x=1742380702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mTVwHnDcjEge4BlyahuAnj0E3stfkonQeNnK0yWfebw=;
 b=BO/Cn1olTXEf5TetPKGzTKSo+EDerl/+2As9xC02p6eyD0kjqAvShuk2NBQA/z6Nvb
 a6AO8c4hmID/JSVigxBs3PQLKM3Tox6RMXquLM3Mle14d7fsHXVQ3MHiSdPEM9qrF631
 QqmZaEkMkZS3Bcm/337dkykLmwADnaii1UOl2Hpj0e20o2MsPPufNPWxstv1HfAWuzBG
 Xs1kVVQFVDwV1wQJ73i0AGPoaNrj18Cjw6aV9SqPrXHKtbX3b0IitkJzujFTHMLTnDz8
 3xVSWRi4B5isRVMkrKB5I0wuxfcRFV+ZGTRV7ATO7PoQ8kG6j/H7/wquXIxqu927++0K
 7tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775902; x=1742380702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTVwHnDcjEge4BlyahuAnj0E3stfkonQeNnK0yWfebw=;
 b=obM9pMOFc7/Xvt9F9J3O9r0NmGz3jmbZmvbqaa/qoFB4YmxzP4rwV7uRsnSaqce7mw
 zqQuXcAip8uvBg385T3zCZ6mtXvVRb2jzwvpUyqA1Crl9b1zg7kBTb/GvcUXB/hThYFg
 wMGP5PHM0ZHSSDBKJi1wO9SCPb2tVOpQdE5TrgR/9NGdEoobnkqJueitQJ1EVzj0U6tP
 LjatiWHimsfmKgqfEq85HDeDiN6u66SJ4cvlph1C5YXCiS392exzudUf5Tgf3y3HJX/s
 PfRubc4N+9lSoEomvJFUjFQaJxz7DFsn1HVY0TCxsGu9ZkzX5i5D9JXQpQy4UeCikQl4
 yxTw==
X-Gm-Message-State: AOJu0YysnbggXkFWCnSiVoMxnMkDkf6UOGOa0m/SwQjvORWEGSIF6tC6
 FUKRlafD99kU/X5DvfwfV2RJqdv5jQ4aWD8nAkEUiZJ6rkvHn6LpeXli9WxordPEiY8upwpkScb
 F
X-Gm-Gg: ASbGncspm51vh1K+xCoi9930myaVvd+KUCTGhAZtBLAYNynPZ6aQlzGwl/lb3/uuFF3
 p7UtSMRnmPOxyndtCnZKYI6idmpZlOqTq+7a8wHNM/D8fxOX8ZxTIWEzptB3tIAXwXAFZoX6vNJ
 lvnV2MvCWjjZQ9l+OsYJctR5PRwakjRw4QPn9grnji5Obd6wWeaaVpnlAY0WbLMfPTMoMMPfe2L
 RTcjybWzQKvTK+KiX+88BzVWKL+gn8/aQuorWikCIcOr7cfoivmcxeq1pL49Lc/wH9ocfSCy97/
 7rrnYsoMc/rI6kwEpIQ03S2uefeHFylYTW1pewm2btjrQaVvpgLmX0r97YbLjsWQzV441LtrR/f
 OgkNGzUhTmdHlNg==
X-Google-Smtp-Source: AGHT+IHiFb+R0Dmz3H7QwOm1OWZLEUsabEXGxlch6pU/SGOHSMA99Zbq+sOnnrSdbSu4fHJCp8S4Vw==
X-Received: by 2002:a05:600c:1c9a:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43d01c11ee4mr62852585e9.24.1741775902540; 
 Wed, 12 Mar 2025 03:38:22 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a7582absm16857445e9.17.2025.03.12.03.38.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:38:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1] target/i386: Replace MO_TE -> MO_LE
Date: Wed, 12 Mar 2025 11:38:18 +0100
Message-ID: <20250312103818.370-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The x86 architecture is only implemented as little-endian.
The MO_TE definition always expands to MO_LE.

Replace:
 - MO_TEUQ -> MO_LE | MO_UQ
 - MO_TE   -> MO_LE

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/emit.c.inc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24f..c7a40a2f9e4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1796,7 +1796,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef TARGET_X86_64
-    MemOp mop = MO_TE | MO_128 | MO_ALIGN;
+    MemOp mop = MO_LE | MO_128 | MO_ALIGN;
     TCGv_i64 t0, t1;
     TCGv_i128 cmp, val;
 
@@ -1853,10 +1853,11 @@ static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
 
     /* Only require atomic with LOCK; non-parallel handled in generator. */
     if (s->prefix & PREFIX_LOCK) {
-        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
+        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val,
+                                   s->mem_index, MO_LE | MO_UQ);
     } else {
         tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
-                                      s->mem_index, MO_TEUQ);
+                                      s->mem_index, MO_LE | MO_UQ);
     }
 
     /* Set tmp0 to match the required value of Z. */
-- 
2.47.1


