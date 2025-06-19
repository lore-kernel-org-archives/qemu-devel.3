Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F0EC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6n-0005YP-58; Thu, 19 Jun 2025 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6c-0004rp-7y
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6a-000474-J4
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so9424455e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338897; x=1750943697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5LZcCqNpH4GazYoT4HEePjvcf7hcAUKrr97H91/oS0=;
 b=QosOga39clcQoPlNDz92XrkRfYUQXQx8Dcexm3Os4ANQ2W4C43xys7BPlUoW4vuhKB
 vzEpELRDD7ASdj3eG/ntKJ9rjgF4q8nxfN8IZdAiObzE+rqA5apawjgyQTwul7rP6mGr
 Hh/Xsk6lzFEdjap7djOhHAsMUzNu5ZgRakGVdi640o8scxEdlXYzyqROKFsxuJ8czJlA
 cmvN+CLTTUwphHlOcG4xW0PRJSmynedIL3/93+frCco+cUc0lsappsX0agK21FkTOGaz
 76cyF9fIyR1vCoXxOXRE2k3veU3/vms0BHKLSATb1KGcUFeHh5ApnBvyw1GeJlIAUmyR
 c+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338897; x=1750943697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5LZcCqNpH4GazYoT4HEePjvcf7hcAUKrr97H91/oS0=;
 b=eSx1kvdyNp80qvcd/6Fvh61HnTxipUgtqTOym8dVQkbGRhkAf9nwaWGc3Sn8XMT6dq
 UZo93NzMyMvn4QtBcDbdgofuUTPRCIGJ6+XlcJ8vbKVILgE17HFQdeLaceRejrkTBPU4
 rzLpn/Uvf1WSL27K3UnFG70nQsByd1CFLFX/Y+FLsEeUi6FBF/8Lcz0PaS+wJTbq1Qg6
 lyaWFX0kRmHfmcMUkBoyFvtLlyk5JMHZzHyHLcEKRqQM54x9ODEtd/tURXTSkqzlmOlq
 nRdHAil+4NsWfRt2gDb1IaJ+dR82XGnXoGUxw8cgSKZaH3xawBbiDnTRBexOyT5KzgJx
 zing==
X-Gm-Message-State: AOJu0YyUpo3NNokmRfd8q1FolPYl1IRCZhFg5MERN2K4j5LoCSrOppBk
 /8Igypn7nZtQ9K+XY0/5wKB3C0IxZqms7mdM9ya/ioVtgFgWNf1u6R5Kr3rjeMeZWoIUPbUwt0X
 3d4Wa3PA=
X-Gm-Gg: ASbGncsYv9rdnSO0VZUudEZEltMcTIAC4LCnXWKAslXMi95BawcDFyG2EHZdUNMufuv
 IH8bxVR+ljaefJE6FixqssKga92OpWv+btqXwSLIkuRGYKjBMJw8XHTnTxyljaNSsbko7LqciVP
 A6ab9tB4iCRHxqczDNduDChI32JQHWgxvz5gvJ466pZMB+FHuFurZ9xq2G0az+Dgjhla2DZKXtx
 Fy1ikRPSml0ah7J0d7TsAwPPkt5uH8pE03C8a3zY9bS4RIhULfmXJIOa1JYj42KS0ePOcExPzpJ
 O2Ln8G0n/DXsR4MbQWAFwc762iCycZ7uQ/7bgvTp3Ko+pB35/kXO7pyCZ9wttCtFVr35noJgwzf
 ch0bjmcyY1D3b4Z7G5CrUwqWf4rrwp7ihVXIR
X-Google-Smtp-Source: AGHT+IGSPxsi1o1FNjNRdOKa4gLP4CvK5BiNLtp11Lll7xjWxOONtOoutqWpAjesn+xGjJ2lNdFzIQ==
X-Received: by 2002:a05:6000:65b:b0:3a5:88cf:479e with SMTP id
 ffacd0b85a97d-3a588cf4d3cmr9235335f8f.48.1750338897594; 
 Thu, 19 Jun 2025 06:14:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a6078csm19176121f8f.21.2025.06.19.06.14.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 18/20] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
Date: Thu, 19 Jun 2025 15:13:17 +0200
Message-ID: <20250619131319.47301-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
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

QDev uses _post_init() during instance creation, before being
realized. Since here both vCPUs and GIC are REALIZED, rename
as virt_post_cpus_gic_realized() for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a9099570faa..da453768cce 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2032,7 +2032,8 @@ static void finalize_gic_version(VirtMachineState *vms)
  * virt_cpu_post_init() must be called after the CPUs have
  * been realized and the GIC has been created.
  */
-static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
+static void virt_post_cpus_gic_realized(VirtMachineState *vms,
+                                        MemoryRegion *sysmem)
 {
     int max_cpus = MACHINE(vms)->smp.max_cpus;
     bool aarch64, pmu, steal_time;
@@ -2349,7 +2350,7 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms, sysmem);
 
-    virt_cpu_post_init(vms, sysmem);
+    virt_post_cpus_gic_realized(vms, sysmem);
 
     fdt_add_pmu_nodes(vms);
 
-- 
2.49.0


