Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F625109E520
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W9T-0000x9-CH; Wed, 25 Mar 2026 17:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9S-0000wZ-5w
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9Q-00034d-Bm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so312137a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475551; x=1775080351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/6uNAZDRg3OvgbspkHXUcua3vTL1U01rrAn4eKcg5k=;
 b=XGsy1ELehUUekP58BGH4rbE5x4Cw5XfqdVfwbZQdDVyl5+y2nheuCNwUlbGBVf4p2a
 226L7p6KHj3tGl3rGY+VfHx3NyzGG9iKo7G+UhD3/HXEb2YoHibYHqWkEHeC+Tqs7M58
 zJ/0zvaumTZYgGc7lcbjsprR5N61jddKL8R9Kd2m2saaFke8vPgz5k0jC5QB3anV4f0G
 JPbnWld0f6WOmPUr3206/4JwT5BM+v3Mia1VJYu9TJ4rGRF88Shy9PxhFpph7+aHeiVH
 NA8wPGLvRD49an7MlOePC4K5Z3kUDJyKkSnqUhy8NFx4OzKvEiygZYBUNVl9RN+nFM3w
 9H9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475551; x=1775080351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/6uNAZDRg3OvgbspkHXUcua3vTL1U01rrAn4eKcg5k=;
 b=tXIrv9E6nAJtrfYY5iq25LwDkG89W3sDyQCr8/5KBb/igm42T2pqXGgM4ikvl6k3WB
 v+BMyW4U+u4XHASDUkFLNiqlWP3KoE5S+dihoYhx1qztauMkNz+2U13HVPuCXywGFfuC
 v5mVAOy4F4l+phNrGr6x56wO0l7Hjubwq+ELzCVuLFokkbhaGvB/hXVSQ9u2JmxMnSKX
 Fk6j1VD9KsSJNwBzGZWBTUAD2k6TiOyaSnTFV1E5urrFgwH4ZwPZ3D8oK6u40ytsttbW
 3C6FJ9ziJTCh8z7B+rv33ZA4Dn6io0T97EJ41IKO+CqGz9ySKzHB02hRCa3lAPiLnuR3
 B5rA==
X-Gm-Message-State: AOJu0YwshKBgqANd+pk0WnyoITqXO4O/o3Asq3FeY3LnqXJpKkClLAFR
 HWG5u+iM2UakpmyCtkDDcJ/scvC5850nYJOOuCwGYuylaPJzTFgiostO5yXP3ARra7kiazcF8gq
 CP3ugQ28=
X-Gm-Gg: ATEYQzwC1NAx6YmV8iiJ66eDO8LvB6UJXcRXPiIEoT86iOPgU7VxWEL/voKlRQAnTiI
 SBXnO5Al2KutQQqiH+HLr/hLkhRqBdnwcfk8BgC9op5vNKzWdN6Hs06I4jdE5JedD1WqX9MqNAx
 943waFTWuO9iY+Bufq4RUQhcFyoePe/XkVbZQU5eqxZShg6JMCeBmKS0i8KQD/mfoYD7PBWGD4l
 Z8mUJW+pNP16DBbubdE677GBiDbvSot1GvHde4tZuq6LF81GjtOHJa64JtI+lwHt6ySxPuTkD48
 uhLtRKYR2DNI8IGLi5ewrdVaNOCOsEYtmjWs9gA/i3yUlQICg/fhpAGxAMEWWj8UlWqtuci2cZ6
 tIzfgI3m3fReV5eYr0bRF//JZJRwA1KMWmg2EsCC3hdjJYthmZbe3BAU0gkT/p1DMEP7Lpxr9aL
 HNXoTN2zfyeRauNNUmgeMWL7aTxGB+tjwAE+Pn7XSWHvH4uSZrIHNJwoVPBBDXbn2hmjDNBJbNi
 ixR
X-Received: by 2002:a17:90b:3d8d:b0:35b:e4d4:8290 with SMTP id
 98e67ed59e1d1-35c008d3242mr7937420a91.9.1774475550941; 
 Wed, 25 Mar 2026 14:52:30 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0313eedasm6402987a91.5.2026.03.25.14.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:52:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 3/3] tests/tcg/plugins/mem.c: fix endian swap in
 update_region_info
Date: Wed, 25 Mar 2026 14:52:22 -0700
Message-ID: <20260325215222.3678982-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
References: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

value returned by qemu_plugin_mem_get_value() is always in host-endian
order, so we need to convert TO target endianness and not FROM it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-4-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 1ee257f855b..6b0732dc0fd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -154,20 +154,20 @@ static void update_region_info(uint64_t region, uint64_t offset,
         val_size = 1;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U16:
-        swapped_value.data.u16 = be ? GUINT16_FROM_BE(value.data.u16) :
-            GUINT16_FROM_LE(value.data.u16);
+        swapped_value.data.u16 = be ? GUINT16_TO_BE(value.data.u16) :
+            GUINT16_TO_LE(value.data.u16);
         val_ptr = &swapped_value.data.u16;
         val_size = 2;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U32:
-        swapped_value.data.u32 = be ? GUINT32_FROM_BE(value.data.u32) :
-            GUINT32_FROM_LE(value.data.u32);
+        swapped_value.data.u32 = be ? GUINT32_TO_BE(value.data.u32) :
+            GUINT32_TO_LE(value.data.u32);
         val_ptr = &swapped_value.data.u32;
         val_size = 4;
         break;
     case QEMU_PLUGIN_MEM_VALUE_U64:
-        swapped_value.data.u64 = be ? GUINT64_FROM_BE(value.data.u64) :
-            GUINT64_FROM_LE(value.data.u64);
+        swapped_value.data.u64 = be ? GUINT64_TO_BE(value.data.u64) :
+            GUINT64_TO_LE(value.data.u64);
         val_ptr = &swapped_value.data.u64;
         val_size = 8;
         break;
-- 
2.47.3


