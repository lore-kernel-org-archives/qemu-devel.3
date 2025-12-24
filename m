Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6160CE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQal-00041h-DU; Wed, 24 Dec 2025 10:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQaK-00035K-3v
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQaE-0003KJ-4H
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so2328095e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589323; x=1767194123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gD8JU2pmVND43MkkfvpIdwWKILzGxGYkTplC6Rgxmp8=;
 b=CHg5V5NirHhInzglecSmX9OI0yQOe/AHl1E54yBE/wVD/9O7nYzX74X9K6xOx8fCg8
 IPxlDzx1W2GKPKpdgVS0LqqiAyVoqGsubba49bdTblsYoPC70bUBxZyf0aS9Fw4/o/Uy
 7hUFTk4jm3ef/01TRwtNgRHSpjSqlJqNs7vaiisQKkS31bjHML8EmRUId5/utUSN2Kpm
 ZL4wwUNnckNyR5FpwEVzpxRQSYE+/loX37pW6xxHbHMzCi+E21xXBLZlqeGPxsItTP0Z
 bDfFnT7KFnmfR9hjqO2jsj2aYNhdUiW0IiohVJRavt6vRvtr5evSq41C6w9+tmiT6x0P
 05aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589323; x=1767194123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gD8JU2pmVND43MkkfvpIdwWKILzGxGYkTplC6Rgxmp8=;
 b=SYtlQ9+/BOdJkqsVRInaEhk7b4C6DZ0vmVSSUs5EN4jeVsml4jRU5733CqvwK2JOPF
 /eC65D4XV9uYK5eMl2fIj2O8RQnJKXNMAXFnaIiV2NnLqguHfGJLGXfgLYiL2bMzF0I6
 1XMLTtMQrjTsusBJ8Q0J9MJlmEVCEADe9VVoI0cGqsV0bKBQGIFozSIYO9vgc6PE6o5m
 tj9knN9I/DJ+XQUhkjKQS5wkqNVnsqLvVfA0WTc7RD/NJD4ySv7auaIYfUaoeJ4XC18U
 CqSzlQHvkFmmUCgiqBib5uOY+NWgAa1HrKFYzvGua+lsGuaw0qpd6pcxnV0w7l36FfJY
 AlaQ==
X-Gm-Message-State: AOJu0Yygcw//TA7QW6cnQMJY1nxtrkW3y1EecE+6RVganbSYQyMru5/t
 TMyWESuro9f9mpIUy8Tk7qhSAnFuiElPeyCFAWhgxwvKwnb/r6p5Zlrjkqs58s0X+284oEfOqT4
 TyGr94ic=
X-Gm-Gg: AY/fxX4EnCDyRztUtRbkm2IOpIlaaL9AvbwqaAgLS3+BCtw8BzOwEd+rmNjEvsjiv/q
 YJ/AVg08ZhdvMOxYPbfQ+c63EGDkGHh92Wxnfl4NsxJoaXMrzxVQm9e0Qh+4/DIAOtqCO+eJnJa
 bANTrNTOYOt+4S7+4gvW75YJyZf++ySRIUbrzrdYSAfjbVhcAW6dNo8QPVALeTezqt9pJh+htQJ
 5yXgSsm5Edz0FdFbE+6mZU+si6KL1p47ee1cXm1fif2ETR1dER9sbnwWoe8GbMQIqhz1luvNMKz
 e06iz+xmaUgj9TI5gD4gIZPXiTIC1XB+jToAzHrF5lNX1Y3OYQqoF1rsSsaI+sdIxeAX7PXxaOK
 4KviS1Ceb/Im3d24PlTDk5MEp3929lsRuTAz9kvgTL9oqB9ziOXlC0aO+yZR2JAJSxVmtA5H6Vn
 2CFrtvC5URdKmEoB4e9xehyB6Hmsfgq1NEPjLWZQM2zDrlgsCN0wpFF2moEXV6VTTAtg==
X-Google-Smtp-Source: AGHT+IED5NTiworPy9fGAYaEAYlWnUKoxV7J9qyYBS1cQtso4club+7XuXaQ+qeAhLJvb9Xr4Cvcjg==
X-Received: by 2002:a05:600c:c091:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-47d195a98d5mr153341105e9.35.1766589322759; 
 Wed, 24 Dec 2025 07:15:22 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm291574785e9.13.2025.12.24.07.15.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:15:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
Date: Wed, 24 Dec 2025 16:13:49 +0100
Message-ID: <20251224151351.86733-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

virtio_lduw_phys_cached() and virtio_stw_phys_cached() are
only used within hw/virtio/virtio.c: reduce their scope by
moving their definitions there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 21 ---------------------
 hw/virtio/virtio.c                | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index c866769cad8..5b5fff5295e 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -102,27 +102,6 @@ static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 #endif
 }
 
-static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
-                                               MemoryRegionCache *cache,
-                                               hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys_cached(cache, pa);
-    }
-    return lduw_le_phys_cached(cache, pa);
-}
-
-static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
-                                          MemoryRegionCache *cache,
-                                          hwaddr pa, uint16_t value)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys_cached(cache, pa, value);
-    } else {
-        stw_le_phys_cached(cache, pa, value);
-    }
-}
-
 static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 {
     *s = virtio_tswap16(vdev, *s);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 257cda506a4..fba9d347d17 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -216,6 +216,27 @@ static void virtio_check_indirect_feature(VirtIODevice *vdev)
     }
 }
 
+static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
+                                               MemoryRegionCache *cache,
+                                               hwaddr pa)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        return lduw_be_phys_cached(cache, pa);
+    }
+    return lduw_le_phys_cached(cache, pa);
+}
+
+static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
+                                          MemoryRegionCache *cache,
+                                          hwaddr pa, uint16_t value)
+{
+    if (virtio_access_is_big_endian(vdev)) {
+        stw_be_phys_cached(cache, pa, value);
+    } else {
+        stw_le_phys_cached(cache, pa, value);
+    }
+}
+
 /* Called within call_rcu().  */
 static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
 {
-- 
2.52.0


