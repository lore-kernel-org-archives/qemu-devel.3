Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2646E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjZ-0004xc-9z; Wed, 24 Dec 2025 10:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjL-0004eE-V1
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:53 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjJ-0004nv-Nk
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:24:51 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64d2c50f0d6so5233323a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589880; x=1767194680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0KML5ZskqhMnCPZDv1dkAtwpKpffc5q5Zjzm5fRR5k=;
 b=cJpQTnQAiocV6S2j7x0nZ67f6iuIIC0KyZ3ufa6MWD0WeMrKPMPHM+4I15pI7y3iRI
 cTSqI4H0NORgfHGOlwP7fK3IhC+Wy1ovFYT6go2Mreuw9ihExQUHHievt4/ZW7G3VnDv
 ATv6MC0UsT2JBn0On152MrVhjbn7D8A61qq27GcY5/yoO3F+zEDP1WR52CPNt+WDnN+D
 zJvXKfaisZdAZd3pNUDeJ5tYaxnOIK/a1zRdbWDxoMCcT5/NvibTDMYThz1+ofpm4TJI
 duZCjlaiLz28WVp9j13XtuTrfyi42lR+I27rUCXvDVlptG86ytGpaOTtHX+4IIwQIH71
 ygzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589880; x=1767194680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0KML5ZskqhMnCPZDv1dkAtwpKpffc5q5Zjzm5fRR5k=;
 b=fvKERqpNSiKrfsRK8qKXku9mkG0wqJ99cn9L71EIEwnaut1ykIArYuqECmL3IqsLv6
 KcrJMEeVqPaVv99Ao7JRQxJd///MMfRTXsTW7n+HVYRj623Woe8YLJwFujLfsGD1FbW1
 R4xPOr4e7r4EbYVsLpqczY5j6R/nh/hSImmZqZycFB21crwd+vIMmdRUH8/AptsRDcay
 uRIJbstYLZRy2kdaOYNPI6BhvZCCjlKe4OUMiNFWYS6YRPw7HyqG85aG/0c8ckgxa85R
 A7xJ0Gj8MHvtDNmF9ND/Tx5hwPkwtlPyh3E1y2bB0UxGm7L6Azwmaykx2/6fxaIeC8nO
 xERQ==
X-Gm-Message-State: AOJu0YwkAk4Hv7iEL1agThpB5wkb0brnWScGah1M5Is7yOW5/E5wYHYS
 1gA8aSPjFis/gj9X2oniGwGEHPTCltosiNrSjK+kB0VZNolDdDggQW+63jM+KnDUe7mDLEBsBxY
 ny9UuQpc=
X-Gm-Gg: AY/fxX7qAMn+69cCT7a2YQWeR6OlfUBI1Ayv+5dXRdEVwI4R3OQLVgSswIk4PaKVl3n
 8uI7T630uTwDtJOlW1pAp47ZT0vhGwlHIL+OKD5SSKOb5BLM76KT8TI4Vyt1g1r/xncZSmIQDaC
 t2aoy6lYY0AbVpJQv6nxas0RT+03gZNSuFbJfJ+N/084siYMEzsiJ6bi79EWi5PyqSCoKnHfHhM
 OOMGfDMM7mXRDYJm+5UEoxEQJJMosiyqthxUdup9794LI6OR27bxBbYoLWb/EVssVzcO1s908dj
 1j9O8ycLj1wi05ckzv8ghqyrDSM2h5gZGocOIbZX5yHb6PwpSc/bGy+sP75c4rN7ZF16AwScfz6
 KSZ0I9MmyUMrmN3FxfmnM2eZI/Oq6vghkn3fex7yxOLNHAxlda2V1cWE+oehpuBpZiz73h+3wH/
 mdbjjISLjFcogCZXz/jGgU5SqvCkB2SwN9/tY8R2Ayg0ZOHPWt3EkDzyKcMmk1B0agbg==
X-Google-Smtp-Source: AGHT+IFEE3sBAZK1T0rAwSQyVk/nlxG87flOMeYZJrMX+xnbPk90NNCcL3svd+1tZBCse2OCi3t70g==
X-Received: by 2002:a05:6402:3586:b0:64d:88c:c2b7 with SMTP id
 4fb4d7f45d1cf-64d088cca85mr12130836a12.14.1766589880565; 
 Wed, 24 Dec 2025 07:24:40 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm17255402a12.21.2025.12.24.07.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 15/25] system: Allow restricting the legacy ld/st_phys()
 'native-endian' API
Date: Wed, 24 Dec 2025 16:21:58 +0100
Message-ID: <20251224152210.87880-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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


