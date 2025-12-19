Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC428D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdF4-0002lm-LD; Fri, 19 Dec 2025 11:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdF3-0002Wt-E1
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdF1-0006M0-TJ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1526434f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161326; x=1766766126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VadcLSqhJ258bP0oq5fPt2FaMzVFLrZ+DXNq/vrBxo=;
 b=M/mbjS7S6o5gNcmxXF3/YJlwA/4BXWkjHOC0/usl+NTatHcwGxqae67oWLv4laKrri
 0iJUk3o160aI5aObiceiIjy70O2RE2cHwQZjATj3CjPlxUN6fvgasAKbJCqd/PYOidz3
 GXOq+NIHfgrzxMjhSWzSfyWSumLm23JnYf0LW3HCjyfsmfdKRVcI+3lcd14DsdBC4Xvf
 OoA8yWtGxFXntKm9BVDT+Zmg1P1hmVHzk9CfQEZ+yxKx2523eefg+eW7idi5r6K1MFgl
 dnFYN0LDmHsTtaGNYviH5zEDuhjllPPQeLmJmjlZE/lRX2S0T/2iY3maLh+LM4eKuafn
 JkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161326; x=1766766126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0VadcLSqhJ258bP0oq5fPt2FaMzVFLrZ+DXNq/vrBxo=;
 b=SwiZv5aX/jXZKVsu8sCfFK5ZNubqOLsuzbY2yc+6vACa/Y3OkFcJuQWWheNoG5INsa
 YZGp+K6ZFT2wFJf2M6Svz5MQ2AgfZC6rXMTUREO2+AhCuNOtuEA8eaUORDrdZCnpRDkJ
 OWHnreOreAy2C9Gybe7NKzJcWw70aB798PApe99Yz+NpGrbwApXVIzHA0n2qtgphpGCv
 jgaXZj3imoyifvmWHUSV2OAEtiXABZETKYyS8sYfWTt8te1hiisr8dk09HrM73nNZh9f
 XAqAkERE9K9wWnq+gAQa4jkSG+B2UDMXPaRr5227RdanGQMwetMzIQ+0H0hMAyIwFEYY
 qBLQ==
X-Gm-Message-State: AOJu0YwpbG3m+TgGQqyqHuWw2W/PiyDyjjhYkbGA4fnLjUD5ZkpKMd0B
 FatADo2riRsr8x+0u9LcC7EFwDFa8qMSAPaVOfsQZqKbiyaHox8lmsE3aJQmXllx6MdN+3vhgFr
 GIx5WUn4=
X-Gm-Gg: AY/fxX5Kkf5eypKMJU02wwaX/hhMnb7igf2K6nz4+dfbLYRfM6NOKO2uJ0AGRMo5kdq
 n//4KS0QtyjDJnPE7H5PlyxkkROZBf8Ntv1Ja7kmEz3yWKzTdfWyFELIbqZFsz/p08kOJ1VKWSB
 sGErJZ3JZplbntk5hUPJkIDHF5Wz0xeB7sGsP4tVp6DYakYwzJnRhHff27IA0QHgP3Ve/NLe/JG
 xXj99yJdAk7SpYN9nZkBbCJAH5qZtDFoTXnYOlw+j4zXwolX5pVhdRiq/2OZFvycGWIm3ZQKqAP
 j01D6NsMA8/RDLFplUfpxczvImUvPKmUnGLlVHxK5/8RyH5xmK0N2JeoMJ3eyZIgs/HbAXV4C0L
 NjXG5Cu2J3kXkIOiNSqwvctKaf9QiODry4yWY+leUCjEahjhN8dD9VHfloBEtCFNR2TNpurNx+m
 A0Aqn1ZGAK/EgQYlJQVQsfgjkT65BSLugQzZIhs7LyNbIZrSZRSGrtlrIVUVuY
X-Google-Smtp-Source: AGHT+IGKzZD95vVI5917QlkyDWGOADRGlmurXAPGz0z+1G4il8Affjnh1eDgz53xVMtPYsa7HKAW1w==
X-Received: by 2002:a05:6000:25c3:b0:430:f879:a0fc with SMTP id
 ffacd0b85a97d-4324e4cb9f4mr3882237f8f.21.1766161326033; 
 Fri, 19 Dec 2025 08:22:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2ce09sm5611430f8f.19.2025.12.19.08.22.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:22:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/24] system/memory: Restrict legacy ld/st_he()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:45 +0100
Message-ID: <20251219161953.72724-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
 include/qemu/bswap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..8b0070d26a6 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)
         }                                                               \
     }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 DO_STN_LDN_P(he)
+#endif
 DO_STN_LDN_P(le)
 DO_STN_LDN_P(be)
 
@@ -423,6 +425,7 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 
 /* Return ld{word}_{le,be}_p following target endianness. */
 #define LOAD_IMPL(word, args...)                    \
@@ -494,4 +497,6 @@ static inline void stn_p(void *ptr, int sz, uint64_t v)
 
 #undef STORE_IMPL
 
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
+
 #endif /* BSWAP_H */
-- 
2.52.0


