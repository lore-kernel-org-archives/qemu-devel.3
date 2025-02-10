Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC44C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacK-0006kb-Ly; Mon, 10 Feb 2025 15:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacJ-0006hh-3z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:55 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacH-0003du-H9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:54 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dd93a6f0aso1416905f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220171; x=1739824971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOkHWRVq/7AcufWqPBNvF3JtlhqdXf5mWn9gacGGeOo=;
 b=PEEj7ehBujeiGyPeemOIzk8ewxhIXCxQ19hb4W2c/vCsTUO1n41+WGn2Urc8XtqEW4
 PP9LEmdV9XPGEb1T7YInOKItBHgZZxarfatJ/HhOD/D+Yhn1EaO32R0qA8fXkNOJFQ94
 CMFwqVDvnIOGaGl5Zx/TMGToR6Y4q4jwlFr8Vem8EDgaa54K/UaCn69n+kc/XmzQsnRM
 LsJoc9OkleBXDEzJw09Gh/ii7enEI9EzDKk2OxP7SR538xgUWwNuYSnswVH3GOsi6XXA
 pul+IVA60kjjLOxwn6yP4xZM6ooLZyDTyLc5CYf3Bq1FTaDigfEHxmk1dcT8ojCP9BWO
 aMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220171; x=1739824971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOkHWRVq/7AcufWqPBNvF3JtlhqdXf5mWn9gacGGeOo=;
 b=tKzl6uVFalGVK3Nu5/K+LaLCFav9P65z8POorHk1RFFXPEzYs2IQ2FltDQp+hT6dih
 qxu3ne+aV/4lpQK34zAVNW+8qcxRF/pS3vAESiJoKdSF/yz4HHsYmdfdOVPFgVIx429/
 ++fw14nAdP3cFlnlthvNAGY8CAEgT3wy5D2yRtd/mAIl/qRN5sG71Il0FSzuUy47rUkk
 bvFc2Ems5y7o2nbn2WK0mSBEnd3222OO/biEiDN/SI3qLdV7d5/6TYKUNk/GMMHAgnHc
 o/lCbpBfskxVOwKz5tULMECUk/6Ohi8HwvOn6CV8mVChtp4qtSLershAxnJOwJPLRd8n
 7Jwg==
X-Gm-Message-State: AOJu0Yy26JZ4TaV9QXnV4NoJGD9bqEg01sA72y0rEJ5yv8DQuzj1HXZt
 ly8DOT1ROqDuVbyJPuOs7VNFKaUz+xK81UC6V5dxE+Ie6ZSwkut90hveMebOwjghOa2Ilc4+bhP
 Rp9c=
X-Gm-Gg: ASbGnctlevzC6ZWbZ9icugj80PRktq9Aw48JSU1X+GoqUQxYnVpsz1ufqqz3EdPkTrd
 aODh9i3QCAWoDkMheIWTtomKDSBT11cfzeMzLh9XfDS7+6MUQSkmgX6d/hmXLkIVO/1RhFqs2B8
 jR+293wgLUw/5gVoLjLCBV4M9SG8o+BuS1uz5K8XYE1R6jtYRofp0cgqkZ3/o2BOeGKfb/9R0jZ
 +5xufiycY49JRfveEonNwJkYOcZB++WURjlWpIycSbVW1i/9ZiiKf6ml90FzG8PtMn7KgD4w5cE
 uyVtmcxnIvwdiIbKgPmmNSFG3EagYVbfGPp9vNbhrCm/pqjFiuN0O5nAfT5C43bLKg==
X-Google-Smtp-Source: AGHT+IH1pliFBulv3OpDz285krX25B3ucS9m8Fylqwvh7mokOa4sAKjz5nxqJSC4Tl1FO3PuMfL3BA==
X-Received: by 2002:a05:6000:cc:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38dc8decf44mr10619754f8f.21.1739220171604; 
 Mon, 10 Feb 2025 12:42:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd3fc7ee5sm7835378f8f.39.2025.02.10.12.42.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/32] hw/core/machine: Reject thread level cache
Date: Mon, 10 Feb 2025 21:41:41 +0100
Message-ID: <20250210204204.54407-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, neither i386 nor ARM have real hardware support for per-
thread cache, and there is no clear demand for this specific cache
topology.

Additionally, since ARM even can't support this special cache topology
in device tree, it is unnecessary to support it at this moment, even
though per-thread cache might have potential scheduling benefits for
VMs without CPU affinity.

Therefore, disable thread-level cache topology in the general machine
part. At present, i386 has not enabled SMP cache, so disabling the
thread parameter does not pose compatibility issues.

In the future, if there is a clear demand for this feature, the correct
approach would be to add a new control field in MachineClass.smp_props
and enable it only for the machines that require it.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250110145115.1574345-2-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine-smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index b954eb84902..4e020c358b6 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -321,6 +321,13 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
 
+        if (props->topology == CPU_TOPOLOGY_LEVEL_THREAD) {
+            error_setg(errp,
+                       "%s level cache not supported by this machine",
+                       CpuTopologyLevel_str(props->topology));
+            return false;
+        }
+
         if (!machine_check_topo_support(ms, props->topology, errp)) {
             return false;
         }
-- 
2.47.1


