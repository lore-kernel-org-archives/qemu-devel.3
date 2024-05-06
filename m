Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DEAC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcW-0002S4-Q7; Mon, 06 May 2024 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcN-00029j-KG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcL-00024R-Vo
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41b782405bbso12299285e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999132; x=1715603932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWoGQoSIt5HJcg/7P1ISVDqkVosvqIqVP9M622YHe5M=;
 b=La5yRQyhNUHvqYbzCjBpMDsFjxSRZPmpWiajSsN81nP6qxvifdVoRGcbv6z/sdTVAY
 eGGc+O2eZSgY8jzMkifpRodc0nvVPZPcsMgw4Ec+v4HK0Gt8sijz9YcUQYaZv7f3oDNz
 1qKPxkJXpAPL/6i2g7+kGJ2Ehr1nwuh78EZr4sYfb6tChbaEQTUCeg21Y+kZRDT3ccb5
 36TrFx7ZIx9J2yz8HJQAtWfg9P15Wn5/0g+eqUim4ogysYjVwUwwict4l7SM9Bx84/AJ
 ltXrISwLwGXuEY7CFmsiQim0lNZqb9eSYyjAAQAH/9CMFiUA9yRJ7O4/Opa4QOv8905G
 6IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999132; x=1715603932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWoGQoSIt5HJcg/7P1ISVDqkVosvqIqVP9M622YHe5M=;
 b=Oalgnxa5Mbwb9qRsqWSD0EHQrPhAVonRiReLVsE3CrpGbLtKwTIQYL4HKBDlWVMgo4
 bwLw0bK1dWPFODB8xt9JovZ1pG+V3Hac/MIa6HKpIfs9DKFeR7bGhsPHQXWPm5CNiopH
 uTE+CuCOyPESAZSSGg9i1yRs2ZobfNKJKqE6Vbc3N1sN6G1Z+TnQeHc5WDy4UktXh0wl
 jtMOzyQX0OFpCzJdgB5wimYf2vkIFuTZPgzaFEwSZjRtI3ovE/I8mSMdsadkwGpm10G+
 nlnKemQdpowBZ5tRgVQ87f9WaQvL5sMWtDJgCQOiee2TnDUVT7EMOmIF0G3/ydcl4GMY
 WqUA==
X-Gm-Message-State: AOJu0YwK4PtLWNWcW0aJPPdu0WtfD1sBnKdjSkMvkbK9lAQ5c6IOC3B/
 X8y7DRG7be+88HwCbkZyPEujUpanOqDNtq8d9ecLP2XCQBB+CkLF+2GSb4YxuPGZ8CiEjEc06XD
 i
X-Google-Smtp-Source: AGHT+IEEKxGgR8uzTnXxoiyWNQFOtvMckALTQc8UCk01ccBfQbxWu6YAkx0PcAPukj9m3vdKjolwRw==
X-Received: by 2002:a05:600c:46ce:b0:41b:851a:af43 with SMTP id
 q14-20020a05600c46ce00b0041b851aaf43mr7683963wmo.11.1714999131824; 
 Mon, 06 May 2024 05:38:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 v6-20020a5d6106000000b0034d743eb8dfsm10598284wrt.29.2024.05.06.05.38.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/28] accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
Date: Mon,  6 May 2024 14:37:11 +0200
Message-ID: <20240506123728.65278-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

So far cpu_plugin_mem_cbs_enabled() is only called from
TCG, so reduce it to accel/tcg/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <5f59c754-44e5-4743-a2dd-87ef8e13eadf@linaro.org>
---
 accel/tcg/internal-common.h | 17 +++++++++++++++++
 include/hw/core/cpu.h       | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index ead53cb8a5..cbeff39e3e 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -24,4 +24,21 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !tcg_cflags_has(cs, CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
+/**
+ * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
+ * @cs: CPUState pointer
+ *
+ * The memory callbacks are installed if a plugin has instrumented an
+ * instruction for memory. This can be useful to know if you want to
+ * force a slow path for a series of memory accesses.
+ */
+static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    return !!cpu->plugin_mem_cbs;
+#else
+    return false;
+#endif
+}
+
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 173349b0bd..a001bafcf8 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1111,23 +1111,6 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 #endif
 
-/**
- * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
- * @cs: CPUState pointer
- *
- * The memory callbacks are installed if a plugin has instrumented an
- * instruction for memory. This can be useful to know if you want to
- * force a slow path for a series of memory accesses.
- */
-static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
-{
-#ifdef CONFIG_PLUGIN
-    return !!cpu->plugin_mem_cbs;
-#else
-    return false;
-#endif
-}
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
-- 
2.41.0


