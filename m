Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110CEC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmn-0005Ew-Gh; Wed, 23 Apr 2025 20:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kml-0005DE-53
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmj-0004Kt-Bq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso400051b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455788; x=1746060588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6MDZmD8wHi337leE/VPRqxkP9hRcv8+ycuZ+hH6Uq0=;
 b=Xe6AiNwiVFEa0lISPAkk3kgYY8Rngyg112PD+5CIbPgDoz2LrlF8wiR7C04t5jQP7I
 7Uv4dmZYmKDaGXJPdWwkVXbv/OJ4ba5LHarrj1BYbBbwIn7KqBn5XoVf45jommmi94tl
 GE9d9oVxVSdHMc2zj1SE+fjGAdTnmmytlHCGP4mLL0lHJHuOPTY23CZH7tb2zMQRd6rq
 9T+KB/d2lk5ZPIymRSJV9RucUUwygiuZSWXQL4+t4I3n+o1JfLaAWFYViOGQpCvi4H6/
 /bN3N1f1QyNBkCZrozXag3Y+6fG1xcp+CvLlLpQoHm9kiUSIChPnC4bcqTVRdEyE6Ner
 fcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455788; x=1746060588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6MDZmD8wHi337leE/VPRqxkP9hRcv8+ycuZ+hH6Uq0=;
 b=mPGxrV1Y/FgECP5S/4Xi5AxLu4SPDdrx72n0sOKxfufuSqpf824Ntj9g+8fvjVm1p9
 9t0AMvQtxYAdEqzD36c2ltE8GY+ijJOcTt6lfvuIdhFUhBbQkV00MCw+gcmEjwkqWAHN
 5UKIjK1w13vJUZK+2OmyyWDq3+tPr9EKuQX6y+PI7iUMblhcWtGrtC/tNJX9x9rxKnP8
 jJ0LZ0kwbUCypYC/676VBc30YZXC7QbXvqkpvVqIwQcQ/0rG0k3lw8+B7H+l5jlXVB7O
 muqAkHTvtcilBPjQvW7UbwlUJfbiV11tpQaB1VS67gR1ZlfVy1S5ccsQXwAidD29VhuR
 8JDA==
X-Gm-Message-State: AOJu0YyY24+ef5dEptzNrqbOZrekcOYZ22X+CAbaULxgPwuJue9tRWlz
 RvFwUssC8yIjBkXBLLRNenrcKa4r1mv+U5yg/lAaFILhyz/qDwGIAi+5Jo9I6Xb+zcCAflWiPUc
 R
X-Gm-Gg: ASbGncuoj9tlY4kQyck08aK3CH4UU+xMYEzaWaHvstc7NT+hBDseCfC60pmZCmk6T5y
 lDDFRAZsH6QwaY+zeHWv+eiGK3bJb0DgLjIkAJUJfETySEo4i4GuavETysIdh0fn0Qru70mjyti
 yjo5gg0y+bjTBkg5zya9yoiCxna08sUN78spFRji1Wg0ifebEedKoJsFY83bOwQKIl7qMTypq08
 mRj0dTLeMDGF6IYjtOiCSte6Mad2SkemMFY1krhISn/RkqNZ8SAO6xmjNvuEEy211Ms2/f/sEdr
 0forO/dJDIdhQ8BeetGP12R9PkuAW/Ad3FQZZk3MzGTaaOIHxkRlj1L9FX2Kv/CnvA8JoDuPmVk
 =
X-Google-Smtp-Source: AGHT+IEJh7fp1odTw4gbWQLh15F8AazCHzHxujhSiLQXPWw/x+oUSqtp5AFv3IoMlN+KecyMI5lA+A==
X-Received: by 2002:a05:6a00:1383:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-73e245db378mr1160762b3a.3.1745455787971; 
 Wed, 23 Apr 2025 17:49:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 016/148] include/exec/memory: move devend functions to
 memory-internal.h
Date: Wed, 23 Apr 2025 17:47:21 -0700
Message-ID: <20250424004934.598783-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Only system/physmem.c and system/memory.c use those functions, so we can
move then to internal header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-17-pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 19 +++++++++++++++++++
 include/exec/memory.h          | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index b729f3b25a..c75178a3d6 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -43,5 +43,24 @@ void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
+
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
+{
+    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
+                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
+
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
+}
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fc07f69916..2f84a7cfed 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,24 +3138,6 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* returns true if end is big endian. */
-static inline bool devend_big_endian(enum device_endian end)
-{
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
-    if (end == DEVICE_NATIVE_ENDIAN) {
-        return target_words_bigendian();
-    }
-    return end == DEVICE_BIG_ENDIAN;
-}
-
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
-{
-    return devend_big_endian(end) ? MO_BE : MO_LE;
-}
-
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
-- 
2.43.0


