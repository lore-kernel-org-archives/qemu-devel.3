Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA7D3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLw-0006FH-0x; Tue, 05 Nov 2024 17:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLg-00065Z-JK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLe-0004Ez-TV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso51641065e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846909; x=1731451709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1llUEnAFmS+LM423RX75Fj9kXPLYaB/D+OwWWf3php0=;
 b=em9sodtzn9o3idqVewD1ww5mxqBEkpkIR3uamyRLiE3PqffhLOqt4tOfac8xLiVYZ2
 EZeOM+buluDjzUa860KnKKBaVOqb8XVt9z7U5wppgczprKGKav/MFBDH/QzVupc7rX3G
 xGL0ZdR9xV+KE+7qVeh/wl3TqVJd9QyFB2DzbLHEVcK62gcFffY7QMh1950VuYyQnMoK
 FkCqD6syIJT7He4BV9eYnG7gcP+DWERVlEOh8ciyYd4zyY7zF++ePJ2e4eaFfOplAFHX
 80WyLBzXjCFALDDv33aWe6AFgmc4Ui8c+iQMKudN3iVPdPcZwTXAaTB/lStm8zMVH8f4
 T5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846909; x=1731451709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1llUEnAFmS+LM423RX75Fj9kXPLYaB/D+OwWWf3php0=;
 b=smRfgXer0xOyntZxXmCkwUyJUgkOOqwei89eSBl4N6Fnr79XsyQW2/14Itb2RcgT52
 mHZv32FyY+joJ4Lbjyuk5SmvOxhdGPGH1gZHzIYlq+rJlm/G/wQsZa7JzeTCaQkl+tIH
 8gqhvf7JouSJeKH21JJCHIG5QvPcOlNLxId7wICH6yra1h7lUbhaMy6TPUtyhAvOzUXp
 PQhbI5DUJmM6upZgRipYOu7+Om0w3TJIuugfzmO4e3j+bTaKBLzUfeTF45nJ4Hr2aV6S
 /sBjuEFQhF/IZ91TsqpcZ5wCJ1uzVFUEHNo2G6iv+36/Gv4Zz4jDp6qu80lzhI2YIXJE
 KZDQ==
X-Gm-Message-State: AOJu0YyQ1KPGazC9Q44YpIJWVhhAUsWI5vnnrbiQ08gPMgdnYAbvs0xL
 3pcigXW2QTMyIMD2CX1tggoU2LBJDVgnArp9vWLqp+j7YtopNyDNetmJbWf4s4FTqeruSGQXsnP
 UCOHH8g==
X-Google-Smtp-Source: AGHT+IEIItMusMbFr22ZVYU0W37YfzRmWtDrA606E4mKcg0tu6jKVZdG3x1cQOaGElq/QDgGCBgHIA==
X-Received: by 2002:a05:6000:4711:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-381bea0ee17mr15122426f8f.48.1730846908645; 
 Tue, 05 Nov 2024 14:48:28 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7392sm17312802f8f.55.2024.11.05.14.48.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/29] hw/core: Add a helper to check the cache topology level
Date: Tue,  5 Nov 2024 22:47:09 +0000
Message-ID: <20241105224727.53059-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, we have no way to expose the arch-specific default cache
model because the cache model is sometimes related to the CPU model
(e.g., i386).

Since the user might configure "default" level, any comparison with
"default" is meaningless before the machine knows the specific level
that "default" refers to.

We can only check the correctness of the cache topology after the arch
loads the user-configured cache model from MachineState.smp_cache and
consumes the special "default" level by replacing it with the specific
level.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20241101083331.340178-6-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h   |  1 +
 hw/core/machine-smp.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index edf1a8ca1c4..36fbb9b59df 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -53,6 +53,7 @@ CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
                                               CacheLevelAndType cache);
 void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
                                   CpuTopologyLevel level);
+bool machine_check_smp_cache(const MachineState *ms, Error **errp);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 /**
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index ebb7a134a7b..640b2114b42 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -348,3 +348,51 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
 {
     ms->smp_cache.props[cache].topology = level;
 }
+
+/*
+ * When both cache1 and cache2 are configured with specific topology levels
+ * (not default level), is cache1's topology level higher than cache2?
+ */
+static bool smp_cache_topo_cmp(const SmpCache *smp_cache,
+                               CacheLevelAndType cache1,
+                               CacheLevelAndType cache2)
+{
+    /*
+     * Before comparing, the "default" topology level should be replaced
+     * with the specific level.
+     */
+    assert(smp_cache->props[cache1].topology != CPU_TOPOLOGY_LEVEL_DEFAULT);
+
+    return smp_cache->props[cache1].topology > smp_cache->props[cache2].topology;
+}
+
+/*
+ * Currently, we have no way to expose the arch-specific default cache model
+ * because the cache model is sometimes related to the CPU model (e.g., i386).
+ *
+ * We can only check the correctness of the cache topology after the arch loads
+ * the user-configured cache model from MachineState and consumes the special
+ * "default" level by replacing it with the specific level.
+ */
+bool machine_check_smp_cache(const MachineState *ms, Error **errp)
+{
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1D,
+                           CACHE_LEVEL_AND_TYPE_L2) ||
+        smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1I,
+                           CACHE_LEVEL_AND_TYPE_L2)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L2 cache topology level shouldn't be lower than L1 cache");
+        return false;
+    }
+
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L2,
+                           CACHE_LEVEL_AND_TYPE_L3)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L3 cache topology level shouldn't be lower than L2 cache");
+        return false;
+    }
+
+    return true;
+}
-- 
2.45.2


