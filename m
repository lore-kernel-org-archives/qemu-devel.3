Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78401D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdFN-0003mR-IS; Fri, 19 Dec 2025 11:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdFC-0003cN-4H
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdF9-0006N9-2h
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso20187655e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161333; x=1766766133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34i2N7BdKj/8NGyrgpN6X684Am9U/Qza8t05wZ+ve08=;
 b=Hq6Pz9HmGRL9UDZd+nKxT+ShzROAPaR2y+7E8RbI67EvxfjLFtZLhvMSmLJ45OAyoX
 kqYbeLER7FouO+rF2SynL1W6nHGQupsqa5w2y5U+aOycuIS3PIYWclCI1VDrlcghOXN8
 gf9BvhPlvg3U1vxvtWuO7JhFp8X5n3e7DT8+R4i/oPAnpziUoCpoQS/1GZK5eFtprd9P
 8Gh8fMus6cv4hmGCiPQ3wrIvts1OxPl4assiEPybKzdEgkiP85mPl1JsmL69TQOoVkpg
 RO8SspW4BjPK0HAAG+jMSdom7iZTxFEi8QjmEa0n8RtsN4wIpHRqph17mwFBMlglZU3g
 2Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161333; x=1766766133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34i2N7BdKj/8NGyrgpN6X684Am9U/Qza8t05wZ+ve08=;
 b=PkU7CQnD5jk1PQfLQNNbk6A3/pRU6z2vU+QmVrxhJhFmhMF8M0WfveN24mOQ5MNd3Y
 WrAUmtTjp+zEaSuVxwp48DF6IG7tnF2jkAROb3WnQbnOYn8N/B3UYDDLcWUMKXFc8oLX
 7VrJ7JbFhU9C7wQYU7hO+kfLu51o61K07I9QwJxeLw3B6JqJCPyzdsFkNJV7IClAK+2B
 tW3uR/NsGG6BpCoQgqnU6ZtKBVFdKZSW7gQtavZELEHMgKwnGLZfUwHoLPT4e3woDMap
 1KHfE7h0ySS//9iuf60A2KhDYZ1UL5d9Wa8kiLppmQGhBqS7JdoSodQAMXtJOuZF/mCW
 osag==
X-Gm-Message-State: AOJu0YyyB5TkeAzycAfMpLVml1sWRiCtPhnMhXeF4HhW/zO6XFXF2clo
 WYFxwi+xIOIzxCymtNzXsjwGq7F31LbiwAYWKAhggcZjRpJ8MJBNa2JnGix1+ebmREQ++5VOTfb
 gUf4q2Uk=
X-Gm-Gg: AY/fxX40D8fZ8oi9CVC3hVRTrmGVdfKSxCNQf/LrUcTRcklV9SL7+W8/VpfEVKf8c0l
 E04+pEvpGX5RziJeSBpJbu8E9IGjhwJKVAO2Kwl+2mFLsjRg7dkwtQyF9Ml340TlLZk7NI9co+A
 3FytM2wt90fbuA288pTsuKgUJb6mKMjZyuT3RYBngROIwzsnm9pICUk5VSh6vnvY4C2FoaXcUy1
 HjKoB00cdKlqQn66OmKkUiMaX3u8iELZURhRgAbXAy4FE94+ZbIkH+0/Yf2TC5NdhSPUjtHUmlg
 QtKOQNrSqM4GAZWJynpr4AtZk5xY7+akpr7+ouO3R1pGDIkhq2JWPTUNWV0QzH4jaq0Q3EI5V/d
 XGN2BBBirHevibG9DcX0Mus6hErQr9Y7+cJTrVCAZk5CO8H8QYEWP4GHM2ex6LKEbk7Yyv/d5Q7
 hLfSnTbFrhQdOiRGDcfQ84m+EvmCDK+NoJ5K6iZ+mnzBo9VQMfM8sHocIhwpzD
X-Google-Smtp-Source: AGHT+IEPJi+DidT23MeG+AK6jJuehEnpn18LDKQTOoDHDaZBLgmEwoeQnE9PfnmUlIlvWHlPUk8BwQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-47d195aaf01mr31960925e9.35.1766161333129; 
 Fri, 19 Dec 2025 08:22:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm5814202f8f.18.2025.12.19.08.22.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/24] system/memory: Restrict legacy address_space_ldst()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:46 +0100
Message-ID: <20251219161953.72724-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory_cached.h   | 2 ++
 include/system/memory_ldst.h.inc | 2 ++
 system/memory_ldst.c.inc         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 587e8a1453a..65ea60df8fa 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -77,8 +77,10 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "system/memory_ldst_cached.h.inc"
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index dd1fb482eac..8ff6e563310 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 20a2784e234..5c8afb26c7c 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -117,9 +117,11 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


