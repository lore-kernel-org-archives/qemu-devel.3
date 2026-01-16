Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15759D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagp-0005Wf-PW; Thu, 15 Jan 2026 22:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgago-0005Vn-9Y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagl-0000D7-Et
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so10596435ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534794; x=1769139594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwA+XxyWFDkORFNBlQmOw9xYRUenABDhu5WGq8pWY6s=;
 b=StR4WfOftKgtJGzUI1Q/4DD1DoUHCcsy0rDVm13H9JLXz5B7QNAmZP4AnceOeNdpBa
 ACjYyuztSv76F5n1WFky4xj2i2q1mrGSyH+vCWW1m4VetQy10jr0D748Nxg8QxleBLLV
 RaaSUWkrfXHsKGx6Cj29CdboTWKAHpUHTEP+FTpifHBwjmDwixeGKZgL64H9mp9JtSfu
 /k7P6OiqedunOpGFFyJ8MiNAJ0mAfUunm3mINOZ//s7tDj8LaMRX3Syu6/qPzm4pLFvg
 o3I4Kn5IlJUW6+WvnV4yhs/1A3zNY2d54QdoV3tFymZEgReurXG/VEQu9EVyNA9ezX8X
 NVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534794; x=1769139594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwA+XxyWFDkORFNBlQmOw9xYRUenABDhu5WGq8pWY6s=;
 b=FxApeF4Ir8C6iScbmPyfFC4T+gsOsH+JdDp/YF69Qu9ndoE0z5242BALbaH7S64liw
 ej8gD3QyhjGKIB0yEqhwPVhx4Y9NLVohvYPQ/yLbWoAqJyA3K9ls9Gcdor0Id/IuOTqM
 caaLb5QK6CRcjBPYEjynOm7muEPNpiaT3ZGW5r/g+FovozBQOVuUEtX93V6p09RzL5T1
 81h/PzKaQ7e6qlWftS/B+Yckwwb6HbNrDnd14yERSn+0hi37bNRxFR6mtlWXUO9JoIxY
 nEL6SplBG+O1mNd3cuzsLOOD0UeUmBqnay/ROcWHTRD8OcbRVdR9fYvDv65J0ebIno0P
 /M6A==
X-Gm-Message-State: AOJu0Yz5KufAsp608u2RdbmLqAwsLcjA8iegdYYx/L6Nahn5e+TEbUmg
 Ym0qbqdkDwCFtJXcGQsQ1YQvBHN8Arq/fRcbYDqY9gwos4ZCEj4fEQt6oYSynPbTQY/okPSPotd
 wLQB4hSiUZA==
X-Gm-Gg: AY/fxX74jAQIuQ1smXa0WpxEsgAvOa8ivJ6TDL1+WhtfK4RIVdWIH0B4LTE9/kB//Rg
 pHq2i6p+/zhmWmwmmVMhIFHaNB3kiAWGYCCoqIDhxpQzBI5QQoMAezmUUSJaaAh2FM9xMrSSA9H
 Gzx06Ngr+RUcgeBu5xEVKlMnu5W1jD34MbgTtwzQKhWEZRdI1urlou5I2c10HUgbNlSqczF8fmP
 kTGjs6capKYabKdBGLGBlGUdWEFlLlpCvFi0HiIUGOkhOmbx4rwa9D3cir+DTbZhnOWNTnxMk9j
 STZ0Z94Hdam6TU4DSeQ77v+d8/yh+PAQaViEpozvcrrEm1DEiELJ0FKpHgXIigmsX/rSFDQt02E
 uLy6bYHTbC6zJPTSr1m1XO8czyBKIiN1iRQd2w0uDdQ1XX1vMdAzmFugwe69tyQiaRTNdjVjlGC
 KSuYF6Iq4ZxKE4mUxfcg==
X-Received: by 2002:a17:902:c952:b0:2a0:945d:a195 with SMTP id
 d9443c01a7336-2a7176c5ce8mr16872725ad.45.1768534794006; 
 Thu, 15 Jan 2026 19:39:54 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 57/58] meson: Remove CONFIG_ATOMIC64
Date: Fri, 16 Jan 2026 14:33:03 +1100
Message-ID: <20260116033305.51162-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This config is no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/meson.build b/meson.build
index 0189d8fd44..3108f01e88 100644
--- a/meson.build
+++ b/meson.build
@@ -2939,22 +2939,6 @@ config_host_data.set('HAVE_BROKEN_SIZE_MAX', not cc.compiles('''
         return printf("%zu", SIZE_MAX);
     }''', args: ['-Werror']))
 
-# See if 64-bit atomic operations are supported.
-# Note that without __atomic builtins, we can only
-# assume atomic loads/stores max at pointer size.
-config_host_data.set('CONFIG_ATOMIC64', cc.links('''
-  #include <stdint.h>
-  int main(void)
-  {
-    uint64_t x = 0, y = 0;
-    y = __atomic_load_n(&x, __ATOMIC_RELAXED);
-    __atomic_store_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_compare_exchange_n(&x, &y, x, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-    __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
-    return 0;
-  }''', args: qemu_isa_flags))
-
 # has_int128_type is set to false on Emscripten to avoid errors by libffi
 # during runtime.
 has_int128_type = host_os != 'emscripten' and cc.compiles('''
-- 
2.43.0


