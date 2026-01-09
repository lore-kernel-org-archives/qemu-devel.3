Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C339DD26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjO-0007Tm-V1; Fri, 09 Jan 2026 11:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjB-0007Hj-QC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:47 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFj9-0007Wy-B6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:44 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3605775f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977561; x=1768582361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7nwKohwrUhcs5GBd6WgjNcDHff3KfVrztRvD4pmA+o=;
 b=tkh6xkk7S6TnympJnyMrIxLqJYxf0/6ZQOKF6sALBYtHPnenizFAWgrv8bA1LNK6Zw
 7OKyvhE9U8hrV4TZtbjlOuLGMJ5JXQz3v+cxxjnWLHqX75hxA5ZIsLR25rkYJ4KY5Ogo
 /eoLkQLFsA1vHynCo4CTgPm4NRRRTuTadGC9rlnIPjs357wp9UnPKMHkTTkM7rWvWB6v
 hrwBxLxuO9fkiQXAP4Nq2uIt3+Z8eZ2qbKNuM9QP9BHqPbCsYMmKVW8NfquLMl1Koirl
 gu8lDY9lAxiK0yHRVhTcYkEHbOUYdfL1KIYR2EAeaK3sH0ODIv2/HLxJN+z1/x5hN8ja
 IP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977561; x=1768582361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7nwKohwrUhcs5GBd6WgjNcDHff3KfVrztRvD4pmA+o=;
 b=kiC5gWac59WaQwp0gyMKPW8Ie0lTJRQZrIyJIOMuS9SJZY7aheGG8j//thCWAJEoSr
 9qkLPJ5hD4NHS7QkYPFa2WV/3E4jzFbCA9lh6BXIjh6ea/gAB/xcDrecO4bpSF9HxGxA
 JB0DA0xpfi6sakKwl54aSGLMdbGNMFLWaiLLhdR5r9n4iiNCS5g2OBzHw4aa5k9neJzj
 rZxXapO56hcE7ad+ntFCQSqJ/oll0iuoGSOENARqsm4mGG6OtvYvmDTGYJdrIXmH115a
 zarWElPOjgZzAKSEXMxb7/Yn5aa3dvOQdwfszjiIWnnzztF+kB8h7bWJq2pqaEpfbBVZ
 +P2A==
X-Gm-Message-State: AOJu0YzT7ZvLyRYWOCJKnVFgILxUmw9AkUfrGhrA+xXAfrXiQdruepTf
 0op//b+jgOgdNWmvfivylHDxWNEDQzb9ThUtbWIwiN2XtXWb4d5qWrlrfpnmGWa1cwHT6hxBriJ
 nPSXrmfQ=
X-Gm-Gg: AY/fxX7+RjuBSxWg3OhuaGZoDOhgWhNjSgZQ5Fk78caIsdh77To7n9c6NqV64mZ4liH
 v8lYhMi/UziYmrmR75w63o2LjLKqm8dso+CvXWXMpBn/k1jmTkYzIrpSsibt0RcaxcXBBB8UOsA
 qBDO5ehSvh5b4se0Gjm8IkSHtVrks3pyJjEMAbbQDKzTPLbGNWqWu+Y5neN+wnvBbBe7tXTCVar
 gmBx5x5Zu7cipIu/KonL3OgqkNa73DZsHmmvg+YIdygmlxjLf5Jw4uw4MVYYsfnWTnSjSIv9BdT
 0B0wFaTaFMCEqy1RgNpUBVQJMUfMdzDYTKThTWrStD/Vc683G+wpx9xOrTFsasPtg0kZVLbEokN
 UKepnUtekqG1WJIHcyg8fURiZ371D8/AdiLffYO1G8VX1Xz3hyCtptrvA09PrMwGcgaIBFoJn/R
 /mdsRLtiT6WlAJoZDmoC6EyS81tWI3DHyv6OAwaniv619fWcrOybmqAfpQ+GqwxlGAXCXyaHU=
X-Google-Smtp-Source: AGHT+IEOfikmyWS2pCcMbmg+1MstFDyCHIFKXGW9Qs0uZQvCHWom6g+l4Co2XnX0NTSrAteKUdwUjw==
X-Received: by 2002:a05:6000:420a:b0:431:c60:c600 with SMTP id
 ffacd0b85a97d-432c37c86ebmr11334679f8f.35.1767977561489; 
 Fri, 09 Jan 2026 08:52:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm23350809f8f.33.2026.01.09.08.52.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 15/22] system: Allow restricting legacy
 address_space_ldst() native-endian API
Date: Fri,  9 Jan 2026 17:50:51 +0100
Message-ID: <20260109165058.59144-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_cached.h   | 2 ++
 include/system/memory_ldst.h.inc | 2 ++
 system/memory_ldst.c.inc         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index e0ed54bd1eb..6eb6179140b 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -80,8 +80,10 @@ void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "system/memory_ldst_cached.h.inc"
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index dd1fb482eac..896550bdd65 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ebb441f1a66..a728b7737c2 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -105,9 +105,11 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


