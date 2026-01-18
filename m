Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36828C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxk-0001bc-Js; Sun, 18 Jan 2026 17:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxi-0001MH-2N
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:34 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxg-0001gC-5V
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:33 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso37543665ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774171; x=1769378971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnCVV9AnEgawNA+fiIe+uEXCZKJSFhPJndsOefTu71g=;
 b=nYpprE9xQYkq3l3Amy2P21fGeiHWahqg3XLCvfqPfxFfW3S24pQbtZ72nBZzkkIMqW
 uIC8hogQc7b93vtjuo3yYwsYOzvqCJr5ljacLyd1OrOvObfR+/W91RlfevT64LxKEQOw
 Bwu4tDyRMod/+wCyMPV8naIz24wdTgTau01nmJhyLZX9deOFrMUwK2uvDN3Kq+0Awlw6
 rCiywKbWkFbhEd2DleEy5ZoBmQrAnXh/qPDXuoy19HxhMF2KBjefr4GUtKRWGSvww/Uj
 YkJROWeB0C5PhQV/pKWROL5sb3Xnlxn051XGgyNsfMBVzciYDCF+vx6zoeTniHlHtMPO
 n0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774171; x=1769378971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnCVV9AnEgawNA+fiIe+uEXCZKJSFhPJndsOefTu71g=;
 b=iytQoEl1YYiyxOVJjyXgTWCsuLyU6cs++RMD8z5OskLNdTsGhEMCrmpsJODYpX5PYU
 TX3PZIl8RkrbEotNAeqfNokduQY0glifTSXTRYinoZgCjnwjoSGIbIlNTL4YI7CbQchg
 C3nha4RcgxWVtCfb1BwGPibI5sfEZVPjLKth0ac1YJO29wA3cg47RYye+MnXfBOcnOlq
 jPNJxqryvvw9U6nhQtMCFlAKPNle8vQJLlzKGl7glGMbzGEDKNvrtWduUDhSW6BZ6/IP
 rR+ELQ94pFqeL8bL7x/ONjVuXGnRtzTYbkSIiYSkb17G+FfC/rDogfUvaQecv4Rp4ebV
 02pA==
X-Gm-Message-State: AOJu0YwNfvhXCZD0zRvupZsFi+Uqzjs3AS+2JUQYIoHsbEdNrYvshN+D
 m4LoPB9Whqtd1LWmhEu59ZNjvoVLQlyl2F51rXRFPGQ5RxsukDtqBTZFr2+F1HMDaC2k3DGLP5Q
 lW3oYoBsR8g==
X-Gm-Gg: AY/fxX6GnMwNKUnDhxGcpTP79dwYBrOSKEhkNvrTUG2tI1qqkPREft5YR8mUacFubYn
 z84MfRyl47i2cUO9o+vyDlfBINJ3nG1bHLaecYRc3oWwkqPHFNFlPyjZX2ioNH3+y9BW1/T2OXb
 sFzXUEgZ8DzX6DIbkB8MVTa+/5lzqDtTbHxf/TqfCUeBU+HpvQOaxP4495VLCuLKjmIY03drGrE
 cS1khVHkmZXhB7zcJiejSX4JneKoMWK1pnm4WIdv0Yr5dr9znN7VR75Xlf8Z7AJQAegsE39NLfo
 PmNGDJKuKoimTKtinWbCcJQaoTJ60Mf/m0g7QHIJBdGEg7FNHCNt7mTWIgAp64Q+AmpooATq6XW
 PPMb8/6VKpEAfD9hV3TgC9OUEtEMDzBtm1RXFLXwgBm3cvNSJ4eBGrvUUTv56hdN/fH5cZfmRRz
 ND1rQvF4b6VIgYGAwwUA==
X-Received: by 2002:a17:903:2f4c:b0:2a0:a8c2:be5d with SMTP id
 d9443c01a7336-2a7188583d4mr76683165ad.5.1768774170634; 
 Sun, 18 Jan 2026 14:09:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 54/54] include/qemu/atomic: Drop aligned_{u}int64_t
Date: Mon, 19 Jan 2026 09:04:14 +1100
Message-ID: <20260118220414.8177-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

As we no longer support i386 as a host architecture,
this abstraction is no longer required.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h          |  4 ++--
 include/qemu/atomic.h                | 13 -------------
 include/system/cpu-timers-internal.h |  2 +-
 linux-user/hppa/cpu_loop.c           |  2 +-
 util/qsp.c                           |  4 ++--
 5 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index ae5203b439..f7924078f7 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -27,8 +27,8 @@
 # define SHIFT      4
 #elif DATA_SIZE == 8
 # define SUFFIX     q
-# define DATA_TYPE  aligned_uint64_t
-# define SDATA_TYPE aligned_int64_t
+# define DATA_TYPE  uint64_t
+# define SDATA_TYPE int64_t
 # define BSWAP      bswap64
 # define SHIFT      3
 #elif DATA_SIZE == 4
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 27d98014d4..dc9290084b 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -234,17 +234,4 @@
     _oldn;                                                              \
 })
 
-/*
- * Abstractions to access atomically (i.e. "once") i64/u64 variables.
- *
- * The i386 abi is odd in that by default members are only aligned to
- * 4 bytes, which means that 8-byte types can wind up mis-aligned.
- * Clang will then warn about this, and emit a call into libatomic.
- *
- * Use of these types in structures when they will be used with atomic
- * operations can avoid this.
- */
-typedef int64_t aligned_int64_t __attribute__((aligned(8)));
-typedef uint64_t aligned_uint64_t __attribute__((aligned(8)));
-
 #endif /* QEMU_ATOMIC_H */
diff --git a/include/system/cpu-timers-internal.h b/include/system/cpu-timers-internal.h
index 94bb7394c5..8c262ce139 100644
--- a/include/system/cpu-timers-internal.h
+++ b/include/system/cpu-timers-internal.h
@@ -47,7 +47,7 @@ typedef struct TimersState {
     int64_t last_delta;
 
     /* Compensate for varying guest execution speed.  */
-    aligned_int64_t qemu_icount_bias;
+    int64_t qemu_icount_bias;
 
     int64_t vm_clock_warp_start;
     int64_t cpu_clock_offset;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index e5c0f52d94..972e85c487 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,7 +83,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
+                r64 = qatomic_cmpxchg((uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
             }
             break;
diff --git a/util/qsp.c b/util/qsp.c
index 382e4397e2..55477ae025 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -83,8 +83,8 @@ typedef struct QSPCallSite QSPCallSite;
 struct QSPEntry {
     void *thread_ptr;
     const QSPCallSite *callsite;
-    aligned_uint64_t n_acqs;
-    aligned_uint64_t ns;
+    uint64_t n_acqs;
+    uint64_t ns;
     unsigned int n_objs; /* count of coalesced objs; only used for reporting */
 };
 typedef struct QSPEntry QSPEntry;
-- 
2.43.0


