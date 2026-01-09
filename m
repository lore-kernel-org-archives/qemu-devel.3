Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0834ED26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjN-0007P8-2P; Fri, 09 Jan 2026 11:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFj5-00077m-38
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFj3-0007WM-Ea
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso16971595e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977555; x=1768582355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3ZoIJR3OjEuiKDmyBptqH1tgWzQzhR33On1g0jSsHA=;
 b=J+yc7CK98LKyZIwAT5hvzX/3RlugVlgSQs9pxzZmGXYATcal7NBj5e1btGfeC3HgIe
 1oyhSixVgOId6fmpluR6IvUr6QD2rY8ZS9DlygzYCmpWVJrhAT9/6uXVMVMAza/WRJMg
 4JSkgQKl65pWburmbaUi+LTct8wBYz0/iyQFYN9eahX9vm+N66lExY2JCwsl//gQAd/v
 9TeTl+TxLWMyghlFhL9sA7pBtp+SO0Tfiv99ebT21dTYsmoQ2xNOrJXDgqciJXrsc/aQ
 XDIvrLP0xivbI627uM5PaEn+z1ByFVO5izjwDujOmhQntQsBAZq9dYaHO7nMQQiTvfsc
 a7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977555; x=1768582355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3ZoIJR3OjEuiKDmyBptqH1tgWzQzhR33On1g0jSsHA=;
 b=FZGh2Q/ZyzlFevFmUI/0NUy+69dv/zQsvUd8x6jmQnoR+6cvy6IAAIe+oahsaBXFny
 1efD/hp+U4knUE1nnxdnUhzl8/gV22LOvUUdj1OVVf054qqHQJf3G+DmrtIa2avqopAG
 4xCpxFV7VaeUuhNCZo2/cf9rNsZUCuM9nEv4FOCQqyYvy9AIKQo+4egG9envwwU9zhmN
 U8a8sq8Qv1D6rBlwZY3XkxpyNetGhzAD5OU4YaepobxUg11PX8RueMKLGg4K/LI2GKWN
 TCgD9v4HtD2unrfuo5HYpDHILCQZ6BcIZn0AW87kgs96QFQHzno3qSuf0Y/segs0Tn2C
 Q6TA==
X-Gm-Message-State: AOJu0YxqtaopXQAmS4//TRsXFjTLUevhPS1uPJbi8anRBqRepr+6HHtZ
 P+fcSCTkBOAJFiJbXB8G36s8dY1LuufY3X/842X/dEg1pWNkWLX0tn5K5QqNGW1Kgvr54tXhWBJ
 EbqtkES0=
X-Gm-Gg: AY/fxX5ljn/RtKeWhMDIBxdv2jiHLm3Vsfh7xIDDbBm/Dnkv0SEsyTiV0h6stt1NlAJ
 jv5cqqFJuSluTDnK7wBRbHMIwsnFq+mSQNjhm5KGXekY6uTk3UgrbzbH74G5GuvxBdVSuZlEiM7
 vaI4tUeo9aEX/DinzXAE4Q9bKKdHsaX8azHTh0HHyF4LZcM4OZUJ1X7BeQkkCCNa5zPIe44TK0r
 A5uEzPMAZ6EQlxgjGWD4e/y2bW3aKxGijA1iU2j4qxFytokwRy81hg/TSI+VzNw3I/XvRhcAJXO
 YF2YunsYANvx/rU2TfjVGYZWe1NmzsLvyFg0WHH9wePd9O7C4zcmdoeb2jT9BYupZ/wfuuvTkiA
 5tVgFIerpbrovnmITgcUhO1CdyhQZo6X86mSW0yHsVUQVQ01adWzbi5f0Cdtvm3mw9lywnm8N2b
 d71yAZKsbeMrWpOLuV+ZePAlKuyuKGSKHxhb/wCZXizgDj6Lv1w0r2z+wUabz7
X-Google-Smtp-Source: AGHT+IEFPdZfYLbvp8BxfnXBIN/rVJbV33qMFqHbDfHf5571rrnmbuMC1WbPpkLq0ZBl47+ugbKAgA==
X-Received: by 2002:a05:600c:6308:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d8486d60dmr94051855e9.9.1767977554726; 
 Fri, 09 Jan 2026 08:52:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm23857372f8f.8.2026.01.09.08.52.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 14/22] system: Allow restricting the legacy ld/st_phys()
 'native-endian' API
Date: Fri,  9 Jan 2026 17:50:50 +0100
Message-ID: <20260109165058.59144-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since all targets can check the definition, do not poison it.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst_phys.h.inc | 2 ++
 scripts/make-config-poison.sh         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index f4c91dc7a91..66bbd3061c2 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS  _le
 #include "system/memory_ldst_phys_endian.h.inc"
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 937357b3531..b4d61e8bc9e 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -11,6 +11,7 @@ exec sed -n \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
   -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
+  -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


