Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B17D68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 20:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PH-0007Z2-CV; Fri, 15 Nov 2024 15:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P9-0007WA-SF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:00 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P8-0004Nk-Gc
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:59 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea304ce809so49816a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704337; x=1732309137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Frvdm/WDiTHhmyZ4u8I9chbK5/V3/lvbxAdiykuEOlI=;
 b=mLZRT+AvDuNcrYjJpudvwvtTpwvlFIcHAZDVrpKUb+7qIjVbOl7JSemLTJOju/P9tN
 zSMj56h4YnOmGcx8HpYh7idJ3rf3fx8KOsVR3SH73Wh5Pgp/lmmQP+2oVM6a5i0z4aH/
 nT5RZAa0IfM4AnVEvJOxIh9j3XdomLaXqYuJFidFgTtNIzXCtyxWsAMyZVnUjGdW8GBW
 ri+hjA86HfGm6Yea3Gk3zLKOnpBzU8fjl1lV8rBBqBrE9iF/HpVMirMX9RJS+8fNfY+n
 DVRQN9PL178WMOXjHgumA22LSxPG/FfY1TAKTPeovFZSp9Xu2xr6FUodGC9jmhxsuG7H
 xb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704337; x=1732309137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Frvdm/WDiTHhmyZ4u8I9chbK5/V3/lvbxAdiykuEOlI=;
 b=dgVSGzpISYWZnI2Npbk9HokIhCOMA0TwipVppkAVrn4amA8BujEisPXFXisEkmm2EZ
 ehTBkrWH/1iplt5st2974fRfMJq05obavAhXUQWKCEqqbX1sNhcsfK2RV4mX4lpq9fqt
 Y0MBxc3N6rP5kL9KFvJnw+GYq0p+FMasp2gJi82launiUA9EI5+Ba+ZZcFGOSlXxq+ex
 lXRYiruM8hzdeBs6gDONMfcyNHFYUsvzf4cLaf8oHMyB/BcFzqMxvGTlU1K5WsCM9VfB
 GsFvD2cJnx5jwfuLvQqKUr5HAEFxdyucrG72Q24r8w8XRCLY7Iz4riIix/NIdLwOm7cH
 3O1A==
X-Gm-Message-State: AOJu0YyjumnoGr7lGMONBx+grUFPF3qqy30J/fI8I3vugUSHaoip2U1l
 wVSSTED6Bo1ua1uSpjbpZ985MGUMlY6SPsGew+Gs0l1gfSPM+4n4OkhN9hayW/GsRPM2P5R8SGw
 Y
X-Google-Smtp-Source: AGHT+IEqp1Lclgwrc244i6QUJND32vQ7ajxzU868H7LQpYhXicxnbxAaNcO/iPK4M+vGtEZTVtrc0A==
X-Received: by 2002:a17:90b:4f4b:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2ea154b5732mr4978132a91.3.1731704337045; 
 Fri, 15 Nov 2024 12:58:57 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/14] cpu: ensure we don't call start_exclusive from cpu_exec
Date: Fri, 15 Nov 2024 12:58:41 -0800
Message-ID: <20241115205849.266094-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241025175857.2554252-3-pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 6b262233a3..0d607bbe49 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -194,6 +194,9 @@ void start_exclusive(void)
     CPUState *other_cpu;
     int running_cpus;
 
+    /* Ensure we are not running, or start_exclusive will be blocked. */
+    g_assert(!current_cpu->running);
+
     if (current_cpu->exclusive_context_count) {
         current_cpu->exclusive_context_count++;
         return;
-- 
2.43.0


