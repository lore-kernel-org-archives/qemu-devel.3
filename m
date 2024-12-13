Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3230BE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB39-0004xI-Rd; Fri, 13 Dec 2024 14:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2P-0003du-OD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:23 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2M-0006fF-G4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:21 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e181fb288so940799a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116956; x=1734721756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqsWYMuz61V4FPOOjOmLye30zpmvR8d0aYJuhAdGM4M=;
 b=kU+5TDMuO4VLB/YUavKKDNtpH/US961bs7fNLlnbq7482yo1NCX6grbZNoNZu5Hteb
 wugRo64oRBrvGFCAbOSbaf8YSLAJ2SrAb+d9sWIafmydsBzD2K2ga8JF+e7+yiqIGNkR
 Y7Wz5HuRE+fYZrlArCJXh3s7rFVV1TUaTZvkKDmA2K9ipk9YOkSzSzr6s2O02trBkjY8
 3i8OQLZozQqOMitqcy0L7pVZAIEttOPjnd+iZdPU+eUM0kmdTvdrun5y+gBGrTk52Ms6
 y5DDmn+mZIrt2EWeHC12ruDl2QSx9YTco9IbZxl3ac9Kz2cAwV8PrJRwT7gQJVk25Jwc
 +jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116956; x=1734721756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqsWYMuz61V4FPOOjOmLye30zpmvR8d0aYJuhAdGM4M=;
 b=vcvoI/bQZ2TI81+p0XF/eZUwKHOn38z2z8WIoC8/TwQdEOtN2+a2u0ReXssCEsdA8n
 o8c1x+KY39Mn4KJ3cOjkF9w4QeOviFOSsGMnzJgcFJ2rszICB0kO60w2EYgg4iVksjQf
 X7QpqAbfW5+luylw8EIFIldwyzGr9jdAiKAYhQdA+5FNmKqcwJC7Mfgb0IM+4WpTIeqP
 VWSR+pCDyzYNf2MoeZysZal/lup2g6QWfND/Zi9pZVfutP9rIHBxsY5gCz88CIHrwG2B
 d75Gtzh1F3P1W5/ru6Zi1VHoZ9mkTw+PjxG1STfQRVKlgAmth29rVH3Vl3otu+1Bw+5x
 YYoQ==
X-Gm-Message-State: AOJu0YyVA/0F7fo+IAAhyBG6KQVjvQwRIaNqf2MgFZ2RB6h3mTVOOcHS
 A/3xh8qwJXQ6H4Orl1Y+/uUNzqAZhS7xa1+BfyJGq16E67LOUNIoJuzqgqsgfa3CO1B62G0ev44
 o7dwUUfnK
X-Gm-Gg: ASbGnctHlAqfFGer0Eoa7DHOknx0Q8WsmxsQQch9SSpRSNWu+kV6HAICGyRJKkDsIam
 ApAULCF9eN1YovemGc36gJyrjWpOHWDC0Y8a3jQ+wST88UwuFlxuny/P1XxEGnP3PY0sHP9tkF5
 LsHDXL8/GPKkVhwFnRsGl/6mY6JKAXCJj9qQzriWsslMA6GCMrbSCcBCAdyqr8aNvSu1sYPxSUT
 gEf5qRC53/eoTyTqtjRCO/wXnu7xGfg2pOUpwxXL+EeiaTavKaY+8NFCYgO15fh
X-Google-Smtp-Source: AGHT+IEkfUD5pXbZeGZ3upc/c4xRkpnTj3yShEzxBn8C+Rvq9IDnNdbtH+lpMgfiUzgvW7rFrt5tmg==
X-Received: by 2002:a05:6830:2713:b0:71d:f562:5f75 with SMTP id
 46e09a7af769-71e3b81133cmr1994979a34.4.1734116955171; 
 Fri, 13 Dec 2024 11:09:15 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:09:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 22/71] hw/cpu: Constify all Property
Date: Fri, 13 Dec 2024 13:06:56 -0600
Message-ID: <20241213190750.2513964-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/cpu/a15mpcore.c       | 2 +-
 hw/cpu/a9mpcore.c        | 2 +-
 hw/cpu/arm11mpcore.c     | 2 +-
 hw/cpu/cluster.c         | 2 +-
 hw/cpu/realview_mpcore.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 967d8d3dd5..5346b8b6c6 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -144,7 +144,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property a15mp_priv_properties[] = {
+static const Property a15mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
     /* The Cortex-A15MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 128+32, which
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index c30ef72c66..c3fdfb92e1 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -158,7 +158,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property a9mp_priv_properties[] = {
+static const Property a9mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
     /* The Cortex-A9MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 64+32, which
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 89c4e35143..193fc182ab 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -131,7 +131,7 @@ static void mpcore_priv_initfn(Object *obj)
     object_initialize_child(obj, "wdtimer", &s->wdtimer, TYPE_ARM_MPTIMER);
 }
 
-static Property mpcore_priv_properties[] = {
+static const Property mpcore_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", ARM11MPCorePriveState, num_cpu, 1),
     /* The ARM11 MPCORE TRM says the on-chip controller may have
      * anything from 0 to 224 external interrupt IRQ lines (with another
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 61289a840d..8e43621b5c 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -25,7 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 
-static Property cpu_cluster_properties[] = {
+static const Property cpu_cluster_properties[] = {
     DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 72c792eef1..9a0ff1df86 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -108,7 +108,7 @@ static void mpcore_rirq_init(Object *obj)
     }
 }
 
-static Property mpcore_rirq_properties[] = {
+static const Property mpcore_rirq_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", mpcore_rirq_state, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


