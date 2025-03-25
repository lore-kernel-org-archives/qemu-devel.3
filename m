Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA11C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQ4-00068L-0L; Tue, 25 Mar 2025 01:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO7-00040W-Nb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:44 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO6-0005wu-1b
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:43 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso11093313a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878781; x=1743483581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6JY17RXIOhpi9WGu5PHvZc/K1MBVjPo3G9pvjwYgCU=;
 b=SFXsDNbQ1/hrAX7kOMgj1dJTDJLDbAu09wphXxbi9QtUQO90OZEHq0cp3cEjvHSxcd
 K7IjzlTENXCDjpqllJgoIM9ZxZDlHIPa3tYfSlAysZH3aPYFAasUar8FayKSOsFXIXAB
 IbFBdjrT7QF2UkKgGr8tOuJKMJF7xPk7RIcyzXLlmhjl3o/NdTLbe6R+4fwI0lS0ZaSn
 v8PBBpQBBIwJ1ibkhMNWTZt+nFCS4m7o+xqrbTllLzLWGYpintg39hUfYcYFwYRszrz4
 wj7jFCK54WYEcwb9XZDFvAy/0qZXCc43BTgeGgVo4+498C7M/Kj5me4H4jcfv+nkRPFk
 /Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878781; x=1743483581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6JY17RXIOhpi9WGu5PHvZc/K1MBVjPo3G9pvjwYgCU=;
 b=CZcDpHxzQxCJe+vMcQRCVyJJ/H2Yr865Ll3YFdZAgbtlrds+eWaad9GWO8RFXjyDsU
 utTl5LOy/oE6UY0SAACVgjIJ5NnJCQtiBAvkwLjPOz5elOd3UozuBpXjznfLwz4TI2Yp
 gvrOT+e4w5rwT43w47zEuFwIUkSqtxikkazkAc+5kv5SQmMVN9cC2fW8lTLdZWC3xYzW
 41uJkXgEpUxiuSeR8ifsOG9ckBkwr7i1h6LxD0Uoa7nUAF50n7weoMk1RPRird9qRG/d
 W7Blb7pPjSESXU0suSUtiemFyx1DIJTYP5OfWVcPcno9R+/Afdia+OQ1MdZvfIVpawDT
 y0ww==
X-Gm-Message-State: AOJu0YzWFLfDun8Hf+fLZrBqJCsHM30Fj6XQhMzpDWsl2ZiDln3AIu+X
 Fwy8NLmLrvYmxa6FoH6wObTPr0BerO6sBug2ZTEMx/ZS7B04KHv+zWG6tYwmt4EDS+hJWe9llFY
 p
X-Gm-Gg: ASbGnctTwXYe0cCJVHpqw9Yp82WLY526klP2c04U8WPIKjFNxKZUYUcWiMtnCav103X
 KofBU42h76OxTobgYjkEphJyC+hNXUJWMMuBzQAIGpojp/StA9rJaQAgjJoYovXjFRScL6ghfwP
 NuvWHdDAnyC9QmA3mGM3AeDDuzUDNCiC0NPdJjc2EX12RYDwyXwMxnlmmAl2P3AuqzIgHI2YTRB
 LXaKu/dUT63GfVPUfIkF5htshJDqCDNDUSUXccaLQIv5iTX9RKB9jzZ9niMzotmozrRha6S2sYb
 Z0fn9orC9tnZoMOykLJjdb1ykYEXZaQqSg3ExhMk1r+m
X-Google-Smtp-Source: AGHT+IFyGbABiDoMVDJJuBiMI7scP0+bHtemckn6LiZHb/NiiRx62CqF94ZOcat0iRmwrJR2/o4N8A==
X-Received: by 2002:a17:90b:1848:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-3030f3efb95mr26168707a91.15.1742878780601; 
 Mon, 24 Mar 2025 21:59:40 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 20/29] target/arm/cpu: flags2 is always uint64_t
Date: Mon, 24 Mar 2025 21:59:05 -0700
Message-Id: <20250325045915.994760-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Do not rely on target dependent type, but use a fixed type instead.
Since the original type is unsigned, it should be safe to extend its
size without any side effect.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h        | 10 ++++------
 target/arm/tcg/hflags.c |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab7412772bc..cc975175c61 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -194,7 +194,7 @@ typedef struct ARMPACKey {
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
     uint32_t flags;
-    target_ulong flags2;
+    uint64_t flags2;
 } CPUARMTBFlags;
 
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
@@ -2968,11 +2968,9 @@ uint64_t arm_sctlr(CPUARMState *env, int el);
  * We collect these two parts in CPUARMTBFlags where they are named
  * flags and flags2 respectively.
  *
- * The flags that are shared between all execution modes, TBFLAG_ANY,
- * are stored in flags.  The flags that are specific to a given mode
- * are stores in flags2.  Since cs_base is sized on the configured
- * address size, flags2 always has 64-bits for A64, and a minimum of
- * 32-bits for A32 and M32.
+ * The flags that are shared between all execution modes, TBFLAG_ANY, are stored
+ * in flags. The flags that are specific to a given mode are stored in flags2.
+ * flags2 always has 64-bits, even though only 32-bits are used for A32 and M32.
  *
  * The bits for 32-bit A-profile and M-profile partially overlap:
  *
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8d79b8b7ae1..e51d9f7b159 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -506,8 +506,8 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 
     if (unlikely(c.flags != r.flags || c.flags2 != r.flags2)) {
         fprintf(stderr, "TCG hflags mismatch "
-                        "(current:(0x%08x,0x" TARGET_FMT_lx ")"
-                        " rebuilt:(0x%08x,0x" TARGET_FMT_lx ")\n",
+                        "(current:(0x%08x,0x%016" PRIx64 ")"
+                        " rebuilt:(0x%08x,0x%016" PRIx64 ")\n",
                 c.flags, c.flags2, r.flags, r.flags2);
         abort();
     }
-- 
2.39.5


